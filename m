Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793110533;
	b=PfFouVfSYJA2C4NSYveuFHpVHtirpAGYzQIIT/spzTMQl8Y3YDEkCnohb/XxQHbJp6u9
	 gYhKLylmV43YPi5HYfUEvYXySup/iYebtSqZUeotmVWuYg/ZNNG4bjQweMWgzMeHmuiij
	 if9+cyByVFHDP+XLc1I3xqjfEzklgu2DgmzghOKq1YmbmjiTS7ZaoNiUg9C5tCxzqsOdV
	 06fFgrsv0haZIHJML39BUjabHwWpzSo/Ag+tdiWeJHQweNgX/VcAAHppnuGE81910GPYM
	 CqJVNeGCT//ESrrJnVUwogeGQ1c+yDxBUrb76WocpNHV21cxzWyVKxYtmC+kTIG6DeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110533;
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
	bh=zAF4yjppsEcksE0S0vumadZQ7wNIJkTVNwAk4krC2EY=;
	b=WwARFkFpSQq28ZCxUbHVw4eBLIwLnDLZV92DyjIZwYSfHbTsJB8EDktIeg9uO/vXq1wi
	 CvUoZLw/vPAsFDi20snKInifvKld/oBW8EVDGY8E/98YiofSSqTTs3Qc1Ko32P2dx+GZu
	 1cg0uKq+g6NJcZ3XRv9bDWjWIOoAMzAZaoP3uoHUAhdYkH+xCqm8UZDmuDHGVln1Azrey
	 UhsYLc5OyMUHw5YkFwtF5jFZtTz9wDt420PfMJfE31GmLPVNXCdM7Cco2SpxIc7Hgt/n+
	 EXdDWUSxw42/AuvjetkSbe8Bp1iTEnDCnxOsO82dulj0OAv8xc3Ede+plf9QSjHlZnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Zm6MGQUP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.23
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C4606A31A;
	Tue, 27 Oct 2026 14:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D98C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Zm6MGQUP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuHDWWiMS44me4ukWWgfI6UFT3oS5pKt7nK3vImPMwiSh3KSeZj6MRVZgcjeZKB2jy4zByFwfMIVVAsF+iOgoksv6YpyByd7eopyv3UC4j78V1LG92bLkJiHUe2LieIDUK7r/64oUZVls1/sY5tld/5/HDvxELlW8JlBqPB5DM1PhcYVEd9fekRyngF/R7zPMgrhRW8QBLgwwtZvDRhrmwIXxmxnGVHt79w2vkGrfV9HQcp3fpCXRtoUv+k7dM8mkkUkeiI6bWJDshjrG4vS8lAqAcgowXZOUP4xpAuSOMrArHlTEm1RCy2STSRQJXT028H6Qrfpq+CK3R7ZEdWWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAF4yjppsEcksE0S0vumadZQ7wNIJkTVNwAk4krC2EY=;
 b=lJsQnwVN8DCgJ+aqfgs0W6jEmWfQirE8+1uznrxppSBjHSn5X+CELJLKP+uiHZJDcGrT07yt9ko4Wvyw0IgWBWEAjA3Xku6AGcAzFAcuzrflK0+rYUm7IuYlAf5YHiTwXIpU/RdBYKtRuzCLPCb26tb0lzQoqnDz9dEX8WbjSTAsyo/ARH9/p4+PrB1ZUmqUPTUDv+EvwN5o5/aO1l6UL01syJ+5imzM8+3nuNjn2V8i6H5wkEOSy/OfJZRTTSGEp8hMkQiFE0lMObhyS1iP4Exst0stj7e7HipabAQD/kktcE/BcZADVr0myoVHk+eF9JCEbfmFRIXqj30REUrJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAF4yjppsEcksE0S0vumadZQ7wNIJkTVNwAk4krC2EY=;
 b=Zm6MGQUP7JHgeuClTuySsz+rpCHtccqbyYYATGD6xcEf0s7SyyKKebLQ+fnXCflnmKuY1CjtXFWGeDN31ySQzaxuEAAG8DbnOuFsN95DKITWEt7y7NXuVB7Xc9br3iEEa5Ep0zqzH3iEzFi93WrIrNNZ+efRYsyo7Z92T7BZ4pIPRd+ODnhQtIW9kScYg+Ci1G5RUBISPBit1R35CkanwcLBAdFC2jfoekIdGu8fJ09y0K+0Qrdc48vnffwuqe5PbbWgdiZ2zo2smmjN42YWyB6e+VaBra23ZoM/YWFt9shK7/E60h9Of51XvIQTxqyncqjOROVnv8kAdVHoA164Fw==
