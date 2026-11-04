Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793796336;
	b=Qe+95l1+Kmo/H8yHFEjvd95XFzIOIPRmw7lkvP62PgV8fCFqEDNPHS9RIsH1FQLO4qFW
	 p86RrnSiVd+KrQx6BraOrRQLI9EjymrPN9Q1UdOUqM+YXbZGzanrB4f0p+phiagDGgwxT
	 QYTBUIh6xVx/WEHOYSGoQxkQHHS/Z1Gt6mkPRt2RD1mRms9XklfpxuquyXM4TtwidIz0B
	 utyGO62nMMnhL0dOtk12EJ9dbss6rTqgMaC1oZFDY5gqDP/nHQkuPkBhV6JbjEcKauuyI
	 wvIpC7ml5qwmJ64INCKNpD1jQv+BhnP6TGX1l3aV6Pi0qizJBcMxS5WxFmS/7jPO7Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796336;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eOKbToCJExomWfktswZQ8Tt1QmJoPra2DuhFwVEnMQo=;
	b=c+sl6416bWjKxJpHjvHHCab9XyTv0u2SME/YZ1BhBH+4ucFE6Xgrh4+1s8gv8ukEETvT
	 XOHrgIMKLz7fZZRtg3lyVDQGlpOoTjAW6yBaTzRNsJYNjnduHJzt42itUB2AhleSog6wg
	 8r9xqBrwYqc+KnnnotdooIK6vVCJ4cBHw9Ci5jyfaHsT5LUEziTntoM27lhqh7b/XmH1B
	 tUfnjTtiw1fxV18RUHO7IMdqFhRRgMy6eM5GwZk7o/fwb5gKoICxDTUUx3pqlHK1B1w5X
	 brPGIfMrO2bakTGStbdqVxc1Cp3Y7XLxgnsKAo6vgxRjP8YdkvCZ5XgRWmhYRo6YJEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=moj1cM4E;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QlQEq3hS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BC606A31B;
	Wed,  4 Nov 2026 12:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 567BC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=moj1cM4E;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QlQEq3hS
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bd0RF1972165;
	Wed, 4 Nov 2026 07:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=eOKbToCJExomWfktswZQ8Tt1QmJoP
	ra2DuhFwVEnMQo=; b=moj1cM4EaYUaj5+tfR35BZJXDGTc76hq/McDSjpcst8zK
	MinWeJAEnUNGEJln1MDzbxwy3yfZOyCWKntePcGXDdZDc00BUbOS2/7Q/UaoCYIZ
	dOBDlbr7YjFxBCZerTNQn/KcntuF1Gdm22GQ+PDAyJ+mkhIGDmHiuYq5jjTelQMS
	7GKb7wnvwGlrlp9ziLTbQ4tMLtSay4oBfqzipVo9xkKsOv5mgTJmghKwtFFC6p00
	fpCLu1ce6DWdc63wBpTDU3IgTjSKXT2hWwCEwbPZ8P6MaGQyK5mdfjjvUZrk6hgW
	BHkHQeqoh1SKs5k5sfibtsPy++hKibKdFxQS24R1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=eOKbToCJExomWfktswZQ8Tt1QmJoP
	ra2DuhFwVEnMQo=; b=QlQEq3hSpzWOJXrdXmhJcKCI3s7aPSrDQt76nX767aKyp
	5mzsOZTk/BAHdao9DxPefqOeJaxZPcbH/C28teVR/nHwL/6ul9VdKvsyZg5k85I5
	6Rk40qX2Qt5qL2cmoBq7oNK7U6zyxD7REX+1x7T6mvM/ir9lqesQjMiT3k7X7q2c
	dKZBA+UFzUB9fz8ld6GVoB7yLNI+D/SMSq0dbBEd/n+oyh7OsC5R7Le2yIuWIdqp
	QvMUzQ21V7P715vW+qEkP3a4n1P91fY3EXgyXJnVmuyAxEXpoi6hrHTyA5IivR+f
	K8twtyo4MxJh2Y48pgrGF6pvF9cKTxD1o4CXE+E+A==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqk2pwr9m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 07:45:19 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhezJkUGgqpXAqTiC45S/THPm3X+4Ly1RyJ0MreQDmGW00eQRvp2zfE9bKXibtfLoPiigoZOXf6KmTQmXg07v2imTL3O/Tc1iBXiVX1QxMG+pLPtLoVaiBUjaFkjN2LsXkchzZLwG+wXjogjivdWzvuPPne0rnHCT0BkkRP1iFej5YDLamY9fJ/kaZ6L9zlQcmVVSGrn5sBffbY15gdwS7I8F4GV0K97VDSZSHAylWpGsiNEB2xkmzkT3Rq2g1otJimKIWn7X3WzAwG5Pxy5XYcuQwH7g1jR2/oWBR3FafUWBIYOSPh4BSY6uB7s0EfdLjGhKXceq6m+MYU0NmXejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOKbToCJExomWfktswZQ8Tt1QmJoPra2DuhFwVEnMQo=;
 b=XrgyybOd4EXN94/75miHJheLF/vwym9GDHWewWz88xbNSEeG+7XYdN/baA14FXQ1fK3I0wvK3tfiv111T5yeP6TmdoDZRb1qERn6OVZVB4wezjDCs6HCo6ipS+6gJCL5RaWmivzZuplUayO3QUFkePw3NxNXvQoSR5KuljHX2sMiFPL68OphOJYusH2vQiRwqyzfwGN/H/Dco0jdprUqaPc/+F78EtfojiPh28w7k9fXfELV1tKF7Jd8z0nuNRhv6v7PbLSFINaKxp9zKaZ5UosoxZ2qJtFmJJdQfKHU0t6PzYQrxCWK3pdwyH1KTA0U/hywLUZWKaYvXnaACgRouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by DS7PR03MB8104.namprd03.prod.outlook.com (2603:10b6:8:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 12:45:18 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 12:45:17 +0000
Date: Wed, 4 Nov 2026 13:45:14 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 05/10] net: dsa: realtek: rtl8365mb: set and
 get vlan 4k for family D
