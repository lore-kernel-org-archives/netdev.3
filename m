Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52F2F290B
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184493; cv=fail; b=hM/t2gaLqqxdDmyrrD7BORyn1FCbSak/fs1kscNdmFI/IGlo9mDNrdqp6CGyt9wIk/HVMATz9MnjvGD3Ik6VHbP/czUBtnD1TSsFOMBUZ5nKSLEtlq4juAryREoPWqJZGg6lj6Es2USanZL4sz9FPlvdJoLp9YvCAA2/4xMo1AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184493; c=relaxed/simple;
	bh=hgynV9LPaBTTGk2BNeXMWFgGr1ayZoSmJ00jeWn6jlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5B1WRSyV6N2bWDcSRLogBpuvMD8XwsyqGRmov5oFCrh/5xclQbxCGWYq0+SOY0iQQxCE2NOyvotKE5ssDHgCFdQUTq2pqkOpOjm9d38GOoIoAisG12AdiWjhNqK7f8UCWe6lxO116ppv+ft+JAwa6sODPWH5s5qfMMuIaV12ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RCB/X3c7; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RCB/X3c7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsYFN5rg217kJsm59sSgC8Dv0k1FdoT1Ji+ptDwfBKspQMzVcmiU7ark2+w1aKSfEcx+lPyET8N3eYZuI4PxJ/jB6Up+2JJWmRHp10onkKPkhj5ymW/TJ3BpteIrjBD0riyCcWI4vRCePoPus5Ap7dkqKd5U8WHRTvycLkFqDNQwyHBS6nD/AZuR5sWJyJLWBdfa89udA0XW1xlg9vWa88bfyAgdSZz/MhiqbrLad19oCjS+Vn/eIos8rzTCsJ1ApvOi2wjmv43ktr7fPFvCu5XIF8exqTYVjg45XCqt9GOk58Lyrk9/K7w7284W79o7NvO3mXI7kckVrrDJx4bY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b/6+Bn3K/6gThSCFOBxW7jz7jRTpEYFvhP42lVbMlw=;
 b=o+JMZ5B2NQrMfn+wDIFxcw2aa+iU57UqTTk6aaOcgi0zxUXyKcy/hjf1o1R9+NhTGiybio9dC7f2jPmDwOe2mP42w2zK8PGBHwnkUcTOxjcARS2lJ57bWfT1CB0NPEmodzWdVUdKC9syFt31Lde4JCyGG5fRxz5VFVikj/Wvg5guMULACnz4EsYcnqfN7OLHnEkAgyOUL+MrH3wcy3dw/lJWdq6WwZ2XaT6jcgKeZ8KmDJR5QMvbrlSywuwdU6rOZ5l9IUQ6ymp3blLWcB/4EbX4F0koFpaokTgG9Wlh+FFGRPj9eobvrWjgIAND91GgUrgBr25cMl0u/mAoPzq4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b/6+Bn3K/6gThSCFOBxW7jz7jRTpEYFvhP42lVbMlw=;
 b=RCB/X3c7wK8xa7C+AjKSoX2kNNpXUNKo+vjzhBwymiFqMeu5P+XAPP9z/pI1F6g6WoTsKEbFiP5iOYiOaXOXeDIBiu24uOc/yfg2n8l+rDnm+CuM0/p/xyj4GRj4TAcTAnZb7CQPMwcrELheLp9amp+fIy7P4zIJsgnbqvwZ+eu6ehNQY7HQfWh6JjxLt97zeNn/nSPj6QaMthQKXc4HUtTpXx8IS6FOInQ9k6cwJIO5yYDX98kwJ93Eez/W1B5uJvbbfdCYwbzvUsWMsGqlRPSYC5A6U4ACDEwe6TT0qlj5lpsWRw76zYAj86xOx/aau2D4C99AETwtL2wcROAnOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:48:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 06:48:08 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	danieller@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool 7/8] cmis: Fix printing of attenuation and wavelength
