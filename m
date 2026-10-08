Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6E4E3224
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473320; cv=none; b=DxhZQlDa7vFLBN+43873w3YuTiLrkgd8zJa+gQe8LNvsrqYmxwOdOSlSU4QxgPSTNwDeQs6EwLIWVXof8Yv/Ko8/SGlOyhWxGmRQmB1kVSiSAvybe9foQoXT4CGxWQODMq6bzchQvG79lQaXXjkw0pcTkbO6r63v3DmB7wSLXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473320; c=relaxed/simple;
	bh=+UBh+TGDDzPRlUk875cyDGYcNpfWKRAyNSP8vlb/LMg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RjkTgOMqZTndLa2fx15mZVXXUv5RXnLAeLDOCDCoNZCtHwJSPZDAH+56K/N8sMGjxcqi1ZRCA5SPSLZvIRDaGJSEPBSn0B768IblMgoVroL1gHmqoGIuL2ighxdzV0VOZY20BRVDjgbgbKpsMPNBHYkHu5pltTVX54tdxCBakB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv8LGGTS; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv8LGGTS"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-47b47de8b4cso1730193fac.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473315; x=1792078115; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N08OobCMo//vTBI14SAh8S8SESI4y6MyZSYQYftLwm8=;
        b=Iv8LGGTSgU5ymAaM52CyCRfKE5XYILt52jp3vCutiZWbOu3D5AbtiWLrDGGKunsho3
         3YZRp9NLqFopNf/ZTuVCDIlKLMMeLNceUO6KDC/aQbk6AEUI2KpNgnGX66Y3YhLZc/0W
         G11BczW+n1+bBcsBBV8DV6MgKbASGDGb9g7ZyLeI/3TvCRKAce5UraQnAzFYl88mhYpz
         6O+LRuSIKY93z9HC5s3DSF6jxEiWS2pDi2d90jibCQznbJvk48Lz5eO2E2J2KAZrhxQJ
         LYjqxJbu/GDZyHta3M6nUGZ66xXPCNocqJXPIrapZIlXlpH1Ljv/wlMFK8nuMqhIDpmQ
         /OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473315; x=1792078115;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N08OobCMo//vTBI14SAh8S8SESI4y6MyZSYQYftLwm8=;
        b=L904VoVCglxFjzeBb4nMsyUgjKNcB1OgrLdyybURxKE2Zav7SQn9bPfbzaY6qQq6Hk
         /VRpXqHxMGhhY8kuPVi0UpTEJBQx1720V9Z4V8LKv5h7au5MxdKaC12WbqsZvVy48o+m
         RG+yR0rb3eisP5jRcSSqg+kaYPvZOnM8L33rTwAvAm4bvRccHcaV9T4yXes8bXHoJjU0
         GjzVAVYP+si5yrWIna+13dlJUdBPTV9VhGuaoBcY5VnRWsLMKTN+Cby4baaQKAe6We3q
         v79MSgGCbH+3dQUEeR7zzu04Phv1ZMzjK1GEFUehZ9eaS/Ijsa3L5moypOJj70GLpzNo
         UplQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFkr87DSSytQ03Hgeyh1PIqVvlynZIxBE5pyCIo/y1nW7Tq1ii4AnX++r1fgTsjbQyuu6KWqE=@vger.kernel.org
X-Gm-Message-State: AFuF++le2JbQz3IneUrjxB9O2YamcPCfiDDBbiFecLjW0+ad7RHE/QKv
	ymSwkRP+4YVK69LpjnELgzY9PX7wjkRaskCe0xTUqgqbUjqbV/gmr1FB
