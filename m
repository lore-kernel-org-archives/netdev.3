Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023141.outbound.protection.outlook.com [40.93.201.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2607046F4B4;
	Tue, 21 Jul 2026 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656414; cv=fail; b=ZsvHlll7YWUFyPQDCkk5H/6SwIb+mT6rcw66V+QAevZm+j7Cez81y8CG30fQEhp7gfBknSlH+6SBX8L7cJ8CpTvPtQz8/KngS8Ru/1R06C0AsB+A2iqYanQaaZ8cXRGXaQZph+K1/HxGVsv8qIvjEriNXsWJP7XT5B13roIEaVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656414; c=relaxed/simple;
	bh=ziOjFz059V4aUTxHeiS6u1qrPZ02xF4av+s5L2h0Tc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ubJfDuEJad+nzegEmrO3iEjTmduKE0YLXe/owOzDpXCKv4QwJ2ko5gSx5ySUYeWAifzxkQ8lSyb+NiJBZWs1INRPTnGJVcvztYWUpRpCQOjwYQP4yynP6g8VPASaNuvybtz5GqIlyV1+4eLxczXgwsinQpB6PtZIB5jUjxzDJnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MWuYOl+J; arc=fail smtp.client-ip=40.93.201.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MWuYOl+J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPP8MJi2lWeV4+dOK+nU89fl2El6fxFrqU7S64aQ7J9NW9sJIehvAmYsokDILQ50hnwWbn7PRKsr6T+QXgRbN4iCRnWqqxr408krsMaCH3nHhSzb6dUz1aq9x+wzpVFIEysPZuyzgmAtFM1j5jLMhVn+waGIMV5PqLGPUWlp1QetGRIxikrxOfHXdo56RJVkLtsWfv8NZ7lMdy/y+yNQSecupx2yokgrhZLNOg37EnginLrOC+KRlhVi4GeaKqzdNfr0udWgSXDyOB6KBn0/a3AHW+bRkKTOcTWRQVvNJBQBYXnQNlo3F+0PGwcvOjlUr944fp22+5tE/ulIJ2GoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLeOTqZJMPH03HcfYOsjHjUa2NwN3sZBEuIbumWem7A=;
 b=cSeYG/NbffDFw5gRnEoc6VpUkoAqbsHbyvpLOotEGOG2ZOEVCsMoA2+m63DIGSQRAlWrJbspNZ872Usp1CC5yP3oVQSIioPhpKvpc5N6GkwkRUiH0v5XAYMhzFpVITBIFGTGagSB2d2Ao5Ldq55BdIb9jDcnKqJKUKGOOIbeOpehWt4Emi1KuNkOm/YMVclGNXo23PxfloTvA1RHbo2UO6lXoPyqZADZP0edSi1XKw4v8C7m/cVzYXWdzio5cgX/3LNNAJHZvbw0k7aaBpTTMUl1mpmg/1AGNJQ4LcKb8MLk9Ng53u6yvFdNkNdNt6XJbMP4+rBGPXIotBSP/FIpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLeOTqZJMPH03HcfYOsjHjUa2NwN3sZBEuIbumWem7A=;
 b=MWuYOl+Jaq+TDxDvJ2/Emo5iewzpjw4czDP1Iyw0xXOKKuNbkMlWwhuB7WSXP6isrwZD4PKDX7AWTtmMslhP6iHYs6FEoHRsh90uTs4PnnQERAENPV4Q3VkYx0UX7ot0G9s/W2OIsA7Afk1xVbbfCmMkrYEVswMVKJnDB0bswGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7425.prod.exchangelabs.com (2603:10b6:510:4b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 17:53:30 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 17:53:29 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v45 7/7] wrap pchan->chan_in_use  in READ/WRITE_ONCE
Date: Tue, 21 Jul 2026 13:52:56 -0400
Message-ID: <20260721175258.87600-8-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR22CA0104.namprd22.prod.outlook.com
 (2603:10b6:930:65::23) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 86be89a9-c865-475c-4234-08dee750f939
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|22082099003|55112099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	3MeTKl5n8XTJ6Uvv/N+vpoKwxcfFbSHnB5sYgMcodVVG9HE0qbrQGgptqaN8PIqrDyMqHNSgp2/gvEoGdfjZHgOzbWEDc77bdmJw1X07iuYF7KcF4bYDfVj8/UhgUTJCrk14yW3ugizKUABoxU3DRD6PhY3ZevSmOG+slqfmFpQ8mDVsVFK3i2Aax94CVZV//uRx7EzmqCnCYppl6bwuXTSXinXP21Q13zNXsyEV9c1jkr8AWnuswFBQtfIzcmidjFTDVTkonf9rTHbVNVIldcXKWjzDRKLlzhYGXvU/cpwpXHE0zWp6bLSG6sAH/mpPRnWg/6P/qOtKtg6QgsW01iJyUrcFTW5GLjdND9pAQx18RlHa9+ZiA8cLO8WlTJkLl7Z/BtlTmO//6M4GnOgODc2RyG4eyLKZcZVUWuAXwHoVN6EE1Infek9pATTWmsFzXWOwdQ0se2yxrLHP300apHWkg1QkecR44SOIWxGRDxNlvLSr7DuWIBfym/LUzgj45EvY+gpiGI47ddEYG3lSHkRrr2Jol+i28fXuuQB/mQXjkSEBxMHxPiwq+wVEnQ/s2yHilrHV805lw7oTwxLA/e+TVVHdE3fYQ5qsxY8QvCnlXM/QCeAEm9cvt6INTMSucsFi3+Cdd5iVdntl8q2zl83QmsUfNCHtdjFhRGMh/Rc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(22082099003)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bj4Vgyji7pk02n9yRiFNC/cgnTQULkGx97f33PZ7NSZqqf6jacIVyMFTWOPe?=
 =?us-ascii?Q?/37nXyJOdkgDyixIxBGC3BpFuDg6tOnqKxJ7HSE/XbAH7sZAPrxYCN6F+/Px?=
 =?us-ascii?Q?atRPMKzG/IMlVIehesL+PXcxv3t+hV3WNVomi3XZpevYEseZAHQkPy2Y5ABm?=
 =?us-ascii?Q?CbDmAcB3uxz6hk2mV6i3MsJutYvTQmHvG6V2+oSNIliXAYu75+RE7pMVg15z?=
 =?us-ascii?Q?UMc1k9QeyvWxGTTwfvGfRJMr2rcD4k/GSI9mwBW92R0LVbCS+rTs9bwXfef2?=
 =?us-ascii?Q?EIWMBNOKvXo4LO1T8+17MpgbrNUZpNr0eWG0+MyGlRjya1TWKqCu3Sx6pgc3?=
 =?us-ascii?Q?erviVpllBgJk8NWzYQkRkVzBzfAYczL2+C7qedTESFpG2MThY9pDMHnmfCNr?=
 =?us-ascii?Q?kYtdU34TqWO6h0Y9c/SIWjCR9MxpvMJhKoK/FLECSSLCVeWfERrCwRysgg8F?=
 =?us-ascii?Q?p18w4i3H4e2gKlQGE70nJEQQTOu6qzCvhlsBEhE72kOfwl+6clT68IT54GFa?=
 =?us-ascii?Q?ahGYG2ZAxJMlca2pa0ypbQOH394ndVn9nxp4ZIBI14ihjYcKCkIkR26YfDl9?=
 =?us-ascii?Q?itzDvr0e9nDNrzewjPI+Fttu23TZ9S4tScnZ137MbPZaGKyDqoKn91+A8xCz?=
 =?us-ascii?Q?unkvTIUGUqVEm5g30kJXM1/iZ9NjZ5jo9jID/Ju2lHnupa+ExtxJMjzBENFC?=
 =?us-ascii?Q?Yt9OG83PBpNi/fZlsQHxsudZa4FsTriuSUcbHKZpe7R21Ip5Rd+O/rZiFI9B?=
 =?us-ascii?Q?Miv7WnN5fpWv9a/Ho3NhUPFdVGdAB+JiRSjdN7gW/JsAmF90ew+9eWTYFwv8?=
 =?us-ascii?Q?c0mlkd1SJgXXyRhdHsazCMciz9A74QkZnGJ+PdV0lXY1QX8sQflyU+X9aL/A?=
 =?us-ascii?Q?t8FnZFjtmafCRodHwh8ShnDHSi8rTze8hrZapaTMo9ty2HH2pMIMZzdqdh3M?=
 =?us-ascii?Q?iAt9FKtt+6Lbnx1u55J9Sv+4kctR+8huifNT6gcyFl0JKw8bRvnwp9h4JNhd?=
 =?us-ascii?Q?78+Mg8gRgpqkJ6JHgvJNS0Q9QB832wTH/B4Q66L9t3eRTJzNxQENPowhafJX?=
 =?us-ascii?Q?ZOEn4thNSZphsTqG3LDDELTlEHbtBbkpnFsOrWh6oXTfiI6tBzZsC46Nsu70?=
 =?us-ascii?Q?RhNJ+7P6BboaX3AkZ3qEe85FzH5Hl5FeQIz4tuEx0zFHvWsE9vtACd8+gEM4?=
 =?us-ascii?Q?Bg8xk/K7c6b+AvNnYLk6JSPXHZq66gR/0Sll1TfuNMfDGB3jetq/dIf1/RR9?=
 =?us-ascii?Q?9rAggvqmwSIuz7cnTMrKiOhOVMIW4bicY3CsJMGaG7HE4jMGfHBIoPiXj+Wf?=
 =?us-ascii?Q?SqaAKSL1wLvtJUdigHdSOPkE3TSSafkPRESsJa2P9uZoVJzGx+5fOK8IWAZF?=
 =?us-ascii?Q?CTFbTjAhDUoYeJ99/HmaQyyjHCcWyx7OatyyeK+V69cy6cU9QmZK08ysqUCj?=
 =?us-ascii?Q?PwUlPgQE7A07bKLti7A1yL8WY8Q8UZISMwTBwUCrryvL8bQ9VrdXAKpLjArl?=
 =?us-ascii?Q?Z4U/jTlDIEDFCxFBYQfWJwD0bMMiCccNzsoibSTeEANjWARBZepFhwMOV1uZ?=
 =?us-ascii?Q?pvaK1HpCue0SjE2XN3OtoH4DrJaYjaJFdiaz/ovAC3d+rLsgdv+iSxSEsbwG?=
 =?us-ascii?Q?hJG99cg0P3meWdm0rAeL55Sb/yhNdh8LtsirFbL1AG0TdAXJuCV4OMEJo7g8?=
 =?us-ascii?Q?rCrZowpP9ajFeVrM4U395ADwEJ3hxN8iDMiFK7UBMegPOZmRH7M5i+6jvebQ?=
 =?us-ascii?Q?yVzujVrHpWKNVKpY1QOY1IWWqbPS3/Ti1kClqDmqRiEJ3WepUMEmddfME6wb?=
X-MS-Exchange-AntiSpam-MessageData-1:
	2n6EfMKsm+F5OiDdk1fR08ro2rL+PX72aWLfAA7W7dMQdMGyogQX3zdm
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86be89a9-c865-475c-4234-08dee750f939
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:53:29.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAX9EPnoK+HfJM7CdrYq+8NbRHxCQuvEA+StkKQBLnK8s4U02O/fesLD66JT0Oir1OO2tsBzGxLw5ZqGTvq8HKMZ82zyIC3F74kx679xb5Q3ZaDAjlRkF2p8WTYbva0a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7425

read/write happening from both userspace and Hard IRQ context
chan_in_use is used a flag to sychronize access.  Volitile
semantics ensure we don't have a reordering that accidentally
provide dual access.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 2ce2afd255f0..dbfe8dd92ddd 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -325,7 +325,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 		return IRQ_NONE;
 
 	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
-	    !pchan->chan_in_use)
+	    !READ_ONCE(pchan->chan_in_use))
 		return IRQ_NONE;
 
 	if (!pcc_mbox_cmd_complete_check(pchan))
@@ -339,7 +339,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 * where the flag is set again to start new transfer. This is
 	 * required to avoid any possible race in updatation of this flag.
 	 */
-	pchan->chan_in_use = false;
+	WRITE_ONCE(pchan->chan_in_use, false);
 	if (!rc)
 		mbox_chan_received_data(chan, NULL);
 	mbox_chan_txdone(chan, rc);
@@ -471,7 +471,7 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 
 	ret = pcc_chan_reg_read_modify_write(&pchan->db);
 	if (!ret && pchan->plat_irq > 0)
-		pchan->chan_in_use = true;
+		WRITE_ONCE(pchan->chan_in_use, true);
 
 	return ret;
 }
-- 
2.43.0

