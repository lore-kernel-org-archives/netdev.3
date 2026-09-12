Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD730F924
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176769; cv=none; b=KGmlyo0+IIDFl9WxncGoqqKpIZkBC8AKC8uuodhgUFQ2C9smvJ4y6NFVVzmhPKyC3G07IbeSp5fVNFUXky3Yeozbn+LPB8Nxp57h5xbsGNMO8uN6TXMeD1QwSokhrNplcfbQCzjQRe1nnzIFjyP02vNemtJQxi03KT+yAeWTFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176769; c=relaxed/simple;
	bh=kpA9tAq2EBytkId5UijebMKqKh1ZAIkgS5SlLkuCrrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iw+aecFgDw0sElCSahLVOpNhQfVZaIVjmmMB5pjkRanUZYXgpGVxTPD9JIMJh03iNCqDtURRuoLjL8QAiwMrn2pLG8O3LFzE3vYCYHZ/zsaByGTGg5D58SZTvXF+a8bT+sBTsNRDIYVkyt8Sh4gjN8xckprWeqXl+CC2aL+4+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK9aTWsR; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK9aTWsR"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e2ff27bso130977e0c.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 18:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789176767; x=1789781567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjS+5MZMCkJIeLNwvKtXeWsQ51wgDnQ0oyyAygIt+Vg=;
        b=GK9aTWsRLbUJqbtPopPpOnUiL5s+JD1R1atRlagB/2lbXvpRhWT0bWaOJbrPcld+s6
         iwNisdwDPRS8G3ni6+Sjtq1sDfys6kQKhZ498ewYVbAejoB9ulCBPZUnA+YvoIir/UQk
         lC8Kw6jktDrYD2GbbX5MxH4OZvkNLfePTkeB56Lh1q62iCUgFVpeO4yluIWZen06pp7J
         /Q/yFnGVzOzDDH96Gna5HX7ZF2wZCQNTihApJTcbbjLhwtxpB9n0nKxC/iUqXrAXcxUM
         mwSxFUpk3ELjoW1M4x4aZ2Hc6DppO1lCx3yns8QdbvhpmgdfGjLXtuN9G2d8Ff1/ZLKe
         UYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789176767; x=1789781567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjS+5MZMCkJIeLNwvKtXeWsQ51wgDnQ0oyyAygIt+Vg=;
        b=nL6K6iDNkxYsQzWQsjrRRT1AvE+uVSn+iLMheFURGGzdpJIgybRllp0IUH3cGfhRAz
         xT2ydz62pzKbrU1XkptdfcWCfu0tOeS2cJh1xBe6GWxO8znqEGgLCjpytw7a7W4DUWD8
         BBQAFo064rm3l55qhCRefaKcj9NfjkBDvC8g2MqDDL/aRaM0KnikqIMLaXNgAbhUAzKl
         unUpMh65uf+RZKf6gtbpbQxDPvQvm9DkFTsZwZ1hOR3BQa5/jGrwM8M129u2CAXVBZZd
         x8pS7pchiZG0SPx67ESps/Zfn9jy+hHUxwaCBD4EVGOxuIHHvumxqcHrxYWmfYkGpdOH
         SkSw==
X-Forwarded-Encrypted: i=1; AKwUvBwjjV4CExRPuFfPgwJHkd8mWtU3DPKZWAtm9AAug9KVIpgO8ZqHq1ZmmINMZe0aeBcj7WLuLPg=@vger.kernel.org
X-Gm-Message-State: AFuF++nnDFhCAm4bTLkXsLUUS/AXr/nLSkm31RQsZTDjMrMESH1ltcZb
	odOO7Gh/JrqxQDaRo6wIafz+x6yCv5Hg9hAp7mvUbphNh1qmKn4T4KOO
