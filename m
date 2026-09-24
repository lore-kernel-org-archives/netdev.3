Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD193B0AE2
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266828; cv=fail; b=Jvap0aKH1A+8GlNoLWKieLGAEgdRxUi4JarZaw5eDZknjNWmUkbYzXkgciRFB3A5UvX3ZE7nzk/GPxk6DQWMuSlF7Ed6BkpCQ3MlgjycCGiFEcGgSM/Zvbaa8kiynjOT+E45qTdItkhBT0T3fMBT/sAEIZ3X9kNFlUKnUkTd4Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266828; c=relaxed/simple;
	bh=VFJla25z4WSfm81v7Y6xB7LlnQFFeemdVcW+tY6kqiI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Frw6qrEzu3Ddrn7yPrcRVI5j97XwJkmZqZuAdTLhVC+N0oeB14KI1z43zhS0kCfDBy1AVkVoDFTScFOWC+FTVfYYHBN2jOpS8tlF2bl75+BvM8IXCXKk85vQ5izwDKAOtjsCHXvzN+G3YTETmgqBhPahwWn9JUNnzu1OWEzkmFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=gkNYmLpP; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="gkNYmLpP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3aw/NeTJ+LrONRd6LonBGYlm7IjoUDbQLRrAfOO3NYv1TSJUMokNN1Xkk0qLFBlDB9v1DbXQmQL9h0APEhGZqI3B38ZoRVbC70fW3i3px5PkMVFUOFEZLBDQt7CN0Jw96A3kFIv44wUcYsRINcrLnPqx9ER1k7UyXB4CzOBXSiTFIo7ruWgdiy/JcNlYuNwKFpyeg0xVmD+SZYkUDicFPFH7BS+uzoZld/CDuXag7l5BZcU7SdPJvxyeaHR9w0hRjz4tyDs6WLXQ2mDqinv74pUn0Ir34ZpnTpQVXKVNRgbUnvBfTMG8RKfrxvAQxCgbPDaA3u8fNj8Jg1Zvnu86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMHwUGnH+n42lEam8DLFtrMdkJ2YslXavp0lTqIYMtY=;
 b=ss1TLVj4tBLgkvfZ0y5ceJNIe3MAviM9hKN9MFLZc8vhaPeTwyfHn+ZNUGHrr8kxR1qL1zHx5ptTBHhUz61RiwNdeqQQHaUk0r7UnLbDY01PHpFVDHmov7u07u5xWWcs7NijVRaHnAOSqsXog+2A3mNWIMMTMfp9xAl32IpoucLxFQaJl/xkJLptieG2FjPKRY+DO5A6Qx/oiHIF+H7HhG2rtsI1cNmRw9XZzV4Dnpu5NylDI59HNWUcYyECSOZTcFS2iMWKOzbDWXh3B1katpBoQIUfBlC+W/zmE4394mehO8ZFINMYwEzYmb8C5Fln/aVAVkC6LwuWKRoALQamdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMHwUGnH+n42lEam8DLFtrMdkJ2YslXavp0lTqIYMtY=;
 b=gkNYmLpPt5ZK2TeWzKbifXWt/5wAOYmdhnYVaj1V9/aZQc0QONSZQvLQAaOJwocB6wAwjeOfbR66mj+bjNQorjN4u/WOSMw4zErFfnwPp1ETimFLcfMlGbzVcWYt7o0Xykq7jE9OC+m1gHcqLFjy7WAGzBggXcf07sy2IbbNnaLLU1HSSMASKkZVgtGTe79AsgaIrFKbmPCwh2Re9LFSnUsa4Yyiy6sOrQhaCHFGhaGq603BLrk+eEX8HfM/L8duSB0MmxO3fNQ6vgD6Vt7vLmQrpYDcB0VZkOXnJ4lVa07HRIbCgST2V1judPUDRKKrReAkSR/dXbo25y6W6La5PA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by PA1P189MB3628.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 16:20:23 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 16:20:23 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH net v2] tipc: reject attaching bearer of different media to the same occupied device
