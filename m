Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123104;
	b=qTHI3Pfhl4ArWO8SdjtH4fEMdJ3Js652G4ILI05MGJDm6bbwJDhcGmtPVQM/MiWjyPzb
	 8QT6ubFjaf36fQ2TOF6iW5OSZBQzc/PWIEVa+Mg5fA7HgtHRG9YlMSkWdf9vZYBeMzFAm
	 ZJU4GTcyLWBeZIeLN/4BrDV68mNPwHxtVdUmdyqgYJnuN99PaU64iBXuRFtmoCKGjObh9
	 ZDXyWpfd6P4MmknurMJfCRDODpLXYMmwMiP2ywKE6ozOY1FcgeDu2jikDi5EectltoBGl
	 a35B3sBbLNeITPfcQFrZCnkpMldYwjt2X6A+yk3mP/zcJ/B/UNx0wpzlCwIcUf9GIsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123104;
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
	bh=KO3KkTeUAAht2rR2iA4NLaD6mRMCJBFA9vBsn22Q/vM=;
	b=ssJQqhaQsCRFA8kr/fkt7duwhIX2FgFQZnGAAz8tY/ujSvf39M7ZVR4Vle2ysduvRNsZ
	 csyc9T3zPDsF/G1pNaCtHmyLLt5BaL4j/gtNdeheD1kHcUu+vtauMUsw1nzjSfGGsLWhx
	 j/r/8PLDP/MREfVcoQ0JqSn8oK7hxASFyQiRDNzL0EWR1TA749v14n7NLyywdvpZXofmS
	 yEF4u72GdEJsv5M5mgPz9ND4tOuyvY+gWt7qPc2WSS4MRb5bRtgfVP36qW+KJpmQcYVhX
	 PoMLL0zzXr54pI7UnUaOwPkpBLSHgJy1gopDku7i+F1qXMN20zrEIyVLqAnBN7tR4Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=REValbVQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.46
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172F606A322;
	Tue, 27 Oct 2026 17:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D172F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=REValbVQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=di3L5oKR+EpvvOOHIf3Q5tltEEFR8DCCIwDHj1JHwWl7GaKy0attVGuyQswtm5VIEoTqTiw+BV8zUbG5gx9VrGRoTcSTZ3Z2QBKeTXbON4sYAjTfDrAHkzqfwfE8q8rUTtbruxz6I+4qu4gRuBIOovvwngEC6vetrZWu50eqD/FTX4BFNRGZlAiekL9eCf2BXyMsfEhJNhuYpi+bAdW0TRVhwE1yt3M0FzsfJS/OxX9KR1ouNcHCOc0FMeLoMjHyWVKNETYLhdDmb2SFwpSZ6XXSKgra+MB1pAckkgGELC3SffoHN3UDdCQK2wqQL8fLpk/TNDedPwxh+7uo21cJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO3KkTeUAAht2rR2iA4NLaD6mRMCJBFA9vBsn22Q/vM=;
 b=VR5ifXqrpu1iw7qhszN1QJ8lNGa4IyWUM5xs0nW/jiHREEgx0xB5jC4hN2cmWbUzRDOZjGhp8kf24HWyxKzmPGtuntLF7BdiZZ07MThYMDIuNdhr9DTOTwr7n0Fc9RO1oTa4aJiBmz9Sz8DYJ8ff08xCHUXmMNPvFJ01PQBg+Nrdr6poaEB+NJ3EkoYG8JKH4Y88MfE63fYg9kzDKK7me0vsDQ5EiTR+6ybmrs7o2F8cLT/ags0ERSQyqyWjdxXfm9+AQjwiOlvz6FZ9tmxVknsaFjCdyLyprQ03BmTwy1W38ezwCWT8p2IJxDUl8eUFWq7dFC9ypOIA302nKo/fAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO3KkTeUAAht2rR2iA4NLaD6mRMCJBFA9vBsn22Q/vM=;
 b=REValbVQfbtpFRzB9ZX9FUPeY6noHHexM37516wEB/wCaWq25ERJ74ZWPOPlchTsQqmdaj750LNyikah9o/W67PmN3j1QbwwFZxfQVAYIyuBtcVK66W0IgYTrCrreqmMKDznwqWYS6iAiYHuTw9Iho0U5Fxgy/O4tmYkTICplpNSSZ0cMpgporvVP9HsSeXY66crOV+tLmgVce6fvyRLe9di1EMbO9sOj6rDuKPMDLFfOiLX7y0H3c35eykKQ4t7PiZ1GiJttUyC6AgkacZbPqAMYC6qdT3rFVCb54pa9DWFVhRd767u5jOC6RN62qrjAIzBnioicheU1ykg89ppMw==