X-Gm-Gg: AYBFou0eWBOi1swfUKAbUezjkhJF4BlMagflEqSv3xqNHyhwgEXWzOZb4doXutGCvOY
	PxS4C0GDn3URGpT3hOrSk2vM4UnD30Oo4hRqq4cQS08SDldg6B0DX32iH1W98HEddBiNVwbcDP7
	ivNrlFwPtxSHkqYeCBitzNiAZacIvvVntCy7q2tXwyA2y72aLCjcTBK8KyhgLYvyBxFTd9OfP6g
	K+oW2CujQDdEExMhGTz5AulrvogqDbIR6i7qOa1t4pXiQroLUV7YA3D5jTV1i/zRfUMRVQFIy7V
	ShYH0Q2rrPcJGZvN5549KO1+wdSMhxcIeniRTgPnXBOk4QGPRBpp8WbUL0iGQ9YH9yhANZ44cPe
	C9bnNXpL0sUkij+8vQNpIM7+7Slyjb7YM3ipatH7xeFAzNS9AmDKHODY5ooMC/ljy/EhUai89Nd
	uxZDfFZMou4PagggwcCUH0CllrAddB8wDWLPHhFRzEAcGHDexVflKXwsl07nLgbBIpNXVdD2d8T
	ce7w2eXAulpZWqxmvzR6UNf2iAzjFdzEXHFK0FiqCvHKRGm94vmZ4tZu+jmoCuu1glI9jx8E0fM
	MNNgBmBdYwvgd43/3dznJPwyBSrJFNf1ma3ovD58gUOQy9yDf6uzvFWnCybQ
X-Received: by 2002:a05:6870:14cf:b0:485:d31b:7767 with SMTP id 586e51a60fabf-4a2595a2e98mr4972258fac.37.1791473314933;
        Thu, 08 Oct 2026 08:28:34 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:655c:c517:c6a0:13b2:a6e1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2743f85cesm3203504fac.0.2026.10.08.08.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:28:34 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Dumazet <edumazet@kernel.org>, David S. Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Alice Mikityanska <alice.kernel@fastmail.im>
Subject:
 [PATCH net] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
Date: Thu, 08 Oct 2026 12:28:24 -0300
Message-ID: <179147330473.58090.15760316487710432833@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

calipso_skbuff_setattr() adjusts payload_len by the length of the
option it inserts or resizes:

	payload = ntohs(ip6_hdr->payload_len);
	ip6_hdr->payload_len = htons(payload + len_delta);

GRO can build BIG TCP packets larger than IPV6_MAXPLEN, and stores
payload_len == 0 for them; ipv6_payload_len() then falls back to
skb->len.  For such a packet forwarded to a destination mapped to
CALIPSO, the code above writes len_delta into payload_len, and
ipv6_payload_len() no longer falls back to skb->len.  nf_tables,
conntrack and sch_cake rely on it.

Leave payload_len alone when it is 0, as calipso_skbuff_delattr()
does.

Tested on one kernel (arm64, QEMU) with SELinux permissive, a minimal
mdp-generated policy (network_peer_controls=1), "netlabelctl calipso
add pass doi:16" and a default NetLabel mapping of fd00:2::/64 to
CALIPSO DOI 16:

- calipso_skbuff_setattr() called through netlbl_skbuff_setattr() from
  a test-only debugfs hook (not part of this patch, see below) on a
  70000 byte GSO TCPv6 skb with payload_len 0:

    before: payload_len 16, ipv6_payload_len() 16
    after:  payload_len 0,  ipv6_payload_len() 70016 (== skb->len - 40)

  and on a 1000 byte skb: payload_len 1000 -> 1016 both before and
  after.

- Forward path, client -> router -> server network namespaces, the
  client injects 5 unlabeled UDP datagrams with AF_PACKET (to avoid
  socket labeling): the router adds the CALIPSO option, the server sees
  nexthdr 0 with payload_len 31 (15 + 16) and delivers all 5 datagrams
  (Udp6InDatagrams 5, Ip6InTruncatedPkts 0), with and without this
  patch.

Fixes: 81fbc812132c ("ipv6/gro: insert temporary HBH/jumbo header")
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
This is the separate patch for calipso_skbuff_setattr() mentioned in
the review of "calipso: update payload_len when removing the CALIPSO
option".

