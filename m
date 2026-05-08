Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A38415539A
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778215042; cv=none; b=TZi16W+7rffe/1J6mA/IX2D5QMwbX1o/8XsCpHIP7rM+X+CpGF5rHAAkUsFLZAaaoaGb1G3DvMZ5BNhJ09qmnJWHzWEIFa+LJOyUSQgWf/15cKaBbJdXJD/cPazKJHzq9GYvkg1ex0CSTccHiKbiuMGGnJlh4A94LUKBs/D8K3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778215042; c=relaxed/simple;
	bh=5frOUZ5UqGVTaqdCTNubY/Zpz6V9myJkFEzJbKyGWcs=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=oDIGrtmosjjKSXdD9n5lSJ3Q3wzXHdZ17OPDvleC+K47M/aNisuG6yp0nQX9tKMVO1j8lHlcMQJ2vUxDPSSGKFdKTmP1gGXvNUlUpjAPgSvpLF+srWLk0C5fwO/XGDPj+yAin+R8os/IYPYfHNtRFZEXxQuxZJGVSfjjpsRlXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gBbtt5YMnz8Xs76
	for <netdev@vger.kernel.org>; Fri, 08 May 2026 12:37:10 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gBbth6K4Nz51STW;
	Fri, 08 May 2026 12:37:00 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6484auJF036705;
	Fri, 8 May 2026 12:36:56 +0800 (+08)
	(envelope-from qiu.yutan@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 8 May 2026 12:36:58 +0800 (CST)
X-Zmail-TransId: 2af969fd686af38-1a951
X-Mailer: Zmail v1.0
Message-ID: <20260508123658284jP1rw367XHYK3zUmmM2ff@zte.com.cn>
Date: Fri, 8 May 2026 12:36:58 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <qiu.yutan@zte.com.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <dsahern@kernel.org>,
        <netdev@vger.kernel.org>
Cc: <yang.chuan1@zte.com.cn>, <huang.jian@zte.com.cn>,
        <zhou.shizhen@zte.com.cn>, <zhang.dongyu1@zte.com.cn>,
        <ye.guojin@zte.com.cn>, <yang.wei20@zte.com.cn>,
        <zhang.lin16@zte.com.cn>, <li.hao40@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG5ldDogbmVpZ2g6IFJlbmFtZSBORUlHSF9WQVJfSU5URVJWQUxfUFJPQkVfVElNRV9NUyB0bwogTkVJR0hfVkFSX0lOVEVSVkFMX1BST0JFX1RJTUU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6484auJF036705
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: qiu.yutan@zte.com.cn
X-SPF: None
X-SOURCE-IP: 192.168.251.13 unknown Fri, 08 May 2026 12:37:10 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69FD6876.000/4gBbtt5YMnz8Xs76

From: Qiu Yutan <qiu.yutan@zte.com.cn>

During the initialization of arp_tbl, the enumeration constant name
NEIGH_VAR_INTERVAL_PROBE_TIME_MS in the statement
arp_tbl.parms.data[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5*HZ does not
align with its actual meaning (jiffies).

Using NEIGH_VAR_INTERVAL_PROBE_TIME is a better naming choice.

Fixes: bf48c3fae6d7 ("Merge branch 'net-neigh-introduce-interval_probe_time-for-periodic-probe'")
Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
---
 include/net/neighbour.h | 2 +-
 net/core/neighbour.c    | 8 ++++----
 net/ipv4/arp.c          | 2 +-
 net/ipv6/ndisc.c        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 2dfee6d4258a..f317e910ec3c 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -49,7 +49,7 @@ enum {
 	NEIGH_VAR_RETRANS_TIME,
 	NEIGH_VAR_BASE_REACHABLE_TIME,
 	NEIGH_VAR_DELAY_PROBE_TIME,
-	NEIGH_VAR_INTERVAL_PROBE_TIME_MS,
+	NEIGH_VAR_INTERVAL_PROBE_TIME,
 	NEIGH_VAR_GC_STALETIME,
 	NEIGH_VAR_QUEUE_LEN_BYTES,
 	NEIGH_VAR_PROXY_QLEN,
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 9e12524b67fa..912e6ca3b26e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1670,7 +1670,7 @@ static void neigh_managed_work(struct work_struct *work)
 	list_for_each_entry(neigh, &tbl->managed_list, managed_list)
 		neigh_event_send_probe(neigh, NULL, false);
 	queue_delayed_work(system_power_efficient_wq, &tbl->managed_work,
-			   NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME_MS));
+			   NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME));
 	spin_unlock_bh(&tbl->lock);
 }

