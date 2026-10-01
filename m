Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3A4A49B0;
	Thu,  1 Oct 2026 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887619; cv=fail; b=QKS0N7L1FnKcrYfCIln3KhMOWGvcgorm6EZZGwes09+buYjNgv0TFV0HWjfiVbmgYVO7Qd77IVoU7fHhu7vWfZ/9qjEXX3v6yXLhpTpHxL7NdsRTMLX8t3A4ZHriGUw89bk8HB5j0SHmYgbLFI9pAyMDzT8VnOqooIxM1u2o/TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887619; c=relaxed/simple;
	bh=PmpNLqE/CIMVAZz2Or7Y5mHMpJoCfKYY/caakvvOMSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ikb0nnCpqjUsLnPWj4qlGRDsT3WJ7TUHgJxa5nW1XY/IlwUeChowM64Si9fX2HSmxgAufyt1LP++nDXpelgSntW3bUbkOiyDGzQmf7fOtEDW3fi5Owa45VJXrUR98vq+mcV3wFxf5Y7ksC7M3CdJ3rTohgwp1pi/Gvo84hTl6rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=n7CWomry; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="n7CWomry"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022077.outbound.protection.outlook.com [40.107.209.77]) by mx-outbound-ea9-161.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 01 Oct 2026 20:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCvBsxe1JVlQEmao7Ds5Peg9WAeYlzgT2yYKnSvmz7Tlk0oiCVCENSKuTBm3atBCrB9g2x8h+qxeTu/e9MKDhyvYOfOmJagv5mJ4xs8InxF22tIS586JvWisK7yzgmJGpFT2qZ8Two0SWRlLLwWAAzcatxCqbKFjbPOzcGKeOeNwNazeuZwphl4RO/v2dDiTmEJyFEdA6GfzzHTGBLZMnZoiL6yO/7nLEx/JFhC9C+/Wk6uKjrsTf4ECkddfko03g7LRzFle7Hghxym4B/aVOJr8/06pKv9RAhtwOAInzoo8IXON6GQovdCjy2ru7pXn6a2nbAbpOH2X91vvKNayQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1AgB+1hhB46nWRv6L0bBGQT5jKvd53/V4mCG9M2NcQ=;
 b=PSgYYEkR2zTVkQDoYHtlScF2kDzPhzp4hmyF8bg32ix0uXOGj1O/lpx8PRtn+VXRK1+NgQ7JwbGSD1dCm3f6/vHeOAdZjjZE6S7vt0MKFUU/91wflq6/YOKRl0CfSVGUzTlm8Os2uL3Za9se55orh7Yex0yZqsgtX0BKed75owKvT92GFg8XkeFg9+X7iCzD0ly1jevx/9uZMNyHmVswpb3i8qR0x9E6CqAD2/Am7a+C9wtGUzgpYAFFD3f1TefluxAAi6Vlgg5DkZGXdJ5aQ2nXj0ACOy6Pi29fqBh7pxehk7lKb5pwbjQbP31ZOc1ssRvNgwfy5elMno3UrexubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1AgB+1hhB46nWRv6L0bBGQT5jKvd53/V4mCG9M2NcQ=;
 b=n7CWomry6uWDtkb16QXLItz0NYhAJO9pqeN2LLzSrP1V4RfnTwI/+UdkDpIKriFsgNi9uGhbeen9FApT5RYz1LhEmbkR4259tturcl+Sr75ov5agkQxu9keXXl+Tr71AafHCPv6zymqEgzE8AKhZrIuWI7SITx7v9nh6DF9y6GMYcbKhVxMpL8hQ2HjmiDnrT9aNFl8yDFeVGaVhDPJyGmmN0/Q+PHI7igkTRRVvwxR6Gq+t7lYGYKkHbHfTn+cA21GzbpfbY2C+Blpcb8oQZ/clND8WpfAlGqsKz+wp39OgxeQ5ptjMr8wrjPxU+wVa3L+J163lmA6ul0KWYBUfVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM5PR1001MB2089.namprd10.prod.outlook.com (2603:10b6:4:33::13)
 by SA1PR10MB6589.namprd10.prod.outlook.com (2603:10b6:806:2bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Thu, 1 Oct 2026
 20:46:20 +0000
Received: from DM5PR1001MB2089.namprd10.prod.outlook.com
 ([fe80::db19:a822:6d47:cfff]) by DM5PR1001MB2089.namprd10.prod.outlook.com
 ([fe80::db19:a822:6d47:cfff%6]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 20:46:20 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net,
	mani@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v6 1/2] net: wwan: core: propagate modem control signals to port drivers
Date: Thu,  1 Oct 2026 14:46:13 -0600
Message-ID: <20261001204614.3481089-2-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001204614.3481089-1-peter.hunt@opengear.com>
References: <20261001204614.3481089-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To DM5PR1001MB2089.namprd10.prod.outlook.com
 (2603:10b6:4:33::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2089:EE_|SA1PR10MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 744da8f2-b012-466f-5662-08df1ffd0c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|18002099003|3023799007|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rht+7ZXTGvavGOQ3IKqW7Pt8jQtlRyYFMHB7CLsb0taUW2cC6aIJPWtkWFv9twFSo+Qikk/WmlucgpFaH0JDBI7DP+PWD78VeA5FyOu/0kCyAvx5MDJnPDVUTaZ8pCQIyzM4H7baGKxPeR2+3rrNurTYeCCN+rfC8XEDYvrbe+7XFl+booCXqBecqwYBxBgJuODFrAheVHi2irNq58GroMIN2g6N2JlTnCX6lqAOmhNudXvpfUyXBTwb4vbELwMN+z72sgVEMZFWLjvGO2SHvBCt2srSuq7l7HEchZ2onW06l5bcm7f2Ga6hZgmvx4E7QIQCiaMMVQu6KEsfTvPiHhZK+I1jUbwrXEmznIg2qjoY5wGvxL0qDoE88rHA0BBWztyC9vHGq41qt5BoAdPLccg/Pc099gT1kDcUiiZQRrbfEwgOl3cWOqoRJAAvUZLhivnz9DpsUhu4Jj7uP9ilCWRWGO1hnFmKKDwHnenVNWjW5TcZPfZN8jfVIIcDNK2OxI0UMyvhnhoxvCWYREQX8r7UlWnSysQ4Z1NMdl0Nm6ssF3atEq0wd/W7hp4SjENqRO4KvxkcNfcNRBQhUESMbx+k6t3Q91S6bCjzm6GPzS0Inxy/zbXC9WncuaV6n0yRzGppMrntIPUi3E0qIeV+uZa74gL4AgpNQ+M0E22uYgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2089.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?88QUUsvUGb2FGAXzCDCHbmk6Sw4vTHMWrvp4HFWU1OTLjr14EBsRzerk/a01?=
 =?us-ascii?Q?KFPNi6niOplqdD812J/a8dEQaNqwhj8SeJnnYBXBB4BKeT7MpVJxUpNzy2KW?=
 =?us-ascii?Q?iyhYCeoDrZ59OHkuQjhiJgBgvEGU5Sr7gHI5cPfh2z4wyigWtPU32gySsvdK?=
 =?us-ascii?Q?ZcXjCFRe/uh+kYiXed/q3kcyJ+ENuGx7tWWqYNE8CIe8fo/WZo/9dOOsPvYv?=
 =?us-ascii?Q?uoqUKJkOWsIfmwn3Bd0E1d5mN/UiADtSkj+L0b6A3+YqKvwiucSFWgGPLY30?=
 =?us-ascii?Q?VD7U1kEFA9tTeAgHs2byHHHgpIpgI4eYgnQdYN5sDbqmQ/vLD96ApKPcHPOJ?=
 =?us-ascii?Q?4D0wKvOq63j7BXif03ju3Ql9wAO1zW4HuODL6OCXGxabMnYJ7DevXY0nSMAe?=
 =?us-ascii?Q?DWKc+4VL6IvXcW50QWNMfKgtZkqJeslnMTiyEqzvQQhAq0XRxo7l29fVRG7S?=
 =?us-ascii?Q?rnxyQVLDKAkX7qlgZ6fRy68gPjuD2NyqsJ8qdK4utStVf8tFHHoXcdiZKDtl?=
 =?us-ascii?Q?Hi+sgM+qJ3jS7g8ZUll6HgbxajF6TmflKuEjdX/Cr43f5m1y3TVKJ+9sSKWp?=
 =?us-ascii?Q?SR1/Nyew/k1ahKEc+znDM2RafO6IVY79ojM0k3QplkXj6YzbXo1++WXLZ4J+?=
 =?us-ascii?Q?xN/ZuBzu33PPeKmzhpuDHezHaIRUVdGIdwH8We2fAvHv1GYhkeg2pxxhGuii?=
 =?us-ascii?Q?YMWuuhKIoDFAwjXRInSRlhmwc8tWf0eKA0xVIiC3IZ4WQeylotRIDHF5PN4K?=
 =?us-ascii?Q?2O37Ke7wVWax+RLExMOaT/9Wo0vRbv9jtblTQbA8zIeO/wx48JSrx21tTmN+?=
 =?us-ascii?Q?3s205TJzV9TUhQle04ewuda/RPHYYxT2Vh/KRiEj6Uj04GmcUYWmm/6z4Go8?=
 =?us-ascii?Q?qJdPGFynbvT8JYDiCLvM9p6kWz4RsGlgP/lIfOgfmQv281TGbxxS3ePobLeI?=
 =?us-ascii?Q?ecTLcmugrc9w6VQDnGQBndlhd6rTxDO/I+U8pd0Ox2AzTo+Yiech8beol+B6?=
 =?us-ascii?Q?/LJIrIlpr5344cjR7Z3L20m9mAHLLd62rSvsi3sfBIlO7FWoIsHFuJo0aNuv?=
 =?us-ascii?Q?Ed01tgwg3tLjO2o4C/J814xhU/A0cwAbogBdPhY9iXsGb3QPiPcMCMRu8vZa?=
 =?us-ascii?Q?jTanvv7jSgwzKwmYOARSO3rHPGWyJ5NwO7dq94DQAitr/l1iPyRw96R78/Qi?=
 =?us-ascii?Q?9puSKEb+A9GZ0kTiQHHhW1cFHuBVb1eNf8R1Zil9eij2NcGmGBUBCh0rMN+C?=
 =?us-ascii?Q?22XeT5+qru5cMOX48sDp75rhJRHUDMcA58xzDk3ibeT1EGbN6miRgMqBfxoT?=
 =?us-ascii?Q?C1EGSk0wxHNHfsaCufiFnGwf8TlQt5A80o+Cw8Swh+xrvDkIXaL1h3T/dzvI?=
 =?us-ascii?Q?+LePdw8iKd0kwX27Bt2njeSMhbjy1kSh889a8nvebxpQBm0608WF5rJ1XlND?=
 =?us-ascii?Q?+CYIDqkcKUktn0UcqndmwPF5u6WZ0Qf5QfhZrR+ptOVStHmZflbU0S5TfXG6?=
 =?us-ascii?Q?RbLMOxbLSq4Dx0MAnTpsj7BUuybZ0ZEPOIUCzC34PHOQCrrPKv/Iw+IVs+Ka?=
 =?us-ascii?Q?BP4ZygZ2NcgQcNv/DcnhpZ8x1lUIg0hjEjo09/HMN5loagg+22qSYhg1kRY9?=
 =?us-ascii?Q?olCaa7JRBFYscYnK2QO0FuOZOlUcoPn61AzRWiDqRRfzDg0FKLy1284UhYB5?=
 =?us-ascii?Q?7ehNaX+0orkQ3f5HWjz/NfJZzeQRod/FT+E+Z+jn9d95MZ9G?=
X-Exchange-RoutingPolicyChecked:
	kNgtwCimsQyZkw8x5bYUqAQOb9CPJ05iWkQjkAgkrwX/wliTLuclEm2eiD88UN45Y38ByChJ/KmI7miE2fSaOQfuqKDlTRBh8kzgLGmGI/SmmrD/QangmrWfLSN416ssbzY5DTNLSvzj5dJ89Y9KQev8iWoA+X/jXSUnR8uwT4TYrjTaecIC/tJyPAjMkCfGitp+g0FQhMA1dm/tGvyRvcQBD8/vQniyxC+tcEIeewKOzvhI8E2qxO7+X3V+NjSsxFvJ94ATzFwFiqcgOisZEjEsOUOXjhQPoTNxjRV8tbXFUbQBpWums2pTmr55x4abHpOR3PnbzUuq1f/+YsWhAQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744da8f2-b012-466f-5662-08df1ffd0c47
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2089.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:46:20.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhuzEsKLwPpH48vykmom9PtbABVTK1CH92LV7l1MqpAwXuePAq4ygnV1LxCGL9gZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6589
X-BESS-ID: 1790887588-102465-16372-69072-1
X-BESS-VER: 2019.3_20260924.1518
X-BESS-Apparent-Source-IP: 40.107.209.77
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmZmBkZAVgZQ0NQk1TTJKMUkyS
	gtKcXQLNHQ2DIlySzJ3NQkxSDZxDRFqTYWADtkG2dBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276532 [from 
	cloudscan13-118.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The WWAN character device emulates the TTY modem-control ioctls
(TIOCMGET/TIOCMSET/TIOCMBIC/TIOCMBIS) for AT and QCDM ports, but the
result is only stored in port->at_data.mdmbits and never reaches the port
driver. A driver therefore cannot act on the host raising or dropping
DTR/RTS, even though some modems depend on it (e.g. they withhold
unsolicited AT result codes until the host asserts DTR).

Add an optional ->dtr_rts(port, mdmbits) operation to struct wwan_port_ops.
Drivers that implement it receive the full TIOCM bitmask so they can assert
or de-assert DTR and RTS independently. The wwan core tracks the full TIOCM
bitmask in port->at_data.mdmbits and calls ->dtr_rts when it changes, gated
on WWAN_PORT_AT to match the open/close raise/drop behaviour.

Also raise DTR/RTS in wwan_port_op_start on first open of an AT port when
the driver implements ->dtr_rts, and drop them in wwan_port_op_stop on
last close. This mirrors TTY semantics (DTR is asserted on open) and means
individual drivers do not need to implement this themselves.

at_data.mdmbits is protected by data_lock. In the ioctl path the ->dtr_rts
call is deferred until ops_lock is held, where mdmbits is re-read under
data_lock, so the value passed to the driver always reflects the committed
bitmask under ops_lock and is serialised against concurrent ioctls and
against port removal (which nulls port->ops under ops_lock).

wwan_remove_port() is also updated to call ->dtr_rts(port, 0) before
->stop() when a port is removed while still open, mirroring the last-close
de-assert path.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v6: Rebase onto net-next. Snapshot mdmbits under data_lock before calling
    ->dtr_rts from wwan_port_op_start()/wwan_port_op_stop(), rather than
    reading it after data_lock has been released
v5: Change ->dtr_rts signature from bool to unsigned int mdmbits so DTR
    and RTS can be driven independently; re-read mdmbits inside ops_lock
    in the ioctl path to close a concurrent-ioctl ordering race; add
    de-assert call to wwan_remove_port() for the hot-unplug case; update
    kernel-doc to note the op is AT-only and describe the mdmbits argument
v4: Protect at_data.mdmbits in wwan_port_op_start/stop under data_lock;
    release data_lock and acquire ops_lock with a NULL check before calling
    ->dtr_rts from the ioctl path; gate ioctl ->dtr_rts on WWAN_PORT_AT to
    match open/close behaviour; reduce boolean to TIOCM_DTR only
v3: Replace ->tiocmget/->tiocmset with ->dtr_rts(port, bool on) modelled
    on tty_port_operations.dtr_rts; raise/drop DTR/RTS in
    wwan_port_op_start/stop rather than in the driver (Loic Poulain)
---
 drivers/net/wwan/wwan_core.c | 46 +++++++++++++++++++++++++++++++++++-
 include/linux/wwan.h         |  3 +++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ffbcf11e4e68..d201d395a003 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -685,6 +685,12 @@ void wwan_remove_port(struct wwan_port *port)
 
 	mutex_lock(&port->ops_lock);
 	if (port->start_count) {
+		if (port->type == WWAN_PORT_AT && port->ops->dtr_rts) {
+			mutex_lock(&port->data_lock);
+			port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, 0);
+		}
 		port->ops->stop(port);
 		port->start_count = 0;
 	}
@@ -759,8 +765,20 @@ static int wwan_port_op_start(struct wwan_port *port)
 	if (!port->start_count)
 		ret = port->ops->start(port);
 
-	if (!ret)
+	if (!ret) {
 		port->start_count++;
+		/* Mirror TTY semantics: raise DTR/RTS on first open of an AT port */
+		if (port->start_count == 1 && port->type == WWAN_PORT_AT &&
+		    port->ops->dtr_rts) {
+			unsigned int bits;
+
+			mutex_lock(&port->data_lock);
+			port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
+			bits = port->at_data.mdmbits;
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, bits);
+		}
+	}
 
 out_unlock:
 	mutex_unlock(&port->ops_lock);
@@ -773,6 +791,16 @@ static void wwan_port_op_stop(struct wwan_port *port)
 	mutex_lock(&port->ops_lock);
 	port->start_count--;
 	if (!port->start_count) {
+		/* Mirror TTY semantics: drop DTR/RTS on last close of an AT port */
+		if (port->ops && port->type == WWAN_PORT_AT && port->ops->dtr_rts) {
+			unsigned int bits;
+
+			mutex_lock(&port->data_lock);
+			port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
+			bits = port->at_data.mdmbits;
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, bits);
+		}
 		if (port->ops)
 			port->ops->stop(port);
 		skb_queue_purge(&port->rxq);
@@ -980,6 +1008,7 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 				    unsigned long arg)
 {
 	int ret = 0;
+	bool call_dtr_rts = false;
 
 	mutex_lock(&port->data_lock);
 
@@ -1036,6 +1065,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 			port->at_data.mdmbits |= mdmbits;
 		else
 			port->at_data.mdmbits = mdmbits;
+		if (port->type == WWAN_PORT_AT)
+			call_dtr_rts = true;
 		break;
 	}
 