Received: from CY5PR19CA0017.namprd19.prod.outlook.com (2603:10b6:930:15::10)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 14:15:24 +0000
Received: from EA8PEPF00000006.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::68) by CY5PR19CA0017.outlook.office365.com
 (2603:10b6:930:15::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 14:15:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 EA8PEPF00000006.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 14:15:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 07:15:07 -0700
Received: from vdi.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 07:15:05 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <woojung.huh@microchip.com>
CC: <Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <cbabroski@nvidia.com>, <davem@davemloft.net>,
	<davthompson@nvidia.com>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <nb@tipi-net.de>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: RE: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that fail to stop
Date: Tue, 27 Oct 2026 10:14:54 -0400
Message-ID: <20261027141454.561978-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <BN7PR11MB2836B99696C08DFEA516C8F6E7652@BN7PR11MB2836.namprd11.prod.outlook.com>
References: <BN7PR11MB2836B99696C08DFEA516C8F6E7652@BN7PR11MB2836.namprd11.prod.outlook.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000006:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8ad6a5-23b9-479c-1177-08df3434bdd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|23010399003|11063799006|56012099006|261009223027099003|261022105027099003|261021135927099003|261021121427099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	To9K1z77D+LM/QCoEVymPAxaZd+Tc/koeOpiq3c7WcNxKzZ1UaELhLQNvaXTHK5EeKfCPwgtXKJYGqTrSAfTgvLC5am0PGHPMd6AqLHUJLqTIA0N9ArqBA62PoWsR0JQWXL8pyrvOOhc4jmLWa7KAqTXJmmbcDkbOO4h9f7iS3LB+aTE2kCSp3baO4brk52XL5VXxm/xZdVxhZx7FyiiiWYz2ru5W0tzs77WZuHvi/oVFvqB/UylwmpTKNruHlp4mrwl1wneNnWujQAtw5PgK52/SYj930cn/ibrnOVNns0hztg/CmsUyDg5dxHoNlgzR+cg3wdq3CpRKuBGlqap5XHm6eDUXwiAyv6ftS+t4NetfvaFuXDTRWdSzPiD5GdnmNE3En+Bhj3Mag/loYZGpAxX8VPVxIv/42BN0fEck9vj/lpBDy35gzUPW67FjY93GcDgZjt89nbvMft9XrTtRck0FU05c3urbs4v8zBbGAZ+Y08mPHRy9hN6+96xC4xAC8473vcfJnJUUd5dA680eur4CbhcQWc2gdoCClHRCVur2tWbqkg6zTDrJCiH7khrdZh2wvCp3SQ111+SrDVouzYQnOnjcbxRqvit3kGIJ39lGjMjyo3LWErGfItndfab2zrcnud+0slDsepIEnsj5NXk3vM/2UcMenwRPvSsW1gh7S7yGch5XWBXN3WuVZUDxkANnfF1Rk6LX4TZIX2m8Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(23010399003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021135927099003)(261021121427099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GCZZrRi/gzh40SkNr+cW0028lcRXr3UOCc4KvJNzg38kVDPQUQ6Dma+LMqdbpBP1Hx7vqcqiYvhVNw6Hro/LY925pyhxWH+gV4CXy1BHgrMVyXicLVt98AT3n88v7LchKI+LGwlFkR+ipTfw6VVh5ViUrF1Ppm9DlpIRq4/36HNuB8F2zVijPU+eZ5SKgl1DJrjRDVW+xaskcBzOxGg9TINnP8uw+Wz+K6EvuakylHeuI3QbtEyjmCZChtE7glfrkcMtEJwfpwvtzvO7JxtQjPtJW7cT1rvoiLNTLSkQALxtnE7jpWh92AbkJDM3cOJAvXPuVyemOlhweRYv1nIFZlLQ/ieTER6ZoDICqOAM2yA8kff0//mGRMt7vHuWHX/3xThBU8ZpoDqG14HMpykZ3grIvtnykKm7tfnEQHkfvOEdK6diS75gjUjc19/dtpyF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:15:23.6736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8ad6a5-23b9-479c-1177-08df3434bdd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000006.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375

Hi Woojung and Nicolai,

> > > @@ -2271,11 +2300,11 @@ static int lan743x_tx_open(struct lan743x_tx
> > > *tx)
> > >                         FCT_TX_CTL_EN_(tx->channel_number));
> > >
> > >       /* reset tx channel */
> > > -     lan743x_csr_write(adapter, DMAC_CMD,
> > > -                       DMAC_CMD_TX_SWR_(tx->channel_number));
> > > -     lan743x_csr_wait_for_bit(adapter, DMAC_CMD,
> > > -                              DMAC_CMD_TX_SWR_(tx->channel_number),
> > > -                              0, 1000, 20000, 100);
> > > +     ret = lan743x_dmac_tx_reset(adapter, tx->channel_number);
> > > +     if (ret)
> > > +             netdev_err(adapter->netdev,
> > > +                        "TX channel %d reset timed out\n",
> > > +                        tx->channel_number);
> > 
> > Not a bug, but what's the benefit of keeping going here?
> > 
> > If the channel never came out of reset, lan743x_tx_open() and
> > lan743x_rx_open() could return the error instead of starting it anyway.
> > 
> > With the reset work from 4/5 a failed reopen then ends in dev_close(),
> > which seems like the better place to end up. It would also settle the
> > open question from the cover letter.
> > 
> Agree with Nicolai's comment that returning error at lan743x_tx/rx_open() to
> make lan743x_netdev_open() returns with error.

Sounds good. I'll update V2 to handle the timeout error by cleaning up
previously initialized steps and then return the error.

One thing worth noting is that every call to lan743x_csr_wait_for_bit()
could technically time out and most cases are unhandled by the driver
today. My goal was to avoid making too many unrelated changes as part of
this patch series, but more error handling could potentially be added as
part of a future series.

Thanks,
Chris
