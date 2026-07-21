Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020076.outbound.protection.outlook.com [52.101.85.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC347013D;
	Tue, 21 Jul 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656399; cv=fail; b=hOoIe8E1u1MuMLd95uYv+QqikY/Ef/aeGKQ7lN3+0yd3PIjCoqVyz06DHDfa6PPGV/1B6dzJe10OagwDOWjdvoNj3cv19rh1UHCUjqdI/ZlZ7I4L8xwliuTJ5hLFTjDHhFpfx0RSfRBlEom8FztSRHjtmPIm5xjBkOUPTz+zXhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656399; c=relaxed/simple;
	bh=WfFlR7ab/LEmmPWwSodF9g4iwpOmp6z1MrZGJFLk9m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iwqWlyy18pVzsIuB8tFcAbDeAI55D05TRDjwB8//gmnWPpjsPyGRwCX4b9FMmgHj6W3pcf8RLDaKYfehczErSGIF0kdXW2iD8BlyDECoTgH7EVkCA/I1WZaAikQVoWW2O0EraCIZSLD8WiGSaAVITsAqypuAhN3xa6BExWIFSNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mhQC7A2i; arc=fail smtp.client-ip=52.101.85.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mhQC7A2i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfSUssNuzSOCd6FWwkgVvfUDqbXt5CUcts/uDsmux1Jrr/7M0tvpNtkMqxWi22dJKo2ah6Hwc26D0Muo9nGYAnV6+HKigTdpvmPOfcDSwuUczImjEiVCWycEmQkZwO01sx9oY4jfa82oUlZ0Yf8ByEn3aD/yGw57ePmLIfVJcNYaHm2SQp/qRb/RmU2J8vKTNzzeIC0JFh/SIyHpLxDDcG1OFzwHyz+iQOzcDb0/LInmDMrrHhnYfPeX+h+po4oTWMdPm3L/6FUwLRYJgVk3isC7nLysmP13vnW13zLf3C35VTh2G7XID1E+GW3WFj+6Bdx7Hcfa8LzDR13WC10VUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVPGE+eocrw3P6/Z83N/rqXKLrzqEbuPWDjB3icBqjw=;
 b=iMcDeT7ATZFyAUY9XYgerG/BTDUqxFAZqqjZbWOVDQTWYm9RNW7XyHNOCK0132sw1jlIMTkp3j5nFwXfX0Jt3HmRZsllUP6pUXi3fsC2hyHUgCqS6z0ZwemcelL2vU7eOdciGeu1uj1GUToeBefbNA+C9TXgixlPcAykYLF1u+Ay1u4X+4sD6J7s5NnSKTVwMVW6EI07YCm0IoBGHUC6tlCkXTdNWTTtuMBFEqQRrW1YPXu8jTrne7YGR0xnoGOJcWYk7btPO197ct9Eaj7sdLjs4nZHszDRPdu/kqwpqa5WXr6aGKVFJ1DSDzw05pLp3k20V1xGViKjdqVoLTkVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVPGE+eocrw3P6/Z83N/rqXKLrzqEbuPWDjB3icBqjw=;
 b=mhQC7A2ioqhv/BA7p+ugA6OlyAf3ZzZXP1Bqs2gaT8G8QdtmGTvVyqc2WWW9K9Jl7tJlyRBzn0UZjQZ6XFvbmwgr0TdWFi6N3+4J6wXJT/6T4xaPaQFIS2AxvNUb/iVGENjzHDabMdbmKQ+nlwAL34AQSeuNgJrRuE09U7fL0RI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7425.prod.exchangelabs.com (2603:10b6:510:4b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 17:53:15 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 17:53:15 +0000
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
Subject: [PATCH v45 3/7] mailbox/pcc.c: report errors for PCC clients
Date: Tue, 21 Jul 2026 13:52:52 -0400
Message-ID: <20260721175258.87600-4-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:930:cf::20) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e7f587-d1a5-434a-ccea-08dee750f0a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|22082099003|55112099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lWOuia65LUNogSvQ/pNa/RuypSQCKZasOsuDZt0jpZjH2PEkTNuw76Qwtugq50MBTv9kdTnPkREYktaOUgSf18bxDMiMDc9ltCFJSOJAAn9/fBetOk7wDTnrumNO6SAU6nzAp/6I6WaXvGCN9aMqIG0/1/tGrgXWRh+x8m8S4/C9HprdP3DFrOvpuFGyPhn9N5nJIMcG2uXBBDHY4R2mVqIE3DDLJ6E6ga3j4zc4jTm+npaYcWC88KLy2ZInC5iCmNJF+hn7i7vDmeyp47kq6UAyS6LnVYHbpF7OgYjVqBudP++tRmPtrx1eRFkEu/VEyjdV4O1ymkcrhgiGK9GXvXZBYLkJwZDvgaQmF5KcK7ifW6ySePF/LFhPiYgYzYHmX6t4SSllQiy+LSnbbEshyit/HAOlAhiNJWRVIkWCaX+8C0vWb6ZtwakninrykkmR+dZTeznWBBkXo6OQsPCVv3QGYd6mCmKgeWaLOfnLMD6Cir/UsueWdgCKGU6iDgS2oU0hXA1ol70Go+dQlgbgkWgr37Jkim0GYgX3pn+WQAnmINxlZCXwg/JUCJ3UPAI2eLyRAVBveVqyJmWnatjNkifcD3pO7O6kIyOPA0ObNVJuLrqgaSSlk3qgDNwejrJnB7NXOaPdfJDHbG0cxMOffFD/FM6fKskyBjrGaPblw5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(22082099003)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KtWLaM45YUpaejTYToPDo0dNdoE48vE7tzayao9dcSHnceegKzaX3vc8UH8M?=
 =?us-ascii?Q?LX5Jd7fgktEfNvMXWn9Ya50as46D8aV1s/CqXIcbjIEnXxGopaMObySOvdwK?=
 =?us-ascii?Q?aEdnQwkXjc0igExZiHX31JMcivF7WZLPz9Q3VPLaT04Ln9kWfsceXgcl6n8f?=
 =?us-ascii?Q?pqlCYGA1LOMb7BYnIVPKqWL/JgFIX7rgk4KTexzYcjAa6rAFGIEvTGbOlG5E?=
 =?us-ascii?Q?BvcIeLuA1fLO+oHy3Aa/viL+lq4OEIKWag9BKtAnmeCSI11Gmm5DtpGHfsDt?=
 =?us-ascii?Q?kbTqjE6q1+jCQlggH5+q4JPCKvttU+r507jrC3OQSB5aV9Qu8SvfKFP/xgnZ?=
 =?us-ascii?Q?jhnuA7SNzcMqXipiFGmGuKn5ZD1unu3Ks3RCM50syF/gRWSq+7qG7QRTTH+B?=
 =?us-ascii?Q?eT7578IoZl+m/NAwFUOz/fpoRzktDIbppprSz75MNKAgDGiVh9a3nekGN6PI?=
 =?us-ascii?Q?48/Vq/9ChtBK5UVPmV8TCp5KjYVavzhql7V3jPD/noo9U70p5TqFdHkFPA6I?=
 =?us-ascii?Q?CXa7dYRiXaUnL/g2/9d2h39HrfqwNTgvFfiJS+LT52g5bJlGgIsf3ylFKc63?=
 =?us-ascii?Q?ElmJ0Y8BoJOlTFjfycizRadfKWp1YWMrySwe2evujVZ6UmuM1+t79Vg0ylMP?=
 =?us-ascii?Q?z6ipxv1SSnAbCWd0/r9JfKUpTEIdgCM3+4+GgLuNm+yW4aqQkNExzyriSXqp?=
 =?us-ascii?Q?NUDQgysBaAv2BAoqwDOgcifiz/mVEkff8eYx1wcs5msrgdJ+JhNh322WChOJ?=
 =?us-ascii?Q?7+JS7bwS5p5LJgBIO07z5A7qjFD0Tkcs53eoUUOX1XXNf7DFkhUY/uti+2QV?=
 =?us-ascii?Q?E1S4TA6Jd2PX66FFk44nfQN0Ql+N6yXBnj2RzGTXEbjDAQ28Z+evb2auCB1h?=
 =?us-ascii?Q?2hffVebTN9FaL4KnVacmT4v7HA5yjMVNIEzi6LrGqAopsxy9M19HG7a1Xkxa?=
 =?us-ascii?Q?OA1JME9aKUOJhAzQyS84eXhfHO1nCg9SK/MieVnUvoqe4AyDXimiIVNn2Fip?=
 =?us-ascii?Q?USmWx91oD/b9hgfUyRmoZAePwjvmUt6nEYFOwlSqrMwYvgtb5wRXDPAhDkjP?=
 =?us-ascii?Q?tenwvlEFGgVuhSt5ilwvjAbupwAO6xAY14tOtR91CTHONnOVOfa6bNRJ0foK?=
 =?us-ascii?Q?UepLmdkOUFFuO+WZAjnoEs6/I7tNsjgCiE8OB97zVYoCIm5OaplFg8r2kOfK?=
 =?us-ascii?Q?m3XuDBZPFsm3mzA30ygiVRqjbtSCBmQdy/pzYuDMFsii4e+NbD7yhmccRc9y?=
 =?us-ascii?Q?6SBhW1Te661vs+wb/g86ICcpcpm9Pzi2zeSdPTK17LSug25R4j0ZPxTRvw6S?=
 =?us-ascii?Q?JgIhvdfKwr8X1M4OBNbIxxGFmnqkxiodgorrZo/S1FzKQwARod8LiX/45dpQ?=
 =?us-ascii?Q?NUuYz0gGAUPyaxm9tcNUINtBBr6su+ZVQVfiPnijwZBJs3WlR8aDGXntfW+j?=
 =?us-ascii?Q?UqkbuP7Q8Jcu4LtVnYUJKkyJnzE+krBGuReOvKkZhu51UmzFurFH1QahjiXr?=
 =?us-ascii?Q?DBJmEb9e1LlCfkAwRsAEw/iziibUqqUmr4H+XO2ZkxCe7/OUD1O46Sz+pOeo?=
 =?us-ascii?Q?OuCX+2e2HsCPw7o2c3ZokiOdp4bP/2kp8dkySk/G79y3m9oqvyOiw/FDe498?=
 =?us-ascii?Q?y9ZIcCZz1AO+79+/OMvksMGN2xptiZNJybrFi9htsAsRQ4NKonfZiRS8rIYD?=
 =?us-ascii?Q?G26Ugk1kMvymVnNTNCP4mNZmiDGQ3HoSCvrAfzqpPePBHfQAGk+tAQ/cI7Nb?=
 =?us-ascii?Q?mdpER9fgQ5Di19788hTLgA8xIvNmCzv5QDp16vQ6axdJC53om8lCdZyORlsW?=
X-MS-Exchange-AntiSpam-MessageData-1:
	NpICqRe12l4RZMvOEKvZVxgqCa6nCCu/Tq+rWIWOA+ajsE8+LPsKzpmh
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e7f587-d1a5-434a-ccea-08dee750f0a6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:53:15.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcFyJQW5Zp78ajay6GLC8jJut+Hp70T6HBFftZ9iDJ9dbr4hPehnqnkKhD7R0z1oNiufggZ/Nr9nt9pug4ptlu/zOkQOZeYrQlGeWXKnCpZ8+tfRU2bIKX2hnRiZCc6B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7425

The tx_done callback function has a return code (rc) parameter
that the tx_done callback can use to determine how to handle an error.
However the IRQ handler was not setting that value if there is an error.

The following clients are affected:

drivers/acpi/cppc_acpi.c
drivers/i2c/busses/i2c-xgene-slimpro.c
drivers/hwmon/xgene-hwmon.c
drivers/soc/hisilicon/kunpeng_hccs.c
drivers/devfreq/hisi_uncore_freq.c

All of these only use the error code to report, so they
are expecting an error code to come thorugh, but they
do not modify behavior based on this code.

In the case of an error code in the IRQ, the handler was returning
IRQ_NONE which is not correct:  the IRQ handler was matched
to the IRQ.  This mean that multiple error codes returned from
a PCC triggered interrupt would end up disabling the device.

In addition, if the error code IRQ was coming from a Type4 Device that was
expecting an IRQ response, that device would then be hung.

Fixes: c45ded7e1135 ("mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)")
Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

---
---
 drivers/mailbox/pcc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 3c059fe87ce4..b1c7d3e4c5e3 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -317,6 +317,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
+	int rc;
 
 	pchan = chan->con_priv;
 
@@ -330,8 +331,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (!pcc_mbox_cmd_complete_check(pchan))
 		return IRQ_NONE;
 
-	if (pcc_mbox_error_check_and_clear(pchan))
-		return IRQ_NONE;
+	rc = pcc_mbox_error_check_and_clear(pchan);
 
 	/*
 	 * Clear this flag after updating interrupt ack register and just
@@ -340,8 +340,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 * required to avoid any possible race in updatation of this flag.
 	 */
 	pchan->chan_in_use = false;
-	mbox_chan_received_data(chan, NULL);
-	mbox_chan_txdone(chan, 0);
+	if (!rc)
+		mbox_chan_received_data(chan, NULL);
+	mbox_chan_txdone(chan, rc);
 
 	pcc_chan_acknowledge(pchan);
 
-- 
2.43.0

