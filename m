Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7438F95B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052382; cv=none; b=Rzq254JFSjxx7FhXegJ4wBPOnyDPGpatTHOD3UzGtW7UKzTLul8IwLF8ukWyu9utL67tI1k8zfQWGDOl7MT2XgtAbFl0bEJvP2M6FpIW4kSrYO4j6oICIgelcumjM5M/T7Po1uK40De/Ok+KeqFWKXXPA+H3jY6jTeW1oEM01Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052382; c=relaxed/simple;
	bh=yUsWMonwzUO9OW/p/Q17dDZXZSLQ0V50VQGmLzNFg40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7k8dzZKSTQGiQlm0N2qwEMOYt1EmIWO6UemBmQkwrUOzo5lOtTjn5j6XEb9kbpM1k/2aow1s8jpMYpwqxGwv99JKxSaSz9nh4ys4aNuyNtIpWcPA8qFUZyXDtn/rnAKgR4b4+0SyV4wPU2aiAb/BPkWYXsD+18itZSd0vBjNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ihpDVqSp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xbme6OhE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ihpDVqSp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xbme6OhE"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AF7C1D00128;
	Mon,  9 Mar 2026 06:32:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 09 Mar 2026 06:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773052379; x=
	1773138779; bh=gxtMMG78TbbXrM7IPazIrbsEb3WZmB7xDAe0mz/QrYc=; b=i
	hpDVqSp6+VWS09dd/SYwsHnYfbHYwsgAoMiHd5lKzMvnV6en2KWsjYN79k4ssIpP
	gjz8Z/jqL8rhChmeEQ/rQZmf8z5SWIoNMZAqNWqIq+CYAYbV5WEODt8a6Cx7du/h
	nunemQSDJ3T/sK1PnOrQIlJVlZ4ivnc5tS12NNWlLoPl1Z8IwH1/z2YVw+3wPl3Q
	ufpSpE7jbZrldnJxXPEHfQ1YpaDp5KJlRuiRZhwWXUN6SF99sUmdBMvhAuC10rOY
	gBh8qCDytU0qU50BwZQ5RmQTJJhml2VirzvwjdsNeVkPG6O6MNeCaPfqN7EoEtTz
	O6Hh0zyDvnnVuuzNVqhCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773052379; x=1773138779; bh=g
	xtMMG78TbbXrM7IPazIrbsEb3WZmB7xDAe0mz/QrYc=; b=Xbme6OhEd1ILGcGdL
	T4iGRDWLt7EzkxNa3nEMWWGFP/cAHKEZemoHIwx+bzJf4XEVTz0KUNklw/09o6U3
	mr9rmbGB2pFadPxAq0oXRF+A1GY3P72k2pPv2n/y9GN+uMOZ4SmGc+sem/U+GOre
	r+VawiDYRzCa5xYQ88WUxymDeaGUtJOa+Pj0sWEpGJdsmcQ0Qv/JyT50tJSf9bEX
	/bxGu+3fShjy+gEamxaaW0VzQzRlQKEOHtefaKbBVSb4j3ZnXN4nqDTvkPvXoKEG
	KwY4I54zjddAXsbCu1Fl62p71A5m83ceubwudN59R+sRQHNkqSTvG21CrsQrY/rN
	IY8tw==
X-ME-Sender: <xms:2qGuaSxiFw6fXhOMgUqY0IJghCWjtXgZqz4iOex8NM2podPTqQrbAA>
    <xme:2qGuaTpoozIJNuMXYj8GDQ956IC6_eyUQ8SsZ5DDDZjPXZ875Ce7vrokM9-G0nEf_
    8cnIo7swUTZPQBQ_QnuHZL1ZbHqu9qaEAh7oDrFHx4_F_BkwW9v_dQ>
