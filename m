Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8937A827
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347800; cv=none; b=DEXC5WuSTecwLRTQjfb/nZ9yI7euZnBejriT25QXjAViZt26b+NWURaXvsC+UWwasRHdQoD4q8JTxnFExu6X4aVGkgyDUZGj6CQeb7NQvuLH3TMntggj1VvouNTf/6sv+k/hDLd4aWu0W4NsIQBCk3uXoqnagYysgpeRkaNf01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347800; c=relaxed/simple;
	bh=N7fW+YE45TTWx0piKqkr3kefm6w/ezzVajXStRwg5Ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GOFVYbouPPXnb5+AGKwmasW4QKFj37b9U9ZZX5K5oDzgkL53UdrtOWA1pxzJp4wHOWPqT2Rm/pH8O4st8uRvxyaOn49Ckx43bTHs7FSwP1l5Cj1IYgIBNoh42dCfLLyLrtERIMioaUv2xpEST6dnk0OHf5IrDT82MDDUTrLXfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIpXPNV9; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIpXPNV9"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so477839a91.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790347797; x=1790952597; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oDeeKwu1Fk+6aKeSpnAZpYBgAoqV+LjHAT/igOrLXAE=;
        b=ZIpXPNV9KwyHPh2cXgOfXgYN1oWT/6vdWtZsvmSQuPiLeBiRPQa8V9cw+bE2cnHgLd
         fIOkFJ+abr/76lDpVe5TwnozuqkRZksMfzxQnvD5vXZ8KfrzGwk0ZbYZfNBHGrLBvog4
         QSZWJMr/QHeHCzoyQyCfLN5/WPIUYkS1y+65sbi/pIgN/AoRFv4E2AUi6n0f2VvfbP7A
         sJMcCsx3oISIt7HCBbX+G31fEt2r5Ch9xvIIGi7M2qpZp9dY9ISmJko8/hwxgbkw4las
         EGnI9kxz0koETmflkKleVp92YBmcPZshRWmrd+tCF3BsNOsgCz2rsjCVv06b3ZT9iqLE
         mMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790347797; x=1790952597;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oDeeKwu1Fk+6aKeSpnAZpYBgAoqV+LjHAT/igOrLXAE=;
        b=CiNFpOU5xKfosHx0JrZP3Y5hCiCCjL1WkbKzkFb4kYHnzXR8OgVNK+y5b+kCoZyFiT
         VdPNRnFHZU599Na4SsDb59TIC3JeUukGpOkOqJVqGHHvCKisGXwE+FmhVpsfCXEzBEVr
         lWOqaPINYfOqGD+ahse0ti8bX8mV6iwMIvqovANib+vz2v8fjZFV9Rd8F6clkXAgLbU3
         k0/B8i15H54+cw6CsTlNP0l80D/Fx97MtDxK/NCMYwbzxuFxOy2EKr7cbLjf+QbZBJyE
         mveU+DUvdj+BwBcJCSRqAeE99Tj0KyEnZiqsGfW4+d2zIez4CgJpBb9MMzhx0urgh7W1
         lclw==
X-Gm-Message-State: AFuF++koFAoOsBm3H1f4NoTnEndapp0q25qfLYRQMRQcKuUsiSexbTT1
	fwmcMhVLWgVNVhQNdHs2c40a9j7aCubksZhWoDneyzYlvxPk9jw/Ldg/
X-Gm-Gg: AYBFou1He+tpESVAvJHbb06rypavUPOcTaByn40TLreIM2YxgdaJbiuHTN5Pym3S+sj
	/HVYuI6PHNF4FjjNGEpM0mRUciOHXrVeP1NAi8HoFJecydQfKPXfMNYy4nbKIeC8r0MrXfIVy0h
	oVRa/C/7t1m6lP5nIJWf7qwGV8R6z20C927nG6BKQ9AIljnq7drArFsF+CkoREOMA+ND4BLWQ/g
	fZNjuFT8VYwX/ZPWDf8zS5aEg8O9bxuMfjqsxa3kvtp7DVkPnhVhZB65wViVYRDOxHas7TryilQ
	AnqbOGtycLQsXjgfgNjGb9z2PC1pSNfmYSxAzWkaLFL/exRGAWRveTsu5luTSClowhvKhNg8lnR
	h7JAXP+vOypR8Q2X+hO/m3ZIHqTODuA5hRTS+3DEj0N677QhiyZne9brhLnF9To8LhEJUf+GFPZ
	Du6o3Zw6yMl6k9g1u/7pBLxgWHfUYRSio9jh4N7fAaAxaH4xM1MN3eDzAAkbZgcbqaZ2cuDX9s2
	JiKxbf18w==
X-Received: by 2002:a17:90b:3952:b0:3a0:c363:9ae5 with SMTP id 98e67ed59e1d1-3a0c3639f5fmr1182901a91.58.1790347796493;
        Fri, 25 Sep 2026 07:49:56 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b94936ddsm5010913a91.7.2026.09.25.07.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:49:55 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 25 Sep 2026 23:49:53 +0900
Subject: [PATCH net-next v3] seg6: reallocate the skb head on L2
 encapsulation only when needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-seg6-l2cow-v3-1-fc83821542a7@gmail.com>
X-B4-Tracking: v=1; b=H4sIABCKtmoC/23NQQ6CMBAF0KuQrq2hM1DUlfcwLmgZoAZb0yJiC
 He34AYTlz8z7/+JBfKGAjslE/M0mGCcjQF3CdNtaRvipoqZQQoyPabAAzWSd6DdixdFpVGVmQA
 EFsHDU23GtezCLPXc0tiz6/cSnupGul+6lt/WhN7597o7iFX8mxgEF5wOgJpAyCzPzs29NN1eu
 /taPMCW4g+FSGssFCrMMyHrLZ3n+QO3o9wV+wAAAA==
