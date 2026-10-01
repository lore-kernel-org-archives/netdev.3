Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083915013DB
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862294; cv=fail; b=VgwjgUAir4hItFMvxxAJ9f/ZYkCwDeiPinFr3Wbf5BvCtmNKFOVocVvC3j/o3v/BEsJ79ghLzO3x+uVEzA+e3ndnM6txnb6P/vE4+dxHU/Cj8+y22Ske23lI+/Q+aP+VjP18GdXABRZVJadbRWzEoydJ0a5rw4tHXw9u7UEWYEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862294; c=relaxed/simple;
	bh=qWaoZLGKb9B2PPJuwPq/KExH98l4/TfYADGjXCrHw64=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R7VGfBIxjkEpLQjDlLSVAlVq/tkBebLfeyYQT+nkil0Q7q38JTc+KlBOxmcaRCH532Dgbtru/F2nHuc/1DZYUu4ahp6WupSFRyi/ODIUozc4rXK6lWVniCXi/puamwmhjAXxi+CL+v6v0VQ3wt8zkuii0W/0QhoHHeBRoBACH7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=AMr2y4+a; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="AMr2y4+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vmy/2XCnSwEHD243/e7Wf3RDMM4eLcxnlVFCVI5XyLb1j6p8X+Rp4Enx3GhvFRXqDJgvRGlOsxXioIA/I21REJHT/81f7dyxvOHmfmfCnKd3XCtW7F7MNnBvtsgMoaebcSVRjt3VUiy7tWwNef7Nqp6netXUFJvG51MtFTzEyRIAimMQAkqBG0fOK+9X9HdqSoGOTbiRDRd34CYLzbPw6mGVkZcclBTZE6mJq81+pUSdaL78POG2tgwCAT2s5GZNZ84qntoxGRQuerY2r909aXQkaNRVCIBGPMNYMsn11UhHmmek4bGQ7E2e4zI8v0jd7AxNNfTgdV4LUMp+M7EG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whpXgHb3L2vnjvAswgfYBcFdzpZle9ljZCQ7L+G49do=;
 b=Gk5G7bYk99GsyBCZ525dAawbKkW1ageP7yfYHqydDG98iMIeJ/MBxm5rqp4LFsRaIbeZtk7ptosoURW5MLtiAdBgGp1vkQdz0ycGc4gbLRWllMBERoSIHGLq7726QBfE6dN4+Gn8PhpviMcBrk2MT4dxL5cTYQuRs3Pm0W9oEe3Xh0krThV9y7jea9whmXZ6wpHjMnkFDZ5RUyHj11eaA2MCU/ATDjru5oCcoZYqa43ob0OTIXOo5G+47rP143zcPpeFXzLxmlgnimX9MJsDrXbteT7WMPkDZjFNwfKEJtQt3KdR3Je9vhbym4yYfNBcHlERAC7ibJxDXk+KeSIgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whpXgHb3L2vnjvAswgfYBcFdzpZle9ljZCQ7L+G49do=;
 b=AMr2y4+aiY0X7iLuVNQy2ml370X96OhXtKhlqB+Rj1vuVfu3hHTq/n0kkSjqhVi6veyY/oe3fvUcQ2g9fAVSZPqKPQNMy1xjf8YzqqOdwGQIkXkoyY2bxPHWyJ4S0kXRvAeQxhEW3BegBFD8Ol/pY9sm0r83nHa4V0kLo7CKnXBHC8hSH1d6X4U7sSIH9Cjkn9z77auxNZF1+azeAa9BWpAcmyppOCyEOH4g/2FcKJNRa8hnfFmXsXxhWbLVtKUnvawG5nndjN629tTHpXkFFW3wjr16IuRmDaX3kGxbd8V2MakhauHVg7TjRLP3Z7wawCx200slo12ZbQuRnSI2kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by PAXP189MB1853.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:28a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 13:44:46 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 13:44:46 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH net v3] tipc: reject attaching bearer of different media to the same occupied device
