Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4937475D
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381447; cv=none; b=c/CZbg3A0VxxvCOP9xC1aHERJA+xjJxFvvAWJSEHnOvfyjUTwZL1Eib/Cm5d7rra9A/Jgfl34xSiaE/lzLk4qAAyT9L42wqGX63VcixzRutJHXsUxedmqcJ6Q4hR44A0vc4dE/w2ZBOUOKd1maz3XUMaqBUvPlX1STvYCRKLfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381447; c=relaxed/simple;
	bh=1iI2qNUGWESVt6zMqTZu3USM6BuyGG863S2nQD7khfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uS/WDmidCeuzlnObU95pPoMThLT8UbkBcOhJid/YkArXTjlN48f9M0KW56DKD19rk3u/1SkGueC8E/2gOvbBiVjPg8cBfJ5O0n/7euURrwGBMB0eaAyJ/pNCa9dbVH6gs8eRX0npwSjXYtefCLxa5r/SWQJcx0PPxAS5xTjimTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=e7YxSPAu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="e7YxSPAu"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c5382806fso16249731cf.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 20:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785381443; x=1785986243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lawFeYPo6BCltKTZ9+d/IYGmzDr01K26lhBILllK1d0=;
        b=e7YxSPAuePsTYWXzyCXaUBljTZxOmd4UWlCPd3YwtdOBYI/aIKTo98rB8rlMaHB8RI
         9Y/K1JfKE2Nu8R5gMn2yMznU85a0mw573QNb0LYEBnBxIzpfgFpsXfu4LJRuAxbXFPm9
         fdC1S6jhG4BXdQZdFrB+jbcoq7yK/ADVYIL3+mtUNPE2RNdb21E/WReGwcXU2JZe/SeB
         Xs/2DzR5XtBczX+MY7s19p4W9AsqE882pzaCsLJeOovjaNCqK4OnOEqN6D/AUVI/WONA
         fvbs8crkn7sHnIXIaA9es8sg/geaNCgAg8HXUFDAjNrYNyNJTQiwOY2qXzbKSlexn5Gp
         Yspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785381443; x=1785986243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lawFeYPo6BCltKTZ9+d/IYGmzDr01K26lhBILllK1d0=;
        b=pp00gq5hiSJMy67sOLfDyCb20zBIKvnfq4xw9YRxy/MR627FCW88FC3f5epHx+uDWN
         CXbXeu+JA7eUT84/k9F0PDNfwPoN6rgf0j/rzDuLazN/DLKMVfJmN0ZOe1BzaSf85eMK
         H+LqsSRZmNZuKWSNDU+r6rC5dANyGOCEd/BnYJsxkXU4iiX/t6icnBqoa0l0FB/sVcyn
         c1eNqSS5YTrcXdMhCjX2buCDu4fGshxvxt8xW5SXcS+bWN0e4IhP1Q1mLR6RyRJg9rs2
         t9E0ewOJ5Z3Au7+C3Kmf+uUHxQYtyhekhm6984RotG13pSgoakiPIAqNjO/0jWFXP/9D
         rL7g==
X-Gm-Message-State: AOJu0YwLMNITgcb+UaT1W0WH3ialYHqD63R3FMK0NZu5mw9E1WlfKjiH
	caJelIswc2McxKW3GMUI/E37J6tfJ77pktPVHp+wt+Vpc4BEWanb4zWyBdWY4YDkQiFa4x4Sv3P
	luuaOWMQ/M08=
X-Gm-Gg: AR+sD10RxjqA86f/ceLew+NK2bkr4T9KUI8QK56YHrtQIx2kuF/I4gVAhltLQvRLL4p
	CKoQ6B6Bl1OqHGytJqvxozfQGeuuot3lSC+L1CV6IJdExC/+MYzsquwMqBK+AKShbPlQQsaYZTU
	wkpzyJmfJ0+tlAZpzMgPd3M6r1c5P8W4ZbJXyvvyQENxJmUROWoyYHWRGuB5bNZ1Np9nDgWrqWq
	+6S3WpD8NAe1OmxbGIjxXU2UUL+0prrWDkTk5orRg1OY/eKraFhsxA/6MOioooSKXbokTiNEk29
	PjyoE1+JaN6BWS+JxoUFDVaV/FKJeU3P0KdDDjMEvmL9fkpXneT7eCRkYsThqgo3O4sC9Fj7j9v
	MBgjswui05xFhDnHrw4+n29IWHl8Ku9m1p6cinaEd3dIwaRpjs+pmm4YBt+B4HBO+TiFsuxsb3e
	9N/V7SH6tzAl0BH+DiEwuDqguDrmsDXSv3UbQCaum3J9A7niCy+lAQLkNcQonUr6YiHYHH2voqh
	nqZnii5u5GVMX7r
X-Received: by 2002:a05:622a:4d04:b0:516:d83c:edb6 with SMTP id d75a77b69052e-52b38378bc5mr12179731cf.12.1785381442562;
        Wed, 29 Jul 2026 20:17:22 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b54941sm32069081cf.8.2026.07.29.20.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 20:17:21 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	leone4fernando@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] ipmr: only copy pktinfo to cache reports
Date: Thu, 30 Jul 2026 11:17:07 +0800
Message-ID: <1b809975e5bd9c0a1dd6fdd1db534e701fe5a4b6.1785379072.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipmr_cache_report() builds reports for mrouted from a packet that may be a
synthetic RTM_GETROUTE query. That query skb stores the netlink requester
portid in NETLINK_CB(), but the report is delivered to a raw IPv4 socket,
whose receive path interprets skb->cb as IPCB().

Commit bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP
msg") added IP_PKTINFO support by calling ipv4_pktinfo_prepare() on the
original packet and then copying the entire 48-byte skb control block to
the report skb. For synthetic route-query packets, this copies
NETLINK_CB() bytes into IPCB() and lets a controlled portid corrupt
IPCB(skb)->opt. With IP_RECVOPTS or IP_RETOPTS enabled, the raw socket
receive path can then copy past the short report packet or overflow the
stack option buffer.

Keep the IP_PKTINFO support, but initialize the report skb control buffer
and copy only the pktinfo fields prepared by ipv4_pktinfo_prepare(). Do
this in the common path so both short reports and whole-packet reports are
covered.

This removes the accidental IP_RECVOPTS/IP_RETOPTS behavior on the
mrouted socket, but that behavior was only a side effect of copying the
entire control block and was never intended to work for these reports.

Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- reword the commit message to say the entire 48-byte skb control block is copied
- mention that IP_RECVOPTS/IP_RETOPTS on the mrouted socket was never intended
- move the pktinfo copy to the common path so both report branches are covered
- v1 Link: https://lore.kernel.org/all/5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai/

 net/ipv4/ipmr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fcef..4827973c6f9c0 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1058,6 +1058,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
 	const int ihl = ip_hdrlen(pkt);
+	struct in_pktinfo *info;
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
 	struct igmpmsg *msg;
@@ -1112,8 +1113,6 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
@@ -1124,6 +1123,12 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		skb->transport_header = skb->network_header;
 	}
 
+	ipv4_pktinfo_prepare(mroute_sk, pkt, false);
+	memset(skb->cb, 0, sizeof(skb->cb));
+	info = PKTINFO_SKB_CB(skb);
+	info->ipi_ifindex = PKTINFO_SKB_CB(pkt)->ipi_ifindex;
+	info->ipi_spec_dst = PKTINFO_SKB_CB(pkt)->ipi_spec_dst;
+
 	igmpmsg_netlink_event(mrt, skb);
 
 	/* Deliver to mrouted */
-- 
2.43.0
