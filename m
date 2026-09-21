Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011025.outbound.protection.outlook.com [52.103.39.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B4238C1A;
	Mon, 21 Sep 2026 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789950062; cv=fail; b=Q21QTQxdlWL9blTZqV6wcsGqUdl161zbFYnTb9OBp1yA4m2JjWaZUJCtKyVmrPBma2aZNMny38lGuZFAqGo5WqQCxpC99Khky6cWeTYtGhrtMEnYnseDEroq/oeH3TPQAGHif9QY5m4tRqRRKoFi2Gp4Y3QFAFOnTkGd6C/TcAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789950062; c=relaxed/simple;
	bh=QVVdlFv7vHKPpiKl9cfFTMjRCdB88XpOE40W17k3Y1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kdVnv3zsOzNrrDAVCIukX8EsU+8jrnibeayxpJfnkg3+NNiT+OnSIQblXDg8mqV7LJYOx9RAYoYQJJqdqgqB7vpi9ZSIcZQB0Lbv3rggGp7QHLx2jkSJ5HYVJ/TeIE0OpmYOiYp3GENS9E9c8c+CXF2yYNgRlqUdiyAuB0+stes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=Y9mqfS/Q; arc=fail smtp.client-ip=52.103.39.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="Y9mqfS/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyI2nv91EKDbT72uBNT8NCHFKijxY80bqUFe9tctyOHNffJ9TcYmEIH/3Zj+E6xwQRtw3jFuz4WXQ9bNJSyJyxTRWswivfo39/b4Igvzrxumco5yWcZm+CugmHG5Susq9vHEm+kFmtR1+rwzVXmy0P4yjtT8O/+986eG8/hjLvj36jwN3613y9/IJwD4HqGFwF1UQI83oFThyfQqKaMzt3sgpYcq001DSqFKRfZKl8DulCIcZf/Z98lOPrWqLvrkKe7nUuV9K+MVDzbJn/K306ZSvtDTZElE/5Vabq1LzINufqLGN2zwqmDGeujmcp7yTFlGEf/sfYQ/0L7G1o9isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVVdlFv7vHKPpiKl9cfFTMjRCdB88XpOE40W17k3Y1Q=;
 b=rrRoby+PMSe+TCyFOZqztlhhjOFhNS1nd7D5LJJyec6yQhCf86r+wWBC0Obpu4voyzw0j60KIcuirYlGkj55yo7Dj9SMB8fwbVdRlRocP+cXfj9QrcMYCAmiPu0G0EINg46vNhGFzlQTW2QUa1ru3jkL1Yqbf4Kc14LcbuIwmN0+sOLSfOQ0DbtPCSchU2gcCxh/0tlLcTGqp8S89vO1TPMARcsZU4I8UmSK53fJ1LPbhc0+m2rrdJRUXmTWeaAuznhvJblLuegho0CeZxNs7kc5FKPJexoBIhUs1UTpJmTxNEqCA8r7hWo8swSTZUVl06sqIFOQeOVmNqCNfJq1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVVdlFv7vHKPpiKl9cfFTMjRCdB88XpOE40W17k3Y1Q=;
 b=Y9mqfS/Q7eg1aHYFQx2z1VWBjn75nOU4cUW8X/aYyYEpnFXBYjAAzNUpqC5ohaXJCASCQVyod3RkdDMoMf61ivS1bEMSgw4TtBqv61faGk/ULmMDU4MhAgpUzd+f2TZFKrbQU4BtdE85C04ISllyZ5ML3hKu12Ap2RnO3y7rPon66NQaf5AsGd+iSjhMzDU/CJQRE4nIsScqmk5ug9HmxgX+K/w0rZhnfmd1VkFcY8LWKQxfwWFXPo2eQJyIYw1iqQJ/E3EdM6vavsBcjpC0GKrPkLyF3N0b0lUeXCHKAj0zSofWsj3m/b+MiogiSdeMds+iYy8ZiCg+qVelzODv6g==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GV2P251MB0971.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 00:20:56 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 00:20:56 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: kuba@kernel.org
Cc: sam@mendozajonas.com,
	fercerpav@gmail.com,
	horms@kernel.org,
	joel@jms.id.au,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: ncsi: validate response packet length before accessing fields
Date: Mon, 21 Sep 2026 01:20:52 +0100
Message-ID:
 <AS8P251MB000149947D9719351F891B19C8842@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260916171722.39e323fb@kernel.org>
References: <20260916171722.39e323fb@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0218.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::7) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260921002052.30445-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GV2P251MB0971:EE_
X-MS-Office365-Filtering-Correlation-Id: b61638b1-0e16-4695-2b5e-08df177633d4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|25031999004|25010399006|23021999003|37011999003|15080799012|5072599009|19110799012|8060799015|51005399006|40105399003|2607281247196008|440099028|3412199025|26104999009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J5si+ED3OMG8dt+6WOyWzX4eti+ciirVKY3Y+emZ2S9stSfgeFPS56nXRBqM?=
 =?us-ascii?Q?nPN5FCS3L16aGh340YkqJ0v/8Nnv6cEiT0cnUFHsIJuCCEdMZgGspVIbR2lM?=
 =?us-ascii?Q?/LZocMJbNacnKAPPrrgmJ0xsPxtutvG2A0dnIKbpUZAPoXq+OEMQcwn9je7N?=
 =?us-ascii?Q?09SSVX1bNZiAFtUEe/bGFKSK3fxkD8TGQLGq6BYOJIIYDRhBTng4nU74vUXE?=
 =?us-ascii?Q?b/j7/a3Dek80qffAYmzzKR+8forSkvcv3YVtQ4r2s7/VvE0YOQ1tDNxLEffL?=
 =?us-ascii?Q?qCnmNUthjE2w9V5y/56OYZIwCvEzMDREwPeWLQXWrWU3Dg4iCsaVqNjTvNVy?=
 =?us-ascii?Q?UE6HWd3Ifo40pTXFdbxaJAddSmGOxumLwvV/SUB1/7wnq2OoFamCbz/6hcs3?=
 =?us-ascii?Q?4T5QzQh4hx0uggMLIN9dHoumoJeUxMM0mIaHu9Tyt61jYxmVoP19AIPheeN8?=
 =?us-ascii?Q?Q07JjhYxyJ2B0nADN+w8ltULa+hIGTgPYuRBwGfbOgz8iauP0k5YGNyL01X8?=
 =?us-ascii?Q?/3NSLZrHfIUGifDR6Ck7tSpiA35Uvq90G6/G3TAqJw0VeJMgZTGG7IlY4dkL?=
 =?us-ascii?Q?iO+yPXCAV1vmF2fQzLEGHiCvQHvoEnMu1DYL/FHd7Fl4WC65L4H3vkTxiORG?=
 =?us-ascii?Q?W98FK+TaZts9AyktuOIHyaxvkPJNq9beLhhthbiZ3c328vznzFNgYoji1GqV?=
 =?us-ascii?Q?w4LBK5XpwGMHhwO/JS2vd+ZX8L6yRzH5cHUi2M6gcYBZt0NPZp9J6fvQ8RV4?=
 =?us-ascii?Q?PoyLJxAtiO7IrSOhwlsQ/uB+iW7o420O9+L+DC25cmIz2UzGqX4sm3um/BGl?=
 =?us-ascii?Q?IW7jUGdqQL8Y7f3gAuNauix+VPdCUN+930xtD486Bm7vzTZspDXVcfafbUBx?=
 =?us-ascii?Q?VFRykBNxkCU3Y0zXHEtQMZp/CL8cMFP0mtLQLPU6h7ebVkn7cCCWW8Er5CzW?=
 =?us-ascii?Q?v5Blz9ZKQ2ChPU4wlayRTxrTuf/cpm428BeQ4BpDaGuUEQu4EDtQBEybAwqB?=
 =?us-ascii?Q?g2fV0zX61HLLf04XefnAA+OkIulkX6xkekf9fVM5Uw+y2hw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y7uTq7gMv0uxeu8fvq/p86XYrleGRrQiMrCJuu7IqHz+3UmKDsPcDpG0TJPr?=
 =?us-ascii?Q?w6/9/dzvZx58QuCOBCRu3GLzAALTjHEo2rLyKM4UrdacnQci5v9gdtbqmYF8?=
 =?us-ascii?Q?3YWl/ejUmB6Abd5SaQkiNOBpAgNkhdXiCnb4eE4MkoVSCQfAafxFFPR482zI?=
 =?us-ascii?Q?ZKjx7sOYrJFyJ3zg8VMwrhfiTbFMWiFJj7t0k16txSE0kqug8SpP9UvF1qWg?=
 =?us-ascii?Q?gv+W90uzxzrND8BUwf8MnDYFAYKS+q2NavSBtck6ye0PJL6+ZI+YNHe8N66A?=
 =?us-ascii?Q?fZvo/16o+4OJBGFJUU2/zJOVvGJIa+3aPY4FdGNSWA9maXwFdmoCNsBVmey3?=
 =?us-ascii?Q?BfMrhq4hbbqt8jdkevUnzyG7ci5xjgh7oUgGRa2+Osid+1kE/PT+YlACSFCN?=
 =?us-ascii?Q?Or8GYrjGNCLHQ/Xr30YSgH/u2RwAMbzSsui1AaQJ+6R0uC/Q1JepeRBofGqL?=
 =?us-ascii?Q?KW6VHSDCGBGm1qOrIJbIOKIDAGWGKJr+egIiwZGsjb/q3w83l5GiF5CiM/LK?=
 =?us-ascii?Q?Q8XV45ykSDuGGY/oDFkejMqKHycDv9Mk4GsmMgsUpUM3U7JbJa3oFStSkfDg?=
 =?us-ascii?Q?NYYQpcMyAbhO09xnaYW9KjpVgodogM5Ew973Kmd9DDPidTToGMXYIGWuDbj/?=
 =?us-ascii?Q?V0gfHyHwFeINE397uRX0Aju6xAQDN470z9DUOR8R+X+rGo2DZ5V3FoaYj3nT?=
 =?us-ascii?Q?x/t78wR68hgJwEtJmsd24PMtk7CBxAL01b0+jyyzk5YycDbkMiiUu4H4BGOq?=
 =?us-ascii?Q?MPJRHTF7r6n/w6Djj3v4HG+p87a2M6T+xG6nvs+M5TuSFXSjmF+B7MZatLeF?=
 =?us-ascii?Q?Q/jF0f7vEi2ANT0XWsuKK3MDMmC11/in2mg5WAgDLYcxNUERLHyDc84sluE5?=
 =?us-ascii?Q?kWp8niqbmka07RG+DT5JFDF1qabv97ZmNzj5t4QrJuPDUd+HNBd1X0YAkDGw?=
 =?us-ascii?Q?18EyL/ehM7thsyNZ+vq4kqAX3f6xqF37xDhfGgm9tCxJo0iTcs9CafSrtakQ?=
 =?us-ascii?Q?AGwimMnNcl6hHdulakONcWzs8WL93RXChCSh7Z2pEn8LZbHQ0PPPrIvyvY2Q?=
 =?us-ascii?Q?bNnA7+COl/0tdwbDNJXNxfC115YaRoMsecQtunNbLHW3r1Q+tRNkrKQ9jolb?=
 =?us-ascii?Q?eoEyoO3DAlgo2LOpssfefdn+4NsqM/COg8urdpjnmoc7wgukbmyZxQSg93hB?=
 =?us-ascii?Q?CBaKi/G+vIYQAqD8Z9l5OKHz+ahOoc7ce05TphDdwQFUzCoYHm35S31xdRMD?=
 =?us-ascii?Q?fcmyYpn+PjztWTTlIHbg3wc1D/Sg+gnMwbqJDabjeXliAwtqatS42I1iyJgw?=
 =?us-ascii?Q?/rACZMuZ0fdCxgYuvUKf31l9kav6GbG3tI59joCnyL+YZ0BWyeSP8dmneHDH?=
 =?us-ascii?Q?5eHEGjTn2CA8abYWzypNI1nEDQk0DDlvVhTyVAO3UGLfU55upYQp2JvlpYN6?=
 =?us-ascii?Q?wjX3pzuJjxSIP3kLeCHLujNhBPcyw7DQ?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b61638b1-0e16-4695-2b5e-08df177633d4
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 00:20:56.6975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P251MB0971

On Wed, 16 Sep 2026 17:17:22 -0700 Jakub Kicinski wrote:
> Patches need to be posted in one thread, which is the default for git
> send-email. Patch 2 should be in reply to patch 1. Please repost.

Thanks for checking. I thought I had done this, seems my email
provider mangled the Message-ID which I passed for the second
patch. Will fix and repost.

Kind Regards

Aamir A.