Date: Thu,  1 Oct 2026 20:44:15 +0700
Message-ID: <20261001134432.49481-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:617::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4P189MB3750:EE_|PAXP189MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c9d875-248e-4a21-f5b2-08df1fc227b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	PcVUFszDY/Z9JX1RAatYZPWvZR+l6V4KlgQjWb/f/b1vMDZ4yw5hXaD3yAJ9+4hmO+j3Khi3UlpsEn/ADnCUhcTYlXa5dsB+FzAPzKsm5VX+du3IRtCuRJkN9XompmiKKVB+PlqmzYQj9xccWi3zlGiHYo/6JTMKdPrXUlrFlxbMice5vANhKR9NbuCqG7H8tSk6YNCItVOw/jNOxMyl5WesIRYnt+XvzJECSSZdxdvsCLE3TAgkVpoDQKFCfUQWcohA2qVGUvRs6zr/XKaAbso6VMAfgc/WprKG+LMk57OQyfoTmjgSvVpCpK/jx6lZLKNGGpdlzwzAf5w03J8xXCniLZoEsKyKbiJFmCVFR1ShDj2rEGF4HUahxeRGLso7zPc3P2+7h7TIJVtF8kUrEkeX4U+cJm9qY9cvWBbn1rTmfpoeZL1a5Ex6kInZ6HiQXdQ1edrfpF06mBJUdCufq7PyI0u1irxSRVhGYhGSzHccDUu/7ZnGCwYszwSdFFVuK0jJACPkPQ3tQlLzskF3tPHGnJc2uVeaFcvhhK7AlLNJyIuuLkgv4KDZSJgbZOf5MdNgvc3vj7gaZ/7jzn5qKxe9Ou2aHp5RKTDnLoOCTfjZir4bPHQ485NeXeW8NP9bFbrT9FlyBLqbZGJ1UL33iUzu7EHOwYdJWfSfm5kJZYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BrSM4dXx0/hS2LIJEX3LCHHr9v8OXriOuaRXatnIvqQpw/guB3q80WBHYTGY?=
 =?us-ascii?Q?1rqXhOmXRaM6kjwM47XFYHEtHafN89jizR2NwZ8nuPsnJDcUR8DUc8/++5cT?=
 =?us-ascii?Q?Hc/OgFCLn/Na+iPIcjDPuqOtBq1GEsxUk7I0zFC6//jCtdJdMz20207ED7PN?=
 =?us-ascii?Q?Upi+uXJFWXBjMHJcb88ZF1+FAeKwMtf/xrd00RzavjS2Savd2cT89qHVKgKq?=
 =?us-ascii?Q?hz37gjF4Qv6Y5Gbfio5wS3VLUVrTgCzXD9Mj4P5z+QecO5dk0YgJG7T6/BvP?=
 =?us-ascii?Q?+gZypmiZ6Lf7sTFO/axLo3cfmNp2zSH4RhP3tSfSUsYuZFrdCnkn5C104T/x?=
 =?us-ascii?Q?lY9fpRNHOpCtb4cycQP8+tZE6HGDbu2N+uU2OTEl5k1RkQdxsrGQ2Yz3b/zB?=
 =?us-ascii?Q?nV5xuZ8jvLZWtQi9dn6Ur3e+bl7IOEd7q4r42Ebj3sGVjSVDw9UYS4M91GLD?=
 =?us-ascii?Q?gjNVQ5QzG+qEJd/3+tbkpafM6V72hPpnv5WIjlnDP0p1KnFOjKuEEEfqA3/+?=
 =?us-ascii?Q?Zz83u2ZZaXOhuaUjMsi9N9l8YqFQFJuPClJEcCCrt+pO7e+kWlKCIKus9DPw?=
 =?us-ascii?Q?kj53maNS9lsSEkdzks7X5lmwwJi2qvPWiEqvzoulV+9L6m75V1uzzrDatmSA?=
 =?us-ascii?Q?An8xKRj8TLM/6cWVtjMitcGpWdoA3GPHmmevQtTaHwnHd3BoRJnob2IB7bR1?=
 =?us-ascii?Q?7+1O2/6n9ZqpW4t4uhN6zAFFfesnigaf9XWbeQ2vRUVRs4P/hITllJo2vCoE?=
 =?us-ascii?Q?mf4W2dNzOmANlyR9hYcb0kSHIhXkvDVC8cBawTTe1UACFUfuqOwy8dhjwABx?=
 =?us-ascii?Q?iXBasMPT34tZUlBCAtSgikIzJy5rE9mDb7/QecqPLzd5kbVCntRSZTzjhm3q?=
 =?us-ascii?Q?OGP0aAOjJQA+7kqqNQFjRxsdTvRaD4RXGteT5a0cbonWi2fe8XlZUBlqE1Q1?=
 =?us-ascii?Q?TAfPhSFxf6C2a1tbdCp498i/QdjAaXyN7w8KyW0KDAIAgJIA450sTF6nIC1u?=
 =?us-ascii?Q?Ide6E4nQgoMAaD2Pr+kPXd4aBmRr1uArOiFGdWEYAzvk4jbTceX779AmNrxd?=
 =?us-ascii?Q?pK20cyzbQLb2QeG+w6lnm+H5KaN+J72fmPczi77OeKe51oeEH67bEidQE86P?=
 =?us-ascii?Q?OPaJg0icbZjARQrAtK/L3CA9Rc1OLIN8EwNCP/DGgaEbmJYf7LucsIIcu23U?=
 =?us-ascii?Q?xo8e6RyrL25Reny4PEfGWkksUrDilIW55IO+2LC+WTvNbFO5StvSaLKgl7Rg?=
 =?us-ascii?Q?VdEijAlvE3TEyLp1u+bH7ak3NGczTp3utLG8eylY87c9xqaPfJ6A4NmDNm2l?=
 =?us-ascii?Q?+tlCjwFfQCvuWDYYHQR53CLosmkq8HAzdboLubh8TmUG225I4x42unmDwgHz?=
 =?us-ascii?Q?rpGqYsdgs6KWFXcvv2epTiJABqhPx02iJg84cwP8cwreRZdU4yQUvmFeEfoc?=
 =?us-ascii?Q?HB1zb/CklEln7UH0knOjzQidkxOqRudsUKWeGIlxOdpRePGxDdtcZJStPqat?=
 =?us-ascii?Q?l91JcgzafMLQb2nLvdmOee9y+dEixkDX+VncXoUp3Wc2cLR/CXsQn39ihbaX?=
 =?us-ascii?Q?gbFGAccWlp7ekf018EdDpi48QDtq0ICVLaiKCSgD1WILA/SuZzADAS2NaNMV?=
 =?us-ascii?Q?dxEW3LMZXA3Zt6tMB8HFtcVjlXZ1xCz044+h84RlvCmi6zkSh+G30baQz4KU?=
 =?us-ascii?Q?6iviU04ohFVby7m7o/ChFQ/zcznOFg/C2Gw3ZVG0WwRnlhnxYgYKMlXTmgjw?=
 =?us-ascii?Q?2N0adgxHPJszINgXte79knpQZp0uwwnwdQlUZn1gC3b4KdGI8kmUabCSU/ZI?=
