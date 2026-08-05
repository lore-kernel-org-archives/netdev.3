Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D13E5EEB;
	Wed,  5 Aug 2026 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920947; cv=fail; b=seoTNelqB+jLiP8go1mY3vWf+fGFRloE2TiVDsy9HhK3E4ySQVzIwQutJioVyJiqrjzBYxPrkq/D6oJfHopGw49LzIYO+pYdy9s8r96zvz3O9OYF5DFKd0DQsXj4tvxrGxl5acsxFlS2LH2RMYVvf4MImgGrzBsXBlXIueXOTsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920947; c=relaxed/simple;
	bh=XEKcD1nZ2aJ9AlH8EFrjd75IbBs8M9foV7G44m5ZwGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SSXJJJPLQ1ACOXZTmtaGJuLckn7M7quistv40GlIXUuekO9G2lV5/cxt/D0hxmgtFEQYgPw3V2kzm2TxSQdQCbs8V7CNQNR/C5qJv+AST4dHHmrW7gVF9SSx4QGOmfxRLr32BhFVDRwvj7WmHhqGCqF0yvBcv9Tt1d5HZ+lJlbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mtkiFZpV; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mtkiFZpV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/64DeMSJrKLod+6B+b6HjfrfjR6OviPRS0NA0WBPgeaFSo9t3AYHlmCgNeUn0/4C0R3l7xDCrxwILcHOF1QYr/h0sfe+PUFPJ6aF9aafG+1P2mw3ZxFmFWG49iq1d1NxqD9nkGOYU7qYMIouEMIOQkgLDDxNBVmRKYomE3UWMuU2PcZ29LIBN+OGvKkytBA6Geg5Hb1KCJ8D0bHd73bqHu+OJT63LSbmxvpRaBjqwKd7yCL+GAmAY2a+fIJE5iIzPF03sihmbmFiy0dspaRElNhiPMr89eQt/LyWvtx69zEtrAeMNQHMi7t5C70D7M01Ado1vL/pdycIB0XnW21gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g8sS+/aBUT6oMGqQS5vR3tLlajxUeBD03TnKFo2O0M=;
 b=ceVI4XvTJbgBiIU6/ciZV/FqLCIbUfQNfycA3elP3ZCEYaVglJlmvcuzbB3egsEcDhvAWi6yGIKhjSZIJGFMIFOVCDzPWOfBI5XScMyk+MtHeKpqyDmMEi9uuoQ9UA2eeNYynsnIo+h8w9ld6nTsWc1Cxx+rf2vrGaHgQ+4ucnPnaNUEjKsrzsVT8fCniiOU2mr2VdRKJw8xMc/WvoMQ5e5PXrdcB0/0CwI4Dkcabih9DZ+B0lSiVNjBqvcDZHSSGvD5Mgt01lFRvYxOVkHoyBc4VCnsX2lsJUvtJW6QUEoqDdXr2U4pxToshD+eqWRq5/fQreH+J/v4ABpgLLdClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=bootlin.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g8sS+/aBUT6oMGqQS5vR3tLlajxUeBD03TnKFo2O0M=;
 b=mtkiFZpVylweNlWRMYPutSFOHCwj3deNZJdtx+2PJhEVoAQhTLsycPzybhAuLmWQ4KHTU1sCqL7KaSnzN7tOWQDOCVWvIowSjgoT7BJJq1CEBAMO0xFNVlSHNizAmeHVUImI9U62cHH6ITr+xMOgRzdNR8zZuHD60gSCIGqm0a97pLV1Evj0XeoGdkdcEX+ymY8bscLDA9px3M/+GHtkSdkTxj1PMiK59ut7nMoX6iPuYP7X+8XLjMIDfVuPJnSTwhZwFvijULSOCmFeDZjTUTdQrtgdrnsBHoxrB1GLzArvD2n5TobF160G8TPyghL2zccy8D9XQzNexyyfHY+5Fw==
Received: from AS9PR05CA0182.eurprd05.prod.outlook.com (2603:10a6:20b:495::17)
 by DB8PR10MB3164.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 09:09:01 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:495:cafe::f) by AS9PR05CA0182.outlook.office365.com
 (2603:10a6:20b:495::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.20 via Frontend Transport; Wed, 5
 Aug 2026 09:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 09:09:00 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 5 Aug
 2026 11:14:26 +0200
Received: from [10.252.2.248] (10.252.2.248) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 5 Aug
 2026 11:08:59 +0200
Message-ID: <4edb03a2-7ae8-42cd-a389-f0f876a91dac@foss.st.com>
Date: Wed, 5 Aug 2026 11:08:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] net: stmmac: manage error case during
 stmmac_dvr_probe
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>, Russell King
	<rmk+kernel@armlinux.org.uk>, <linusw@kernel.org>,
	<antonio.borneo@foss.st.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260804132052.205273-1-christophe.roullier@foss.st.com>
 <20260804132052.205273-5-christophe.roullier@foss.st.com>
 <807166df-2de0-4176-aad6-6bf632670528@bootlin.com>