Date: Thu, 24 Sep 2026 23:19:32 +0700
Message-ID: <20260924162016.1258485-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:617::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4P189MB3750:EE_|PA1P189MB3628:EE_
X-MS-Office365-Filtering-Correlation-Id: 463b5c5b-1142-43e0-8726-08df1a57bc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|366016|1800799024|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	KYkg3mn6F+pHj2Jh+ZW2QAK0pHb116AimPSclOo0ZC15dQnmqS61KmdUbhQrh+D7OTSL6JcictRUzcNuZWTflBdMGnV9I0RMX6mAdPKesfAbG0fbQB/kkINayhcH56kdgn3Q6ibFI7xZChFo3wOIusmE82Eh45XV1L34oaelsY0FScXeTn2wvY6CPegjsKwSN809kyWOfc8chguawUZgO3u3uzgE6IvRWsLUMw0fLwT+MoPVIvbwEo8p1tsfsKaffG4vwCb5Oe/7kPIhm7fyNfONjIQSWShx/RTStjkBL5PMW4kjlfnENqQbXTY7z1kTCDKHXsmKucooKaCrT3TFE7RWPSs/uVqZj4pPtHLs/U2tBzDnN6GWxizm+eNxjUjTi28PX7sks4kjBlYRru1cRhB56BGNKasFsohmi/iF5Oi/libTJiekArSGR2pi9MU2x8NDtzuGl92SgJAbIQEfJfiJ2C4lL3TSPDhsqpyn5rxqpwSGVxWHQcT2ZaG56YwAquLCxqonuiuVNzK5EO3gnEfsE5u3nAgpBB7YTsptWPHvygSpeGjFKMDnylvjGNjGCg8RsKgqF6o/w9ui+N7AOKvEwIhfrSICf8XFaswNwie7rWmrPj9vBEDYI1sSpdCNkyzmTp4atpHMzO5P36VE69TWo+CtHOoh0AIRlAqsVH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(366016)(1800799024)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YTMc237m86Z86ZlWyytJG2+tEegnCp3BJbjE2Jc0bGXn4dpKR+yDOTQSrduW?=
 =?us-ascii?Q?dTVrCPrm6mUoq/V7GeHjBS/ZdZn4ENSw5ZCKKVUx+RUOy0qY9rwj1djSpjMh?=
 =?us-ascii?Q?kCke6swkm4T+3wVHG3QzJjsxHtEBF6X7zCFUJTAol784yw2L0z0DUv46Bsxk?=
 =?us-ascii?Q?UW08DNc3/f0shWySY/wzn1LNhELtVimIN+aa/uxEF2k72nciwRLNcacOMyya?=
 =?us-ascii?Q?UJ4cgJ30ETeCbE4N/q2zi+4BHxmxVEWSZ+IRUVRGHQhZPPkWzznqPqulpaAE?=
 =?us-ascii?Q?UCPVEEn2IBaunOkJX55tXJSgRxpDbEOq+T/PtzmdZ2HU/5a72/ZI5ndWSWSk?=
 =?us-ascii?Q?527p2gkF9ckJw66PJLUJDlo3YfHgqY4JjzUw9p2Mez+flo3SmRZqPkrC5ZGw?=
 =?us-ascii?Q?hiMwofYkISHfUE4KhZedCcWVyUVb0MR5hW8oc0K4kQv54xFh6yRy+WD2+Dv9?=
 =?us-ascii?Q?IRdwl9On7zsswRQElmzP3lGuHYscFPeS1Fb+WbvxwkZDZ4LgY8VXeGMuV5bv?=
 =?us-ascii?Q?Vl1N48BmbABARNG/rwfSNW68iga6eGUYkG1sRJCU4SjyYpqV7aC4G8VCA6N9?=
 =?us-ascii?Q?20UUzKhtW7rH4xNrnhobTRKep94DO9AV2fRGvhjtKNxa8YhszS0FVRDxE9cG?=
 =?us-ascii?Q?g4WwYdCDJ+TKG+PVA+Y6QSE2fuEtalSbHt7o/PIj2eq0/QxWXsIvzR8gwzGe?=
 =?us-ascii?Q?EI5vL5lesncgHQM+aYzPzYUK7PfaJ8vpc86A8MCbd2J84UQydewUmVRP4fjQ?=
 =?us-ascii?Q?yQ1qOmTAvgXluJlKmkr+K/LjTNN7j4wQIRqHRA5WVLf7D4gzctl3aDEGRyNz?=
 =?us-ascii?Q?CclUcqrWz7z1/EnwbrwBbzWbuYIdyyPHniGCcgg4/4+5CzK87LQ/vCkKuzRE?=
 =?us-ascii?Q?TGx0TB1/jyvxM2SFWWq9bDsCcGldBcYTZrJHPjLkqUj/s6DPUX8hgJv/y04I?=
 =?us-ascii?Q?0TABougmvbW5wZxolaPf7PD+LXi/XmkNx0lsMPtKHZ2pmt4E8AAWnVMNqQUq?=
 =?us-ascii?Q?Tvz+aqa8bHzTMx5rAw6D8VuYost3WU5KtR/Cx7fXOtxjRfUmd9lWt+3XxntN?=
 =?us-ascii?Q?ZlHc9Tdp8LGblweel0paZIaUeURLkm3NAEq7oj01oWPG8Tf/ll26e65q/rHp?=
 =?us-ascii?Q?PEL+eIKX+xdqy5gpAo26bBaTMa691Bw/HJb4KPNYO0uRbIwz3Tk1Y9rGB9TJ?=
 =?us-ascii?Q?GQjYl19xqOmfx94CApHsT02vTuE56oZMrdTBmAVsQZUvQee6CGBmqd6nXdbL?=
 =?us-ascii?Q?JqFkkPeGS7A/YABGTOKok0BVZGMFZPGy8pLhOFYQxW1AnRsDYWDxKnyBJDiT?=
 =?us-ascii?Q?Vb9fnOPs2AbUHGSIcCOh1v/S8pHNRzL8CWnbfYlJsclVdQPYz3AW9r1vQhk5?=
 =?us-ascii?Q?7Rq6/LKWKNNV1yZkPYqMJxGy21EoI4yA5IYrNbrJk7oUw1W689N5vBe+SFzI?=
 =?us-ascii?Q?zvsju4yllLxjJ/s4K78ceFhbhgn2QEcd5cfA5ibRz0pWyULmfLWlaOtuPcrb?=
 =?us-ascii?Q?AA54Y8SZysEfW8Zq/0aNQdRIetM89xRxSZUlMTU9vR9OWdaYVH78c+6JVi9I?=
 =?us-ascii?Q?nNo8YcxB6R4IsK9i1PFPvBHxnJ+BXgAxc0BJTryFiTT+WJRLt3ipNqjd5K4Y?=
 =?us-ascii?Q?BJWib7q9spyKalWsEuKOk6IRugT4Ofly25QW/dB3feVIMWzQOABjCthEPpOg?=
 =?us-ascii?Q?zIv7nNboyrN3rHsfwWLGPHruivPl4U6vRz40ELaTqHm5zxlEK/JLJA06jZVZ?=
 =?us-ascii?Q?v4S7YMSW25gIzuBKIIiSSzlsuGOZV+KIiprlznMTU15CA/9cIp63asYVZ5H+?=