X-Gm-Gg: AYBFou01ksuhz2HK+ehaVibR+UMYAPwUp9+5Om1pQmosWsAyGBY1e6stdv/HjyQ/3p9
	BzlvjmZhZ413e+6uKsXPpo7fl88dJUDv8SbEQ+zY3/G6UVgDZ66dS9eBwommnqxLSgmSt5/e+CM
	GWnLE1LNir2MNV6UcVJZ8Da1RExa2hHf85ihY66mQs+UqyxikbjoomfI4/nEOBWwo7L7s+9yPV2
	u5KjQjVQDYl4jYWTmxzHMV4gMJ569SJwE2AizydjIGaJ52mXci32Qx4LeKeJ8Hmw/PrblKJqGRh
	tZesr+mTRwPl0oPzw9FgjERy+x4/6FqsxYnUEPlJliJqfa0jgN2K5Gs1cyJ/mICD76bUhFE0aLN
	Qmdf/XtNJPxb0AGBxSgte1sMaB1qT9x46zA4M/LdHKEbg0u0Mh8l6xfP/FkbSqZ/Ipww+RNWXUE
	bOaj5TvBvw6F01ennWgBl58tIs493bgCfSB7LYrOvEi+tWyG/l4Ooy1LePD+NSKq4=
X-Received: by 2002:a05:6122:17aa:b0:5c6:8480:35c8 with SMTP id 71dfb90a1353d-5c965eec205mr576062e0c.8.1789176766750;
        Fri, 11 Sep 2026 18:32:46 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84714c380sm4738262e0c.15.2026.09.11.18.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 18:32:46 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 2/4] ipvs: stamp per-service secure_tcp on new connections
Date: Fri, 11 Sep 2026 22:32:14 -0300
Message-ID: <20260912013216.588300-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260912013216.588300-1-adrianox@gmail.com>
References: <20260912013216.588300-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the IP_VS_SVC_F_SECURE_TCP capability into
IP_VS_CONN_F_SECURE_TCP when a connection (or a persistent
template) is created for a service.

FTP data channels are created by the ftp app separetely,
outside the paths above, so propagate the flag from the
control connection.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/netfilter/ipvs/ip_vs_core.c | 23 +++++++++++++++++++----
 net/netfilter/ipvs/ip_vs_ftp.c  |  8 +++++---
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index ba0957798bad..eead1b992dd9 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -52,6 +52,13 @@
 #include <linux/indirect_call_wrapper.h>
 
 
+/* Encode the per-service secure_tcp capability into a connection flag */
+static inline unsigned int ip_vs_conn_secure_tcp_flags(struct ip_vs_service *svc)
+{
+	return (svc->flags & IP_VS_SVC_F_SECURE_TCP) ?
+		IP_VS_CONN_F_SECURE_TCP : 0;
+}
+
 EXPORT_SYMBOL(register_ip_vs_scheduler);
 EXPORT_SYMBOL(unregister_ip_vs_scheduler);
 EXPORT_SYMBOL(ip_vs_proto_name);