X-ME-Received: <xmr:2qGuaUhj3NsMRSJHwyylXpRUDGRyjTeaunRkVOY3ApIbS11fycTuS2FQ3wgR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeejkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdroh
    hrghdrrghupdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:2qGuaYiIezeTO7rNVrlgLAAPECyvkAJaXJfCq4IfN57DwdjgGnWt-g>
    <xmx:2qGuaSh8RO-_jD8hhEVkvg3gaCMUU6D9QixhlyI1v3OmQNJIUZlz_A>
    <xmx:2qGuaQKKqsHl8uW1HO7ue2zJQrYOppDDnnit8UWzUrTYUzRtniaOOA>
    <xmx:2qGuaZHobqcSqDV2rHe0oaq9nDDgfKWy5Od2wI8sOui-9f1YwFvmUA>
    <xmx:26GuaRGz8fIc5VsQ5x59QTHWaj2KKhJIA-ZxmIxVNCggbXVP7yJsEXxR>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:32:58 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 02/10] xfrm: state: fix sparse warnings in xfrm_state_init
Date: Mon,  9 Mar 2026 11:32:35 +0100
Message-ID: <efa6484e140b2f842531d5404a17e52955c6d67d.1773051558.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1773051558.git.sd@queasysnail.net>
References: <cover.1773051558.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use rcu_assign_pointer, and tmp variables for freeing on the error
path without accessing net->xfrm.state_by*.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 7a68c594ce37..e9bf160a30f8 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3258,6 +3258,7 @@ EXPORT_SYMBOL(xfrm_init_state);
 
 int __net_init xfrm_state_init(struct net *net)
 {
+	struct hlist_head *ndst, *nsrc, *nspi, *nseq;
 	unsigned int sz;
 
 	if (net_eq(net, &init_net))
@@ -3268,18 +3269,25 @@ int __net_init xfrm_state_init(struct net *net)
 
 	sz = sizeof(struct hlist_head) * 8;
 
-	net->xfrm.state_bydst = xfrm_hash_alloc(sz);
-	if (!net->xfrm.state_bydst)
+	ndst = xfrm_hash_alloc(sz);
+	if (!ndst)
 		goto out_bydst;
-	net->xfrm.state_bysrc = xfrm_hash_alloc(sz);
-	if (!net->xfrm.state_bysrc)
+	rcu_assign_pointer(net->xfrm.state_bydst, ndst);
+
+	nsrc = xfrm_hash_alloc(sz);
+	if (!nsrc)
 		goto out_bysrc;
-	net->xfrm.state_byspi = xfrm_hash_alloc(sz);
-	if (!net->xfrm.state_byspi)
+	rcu_assign_pointer(net->xfrm.state_bysrc, nsrc);
+
+	nspi = xfrm_hash_alloc(sz);
+	if (!nspi)
 		goto out_byspi;
-	net->xfrm.state_byseq = xfrm_hash_alloc(sz);
-	if (!net->xfrm.state_byseq)
+	rcu_assign_pointer(net->xfrm.state_byspi, nspi);
+
+	nseq = xfrm_hash_alloc(sz);
+	if (!nseq)
 		goto out_byseq;
+	rcu_assign_pointer(net->xfrm.state_byseq, nseq);
 
 	net->xfrm.state_cache_input = alloc_percpu(struct hlist_head);
 	if (!net->xfrm.state_cache_input)
@@ -3295,13 +3303,13 @@ int __net_init xfrm_state_init(struct net *net)
 	return 0;
 
 out_state_cache_input:
-	xfrm_hash_free(net->xfrm.state_byseq, sz);
+	xfrm_hash_free(nseq, sz);
 out_byseq:
-	xfrm_hash_free(net->xfrm.state_byspi, sz);
+	xfrm_hash_free(nspi, sz);
 out_byspi:
-	xfrm_hash_free(net->xfrm.state_bysrc, sz);
+	xfrm_hash_free(nsrc, sz);
 out_bysrc:
-	xfrm_hash_free(net->xfrm.state_bydst, sz);
+	xfrm_hash_free(ndst, sz);
 out_bydst:
 	return -ENOMEM;
 }
-- 
2.51.2

