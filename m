Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792610672;
	b=QlgOGouW6DPN2851S8OXQSdUcQKWvyHihbWqp9I6rfjsloXpjckXwh69pnNdf+0dJAuI
	 Yel+N5nYsQrKY3H3eTb5G3Db+FfzkAKdqpwmYHteXG1vPJbSn2ARfh2ebUj2JJTFcWgNP
	 bPRSyG13MbqRxMxc+j51iqp0sG3k17eXb6YShnrhHzbeVqU0tzJPJvT/0CTEvsP/vQt8L
	 iDg4skvbkaGxU6HiNIwtnYRvrnoXxP8mr1FylKZ4VMGQacxg8IKafYzcTpQ4O682ctxxP
	 40OmW+sAz2VPgpMEKayxhlSpveU6ymBv6dfjbcasIhkfEWp18ft/+RqAj+v21UVzPZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610672;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eRCLyBt+ysVU8obGg0HYhUc8IZ0B/A88tNWq7dVZWYM=;
	b=s2fvD9hXXx+A9yoiCltY0Q1mJvTV1II/qy+C97JZry5JGdABeM5yRFTN+925btUCh+25
	 K7kFnfaGnYK1EZIHKMgUVfu+fuAbY3klMtvPbbDgVVwlA4dZy1Ns+CuvAg9ZK7JB3pF5b
	 hzOFlDUlKb9WStD1Y5zMYrvsu0mIQMhGqUOKBHsccJ+guj6e/1akdYJnDoAC9ag60fY3O
	 tx6uGvma9NmdYeik66PiXqhaeyMDMtvqxbBnebql6KCP/SpJdtkpXwfJXdt01T7rH69OG
	 xbtzgcjVQn+xKjHAruhRldEYe0+NbPKnEuoINg0oCE3YTzNoRiBz4lB0Pg5Jigzht7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GHt6WCOm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.46
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E94606A319;
	Wed, 21 Oct 2026 19:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E94606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GHt6WCOm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3CTtZrj1ToyY5QbmNEDppUwFB/0cT8wI1B5FUP4jSIlsP8/9EDHaADn7jXGD/CsPLLI39HXNbRkIVxMUxZb5bcGIm0xFlW7Bspz9rWcmlI4wbR55JpSAtZ0vJhYJb5tGo4jgFOuQwh30m2M/7OkTSw0ttIgE41Cb+/muKwgdh59Wc+TJfkBWd2nMXOQBNey50354jCAtLhh/0DVCJlTXpeuXp5J3uZiqofoDn28GL7/IFzBB9pbd87Ss6Kt9pRQ10AIFuiGvDuwJqS9TqDHGuq91M5mfgy+kc7XHuz/VxsxaxIJeHGnZs6Wy2+A5dXycRMb1dZ3yRPilMNAITfcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRCLyBt+ysVU8obGg0HYhUc8IZ0B/A88tNWq7dVZWYM=;
 b=HxaOCTzhc/8rpuAnjxQ+F4948wliLpXT99wBcyu1+6SqcOBAa5Iyf5yeYEWSyHwccd9hjxoWwJLeO8faMnuvPOOqaVhtJQXOkYcwiMRMg5WO8JhOJeDP3aHUDyrGGwT/kGxDxKUCU5+82Y89APt10xPGWPtE4fHjG3l7KCapXe+ZT/k5Qc3f86ZQt6sRjkwBiHhielTxIK05u4fqyi9H+z6gbqDtpn3lLonsXVNwtZD1xNP+uB8WrGkEmbV49VodnmoIPJrevwcDg8fwBE179jtqTujy2eMg9k4xXypA6gFX4VendwBOQ3SDjeRJtCBUJy4XcoiPtm3Y7LhG562QHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=tipi-net.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRCLyBt+ysVU8obGg0HYhUc8IZ0B/A88tNWq7dVZWYM=;
 b=GHt6WCOmJM02OeGB/NcoN6rXH7VjV81NZqsth4IbyzXoSudxg+2a8ucmd1LyWs61IubOqlu0Z39iMRk6e7fHs0AB5N1vtoEhjgS2QznVhIFEe9Pw4227rdJcna5AurlMogUKWOlAbNf8V8uezevmC4JWQSTIwu/6fWod6TvNxbuxDBVgfanuhzjrNXdjUtAQjC1MCf4S/UKXAPTRETGr3VcZAwtbWY/SjhRQgrz8iv8txXrv5glapnMZk9I6LtdGw2CnKrB6RwdKp7MiW5H88FkJ884i84xTR0Y4O/9SwLc/Wt4S6eoq9gG9Tz+vmvXm5fPzf9DqL48ZQw0rHxptAQ==
Received: from CH0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::14)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 21 Oct
 2026 19:24:22 +0000
Received: from CH01EPF000BE94A.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::89) by CH0P220CA0002.outlook.office365.com
 (2603:10b6:610:ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Wed,
 21 Oct 2026 19:24:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94A.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 19:24:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 12:23:56 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 12:23:53 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <nb@tipi-net.de>
CC: <Raju.Lakkaraju@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <bryan.whitehead@microchip.com>,
	<cbabroski@nvidia.com>, <davem@davemloft.net>, <davthompson@nvidia.com>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v1 0/5] net: lan743x: automatically recover from TX hang
