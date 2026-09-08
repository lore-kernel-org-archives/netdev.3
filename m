Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89498594805
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888405; cv=none; b=Q47v4RYgzZjjepmAqH8y8JVPA4Aibr3AAL1UxAMGYPGAha3IulCkEFSDRWhFsjEUtnLW8WHyIEwnPxWtIQucA1Yu+apD0qahOv2tUkKX4lx2BLx006jZe94jjf+N8vuaPVUWkzfyM2jTnhTr30jURBEK9N8WXmpFSwwWFT6YSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888405; c=relaxed/simple;
	bh=w+GRc/vb6kJZxoG6eKfFBmdJLhsxKqOH3isDRji86Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E05Cdy8gji/u6OdtY/j8I9KAseGz2oPHG6XXArjjb7Jg4/Q7zqBtNyOce2dOSOjlk7T3M8UFelyzbpM25AJKS0gkUNaT1Nguq43YDAhy7Zm0mrP/pPTMv1QwoUGKxKd7AAi9yFm8CiCHS3pj7dYCu8QJ3UmDYkkpcUZsh3seHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=hrjHL3Bs; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="hrjHL3Bs"
Received: by dvalin.narfation.org (Postfix) id 63EFF203C8;
	Tue, 08 Sep 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788888401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FHeMM3cah6we71csw5zVw2WNdPXB/wb60Sk/ZQak/zY=;
	b=hrjHL3BsFo9ZOXfxOa8aH6bBY4Fz2Jq99PJRhQtA/DCwSwI202J/RGUtFuU3rtreE36ApR
	fmWiMgBGtWW2I9fH0agOizZ+cdp/ciMzlBfqm5uXnLvUYldMn/OG29RmZ3Xon+uyPF8WY5
	5iEV9o0BuyAEUJ3S9mwdxw8FV9mRJuk=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 10/15] batman-adv: tt: extract marking of a removed local
 entry
Date: Tue, 08 Sep 2026 19:26:38 +0200
Message-ID: <2056796.PYKUYFuaPT@sven-desktop>
In-Reply-To: <20260907081824.2474040-11-sw@simonwunderlich.de>
References:
 <20260907081824.2474040-1-sw@simonwunderlich.de>
 <20260907081824.2474040-11-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23242329.EfDdHjke4D";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart23242329.EfDdHjke4D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 08 Sep 2026 19:26:38 +0200
Message-ID: <2056796.PYKUYFuaPT@sven-desktop>
In-Reply-To: <20260907081824.2474040-11-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-=
1-sw%40simonwunderlich.de?part=3D10

[...]
> Discovered by: opus-5, old-prompts =C2=B7 Missed by: gpt-5-6-sol, sashiko=
=2Dgemini
>=20
> Two comments in batadv_tt_local_remove() look like they no longer match t=
he
> code after the move.
>=20
> First, the untouched comment further down in batadv_tt_local_remove() sti=
ll
> refers to a check "above":
>=20
> net/batman-adv/translation-table.c:batadv_tt_local_remove() {
> 	...
> 	/* batadv_tt_local_transition_new() may have committed the entry and
> 	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
> 	 * check above.
> 	 */
> 	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NE=
W))
> 		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
> 	...
> }
>=20
> After this patch there is no BATADV_TT_CLIENT_NEW test left anywhere above
> that point in this function; the only one is now inside the new helper:
>
> net/batman-adv/translation-table.c:batadv_tt_local_mark_removed() {
> 	...
> 		if (!(common->flags & BATADV_TT_CLIENT_NEW)) {
> 			common->flags |=3D BATADV_TT_CLIENT_PENDING;
> 			pending =3D true;
> 		}
> 	...
> }
>=20
> Should the wording be updated in this patch to name the helper, so the
> size-accounting race stays traceable from the function it is documented i=
n?

See patch 11 "batman-adv: tt: extract immediate purge of a local entry"


> Second, the retained comment above the "if (roaming)" line still says the
> node "has to mark the local entry as roamed", but the code it now precedes
> only assembles the announcement flag word; the actual
> common->flags |=3D BATADV_TT_CLIENT_ROAM happens in the
> batadv_tt_local_mark_removed() call two lines below.  Would it read better
> moved or reworded so it describes the flag assembly?
>=20
> No functional change is apparent here: flags is fully computed before the
> call, *curr_flags is written unconditionally inside the guard so curr_fla=
gs
> is always initialized for the caller, and the helper is only reached after
> the !tt_local_entry early goto.

See https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260908-sas=
hiko-kdoc-v1-2-535b498f2519@narfation.org/


Regards,
	Sven
--nextPart23242329.EfDdHjke4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaqBFTgAKCRBND3cr0xT1
y9eVAQCrSHMq+uPJN+ZPUSxx99ek6ob/8ZDfr6sFi5RrPM/zYwD/SxEeTKNzH0Eu
zfG8hknPR/Ai9zHlEzWGPvUmEoEuEwg=
=kyIT
-----END PGP SIGNATURE-----

--nextPart23242329.EfDdHjke4D--



