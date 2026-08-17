Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3663D45CB
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963300; cv=none; b=sMvqSumCFIa2ALt0xpS8jhdGbQaLXRNpWzvlzr/xWuj+HJxjAIKIzrfGrVTUshuHuW9zFMUQV3AsVnx6IiXlYp5LEyGGCjz2mZYMsU/uNveTh//+5G8vZPdB2w1+9iB45ZEzrxXNdkLsl6+NlRukqA7b0hXONPSSt/53+ZxyWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963300; c=relaxed/simple;
	bh=LSb0KhFUzLnQsU1r11r/6fkNT7w+2m2GOzx274QNTwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gV4Xq5UrJ4CFzYD9trxna5avxaOrHa2bBiz54Tg7Myw8+O8gV80dwrLq/GppQni4Bp6F6s3ykSFqqWGrT7h6oauCRhRf5+LwYZvhDUperH9b+FXee9c0yJR/NHetSF9MvN+/q/sz22vzy9GnZDvhedu5fUwAnjqhesKjhxzgmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKI44xDM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKI44xDM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so2670820b3a.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 03:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786963298; x=1787568098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dMxmArJymrzxglgoXBpsaklWgzCGHZMX0N8em1OSk78=;
        b=CKI44xDMN0ApseP4SnsEg8tOLC735qT7Gq3pfKeTP/1fopfHeGca1sU+W3eQ3quBIy
         1Yd20y7lRzIuZVJAsXbSJXRr5O8j6GukmN2KnSp4IdvbDTqu7RwBtqi7NivJ2YvWHDL1
         yoSwUcPM5geExs6koRBQKLckGAi2m+bwrz0SU/gqJrzy4xW0Pk4HmHtk5RHa1U8IW5Qn
         MUg++Z6yagCAu++qphMBk4E/V+bFAa+5LDbBfBlBLeaq65N3snKoYriT/EzFJoZMSLtt
         BYmbdagWSQM799lFY0B3lE+RCMJX6KpW3nLLaCSyQKWOmrHFuYUVu/w9M0etYHQem5gG
         B7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786963298; x=1787568098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dMxmArJymrzxglgoXBpsaklWgzCGHZMX0N8em1OSk78=;
        b=nwczUdW4lam6ba/hXKe4/luMWVzZxEzhdDq1nh29Hnn28JuCl8z4/+HKuK3QJ9SOB2
         d+sPaafwJiUGdhQdZb3UAtjGRmc+Qq9angReTf3tQUb6aBE8ydgDiU+Xo5WcLtkDnrxx
         toc0dqbu6iNgmVQJcEsxNoOdJ2nq2myqxgrH2E2nrCgRAS/OCHiYVo2oOJ+DtqQMqDYB
         uiORN9wJIRWYR/P/fkttTQKWgf5ebHm8dPVMfixh9Mq3YNZJM9igQUxOBYq1k5MSSY1g
         mfu+rxs7Y5p8gGoh9jmQZLls/8mBohYYXxAgn6LMOsXzfUVj6mpslrauYVMspKqdglrl
         tWqw==
X-Forwarded-Encrypted: i=1; AHgh+RqcxDNs5lCCS7iIP5Bq+SVWVvVa8iOP2RUionQfPtl+B/DwrOIf2e/h5hFgJGKkwjkb4Wv833Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMMnQnNtqVuiquLqVSxVSB7Q8JUruXMkzIfdVayAoWf/Dno9l
	vq4vdf8Uk55q0sR4nnmcSsKXbGYpukE/iIc2OfR7c31RA0drEzhiUYfn
X-Gm-Gg: AR+sD11rwVJelm/FaemY74OvCmc9Pu4K/RCEGrtkLhp/pPfutNr0hpL0OYbzH+dL/lW
	++/a82DDekmKMRD3cy1lwwd7nMqpaz4fR/NBTj4kNhPE6euTrqGp2Cc5f732/kajHnORtYQDi1k
	hmHXpGwb4MaTlZx02krtobbQnp8XGBbGL16lQRrBQhWVCm0eic2J5lJQ2GJULsuOdv9jY9i0XWC
	FwRaTc1bvhK02QQ7ifZBF1/RewWAajVFFD2Px+FcmgqLWV7luTRRvzBUeSmj3PseW353b5jwHNj
	mXJOBvMObEqnoFPDvsDU0wF9bEVsHjwB3qJsBiDFFOowiXkP8viO33H3V47xjyAF8Ctc5OwNUti
	X+p1LoWt+Puj1P4fBiomplFeakpHLI6zBoSm0QWLhh0gpyIcfZAkicNn9d3vEQiG41/pLd3t35Q
	yILNb+Xg5Wa+Ka9GzJ5QP9SRihBEN/GhPzh8lLKEF4+0IFfbGngbx3PXYWTAxbYI8hw6N5cbQuZ
	xZORMbqM/M9GtlARwBy7FdCCw==
X-Received: by 2002:a05:6a00:3697:b0:845:dffa:3740 with SMTP id d2e1a72fcca58-84fde11d75cmr24478182b3a.4.1786963297851;
        Mon, 17 Aug 2026 03:41:37 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fcc0besm71682b3a.50.2026.08.17.03.41.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 03:41:37 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] ipv6: sr: restore network header before forwarding
Date: Mon, 17 Aug 2026 18:40:52 +0800
Message-ID: <20260817104128.22681-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

ipv6_srh_rcv() runs with skb->data at the Segment Routing Header while
skb_network_header() points at the fixed IPv6 header. It restores the
data position by pushing sizeof(struct ipv6hdr) before dst_input(),
which assumes the SRH immediately follows the IPv6 header. If another
extension header precedes the SRH, skb_network_offset() remains negative
and neighbour output passes it to __skb_pull() as an unsigned length.

Keep skb->data at the current extension header while rerouting and
restore it by the exact network offset before each dst_input() handoff.
Remove the fixed pull from the loopback path. This matches
ipv6_rthdr_rcv() and handles any valid preceding extension header.

The trace was captured with kernel release
7.2.0-rc2-00023-g714b725feef4-dirty:

  BUG: KASAN: use-after-free in eth_header (net/ethernet/eth.c:86)
  Write of size 2 at addr ffff8881247b9a3e by task ipv6_srh_poc/9336
  Call Trace:
   eth_header (net/ethernet/eth.c:86)
   neigh_resolve_output (net/core/neighbour.c:1611)
   ip6_finish_output2 (net/ipv6/ip6_output.c:136)
   ip6_forward (net/ipv6/ip6_output.c:690)
   ipv6_rthdr_rcv (net/ipv6/exthdrs.c:832)

Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type 4 (Segment Routing Header)")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/ipv6/exthdrs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 9c677eb1d1a6..4c407520e9da 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -452,8 +452,6 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 	hdr->segments_left--;
 	addr = hdr->segments + hdr->segments_left;
 
-	skb_push(skb, sizeof(struct ipv6hdr));
-
 	if (skb->ip_summed == CHECKSUM_COMPLETE)
 		seg6_update_csum(skb);
 
@@ -462,6 +460,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 	ip6_route_input(skb);
 
 	if (skb_dst(skb)->error) {
+		skb_push(skb, -skb_network_offset(skb));
 		dst_input(skb);
 		return -1;
 	}
@@ -476,10 +475,10 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 		}
 		ipv6_hdr(skb)->hop_limit--;
 
-		skb_pull(skb, sizeof(struct ipv6hdr));
 		goto looped_back;
 	}
 
+	skb_push(skb, -skb_network_offset(skb));
 	dst_input(skb);
 
 	return -1;
-- 
2.55.0

