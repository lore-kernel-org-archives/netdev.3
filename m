Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664437;
	b=CZ7o9C05DPf8/maGtyR0NnrcrvWg2kcm15SIlo/wiyOXFyC/B+V83SLN0kJ9lE+CosYI
	 x7/Pg2HtdLJAQX5ZPk5r3GzNwDPsHQouthnRqxGm+MIFo4KALZ/EWmq+7GNqOanjVux6+
	 jk1JmYyfxmFKxcKbRd0VMXmOYP83E7e+I2BzyfQJHTUvWKFFvImf23+rqqXO/xtB+tNTr
	 XZ9aUL7UUjvUys3tZMv0lPWPlFSfcRYFtAP3fBfuzboIqLlAdXfVnAzw3d61aD9jG6M/+
	 yhApcNUvFjLEkSXWeDd2BJkhJvRlw+fJs1Y3mPCToLOM27mDf/RNm3unGNatOaHMbAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=yZ7EjYtEa5nx0ntrmusqQ2YcpiCHaAVmxDpwmQu13OU=;
	b=xAPRF8xI+EyRXgalrE97PErsKIFLZJ+kZASQa7OMscR5VNF3I0dcilgw3KF0YBvMhaJi
	 pmUwUMab7LW43MSE0MCFALJfH7l7y8eqiNYNDiMccjpMwnaK2d37b8k6A3q3ksJUhVLAy
	 2+nSaenK1qGjdGA5krKMOQZxrIzyT5QALLOo+ydavuFLtkiuA/H1IykjOzA4Q5v16MnwM
	 xIWbV/GY/CWuFAsvOtj00qOX+qgfnX4E6N2HAVT9hnfRTz+NNteK20TfyNqW0L3G0ew68
	 OvOi+lRwZM/kph20KkwZ4INnxSIWbgvzUCl2Os+a3EjKd/bMHaR0e/9Lsu41tW1sYsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="eGti/VNW";
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4979606A336
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 00:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4979606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eGti/VNW
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so3880489a12.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 16:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793664436; x=1794269236; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZ7EjYtEa5nx0ntrmusqQ2YcpiCHaAVmxDpwmQu13OU=;
        b=eGti/VNWMf0C20i7CNheDlUGCO/AK48tLIT6OeUYLVDCxe309PBZrjTO0IWFo6LKU4
         /FyiOeEEjo+PnG1EpNobaXvISDUenJfRkrvrZaRfcJZTZddWFJ8ItKB6pLT9ww9NPgbO
         tlRhKgJVy/eKDrLBO50M4HRNnzM9+mbyg9NaXS4qYGkqJ2tWbSK7xuba2iaBtX5cjifI
         bM9m9LHKkL7sJtxjqGjfDC5kOZ6DtaefrhlIdJCh+Dk48mztTz68w+pz9pyQ2AivtXYE
         B/5EVuy4srDYve5CII2dGYocVG76P4gOAvt3bQ//TZzFUI1+IRWgi388KL1xHF2l8Z4i
         eAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664436; x=1794269236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZ7EjYtEa5nx0ntrmusqQ2YcpiCHaAVmxDpwmQu13OU=;
        b=uzWMhW2KeSiC7WB2Fq9W78QJEf2oiG5ge7XXZkLsVLLOMwHUcJeLqbj6P2EvyKhYPA
         xnOiRaRozSH69MqYvAQZf5BJgGrfjCNlJ44rFvowrJajtMDrwuLmXRnANlyjrc3rPeik
         LaUJVQv8r7lnoEwOEglYPkLcq0EuvydAI2jNzxaTH+pnwhJwr+bsU4fkxQQRLzR2nhBL
         1nzTrW98X+2yrUWM76Dk4IkoMxhRJ9TqlAC/eHs8SksSOKKkn4xPSUhZsaf0aWUplyks
         S7ciaY+wJ4DPqK4ULEpxteWurR8EBPLLsH8fKntURE4jg2uwAdtWkqMgMQy/krKfKC8V
         jFVg==
X-Forwarded-Encrypted: i=1; AKwUvBwXqbGY1EJIBX4DpFwMmvMd/TYja37RfNI8TKtMHeNGRXbRsXrn3h0z5YjciKmsaG3SYJ4iO0w=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3ITk7zXQEA/mLj7tZpFeH4ySjiQ3xvuIAeTVkUxSSUrSWvyiS
	xmTjZ/vP7Q8EffL59+1bInhZEqV3u0qf+5zmsgGvGVnzqunhh0ctEri0+RVppxb0c/4Nwfo2HyG
	V/C7u/Q==
