Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C958F068
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888401; cv=none; b=cKY4PIjQNuFubJAjwcSOeiH+MPxYWTgIMVLjaty9d3XhYYzDxLKwBkWNjtw4n/8DIzCQ0dawT84IlJXVxoYFRmrDU3TX5Z6Y9rHafyRrZ6XFz55Jy6Cv26zmywRsIWUcW0yua+rP71k9JL7/mNhA6Y9VL5vzyZWxluvX2blLc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888401; c=relaxed/simple;
	bh=jaoqP8HG/atWKUIxXbC56CXxtOl9dkPs9IrPhSeQBn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqFpMaXHqtNwEg9aNjVky5SYwnUxKKsewTV75iOyc6gj2qQSZ0GKNWcbDOkBZ/AksmdHLZp9Jt7t93m3xYR9Tig3dJADnFYlNl39GoI/aSTtIWkDmyGM3sKSIPqVAP1Jo5hakGdsiAbsHzeuXkPFaZHkb++ip+fyhrVN/aEeSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=I6UOd57m; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="I6UOd57m"
Received: by dvalin.narfation.org (Postfix) id EEBC91FE4D;
	Tue, 08 Sep 2026 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788888398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQ3A98NZ2ECFbKXKOsLzyCKt1+1+2WSG2OWSAYlYPsM=;
	b=I6UOd57mdRUQ4rJ9KDGFDA/AGB2puwV9x1z2f00x5yWsebJbapMcToKfMEzQqA++uINhpm
	M5kPcwwBjNSeA2KWJb6D2crIdJi0wEfKtwM3hIHUbG4AO8rBLdn4oqY5MXamOYI+YgVhXf
	n7ZbsOmCsLOKwRN6j/GKUKNxSRdY/vk=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 09/15] batman-adv: tt: extract removal of the superseded
 local entry
Date: Tue, 08 Sep 2026 19:26:34 +0200
Message-ID: <10917869.nUPlyArG6x@sven-desktop>
In-Reply-To: <20260907081824.2474040-10-sw@simonwunderlich.de>
References:
 <20260907081824.2474040-1-sw@simonwunderlich.de>
 <20260907081824.2474040-10-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2370024.iZASKD2KPV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2370024.iZASKD2KPV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 08 Sep 2026 19:26:34 +0200
Message-ID: <10917869.nUPlyArG6x@sven-desktop>
In-Reply-To: <20260907081824.2474040-10-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-=
1-sw%40simonwunderlich.de?part=3D9

[...]
> > +/**
> > + * batadv_tt_global_purge_local() - drop the local entry of an announc=
ed client
> > + * @bat_priv: the bat priv with all the mesh interface information
> > + * @tt_global_entry: the global TT entry of the announced client
> > + * @flags: TT flags announced for this non-mesh client
> > + *
> > + * A client which is announced by another originator is no longer a lo=
cal
> > + * client. Remove it from the local table and take over the WIFI flag =
it was
> > + * tracked with.
> > + */
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, gpt-5-6-sol, sashiko-ge=
mini =C2=B7 Confirmed by: gpt-5-6-sol
> This isn't a bug, but should the new kernel-doc for
> batadv_tt_global_purge_local() mention the two things the body actually
> does beyond the summary?
>=20
> The doc says removal from the local table happens, but multicast addresses
> take an early return and nothing is removed:
>=20
> 	if (is_multicast_ether_addr(common->addr))
> 		return;
>=20
> The doc also does not mention that the global entry's own flags are
> modified, not just the inherited WIFI flag:
>=20
> 		if (!(flags & BATADV_TT_CLIENT_ROAM))
> 			common->flags &=3D ~BATADV_TT_CLIENT_ROAM;
>=20
> Since flags_lock is documented in struct batadv_tt_common_entry as
> protecting both @flags and @batadv_tt_global_entry.roam_at, a reader of t=
he
> new standalone helper might not expect the name purge_local() to also res=
et
> the global roaming state.
>=20
> Both behaviours are unchanged from the previous inline code under the
> out_remove label in batadv_tt_global_add(), so this is only about the
> description of the new helper.


See https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260908-sas=
hiko-kdoc-v1-1-535b498f2519@narfation.org/

Regards,
	Sven
--nextPart2370024.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaqBFSgAKCRBND3cr0xT1
y13LAQD3VEVHjsI9tXKh0taDphyxGC7UrRqY/ulxeBr95Uek+wEA9UdRnWCKsCsQ
N0Zjd2X9YldVmQvuB6/1yNn/k2gQjQM=
=MCep
-----END PGP SIGNATURE-----

--nextPart2370024.iZASKD2KPV--



