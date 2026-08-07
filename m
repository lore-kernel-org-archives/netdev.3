Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022075.outbound.protection.outlook.com [52.101.43.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842237F8AA
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133875; cv=fail; b=n6qkQRS3/GW7wmNSrZE8Ggbk8BQ3FdmiX2BEVNWvOU1okjOxU1Loqpc3q+v8iJJuOviEMbdL/PXXyP9ZrZjUcLwtUgnw0FXcjnJbJIL3sTJCepdW9uA8bggtmgB7cFojlMCGJYZ7+mx5svfWt853HpJWP9IuYNoW4gq2VbwabVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133875; c=relaxed/simple;
	bh=eMikBftyOBEfSY1P0NxzXL9n18dCh4vQDO5Hb7nXM2o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fUNXr+sjGzWIVSyOQgwbsh6ztVk8lT55su+5kFXag4/QcKZ5X4KmKyFJEajXD4iqx8Gog9YjFl+i5JdwbB25Y38DXCLRQlhHzYOAOwjfQu3S5YjSDPuiNp2yoax62QVNrVkgU1SgzqY82FN4vXzyS+meQte25cVqJ+zUv/66PjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=MDRC6U9u; arc=fail smtp.client-ip=52.101.43.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="MDRC6U9u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqZEHCpeK+RIfY+2Vp3H3vRJq8AeUWdySfD4Z7b/VRNYzaX155/vPQm4zVeXFkUym1qOKIFI2WakZ9PanFAc0r5O9mOCNj05roWT0vJjN/ydMi+JSoUWmI1AlnQfU7GFtZwcQexipbrx5VR55owGBQu4lK9MiFIvxWxpAPaw4VdM69M+NKk3QEefMob4OkYMBdSIR7kwBVw4mNrwQLVkKJL5Ou+tdFVBwlwS+ooUVXz5CozMycdo7+TIx5A73s28/f/+Q4+81PpCRprQ+dQCgXzlTs2FBj11tIxEzpg4jyppHGKG3e5JQd9a5YxN7uzFGETR+5uE6pizYSWJoqD9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYAtBbpGY+VtBlMCyGKdrGWnhREe9fahI80j59dYpcU=;
 b=KrEsfexTkpHD5fAw3DkKf4ABF7M4JEztpU1/ddtP7rSzOcCwT9X1wygo4vVBI1hFYTJ4dHWh56eJwa5R8veJWB27urqfZ1sbvrGJ+UyPswGEBNiD5AUHfz7v9Zr6yhnpbPe1SxbXxElcIJgwB1FyfONSSLQFdRYnwYBhz/5E5XIZ8hhVmGMqsMaz/51wZXLYvjS4rJT4hu8zJU+K4aoFfQ2ldXrwMrVgciiRDHLCwsGMQy0Rf4GvpMhrOp0yXKyWNQ1sYgC2+PpeAKfwyks+C9YJIf1Xv1SLXeb1CFU9Kk7wwJcHxSV3kTFAylFddVASltxw7D1/cPvSPCoAymockg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYAtBbpGY+VtBlMCyGKdrGWnhREe9fahI80j59dYpcU=;
 b=MDRC6U9uTS3QZmc3H+JR6oOqbAorhBwCRHAphnHpwlcCipepWZDGec3lSK+PDh2I3ZpUS9Ln8GVxGgF0t8t7DwIwQZz7sDtBP63CSwdK9LVVg1bv8dP40oty/bwgwL2BGJoEvJKNTQVMqiXDjPnaDayjQNiYacMdhpr8XrpUwMwJMXn4g7Cxqw0BmpIMd6GkVeQsrFv82KdN/4wQdzf8Tzgs/1dUO5cHSt01pxKaqUyr4k8bzYJYBL08HNFGh3P2Ic4ea/gmbndgzBxBY+76IRPnxJ5PNcPg7DiBclAMv2Wwh4yeQy44zVMIgRaiUNvabxyOKQ0tM1ZrwjUggv0S3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 20:17:51 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 20:17:51 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch
Subject: [PATCH net-next v4 0/2] net: macb: 1000BASE-X on internal PCS
Date: Fri,  7 Aug 2026 16:07:45 -0400
Message-ID: <20260807201741.3275-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:b0::15) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: daf4e08e-af1e-4d01-cd8c-08def4c0f4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|786006|23010399003|1800799024|366016|376014|11063799006|56012099006|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	EidwHDmmBJC5y6opoNEFFdTax2UUvxElsGrJI+DFBtzIWM7+pHJu5aceXgmlNoaEXj2DY0k1VsoPMDhjFBa+GuakFY7hRkS/TZEoDfWrGjoIAtaSqn7MoRUM0j82T+ttV9+dt+MOsscJSIGodEu/9+r8Egl6FZ+1jSEt3KOxuOku0YRM5p3wyA2QaxMKtdrC/EEE6Z5yPJhJ/3cQwOrljzxTXtzCAZQNQo8v2a/CCoWBe2fE4WnhgtMijOnDakIHdDPJT/zfobd3pAOek18Qz1HATV7qRx7EO8jdht/9OjO4mdqsY2DFIn6piVTTLd+I+blrC/uzezvBHML5wExlYzcjuMTHjJhj3nUo/t4ZtYfFzrwuWIMD1bARtU6z1AwMS1Us3tGepdbmERN8yRErEikVcIGD2b9d0eGTQHX+cNkyrcmELI2rHJrBU+YR9/Ha5Pjt/Au3I5dmX+gMZMSBJFOcPd+/0yTrNXKLkLkZpnMMIkOM2yHVcCufuk1ERl2/xQop1XXP0it/LUJcTUmifKkZI51xQrF6EZLzphk9b1y2tqkex8XlojbLXEaiuRj/l/q8LWCDOqnTbFfn0GFc2jflWA04u7rtT6wNGDGq0AwCTDusSEAESM90WjMeJeilqIuKdkeIy6cU2aiTO4ZgRhq64iwzxg67RoqZ5ijbS2Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(786006)(23010399003)(1800799024)(366016)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFBNSU9sRyswQlFnalNQWkprcGtZOFNqYlhlamdZbzFhby83cy9JdjlKZkRa?=
 =?utf-8?B?d0hsTkZGOGRRL0syaHBqQWk2cUNBYlBrVHhzU3JQM2VXK1ZTbWZBbnFzNjBX?=
 =?utf-8?B?UTlJczdTR2JtMXB3ZlcvaC9vdEt5NDZ2YnRPWmtXSDh5NFNCdExlMzBJZElv?=
 =?utf-8?B?bTRZekdob05YV1UxVkpZR1VxelIxektTTWxsQVB5bnk4ZTk5ajgwOXFjNit0?=
 =?utf-8?B?VFQ2VFJiWjFSU1BGLy9DeUQzZTdraWdpSGNpVlBDZW5oNUNzaVMxcVdHa1dR?=
 =?utf-8?B?NmRPTUlJMDl6NHZVZ2lWVlVvY2JyTzhxeDkzdVVmcElyUDE4VS9NT3dXeUtJ?=
 =?utf-8?B?Z0h4bVZPeUdNMlhEb1I5dThXdG8walR2NmRrOTg1cHozenI5aHdIYUY3VXUz?=
 =?utf-8?B?dmpML0Z6Y1B5cXhlK0FmZ1hYOVJ0VzhtNDJZdjZMVjMrNVNPTXhYd0tYQmdC?=
 =?utf-8?B?MDFZa0FrZG1TVXZ4Y0dEamw4QVhGcjRXSlloNjYzWVpxV2ZOdkZnaXBXNmZh?=
 =?utf-8?B?ekxsNHZLaXR5V05EaEo1QmNtbE1XRm5uWFFqSnZreDZRZ0twZnlLakFCRHJv?=
 =?utf-8?B?OXB3M0s5ay83c2VTbVhvTnNwOWNxYVVOd0ExR0dpWWUvV2VvN24vTUt5ci90?=
 =?utf-8?B?cjdvYkJBZDlCM014NFBLa2dmL2xjd2FLa0ZYMTZ4UjhMOXNYeENGeUlNN0Vr?=
 =?utf-8?B?TDJrRk9lekFVbkI2bVVyQndlazhzZkZCSUkrQjZnR0FyVm50L2lvUTJ5WjhK?=
 =?utf-8?B?aExHRmY1MU1PeVhrMnNiWUxwUHU0YmFkQ3VLdlFoTStUaVZoY0Q4dk1IMFVs?=
 =?utf-8?B?MWl2ZG9idWVROVVxQ1ZEQjB6ekU3Snh0VUloQ0VlOUgyNE5oWGpCMFFMVjNj?=
 =?utf-8?B?VnJ2STRVTHZZek1NMm1VaDJZTnB1TzZ5N2IvWUUyZ1VlZEFXNzgzNFFUYzRF?=
 =?utf-8?B?Q1BycUdGQ3dNNmZLTDIyWE1hR0xTN0JJVFhzb0dZWWFNeGZRS0lvUXFhU0px?=
 =?utf-8?B?VHIvMDM0TWZEcERVUzN2MnpSdVFQQXgyblgxUUlqNnI3aFpDcU1rQUpYZGxL?=
 =?utf-8?B?OVpzSXUrSC9OU3RtRWdmSUxmbCtmN3NyUmFUeU5jR3k3YjVHK2VmbTFZeEVM?=
 =?utf-8?B?djBIZW5nV0h3Vm1LN0c2bEd2RFNuRDdXRDlsUnIwRFc5VHo1Y1kvNGdyV3Nz?=
 =?utf-8?B?SDllaVBXVEZQYldCYlV2cWo1T0FyVk9YZndHc0pNb05IVngyeUpnV25kb2Jp?=
 =?utf-8?B?anJzTEVXbFRxTXkzRjRSTGNzaWdWQ0g1bmNNM1E3b1JrdC9qKzFEZHQwaklR?=
 =?utf-8?B?czlSTHYrd2tKU0hpZFVpS041c2hkeVRubjF3bUdrWVRicjMxSjk5YXJuSFJ6?=
 =?utf-8?B?QXh4eENDWEZKaHpucm11WVZCWDlXR2Y5TWtkN2xManRISlBVOXAyT2RFeG4w?=
 =?utf-8?B?YTRMQUZmTTdValF1RzZzQzVkSWdBSmhOWlU4L05yQi9XWUU0d3N0TzFYczlV?=
 =?utf-8?B?aGUzL0pPYzRVWTFHUVhTckRKNjhKTUpPNUZQaVlscFhVcmNscmZGUENjc2ly?=
 =?utf-8?B?QXgrQmd0b3pCTjJ0MnUyTU1sakc1VHdCblJ2ajliVEJQYzNqYy9TV1czMEEr?=
 =?utf-8?B?U3hHaWNPcTM3TGozQWRUTzhBbmZhQk5uSUN4aUV2ZDJ1UFlsZG1SSzNGckVm?=
 =?utf-8?B?dWtwUDl5SE9ZUEF0UFBNTDREWERDOVlkdE1wVDVGcUdxNnhWeHNRS3EzSjhq?=
 =?utf-8?B?S09yQmtHczJOQnB1UGp3Tm90eXE1TUxPUnNRTVJ0NUVPalJMaW04bTFSVHYr?=
 =?utf-8?B?SEtlekZOYmpoL0RXUVN1R3NLeVp0N0FWVmJYK0ZBQ1doeUdseFRWWnoydmxN?=
 =?utf-8?B?RjRiTTR6UEQzdUlWNzdUNWVyS0pXMXRsOElBaTJwT1p1Sy9iRzVvUVdDVWZZ?=
 =?utf-8?B?M1h0bm0veXFDQW84WThYNUF3cFE3YkVCbWFZTGkrRFdPaE1mSFRYa1ZuNWtC?=
 =?utf-8?B?Q0R2ampQRlhqWjdLZzk2YWFuK1lvbStnMlJXNFgxdlVyYVdoN2llSXMrN0hN?=
 =?utf-8?B?TUlLMVI1STBGL04zWWx3ZU5EWXhyQTc3bDRwcmoxaWpFMjRkYXdwQ2FGbWdr?=
 =?utf-8?B?T1pMZFgzaEdrY2Z1ZmNORmlWWnZNVFpsRytRU0x4K2hhZ2xtQU9mNWtjUS9Q?=
 =?utf-8?B?QjFKMFN3dkpPaDM1N0JjeGNqcWVTUkdBM2xyS3VxSHNOL09DUm95VVAvdHBq?=
 =?utf-8?B?ZTdpRURKME9QdDRCWEhBNzU1NVJFeVN6aXY5L2g1TTVXQm02SURwZTV2QjVz?=
 =?utf-8?B?S2ZPU1IxOUFEcjNxVm54TCt5UGN3R29vc0Jxbk95UXZSMUh3L2NtQT09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: daf4e08e-af1e-4d01-cd8c-08def4c0f4fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 20:17:51.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI5TvTqK7cCxmN4IMdCJIhPY8NtO33YjNqmclde8sFyQglKbKsbS8UnHTvvAc9Jr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532