Date: Thu, 16 Jul 2026 09:45:31 +0300
Message-ID: <20260716064532.1522382-8-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716064532.1522382-1-idosch@nvidia.com>
References: <20260716064532.1522382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: 001f07bd-b8f8-4f1d-339a-08dee30631df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|18002099003|22082099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kqBVgrxCg422kVRgUKW4B8n24rmETYNo3X/bxHL400Tm4puyjAPhmulpnnj70AIn/e6El9kSIy6syylSdMkdwpl+nLE2yFNPGjYyMP5Cm7hNBX2WTK/AoxFaBt3Lp9woaxfJcqK9zlv2ZcVjarTg43kaYC8s0WQWor9WyrjjLrSJfG2dif5QiI3n0Fn3KIGMQXyXBwJ+w2Obu0YadGcw9otvcXZWKaYYrbR2oAP9gym7mgjUES0U0jPgePMRxAtHa8XQbBhxCJ8inYIwinDDI4dACNx67ykkLGkJoOM2lHSc+qATCKmcgXLbZ1n0j1ntREaajvhMF6eTQX9/fvQoT4DN4Ktr4/tuVawXFo/gHyuu6Y3ahYDB4usbCQ3XZAJQssDG7qVUS5hqfO3S6GTxUBugBnsnIkmUEqyCXL1+n93VsNEWEneEDty28jaYcR01xjYS7rsI2rqSUnpkzoSy2L4kAW1w5ezZgppvDQkjrU0HkyygmrW6DLa0W/bf67aszsVBEEnWxgQnNwSWHxyRdftJBdg0L+Ez7D3N5DgJm+JhFReb8yjamNWRMjXHUd8S1F0q/GJMz8Y4ywtrAl/so6sIT6oMwu5EYfQO8qhq9I8i7IIiPS7Di0VvwSbNH9jX12qx5M9TER7vUtQyc0dRobeA5pwjPeFNjq2WpCthZ2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BR192NpuZsY0lR5yhwXnhAzQsKiGTFh4DDp7KUbOrfK1HlHrkxOlxlFv0IEq?=
 =?us-ascii?Q?Z5rd6lZrpialN7xVwCFmb2wQRrFwHtyMmtmKoqHjDH3Ql9q2g5aokBg5XX5j?=
 =?us-ascii?Q?LPiLuhXxyxHk73gwtq5/LIPGFOknnLftGQIMrK0Y/kyZSVp7qxpn2gfKJKdb?=
 =?us-ascii?Q?XMr0xubD9RtHI9q/eW3hjiVxgLYRuV0dxE6Eh61EJtf8m+YzXOFRCRlywTS2?=
 =?us-ascii?Q?XpGlmpeXruWDe1Tr1f9keRbdhzo35y2Bg2whbYyUZZfxBWd8SCSXkLSwjz/q?=
 =?us-ascii?Q?bTN4XAceN/ysHMoaAMiroV4jEEsfB6Xp4N/zvfeEUv9/IPHSmVFQy5sWZZei?=
 =?us-ascii?Q?0HvN7gF2x09I/LDozq9r2uZAimMzsUldiIlveRa8zHKHc1jPLf5AK4ocX+7N?=
 =?us-ascii?Q?kwJTJ/WEz5icFFncWpBKmcjKnbwEAxsezrC32m4rDUnrWbLjDKvPw26/Ecim?=
 =?us-ascii?Q?TnLx9PVdH89MaQ6w7FNdvvWOZsT99JdzAZqoVIJOtL+0vnRJufgCvatUfBdm?=
 =?us-ascii?Q?iaJpTrWWC+s6nU6LiAleHmpm/N+GhIPhvYA0KNK5FETWd7K00fss4T8yX1Ht?=
 =?us-ascii?Q?4O5Pg1tlCURNtUEkgofyd+xDRneAwx4+x+ZV61oo2d/O843vXI3jVoMo6488?=
 =?us-ascii?Q?bP2HkqyoVu6XhBqnyEuf6iTv/DKr57vjv8nlpSUqFHvhwDZHXLkEif5rkyCV?=
 =?us-ascii?Q?RbGUZjO5xteb4vdXolBHQf5i+THANu1VN00AftsDy1CejBDtPFi+cLjvM9lm?=
 =?us-ascii?Q?WAKt9/lzhhQyITNnlSqWwdB3a9uJDecpby6O9V/CYm1o6aZSSaofZvAhHlg8?=
 =?us-ascii?Q?79cslmSLVqpjaPz0zRxjlTzaH+sGdRXb3ciV68N6oPW0QzxJCs6LD2M1aV0O?=
 =?us-ascii?Q?WolwsrZjGW50uS3aVjwGOv2TqiwbJiWVLgWx3QE+yWAI+fv99iqC2sPBFdrO?=
 =?us-ascii?Q?Xn7IsarNFZZgabV9hZRJn9v4rDX4og2qXDgdeE+gvULpBSgDjsbP8GDW2Dqz?=
 =?us-ascii?Q?EPsVSk0rAfql7uS1KL0L9NZ+rGlQYn746/CG6nx74dUrMDdHAj7WF/hoQDI/?=
 =?us-ascii?Q?IfO5h1jkZ1groNa+munKhE9r8KFUx7wH28iir2G2QnbHX4FzH5Kvp4CZ7yOu?=
 =?us-ascii?Q?RGzsDpI5+BhB1goMP8dLKtXkwTFLwBWdEF0IF9ylWRPOy2bETq88qXw35yWy?=
 =?us-ascii?Q?KJFlab3BHXqA2czPyH8ueFI8aMHmW4mfEfVjEOmQf7nYj6AcMfAtXa4/rud3?=
 =?us-ascii?Q?zakZx2REelGB8DvpaQszsew7rhwUKsZeI8mIoyFfTSYfN88gTPKC0rebofiN?=
 =?us-ascii?Q?rgKI+nXQihyS5clKATEUxTHRrkn+M0Awxjq+U3QFBwuV24lV8v+c0bD6rwln?=
 =?us-ascii?Q?voVgVaDHhjb78UygYfHlZn4kyr8Ju2Sah0LXteMKo5Qdg6ulUa7kpxrN10TZ?=
 =?us-ascii?Q?TCA1Etl1vffwkQop/uiVcGgRaq/JkBRtw9r6aS7eQNvS56rA82++x+KuE08Q?=
 =?us-ascii?Q?rb9uF/t8pqxwMC5iR4aNkC0JsFOewzm0+pYWzHzdg93NqK6ZEe0cD6iGe2Y/?=
 =?us-ascii?Q?Mco5RHNg+m87Ko9NWn3sepTLf8VoQK8Gy1307suEp5ZNHIxR7Ik0mfgOCHxv?=
 =?us-ascii?Q?+XcSAWwX0z4B82nf7bUE3OWaob4WeDI9uSXwjDJ1TlvFsQQkNTKiAz4MoRA1?=
 =?us-ascii?Q?ze524bXzIamvOXMptesbDduG/znoKcLI2PZz08zo+7r4wiM3xobGc9uf20Ri?=
 =?us-ascii?Q?tCJ65LGscQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001f07bd-b8f8-4f1d-339a-08dee30631df
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:48:08.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2662u4EKi7Oo3aIaiBV8g3PyV3DurEcQrmnagPiP5myO0KqpRSdav2++vCPds9p6jisgKAGsKTu66cGsfnsUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

