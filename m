Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316468;
	b=Tzep3efrGPEw0CPFDVFiK3Ykrkm/sD+ANPQkUDedpf3e4V2ufI9H0ZWvunR2thMCHzou
	 +wCkSKMqNS1jPxk8XJ3epp55XzGiNqrtDFAicIb0qxKydHIjQ0E+hxvDQQcXVdd7cNYpT
	 9p9nzLgageWOCUG9p6p+uVjjjyvX22Dq1r9k2Q+R9qbjhZmSpoHvxqUl+qFLQcEI2BP7x
	 c9msRYrrlDnLcbLx1/ftDMDx2FUI3aEg1vWv8BsiLyhP0JFJ1xKJ4aF6tvsnFACz/nllh
	 E8XfVKGb/Lg6bbYWfxaDIvULTHE6pbhjlyBuIzsxwDeql/d8HZQf767+QOYaWOlrBnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
	b=l3KHh0DrxdZ1H/htFxcI8GNfF/HVFS8rF86iy6KXTXfG1aYWM+pThDYjOyTsIBA8AgLR
	 VsQqiPuyNSZpxg4MPsz5YOVWp/p5ud9oG5qbO+MwTjbsJX6Vb96+MOqQDlzi9q175dUos
	 OTqzF6ouYujfcnvp5ITHvcSyBlcTHTHNHULp89pamWKDZGgQv3BPAxSU8+R9Fs19NAUW1
	 GhWPswrA/GlMumRrAcOU4rStci2oXiG82EE2rq/QEk0JKf7QR/ybwJctXGEZh+egVvnG/
	 8jC8GMJCJMakGvujg15yAXtE/PfYPRqJtk4wm92CgrD/aNTpTGjh0fsJeSpEfSr+4mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wXzhaUs+;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64FE606A334
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E64FE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wXzhaUs+
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-943e8d35f74so7158985a.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793316467; x=1793921267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
        b=wXzhaUs+nXAE9QzdFqH/pW6xNcQ2k3dW/Fyy5x+FYbA09Cvmggn1hOpcgdKuJBTzLw
         mtz3Q617eN688Pg3U0xVpuBvuKceCKq4FQhyN1yU9qMyNowZ2oOBRNWXr3bwBQthxIHH
         x8wK6ZIjuD4rDTn4JwoBlJ1VkrGJ4FixQB5A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316467; x=1793921267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
        b=k8Df/Wmu00Eq1KirSfnVTrJg4+ApuwMSm6wCyKQOZ7pCvF38EmbVDLq/RrTrC/0xf1
         peZqvkAfoSGAsr8AT5s7rHCqe521UICybsm4+T/Or5E4Y50XyzPT8oTOczbwlCmFQBLz
         ajWrblEbSPxVolF48dXKRoLkXZf/xDgQcFh+DlTnBv/4XHrZMo6bEcELipNEW+79bMu9
         6nEAXE+wOgNG3l3BoY9TcHZuF5PfoLT+VEa5V8j5iQ4fFiPAN1/TN8lvQMrQf+vpjjp3
         P1z3nfFnbaFFM7XkcbCjkBrd5fVDKyjwBGrZQlv1p3jX4T0H7RFojvH6d3pePll8a+my
         X3qA==
X-Gm-Message-State: AFq9FYIBzaN/w5LZ1KKiJ14jiDU09cixuQ56CuDxuAw/PTBTulygQzw8
	KjgYpjWgzhtmwhWnZBu5pROORFem4G0JNh80munOT1Y96Lfes1S85Co/ucxBr5YijauQPEVQ/LM
	5Qoc=
X-Gm-Gg: AYBFou1rujhYt3d900kTvDuOMFLIUvrLSCWZncRvB+jHyf0mPmYeqCTHg4oXM7Fdbeh
	xy9iGv9+o0lzC6//LsJgPMIz1tY5glkGVSzNcecE0etCE0JedmbfKBYaLus9BA+LtfMZR10zm1Z
	tGYc/SAS4N2+bLLbHI5RsRATHYBa18vNhf5wcZXKprLZG9UccW1mq3Jb5ZC32cVTOvBaHJ6GTne
	dKl/Y3Hr3zkkjTOkvCEAZQfORVqnx6W/qOjZ8FrgCZsmcCl7Q2GO54Uuy6y9aoeFJ/oJW5gxkpA
	SbGJwRBLMqw2EQ+gAQgMRfP44kOxWWNHw+6ln0ANpltMFPrAbrI0I2lrTvlseNsfDWNITxzznrY
	JQy5KWNG56iVWwRtnkH3MbWE42bJLVDNzCAEJOdSsO4jtVXqXfWgRRoTmCTtlkEsGcvRyV8OQkD
	yNaIKRStZ83zOPiwPRMjwCWPPr57yzm8XVv0/tCEOf7aRckIzjc0Y9mtCLJrzL6PUmF3oBLtG2h
	ywTCRDXi+vfIMeIHLQ3nCMSTxqCHzx/L/KPwJWW4DvPHlJuH2DOMbAoV6o0UX3DyeIbru9LoNvM
	cr3ZzmqSSfey8gn3+8Fhlqmos/pMNE3K5F05kqtffbKWcok39nGC1ynoK3MhXQt11yiRTL6hGeM
	=
