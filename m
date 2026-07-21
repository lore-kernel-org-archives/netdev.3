Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDEF42DFEC
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676502; cv=none; b=t3AsmACO50vGGdJtPlvgoFDckkp95iD1opWDX003f+tPzWALNLikxDP2RBRn86EMdk/jYvrWAJWqS3SboKzBcfmMtDVM2PUASowbwOYOWqK/7Xw8vXU6pyCSsidph/y4UE6BzsjcbPF6krt6Dknj8sQfAdQ07AudePQ5gTAL9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676502; c=relaxed/simple;
	bh=irVTV74mVuOuLu8jU6nhDyNRWI0SVtaJWyZgTsXu7us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apvqGKKDTdZ6e2ShQ0S6xk6j+AjE2aR/hnHzlAiBFvQEe6aBGYxeA66SfdyaQbcyEugsy8bjQypLFVMLeuPDZvdMDI2hQ/38rVlTHoA0FOIkq/VOGqy02yuyPPF/o2sumpi2xgXYTpWtAhbc7N9C6EbcugGyT9dtxfNT/MG8iXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Z9viuVl+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Z9viuVl+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so109015315ad.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784676492; x=1785281292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3qrZVVtwbHqwgSrHi3jW4izH2aGoGZ3Oe5m0UJ7ploA=;
        b=Z9viuVl+LIZP5fXAcmuVIl9pvUs2+oljzkQeayt4Uz53vC3LaDDWRpHsn6slOB23TE
         9s3Vl5CUUoEtRF70b1QWFLw8H8xupiL6UpmoueY/pZLGD3WvF9K49S28fG5gbreXtkis
         REb1wy403Q0k78l7+/+BeJRN+GitgHZgc7ROjJBB00/u444E23+hYS/qaLCOGcmKm/st
         mmO/NT8BkH+a8xM4/etjvOcQcBYJeCG36i07UqbUfsB9t0vSLjna4ke13GS2xvnFbaJD
         bfiGjdAIUtbmb0KWAoGuP4tNoMpg1OdU05ahSS5tzl7SsJjm+40wsYVlHE9FkseSTrBo
         hMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784676492; x=1785281292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3qrZVVtwbHqwgSrHi3jW4izH2aGoGZ3Oe5m0UJ7ploA=;
        b=eQIaPbdKZl5+pSEv5ndif+5H3gHCJVxzwGjuLmur1x9eVua+0QDBBdyO7B/x6nF5AP
         gLPAewcCSygfJSuw3NPWobA2PPgrEyfmGFVK/Rr0TuI1vWeZphQfqkWSRXe1XdtFzEXC
         bUrOlzzdU2TaK8adTV8N92MPDA5o+s2yDo+KcYt28+wiHQTVD2KTLh0TXMj58VmLrlnJ
         5tfPWBauYWX11+3MkxKZejgM63iikJIqwATgdGu4mG6nnpoVSlUpZNlAi/5fjDyKdob2
         bSgYT+hBO3T2hwOazSQ4BRfojVyjwKPJHbmTaUVjG4eZ1/w+2jLYjcOyRUZb64iy67wj
         opcA==
X-Gm-Message-State: AOJu0Yw6AN8Ek+x+RLSM867mwG4YvdNrL3IoCFnYAjRn4g9ZBsz8ddU7
	acUwC2Bj8NfE1M8Hn3jD2WaQSJuwQdk+o0mcvBGE3mLQ/q8hD/9vgoB2uXMZvrLvGg==
X-Gm-Gg: AR+sD11KI4wOFBYgFEOBlt9kam88+3DbdYDJglyN+0z7ZsoWtwloSNhh1xvARGTjfXk
	BVVu2xBfL2SkuMdVSsirxvyx1qBWy8emSmrmG/G9kMfQ0YaCpdtUWRm7av00FK5/i/zxE2HMOMQ
	B5AuoFidgovps3OM2nwi/Eog2/2MHkkBSDdJiv8EikozTcVNG9q4h3vem6kqNjNIQC4boL+kLLF
	K7dNvDeJqN/c7IrU5qllpEZlxRkU/sVgS1tIqQb1/jRArGlz2lfRM9XX5nfpo3ID2F5RBvlmePG
	LbkPq6Cvce8vdJ2Pr7O3wKt3g+xcJoSumWkoMC4/Ukv115Bo12V05M3Xhg3zM7VdCcJRS+yZZNI
	91AwEe3bXM+k6/LgcvFHuPRW5DUQgsqjHNzNe2UHHJFbsNR8Ix5Eghm8KxTF7WA2YEoJ6PNFxSH
	DwMxAaDZc=
X-Received: by 2002:a17:902:d491:b0:2ca:bb7e:29a7 with SMTP id d9443c01a7336-2cf34a76fe0mr238495075ad.41.1784676492429;
        Tue, 21 Jul 2026 16:28:12 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1c7ff4sm2633629eec.27.2026.07.21.16.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:28:12 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] amt: linearize skb in amt_rcv() to fix use-after-free of cached headers
Date: Tue, 21 Jul 2026 23:28:05 +0000
Message-ID: <20260721232805.2451198-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AMT message handlers cache pointers into the skb linear area (grec,
iph, ip6h, eth) and keep using them across ip_mc_may_pull() /
pskb_may_pull(). On a non-linear skb (e.g. a reassembled fragmented AMT
membership update) such a pull can reallocate skb->head via
pskb_expand_head(), leaving those pointers dangling into freed memory.

Linearize the skb on entry to amt_rcv() so no later pull reallocates the
head. This is a no-op for the common linear skb, and covers all handlers
at once. Drop the packet if linearization fails.

  BUG: KASAN: slab-use-after-free in amt_igmpv3_report_handler (drivers/net/amt.c:2023)
  Read of size 4 at addr ffff888013fdd71c by task exploit
  Call Trace:
   <IRQ>
   amt_igmpv3_report_handler (drivers/net/amt.c:2023)
   amt_update_handler (drivers/net/amt.c:2503)
   amt_rcv (drivers/net/amt.c:2846)
   udp_queue_rcv_one_skb (net/ipv4/udp.c:2389)
   udp_unicast_rcv_skb (net/ipv4/udp.c:2580)
   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
   ip_local_deliver_finish (net/ipv4/ip_input.c:242)
   ip_local_deliver (net/ipv4/ip_input.c:262)
   ip_rcv (net/ipv4/ip_input.c:612)
   __netif_receive_skb_one_core (net/core/dev.c:6212)

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 drivers/net/amt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 951dd10e192b..2bce99d45d2c 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2785,6 +2785,10 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	skb->dev = amt->dev;
+	if (skb_linearize(skb)) {
+		err = true;
+		goto drop;
+	}
 	iph = ip_hdr(skb);
 	type = amt_parse_type(skb);
 	if (type == -1) {
-- 
2.43.0

