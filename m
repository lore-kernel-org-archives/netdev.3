Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F6344DB9;
	Tue, 29 Sep 2026 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677302; cv=fail; b=cNaokdfzg2QAHwSFXiZdQy4Kjm0C/4++vcW5J80K2+4CHiUW8ojlvrA9qsOeGWaqjKIBMpXZ3H5kTe3F7mReB1P8qTl/pdxUdsJnEYuwGLw9pQYXIjx/5pMJvsZgSMSbX0enMcGf2yN8UBk6I12aFrW8qBDm0ot+FtDyrnyh8O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677302; c=relaxed/simple;
	bh=L6x8CFeRu4ufyTRyt1yn+oOGRAjLXJU6/0DijyFjpfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=evxbuPy0lGU4R4Aa/ELm9WRuJHDb7/oYpOdfRGxcxUduHY+VRI+a98QZikBdNtMH5fyVplyALya8ztyDsJkbIWUbfzmYWm80s3zKdwouw1DpV0IzvwSt0MiefCsG716r96B9+k8JqmzhfRT/DcBKThtha300qKnE5tSqa2NOWiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=F91RZFZ5; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="F91RZFZ5"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7UNUQ1553359;
	Tue, 29 Sep 2026 06:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iyrp6
	61UyQOaOGDZmY1c+hAcxTi8Ky92ZKGKnKypRSQ=; b=F91RZFZ5SSJe+xyR0wVXc
	zoQ8vviSqNgzsWbGECeNZI3V03HM0t+q5agY1ZEYPW2OHuUv1ygaQ640dCXPz/85
	tdAPpPdSadsGMT5hI6NT30CiiK7rR5plIwjtYEfuzHBC1HWeHKNYCs5Zj+xcIcFy
	J+yvKYipyhdHXJmkWua+FCl/LKIxGSsfZ5nXBp17+lQ+BiDWsu6CETTLYTB4p99F
	yZACra/y8a+eCB0kESVzm4pErk65SOROlkOAbZW0QqGYBiMQ/Y+//BAlcomKpZ4n
	uGouGfV0M+5BuS6NtblDAeTIhnRYMuR2NYytVv0tA0d2FwAtCiyHPgfH0qch/58c
	g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gyy3vbu01-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 06:21:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvSApweDJMuqPB80IDOMRhxnh2Utw8zOGosZo/cZEsDRPfiwqcHVxNO+fRDC7NEyHMkMcKOjcBKZplVpAVTOSlxuKJszKPc8lxRbHq3sJoOgz5YZgK9FulpfMi7/t2Eo7sxbdIjnhbDHYBSKR0fTytX1Bn57ak9HjinNHlw4cNmCou2YJzTbae5eezkembj3t1nn10+HA3e15nxpNM8AoICZDvxZa1d57o/wbCDsxjCqNFP59JGUs2ryTHyAuKHuEeg2c5BjnVBJ97/o9y3IdKiuCT0Fop3HlIPMYAUvBDAKCy1N2SUFaDsnsjfKIQTwzzFKgWgGmbYk91fzh8oSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyrp661UyQOaOGDZmY1c+hAcxTi8Ky92ZKGKnKypRSQ=;
 b=yrLt8UxY+9Eal+6SvGXs9LYJ1W19roJLEbIrnXH5XilbKyRxb93ZOkiVUpyG1jTyAbCSWfmE726X1apUR8gCc1m21tsJLVuUoqkU67AR+VTuS+sQr9/Ote4BhQu5U1EQPh0cOvPR6CMKZszjDYXZtSTDeRFzUt4YWwDG8FN6nPMQKd9SPDlt1i/n6Y4PVXud8lbcNHMCl2mPiNjGkLb6VXPDMsTViNLxPSBmex+qqnOA2p9B0CbZ0IDnkXBPNKN3nnN5LEQP8+cSjn6zNtSdUFuI1qPumS/ZpxP40oJ3aa094QziFmiLnj8r6CODNp7kY39FM2NUH8mM6iPiuziX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by SA6PR03MB7664.namprd03.prod.outlook.com (2603:10b6:806:43d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 10:21:19 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 10:21:19 +0000
Date: Tue, 29 Sep 2026 12:21:14 +0200
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: realtek: add MDI-X support for
 RTL8365MB-VC
Message-ID: <aruQ_q5JfpQum3Ix@analog.com>
References: <20260929092007.1184843-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929092007.1184843-1-o.rempel@pengutronix.de>
X-ClientProxiedBy: AS4P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::19) To DM4PR03MB5981.namprd03.prod.outlook.com
 (2603:10b6:5:388::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|SA6PR03MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: e654bfc8-cf05-4831-f703-08df1e136666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KDcpzLQAPh1Q62GBv6cN64dEYeCD0ZuQ1oi68erA1REGEPoBu7Vv4tYVBKqzS7Bypg1NVY8yFXqmRSuKDvl5vvhk49TSYgkyXLrsS/qFc96o0ar5nwAK7+YPgJqDsvOwW4D0toyrVPog1qfTsxdanSxFCTsAG/H4I5rNUq4oLOPC7PPsKOvmLMi15tZXY6YG8Zj03tIWmfwknPc+Kdy10+hgy64atV4v/s61ctgDqvUCCaF30b0xD7kU12DJCRpxVx4O7qIAMjzVMaPJLVNO+ucT/oMre+200Aw/zFdT22EcfmNDkJBBw98loHSWhkmksNCqgY5NXw/FkJo5jNtv3WhBIBhR9Ck4pvypajh0omeVmMxs8S5B000MbJDMBnMATcy+goBOK+5hhaK/OpUsOlPJzg3T9Ff7AsjQwbFddWqIdb1LuFoHPMWPoYduXTmOcW7CbT2ZSmXEPXqULbJZgSzzxajowm/mtqIiAVwIFxemd4ECZZUmsTfcbMJqskgdS6g2xNCkNT83sxDghDd/q81js0gnWszrAYx8qsbiuQnGrw+K2Tw/Gt4Pga9IsczUkr7s5glf0NeqUZ6PK3faRmorlzihrWOtD6AYbB5rL9VVBtMsdtvk/jJHLdLBKKAQPaNiTghoBdPCPsed+KSl+LyosxsbTZWKmdHpGbKC8+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K21Obmp5UnRRWnNTcDBuV0ROeHdla1Mrc0hscEZwZkd4UlMvWEVzL0ZMTk5x?=
 =?utf-8?B?VnZna1ZtNWNOSitnZHdHc2EwblQyRTljbEtpL1JCbWN0L1dSdk9MZHpkYnQ2?=
 =?utf-8?B?ZEFOM0dEMUx4djF3dmRqOE00MXlqVXo4QnJPcVYzQnA3VE91MFQ5aVJwMUI1?=
 =?utf-8?B?NkZUdTJaK2V1R0djNmw5cU9ubUhTL1lNUWczU1ROUDl3SVg1UFZLZ2hJVmVs?=
 =?utf-8?B?Z1hWZFhYOGFlbE5hN1VpbWd4dkJ1QS8vb1pDWFFnUEwrTGhGOFJEbFNYUFVS?=
 =?utf-8?B?NzV2cmtGbCt5T3RQeDBWSFJ2dERjVVYwcHRndXVGVFJJcTE0aG5PbENYRXdC?=
 =?utf-8?B?RTlOKzN4S0ErdXF2bzAzNE9iNTRaMVh3b3h0K3UwZUJCK0JGaTJEbWF1OTFt?=
 =?utf-8?B?M0w0ZGNKYmdxOXFXcHVOSms0STdheWNnWEZ0cmI4dER4ai84QkFuMXhiYnBh?=
 =?utf-8?B?NUs1eHhpblIwLy93blBGN0c5ZVptRGtsMzh5a1dVOWN6ZTBua3h2aEMvcmh1?=
 =?utf-8?B?bGZ5a1NrUGczTlhGQ1RpbG1mY2FxZ0h5T2JEZTJlS1ZMa3F4M0JLcmN0K3JD?=
 =?utf-8?B?cE9INXhxU2pHdy9YaElkSFNwdHdtaXhBdEpIZGpiMjg0eFkxZ0VxY3VMdCt0?=
 =?utf-8?B?N1czMjFVWVRKcHhMaExlWHM1UU1pdkdEbzBmdXZTeEhUYlJVWWNNVUdUQW1G?=
 =?utf-8?B?YldsQzhaRWJ1VjNQMkttL3pKeWV1TURCZ1hMMG9oWVo2ME5wWHZVbFUwNmtJ?=
 =?utf-8?B?ODNIN3VqN3k2aXhLMlZrWVpDd1h0R3FrUG8zWlBCTGx6ZU9YeEpFVVRYSXZP?=
 =?utf-8?B?RDRiZDdiVysxaXJOTHUrRTBaRTVQNmhOK0JIUnNiVWlBeG5RMVZ5Q1p5QUxF?=
 =?utf-8?B?UGpoYVZkZWErSGw0UjhtZjZHL3d6NE1XRE1salJuUEFIam5yQlRzdkVCQThk?=
 =?utf-8?B?SUV6VElNeFVpQWRzMzRNTXFnNWhHQmswemN5TlF5cTRoVXFPSHJndDFzd3Ar?=
 =?utf-8?B?SU1VdnhkbUpTQ2Z2dW5WWGNPMkVYbjZqekpoR2pjOUd5dm1Zc204RXkxYUxD?=
 =?utf-8?B?OWRvdWRFS1EzODlHU3ZiWXg3dnJSbnhIV1Z0bGNLWUc5MEZYQjZONU5hQXQw?=
 =?utf-8?B?OVptZ2F0UFYxZUo4TXY4N1RmQm9Kd2FsYnNQcjViU1QyN3pTUXhtYkdpVTVF?=
 =?utf-8?B?STAzNVVvY3gzb3pZRGlIeSs4UHlxbXRtUnM3WEhPVHJnUHM5RlNaQWxOdjR3?=
 =?utf-8?B?S2hsWG5JSUVlSFgzVHI5WVFtUXlqWVk2eDV3c0M3dzJUT1RkN2pJR3kxVUxp?=
 =?utf-8?B?QjVpUmVZUW9KQzk4bkkxeEFmSi9QYTBkdXliM2NDUXNCZTBmWXZMemh1UWpI?=
 =?utf-8?B?MEJsVGxRZmRoR25UYlZiTHNabEV4cXliV3dham9uNSt0NjB6UVJaN1Azemht?=
 =?utf-8?B?Y1Boa3NjVndpSmJONVJJMkE1QzdhVzNxMWZmbnkwOU1UcUx1azNFZGU5czlF?=
 =?utf-8?B?MWxNamNlUnc1YzNzMUlvWTJEci9SY2hqUWV6V3lRb0FLNkFZZ2lPT2pIdkZ0?=
 =?utf-8?B?UUFaTU1ld2YrRkxKQS81SEEyUUlJQ2QrWVdxOUZyZVVvWm1wcmVjaElvNWFn?=
 =?utf-8?B?SEkwdEhjZHdPSDY0NURzVVdhd1pwdlhPU0RCWFBoZWdqWjNud2hndlM0aE82?=
 =?utf-8?B?WXZBWGN5eXRYK0M0blZHKzZxUWpXcTV5Z0Z1WFhaZk1DM05ISGdsZWlxSmFV?=
 =?utf-8?B?Vm9IV3ZqTE5HUjh1azBYei9wK2ZsYVdndTZYaFN5UFpZQnV4NVB1QmgyRVdv?=
 =?utf-8?B?Slk0aWN0T1NJbXRScjdLeUdLbjF6T3ZUQkFJSHJOZ1Irbzd6eVh3N2ptWGdH?=
 =?utf-8?B?N3ZPVXJxWVF5NFpEOGZzc05mcTJIb0pIYWlGZFF3OUJ5bS9lYS92V3Z5cUpz?=
 =?utf-8?B?STdrampUVFNBVmw5RkJtenY2Nms4S3RwUGpZc29tSUg0Y29XVGZucmd4cHpo?=
 =?utf-8?B?d1FDVGo1YlVqRXVjbDltYURSdFhpZjNXQ29jTVN4TGJHd1BQd3ZkTUZtblUz?=
 =?utf-8?B?V3JtWGFuN1phdSsyZzlyWXhkVEZldGxVTzkxdTRqNndrQmxLWjBUclF3aWlG?=
 =?utf-8?B?T1VHQnpabnQrMW1NUVM3eTdtZHJ0SWRkNUZLN3dHZUYxMXdKUHRtS1NsK3BT?=
 =?utf-8?B?b05DenlpTysxYks1bE5iWW9zTE1PNW1MTGJMQUd2WTVSTDllRHFmVE9xWDI0?=
 =?utf-8?B?bXJRQVJ2U3VLYVQxc2VTbEVIclMvZE14ekM3ZmRtdUh3Vkp3Y20yKzQ4V2FG?=
 =?utf-8?B?dktRQ0MyQjVYbG5ONzdBbUxVeWlBL2MyMnFBTElLYzhTczF2UUU1QT09?=
X-Exchange-RoutingPolicyChecked:
	EWTFG95BKH0k6+/DtaugVjtcHbegVwnbgJfTACosn1c/K87FfdZJ0dJp/vXS4/mTArdVF4THZPNBCYWMBQPBhKj5jZOVSXBz4ghui2q3Zb92krPXmxIL2mER3O4Rx6PykhPlrdOdOQ+3e1wliWcRwArmideCwUiBJQske66i3AfEF1kmOwCGjzjc+QtxotMVG5DbBy2dk1zj28m/IrMvoWZonJeAsi6HsNGDYjXQo0hxl/TomJQxJ4sb37QXSv/81VOF6MPDd1pwnK+7yVxpVOkdHAGejPzgivpniFu2kFDIQ3ZWo7xafB81ongdJ4x0xhbSuzto7vYpM+tfp2YmiQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e654bfc8-cf05-4831-f703-08df1e136666
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:21:19.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iu6Jx0ice1x2X/Isdtm3PVimAfiHRS2GzvRC47toY7xZ9bcur5B6+iVQ+1BjnceewH4OciOQ+LLtk7lKps4BhzTWv5pRZQ9hnnmkZVhUMMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7664
X-Proofpoint-GUID: GPESzcuNUcd2Foj_5Ru9Sz_crCS68zoh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0MCBTYWx0ZWRfX3KlULhj5oM2P
 Kf+OPpNfc/m+x+tejWn+0JIcmJSIjowUXMIswTCabKENmsqz7HkfAkX4IRZiIx6BeGMsjZc1flA
 MITZtTimJVgfDMQEHTllgPJtO56K6lY4OhguVFPjRbEdsmUPVM62p+9ucBQHPDVg9/UTkhRW+Wk
 ki6mCqKj5Kp2IXkCOM1qYA8O6KTBgIZx8/4rk0O24rzYxsM55AI1H9qj6R4ulOLjnPHC6Dft3Vm
 K823wU56BCptG7rNt5B9FyDx5xZ1QVdMeNxho48OcUnB7XRTCTkWL5jG+BqP++vvLjKR+eFSulK
 m0k8lhK33E66VHCGgnShn8Dm1gWhV0XjfQdc/icU/Ipu4rxmpft/Cl4QwvrArpQUJKfzhnl5wZm
 91ZFl/XhCZFkLbQRkIoDYqP+yidV+jpsGd9UmNzWSfMKTcGYW7zhIDlqgzPZt6W2LYUjNHL3OYC
 IlY6gn6EWEkFhOZsq8g==
X-Authority-Analysis: v=2.4 cv=Y/ltIReN c=1 sm=1 tr=0 ts=6abb9121 cx=c_pps
 a=qCFiEXCgs887QpJba4awmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=R4LS3yDQOdlxsNZJ_bEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0MCBTYWx0ZWRfX4QIylyJwHQyi
 jg5Hkvw4RAxux5eJuvmcQxG62rYiddk7CqrO+tfiyNLbpxIIcL5N3mfVrTETjbb+5JMgpRtA5lH
 Bt2uERE4BZBT1AwnlYoyU/sdeBBKil9sFRZjPOoPO8++cpASFDc/
X-Proofpoint-ORIG-GUID: GPESzcuNUcd2Foj_5Ru9Sz_crCS68zoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290040

On Tue, Sep 29, 2026 at 11:20:07AM +0200, Oleksij Rempel wrote:
> Add MDI-X configuration and status reporting for the RTL8365MB-VC internal
> PHYs. Without a driver hook genphy cannot reach the chip's crossover
> control register, so forcing MDI/MDI-X with "ethtool -s <dev> mdix on|off"
> is a no-op and "ethtool <dev>" cannot report the resolved MDI-X state on
> this PHY.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

> ---
>  drivers/net/phy/realtek/realtek_main.c | 80 ++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 3b3352e2cdc6..e14960192e79 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -239,6 +239,16 @@
>  #define RTL_PHYSR_MASTER			BIT(11)
>  #define RTL_PHYSR_SPEED_MASK			(RTL_PHYSR_SPEEDL | RTL_PHYSR_SPEEDH)
>  
> +/* MDI-X control and status of the RTL8365MB-VC internal PHY. The resolved
> + * MDI-X state is reported in RTL_PHYSR; the configuration lives in a
> + * chip-specific control register. Both are only known to apply to this model.
> + * On this chip a set select/resolved bit means MDI, not MDI-X (measured).
> + */
> +#define RTL8365MB_VC_PHYCR1			0x18
> +#define RTL8365MB_VC_PHYCR1_MDIX_FORCE		BIT(9)
> +#define RTL8365MB_VC_PHYCR1_MDI			BIT(8)
> +#define RTL8365MB_VC_PHYSR_MDI			BIT(1)
> +
>  #define	RTL_MDIO_PCS_EEE_ABLE			0xa5c4
>  #define	RTL_MDIO_AN_EEE_ADV			0xa5d0
>  #define	RTL_MDIO_AN_EEE_LPABLE			0xa5d2
> @@ -3058,6 +3068,74 @@ static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
>  	return IRQ_HANDLED;
>  }
>  
> +static int rtl8365mb_config_mdix(struct phy_device *phydev)
> +{
> +	u16 val;
> +
> +	switch (phydev->mdix_ctrl) {
> +	case ETH_TP_MDI:
> +		val = RTL8365MB_VC_PHYCR1_MDIX_FORCE |
> +		      RTL8365MB_VC_PHYCR1_MDI;
> +		break;
> +	case ETH_TP_MDI_X:
> +		val = RTL8365MB_VC_PHYCR1_MDIX_FORCE;
> +		break;
> +	case ETH_TP_MDI_AUTO:
> +		val = 0;
> +		break;
> +	default:
> +		/* Leave the hardware configuration alone until user space
> +		 * asks for a specific mode.
> +		 */
> +		return 0;
> +	}
> +
> +	return phy_modify_changed(phydev, RTL8365MB_VC_PHYCR1,
> +				  RTL8365MB_VC_PHYCR1_MDIX_FORCE |
> +				  RTL8365MB_VC_PHYCR1_MDI, val);
> +}
> +
> +static int rtl8365mb_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = rtl8365mb_config_mdix(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* The pair assignment is only evaluated while the link is brought up,
> +	 * so renegotiate if the crossover configuration changed.
> +	 */
> +	return __genphy_config_aneg(phydev, ret);
> +}
> +
> +static int rtl8365mb_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = phy_read(phydev, RTL8365MB_VC_PHYCR1);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret & RTL8365MB_VC_PHYCR1_MDIX_FORCE) {
> +		if (ret & RTL8365MB_VC_PHYCR1_MDI)
> +			phydev->mdix_ctrl = ETH_TP_MDI;
> +		else
> +			phydev->mdix_ctrl = ETH_TP_MDI_X;
> +	} else {
> +		phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
> +	}
> +
> +	ret = phy_read(phydev, RTL_PHYSR);
> +	if (ret < 0)
> +		return ret;
> +
> +	phydev->mdix = (ret & RTL8365MB_VC_PHYSR_MDI) ? ETH_TP_MDI :
> +							ETH_TP_MDI_X;
> +
> +	return genphy_read_status(phydev);
> +}
> +
>  static struct phy_driver realtek_drvs[] = {
>  	{
>  		PHY_ID_MATCH_EXACT(0x00008201),
> @@ -3354,6 +3432,8 @@ static struct phy_driver realtek_drvs[] = {
>  		/* Interrupt handling analogous to RTL8366RB */
>  		.config_intr	= genphy_no_config_intr,
>  		.handle_interrupt = genphy_handle_interrupt_no_ack,
> +		.config_aneg	= rtl8365mb_config_aneg,
> +		.read_status	= rtl8365mb_read_status,
>  		.suspend	= genphy_suspend,
>  		.resume		= genphy_resume,
>  	}, {
> -- 
> 2.47.3
> 
