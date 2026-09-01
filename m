Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9348CD5E
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788286737; cv=none; b=huVQ/e0fpcvGrBvH+CjEmO4KFQFCagT3rASaFQHHXM3yo4wFvWGyIFrXJsFeTaSkrK+mRQxoqZti5LI54JJaHblsSBU0Jy6Mvr0T2t1Dq3tQ6OVynyU9uD/FU7/zvhgPExz6W8eJEfv9DRD/q/hzB86bkHdS0Q1J2K8Ce7tFM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788286737; c=relaxed/simple;
	bh=YXqEs328TowbEf5G0SPaV4v6Nvx2fFTpdEhShmlp9ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2O31hO+RBg6H9zH2A/jv1QFWQokWHOtAxaWt44sXdtqhR/u9gSHYcZnWWayCDMAHz60inu07DTBxyy3Uu2zzZLSB7nRrbEXpSU1HAFkBYTNXycNRkq5D25XCTuvDIx1F/NbCst2E1ZkDy2X0Vte0Eh25RrkSg28/chxRsXJN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=w6oxEPr/; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="w6oxEPr/"
Received: by dvalin.narfation.org (Postfix) id DE591203D9;
	Tue, 01 Sep 2026 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788286730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsvuI7lZ0TZRrrGE3s3xeWRxZcspgFKVyXkTwnTErr8=;
	b=w6oxEPr/yLRyLmoykG/ykaHijXj0AhyZBNcWzrmpqWYwgCYNIgyPYGOvxMh1VuXjSSQZ21
	A4RfgfOkuBqHGMBS5ojfaO51H5LstcswzWF457owhmo+pUsOrmche2kPh2f/UP68fswJ6f
	PUBqkS5MmknD+2NfATqmWr0rNCW0k08=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 10/15] batman-adv: tt: simplify NEW flag transition code
Date: Tue, 01 Sep 2026 20:18:47 +0200
Message-ID: <5146131.31r3eYUQgx@sven-desktop>
In-Reply-To: <20260831135117.574836-11-sw@simonwunderlich.de>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-11-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4778182.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4778182.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 20:18:47 +0200
Message-ID: <5146131.31r3eYUQgx@sven-desktop>
In-Reply-To: <20260831135117.574836-11-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D10

[...]
> Discovered by: opus-5, sonnet-5 =C2=B7 Missed by: gpt-5-6-sol, sashiko-ge=
mini
>=20
> This isn't a bug introduced by this patch, since the removed
> batadv_tt_local_set_flags() did the same unlocked read-modify-write under
> rcu_read_lock(), but it may be worth noting for the rewritten loop in
> batadv_tt_local_transition_new().
>=20
> The loop only holds rcu_read_lock(), so it takes neither the hash bucket
> list_lock nor any per-entry lock while doing:
>=20
> 	tt_common_entry->flags &=3D ~BATADV_TT_CLIENT_NEW;
>=20
> Can this store be lost against a concurrent RMW on the same u16 from
> batadv_tt_local_add() or batadv_tt_local_set_pending() on another CPU, for
> example one that is OR-ing BATADV_TT_CLIENT_PENDING or
> BATADV_TT_CLIENT_ROAM into the same word?
[...]

Out-of-scope for this patch. And handled in the patch
"batman-adv: tt: transition NEW local entries only under lock"

Regards,
	Sven

--nextPart4778182.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcXBwAKCRBND3cr0xT1
y8GTAP9pYtgQ53GhxqBDk6erQWp+KbSDdLPShU2KxvHj7228rQEApSyZSKDsN0tA
BBvtJ/3BubEGdI0/mkrs3pHOpE3++Aw=
=mchY
-----END PGP SIGNATURE-----

--nextPart4778182.LvFx2qVVIh--



