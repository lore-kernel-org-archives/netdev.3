Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811029;
	b=yYcJgmt0kiybLWIpZqttBem5LBSzOrGDOAZq2oQicMT3YZAtUNEygTU4o4deLXI5vJ9G
	 fi+ahDjvf7roT5mjXIndgPr6Tm65UPMGxNthcO2r4ekGwHXdCPBHHE2J75poU/bK8H8yz
	 6JSr0Yoow3LYbxqXE8JRUfjRcF9o370G/6B1VWTXXH3uIoeJfL7d6YpZI6UMKppS7NcwU
	 zJQnkyYAmRjtg/zUFuYihUNnzep8RS2mjT+sVqTCYpxh/fAhlupbudz/2ESFmSerjpcg+
	 CaJXYRvEIz9f880XNns8yRVDedMBbUPUis0IkjWW/egQz9i2eWvpODcttSe05wmZBxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=wRLlZ1j87EtkCty0brvd94nJUm5Ap97e5SuLylI9V0s=;
	b=3YX73qdUq2F2dSxcZn6ctUS93MkXBUO5l38WasFULPV98+6SgTjQj2eiBpL8zPdVane3
	 8iID7KxCp78LMwoOI+4eY3gJmPUxD2ZoGvaTmLnmsWMtiCTC9r1Tvf/z/xx+cIb0sZibZ
	 lYI43PPvP+rdyrk8Ph/mH2MUUnmfyq7f+qDlS+LiyD1ClTR+9wzX+O9365T81aNKPShXB
	 QAdXmAEyw4GA/hnTVAx8SwcBFw238BSDXQ3rnouseEtdNDdGXbXAXp9Cdfeuqh9ocIQ38
	 VLp9ALv3T1eto8eMG6YwlSafljzU5htM4VHzQFuAskQkyTzkaospNZs7CdKMOh0O5rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QQHGNMb+;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2076083625
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A2076083625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QQHGNMb+
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac6795617aso904088a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793811029; x=1794415829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wRLlZ1j87EtkCty0brvd94nJUm5Ap97e5SuLylI9V0s=;
        b=QQHGNMb+0QXTkb2xaMhIE2o6wJ/UCFPrA+wH8ibIlleVEWiQw5/+2Rh37PV7u3m5dy
         WHrJTfhMVXtdu/kt8bJ5Fc+fd6snIC4EKWU+VK3oRSF2jq9m78AlYfdJ7Sm2M1MTt38I
         cgJlFeXE3IB3O0BMMpoJy/RsQbeKQiKBT+gvXLHfVH/K2NkQ2RNdM9dLaVziveZqjVXR
         X9ua81BZFJ+NT5/IOXyWU3n3fD18Sjsnek2phpfPNKIV2kMTGux8x40l5Cq8ht22eqlh
         pcQYQnn1gGgW2T9438cJF45cJrPVKNz3DOtc2EtuQA/Mn38nbVOezV1b4yO0tJRY9VSV
         SB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811029; x=1794415829;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wRLlZ1j87EtkCty0brvd94nJUm5Ap97e5SuLylI9V0s=;
        b=X4jdblrdcHUNm2j6uL6riTKc937RSNYKOrJa60f2amzi72QQ/JDr0v2e7ufXg8P6Wv
         KHQuLKmqmkimpsHKW6aC8DDmg/anJLbaaN56bLR4SCofR6sHX+WYmusDnzrA1cbQuZhU
         vuNhGtPG+JB6+D5ojy1juB7H8+b4iMKL4vcJGEyAxToAA5svjhLG3oZJFVxFBc5iN8qG
         7d35WWUaJebXMV53bRVG//XOSe0xSgGAjpdrtQT2DEF1XsDxbIgQSHKo56PtA0DaDQRW
         zhWfVd9+LqwuejN6rMiXQC2s0zkuBFdH37ntaaQIzt1g9ymnAWTljZ3znfEK2VyC0sIw
         Fkjw==
