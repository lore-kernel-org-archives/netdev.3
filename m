Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560898;
	b=Ef1hC3jwwVnzycmkk0HbwR0VbAIrgfpFqXzBrNqdeKzFY6FRsQRmJ/5zK20FuRr8fZ9T
	 S4EbilkX3g8PmQS6R3icw/RopEeCnmglTjN3DwwxGrYSa94S62n+gYNdhmMCSCRZ565IU
	 iSOpqI84co3PZiyIxiV7bytPWw6hy09C9dQWadV8rV905mTwPRuFg5cR7mWP3ONLj8C/+
	 wKZlSV05V9ZyEgwIosQorZcbeKW8Odt+WdfE5nE/e1gwPHhFgjRJfrW18MyW0Zp+NYsfm
	 Sm9l3hGoc1kaVg+YJ35Oh4ie2ZiqNdiOS2+5lt0Lh+ghlr+RNnMdD/4ZL2l/M0R9QoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dz6pRM/Io22GYPHM6stLxgSNOJoApnHNm/0rCYVyXHY=;
	b=xR5aK7w5DM53j5eIF0pumdZ2GqeVhAV5rD8KJqu70/t+A19FnW9RJQ9DHL5CIE1D8kTy
	 foknbreyV6VelKTM/o4mKyUFN52olBGDG1gweb1kvQVgFVRX6gDZmIREvDKMyaSSu8gWC
	 QGsRoqhzUqRjzzHrJ1SMi/4z0G29Wtrhauv2zUT7YARJzeRGShKKAnA3c5kHsWMvlpUaP
	 cf/QBVJnHiPWsGQ0naZ826ObtQ13T6ubnwYzpDCEJIBj+nP/cOL3mIJjpGq+NPoUltwNZ
	 KYCAZaCJy+Xvbx3cxpMSP9wrZeRlc27UsQmnco48iYKX4Qbn3LgMCSpR/cFc7oA1XEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HnkGGTnF;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B36F606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B36F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HnkGGTnF
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso767243a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560897; x=1794165697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dz6pRM/Io22GYPHM6stLxgSNOJoApnHNm/0rCYVyXHY=;
        b=HnkGGTnFHsJZYQGgLpwCXsLPu5A5AkoaltOAKmUyQu8Uak2XauIWb75LliZ7KlENkS
         mM1KPNZt2tmxvoHPH4948xnz91Sj/4udRUC7us5ARsXrbl9AeHOV/e285a0WeeAbv0h0
         r4UeevLiFYPyxh4uGePmgzHjiyWzCwt42XkZMd/97gnwDCkbZxKVbFRLtNwptVgBE0s0
         AUJ3ghyqCYBKLeaqwN1S2jjZv2eJWWEtXKr4+B7dZZg0ffZY7k3Z+VJkX/NhjIr/UsYW
         NNUi5baESdurkGz/pVuHsGroq0gtcDfzCENIq9QkVa9pmMSeDVh70TLqtbgxnV4qHHzq
         d1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560897; x=1794165697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dz6pRM/Io22GYPHM6stLxgSNOJoApnHNm/0rCYVyXHY=;
        b=ExoVNS5CkWDsYXKyL4+m9mIi3ZW1Olzxs52q9M0Wux9mDDxdXuST+BrdydB4lVd5YB
         de3Vwi49NzArgUEjnCzzg6Fsqli1kvLzTvav1lKFu5d8m+Kt/w2/YiXip2Frvm49MqlM
         rnl6U1yeXAZ+inm3LEwpB6gHQX8vrOtQgFXFUyV9Ty8xZIOl9d3uwDZkp71sUB4BhSSK
         T45hQnUDHX0tGhZ9Rs66SwqutWalfq5ZPHzSoIpdynFDEBRLBvNdUJwfkSVM3/tZbPns
         CNCfw6jewYTCwAR+OxATnwULm6vqp4YIxDKvP8dHTqC564A6f9AGt0xAnDw1wZ8jOL6y
         Wj1A==
X-Forwarded-Encrypted: i=1; AKwUvByItsynz1c+u66N1+B8DXqMcWrE+QyoUF5QIHXnaKabDgAYooAvdLrD89AyaeG7TnqiBmNxPXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Stg4tp5Jkdk6gYORk8lk7gj/xeFexBrZo5RUeApws0CKhJIxF
	nAajEs69WvwJks6Sucz7ZXuQ9NpeSG+9gWgrbGEOm5QJlQ9krA49VNgOsi0rfw==