This series adds support for 1000BASE-X autonegotiation to the Cadence macb
driver when using the MAC-internal PCS. The existing driver code is oriented
toward the PCS being used with an on-board SGMII PHY, so uses Cisco
SGMII-style autonegotiation exclusively and does not anticipate e.g. link
state changes arising from fiber attach/detach events since the SGMII endpoint
is permanently attached in such cases. The first patch changes the driver
to monitor the PCS's link; the second extends the existing SGMII
autonegotiation code to also support 1000BASE-X autonegotiation.

Changelog:
- v1: Original patch
  Link: https://lore.kernel.org/netdev/20260714200904.70428-1-nwhitehorn@pa.msu.edu/
- v2: Split into two pieces and clean-up of a few details in anrestart().
  Link: https://lore.kernel.org/netdev/20260714200904.70428-1-nwhitehorn@pa.msu.edu/
- v3: Fix mistakes in commit message for patch 1 and improve wording.
  Link: https://lore.kernel.org/netdev/20260729192748.6928-1-nwhitehorn@pa.msu.edu/
- v4: Fix return value in macb_pcs_config() to indicate to phylink when the
  autonegotiation advertisement has changed and autonegotiation needs to be
  restarted.

Tested on Microchip PolarFire SoC with a variety of SFPs (copper, fiber, GPON)
attached to the I/O Bank-5 PCS lines.

Thanks to Charles Perry, Andrew Lunn, Paolo Abeni, and Théo Lebrun for helpful
suggestions and discussion on this patch series.