X-Forwarded-Encrypted: i=1; AKwUvByc3IJ4zmAYeWbw82fQWKB2MrmLzoKW8UE60wHojBwzY4Px3xRkEZKwNb05vSXeUpp0xO2xzmU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GooHmRwfG44WOvni3AXxzPwVCaZmI+fzIKnb2K2RR+jwq8qhv
	NtNASYCH8Kwcn4uzuZdbS235FOrcsOJ8w7A8qEhFU5ukuJjvKldJG3gTD8TQDOlnYKZzFjGmJZT
	7XQjlEQ==
X-Received: from pjbhk4.prod.google.com ([2002:a17:90b:2244:b0:3ae:49df:2522])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ccc:b0:3a8:32f2:f4a5
 with SMTP id 98e67ed59e1d1-3ae898385aemr14324010a91.53.1793811028658; Wed, 04
 Nov 2026 08:50:28 -0800 (PST)
Date: Wed,  4 Nov 2026 16:49:56 +0000
In-Reply-To: <20261104165025.1026357-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104165025.1026357-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104165025.1026357-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/2] tcp: Don't call tcp_update_recv_tstamps() if
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
 include/net/sock.h |  7 +++++++
 net/ipv4/tcp.c     | 12 +++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 173b37b2b8bb..ba310182e6cc 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1063,6 +1063,13 @@ static inline bool sock_flag(const struct sock *sk, =
enum sock_flags flag)
 	return test_bit(flag, &sk->sk_flags);
 }
=20
+static inline bool sk_want_rx_tstamps(const struct sock *sk)
+{
+	return READ_ONCE(sk->sk_flags) &
+		((1UL << SOCK_RCVTSTAMP) |
+		 (1UL << SOCK_TIMESTAMPING_ANY));
+}
+
 #ifdef CONFIG_NET
 DECLARE_STATIC_KEY_FALSE(memalloc_socks_key);
 static inline int sk_memalloc_socks(void)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b9de7c302ba8..4166be09b826 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1878,6 +1878,12 @@ void tcp_set_rcvbuf(struct sock *sk, int val)
 	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
 }
=20
+static bool tcp_want_rx_tstamps(struct sock *sk, struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->has_rxtstamp &&
+		sk_want_rx_tstamps(sk);
+}
+
 #ifdef CONFIG_MMU
 static const struct vm_operations_struct tcp_vm_ops =3D {
 };
@@ -2069,7 +2075,7 @@ static int tcp_zc_handle_leftover(struct tcp_zerocopy=
_receive *zc,
 		offset =3D *seq - TCP_SKB_CB(skb)->seq;
 	} else {
 		skb =3D tcp_recv_skb(sk, *seq, &offset);
-		if (TCP_SKB_CB(skb)->has_rxtstamp) {
+		if (tcp_want_rx_tstamps(sk, skb)) {
 			tcp_update_recv_tstamps(skb, tss);
 			zc->msg_flags |=3D TCP_CMSG_TS;
 		}
@@ -2280,7 +2286,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 			if (!skb_frags_readable(skb))
 				break;
=20
-			if (TCP_SKB_CB(skb)->has_rxtstamp) {
+			if (tcp_want_rx_tstamps(sk, skb)) {
 				tcp_update_recv_tstamps(skb, tss);
 				zc->msg_flags |=3D TCP_CMSG_TS;
 			}
@@ -2893,7 +2899,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct=
 msghdr *msg, size_t len,
 			tcp_fast_path_check(sk);
 		}
=20
-		if (TCP_SKB_CB(skb)->has_rxtstamp) {
+		if (tcp_want_rx_tstamps(sk, skb)) {
 			tcp_update_recv_tstamps(skb, tss);
 			*cmsg_flags |=3D TCP_CMSG_TS;
 		}
--=20
2.56.0.385.gac671c819a-goog