X-Gm-Gg: AYBFou0cGKAMUkpU3G2rxYQ1H7ZCHGya262OxES7Eqymp9haSGqT2xFtiWxUy7P46Hw
	PO18n+oeZcWpRf15Qw1YogpG3Wmi6EH/6wKRSQjy1R5rhq7gj2GC2IblOP5MWUA3TkBUjjrLKln
	0ZqA87VGze6shX1B/zPn+yGLVLnYnj6uR/LyYUaiwKlIGEjXlaK4rw97lJXSRY+1KBySW4KYhmg
	ybaDCm6HlZWabxsUNAMgLjeZDpVFMd2Lr8V7Qur5YvNhJYcYLJdEYJtFJ2qLMQCnfd5MTfRJ0sC
	u2cPNsCNbbO+y5YERDivTJrRP6A6dzuOtqsRuL+d7PCxKWGxdtbn/oE9bUxIemvk/YMQQm2t6sN
	DV981bmvcBQNvSCFyhRnhD9A9HpDGbZYJCsU+yEfBgJcpbax2r/plv3xHGzVcipy+wEIDRHX703
	M4n6fiKxBCuE7uBSByKbJIaJVA0Oh2qFYVNol6pJkc16wUlX1Km6PA8QIGMopB6gqxkeGhDCB7E
	RszmKkfGMvGS8Xz/zM1oJc19nEOL9IRSgmGDibU/sqYXAS9GyZLUjwh7SbKH0x7n3iEUeE+gNAP
	vYvxtCW4+FY4lTWpD0hQZfr2vr8/qXHcUNXNCrJ2ZGNCsgjzNh2RhJw+UoLoe2XVAXQO37qgN+j
	aUoG54kunUKpG6JeEaiSENQSAKSB2eyk5u5Y/k+NC6WPftBr8mMBJyMtgHF8ypFoqEBOo4dfRhi
	a1P1za/sZM0Ot7MGLyltI=
X-Received: by 2002:a17:90b:2549:b0:3ac:a7ee:678c with SMTP id 98e67ed59e1d1-3ae89536be7mr6671928a91.2.1793560897506;
        Sun, 01 Nov 2026 11:21:37 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm15650206a91.7.2026.11.01.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 06/15] bpf, sockmap: Give no progs to a TCP listener
Date: Sun,  1 Nov 2026 19:20:48 +0000
Message-ID: <20261101192057.2296489-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

A psock with a verdict prog replaces sk_data_ready and sk_write_space of
its socket. It saves the old callbacks, and the new callbacks call them.
sock_map_link() does this to a TCP listener too. Its new sk_data_ready
cannot read and does not call the old one. Thus it does not wake accept().

sk_clone() copies the new callbacks to each child, but not the psock.
tcp_bpf_clone() restores only sk_prot. Without a psock the child loses data
or does not wake its reader. If it gets a psock, the psock saves the copies
as the old callbacks. Then sk_psock_verdict_data_ready() calls itself until
the stack overflows. sk_psock_write_space() calls itself too, without end.

Give no progs to a TCP listener, as before the first commit below. A
listener receives and sends no data. It stays in the map and keeps its own
callbacks. Add this exception to map_sockmap.rst. A listener no longer gets
-EBUSY from a second map with progs of the same kind.

Since the second commit below, a socket keeps its psock when TCP unhashes
it. sock_map_link() does not see the state that the socket gets later. Do
not depend on TCP to keep such a socket out of TCP_LISTEN. Set both
callbacks in tcp_bpf_clone() to the TCP defaults.

Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/map_sockmap.rst |  4 +++-
 net/core/sock_map.c               |  9 +++++++++
 net/ipv4/tcp_bpf.c                | 15 +++++++++++++--
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
index 2d630686a00b..eb466b86df17 100644
--- a/Documentation/bpf/map_sockmap.rst
+++ b/Documentation/bpf/map_sockmap.rst
@@ -33,7 +33,9 @@ of ``__SK_DROP``, ``__SK_PASS``, or ``__SK_REDIRECT``.
 
 When a socket is inserted into one of these maps, its socket callbacks are
 replaced and a ``struct sk_psock`` is attached to it. Additionally, this
-``sk_psock`` inherits the programs that are attached to the map.
+``sk_psock`` inherits the programs that are attached to the map. A TCP listener
+is an exception. It gets a ``struct sk_psock``, but it keeps its callbacks and
+inherits no programs.
 
 A sock object may be in multiple maps, but can only inherit a single
 parse or verdict program. If adding a sock object to a map would result
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index efe49551caba..282c6a4b2b05 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -228,6 +228,14 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 	struct sk_psock *psock;
 	int ret;
 
+	/*
+	 * A listener receives no data. With the callbacks of a verdict program
+	 * or a parser it would no longer wake accept(), and its children would
+	 * copy them.
+	 */
+	if (sk_is_tcp(sk) && sk->sk_state == TCP_LISTEN)
+		goto no_progs;
+
 	stream_verdict = READ_ONCE(progs->stream_verdict);
 	if (stream_verdict) {
 		stream_verdict = bpf_prog_inc_not_zero(stream_verdict);
@@ -262,6 +270,7 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 		}
 	}
 
+no_progs:
 	psock = sock_map_psock_get_checked(sk);
 	if (IS_ERR(psock)) {
 		ret = PTR_ERR(psock);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b9761af13989..aa904ded816f 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -777,7 +777,18 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
 {
 	struct proto *prot = newsk->sk_prot;
 
-	if (is_insidevar(prot, tcp_bpf_prots))
-		newsk->sk_prot = sk->sk_prot_creator;
+	if (!is_insidevar(prot, tcp_bpf_prots))
+		return;
+
+	newsk->sk_prot = sk->sk_prot_creator;
+	/*
+	 * sock_map_link() gives a listener no programs, but a socket which got
+	 * them in another state and listens now has the psock's sk_data_ready
+	 * and sk_write_space, and sock_copy() has copied them.
+	 * sk_psock_init() refuses a socket that has sk_user_data or a ULP, so
+	 * what the psock replaced were the defaults of a TCP socket.
+	 */
+	newsk->sk_data_ready = sock_def_readable;
+	newsk->sk_write_space = sk_stream_write_space;
 }
 #endif /* CONFIG_BPF_SYSCALL */
-- 
2.55.0