Message-ID: <ausoMS5PcpEFz02i@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <1ccb6acc-0809-4abe-8443-576f6727a6d5@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ccb6acc-0809-4abe-8443-576f6727a6d5@yahoo.com>
X-ClientProxiedBy: CPBP307CA0004.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::13) To DM4PR03MB5981.namprd03.prod.outlook.com
 (2603:10b6:5:388::24)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB5981:EE_|DS7PR03MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bff26c-6df7-40d8-df2e-08df3a717abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4MeKrFyi9zw+Qdbk3DZAGldArEq7datf0GnT4DKEDxPCzIiPSOC5KXLYyOLW4zRIMlr+Out7bA+U3vveViz7SDip2ePMcln0Fe5mTckoDve6d3mLRJ33BDtgBVMz/H+AJjI6rrrh8H25lGViDfwiovfyM0WHa+S8OLDi9l5qjbRdVFwoQHO/eiX4OtrtvphaOaW4fbC1HJ07+wfHWldE4/2ghetkPZOCJqNYKPPuNk+rrdc2DB01+geIjMF5CIkL4QChawd7Th91P9fbx9XNcKdBBBf+cc4Fd+x4zPCBgwNIQq7ZJG7GaBNIgVC+1QRQxkZat5xiuwm8kGUQ1ELBlUjAAQ9ojvuPfWiGArGQOl92IAQ83xthq4i3zuWna0NXCS94PDfAjisn9Z8hWW9OcVK2+WRLGToI5b9K2JWd6dnHvWJntoWQs58AJv3jk9foUzvhwmeligSCUyHiAfo3yMJSCplo7SgX+U9qqOnsMM3WUcHHxHJeaJe3GRre5gYjWApXNPT6hrpIkx5+HufOaGRpgFcM5e+H5SDMC3v3tuM9tNVu8Ha/4gac3O+S3tz3/xb84GuRA66/jXutAlrNV8LDpT0LkEqA331E4JWTzLjQTb/IxNGBG9TuVi30k2uxifr1wmtOluiFjBoSH2ILPvqPnCfE8UHyyW7g5Zdmckw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NERKQWhYMy9YbFoyR1Vtd2kydmUwZXIweU5vMGpnMWJvakpRUHBPa0M0NFNj?=
 =?utf-8?B?QW9rM3kxQ3BlenhTUkdtRUxUQXdQcXhvVkhVTndRQVFsTmxWbjRUSy9lcWR3?=
 =?utf-8?B?K1dBWkdhaGRHbEtVQ0c3RHFYN1pBVVlJUmNEWldkT2hlUHZYSHR0eCtCQlhY?=
 =?utf-8?B?MlovNFJvcmx0NFdIYURJMjN2TFM2MHlDajJ5UDIrMmo2SlRRMmhoRXhCdW1Z?=
 =?utf-8?B?WXRNOHNQN3V2dlZGODFLM3REbmlVL01LOTlXeTBTY2Fld2ttQ3BIeW40cHVG?=
 =?utf-8?B?azlCemwxY2hWekh1dFEzcCtrZ0pzWmliUC9ycWtVQzI3VE05SCtxTk4zTVlu?=
 =?utf-8?B?WDBqVDkwUGtQRmNaaDU1STZhVWs0VUlhUUhKVk5ROEdZNy93dHIrS3NzTFRT?=
 =?utf-8?B?ai9MVCtyY0FyWXRqNTRBS2dCcGdIMnowQm51eENrTmRuQXpoVjJWU2dxck05?=
 =?utf-8?B?NmNVck01YXo4aDJWYWtTOVUrZFI3Qm1yZHZBdkZWaWxMNXM5MVl4VjVmN3VN?=
 =?utf-8?B?ZmYveHlRQzZtS21vU3BKVkU0L1NsUHNrUlJMTUdLTDk3eDh2MzkwY3IxV3dt?=
 =?utf-8?B?aE03L2tBYTZYdkJvMDM3SVZpWTlGa3Q0aEpKTlFxQjYva3BBMXJOenBHTDRN?=
 =?utf-8?B?RkRKeVIyU2l1YVN4WDdZYVVwMFhDRUJscWpBREdTQkoveEprd0dmKzM2T3VP?=
 =?utf-8?B?RXl3S2VqcDduNWVUZkYwZGtkQzVsOWNJMmJMZGtHKzcwMU54aGFLVWhidTRZ?=
 =?utf-8?B?QkpPUjFHZTQ1dE1kdTFTYmZhSFdZOSs5WTF3NHJSK0Q3VHZyeG5JMlV6N3d2?=
 =?utf-8?B?QWFkaWdINisvK01oZlNlc2hBc0RkVUswMHF6aTY4aUNxYVdDMUZWRllRdVBP?=
 =?utf-8?B?d1VkUlU2aFZ3cjNtRURtSGVaNWF5OGh4aHhIZm1BdE4yTU9CYno5bjArbFNx?=
 =?utf-8?B?YkpMOEI3cEc0VjRrTUppRFZXUWdXcDJQcDRwUG1ERHkrdzBxTWVNUmp5a2d0?=
 =?utf-8?B?ejFackxSMG5uNWtjNTNGUFZBa2M5Y1VlbWdzaGR6YmRKZFJQcWNZWXFLUmY4?=
 =?utf-8?B?dHhuc1h6ZW9rWGpnZldrd2NVaXNrczNBQ3E5K2lSVXlGM2JXNmVZbERtTkIy?=
 =?utf-8?B?ZjdmSkpyQkhzMUFzZG9Ba3AwWTc1UVhMWTRyWHBuOTZvWFpoTlJVK1pZN3RG?=
 =?utf-8?B?em96MGRERW5hNEUrN2gvSE44L2s1c0I5dXhOQ0tJY1RLTDdRSHhobnRhRWUv?=
 =?utf-8?B?d3ZVRWE5UTVsUjRCNXJ6WWIxZkVNQ2FaRzR2OVk4eGFuK2o2aGRRbk9sb3hk?=
 =?utf-8?B?Sy81VnpzSlErSHd6RGxsczNHVWorNUJ0RU05dm1ETDVGZXhoZnVGMEIzUTZ0?=
 =?utf-8?B?VFlIWDJlSUFHVVNBMysrVGtYcUFzWUdMYTQ2NEpSY2tDaFoxeGFFampMNmFa?=
 =?utf-8?B?dU0wQnJlaTd0dU0wTThhVzNjQjBMZjUrdzFoTC9hSUtaQ3ZEaHpxMUcxL0Z2?=
 =?utf-8?B?L0hCZnVZelNCbC9GZ2I2dHFpYktuUUtnMjI3OHJpYjA1UWQrbkR1OWJYY1V4?=
 =?utf-8?B?KzBnaWxXbzdya2dCcFN0MTA1RmNGR0F2Y21WbThLb2lYeGlFaGJoVHpmWldk?=
 =?utf-8?B?aDdYalk4d214Q1JoZktqTEZReXN3ZTVhVWJZak0rZTFRY2dqUm5BRG9IVEdx?=
 =?utf-8?B?bjNTbHhpSnJBTVZvRWxER3g3WXZwUW9HSHlpMnZTMjJlY01hZkNzWVB2VGxG?=
 =?utf-8?B?UUJXTzl5bXNYeTFydUh6ZU9nZnNwclJxS2UzN2dpSXdSWTlUY002YWEwdWVn?=
 =?utf-8?B?czZRemZsRHBycWhsazc5OG1Xb2tjTVJPdmhHRStqTXd3Q0srSGNHSHIrMkRW?=
 =?utf-8?B?TWJXajJEenpmbGFFNHlUMHJoRVliYXlab1RtTTR4amZFUWphYzFyY1dZL1FQ?=
 =?utf-8?B?YjNCeENUVzJ4d0dpYS92ekQrd2dmVzRIS2VjNjRUSDZuRE9lN0dDZ25IZmd3?=
 =?utf-8?B?UGxsQ1o2Y0J3Zk0xcWNBc2FiN2hoQVptZ3l1blcvQ0lQQk5iYzdob0cyRzhG?=
 =?utf-8?B?dndhREtzaUV3dk1tTVZwSlZUUU5Wb01TQ1FDT05oN1Rtb1RqK0FXeURCemRm?=
 =?utf-8?B?aEx3dzd6L2F4RXFyeGVINkFWamd5UU5HTk0wTURaQm9tZEN5UFpSTitnaDJL?=
 =?utf-8?B?U2t6UDlrNnRPOTJWQUd3V0Z0eEFxc1RCUVAvS3U0TUh3NG9MRnQxck41U0Zy?=
 =?utf-8?B?VUIrWVVsTXkvTjVJVTVkaWhaUU5sVHF1RlRQOGt5ZnY4U29IS25FZ0JISUJw?=
 =?utf-8?B?cUdEbnpjS0JZVTlHUmsxRjBMU0s2WDN6NWV6RkJXNXJYVmhITWh6dz09?=