@@ -546,7 +553,9 @@ ip_vs_sched_persist(struct ip_vs_service *svc,
 		 * and thus param.pe_data will be destroyed
 		 * when the template expires */
 		ct = ip_vs_conn_new(&param, dest->af, &dest->addr, dport,
-				    IP_VS_CONN_F_TEMPLATE, dest, skb->mark);
+				    IP_VS_CONN_F_TEMPLATE |
+				    ip_vs_conn_secure_tcp_flags(svc), dest,
+				    skb->mark);
 		if (ct == NULL) {
 			kfree(param.pe_data);
 			*ignored = -1;
@@ -567,6 +576,7 @@ ip_vs_sched_persist(struct ip_vs_service *svc,
 	flags = (svc->flags & IP_VS_SVC_F_ONEPACKET
 		 && iph->protocol == IPPROTO_UDP) ?
 		IP_VS_CONN_F_ONE_PACKET : 0;
+	flags |= ip_vs_conn_secure_tcp_flags(svc);
 
 	/*
 	 *    Create a new connection according to the template
@@ -714,6 +724,7 @@ ip_vs_schedule(struct ip_vs_service *svc, struct sk_buff *skb,
 	flags = (svc->flags & IP_VS_SVC_F_ONEPACKET
 		 && iph->protocol == IPPROTO_UDP) ?
 		IP_VS_CONN_F_ONE_PACKET : 0;
+	flags |= ip_vs_conn_secure_tcp_flags(svc);
 
 	/*
 	 *    Create a connection entry.
@@ -779,9 +790,10 @@ int ip_vs_leave(struct ip_vs_service *svc, struct sk_buff *skb,
 	    ip_vs_addr_is_unicast(net, svc->af, &iph->daddr)) {
 		int ret;
 		struct ip_vs_conn *cp;
-		unsigned int flags = (svc->flags & IP_VS_SVC_F_ONEPACKET &&
+		unsigned int flags = ((svc->flags & IP_VS_SVC_F_ONEPACKET &&
 				      iph->protocol == IPPROTO_UDP) ?
-				      IP_VS_CONN_F_ONE_PACKET : 0;
+				      IP_VS_CONN_F_ONE_PACKET : 0) |
+				      ip_vs_conn_secure_tcp_flags(svc);
 		union nf_inet_addr daddr = { .all = { 0, 0, 0, 0 } };
 
 		/* create a new connection entry */
@@ -1350,7 +1362,9 @@ struct ip_vs_conn *ip_vs_new_conn_out(struct ip_vs_service *svc,
 		/* check if template exists and points to the same dest */
 		if (!ct || !ip_vs_check_template(ct, dest)) {
 			ct = ip_vs_conn_new(&param, dest->af, daddr, dport,
-					    IP_VS_CONN_F_TEMPLATE, dest, 0);
+					    IP_VS_CONN_F_TEMPLATE |
+					    ip_vs_conn_secure_tcp_flags(svc),
+					    dest, 0);
 			if (!ct) {
 				kfree(param.pe_data);
 				return NULL;
@@ -1364,6 +1378,7 @@ struct ip_vs_conn *ip_vs_new_conn_out(struct ip_vs_service *svc,
 	/* connection flags */
 	flags = ((svc->flags & IP_VS_SVC_F_ONEPACKET) &&
 		 iph->protocol == IPPROTO_UDP) ? IP_VS_CONN_F_ONE_PACKET : 0;
+	flags |= ip_vs_conn_secure_tcp_flags(svc);
 	/* create connection */
 	ip_vs_conn_fill_param(svc->ipvs, svc->af, iph->protocol,
 			      caddr, cport, vaddr, vport, &param);
diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
index b315c608fda4..73d2e7904303 100644
--- a/net/netfilter/ipvs/ip_vs_ftp.c
+++ b/net/netfilter/ipvs/ip_vs_ftp.c
@@ -330,7 +330,8 @@ static int ip_vs_ftp_out(struct ip_vs_app *app, struct ip_vs_conn *cp,
 				      0, &cp->vaddr, port, &p);
 		n_cp = ip_vs_conn_new(&p, cp->af, &from, port,
 				      IP_VS_CONN_F_NO_CPORT |
-				      IP_VS_CONN_F_NFCT,
+				      IP_VS_CONN_F_NFCT |
+				      (cp->flags & IP_VS_CONN_F_SECURE_TCP),
 				      cp->dest, skb->mark);
 		if (!n_cp)
 			return 0;
@@ -535,8 +536,9 @@ static int ip_vs_ftp_in(struct ip_vs_app *app, struct ip_vs_conn *cp,
 		if (!n_cp) {
 			n_cp = ip_vs_conn_new(&p, cp->af, &cp->daddr,
 					      htons(ntohs(cp->dport)-1),
-					      IP_VS_CONN_F_NFCT, cp->dest,
-					      skb->mark);
+					      IP_VS_CONN_F_NFCT |
+					      (cp->flags & IP_VS_CONN_F_SECURE_TCP),
+					      cp->dest, skb->mark);
 			if (!n_cp)
 				return 0;
 
-- 
2.51.0