X-MS-Exchange-AntiSpam-MessageData-1: +GBSzZg96cOXbJqbm09T+h15rmSItmDahpA=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 463b5c5b-1142-43e0-8726-08df1a57bc2b
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 16:20:23.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6rOPbC0C+V+eDQjueOuru2F/kOuGdiE9DZ4q5GyWafe7K5tydHfFhDUO58TeBtmxr+MAYWtPa07v+rbfO5A1dP6Wmt+3ituvYVrqM4O1Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3628

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
v2: only disallow eth and ib to attach to the same device. This avoids
breaking udp-eth or udp-ib combination on the same device as found by sashiko.

v1: https://lore.kernel.org/netdev/20260923091057.375981-1-tung.quang.nguyen@est.tech/

 net/tipc/bearer.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..2c0ceee4aa6b 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -258,6 +258,7 @@ static int tipc_enable_bearer(struct net *net, const char *name,
 	int bearer_id = 0;
 	int res = -EINVAL;
 	char *errstr = "";
+	char *if_name;
 	u32 i;
 
 	if (!bearer_name_validate(name, &b_names)) {
@@ -296,6 +297,21 @@ static int tipc_enable_bearer(struct net *net, const char *name,
 			goto rejected;
 		}
 
+		if (b->media->type_id == TIPC_MEDIA_TYPE_UDP ||
+		    !strcmp(b_names.media_name, "udp"))
+			goto priority;
+
+		/* Not allow eth and ib to attach to the same device */
+		if_name = strchr((const char *)b->name, ':') + 1;
+		if (!strcmp(if_name, b_names.if_name) &&
+		    strcmp(b->media->name, b_names.media_name)) {
+			errstr = "same device for different media";
+			NL_SET_ERR_MSG(extack,
+				       "Same device for different media");
+			goto rejected;
+		}
+
+priority:
 		if (b->priority == prio &&
 		    (++with_this_prio > 2)) {
 			pr_warn("Bearer <%s>: already 2 bearers with priority %u\n",
-- 
2.43.0