Date: Wed, 21 Oct 2026 15:23:41 -0400
Message-ID: <20261021192341.361517-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c0117e4e987c3bd349e56a979cbbdbc5@tipi-net.de>
References: <c0117e4e987c3bd349e56a979cbbdbc5@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94A:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fa6f7f-e4f9-4bd1-bf38-08df2fa8e95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|7416014|261021121427099003|10067099003|261021135927099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FDF4Ovqk5CZZbThLm67+Y5KpgrNsco71hmFH/5kFhN4dHXFgBXpzkSwOF2MyakQQXRgOjHWW/CDH5zKyObmuRLM9Z6I0kTnIHpPfp8cgfGnWUHuiOc5jSZe8dd0sOCj1AA45jmeaFVj9g8UYIGb7vt72rGPDwx0Z9LvMq+uh1G4aeMZa1iHGbUivI1zmo7K666cBt+uCCaU3AJU4xeWIJYA7uZhd1gzqFO/T6pZjB2hjVj7mWttWYCCnO3a9QwjQ7r719ZrTA6xUq7eRDyhIl02fjdD5KGCUG15rdc1vanqx+VLcpJzvjx+DFC7oyl6Ikcwy/PMPpDGKnKbEEwoPoE6bJ0NTES1JFUm3XY1X5pVfuE03D9Votba+hwoL5JH7cQnQIcpUqf9o6jgK4BY/yZovNr6nPA8vIr4k9lkgjlNkCpB6so3Q5KOeTK5zaFGXEGIy/L/UdcN9WZmZRP+9RPm9zIf+N8iiF5WSTs9ky9rWKtKGrul12ZjRIPF5JXWoudhpJBS6jgd28cXQ49NtCH21wTyfsz5m/CqUYOwx7PIPF37CVDu3vPM33Dvyc8j+L7xO0bM/q5MqBcc38cLu1locx3hPXsmX0J6vZ+ygUEsulK1WYIscj+RstQ5dEX7rD2EIA+h5QHeO63oJTtMxzFBYRBGvzw7YZDYANLILxCh11wtdmG/O7wZThTsevLCcwLQY/aP0TgOGLAsD9Gz4ZQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(7416014)(261021121427099003)(10067099003)(261021135927099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OJDyhbZF21Dk83rC/i42pvOH2amyOcaYnJSAC3LtC/O+eSvFzZeVXfHk7SPXgZ9Ta9QO713Nrsa1EM4pAgInAgoiIEGMX3/Ws1lgehylzgtks57nSZH1dn8mUQ13w29lCToLJowUqFp64zEvTymgfXxKJZ/vNufH09E3g7guw3G2oWB7v8q8UwpR6O1G7UZNL7FLjh/iF4LZTDoxj9xHla6Xx4zG6QisQJ7gHiFvZDeD8kc5IdUe7RHm0NYHQHDzIFUj4FhZP0IEvKFQ6gjZXBxpP7aPrYvMM/Ex7yla5tdfYcGlFy32RJYxBtg7DpXErDsf9oS5WHp7Xk/J+sTlGYFRMz5SEUwP0w/pTBoC+0dpNlEPPt7r9tsewKejAysNDsztxTw0EUy2G0f+rdxAgSm55CoadSoVwEBtzzK76BrWkM0Gx6P9aOM1+BDajKao
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 19:24:22.4528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fa6f7f-e4f9-4bd1-bf38-08df2fa8e95c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

>> Is there anything special about the 52 byte usage?
>
> Not that I know of. It looks like the head of a scatter-gather frame
> whose fragments never came in. Does it match the buffer_length of the
> first active descriptor at tx->last_head?

Yes, you're right, tx->last_head is pointing to the header of a TSO
frame and the consistent 52 bytes was just an artifact of the test
data I was using to reproduce this week which creates a 54-byte
header. FCT_TX_USED is 52 bytes, but tx->last_head has a buffer_length
of 54, so not sure where the 2 byte difference comes from. TX_HEAD
stopped at the frame's payload descriptor, after the TSO extension
descriptor.

> Which one? Ours sit behind a Pericom PI7C9X2G404.

Oh, we are also using a Diodes switch, the PI7C9X3G606GP.

>> Recently we found that after every reproduced hang we see that the NIC
>> sent a NAK to the switch, potentially in response to a CplD from switch
>> while reading TX data and descriptors, but I am not yet able to see the
>> rejected TLP or NAK reason with my setup.
>
> Then BadTLP/BadDLLP on the NIC and Rollover/Timeout on the switch port
> should tell what went wrong with the replay. Are those clean too?

Those all appear to be clean too (based on NIC's receive error
counters and firmware AER logging). Occasionally we see replay timer
timeouts reported from the switch on port connected to NIC, but they
occur even without the TX hang and don't always occur when there is a
TX hang.

> My guess: the replay hands the NIC a completion it had already counted,
> and the DMA engine then waits for data that never comes, with nothing
> in the error registers.
>
> Lowering MaxReadReq to 128 bytes with setpci would be a cheap way to
> test that?

Unfortunately, we can still reproduce with MaxReadReq set to 128.
Using the same test as mentioned previously, the FCT_TX_USED now shows
the header plus ~1 KB of payload data instead of 52 bytes.

Thanks,
Chris