X-Change-ID: 20260902-seg6-l2cow-77dc3ba41232
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=N7fW+YE45TTWx0piKqkr3kefm6w/ezzVajXStRwg5Ck=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqtooS872w54vNAZGZyiuBTkfchwo0v+H3OR2cS
 BUyBgl+f2SJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCaraKEgAKCRAq19F1Kl0b
 TSQCEACibECaemY1AT4fRQQdoEmmWlnsIQHkIc8CWub8vIODMd7PR9qPGK2B2Y1SHF/4I1U+UDv
 Wfx9m1Rotr+EfSC8SwyoRJGW4s7vY54gAi8He1dk8qlasJPFY6TNe0RqLe11k8ZrzKEMB4mTZ9j
 quvj6au2kN+kWCSAJxdj0fOzcUKfBvC1x40xrhCRusNCEqMB09Z7iVixAhLawVxzsr0hGaEgOax
 6pPMlZ1ff+gKGnqT6cYsQPnXh66miZ2w+6/Ah+nNj8V99nMfEJIwQnnkR6ZNikiMiXMhM0ME1S0
 5eoICA7jgEuJwdH0PMTnAK9U8t4UWceaWvIWa7klymBb0T7H4T4ibp8OFsuqdOlkcOZKGHLtTNI
 FEYMTZ2mgPjVokGzbbWBjY6sBH0LIh1HuxwcT96f+BABYw/XfZa23AeR1N6ZsFenmNGvSWJ4D1p
 xYDBSBZ475JPoSNXZ+XbB/iONWkLhY7500zw2S95pMSB3Fz8zq/RNNQvvyik6Ym35scvXA+Fi1R
 ZP+KZ0+ZDU2I0zwG+ShBNp/u7Q+G+rTEzgkauyWIgNySMsu751j/CjUZODnw5lXUrQAI7yUW7GR
 65Vw7dYBAdgdObVv4ZbpF3HQw8LUvxbaJoVIn/wBSJJL8T6mcS7gURJhs+/OJmVX4cfglkfTcIh
 ONeDIcx79SbvHoA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

The L2 encapsulation modes of the seg6 lwtunnel reallocate the skb head
on every packet, where the IPv6 encapsulation modes reallocate only when
they have to.  Ask for the whole encapsulation up front instead, so that
the reallocation happens at most once and only when the headroom really
is too small:

  skb->mac_len + sizeof(struct ipv6hdr) + ipv6_optlen(tinfo->srh)
  + dst_dev_overhead(cache_dst, skb)

__seg6_do_srh_encap() then finds the room it needs and its own
skb_cow_head() becomes a no-op.

Drivers reserve more than that on the forwarding path, so the
reallocation usually disappears altogether.  A single-segment policy
on ixgbe needs

  14 (mac_len) + 40 (ipv6hdr) + 24 (SRH) + 16 (LL_RESERVED_SPACE) = 94

against the 206 bytes the driver leaves.  Where the headroom is
smaller, as on a veth pair, pskb_expand_head() is called once per
forwarded packet instead of twice.  Asking only for skb->mac_len would
still take two whenever the skb is header-cloned, because the cow that
unclones it does not also make room for the outer header.

The cost is amplified by CONFIG_INIT_ON_ALLOC_DEFAULT_ON, which many
distributions enable: every new head is zeroed in full, and that memset
alone accounts for 16% of the datapath profile.

Throughput at 0.5% packet loss, 64-byte frames forwarded through one
2.30 GHz core (Xeon E5-2650 v3, ixgbe 82599ES), offered by TRex and
binary-searched over 10 runs of 10 s:

  Before: 654.6 kpps
  After:  965.7 kpps

Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
Changes in v3:
- No code change.  Rebased onto net-next, which now has 87cd6b717e40
  ("net: ipv6: keep room for the mac header in dst_dev_overhead()").
  That fixes the headroom shortfall Sashiko reported on v2, which
  predates this patch and affects every seg6, ioam6 and rpl
  encapsulation.
- Link to v2: https://patch.msgid.link/20260903-seg6-l2cow-v2-1-f37b3b35416f@gmail.com

Changes in v2:
- Ask for the whole encapsulation headroom at once, so that a cloned
  skb no longer takes a second reallocation inside
  __seg6_do_srh_encap() [Eric]
- Re-measure against unpatched net-next rather than an older base
- Link to v1: https://lore.kernel.org/r/20260902-seg6-l2cow-v1-1-e823ce216454@gmail.com
---
 net/ipv6/seg6_iptunnel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 61c6a27bf202..ecd8146089ee 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -400,6 +400,7 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 	struct dst_entry *dst = skb_dst(skb);
 	struct seg6_iptunnel_encap *tinfo;
 	struct seg6_lwt *slwt;
+	unsigned int headroom;
 	int proto, err = 0;
 
 	slwt = seg6_lwt_lwtunnel(dst->lwtstate);
@@ -446,8 +447,13 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 		if (!skb_mac_header_was_set(skb))
 			return -EINVAL;
 
-		if (pskb_expand_head(skb, skb->mac_len, 0, GFP_ATOMIC) < 0)
-			return -ENOMEM;
+		headroom = skb->mac_len + sizeof(struct ipv6hdr) +
+			   ipv6_optlen(tinfo->srh) +
+			   dst_dev_overhead(cache_dst, skb);
+
+		err = skb_cow_head(skb, headroom);
+		if (unlikely(err))
+			return err;
 
 		skb_mac_header_rebuild(skb);
 		skb_push(skb, skb->mac_len);

---
base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
change-id: 20260902-seg6-l2cow-77dc3ba41232

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