X-Received: by 2002:a05:620a:2609:b0:944:dbd:8253 with SMTP id af79cd13be357-944217f72c8mr121536785a.59.1793316466853;
        Thu, 29 Oct 2026 16:27:46 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94424243823sm5384385a.21.2026.10.29.16.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:27:46 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 2/3] net/sched: act_ife: require a full Ethernet header on egress
Date: Thu, 29 Oct 2026 19:27:38 -0400
Message-Id: <SER-NSBD.v1.r0.20261029191634-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r0.20261029191634-1@mojatatu.com>
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com> <SER-NSBD.v1.r0.20261029191634-1@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a followup of commit 5b483f7791b0 ("net/sched: act_ife: Only
operate on Ethernet frames") as reported by Sashiko.

The finding was raised by both Sashiko providers (nipa and gemini)
while reviewing the parent patchset. shaos <shawnq1@163.com>
independently reported the same undersized-egress path with a
reproducer, which was reproduced and verified in our test environment.

The issue:
On egress tcf_ife_is_eth_skb() only checks the device type; it does not
check that the skb carries a full Ethernet header. For an Ethernet or
loopback device it returns true even when the skb has no Ethernet
header. tcf_ife_encode() then calls ife_encode(), which copies ETH_HLEN
bytes from skb->data. A short skb therefore reads past its linear data
and the copied bytes, including stale kernel memory, are emitted in the
outer Ethernet header.

The parent commit fixed the reported ingress mac_len case but left the
egress path without a length check.

A total-length test is not sufficient: a non-GSO TUN skb can have a
large total length while only a single byte sits in the linear area, so
ife_encode() still reads past the linear header. Require instead that
the Ethernet header the encoder copies is present in the linear part of
the skb.

The Fix:
On egress require pskb_may_pull(skb, ETH_HLEN) before encoding, which
ensures the Ethernet header is present in the linear data ife_encode()
copies from; the ingress mac_len check is unchanged. A short egress skb
is now dropped instead of being encoded.

Conditions to recreate the bug:
CONFIG_NET_ACT_IFE=y, CONFIG_NET_CLS_MATCHALL=y, CONFIG_NET_SCH_INGRESS=y,
CONFIG_TUN=y, CONFIG_NET_ACT_MIRRED=y. In two user and network
namespaces (a victim and an attacker), open a TUN device in IFF_TUN mode
and attach clsact to it and to lo. Redirect ingress traffic from the TUN
device to lo egress with mirred, and install an ife encode action on lo
egress:

  tc qdisc add dev <tun> clsact
  tc qdisc add dev lo clsact
  tc filter add dev <tun> ingress matchall action mirred egress \
      redirect dev lo
  tc filter add dev lo egress matchall action ife encode use mark 1 \
      action ok

Send a TUN packet shorter than ETH_HLEN (a one-byte payload is enough)
and receive the emitted frame on the other side. Without the fix the
outer Ethernet header contains bytes copied past the short packet; with
the fix the short skb is dropped. The attacker needs CAP_NET_ADMIN in
its user namespace; no init-net privilege is required.

The same path is reachable when the total length is large but the
Ethernet header is not linear: write a non-GSO virtio header with
hdr_len=1 followed by an 8192-byte packet so that only one byte stays
linear. Without the fix the copied header reads past the linear data;
with the fix the header is pulled into the linear area before the copy.

Fixes: ef6980b6becb ("introduce IFE action")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Reported-by: shaos <shawnq1@163.com>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821164031.32824-1-victor%40mojatatu.com
Link: https://sashiko.dev/#/patchset/20260821164031.32824-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20261022144736.61227-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_ife.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece..986264af8146 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -876,13 +876,16 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
  * is an Ethernet header because the skb could've been redirected with mirred
  * from a non-Ethernet device.
  */
-static bool tcf_ife_is_eth_skb(const struct sk_buff *skb)
+static bool tcf_ife_is_eth_skb(struct sk_buff *skb)
 {
 	if (skb->dev->type != ARPHRD_ETHER &&
 	    skb->dev->type != ARPHRD_LOOPBACK)
 		return false;
 
-	return !skb_at_tc_ingress(skb) || skb->mac_len == ETH_HLEN;
+	if (skb_at_tc_ingress(skb))
+		return skb->mac_len == ETH_HLEN;
+
+	return pskb_may_pull(skb, ETH_HLEN);
 }
 
 TC_INDIRECT_SCOPE int tcf_ife_act(struct sk_buff *skb,
-- 
2.43.0

