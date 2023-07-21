# FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
# WORKDIR /app
# COPY . ./
# RUN dotnet restore
# RUN dotnet publish -c release -o out

# FROM mcr.microsoft.com/dotnet/aspnet:6.0
# WORKDIR /app
# COPY --from=build /app/out .
# ENTRYPOINT ["dotnet", "Foundation.dll"]
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

COPY \*.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app  
COPY --from=build-env /app/out .

EXPOSE 80

ENTRYPOINT ["dotnet", "Foundation.dll"]