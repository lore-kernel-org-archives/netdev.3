Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925574369A;
	Sun, 16 Aug 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786884757; cv=fail; b=BMEWvU80mTdgmjkdJHAPnK+pxCxYmrRzyj8qcNYvnRFWXyLHuMmb7nDArt5iinhgOYUD5r9g1yoU8dbdlvdhsfh2tm2G/E0RwnsHq2hWh5rIejkAEEBjTVpO+rja6LX2+4sutA/kBQoxsGZhypLICLMOk5jab4Ud5pAVNchtSuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786884757; c=relaxed/simple;
	bh=MnPHGXeU8aZreFXAfwFOdC1GRsoGA1PrZ19XLJ58OZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VXG+lRVNMKoBHkUPhYhprjwsngG+vnGtSusZ7hZYoNEU71GAVPKVQznCNGRub5LfbMKEg6ALjRw9TCEy2VoC+eL6rVAnzbp4kd1l0YPUFUF4tUp0t0T2CwX+MUrEZDy2iKLBcYxyiprKLVxi74ZCCFWtt3YoIOy2ZLe28jkLDFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=NYCywF/q; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="NYCywF/q"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021120.outbound.protection.outlook.com [52.101.62.120]) by mx-outbound13-51.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 16 Aug 2026 12:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsZUMNznrNp8wMZrX9AH+OM34vJVS5+3PKMC+frCBFgKKoyNL4yOSpQYujR3kiZq+8A2HZxXvTPNzdzIH30xSCg/RMsq867s5phVkLjiHNeK4sVUO6gBXzIVr3RmbwKUajYErLCXf47O/7Yxv01k6vFbQ9WgDMdvOfr8IHr8B8eGeFUl/+AOaHnpPOHl5He8NdZU/uc5VjLytiDX0WUlTxSAuoAMS8KWBGLO/R5DzZLn7MGWodT4plyflLjFkvyssPVSb6IDqDI6LL+tFP8xrEfYa9OSNcE9toXKrlgwSM6au4kp3C9fNn8l3bj5x41NGMx4PkKRZQ+144EvSyO5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akmLE8+FHNT9+mVs5xN6u/KuJbg9mzs5z3LoDUsVrd0=;
 b=IMGN70QKLpF1rM3BtpyxFLtG3198ZdG0b2IbQXoGy2dZZb3yuCdShmqXZ3PPRuC/DRbaav1IaZxNMebmpZTParth/DS5RHu6Fb0ZfyCajfNpzZTOBMNl7HbGDeP10q94Y+gVR6/RzmvX4+dXST+pFPWNlbsG2CICKmZGV18n49JdID4Yb2mnzzVl7i9QIp9e/c6VOZ5faJnelJdiWkejWHevH7sX1gx8ElYoOgFgeEyrCkdy0E3V5zxoAMOmVmEKv+ub5djXOc+tf98IqnhdLc0YeDHJXXe+bodhIyQZalcOheqbf3t+j2ZvU4sVNU5Twz1lJ0BeX2VhyeGr6+YeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akmLE8+FHNT9+mVs5xN6u/KuJbg9mzs5z3LoDUsVrd0=;
 b=NYCywF/qfEtrOcXpuPileMnyMEoFOJjiWPfAbTwWuIMGKNtf+zrJXeKxB4SNPxYZ1VVRJ6jkqXPmh4LiMBaYgUMmbpp8Er/nYNljpYl0EmgxT0m1qCDMijA8EgYvAg2uf4AsDwzboa2m6X5mvlyL/IRcBdiN6FifCC4pt8oSkf3aQxntACmf1F7IlWv0X17S9SVxD+BldIriNShLndXueI3la4nHpduEH7nIBtpqEBVF1PmZn2BPKtptQ6ozT9p6EpCRCew4ZsmYhVbO+2492Km1fsg0iQnbVv1K1cMQgtJJMlwM03o5/J7yex4fyFprsMxH9NHxxcDMHpNsYtYLWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by LV3PR10MB7793.namprd10.prod.outlook.com (2603:10b6:408:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:17:19 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:17:19 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	mani@kernel.org
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v4 1/3] net: wwan: core: propagate modem control signals to port drivers
Date: Sun, 16 Aug 2026 06:17:03 -0600
Message-ID: <20260816121705.858013-2-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816121705.858013-1-peter.hunt@opengear.com>
References: <20260816121705.858013-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY0PR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::10) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|LV3PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2219c2-c276-4570-8390-08defb90514b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|3023799007|22082099003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wnpbs4LOXfKte4kIQMdW1oe53NbxzaPX3+ELO2mw9LuOPyOtwTUgS/rmPdPOiK60wtxb6aNTBupyAVAWRKa7ev0EVMeCwON+3H9AUxZzVBt+BVIoffpYhvvXw86M2dJ2xtz2teHKpE4nhyRI95QY0Q2nohCCtyaRuFXufasQIuq01ICAYX0R+I+f2/PI/HPWHa3OrSs8rCpWo6QLVLMgQLHwm2JTKD+Izm/Cd2T96ZnRzGhAtVD1EzZS6DOR5ZYS/yoOkMrjtkn0U49LSKO0fvjwHn5tDL3KXRtk3NRMU9nkIKm/27ZX8UZuM599q9iywCGhNUDqAlB3kJ/fmhB/RQzWICJnr4wuO0amC8U8JedqSTN5UOgBAS/ZFInhvkJXJG/V90Yieez4rF6LcYPKLWsCDgWmcl2HSPVPmg9wInJA/8cbTuOGdb9UoQUfotJ9M/P1VePzyWBfWmqlw1piGzYHsCuN+zZBUFZrbbxE0v19da5qOM4Nuj7KR8SiWKjK8rpC4aqlC7uj/ft/POkJh5fNsqSyYAJ86JJTscUBdGQAvS5jv+GrKrY2ZyT58oN6FhKudRLyTugLYXC08R9BfS7zUhCaPWiuswlV+uIiKkd/S7uuMXgMWMDbDkcW6fAu0g7b6QCPvHXKKs45TIJ+Sg8LAGCUmldd/6JAVHsCaVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnZ3lbWxBx8Nu4w8+BughstHO7Ayy5RQ2S+J0ekL35bOECjDbk/WmKraPo07?=
 =?us-ascii?Q?bX084hquGYEashXVSjf49OZJevBjbCeJnYCI9gpqJsr1ua1VyBJ9PLpCuhL7?=
 =?us-ascii?Q?BID7UOCYzQxl8dNikkr11uG8K94ECm8OkwM2sR4GumEffZmHPFWjVRqSA6R8?=
 =?us-ascii?Q?lpdkc+coFHEQD7dD69uyOQkQ/zU4Yc8rjLyzksRj8zj2BFi4pT37vanzaj8Q?=
 =?us-ascii?Q?ytVurnUEh/GdQVoymJpeRPspyvUpIVkNcM6JfYpyeMRpQEi+Vam68wllLFan?=
 =?us-ascii?Q?CtsxNGSHSBekh/o0CVbobIVoUwUbDtmaR8o1G5um5J3Sl7y1+xUfQz5Rfhz5?=
 =?us-ascii?Q?xJT8cS0qvSOI04SAC+eJjiv4J8Rikj5xQah+bBnWo+OpS55+6c3A2XxFkjTF?=
 =?us-ascii?Q?VxLLIPdgkyYieWNVDK3gMPpEyatuBTm5xQHGXkezIH9WQ05s8yhE3HZYFaxJ?=
 =?us-ascii?Q?mFI60owF9PSQ3AbzgCEPhh8eyJVjxuSnqe/Y6TiNA4VVP6YXdulyVT3fAI++?=
 =?us-ascii?Q?qoycJ2qHgIzD/5/N2gkIRALkzDkM2weyja46WjOmyUba1aZDqqq6Dp7a0u2L?=
 =?us-ascii?Q?bwLRTcDJX5MzStbYuu7TyW4o6LICcHI6433Mk+bYiFVvdSMRzGEExerA7Kea?=
 =?us-ascii?Q?sLJGEuPpJljUx6n5J3PQYLBmGJavkHxf/uArldMVUdKPV+xIP9btamIs9H1+?=
 =?us-ascii?Q?8+/nGKN7sMDvCZHCmikZd45pGE3pIt5HSavarkaMw9eWS0iLZ8GTPh7LDh0Z?=
 =?us-ascii?Q?Il5C0lqu/U/Bduc2rschw0jDW4bkbLkRIXNUPXXeC8otyJj8bq0luWce46Y9?=
 =?us-ascii?Q?aibr1ZrXBYjJXCcUFoGo7uShv6FbnsDUz0/SsQWA16c/2wDsaelMYEz/MGwr?=
 =?us-ascii?Q?RJVVuj4xzMrAG1PrVcEiHOxb05iNgRFDjCdS2v344RXjpj0wybhsYS0WRKfg?=
 =?us-ascii?Q?kjrasziwbBx/aQCKRZIQSmijBac4aHwdjdZq1C2o37r0Nz0l0oUnYXknBZHi?=
 =?us-ascii?Q?jaVg2/4dobadJ+MQR5/ydishcI5+pKE+syfE6Kzh4pkvVv28oR4cfbs7D1FX?=
 =?us-ascii?Q?x8hWTdNxn0dky6WtOkL8enHeS8Y+vjGPJn/hVEqLL6PjdXQXYB6JywGpOgDn?=
 =?us-ascii?Q?KGfvdBoQcnPT6cQzWYwdTfRuBbXdxF3RanK/Jl0eKkkuYpFuR1rnKSQFwYk8?=
 =?us-ascii?Q?LBCZhtWPVK1JgRG1hbapXnt59NOOGBk9ujlItAo8pFcXr5tfy69PRal0jfVx?=
 =?us-ascii?Q?qfn3RJGw94y5DAIRp/Qe306gqW8dRrQAgRkuOb5J0ilYf+6Yb4io2vTrqvep?=
 =?us-ascii?Q?4PjhIU9FOvjvd84cV09JpW8fMdABOf7ligMiv+lUzod2BV0aS+4palBK9vnk?=
 =?us-ascii?Q?SPZGndkZMypxAo0ZRcca5sFzZY2lBPsx8/x3UOv8eRGNdJTOT7qGdEMwYSFq?=
 =?us-ascii?Q?ICtzlJnoT9c3OWO0pItYoIQx+jBhgPAyC1J6C4P2uLhs8jxDSuz+ij8bRX/T?=
 =?us-ascii?Q?RQSadbJGMIkH7h1ZpMO5OG3F6k1uH5ZSUT6vBKLPNpFMhAcVuprwGXWvzqsO?=
 =?us-ascii?Q?F9gJCs6YCwrbqEwm+CyO4hVeEZCacaMfcuecp3U5b/gUe7cXHXbmivK3dBhk?=
 =?us-ascii?Q?1uPsIoe83rdLLkflMb7gik3AqQNfe2iaym4AIp1Nx5+DoWDVCmJZQ7dVXA1c?=
 =?us-ascii?Q?4qrgZFQtmxAdxTR9FqWicW9KLrPuS0obWbbL8KlTRXnvyAnY?=
