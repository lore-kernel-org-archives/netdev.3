Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C844CF52
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799855; cv=none; b=BVF3uurN867k75MXLX1tJXncjjbGxr4ECPgZP0GgNK4qiNnv8vKZI9b7dvioS5hGjrTuAP/vLu2KdniEbzTHVn1PAIMKJIITqNgRSEIkDoruaQCszGwXPuaDyiPk7O4HPXm+BdEC8XN5QY4BwhXrctOKtbqWH/bNnVnWhzBJE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799855; c=relaxed/simple;
	bh=xECSW4d1vLvpuH2hQQ0xP+B+zasHTAiB77HZkYJpzgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lxqm7YGrQ75vxw4j1WPF7QCeq0fbdvIns9HNpu2SJ29HqWh/7J9AGGmoPgcoV1+EiJVZxXaDDsWYVMMDTDBikovpy78QPqAW6/dRVNNhnWN6BZzlNxGa2KdbbSqkJ3td+K11+/bMbxBJoksfqIkIQ7v71y6Wgmin0O5jIzndz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKyi0ZFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKyi0ZFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F8F1F0089B;
	Mon, 12 Oct 2026 10:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791799847;
	bh=7SaiIrHpO4xHOePMxxkGpn90obrjAosd3s3sZ3YJ5EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kKyi0ZFMEUhZRFL88Y1BTkY9KsaiQoxP2IF/r5IJyl7Jno3YgPhgsVWOb0CHm8SXb
	 BMAEUEQ6Tt6xOfmCVSa5ELnUeSv+CVgmMBjKgi1p2jUemT/bct1WHi7gYU2wgGg7pj
	 Zdl4YVH8e7+dhxAY32mHnnuTeHIgbKR4CagoJxq3sg7oSAEFesK1AIVlGRTwT2RURq
	 969XjATeSp5kh1ugRlCjg64sePBGygkKB6GZzcbB86F/9YOLsr+L2vUiCo/UQB1vEW
	 QY8BdCXXCUE3MRaDAdVEWs0ZeLp/mbToW65sNh2SLSCp29vUiK1R9PXXS5feIEtNwM
	 o++7lbN5MAB4Q==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v3 net 2/2] tcp: use the echoed source route in cookie_v4_check()
Date: Mon, 12 Oct 2026 12:10:29 +0200
Message-ID: <20261012101029.927296-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012101029.927296-1-edumazet@kernel.org>
References: <20261012101029.927296-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the ACK carries a source route option, cookie_v4_check() routes
the new socket to opt->faddr, where opt points to the options of the
received packet.

ip_options_compile() only fills faddr for options given by
setsockopt() (when called without an skb), so on receive faddr is 0
and the lookup is done for daddr 0, which gives a local route.

Use the options echoed by tcp_v4_save_options() instead, as
inet_csk_route_req() and inet_csk_route_child_sock() do with
ireq->ireq_opt. Read them after security_inet_conn_request(),
since CIPSO can replace ireq->ireq_opt there.

The route now goes to the first hop of the source route, so also
refuse a strict source route through a gateway, as
inet_csk_route_req() does.

Found by sashiko while reviewing the sk_mc_loop() fix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
v3: new patch.

 net/ipv4/syncookies.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 73e12976818473277e83ab47f271a43991217e3e..8c9691569e01af0140b8db8990ceeddc3c5fd8fb 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -404,12 +404,12 @@ static struct request_sock *cookie_tcp_check(struct net *net, struct sock *sk,
  */
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 {
-	struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
 	struct net *net = sock_net(sk);
 	struct tcp_request_sock *treq;
+	struct ip_options_rcu *opt;
 	struct request_sock *req;
 	struct sock *ret = sk;
 	struct flowi4 fl4;
@@ -449,6 +449,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		SKB_DR_SET(reason, SECURITY_HOOK);
 		goto out_free;
 	}
+	/* Load ireq->ireq_opt after the LSM hook, which can replace it. */
+	opt = rcu_dereference_protected(ireq->ireq_opt, true);
 
 	tcp_ao_syncookie(sk, skb, req, AF_INET);
 
@@ -461,7 +463,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	flowi4_init_output(&fl4, ireq->ir_iif, ireq->ir_mark,
 			   ip_sock_rt_tos(sk), ip_sock_rt_scope(sk),
 			   IPPROTO_TCP, inet_sk_flowi_flags(sk),
-			   opt->srr ? opt->faddr : ireq->ir_rmt_addr,
+			   (opt && opt->opt.srr) ? opt->opt.faddr : ireq->ir_rmt_addr,
 			   ireq->ir_loc_addr, th->source, th->dest,
 			   sk_uid(sk));
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
@@ -470,6 +472,12 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		SKB_DR_SET(reason, IP_OUTNOROUTES);
 		goto out_free;
 	}
+	/* Same check as in inet_csk_route_req(). */
+	if (opt && opt->opt.is_strictroute && rt->rt_uses_gateway) {
+		ip_rt_put(rt);
+		SKB_DR_SET(reason, IP_OUTNOROUTES);
+		goto out_free;
+	}
 
 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp = READ_ONCE(tp->window_clamp) ? :
-- 
2.53.0

