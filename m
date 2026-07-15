Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBD396B9A
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126924; cv=none; b=iLRlrpmcNRzoNcCu4/9MbjL3EuhX9hLCQMHKzD1dPWXpVS9YYvrSpLXBR+46HcA0jNMjPcWKyrgv0j0k8cfj40+l/HiT3IuHv+E2WhIO5FlmKNDAxB0bn35+2VHswXqzTDZwXt5P35a4LISM2MfQu1S45OUtWvO6aiCqB9Hk+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126924; c=relaxed/simple;
	bh=6ouk3uokvdotrDHfaQMI0gS2Pljg30PRdbhVcrFQaB4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LtWbeTwWQKFVey9NfXeyBjX0y8ayF00JonWSG/EdgE+RRGVqQf8Knb2Ed9iEacsDlxnkydaZOXuotSMI319NmxqEaJHhXCdfeu6WGvLaGQiCLjphU7WbifUu0b5zvWsW8omPsz2RxWmhi1L3aN97s0sX1BTmqgYS2D3BCFzPxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=h5jJXO3y; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="h5jJXO3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784126908; x=1784386108;
	bh=DkneTlIFzL+4NL/atILUBCQHg45PwZkk92XrOGD3QrE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=h5jJXO3yr7QkQ4rUWA2xexbZML4Ygpib6+nS6qMRaaPYZWz1a9aDXr7WY/8vHSjzJ
	 yuGrwKYxhouoD6HFInPrdobV7feahyQRHVSNdh6qA76n7g9b2jkQ3zlKMbdbQa1lkf
	 UV7GId9znsj5Ncb2KG02vahmhrYHqLMiK4cyybSvz5xCVrsjH57A9qlJbzRc8tceHv
	 X8RW45UArJDiMDi5O094fyi7cR0VoaM5/6nIKhIj8EmftKiLOifjSuSlW7UhqE/Ozj
	 gT89iHbhI6vM29l8ha+7MaZUEYZvf3ilpvFdWs/+7jqW8KK8JwCZWYlFlCrX9DXGmB
	 ydMsT8qB8e+Hg==
Date: Wed, 15 Jul 2026 14:48:23 +0000
To: netfilter-devel@vger.kernel.org
From: Jaeyeong Lee <iostreampy@proton.me>
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, sveyret@gmail.com, coreteam@netfilter.org, netdev@vger.kernel.org
Subject: [PATCH nf] netfilter: conntrack: prevent helper extension relocation
Message-ID: <20260715144755.00ea7dfcd9f@proton.me>
Feedback-ID: 96968035:user:proton
X-Pm-Message-ID: 156e66a3a153ac3049c51837541c2585302d63b9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

nf_ct_ext_add() may relocate an unconfirmed conntrack's extension blob
when the current allocation is too small. struct nf_conn_help embeds the
hlist head for the master's expectations. The first expectation's
lnode.pprev therefore points into that extension blob.

An nftables CT expectation object can link an expectation before a later
NAT expression adds extensions to the same unconfirmed conntrack. If an
addition relocates the blob, the copied hlist head still points to the
expectation, but the expectation's pprev continues to point into the
freed old blob. Removing the expectation later executes hlist_del_rcu()
and writes through this stale pointer.

Reserve enough storage for every extension whenever the helper extension
is added. Account for the alignment padding that may be required between
extensions so the reservation is independent of their addition order.
No expectation can be linked before its master has a helper extension,
so subsequent additions fit in the existing allocation and cannot
invalidate expectation list pointers. Conntracks without helpers are
unaffected.

Fixes: 857b46027d6f ("netfilter: nft_ct: add ct expectations support")
Cc: stable@vger.kernel.org
Signed-off-by: Jaeyeong Lee <iostreampy@proton.me>
---
 net/netfilter/nf_conntrack_extend.c | 31 +++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_conntrack_extend.c b/net/netfilter/nf_conntra=
ck_extend.c
index 0da105e1ded..e5e04e0ec40 100644
--- a/net/netfilter/nf_conntrack_extend.c
+++ b/net/netfilter/nf_conntrack_extend.c
@@ -54,35 +54,38 @@ static const u8 nf_ct_ext_type_len[NF_CT_EXT_NUM] =3D {
 #endif
 };
=20
+#define NF_CT_EXT_TYPE_SIZE(type) \
+=09ALIGN(sizeof(type), __alignof__(struct nf_ct_ext))
+
 static __always_inline unsigned int total_extension_size(void)
 {
 =09/* remember to add new extensions below */
 =09BUILD_BUG_ON(NF_CT_EXT_NUM > 10);
=20
 =09return sizeof(struct nf_ct_ext) +
-=09       sizeof(struct nf_conn_help)
+=09       NF_CT_EXT_TYPE_SIZE(struct nf_conn_help)
 #if IS_ENABLED(CONFIG_NF_NAT)
-=09=09+ sizeof(struct nf_conn_nat)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_nat)
 #endif
-=09=09+ sizeof(struct nf_conn_seqadj)
-=09=09+ sizeof(struct nf_conn_acct)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_seqadj)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_acct)
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
-=09=09+ sizeof(struct nf_conntrack_ecache)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conntrack_ecache)
 #endif
 #ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
-=09=09+ sizeof(struct nf_conn_tstamp)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_tstamp)
 #endif
 #ifdef CONFIG_NF_CONNTRACK_TIMEOUT
-=09=09+ sizeof(struct nf_conn_timeout)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_timeout)
 #endif
 #ifdef CONFIG_NF_CONNTRACK_LABELS
-=09=09+ sizeof(struct nf_conn_labels)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_labels)
 #endif
 #if IS_ENABLED(CONFIG_NETFILTER_SYNPROXY)
-=09=09+ sizeof(struct nf_conn_synproxy)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_synproxy)
 #endif
 #if IS_ENABLED(CONFIG_NET_ACT_CT)
-=09=09+ sizeof(struct nf_conn_act_ct_ext)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_act_ct_ext)
 #endif
 =09;
 }
@@ -112,6 +115,14 @@ void *nf_ct_ext_add(struct nf_conn *ct, enum nf_ct_ext=
_id id, gfp_t gfp)
 =09newlen =3D newoff + nf_ct_ext_type_len[id];
=20
 =09alloc =3D max(newlen, NF_CT_EXT_PREALLOC);
+=09/*
+=09 * nf_conn_help contains the expectation list head.  Once an
+=09 * expectation is linked, its lnode.pprev points into this allocation,
+=09 * so later extension additions must not be allowed to relocate it.
+=09 */
+=09if (id =3D=3D NF_CT_EXT_HELPER)
+=09=09alloc =3D max(alloc, total_extension_size());
+
 =09new =3D krealloc(ct->ext, alloc, gfp);
 =09if (!new)
 =09=09return NULL;
--=20
2.43.0