Test-only debugfs hook used above (built in with obj-y in
net/netlabel/Makefile, triggered with
"echo 1 > /sys/kernel/debug/calipso_selftest"):

  // SPDX-License-Identifier: GPL-2.0
  /* TEST ONLY, not for submission: drive calipso_skbuff_setattr() through
   * netlbl_skbuff_setattr() with a normal and a BIG TCP sized skb.
   * Needs a NetLabel default mapping to CALIPSO (netlabelctl).
   * Trigger: echo 1 > /sys/kernel/debug/calipso_selftest
   */
  #include <linux/debugfs.h>
  #include <linux/ipv6.h>
  #include <linux/module.h>
  #include <linux/skbuff.h>
  #include <net/ipv6.h>
  #include <net/netlabel.h>

  static void run_one(const char *name, unsigned int payload, __be16 plen_field,
  		    bool gso)
  {
  	struct netlbl_lsm_secattr secattr;
  	struct ipv6hdr *ip6;
  	struct sk_buff *skb;
  	int rc;

  	skb = alloc_skb(LL_MAX_HEADER + 512 + sizeof(*ip6) + payload, GFP_KERNEL);
  	if (!skb)
  		return;
  	skb_reserve(skb, LL_MAX_HEADER + 512);
  	skb_reset_network_header(skb);
  	ip6 = skb_put_zero(skb, sizeof(*ip6) + payload);
  	ip6->version = 6;
  	ip6->nexthdr = IPPROTO_TCP;
  	ip6->hop_limit = 64;
  	ip6->payload_len = plen_field;
  	ipv6_addr_set(&ip6->saddr, htonl(0xfd000001), 0, 0, htonl(2));
  	ipv6_addr_set(&ip6->daddr, htonl(0xfd000002), 0, 0, htonl(2));
  	skb->protocol = htons(ETH_P_IPV6);
  	if (gso) {
  		/* what GRO builds for a BIG TCP aggregate */
  		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
  		skb_shinfo(skb)->gso_size = 1400;
  	}

  	netlbl_secattr_init(&secattr);
  	secattr.flags = NETLBL_SECATTR_MLS_LVL;
  	secattr.attr.mls.lvl = 0;

  	pr_info("CALSELFTEST %s: before skb->len=%u payload_len=%u ipv6_payload_len=%u\n",
  		name, skb->len, ntohs(ipv6_hdr(skb)->payload_len),
  		ipv6_payload_len(skb, ipv6_hdr(skb)));
  	rc = netlbl_skbuff_setattr(skb, AF_INET6, &secattr);
  	pr_info("CALSELFTEST %s: after  rc=%d skb->len=%u nexthdr=%u payload_len=%u ipv6_payload_len=%u expected=%u\n",
  		name, rc, skb->len, ipv6_hdr(skb)->nexthdr,
  		ntohs(ipv6_hdr(skb)->payload_len),
  		ipv6_payload_len(skb, ipv6_hdr(skb)),
  		skb->len - (unsigned int)sizeof(struct ipv6hdr));

  	netlbl_secattr_destroy(&secattr);
  	kfree_skb(skb);
  }

  static ssize_t trigger(struct file *f, const char __user *buf, size_t len,
  		       loff_t *pos)
  {
  	run_one("normal", 1000, htons(1000), false);
  	run_one("bigtcp", 70000, 0, true);
  	return len;
  }

  static const struct file_operations fops = { .write = trigger };

  static int __init calipso_selftest_init(void)
  {
  	debugfs_create_file("calipso_selftest", 0200, NULL, NULL, &fops);
  	return 0;
  }
  late_initcall(calipso_selftest_init);

 net/ipv6/calipso.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index c6a34334e..dfea7ed65 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1318,7 +1318,7 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 	struct ipv6hdr *ip6_hdr;
 	struct ipv6_opt_hdr *hop;
 	unsigned char buf[CALIPSO_MAX_BUFFER];
-	int len_delta, new_end, pad, payload;
+	int len_delta, new_end, pad;
 	unsigned int start, end;
 
 	ip6_hdr = ipv6_hdr(skb);
@@ -1357,8 +1357,9 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 			sizeof(*ip6_hdr) + start);
 		skb_reset_network_header(skb);
 		ip6_hdr = ipv6_hdr(skb);
-		payload = ntohs(ip6_hdr->payload_len);
-		ip6_hdr->payload_len = htons(payload + len_delta);
+		/* BIG TCP packets have payload_len == 0 */
+		if (ip6_hdr->payload_len)
+			be16_add_cpu(&ip6_hdr->payload_len, len_delta);
 	}
 
 	hop = (struct ipv6_opt_hdr *)(ip6_hdr + 1);
-- 
2.43.0