X-Exchange-RoutingPolicyChecked:
	KRRB9ZqCp9Iu2Ef0zXCWMYjkMqkRhlTSHn7gk6DcVBP45X7Qg9/YP2Xy9t7h6kG0qVjaKzeqIVeOHpVOsHJq99h1Ag5cBYxIZGOjDPqmlv6Ogyo7rbnAb5/2Xla0BHNvRiQqLeKP5k9WXqfFAbEq2PEze/ZLHqo1gEsl+xrki/AorK7O78VHhDQ+iGSQmemzhKjAqIck/QNOTLncBW5bScBqfqCNG1wUxFH3wJS8yheZvJLu0abrH2TRKq+xx2E0hnl0WunM+5cSC2j1pDmtzfvwXBPTXCkQ4QQ3LtIqBMpJe0IFhe+gKyaOVSlgkSDf62KewgVRAhXm+90aczQFxw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bff26c-6df7-40d8-df2e-08df3a717abf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:45:17.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pLXE8JCR8yg1AKV3yIrATggRZk11Kl+74d/Vi7l/O23lgTNONq7phT0/sekkojeYdsyW0BX4UbA2beYIh4FVYHXkFCBFo693GDwqar8ljw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8104
X-Proofpoint-GUID: xw-7Di0fdwgHmKflqhlh_Mhx4YLwVJA7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MCBTYWx0ZWRfX+FzNd1/BFg6P
 Ezapz3+8zxyhVhGmTQEqDSPAsSNd4SUbn9epzwfD9szojl3vU1CLcIHpM8ncA5aXawJHSeoMqZy
 n1D+YCAAkzA9jt0+LdK8VtJtmuR2vvjOlWtHNWJ7BkaTXF2Hc6ZA
