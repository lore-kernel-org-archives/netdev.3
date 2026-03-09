Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B92C859;
	Mon,  9 Mar 2026 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077463; cv=none; b=hJhLciLLIQymcLm7izlxeRsLZu5BRBXV38VktFTz11HOmOeX8cQvzW5EFpcrfeNABjQVI0kTbLekAOBNWyM9BfawW8Qr7DQsRwCnZ+YENuRld5lOSn++WR9oa6YdHgZUTCByVX+oxTfROHR2iv/s8bHBmXsJ+DPt4dBtmWvFiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077463; c=relaxed/simple;
	bh=vq9qELLf+DkS1aEy7XNi16pQSYzBzvi2Edvj3TR6CnA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NWF0i0xB2LQZpYRN4SiGBFqZ/r0V6yGl4m2arfy9nyOouG3E71x9lQ4gvnafMbO12L2vp+2JMCyl7SqVBf3vtuO7VyaQXOHrAHtO19/1GeTG6AS5VNGK5jsK/WVRlKnQQT71TyBSzCWfyvjFLkQrrlRrYSnyY71CJn1CAtHumJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=RWmKrtAV; arc=none smtp.client-ip=185.70.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="RWmKrtAV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773077450; x=1773336650;
	bh=vq9qELLf+DkS1aEy7XNi16pQSYzBzvi2Edvj3TR6CnA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RWmKrtAV8ZZMISxehOdh/+e6bhevmndfGQcoN2vDbmzxIH6F41lo3uZe5xTnAqsxz
	 fSji5GBYl7/QB+Yw/sOTPAQtF670T3ThGtQKoMK5O4cDBXTMyzphHx/PL/and/DzKl
	 80Wvv2V0xtJlyppnW/2K6BIUVTLEK515M6rp5rfmMAl7xLPISMJ4zc4aGGFvfgb2ee
	 VHJaaBxlJAZvXbUFcvNsRWwvCw1NYTK0arH+O2lt1MbmGAiFl8t/TkVVQSUFW9KSrm
	 ih0knc2dHpWzLVwjjQFAX5cUYCqB9FiMcKjNAMWd1vFU4qPY3+/ndKckbl0KXNPTUW
	 HOcJXJnkVU5gw==
Date: Mon, 09 Mar 2026 17:30:42 +0000
To: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
From: Paul Moses <p@1g4.org>
Cc: horms@kernel.org, chopps@labn.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net] xfrm: iptfs: only publish mode_data after clone setup
Message-ID: <20260309173033.537743-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 078dc614e4a1deba1ef5250950468c64a930103b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

iptfs_clone_state() stores x->mode_data before allocating the reorder
window. If that allocation fails, the code frees the cloned state and
returns -ENOMEM, leaving x->mode_data pointing at freed memory.

The xfrm clone unwind later runs destroy_state() through x->mode_data,
so the failed clone path tears down IPTFS state that clone_state()
already freed.

Keep the cloned IPTFS state private until all allocations succeed so
failed clones leave x->mode_data unset. The destroy path already
handles a NULL mode_data pointer.

Fixes: 4b3faf610cc63 ("xfrm: iptfs: add new iptfs xfrm mode impl")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 net/xfrm/xfrm_iptfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 050a82101ca51..4d7a925f59b7c 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2653,9 +2653,6 @@ static int iptfs_clone_state(struct xfrm_state *x, st=
ruct xfrm_state *orig)
 =09if (!xtfs)
 =09=09return -ENOMEM;
=20
-=09x->mode_data =3D xtfs;
-=09xtfs->x =3D x;
-
 =09xtfs->ra_newskb =3D NULL;
 =09if (xtfs->cfg.reorder_win_size) {
 =09=09xtfs->w_saved =3D kzalloc_objs(*xtfs->w_saved,
@@ -2666,6 +2663,9 @@ static int iptfs_clone_state(struct xfrm_state *x, st=
ruct xfrm_state *orig)
 =09=09}
 =09}
=20
+=09x->mode_data =3D xtfs;
+=09xtfs->x =3D x;
+
 =09return 0;
 }
=20
--=20
2.53.GIT


