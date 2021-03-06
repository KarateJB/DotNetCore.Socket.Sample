FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY src/ ./
RUN dotnet restore
WORKDIR "/app/DotNetCore.Socket.Server"
RUN dotnet publish -c Release -o "publish"

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build-env "/app/DotNetCore.Socket.Server/publish" .
EXPOSE 6666
ENTRYPOINT ["dotnet", "DotNetCore.Socket.Server.dll"]