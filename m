Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6813911C1
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856265; cv=none; b=QHjGAFQfPoVwuReLwML8x/HhMjQgQFCrTHuCgM9NBdm3jBjUH9ipZnaPQxkr0eF9NAMfTG5j24CvtkfKwNM0xha1riERkqS1U2b2cfiTQo00X3SiT2pJCOecnoZ0OHQeh6d/4fo0JgddJkHCXHbDk/enpFqCpT45YNl5KXFavN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856265; c=relaxed/simple;
	bh=hnfvSXlQm0H4LxGfOJPKpiwmvKO3zvxJVZsdPHu3oY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCn/i3rNWT5YMR8xEAv9Ny/L4JRNvb/ZLi24ON7k8fNE57H/NgEePS4solsVSQqE9uhBzqUgqhGbXHbXBj3hlAmKqUGYm6NZyBYgcFu0pJTLhvqZgv6Jnh2FyQCPM7rAbv1vBksTawtGJPkbreuGDQhAQjNxsRVNvdKpmTCyAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKZE0TZA; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKZE0TZA"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so1285898a91.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856258; x=1790461058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sIPd6MKwiqO1KHtDcJOHCxhNbUyXr9QmbbtW99agFhc=;
        b=kKZE0TZAw9b+wzKn8AtdWqO57+JO18j1O5dShEufghGDHqgBRvRxiTgaF+rPcfTHBL
         mfGWOQJzF5dGJ2fi8o94oNBpyXjO16XhEM9sH7SUFwxlCpNZdBEGAMVJz/WshmjVNkr6
         KeEFjLH+g43m/D4Gg81zij8Tf3fJhoGeCcq08j12hMV9paxtrno2kw5WZvIQhjwRgWgx
         UZCrpF2NcJEI3OuZ4drc7UuM22OqRGbSSOPMsa7SxmZAhvO/zpNx+THfqU59gjdhmQWE
         tB7QPqXJ6vPF8BUYYkuPMmVYMKrDPRDMc+bzpfPWDFMhOOITrncS4dl54wDzAmjvF5/O
         x8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856258; x=1790461058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sIPd6MKwiqO1KHtDcJOHCxhNbUyXr9QmbbtW99agFhc=;
        b=ROBa2XMhA4fgDoiE2LAVtGmc8LcWQm3WB7mf9bJqQOmMnmVVZOCCmX5UWDqg5aAtlw
         IR8ZReMH78sb+3HEnl976uWm01DBu0pvMLKETmpXKX24/bOAzxt0DmxUSU1ViZI8CBE3
         r6tK3y9EOlCPkzhIypTo49cixEsMnEgyP6X82huClFCoWAM+HuJek5YQDi6ZTiJga44O
         HVUkvwpU5P0c73ofCnOQpqRMP3ZmE4gCkoSCirRlVN3WyMSODJDpwwfBbFw6sz7BxSy/
         0y+RJszjkGHv0JI+vDmdaWaePwbufUWDNGfmbtuLRmhE0s+BtfPnxJp/3l2+kuhhbvDH
         4LSQ==
X-Gm-Message-State: AFuF++nPbsBuAGYxSWQZk+gxi8Ax7/zMs5uumFeFYgBDfWw0ngCRs7sL
	m5gFbvfi1YEgd/B/7kXJOeCV+7jnaJzGpDtoer/UJcq26Lsm9c6aQk/1
X-Gm-Gg: AYBFou2vbXSu4rC/0Q6TNnaVLIRRwBTuPoYn6YKmlMFvVzxXBWwbbm+XeuxbjnFa3kU
	OU/sxJO6VLNP9gAzARf1KWt/5dTlB3SQ1yisg6hc5BzPEIaFsTEXdth+HgWbKfX0X/smioSOpjS
	jD80cnR4Mwb+4Qn7cmCMc6F/vTc2bcP8Y/IribxuCXpGY/ymNibWzPypDLhZIBwysujZCP7aNEU
	L/H8YunUHJudtwrTi6VmUhncl/1uGoMjUlrm6lxv45pDPLJ5Xz+Ug0kaAr0WzfaEK8Rb/PeR91w
	NFtAuxvmOMhfo4wofUmn6sItIn1lLboOMpE44WCt2Rv4fJs/M5qe2csE3GUfMk/x61jIds/18Hh
	sNzty2swWDuhW0a/iJ22Mf7hgJPDBG076csCQ527uV2/Zg8VZkMOAVTAl1IyYBYBMLQkPZq8OSK
	Uzo1fJxCEnO4WMWxwQ7qP5eN1We4xX0fhMUjsIbpVQ1YmlEN3corl8ka1Y+tsVK2jFE+ZC1mBkd
	kLIyQYJz3DdZqneBxJvMO4eSDJr7hJyYx4Ma1XsHP5qmnlLBrkL6A3IC+rePeE+WyyQMTOd3AG4
	3Z374AVmQYhmKvFki8Zu
X-Received: by 2002:a17:90b:3fcc:b0:39e:4c81:6c61 with SMTP id 98e67ed59e1d1-39e54d54a6amr12357036a91.28.1789856258131;
        Sat, 19 Sep 2026 15:17:38 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c379c4bsm6632934a91.7.2026.09.19.15.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:17:37 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipmr: validate IPv4 header length in reg_vif_xmit() and zero iphdr in ipmr_get_route()
Date: Sat, 19 Sep 2026 22:17:37 +0000
Message-ID: <20260919221737.3708462-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two bugs in IPv4 multicast routing:

1. In reg_vif_xmit() (net/ipv4/ipmr.c), verify that the skb contains a
   full IPv4 header with ihl >= 5 before reading ip_hdr(skb) and passing
   the encapsulated PIM register packet to ipmr_cache_report().
2. In ipmr_get_route() and inet_rtm_getroute() (net/ipv4/route.c), zero-
   initialize the synthetic IPv4 header pushed onto the RTM_GETROUTE
   probe skb so uninitialized slab bytes in iph->ihl / iph->tos /
   iph->frag_off do not corrupt fib_multipath_hash() or
   ipmr_cache_alloc().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b9c544d48c45..8242ab62d1b3 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -545,6 +545,13 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
 		return err;
 	}
 
+	if (!pskb_may_pull(skb, sizeof(struct iphdr))) {
+		DEV_STATS_INC(dev, tx_dropped);
+		rcu_read_unlock();
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 	DEV_STATS_INC(dev, tx_packets);
 
@@ -2492,6 +2499,7 @@ int ipmr_get_route(struct net *net, struct sk_buff *skb,
 		skb_push(skb2, sizeof(struct iphdr));
 		skb_reset_network_header(skb2);
 		iph = ip_hdr(skb2);
+		memset(iph, 0, sizeof(*iph));
 		iph->ihl = sizeof(struct iphdr) >> 2;
 		iph->saddr = saddr;
 		iph->daddr = daddr;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 37674d76f90f..1cba70e38507 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3087,8 +3087,10 @@ static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 							 r, portid);
 
 				if (err <= 0) {
-					if (err == 0)
+					if (err == 0) {
+						nlmsg_end(skb, nlh);
 						return 0;
+					}
 					goto nla_put_failure;
 				}
 			} else