X-Received: from pgbj23-n1.prod.google.com ([2002:a05:6a02:61d7:10b0:ccf:d903:c14c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1bc1:b0:3e2:1a3e:395c
 with SMTP id adf61e73a8af0-3e928a51d5dmr10819631637.59.1793664436062; Mon, 02
 Nov 2026 16:07:16 -0800 (PST)
Date: Tue,  3 Nov 2026 00:06:03 +0000
In-Reply-To: <20261103000712.658501-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103000712.658501-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103000712.658501-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/2] tcp: Subtract psp_sk_overhead() in
 __tcp_mtu_to_mss() and tcp_mss_to_mtu().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Thaison Phan <thaisonphan@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, psp_sk_overhead() is added to icsk->icsk_ext_hdr_len.

__tcp_mtu_to_mss() subtracts icsk->icsk_ext_hdr_len from mss
after clamping to tp->rx_opt.mss_clamp, which comes from the
peer's MSS option configured via advmss.

Since PSP is upgraded after TCP_ESTABLISHED, PSP and non-PSP
flows share the same route mtu and advmss.

This makes it impossible to configure a route so that both PSP
and non-PSP flows achieve 4K MSS for TCP_ZEROCOPY_RECEIVE.

With mtu 4220 and advmss 4108 (4096 + 12 TS), non-PSP flows
get 4K MSS, but PSP flows are clamped to 4108 first and then
reduced by 40 bytes to 4056, breaking TCP_ZEROCOPY_RECEIVE.

With mtu 4220 and advmss 4148 to compensate for PSP, PSP flows
get 4K MSS, but non-PSP flows get 4136 bytes, spilling over
4K page and also breaking TCP_ZEROCOPY_RECEIVE.

Let's subtract psp_sk_overhead(sk) before clamping in
__tcp_mtu_to_mss() and add it in tcp_mss_to_mtu() and
to icsk->icsk_mtup.search_high.

Note that tp->rx_opt.mss_clamp now bounds only the inner TCP
segment rather than the outer PSP packet, which is consistent
with xfrm and assumes that the peer's MTU is at least as large
as the local route MTU or that PMTUD is enabled.

Also, in psp_sock_set_tx_key(), icsk->icsk_mtup.search_high is
simply incremented by psp_sk_overhead(sk) because PSP is upgraded
right after TCP_ESTABLISHED before any MTU probe fails in practice.

Reported-by: Thaison Phan <thaisonphan@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_output.c    | 14 +++++++++-----
 net/ipv6/ipv6_sockglue.c |  2 --
 net/psp/psp_sock.c       |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index cf3ddc055d48..08d0d4a639fe 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2060,6 +2060,8 @@ static inline int __tcp_mtu_to_mss(struct sock *sk, int pmtu)
 	 */
 	mss_now = pmtu - icsk->icsk_af_ops->net_header_len - sizeof(struct tcphdr);
 
+	mss_now -= psp_sk_overhead(sk);
+
 	/* Clamp it (mss_clamp does not include tcp options) */
 	if (mss_now > tp->rx_opt.mss_clamp)
 		mss_now = tp->rx_opt.mss_clamp;
@@ -2088,9 +2090,10 @@ int tcp_mss_to_mtu(struct sock *sk, int mss)
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
 	return mss +
-	      tp->tcp_header_len +
-	      icsk->icsk_ext_hdr_len +
-	      icsk->icsk_af_ops->net_header_len;
+		tp->tcp_header_len +
+		psp_sk_overhead(sk) +
+		icsk->icsk_ext_hdr_len +
+		icsk->icsk_af_ops->net_header_len;
 }
 EXPORT_SYMBOL(tcp_mss_to_mtu);
 
@@ -2103,7 +2106,7 @@ void tcp_mtup_init(struct sock *sk)
 
 	icsk->icsk_mtup.enabled = READ_ONCE(net->ipv4.sysctl_tcp_mtu_probing) > 1;
 	icsk->icsk_mtup.search_high = tp->rx_opt.mss_clamp + sizeof(struct tcphdr) +
-			       icsk->icsk_af_ops->net_header_len;
+		psp_sk_overhead(sk) + icsk->icsk_af_ops->net_header_len;
 	icsk->icsk_mtup.search_low = tcp_mss_to_mtu(sk, READ_ONCE(net->ipv4.sysctl_tcp_base_mss));
 	icsk->icsk_mtup.probe_size = 0;
 	if (icsk->icsk_mtup.enabled)
@@ -2643,7 +2646,8 @@ static inline void tcp_mtu_check_reprobe(struct sock *sk)
 		icsk->icsk_mtup.probe_size = 0;
 		icsk->icsk_mtup.search_high = tp->rx_opt.mss_clamp +
 			sizeof(struct tcphdr) +
-			icsk->icsk_af_ops->net_header_len;
+			icsk->icsk_af_ops->net_header_len +
+			psp_sk_overhead(sk);
 		icsk->icsk_mtup.search_low = tcp_mss_to_mtu(sk, mss);
 
 		/* Update probe time stamp */
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4b3536571c98..ea03fcffd147 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -48,7 +48,6 @@
 #include <net/xfrm.h>
 #include <net/compat.h>
 #include <net/seg6.h>
-#include <net/psp.h>
 
 #include <linux/uaccess.h>
 
@@ -109,7 +108,6 @@ struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 			struct inet_connection_sock *icsk = inet_csk(sk);
 
 			icsk->icsk_ext_hdr_len =
-				psp_sk_overhead(sk) +
 				opt->opt_flen + opt->opt_nflen;
 			icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		}
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index a6b1c42dd626..f2cba3fa3a23 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -243,7 +243,7 @@ psp_sock_set_tx_key(struct sock *sk, struct psp_dev *psd, struct psp_assoc *pas,
 	pas->upgrade_seq = tcp_sk(sk)->rcv_nxt;
 
 	icsk = inet_csk(sk);
-	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);
+	icsk->icsk_mtup.search_high += psp_sk_overhead(sk);
 	icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
 
 	return err;
-- 
2.56.0.385.gac671c819a-goog