Content-Language: fr
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <807166df-2de0-4176-aad6-6bf632670528@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|DB8PR10MB3164:EE_
X-MS-Office365-Filtering-Correlation-Id: b0974eb1-9bc4-409c-ce72-08def2d13083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|23010399003|82310400026|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	o0EXkvll78csj2e5t85S1UUBSrvp9GlW2Zg2Wv5AmCJLQI5l29cYhf/Mw91x2rPDo9fzS486F8H7vpEchIoMl7XsRtsVwn3BKfn7UIBjC2nCzxf4y4GcSDVDEmZ0rUoOFShfbrTJAf/kzdJonjDA2GMirQ1grVIUkx4B51Zxb3QqqNU0jXymej+gjtpBi8Apdpy48Dmw7l3IAvlk/+j+HKPfnGTK5lrTvyoUWwlLVEzffYZXw6TtiLSW+sizUFf1ZiQnnazYWWFUHiZJOuPiQQc3su/gBcZNOy33OfSrNEPjR4lUuuA5QX5gA6tIu40ukz2kIRIZg6M1dfHjMKeg78DOy8ivomaPc1Ff/3pD5Pu3T0VKRpU0ah8LexCVJXP+8Mg+n2p87Orc/24kBI/OayhVJIOzu2t8XSVnGOqhhjJIanDAcan1lq/w/wa9KKOgvoGNa6HpSUD4ko7WQKlI0Lc/1TSF9B/GPS8kWUDsnljDNiyIUQKKgLgkP/K0PegbGY/DQj3YRv91X88vBdR+yOwfCgfWeh1uhXgYEL+LXasIoawT/gbc0Ska2mF+faNnq97SVlX+KRniVEURh/PB467dqqxNrqOO0mSrM9ISkrAPAnPYBtSHMW/AMwGswa2YulKP2F96T51OGISp6b8ppnK7cohvyhQNFyDTP50XDcEvT5iiiuv0em8D1K6KJ4+QY9h3i8l3g+xg7Al17jQvh3Y763gSrrrl01ZE4LyUPaMMKaPW8Y4JIdp9nzW5A/xu
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(23010399003)(82310400026)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9wQ0GPSq7radGcKp5exgXxkGtubwI5wX2oHVfWROiEwXrkD8qErYElvff3akw7CwswR6P2UwXyhDp+4fJXjVRJHfouOmTnOd8F7uq3FfrPZRV69Iv+Gy27RJ07Kqgf6NS/f883bRcdCc1qIelQ0sOsb5bGv+0o0m0tXI5EQdFtkT83wOqHRgh6uCJGG4T1G/DjDnPoypyAGUkRW/0d7UPIEuNk3zrvo9z1qLc+gmXhkbv0oF7DvOj77K6SZBzPVsa6dCj/lIOZi3wcfmgNm49Q5yyelZz4b1gcMu7WocHXMwtriEsdrhFna7BrSQ9KAYomj7idUtjuaQrs52O4ettV4u/BpNFry1F0YUCntSVyVxXqLzOPBmrf7m11N6TYqoX56G3rPSU2fdvBpn6g5vG29W3I8Y7nCrA78b7IiAF8NIP5nnIaBZ4YlAuIrFZ5jb
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:09:00.8323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0974eb1-9bc4-409c-ce72-08def2d13083
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3164


Hi Maxime,

The pb comes from an error during ethernet probe (deferred because 
IOExpander used for Reset Ethernet of STM32MP13-DK is not ready), The pb 
is the Ethernet probe initialize pm-runtime but when error occur and 
exit from probe there is no deinit of pm-runtime so when the reprobe is 
called (after init of IOExpander) pm-runtime is already enable and the 
balance between "put" and "get" is not symetric, so Ethernet genpd is 
always active.

Ok I will remove this commit from my series and repush this commit on 
net-next.

Regards,

Christophe.


Le 04/08/2026 à 16:16, Maxime Chevallier a écrit :
> Hi Christophe,
>
> On 8/4/26 15:20, Christophe Roullier wrote:
>> In case of error during stmmac_mdio_register, pm_runtime is not
>> cleaning before exit probe.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Can you send this path to the proper networking tree ? Is it a bug you've
> encountered in the wild (like, eprobedefer or something ?) or just
> something you've noticed ?
>
> If this is something you encountered, let's send it to -net (and it would
> need a Fixes tag), otherwise just target that to net-next
>
> Thanks :)
>
> Maxime
>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 0de4bc949913..852de0f51c09 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -8062,6 +8062,8 @@ static int __stmmac_dvr_probe(struct device *device,
>>   error_pcs_setup:
>>   	stmmac_mdio_unregister(ndev);
>>   error_mdio_register:
>> +	pm_runtime_put_sync(device);
>> +	pm_runtime_disable(device);
>>   	stmmac_napi_del(ndev);
>>   error_hw_init:
>>   	destroy_workqueue(priv->wq);
