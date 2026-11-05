Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915533;
	b=5RybN6mNzhbZ1Plihhr96gjdOAWhZ9aWNayVR4BvQdxPOdt7lcka790qAtY/kOmF2rRV
	 l8Njlb0OQU2S5HsWcczR3bWLY1z7aUeq/qnkxsTeaZf0Di62Dha6k6ao/9V943ixeAVOF
	 jNRc6my4UAff7w9tR67eeG+NY/pFMeLgNpUczH5bgqwbpjRaAIxdA8PEEX68OwgbKR1VQ
	 ztZwYO30OD8WvxoNbQmhXfABfwtd3I2/jIjMflnWy8ASEWFEeuTCRXBf+9VKQc5Y8OFW3
	 QO7DjfCr8w4XMQ27jU5rmg2J+hWYSordMQJ0YYOxEIm4HkafyL0fF6Ka6+gQBT40vDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2nOPP03gnBdT5M1/cSkN1tNTvdrb6gjd5zrbYYhQ6Fw=;
	b=iXlVUM26TU4qwQAgvll+EhssLCIasDUuUCMZBsTckLIxM9eCzOwGcIJIpPyVKkEw6119
	 qUwoSIEIddaY/SCiId5NyVPuYSv/HAwMQ1zdQ/9C0HVtBcWWBj1Pt+shf4bfmGKIAMbVN
	 vfqbtzLXvTSopDCubVbFX04c3Avz9x4N+keGCbk+3COpeoBIfdAxTylXcmjlwKkt9izQI
	 WPHAnHkCul+CfvjhRwFBI4au2PUy8ChHCgQAfg8tPF0YQ1oEJZWYFOrgSg7QgvgWUrfv8
	 W9DNSsujGcNdCA4XLjnHN25SFOWxngZMUpKszsN+5cRwKxL4OImxLIzAB0C0e+LWazA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MGIGaMX+;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F98606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F98606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MGIGaMX+
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad91787a1aso5274a91.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793915532; x=1794520332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2nOPP03gnBdT5M1/cSkN1tNTvdrb6gjd5zrbYYhQ6Fw=;
        b=MGIGaMX+IRsnMi+j1KQCCNy2MIHC/zsd/PgmnUwNx4qlJy+UxZT0r6IUSPgGOJ1DRz
         8RNkAphQkqCAbTza35eQ697rI1w7SiKKGPLL6tz+wqq9oP1CoDEmYoUGPEMfD1szybFa
         AvcjXrMEnI+/9HDhTH4c2QnrtUb+5LYa8n/Qf5ekjLXR8lnaUSAHsEh81c3+S+QWC/qt
         xeuJyEXHkh6JyPe3n6RxrNGn+HrYTFyq3Bob73aUZhwqVxunrTs/7eNgBzbG7QA2BFq5
         em3ryB6hwHbfR3eJgixScybNdKehdiC7Snhl0KOaBdXzIEZL8fmPMHQj01cz2V+C18Cf
         VnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915532; x=1794520332;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2nOPP03gnBdT5M1/cSkN1tNTvdrb6gjd5zrbYYhQ6Fw=;
        b=MRD0bBaaBWLLaZeOl5guTU6mZpUVMCcW2gRFuw7xGYTZxv9xF4S0wqmwHMvZknmCEk
         rJh26gAIUmhOgHws9H6pVi5HTB7EMDI6/aZjPNcMBMacbd0/ow54Navnlj9qotR2Nke1
         MeXj6b6QNRNUKlvbmVjlvek9z2KU0uXzcuGQY4yyOCkOXt9gwwM0K3pWSyTZdvKDXn2c
         OT4OIgGB3wF2ROtqDTzJR7NSFoFX8hg22JJMVTVUUbJyUkYqljrq4FZYKApG1WQDlmG8
         7i2uStt7rqGhdiXyp9r/KW5ifuUzqGi3YLbBrTIPB0jv7nH9FlYkgaGFlhgPO2R3Y1mj
         5KVg==
X-Forwarded-Encrypted: i=1; AKwUvBx2G8zQBRTKGzjDGog4iClCCDA40qpJChQUs5h5WegXoHMc+VD4AtHD5d12EfdKGUw+xxUllk4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iBkAURHtjV1coLXPaQl0t62fgpTKgNAMk7d7j05BtrJ3FRVf9
	nIM42/RJYqq+pY4vbDey6W/0YHEXTaTtbYR7d77gkwpmteuccS6u8twKeU8cOri7osghfl6esrA
	49XWA2Q==