X-MS-Exchange-AntiSpam-MessageData-1: TjmLs5Viu4nqHFOva7H4M4IaWJkKNRpALFY=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c9d875-248e-4a21-f5b2-08df1fc227b3
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:44:46.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeISmiGBWUo82cvfE+E6vCfPN0j4UXkc1w/nMNeCdAm5UFxc4e7pxGCF8Fj8Ua69xSUuIKlHP/XGopxCiNzdd8SlV+r9dOMYm8Z28R88Ry0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1853

Currently, two bearers of different media types can be added to the
same device (e.g., "eth:eth0" and "ib:eth0"). This causes a leak
in device->dev_refcnt as follows:

tipc_enable_l2_media()
 dev_get_by_name()
  dev_hold()

As a result, device->dev_refcnt is incremented twice, but the second
bearer replaces the first one.

Fix this by rejecting a bearer with a different media type when the
device is already occupied.

Fixes: cb30a63384bc ("tipc: refactor function tipc_enable_bearer()")
Reported-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Closes: http://lore.kernel.org/netdev/20260918013509.1853952-1-xujiakai24@mails.ucas.ac.cn/
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v3: Address alternative device name issue found by sashiko
v2: https://lore.kernel.org/netdev/20260924162016.1258485-1-tung.quang.nguyen@est.tech/
v1: https://lore.kernel.org/netdev/20260923091057.375981-1-tung.quang.nguyen@est.tech/

 net/tipc/bearer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..f480fffca843 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -285,17 +285,42 @@ static int tipc_enable_bearer(struct net *net, const char *name,
 	bearer_id = MAX_BEARERS;
 	i = MAX_BEARERS;
 	while (i-- != 0) {
+		struct net_device *dev1, *dev2;
+		char *if_name;
+
 		b = rtnl_dereference(tn->bearer_list[i]);
 		if (!b) {
 			bearer_id = i;
 			continue;
 		}
 		if (!strcmp(name, b->name)) {
+duplicate:
 			errstr = "already enabled";
 			NL_SET_ERR_MSG(extack, "Already enabled");
 			goto rejected;
 		}
 
+		/* udp media can be used together with any media */
+		if (b->media->type_id == TIPC_MEDIA_TYPE_UDP ||
+		    m->type_id == TIPC_MEDIA_TYPE_UDP)
+			goto priority;
+
+		if_name = strchr((const char *)b->name, ':') + 1;
+		dev1 = __dev_get_by_name(net, if_name);
+		dev2 = __dev_get_by_name(net, b_names.if_name);
+		if (dev1 == dev2) {
+			/* Not allow eth and ib to attach to the same device */
+			if (b->media != m) {
+				errstr = "same dev for different media";
+				NL_SET_ERR_MSG(extack,
+					       "Same dev for different media");
+				goto rejected;
+			} else {
+				goto duplicate;
+			}
+		}
+
+priority:
 		if (b->priority == prio &&
 		    (++with_this_prio > 2)) {
 			pr_warn("Bearer <%s>: already 2 bearers with priority %u\n",
-- 
2.43.0