X-Exchange-RoutingPolicyChecked:
	pBWDHjXJp53eXkVaUFdG7mhVViJ4tsBJi+DTCVlyuVwQEcdtkbmntjQXsQBcKD7glRw4iu6F4ENzREqHRcyXaOPzvhUJAELYQ4+1WZyygaTX7vPxqiHmIU/T5VQIr8hh7K0lg8xeO9mLwi7UfK51vw87O3THYigspkSGHL0Kwp4YfRfKgSNtE1nYvre0pkHlrmamEVKoArm55PGu4FuXI9GAuHjxM6czz9Fh2q73EL7nST1D45y0KZ9RapM+O5wZniWmSOnDjv4vo8H29wgwXSqfAXl7jcx64DanouOs4Q72ySx9txJZG85MdP5hjzPZPkm4aWjGW5lsAMU4BPgL8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2219c2-c276-4570-8390-08defb90514b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:17:19.2035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCtOMHYpZ4nNKhUXPKnPJbpCrIGF8bT90jRKD4aKaaZo0c3Br2xoptfWhRYie2Eq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7793
X-OriginatorOrg: opengear.com
X-BESS-ID: 1786884752-103379-7726-7591-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 52.101.62.120
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbGpmZAVgZQ0NDU3NI4NdHc0M
	IgycQyLcXMIM3IKCnJwDg5OSXR0MJIqTYWACPO17dBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275424 [from 
	cloudscan19-76.us-east-2b.ess.aws.cudaops.com]
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

