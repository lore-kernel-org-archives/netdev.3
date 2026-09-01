Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2073848986D
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281950; cv=none; b=MBlJbTEPS++5B3y0HODMk+wIhctPEptHHe+Me9lGYBAVq6jWJ4hcrzBjxh8ykwEvWiR6IF1SZHNUijv4GOXA+dLTjWUg9FnhnlD3NO3i1KwIN31eoMPWiY5gP35HMRElf725tYRgQ8IPFhLYJe8E6qvNKO2C4B1dMANbjRz2Ubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281950; c=relaxed/simple;
	bh=zBC9HhpKgvjHRSPftf5DbL8uCGB9GcKXLeg1ugY3Lvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFH+NoT5yrEzM2XaH618sIJWzIlsFcjugBb3bb3Dz4BgQzWS2qaN8OOj5CQQVYLkMhChzusqd6kLHPWAcYpJSwCZAsjBGcjtJI880u1ZLidxUCUaajkmA/RLWnSOLgIc1O+DYEUqLYU6D1Uf2IJ0I9MrX7uRcuNO+nRcrGwElDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=uxTKGMn5; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="uxTKGMn5"
Received: by dvalin.narfation.org (Postfix) id 42EB220514;
	Tue, 01 Sep 2026 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788281943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kyVpyxMKwICU52GfM+db+NQ7egE9kupVgMHw6B7+x6w=;
	b=uxTKGMn59/0/onI/1eIR9MWeV4JWNjBw0yLooBTZ2F0S2fuE80p1OLrOoUFgN3rJH7Medj
	Kp0JWDSfnWRVM3TKnPEGfX6Kod6lPEqI0DccpMHkLp3KdtzXwp7KX7ikpNND6UL3JnFErK
	fx0yMxGy4W/S7s5sChfbltooesGeVuU=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: sw@simonwunderlich.de, antonio@mandelbit.com, marek.lindner@mailbox.org,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH net-next 08/15] batman-adv: tt: remove only the entry which was
 looked up from the hash
Date: Tue, 01 Sep 2026 18:59:00 +0200
Message-ID: <1874754.VLH7GnMWUR@sven-desktop>
In-Reply-To: <20260901140001.59CD41F000E9@smtp.kernel.org>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-9-sw@simonwunderlich.de>
 <20260901140001.59CD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8776105.NyiUUSuA9g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart8776105.NyiUUSuA9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Tue, 01 Sep 2026 18:59:00 +0200
Message-ID: <1874754.VLH7GnMWUR@sven-desktop>
In-Reply-To: <20260901140001.59CD41F000E9@smtp.kernel.org>
MIME-Version: 1.0

On Tuesday, 1 September 2026 16:00:00 CEST sashiko-bot@kernel.org wrote:
[...]
> [Severity: High]
> This isn't a bug introduced by this patch, but doesn't this exact same
> vulnerability still exist in the Bridge Loop Avoidance (BLA) subsystem's
> batadv_bla_del_claim() in net/batman-adv/bridge_loop_avoidance.c?


Out of scope. And it is missing the completely different promises by this 
function. It would make the code a little bit cleaner but it is definitely 
nothing missing it this patch. A ticket for a potential improvement can be 
found in https://www.open-mesh.org/issues/471.

Regards,
	Sven
--nextPart8776105.NyiUUSuA9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcEVAAKCRBND3cr0xT1
yzeSAP9ZefdhV7eSzQzXVXGIqftHP7BStqGdY+yYDGRiS76tAgEAo3KPumCxwcoq
yVR6MESyvAZzoFV6h5P2q5CSyOx0Jgg=
=/XlM
-----END PGP SIGNATURE-----

--nextPart8776105.NyiUUSuA9g--