The CMIS parser uses the same trick as the SFF-8636 parser to identify
copper cables for which attenuation should be printed. That is, it
considers every transmitter technology value above 0x09 as an indication
that it is dealing with a copper cable. This is not true for CMIS
transceivers which support more transmitter technologies compared to
SFF-8636. For example, according to table 8-40 in CMIS 5.3, 0x10 is
"C-band tunable laser".

Fix the identification of copper cables by only matching on the relevant
transmitter technology values. For all the rest, only print the
wavelength if Page 01h is supported and the nominal wavelength is not 0.

Fixes: 88ca347ef35a ("Add QSFP-DD support")
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 cmis.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/cmis.c b/cmis.c
index 19a3eb7cf925..351e18484854 100644
--- a/cmis.c
+++ b/cmis.c
@@ -255,10 +255,20 @@ static void cmis_show_sig_integrity(const struct cmis_memory_map *map)
 static void cmis_show_mit_compliance(const struct cmis_memory_map *map)
 {
 	__u8 value = map->page_00h[CMIS_MEDIA_INTF_TECH_OFFSET];
+	float wl, wl_tol;
 
 	module_show_mit_compliance(value);
 
-	if (value >= MODULE_TT_COPPER_UNEQUAL) {
+	switch (value) {
+	case MODULE_TT_COPPER_UNEQUAL:
+	case MODULE_TT_COPPER_PASS_EQUAL:
+	case MODULE_TT_COPPER_NF_EQUAL:
+	case MODULE_TT_COPPER_F_EQUAL:
+	case MODULE_TT_COPPER_N_EQUAL:
+	case MODULE_TT_COPPER_LINEAR_EQUAL:
+	case MODULE_TT_COPPER_NF_LINEAR:
+	case MODULE_TT_COPPER_F_LINEAR:
+	case MODULE_TT_COPPER_N_LINEAR:
 		module_print_any_uint("Attenuation at 5GHz",
 				      map->page_00h[CMIS_COPPER_ATT_5GHZ], "db");
 		module_print_any_uint("Attenuation at 7GHz",
@@ -269,15 +279,20 @@ static void cmis_show_mit_compliance(const struct cmis_memory_map *map)
 		module_print_any_uint("Attenuation at 25.8GHz",
 				      map->page_00h[CMIS_COPPER_ATT_25P8GHZ],
 				      "db");
-	} else if (map->page_01h) {
-		module_print_any_float("Laser wavelength",
-				       (((map->page_01h[CMIS_NOM_WAVELENGTH_MSB] << 8) |
-				        map->page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05),
-				       "nm");
-		module_print_any_float("Laser wavelength tolerance",
-				       (((map->page_01h[CMIS_WAVELENGTH_TOL_MSB] << 8) |
-				        map->page_01h[CMIS_WAVELENGTH_TOL_LSB]) * 0.005),
+		break;
+	default:
+		if (!map->page_01h)
+			break;
+		wl = ((map->page_01h[CMIS_NOM_WAVELENGTH_MSB] << 8) |
+		      map->page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05;
+		wl_tol = ((map->page_01h[CMIS_WAVELENGTH_TOL_MSB] << 8) |
+			  map->page_01h[CMIS_WAVELENGTH_TOL_LSB]) * 0.005;
+		if (!wl)
+			break;
+		module_print_any_float("Laser wavelength", wl, "nm");
+		module_print_any_float("Laser wavelength tolerance", wl_tol,
 				       "nm");
+		break;
 	}
 }
 
-- 
2.55.0

