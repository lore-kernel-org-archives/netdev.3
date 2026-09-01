Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFE48988B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281957; cv=none; b=D+BW7PZMxxurmTSbk/Ds3dBdfPAg+bpomWmbb+KxcnKzthS7nCmy1JbnnodRk3T64mOI6OrRJI+Ghuyvj7VmHEAbRbRf8h/lPUsesFzL4TUmdBuKnu8yCXCMBvTFaFMFNCgPUkNUq5xVTMG13rpQJ5nd38OafkXGmUGABt6j9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281957; c=relaxed/simple;
	bh=Yrc9AyOh+cbhmWx/2m8p/aD6UbD4nC8vkcj5HtUZEj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sn9Z+wPkBBLbbVYTXk/oQfV3aCsI5i70eAOywovLywxLriyBEAiwWxjAvZ/bNeJJjkmPqYVrnN7w2hcgm8gnbr+crlTw+iGvEM/0qAADHKqFwYcP3CYsWxBVV5OaUsm/sMhxpky743Gjh/7PZ6s7b2389TNIb1gh0CvuwtWcudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=iuF4AF0p; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="iuF4AF0p"
Received: by dvalin.narfation.org (Postfix) id CFE7020396;
	Tue, 01 Sep 2026 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788281949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6H72fJ6kyOlrK3Fr6O2GXskmmT15SVIoLWNy5VHEGUg=;
	b=iuF4AF0pOqbEOUd8OL8Fc4G0ffHHfH/O9b4gwxRdpeigsyhJc/S5oMd95mcyQv0H4bj3mF
	nsBwANQM3+oAhQLv95uryuRamgH1dFzAaLdaqNAu1ZjTHOIIjwpYl/j9eJbNoZre0s4JAm
	O5Ad5El8Nnq8Qx4uNmg6lvaicnn9njw=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH net-next 06/15] batman-adv: ensure u16 aligned mac address arrays
 on stack
Date: Tue, 01 Sep 2026 18:59:04 +0200
Message-ID: <3637364.QJadu78ljV@sven-desktop>
In-Reply-To: <20260901140000.035F51F000E9@smtp.kernel.org>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-7-sw@simonwunderlich.de>
 <20260901140000.035F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1977324.CQOukoFCf9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1977324.CQOukoFCf9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Tue, 01 Sep 2026 18:59:04 +0200
Message-ID: <3637364.QJadu78ljV@sven-desktop>
In-Reply-To: <20260901140000.035F51F000E9@smtp.kernel.org>
MIME-Version: 1.0

On Tuesday, 1 September 2026 15:59:59 CEST sashiko-bot@kernel.org wrote:
[...]
> If memory allocation fails for bat_priv->bla.backbone_hash, the previously
> allocated claim_hash is destroyed but the pointer is left dangling:
> 
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_init() {
>         ...
>         bat_priv->bla.backbone_hash = batadv_hash_new(32);
>         if (!bat_priv->bla.backbone_hash) {
>                 batadv_hash_destroy(bat_priv->bla.claim_hash);
>                 return -ENOMEM;
>         }
>         ...
> }
> 
> This failure propagates up to batadv_mesh_init() and register_netdevice(),
> which rolls back by calling the device's priv_destructor 
> (batadv_meshif_free()).
> 
> This destructor calls batadv_mesh_free() which unconditionally calls
> batadv_bla_free(). Could batadv_bla_free() then use the dangling non-NULL
> claim_hash pointer:
> 
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_free() {
>         ...
>         if (bat_priv->bla.claim_hash) {
>                 batadv_bla_purge_claims(bat_priv, primary_if, 1);
>                 batadv_hash_destroy(bat_priv->bla.claim_hash);
>                 bat_priv->bla.claim_hash = NULL;
>         }
>         ...
> }
> 
> leading to a use-after-free in batadv_bla_purge_claims() and a double free
> via batadv_hash_destroy()?
> 
> Would it be safer to set bat_priv->bla.claim_hash = NULL immediately after
> destroying it in batadv_bla_init()?
> 
> 

Completely out-of-scope for this patch. Submitted patch for review to 
https://patch.msgid.link/20260901-claim-avoid-err-double-free-v1-1-6d6f081f5151@narfation.org

Regards,
	Sven

--nextPart1977324.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcEWAAKCRBND3cr0xT1
y5BVAQDFGx1qM0SkIVnCp5qmK5Q/Pmtn5ScyGmW/C5PWtQo09QD7BzSQgk6ULsJS
HDpkD5cWCszVKXdEfY/5Cop9YIV5SAg=
=r7L6
-----END PGP SIGNATURE-----

--nextPart1977324.CQOukoFCf9--