Received: from CYZPR17CA0018.namprd17.prod.outlook.com (2603:10b6:930:8c::15)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 17:44:49 +0000
Received: from CY5PEPF00000E77.namprd02.prod.outlook.com
 (2603:10b6:930:8c:cafe::a1) by CYZPR17CA0018.outlook.office365.com
 (2603:10b6:930:8c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 17:44:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY5PEPF00000E77.mail.protection.outlook.com (10.167.247.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 17:44:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 10:44:26 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 10:44:24 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <woojung.huh@microchip.com>
CC: <Bryan.Whitehead@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<cbabroski@nvidia.com>, <davem@davemloft.net>, <davthompson@nvidia.com>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v1 3/5] net: lan743x: quiesce TX before freeing the rings
Date: Tue, 27 Oct 2026 13:44:14 -0400
Message-ID: <20261027174414.578524-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <BN7PR11MB2836EB5375FADA5AAB831982E7662@BN7PR11MB2836.namprd11.prod.outlook.com>
References: <BN7PR11MB2836EB5375FADA5AAB831982E7662@BN7PR11MB2836.namprd11.prod.outlook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E77:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f974c4-aca0-48ce-7dea-08df3451ff69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|7416014|82310400026|261022075727099003|261022105027099003|261021123027099003|261009223027099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	NTc/FGRmC69yzwhfIh95MZXdNCOdblp/PPCQc37FXAonk2ga9vxrnkrz5773TqVaeMG8vHrXJ91vz9vmZP/e3aIghRuf5eEYXjOxfdJTSYL4B6/avfwujl5U2aiuRRPTj6ElRh8jwJgNkvH23/++od7CYc89oXd+tVOsVyUzRiHTQCj61SBwGSUBBivEjzWvHdRbhTI/90CbmgZL91n1mCZx9atTxOQDTa9ErZwraxiLBGf5Lhrq2dlN60fh3mgwp/uAdkvM3/DAv/PHQN42fJmBvH/p990egsRySxHs+Kxb8md7/BoGAsfDJP1tkyc/Y0OcHOL6M6UgftjkecGq5OkUlFNlqtgUqxQyZqd7tBQ/k6dNDIjKKdfHhmtAH+54VwbPQB8ZcYM8SanoSBNXj4LTGVGINuxAXsnFRq/Bc27sgwNU7ZYbWps4fawdOiqKBtF2BewTlKGdTqhxR1xswCJmXvZhTkbZRrLtJOiWONo2mME6sfICARZcxgvBReCmvDv5QUGXok9DMHphURnOwg91b0N2YtJpUm62lV7/08CybNnr19sNqLWM2WoyP3SN/zBw5vVnm0eEnbZofTk8VZyIglzHYxfU757n0m/sPwDcuXlTKh/6s5/QynUdUbX5AoiAym9dSzwkKniukAALZWEY3c3fw17uVxwSkjgk7JJbhoSBOhddzT6/JZJUn5VMC7e5bFCvS9Az08zked0RLQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(7416014)(82310400026)(261022075727099003)(261022105027099003)(261021123027099003)(261009223027099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(261026140227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iQAx/gdHa/xttNWhUNacgWjpYp+z31prZYcPh596ICUlrjJgoN/enF2nKQ6VP7ha8orMMVcnMJBrXr9pT8vmx/hhJHHxksdeQN/w0bKw3WfwZa8jTZ90ZOGOo+GW4CcUXxWWihRbetroc0WVUA++MaEmCL5ZBrZtn/6uUDwnD7BGYy4R47CxLGjx7RfO2bHfDKT/wLVkESogtl3LKlT13eGHn9xAFsaYuUv/qWlGmqS1xEnjPd975VHmmkK82WEUjH0GALpJ8Zw52wQqU5pl/3eauuviPR6Y1l8BMfG5cb8kgzcBkB+Uems5WkP6rIzjF3S9z7bJVntxyq5lTNEIlv6JRrqLiiipFenqGCZrzThjc/KSKfSWUuoo/uEKd4GBIG5P2uXGz4WFLpF6ag65ij3SHI1LRJmmnkkA67XyIHPvUzikW29wEmjMZudp0kcw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 17:44:49.0393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f974c4-aca0-48ce-7dea-08df3451ff69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774

Hi Woojung,=0D
=0D
> > @@ -3336,6 +3337,9 @@ static int lan743x_netdev_close(struct net_device=
=0D
> > *netdev)=0D
> > =0D
> >         lan743x_phylink_disconnect(adapter);=0D
> > =0D
> > +       synchronize_net();=0D
> > +       netif_tx_disable(netdev);=0D
> =0D
> synchronize_net() is called inside of lan743x_tx_close() and lan743x_rx_c=
lose()=0D
> via netif_napi_del(). Do you see current order of calling is an issue?=0D
> =0D
> > +=0D
> >         for (index =3D 0; index < adapter->used_tx_channels; index++)=0D
> >                 lan743x_tx_close(&adapter->tx[index]);=0D
=0D
This was a change introduced after AI review flagged a potential race=0D
condition:=0D
1. On CPU A, the TX NAPI poll now checks netif_device_present() and gets=0D
   true.=0D
2. On CPU B, netif_device_detach() runs, then lan743x_netdev_close()=0D
   calls netif_tx_disable() and the queue is stopped.=0D
3. CPU A calls netif_tx_wake_queue() and the queue is running again.=0D
4. The qdisc is still attached in the suspend and reset paths, so the=0D
   stack transmits into the ring while lan743x_tx_close() frees it.=0D
=0D
So the synchronize_net() called via lan743x_tx_close() can't prevent=0D
NAPI poll from waking the queue again.=0D
=0D
The fix is to wait for NAPI poll to complete with synchronize_net()=0D
first to prevent unexpected queue wake before netif_tx_disable() stops=0D
the queue and waits for transmits to complete.=0D
=0D
This is unlikely to happen as part of the TX hang scenario because the=0D
reset in that case comes after TX has stopped. The pre-existing=0D
conditions that could see this would be suspend, reboot, or kexec on a=0D
multi-core system under TX load.=0D
=0D
Given that this is not directly related to TX hang recovery I could=0D
drop it from this patch series if you prefer.=0D
=0D
Thanks,=0D
Chris=0D