@@ -1061,6 +1092,19 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 
 	mutex_unlock(&port->data_lock);
 
+	if (call_dtr_rts) {
+		unsigned int bits;
+
+		mutex_lock(&port->ops_lock);
+		if (port->ops && port->ops->dtr_rts) {
+			mutex_lock(&port->data_lock);
+			bits = port->at_data.mdmbits;
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, bits);
+		}
+		mutex_unlock(&port->ops_lock);
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 1e0e2cb53579..57406139304e 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -57,6 +57,8 @@ struct wwan_port;
  * @tx_blocking: Optional blocking routine that sends WWAN port protocol data
  *               to the device.
  * @tx_poll: Optional routine that sets additional TX poll flags.
+ * @dtr_rts: Optional routine that updates the modem control lines to match
+ *           @mdmbits (a TIOCM_* bitmask). Only called for WWAN_PORT_AT ports.
  *
  * The wwan_port_ops structure contains a list of low-level operations
  * that control a WWAN port device. All functions are mandatory unless specified.
@@ -70,6 +72,7 @@ struct wwan_port_ops {
 	int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
 	__poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
 			    poll_table *wait);
+	void (*dtr_rts)(struct wwan_port *port, unsigned int mdmbits);
 };
 
 /** struct wwan_port_caps - The WWAN port capbilities
-- 
2.43.0

