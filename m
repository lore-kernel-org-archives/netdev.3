Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177114;
	b=4HO66m8VF0/yfnm04MhoMO7ZWQjW4aL/egrn7+sRrl2S5knNtSh72IPkKJlgDEDPMBkk
	 hUAihT8IQysIg3fI8Q6VQ2GDfdz7NYc/FlSfQatpnncNNOln+wvFKPz5Dvt+g18ZJ7uPP
	 j00uT7bgucgOK7/KIsyUZDVHfzrw0iOXR/at1gnvhD1NSBjcXKV9Pe1X//jfejUJZmeen
	 sez4P74g8lnW040qTCfPLIpDqN6L+gr3LEgnqiSNZFwig03MMg9p62JVFUAyPj/vp6ahh
	 GvL/TJGTNk8kI2Dk7y3xyaC7E0zJ0kNnjxbt2f2xJ1nUfBPRWktkwUF+OiQZsKI+L+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177114;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g/cYqN1rGyHuNRthZzurI3x4a+62pgq35o4KhHKAEtw=;
	b=JCQouAwvrXqRSAa+tO4rvdzrx4lppi0AyoMqUFlBnrocStNbTTt5pg5ngI2g5BpFf4ho
	 oGZ8CIsJ7D9NE3ojGoW8x6cJvhDz4ibiW452xdoXm2b5PyhbxZa+O0w58A6a/bLIoA8PD
	 S9MkG7OKYTbxeclTrum92CaP9xRGKry1qsDyXyWmE7kmjBpAamWVPmmGwJPtAT2C7Zity
	 usPm5GHb0Wb+4lbDMes1yfv4eQ5rDOPhL+SWzjmc/6UZKv23NYVIKhhleZejYSLINKbVm
	 jG0uiAePW1V3RfWRdKwR1baDRGWbQKD0yZt2KeJ8PUpbiEPg5Vek1iYwLEMPb5OFEKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Olz15Zaf;
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D81606A320;
	Sun,  8 Nov 2026 22:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4D81606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Olz15Zaf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794177111; x=1794436311;
	bh=g/cYqN1rGyHuNRthZzurI3x4a+62pgq35o4KhHKAEtw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Olz15ZafyGmAiHEo7IpgcVYTAlTETDkwLxWZagIFK/p/r+m6smtfCWNbvBW9VReM0
	 OecaOgg4DsK4DNuoNus8eVEgFKjS3ZzObNYONeMidaIgtsjONiSE2Gc+afjWksaBVy
	 1wFLg9WWf/UKNlZprSn4K+nquiDR44MNGhVB9nzXO85wepeRwnhMR6tv0TpJVVFvMg
	 Vl3/Jm3lzX5q0xAIy6K+/d7lVW4/NWnDqwe3N+zADFa3hCAvZDnA862JRVfsVphmdj
	 7VriTMjSWFxSI99nfp5HZjZho3Vj4bclAA6l88LCNhTdqBtYZ1Fl7x2z9Eb9uqsU6r
	 Yz4IrCVSL3LSA==
Date: Sun, 08 Nov 2026 22:31:46 +0000
To: "jhs@mojatatu.com" <jhs@mojatatu.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/sched: em_meta: clamp shift to value width
Message-ID: <PonpZoq156a2aiUCGrHWYeg_kl3yFtp5oE2JaeCRJosmPfqWvGCrSlM-dn8lG7kSQpaAJuSaDN1zwr8X9UTC_DxfkFYZQVEQpV9kb-dMWxc=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 8670b41f2d7ada11545e0e42e1c7af06b67fed0d
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

em_meta_change() copies the user-supplied header without validating
hdr.shift, and meta_int_apply_extras() then executes
dst->value >>=3D v->hdr.shift on an unsigned long. A shift count of
BITS_PER_LONG or more (the field is a u8, so up to 255) is undefined
behaviour - on x86 the count is hardware-masked, so the practical
effect is a wrong match verdict or a UBSAN splat, not corruption.
act_pedit clamps its shift for exactly this class.

The patch clamps both values at change time, like act_pedit does.

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), net/sched/em_meta.c:762-770 (meta_int_apply_extras)=
, 906-941 (em_meta_change).
Longstanding code; the sibling fix pattern exists in act_pedit.

This was found during an assisted (AI-supported) static source review of
mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); e=
very code path cited below was re-verified by the
reporter against that tree. The patch below has NOT been compiled and has
NOT been runtime tested, and no reproducer was produced - the triggering
conditions are described above instead. Please treat this as a report for
verification rather than a battle-tested fix.

Reported-by: Noah Weinberger <noahweinberger2003@proton.me>
---
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 48bdd77..6681c67 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -936,6 +936,14 @@ static int em_meta_change(struct net *net, void *data,=
 int len,
 =09memcpy(&meta->lvalue.hdr, &hdr->left, sizeof(hdr->left));
 =09memcpy(&meta->rvalue.hdr, &hdr->right, sizeof(hdr->right));
=20
+=09/* Keep the shift within the value width to avoid undefined
+=09 * behaviour in meta_int_apply_extras(), like act_pedit does.
+=09 */
+=09if (meta->lvalue.hdr.shift > BITS_PER_LONG - 1)
+=09=09meta->lvalue.hdr.shift =3D BITS_PER_LONG - 1;
+=09if (meta->rvalue.hdr.shift > BITS_PER_LONG - 1)
+=09=09meta->rvalue.hdr.shift =3D BITS_PER_LONG - 1;
+
 =09if (!meta_is_supported(&meta->lvalue) ||
 =09    !meta_is_supported(&meta->rvalue)) {
 =09=09err =3D -EOPNOTSUPP;

