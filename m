Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CFE3CA4B8
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580274; cv=none; b=ZgYw4Rf+0Vld1XGp2nlpSNAASwilaqegoR8T6r/tVnswQqEkItImZVq9QB5fIwlJ+OIUFEX2vsnivXy2zCtGPzoAX5BJf+e6rWHzf+c9lqbEdaYs/rm/tdhvJ+NrvYqtkOlKLtNkV3/cJlJYvES5rV7Q8Hz55nqqSJoMGSMCWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580274; c=relaxed/simple;
	bh=TOAoY85g7R1fCg19Yk8Pg1OjQJ61RAR3DC2r7KzW9pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdUI85+4qRkHBcQyITnbvx8e04x+q1sMgi18nc9xqOn6htedvlGii+aWS9LdrLwEtbb6ankM0TzpcKixd1mJvUKODbLjjkqfjHa+p5mBuqccZ7WL8qH11nwEmf876lRS9jEr+Q9nMou16Ry02nIb2kdkVJYAk+9CMZ9AAK3YUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Bm+q1wEg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Bm+q1wEg"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so4691981a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784580273; x=1785185073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EApeSAZEaVIOU1kfv3a3qR+RN8p7t+ZNg/hKbt9uTCw=;
        b=Bm+q1wEgf4L4T0Gl9LSB5usP06GPSf68v6K4ALZezA1BFbARIpWOru6a1nwsjc3AA6
         /SJAStXgcaGFpx6+vJux43PFLcdOfF4krapMMKYc2EUOLRCV6/EgAdnP6KWBjEbMesMu
         cxflupWiDoQYxIAVzBUuZAvMg5GBFyQ5i+IwNTFUibb+pfFD08jYvK6Hq5ZdjfNyyG0m
         2udQ3z7o6QpEtmP6sLmmR8otJQbaLdpNh1uyzNecRV1+E8ggbqIvTY2Hvhp1DaUGmP2j
         n8S5Wy4wAVziKuhvFhHRJu4fWvqL5K7iaN2uLPlmtTaPPvumU/WzuK/z+/3sF4KfNLdV
         2czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784580273; x=1785185073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EApeSAZEaVIOU1kfv3a3qR+RN8p7t+ZNg/hKbt9uTCw=;
        b=A0QCxk3ZKzy5uWEHzDfLej4wEWt/ooVpI0DwenU7WjKjfUnm1OF0aL5Pof4IkRdHaV
         U+uhk4R8cZGFW22/zQIo4nP0vvEVaEEKzDfnDs1gP42mJbNuOFsqxKWEYl1utLMHMA14
         DkJzgE6zjKTc3TRS24zZAm3As8UouC7UHpMY6hF+9gyLNjdfRnJom26CZecoAIBlP7hO
         n6NdOhT1mUEAoEaNubfbMabe8nxiqU+fgYMkjOsFkqs7OS+ai9MsEMJ5CnohiwMfoX7L
         ckuxlVfLDlvKZTJWJ31F5oAItFCFshgapHaQQq7ZEOI7iXUK4UmMqgd8/eCjHb/23iVJ
         xfgg==
X-Gm-Message-State: AOJu0YywPyYR3O7BOd5QQKY6s5KXLLlaIKNOEIhJhnf0OKnM/Rrnw8b3
	505+SKwmWGygra06rP4h3qHQPrsEqwLtxFRUmpGWKqYNZZKeix4hmMl5ImS9ee9ykw==
X-Gm-Gg: AfdE7ckkeZ56p2KO4fRI7F1SYKAKUSFkK/yHK+K3aGFwtPiUb16DjwBgnop+r812CT4
	ngihCswzL0EBsM/GWAlJKbcMiiuSQMFsewViUk0AaKtsYRnt5U003nw1TOSh9ImMUerUQVWHwq8
	7BTgrYI7lfhaPPvDQLNyIMiRu9ovYX5Vl0UyQtLbOV3Ldif7MP7EdkGG3ZzXEzx0kc40OIKxZQx
	kY4ihTrNdL9pwPFzW94OilqxwFcGAr4iDit4j+4uwkCfsvc1KFEtUKjT+YVfl0tKcoCFG787FEz
	s+EvWkseKNUM6//d/Vc6sJsONadGkiRoHKuPful944NfvnfnfF3r6eXk06VkGdDdjaQfo7vHqv6
	LiiMdGeKJIuBjxBILVG09MZurTHBcvPgiV9jjwTx3jHzyqhrLVz9wxGfjIwfbIXrKrD8MG/juXp
	Vah4D4Wng=
X-Received: by 2002:a05:6a21:114c:b0:3c1:d78:6457 with SMTP id adf61e73a8af0-3c3ad80c405mr15914125637.32.1784580272829;
        Mon, 20 Jul 2026 13:44:32 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1dde81sm67750924eec.21.2026.07.20.13.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:44:32 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Ryoga Saito <contact@proelbtn.com>,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] seg6: fix NULL deref in input_action_end_dx{4,6}_finish() after nf hook
Date: Mon, 20 Jul 2026 20:44:29 +0000
Message-ID: <20260720204430.1886091-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nf_hooks_lwtunnel is enabled, the End.DX4/End.DX6 actions dispatch
the decapsulated inner packet through the NF_INET_PRE_ROUTING hook chain
with input_action_end_dx{4,6}_finish() as the okfn. Both functions read
the lwtunnel state via orig_dst = skb_dst(skb) and dereference
orig_dst->lwtstate.

A hook in that chain can legitimately drop the dst: nf_nat_ipv{4,6}_in()
calls skb_dst_drop(skb) when a DNAT rule rewrites the destination
address, leaving skb_dst(skb) NULL. The okfn then dereferences a NULL
orig_dst, causing a general protection fault and a panic (the fault
happens in softirq NAPI receive context).

Free the skb and bail out when the dst was dropped, instead of
proceeding with a lost lwtunnel state.

  Oops: general protection fault, probably for non-canonical address...
  KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
  RIP: 0010:input_action_end_dx6_finish (net/ipv6/seg6_local.c:912)
  Call Trace:
   input_action_end_dx6 (net/ipv6/seg6_local.c:946)
   seg6_local_input_core (net/ipv6/seg6_local.c:1621)
   seg6_local_input (net/ipv6/seg6_local.c:1643)
   lwtunnel_input (net/core/lwtunnel.c:465)
   ipv6_rcv (net/ipv6/ip6_input.c:351)
   __netif_receive_skb_core.constprop.0 (net/core/dev.c:6165)
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/ipv6/seg6_local.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2b41e4c0dddd..45e66ba306ca 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -909,6 +909,11 @@ static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
 	struct in6_addr *nhaddr = NULL;
 	struct seg6_local_lwt *slwt;
 
+	if (!orig_dst) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
 
 	/* The inner packet is not associated to any local interface,
@@ -962,6 +967,11 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 	struct iphdr *iph;
 	__be32 nhaddr;
 
+	if (!orig_dst) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
 
 	iph = ip_hdr(skb);
-- 
2.43.0