X-Authority-Analysis: v=2.4 cv=NPlAaE6g c=1 sm=1 tr=0 ts=6aeb28df cx=c_pps
 a=l4G2nZJL/liaK5VsxlxrQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=CjxXgO3LAAAA:8 a=VwQbUJbxAAAA:8 a=KMFrUNXYu4h0triGs00A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xw-7Di0fdwgHmKflqhlh_Mhx4YLwVJA7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MCBTYWx0ZWRfX/VP4hVwl3TsU
 rLTg87CtLDlPJXVpOx10rOe2ChRl9YLfHYsHWn4xI/Rt3x2Fa4bXqiCLRjIXI+qvBQjpXn5Sa+1
 GIePdAcTBlyWRXUIFq97cXAqZW4Kf+3J1Y4jGSYvwqb5qbsq5L0xMFukEXme2QBJe0DTByH/xaz
 bGsETBDoeHAMP0a4U0yqDeo+poV62SCKkGFIKGXV/p6sSBuxZ/WLa6uMSXC/EXPvASrhoX52bXV
 So8RBbgHil7TSlIEPiZj7r+nBv/HMwdX9W4DOWzHxCQNPw68s3jU3Np9vMj8bmPC0EYA6BlpNRi
 940uUuzxkX4NR4z1ihFtw1TdoaIYilhe6xnUvHMx9MWGtcftyOTe0lxr75S3S/QOCL7cibIO4kt
 JYPSqTdlV0ALCgm68cY6iQwSqezhtyi7uJNbIq54/cSsqFKD+gyM5RBTwyyG+ncsDh4IWkp1sEU
 Q4VzNEt9vpTK5qGCObw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040050