@@ -2235,7 +2235,7 @@ static int neightbl_fill_parms(struct sk_buff *skb, struct neigh_parms *parms)
 	    nla_put_msecs(skb, NDTPA_LOCKTIME,
 			  NEIGH_VAR(parms, LOCKTIME), NDTPA_PAD) ||
 	    nla_put_msecs(skb, NDTPA_INTERVAL_PROBE_TIME_MS,
-			  NEIGH_VAR(parms, INTERVAL_PROBE_TIME_MS), NDTPA_PAD))
+			  NEIGH_VAR(parms, INTERVAL_PROBE_TIME), NDTPA_PAD))
 		goto nla_put_failure;
 	return nla_nest_end(skb, nest);

@@ -2508,7 +2508,7 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 				call_netevent_notifiers(NETEVENT_DELAY_PROBE_TIME_UPDATE, p);
 				break;
 			case NDTPA_INTERVAL_PROBE_TIME_MS:
-				NEIGH_VAR_SET(p, INTERVAL_PROBE_TIME_MS,
+				NEIGH_VAR_SET(p, INTERVAL_PROBE_TIME,
 					      nla_get_msecs(tbp[i]));
 				break;
 			case NDTPA_RETRANS_TIME:
@@ -3804,7 +3804,7 @@ static struct neigh_sysctl_table {
 		NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(RETRANS_TIME, "retrans_time"),
 		NEIGH_SYSCTL_JIFFIES_ENTRY(BASE_REACHABLE_TIME, "base_reachable_time"),
 		NEIGH_SYSCTL_JIFFIES_ENTRY(DELAY_PROBE_TIME, "delay_first_probe_time"),
-		NEIGH_SYSCTL_MS_JIFFIES_POSITIVE_ENTRY(INTERVAL_PROBE_TIME_MS,
+		NEIGH_SYSCTL_MS_JIFFIES_POSITIVE_ENTRY(INTERVAL_PROBE_TIME,
 						       "interval_probe_time_ms"),
 		NEIGH_SYSCTL_JIFFIES_ENTRY(GC_STALETIME, "gc_stale_time"),
 		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(QUEUE_LEN_BYTES, "unres_qlen_bytes"),
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 51d70180e1cc..601b98185cf5 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -169,7 +169,7 @@ struct neigh_table arp_tbl = {
 			[NEIGH_VAR_RETRANS_TIME] = 1 * HZ,
 			[NEIGH_VAR_BASE_REACHABLE_TIME] = 30 * HZ,
 			[NEIGH_VAR_DELAY_PROBE_TIME] = 5 * HZ,
-			[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5 * HZ,
+			[NEIGH_VAR_INTERVAL_PROBE_TIME] = 5 * HZ,
 			[NEIGH_VAR_GC_STALETIME] = 60 * HZ,
 			[NEIGH_VAR_QUEUE_LEN_BYTES] = SK_WMEM_DEFAULT,
 			[NEIGH_VAR_PROXY_QLEN] = 64,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index e7ad13c5bd26..ca7df107e3bf 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -128,7 +128,7 @@ struct neigh_table nd_tbl = {
 			[NEIGH_VAR_RETRANS_TIME] = ND_RETRANS_TIMER,
 			[NEIGH_VAR_BASE_REACHABLE_TIME] = ND_REACHABLE_TIME,
 			[NEIGH_VAR_DELAY_PROBE_TIME] = 5 * HZ,
-			[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5 * HZ,
+			[NEIGH_VAR_INTERVAL_PROBE_TIME] = 5 * HZ,
 			[NEIGH_VAR_GC_STALETIME] = 60 * HZ,
 			[NEIGH_VAR_QUEUE_LEN_BYTES] = SK_WMEM_DEFAULT,
 			[NEIGH_VAR_PROXY_QLEN] = 64,
-- 
2.25.1