Add an optional ->dtr_rts(port, on) operation to struct wwan_port_ops,
mirroring tty_port_operations.dtr_rts. Drivers that implement it receive
a simple assert/de-assert signal while the TIOCM bitmask state is tracked
by the wwan core. TIOCMSET/TIOCMBIC/TIOCMBIS resolve the new bitmask and
call ->dtr_rts when the driver implements it, gated on WWAN_PORT_AT to
match the open/close raise/drop behaviour below. The boolean passed
reflects DTR only, since DTR is the line that governs URC gating on
modems supporting this signalling; RTS is tracked in mdmbits but driven
together with DTR on open/close.

Also raise DTR/RTS in wwan_port_op_start on first open of an AT port when
the driver implements ->dtr_rts, and drop them in wwan_port_op_stop on
last close. This mirrors TTY semantics (DTR is asserted on open) and means
individual drivers do not need to implement this themselves.

at_data.mdmbits is protected by data_lock; the ->dtr_rts call is made
after releasing data_lock and re-acquiring ops_lock so that it is
serialised against port removal (which nulls port->ops under ops_lock).

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v4: Protect at_data.mdmbits in wwan_port_op_start/stop under data_lock;
    release data_lock and acquire ops_lock with a NULL check before calling
    ->dtr_rts from the ioctl path; gate ioctl ->dtr_rts on WWAN_PORT_AT to
    match open/close behaviour; reduce boolean to TIOCM_DTR only
