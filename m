Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5711EED8
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789224532; cv=none; b=MbfMInVedERqyWrlrX9IF0dW20/7AVceBpU1SoZax/PoRrUZds7ia1+aannD5U4flLr/TzRwIyxwqWnzYXjK7WZucH0ZcsiOXyzegVVgXbXYMZSwiwGRUbgaTmcM1iIm+o+7f7LrQprVBrEJxTB8UxxHHvHhCAKs8nByQuXsAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789224532; c=relaxed/simple;
	bh=c9c5nbx6QkMCv0r3S19yDKG5is0wWwd9bxsvIlf048o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C24/5oAKZIpdYITQOV0R9HjKdRxQ2c8npuIDnUemEMypvcI5QxHD7XYerXz8vLXPdMwkf2TzreknzaHejYGeXpWLwnL/qg+alOxLdQ3QUB3AZ5d0SiMAl7hqFVVffOSVT59ROTQyEef3qiZtQFpKZ5dNHj/MjRg2H9pl062b6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJ6kB9LT; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJ6kB9LT"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530e89b584cso10697021cf.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789224530; x=1789829330; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V68nnfetgPV0z4oofellYAvD3CZanEe6c9ajxPnNXNw=;
        b=FJ6kB9LTOOQdrvMZo2mRETjY6ny4cqPCIfLVdqvJBGm6OkRRgwif9xq6JkKBrJObJW
         jW+MTkK0WcYpBJDMcGSthWY/qpQ3XUgWO3e+aonExsK0w62oE2xfOmuklszmnaq2hvc8
         6bp019a3wIuG78sC5fw+1yf+zwc+/ewj4FhZBMOOwCEwyYkn8v7crrtL0f3LsUwPFz+h
         VfO5TvQq0BalOz9GsHkye5L3/9ODs11ViCS3c2Bd/YaNFuRQsBM8qT0Mbknjmip2+mm1
         XO1v4PkrwKq1aW1vpN15eqoNSetUt7RN2lQacPHi626/fCiAHwbC6MJjI0jtPi7c2sFR
         /BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789224530; x=1789829330;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V68nnfetgPV0z4oofellYAvD3CZanEe6c9ajxPnNXNw=;
        b=JeG5f/8jzH7PTuirwLTBtJ0v5sB6cPr+XAG7rYUoACMR+chL3ImQRC/7/GrSnNFQki
         WfMol2fZ3uougGx1/WadFqN574ZJYnHbsWsmSkkgFNF+BAMV3Nl1FxeVw1Uv4yOe6kjH
         ikBr4mlbOVuf7r9jv2LbugE07MOLBfdFCJ1zIqLgSJCw1pfEcVAbOQPmMUL3TIytEcRK
         xQ5vZ8onWoVAJOMr7WpBqhop8TkkcyAUmeAfW2OZbEyZZT++gKOQMkIBhsTU8kzzViIV
         LX6KOhfCcdIINdo0YhFsdCFVBnrR2FzSgYwnGGa+hf2ZK5BQO0NJOalHJmfekflRC6IM
         l9gg==
X-Forwarded-Encrypted: i=1; AKwUvBwaR13XdDTk0uw1XPHMZzQ3P+FIsdCe2zwpc1khzQa8DezFmSLyQuFRwUxe5ml82K8Ib7q8hZw=@vger.kernel.org
X-Gm-Message-State: AFuF++m+ix09uU7qhkCSaeQs3l8nIqLGW5S1iHlUa6mMTxWPaPuBE882
	Dz5QC2pVFPKfswZneOG23mANPtJQN1xDCZeQ2BCq8wL4aScWkivkdMWlia4QJZp2oP9PFtFMV9b
	lbfFhJSFmQKVgWw==
X-Received: from qtbx12.prod.google.com ([2002:a05:622b:14c:b0:530:d5f8:4d68])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1ba1:b0:530:b2e1:2f3b with SMTP id d75a77b69052e-530e81f8c8cmr41077591cf.50.1789224529480;
 Sat, 12 Sep 2026 07:48:49 -0700 (PDT)
Date: Sat, 12 Sep 2026 14:48:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912144848.3448026-1-edumazet@google.com>
Subject: [PATCH net] tcp: do not let tcp_rmem be set below 4096
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We can hit a division by zero crash in tcp_rcvbuf_grow()
and tcp_rcv_space_adjust():

divide error: 0000 [#1] PREEMPT SMP
RIP: 0010:tcp_rcvbuf_grow+0x187/0x450 net/ipv4/tcp_input.c:939
...
grow = div_u64(((u64)rcvwin << 1) * (newval - oldval), oldval);

The division uses oldval = tp->rcvq_space.space as divisor.
When tp->rcvq_space.space is zero, this leads to a divide-by-zero
exception.

tp->rcvq_space.space is initialized in tcp_init_buffer_space():
    tp->rcvq_space.space = min3(tp->rcv_ssthresh, tp->rcv_wnd,
                                (u32)TCP_INIT_CWND * tp->advmss);

If tcp_rmem[1] is configured to very small values (such as 1),
sk->sk_rcvbuf is initialized to 1. Then tcp_full_space(sk), which
computes (sk->sk_rcvbuf * scaling_ratio) >> 8, truncates to 0.
This sets tp->window_clamp = 0, tp->rcv_ssthresh = 0, and
tp->rcvq_space.space = 0. Later, when data arrives and DRS is invoked,
tcp_rcvbuf_grow() divides by oldval == 0.

Back in 2015, commit b1cb59cf2efe ("net: sysctl_net_core: check SNDBUF
and RCVBUF for min length") ensured that net.core.rmem_default and
net.core.rmem_max cannot be set below SOCK_MIN_RCVBUF. Similarly,
SO_RCVBUF setsockopt enforces max_t(int, val * 2, SOCK_MIN_RCVBUF).

However, net.ipv4.tcp_rmem still had .extra1 = SYSCTL_ONE, allowing
arbitrarily small values.

Because SOCK_MIN_RCVBUF depends on sizeof(struct sk_buff) and cacheline
alignment, its value varies across architectures and configuration options.
Using a fixed constant of 4096 ensures a predictable, architecture-
independent lower bound that is safely above SOCK_MIN_RCVBUF everywhere
and matches the documented 4K default.

Fix this by setting tcp_rmem.extra1 to 4096 and updating the documentation.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/ip-sysctl.rst | 2 ++
 net/ipv4/sysctl_net_ipv4.c             | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index b05829e44d8fcb5efe1a0e27569a5ffa37915e49..f7af0286341c9b20047f4719d4c5b81d3a12a107 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -874,6 +874,8 @@ tcp_rmem - vector of 3 INTEGERs: min, default, max
 	case this value is ignored.
 	Default: between 131072 and 32MB, depending on RAM size.
 
+	Each of the three values cannot be set below 4096.
+
 tcp_sack - BOOLEAN
 	Enable select acknowledgments (SACKS).
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 2f0363bca2a88d68276670cfce6fb04398f82bc5..e3760daa347064cf455d1e6e9bbee390dab930d9 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -51,6 +51,8 @@ static int tcp_ecn_mode_max = 5;
 static u32 icmp_errors_extension_mask_all =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
+static int tcp_min_rcvbuf = 4096;
+
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
 
@@ -1462,7 +1464,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_rmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
+		.extra1		= &tcp_min_rcvbuf,
 	},
 	{
 		.procname	= "tcp_comp_sack_delay_ns",
-- 
2.55.0.1007.g17ff1f9808-goog