On Mon, Nov 02, 2026 at 03:40:53PM +0100, Mieczyslaw Nalewaj wrote:
> The hardware structure of 4K VLAN table entries has changed between
> silicon families. Family D's CVLAN entry is two 16-bit words rather
> than three: there is no third word extending member/untag past bit 7,
> and no priority/meter fields at all. The FID field is restricted to a
> narrower 2-bit width. The chip itself supports both IVL and SVL.
> IVL_EN (bit 3) follows vlan4k->ivl_en, as on family C; the only caller,
> rtl8365mb_vlan_4k_port_set(), always requests IVL. SVLAN_CHK_IVL_SVL
> (bit 2) is left at 0, as in the vendor RTL8367D CVLAN API, which sets
> it only from the SVLAN member API; this driver has no SVLAN support.
> vlan4k->ivl_en is read back from IVL_EN.
> 
> Reusing the three-word family C layout unconditionally means the third
> word is read from and written back to the register that holds it on
> family C, but does not exist as a distinct table word on family D's
> die; whatever data happens to be there gets folded into member/untag
> bits [10:8] on read, and re-written on every read-modify-write cycle
> in rtl8365mb_vlan_4k_port_set(). Give family D its own two-word
> pack/unpack instead.
> 
> The two-word layout matches the vendor switch API for this chip
> family, which writes only 0x0510/0x0511 for a CVLAN entry.
> 
> The family D paths are not reachable until the RTL8367S-VB chip table
> entry is added in the last patch of the series.
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_vlan.c | 161 ++++++++++++++++-------
>  1 file changed, 111 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> index 8d49ffa..36f0d2a 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> @@ -48,12 +48,16 @@
>  
>  #include "rtl8365mb_vlan.h"
>  #include "rtl8365mb_table.h"
> +#include "rtl8365mb.h"
>  #include <linux/if_bridge.h>
>  #include <linux/lockdep.h>
>  #include <linux/regmap.h>
>  
> -/* CVLAN (i.e. VLAN4k) table entry layout, u16[3] */
> +/* CVLAN (i.e. VLAN4k) table entry layout: u16[3] on family C, u16[2] on
> + * family D
> + */
>  #define RTL8365MB_CVLAN_ENTRY_SIZE			3 /* 48-bits */
> +#define RTL8365MB_D_CVLAN_ENTRY_SIZE			2 /* 32-bits */
>  #define RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK		GENMASK(7, 0)
>  #define   RTL8365MB_CVLAN_MBR_LO_MASK			GENMASK(7, 0)
>  #define RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK		GENMASK(15, 8)
> @@ -65,6 +69,9 @@
>  #define RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK		GENMASK(13, 9)
>  #define   RTL8365MB_CVLAN_METERIDX_LO_MASK		GENMASK(4, 0)
>  #define RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK		GENMASK(14, 14)
> +/* Family D CVLAN entry, word 1 (family D has no word 2) */
> +#define RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK		GENMASK(3, 3)
> +#define RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK		GENMASK(1, 0)
>  /* extends RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK */
>  #define RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK		GENMASK(2, 0)
>  #define   RTL8365MB_CVLAN_MBR_HI_MASK			GENMASK(10, 8)
> @@ -185,13 +192,16 @@ struct rtl8365mb_vlanmc {
>  static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
>  				  struct rtl8365mb_vlan4k *vlan4k)
>  {
> +	bool is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
> +	size_t entry_size = is_d ? RTL8365MB_D_CVLAN_ENTRY_SIZE :
> +				   RTL8365MB_CVLAN_ENTRY_SIZE;
>  	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE];
>  	int val;
>  	int ret;
>  
>  	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_CVLAN,
>  				    RTL8365MB_TABLE_OP_READ, &vid, 0, 0,
> -				    data, ARRAY_SIZE(data));
> +				    data, entry_size);
>  	if (ret)
>  		return ret;
>  
> @@ -199,33 +209,61 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
>  	memset(vlan4k, 0, sizeof(*vlan4k));
>  	vlan4k->vid = vid;
>  
> +	/* member/untag: d0[7:0]/d0[15:8] on both families. Family C
> +	 * extends these into data[2] bits [2:0]/[5:3] for its 9th-11th
> +	 * ports; family D's die has only 8 ports and no third table
> +	 * word, so data[2] does not exist there and must not be read.
> +	 */
>  	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]);
>  	vlan4k->member = FIELD_PREP(RTL8365MB_CVLAN_MBR_LO_MASK, val);
> -	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2]);
> -	vlan4k->member |= FIELD_PREP(RTL8365MB_CVLAN_MBR_HI_MASK, val);
> +	if (!is_d) {
> +		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2]);
> +		vlan4k->member |= FIELD_PREP(RTL8365MB_CVLAN_MBR_HI_MASK, val);
> +	}
>  
>  	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, data[0]);
>  	vlan4k->untag = FIELD_PREP(RTL8365MB_CVLAN_UNTAG_LO_MASK, val);
> -	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK, data[2]);
> -	vlan4k->untag |= FIELD_PREP(RTL8365MB_CVLAN_UNTAG_HI_MASK, val);
> -
> -	vlan4k->fid = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK, data[1]);
> -	vlan4k->priority_en =
> -		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK, data[1]);
> -	vlan4k->priority =
> -		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK, data[1]);
> -	vlan4k->policing_en =
> -		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK, data[1]);
> -
> -	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK, data[1]);
> -	val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_LO_MASK, val);
> -	vlan4k->meteridx = val;
> -	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK, data[2]);
> -	val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_HI_MASK, val);
> -	vlan4k->meteridx |= val;
> -
> -	vlan4k->ivl_en =
> -		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK, data[1]);
> +	if (!is_d) {
> +		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK,
> +				data[2]);
> +		vlan4k->untag |= FIELD_PREP(RTL8365MB_CVLAN_UNTAG_HI_MASK, val);
> +	}
> +
> +	if (is_d) {
> +		vlan4k->fid = FIELD_GET(RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK,
> +					data[1]);
> +		/* Family D has no priority/meter fields in this entry -
> +		 * left zeroed by the memset() above.
> +		 */
> +		vlan4k->ivl_en =
> +			FIELD_GET(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK,
> +				  data[1]);
> +	} else {
> +		vlan4k->fid = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK,
> +					data[1]);
> +		vlan4k->priority_en =
> +			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK,
> +				  data[1]);
> +		vlan4k->priority =
> +			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK,
> +				  data[1]);
> +		vlan4k->policing_en =
> +			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK,
> +				  data[1]);
> +
> +		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK,
> +				data[1]);
> +		val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_LO_MASK, val);
> +		vlan4k->meteridx = val;
> +		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK,
> +				data[2]);
> +		val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_HI_MASK, val);
> +		vlan4k->meteridx |= val;
> +
> +		vlan4k->ivl_en =
> +			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK,
> +				  data[1]);
> +	}

Don't you think it's better to just split out into family C/D variants
for these ops? If you do so, then I think relabelling the old macros for
the C family with RTL8365MB_C_ prefixes will also be appropriate.

[...]

Kind regards,
Alvin