v3: Replace ->tiocmget/->tiocmset with ->dtr_rts(port, bool on) modelled
    on tty_port_operations.dtr_rts; raise/drop DTR/RTS in
    wwan_port_op_start/stop rather than in the driver (Loic Poulain)
---
 drivers/net/wwan/wwan_core.c | 31 ++++++++++++++++++++++++++++++-
 include/linux/wwan.h         |  3 +++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ffbcf11e4e68..90ca85a63b5a 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -759,8 +759,17 @@ static int wwan_port_op_start(struct wwan_port *port)
 	if (!port->start_count)
 		ret = port->ops->start(port);
 
-	if (!ret)
+	if (!ret) {
 		port->start_count++;
+		/* Mirror TTY semantics: raise DTR/RTS on first open of an AT port */
+		if (port->start_count == 1 && port->type == WWAN_PORT_AT &&
+		    port->ops->dtr_rts) {
+			mutex_lock(&port->data_lock);
+			port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, true);
+		}
+	}
 
 out_unlock:
 	mutex_unlock(&port->ops_lock);
@@ -773,6 +782,13 @@ static void wwan_port_op_stop(struct wwan_port *port)
 	mutex_lock(&port->ops_lock);
 	port->start_count--;
 	if (!port->start_count) {
+		/* Mirror TTY semantics: drop DTR/RTS on last close of an AT port */
+		if (port->ops && port->type == WWAN_PORT_AT && port->ops->dtr_rts) {
+			mutex_lock(&port->data_lock);
+			port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, false);
+		}
 		if (port->ops)
 			port->ops->stop(port);
 		skb_queue_purge(&port->rxq);
@@ -980,6 +996,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 				    unsigned long arg)
 {
 	int ret = 0;
+	bool call_dtr_rts = false;
+	bool dtr_on = false;
 
 	mutex_lock(&port->data_lock);
 
@@ -1036,6 +1054,10 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 			port->at_data.mdmbits |= mdmbits;
 		else
 			port->at_data.mdmbits = mdmbits;
+		if (port->type == WWAN_PORT_AT) {
+			dtr_on = !!(port->at_data.mdmbits & TIOCM_DTR);
+			call_dtr_rts = true;
+		}
 		break;
 	}
 
@@ -1061,6 +1083,13 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 
 	mutex_unlock(&port->data_lock);
 
+	if (call_dtr_rts) {
+		mutex_lock(&port->ops_lock);
+		if (port->ops && port->ops->dtr_rts)
+			port->ops->dtr_rts(port, dtr_on);
+		mutex_unlock(&port->ops_lock);
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 1e0e2cb53579..a7684950d73b 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -57,6 +57,8 @@ struct wwan_port;
  * @tx_blocking: Optional blocking routine that sends WWAN port protocol data
  *               to the device.
  * @tx_poll: Optional routine that sets additional TX poll flags.
+ * @dtr_rts: Optional routine that asserts (on=true) or de-asserts (on=false)
+ *           the DTR and RTS modem control lines.
  *
  * The wwan_port_ops structure contains a list of low-level operations
  * that control a WWAN port device. All functions are mandatory unless specified.
@@ -70,6 +72,7 @@ struct wwan_port_ops {
 	int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
 	__poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
 			    poll_table *wait);
+	void (*dtr_rts)(struct wwan_port *port, bool on);
 };
 
 /** struct wwan_port_caps - The WWAN port capbilities
-- 
2.43.0

