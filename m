Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604117;
	b=CJBG6Qm+GN7wRUeRoh/kC5RPKZPXSXo/5GJxZcsSF3Xru2kZf3HKQHWDIqRSlxsL0oor
	 zrH2gCBr1TmuRJYT+6or6tK5RBxOzlQyt2TxaJYcLZVh37ACF17U1negUZJ4chUSkMaSN
	 0bpyWaLcFGFVQHNeNJVQxurJSLLQNlIisRw8aF3pGK1gZ9Rxg9mQs+f/gmw5vDM5VSVkE
	 iu24G5fFPTyi/wT2eeftBs560pDSm591xFcEcdnTreGl64tP2LMeyGH6bf0svcs7HpIiY
	 3lnQROaL2tFNDnIrSFp20y1rn5Gf8qaz/ZMQw9E77GfEH5m2ELcpRnhJrOr5u55/I6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DJmLVVVW+5deakG/rXx9rSWGIQrWi9+mRR7c5J3o35Y=;
	b=d/GOHaETw8k89gcCmT7SmD05fe18twLcCKzhs4DeWogC7ONx7LbaTJnb5QhjM3PdggDZ
	 22HsvJEI1KdY8FrYx3Okj53jjMKO8hunvLKz5+XQpOuoneTKD1xS26Z222ofJSj+G3iCr
	 Rw06PYUCSMj0il+XcFuqlIvJd7lTk5Qxk04XRuzuXBmGxNfvgUCaIwRx159BVlUtFMixe
	 kS8yFZEM05Ztc9paP9Uxvw5PVQyUSZm6JpfPJdY+fPHh9kNiioadoJQJQof1lqUrUU9sU
	 7IW6b2WyEgf1pq/CJYIeKgSOB6xa53uhSTrXujNJaV0kZ41oLKtMkSkhOzHRrts18FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IdpUE4co;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA51606A32F
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA51606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IdpUE4co
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1524370a91.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604117; x=1794208917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJmLVVVW+5deakG/rXx9rSWGIQrWi9+mRR7c5J3o35Y=;
        b=IdpUE4co+PiPL+yBruoswBCDY/L7XhxHdcQl33YTywzuQmWl8ALc5aW/xDhTw4XP8v
         MYzTogUNvP7snu5urYgumlPcJGb27Fy0/lF5xalEmXhMDggU53fxv02ustaGqq45m7/y
         aGDPAYi+jQTS5gwRwy6HjICy0fgfwW1rxnTtVCsomE3sbpSKZDr9vYFU+g5rE/nZaoKq
         Gz1gqks4iRsR9YkNY4APSLZzKsAxCxk55JaORcmN2oVuGbPVI42fb1oykSqexreBro+4
         ce+vhUMVDixgaA8xhTI2sJ5tZ7RHk1WJw8ayNh5kL9lnyIIWLcr3y3DS90vT3LmGLia9
         YWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604117; x=1794208917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DJmLVVVW+5deakG/rXx9rSWGIQrWi9+mRR7c5J3o35Y=;
        b=N1BmMSTanYK2PgeEHzpFZKICSHWkEhD4NkeH0PFDRWaBf4SQobo3F9gDc4DjhtPthE
         dolUva0Z2GCJFoCauuo/7kXuPpWVsxLgIrzZyaaxmGfKtTdgH2vZTDN96odCAUy0PgeP
         foKJGOnZlKNrP6nV64Hldg9+ZvUJCh+p55V5qoC80BmzEvlYf+OtvSzhejWlDgiVasfQ
         Xx0hcfaVSI1fvUiro0fI8GOnijKoF/qpMo3MBD1b98fNuv9lynaT10+RFBFkszC7kOWN
         ciGS8sjxA6eohFuSwefWhA/7PDgzkfhRKVZymtL0BliW5eLPKlcKT5+VKXi4kdkwFESl
         0s6Q==
X-Forwarded-Encrypted: i=1; AKwUvByFr2SrkRVhUz3Q/cDcbt6JUYHCKrx7RKG69td3NysCs6FV8O9DqleuHbn/UtYdhRcs9wlVL9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Jz5kuDlu4KZ6OjjtyUl4ehaYQe3n5uwWpQpPp5KUvJLIy8qW4
	PbjoStpReOyevoGtepyJHTxONg01adUNh1CQI+GCKL8clwpB4jrZVItJ
X-Gm-Gg: AYBFou1KraTZBq2x9J/b9j3RjnzVJHXqhLefT1fpLKbeXyrTH8ruSEHP/aKjfVXbi9b
	BzYb5tpIPcZ9Vm5YjJaP2KJD7GQCKM0YLWCeYkNPwrcE2Q8/C0RDtiTBgXhn/EaeOrBPMOcpe1g
	xRI9zNzC2JXLCbINl+ju5rMS3f2tbuTMZ3tcWK0mSJEc0Bw3b5mELJydBjTXhJ7B/jCJFfMaukl
	xiS82oxWP90lHIIzFgDBhSocKLmMrXShP+9xCpPdY1ZvLzjC1PMjdUfTeyDrKUIsqMsCaqRNoTc
	KQ4BCGo/gxTvz5Miv07tZbv3iQo+QowGuS7pr6/GQeD5C30AK003wlxY0aMOhWmVgPEipvWthp0
	dFMUz4u7Crw8kTJC14KA7c1+mb3BFE2GO+rbbJbEpDfmR7AortrQ1EJOw91KFicWcns2nAWPZGZ
	7WH1KwD7tAFQkYDrxaWqs1tJc942sr77aZMKAQBRKrCHS4lCwDaZQL+HsmfA57zong4urOC2TaX
	DyavV33FkIpv+yibT1VLlGsBRxWQymhOvgZ/3A1ztkSvdy9a91ar9gjXDCdEKtbSAgsW6/QgWdv
	yvoFk8MQMhy1WYQOjETIDEBOyCmxsY4gVK/3KweiKcVrT+J5GTWzo9c/8/kT9Jddq+qakZOXXe0
	C6dLSZT0CqbhV2JS8FuLRuXJRs0zvQOpOGKIceft4ZKoR9VhCEr5QwoGwZeqV928iwvr0eA3bn1
	Q=
X-Received: by 2002:a17:90b:184f:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3ae897e06efmr7231700a91.64.1793604116645;
        Sun, 01 Nov 2026 23:21:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8826a769sm6098801a91.4.2026.11.01.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:55 -0800 (PST)
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
Subject: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP listener
Date: Mon,  2 Nov 2026 07:21:03 +0000
Message-ID: <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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
index 36d1bf46353a..fd443350f9b8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -785,7 +785,18 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
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