X-Received: from pjbrm13.prod.google.com ([2002:a17:90b:3ecd:b0:3ae:9bbb:7d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c8:b0:3ab:c80:9365
 with SMTP id 98e67ed59e1d1-3b0db717fb6mr294387a91.42.1793915531787; Thu, 05
 Nov 2026 13:52:11 -0800 (PST)
Date: Thu,  5 Nov 2026 21:51:45 +0000
In-Reply-To: <20261105215209.3160316-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105215209.3160316-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261105215209.3160316-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/2] tcp: Don't call tcp_update_recv_tstamps() if
 not needed.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When RX HWtstamp is enabled on NIC, skb_hwtstamps(skb)->hwtstamp
is set, which sets TCP_SKB_CB(skb)->has_rxtstamp to true.

In addition, TCP_SKB_CB(skb)->has_rxtstamp is also set from
skb->tstamp, which is set when one socket (e.g. tcpdump, PTP
daemon, etc) enables software RX timestamps (netstamp_needed_key).

Then, tcp_recvmsg_locked() always calls tcp_update_recv_tstamps()
and sets TCP_CMSG_TS to cmsg_flags so that later tcp_recvmsg()
calls tcp_recv_timestamp() after release_sock().

If a socket does not have SOCK_RCVTSTAMP in sk->sk_flags or any
flags set in sk->sk_tsflags, tcp_recv_timestamp() does nothing.

However, it is not free because sk->sk_tsflags shares the same
cacheline with sk->sk_forward_alloc, which is always modified
under lock_sock()/bh_lock_sock(), causing cacheline bouncing.

   0.31 =E2=94=82 403:   test   %al,%al
   0.02 =E2=94=82      =E2=86=93 je     4a0
  12.40 =E2=94=82        test   $0x2,%bpl        ; if (cmsg_flags & TCP_CMS=
G_TS)
        =E2=94=82      =E2=86=93 je     48f
  11.59 =E2=94=82        mov    0x60(%r14),%r15  ; sock_flag(sk, SOCK_TSTAM=
P_NEW)
  12.25 =E2=94=82        mov    0x170(%r14),%ebx ; READ_ONCE(sk->sk_tsflags=
)
  20.70 =E2=94=82        mov    0xd0(%rsp),%rdi  ; if (tss->ts[0]) {
   0.39 =E2=94=82        test   %rdi,%rdi
        =E2=94=82      =E2=86=93 je     44c

Also, sk->sk_flags is on the cold cacheline in tcp_recvmsg().

Commit f0e70409b7eb ("net: avoid unconditionally touching
sk_tsflags on RX") introduced SOCK_TIMESTAMPING_ANY to avoid
such false sharing.

Let's check SOCK_RCVTSTAMP and SOCK_TIMESTAMPING_ANY under
lock_sock().

We still need to touch sk->sk_flags, but with this change,
tcp_rr -T 128 -F 10000 gains ~3% more throughput on AMD EPYC
7B12 Zen 2 Rome (2 sockets, 256 vCPUs).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Mention software tstamp
  * s/sk_want_rx_tstamps/tcp_want_rx_tstamp_cmsg/ and
    moved to include/net/tcp.h
  * Use const in tcp_want_rx_tstamp()
---
 include/net/tcp.h |  7 +++++++
 net/ipv4/tcp.c    | 13 ++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3560adddf821..f265ae06bb55 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -517,6 +517,13 @@ int tcp_set_rcvlowat(struct sock *sk, int val);
 void tcp_set_rcvbuf(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
=20
+static inline bool tcp_want_rx_tstamp_cmsg(const struct sock *sk)
+{
+	return READ_ONCE(sk->sk_flags) &
+		((1UL << SOCK_RCVTSTAMP) |
+		 (1UL << SOCK_TIMESTAMPING_ANY));
+}
+
 static inline void
 tcp_update_recv_tstamps(struct sk_buff *skb,
 			struct scm_timestamping_internal *tss)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b9de7c302ba8..a1f89c1fa2ae 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1878,6 +1878,13 @@ void tcp_set_rcvbuf(struct sock *sk, int val)
 	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
 }
=20
+static bool tcp_want_rx_tstamp(const struct sock *sk,
+			       const struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->has_rxtstamp &&
+		tcp_want_rx_tstamp_cmsg(sk);
+}
+
 #ifdef CONFIG_MMU
 static const struct vm_operations_struct tcp_vm_ops =3D {
 };
@@ -2069,7 +2076,7 @@ static int tcp_zc_handle_leftover(struct tcp_zerocopy=
_receive *zc,
 		offset =3D *seq - TCP_SKB_CB(skb)->seq;
 	} else {
 		skb =3D tcp_recv_skb(sk, *seq, &offset);
-		if (TCP_SKB_CB(skb)->has_rxtstamp) {
+		if (tcp_want_rx_tstamp(sk, skb)) {
 			tcp_update_recv_tstamps(skb, tss);
 			zc->msg_flags |=3D TCP_CMSG_TS;
 		}
@@ -2280,7 +2287,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 			if (!skb_frags_readable(skb))
 				break;
=20
-			if (TCP_SKB_CB(skb)->has_rxtstamp) {
+			if (tcp_want_rx_tstamp(sk, skb)) {
 				tcp_update_recv_tstamps(skb, tss);
 				zc->msg_flags |=3D TCP_CMSG_TS;
 			}
@@ -2893,7 +2900,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct=
 msghdr *msg, size_t len,
 			tcp_fast_path_check(sk);
 		}
=20
-		if (TCP_SKB_CB(skb)->has_rxtstamp) {
+		if (tcp_want_rx_tstamp(sk, skb)) {
 			tcp_update_recv_tstamps(skb, tss);
 			*cmsg_flags |=3D TCP_CMSG_TS;
 		}
--=20
2.56.0.455.g6c5a503b38-goog

