Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481062;
	b=cSQRNqknHrON0Ue4ZC5Nonbo2JPLhvitwY7OvqwtqIggXRSSrBRZvo9PuP+qJchOHRhd
	 aLcz258rZLKbjDxc09BL/NcMtsny5G2nJ/u62587+LwsCdOTSNmIp5a6KJRJ+lJujvdtL
	 EQ2k8WUBUkwEKtv5QP0GXXqopM7gyNgr+P9HLZeMQi+5Iq3ZrtQJBiesdzD3SsOFVdXRi
	 AP6wbmDsvru9GviXW6ms6YKlaqObhTpBoDd2AnjzJinaAGo2G+odHIxJZLA0vLNMGPscs
	 Wj6V5nbJoYtB5Q24ct+NZCNb7jytqrsRDD7W1HTTbzsNvCLGVxiZMl3mDu0yrixDrlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481062;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type;
	bh=8P9ng6dnAOZ1uLRwI2Xyior8nl1Uol/mP/8AoZqdZUo=;
	b=WARinW6u+uXojqxRDImtfW6YdKbswKZmQG7uWGtRce3NnESFJ/MQ4gWTaG8R5k1/Oy2f
	 zjcRA0+B1ZbsRg0ePltcc/eV8yFPsMCm40YngGgbAgYUyuWAUdPPYc8QNSgw6fxKpK0aj
	 XgmNg7rixbYqDvQigyPLI5GFoekGu2YU4LzvnN3SvNEUnBSHFw1CA9rO7MCgVGFD8obig
	 h7M6rqUnYv48Wdgw1xDMCUlKthF8YKZEN7b1zICT1BSCgGUEzOOzi8j8f8ZgrOniFD7R/
	 Ehyz9g9Nk1txAt8t/tMDEs4SztkpJpHZEoSghn3ckb8WqWY7OG3+whJUPXslz1WyjBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=aZBIcGHd;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3E606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=aZBIcGHd
Received: by dvalin.narfation.org (Postfix) id 46F7F1FEF7;
	Thu, 12 Nov 2026 10:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794481060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8P9ng6dnAOZ1uLRwI2Xyior8nl1Uol/mP/8AoZqdZUo=;
	b=aZBIcGHdgmTgfk0JcPXJLdRysccdxIvZ/gaPvXpts6Ofv5Y3eOzvbwWlk3Cs5A0WFSNdlC
	aXjzjLzKCOIB85shL/DCf4ggsC9869mYZ9NSWOp2K5ht2NFUHFIfa1J1JkBsqpC+2fk3dO
	uiewdbMYQkq+6nYDyjZ4z8TL97QIwfo=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH net-next 09/15] batman-adv: annotate originator last_seen with
 READ/WRITE_ONCE
Date: Thu, 12 Nov 2026 11:57:37 +0100
Message-ID: <1831685.QkHrqEjB74@ripper>
In-Reply-To: <sashiko-outbox-210959@kernel.org>
References:
 <20261111102729.2096241-1-sw@simonwunderlich.de>
 <20261111102729.2096241-10-sw@simonwunderlich.de>
 <sashiko-outbox-210959@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4751616.8F6SAcFxjW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4751616.8F6SAcFxjW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Nov 2026 11:57:37 +0100
Message-ID: <1831685.QkHrqEjB74@ripper>
In-Reply-To: <sashiko-outbox-210959@kernel.org>
MIME-Version: 1.0

On Thursday, 12 November 2026 11:34:43 CET sashiko-bot@kernel.org wrote:
[...]
> [Severity: Medium]
> This problem wasn't introduced by this patch, but can
> batadv_v_neigh_dump_neigh() and batadv_iv_neigh_dump_neigh()

batadv_iv_neigh_dump_neigh? There is no function with this name in the source 
code. There is only batadv_iv_ogm_neigh_dump_neigh()

> suffer from
> the same timestamp underflow [1]?
> 
> net/batman-adv/bat_v.c:batadv_v_neigh_dump_neigh() {
>     ...
>         last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
>     ...
> }
> 
> Because hardif_neigh->last_seen is updated locklessly on packet reception
> and read without READ_ONCE() or jiffies_delta_to_msecs(), a concurrent
> update can leave hardif_neigh->last_seen ahead of the sampled jiffies
> value, wrapping the subtraction and exporting a huge last_seen_msecs
> value over netlink.

This is adjusted in the next two patches in this patchset.

Regards,
	Sven
--nextPart4751616.8F6SAcFxjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCavWboQAKCRBND3cr0xT1
y30qAQCxM2pzrCpWwjtmdG17Uozu4UXuGHZ7Y558+4W2pqCO7wD/dz9ukJGdb+Jv
qjF9rkCqVOr4xg+aDzhwJ5Pan1aQGww=
=hGQR
-----END PGP SIGNATURE-----

--nextPart4751616.8F6SAcFxjW--



