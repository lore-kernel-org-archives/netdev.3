Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104544;
	b=HEzqjeWT90vKDN5vKNK0d1i21WBLTfor0D4DuFVQ7xxcoSIOHoOUKt/2951xQkdYp1Sn
	 sn1LbE4U88uB/vrs9U1emJKkeTjIo6lhJBw16Vvrb8OlCCG3UdCsHFXIFFkjN/sEVsGDS
	 5h1Ds88wt89PQ7/8fu7ZN3j3K2eW60wgNcpIOU6lWwjKZRo5T2eO6RmvHJAd+nADZaVJj
	 cZeMWq7fgAxuqhYqt5pDIrijGqvMwIQXgxQtIuA6Uy9LtOJcT64OUvK+om22VmAYBewY2
	 7WVxRXz3+St5B6XMiypzTlacWhxv+8ME1YaOCTOI+g81z7YBKXOsAHByY3rcMwiYRtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104544;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type;
	bh=K+i0Ir8NB1/YA/OFJN2Vo6ahQORxDCkTkkHvWg7tAU0=;
	b=FZnL/r9P7YHUrT1SclzP156rNICVWZIVwWptShWmZiue78aZ99cV+iWRoMWszZJQXOPB
	 cBP/q3BH7u9ZeuxLPPXugZFZx/qNOint40S6Wu9+GEHJAr65FBNY4hpvJCOhRDGRciW+A
	 Qf2IPEA6UkOyBghqduwesdD1XBtE6vZb1hzA9fZElYEnuT6qSv4xn+0t/TNlGDmjmcttX
	 2a6DBCFqy8RmU0R4F3GN8oHSOFmDOOs7izr923N6Q/6WmkIajldj5xkVVu1PZ6RG28xJG
	 6Q4GenFQyjZnDy68mPERuyTUX8gAJcn9LqcuFPRkQ/0XrlLqfDsDubgwf6XXRe/AZOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=VALFiym6;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED50606A31F
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ED50606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=VALFiym6
Received: by dvalin.narfation.org (Postfix) id 4D1BC20581;
	Tue, 27 Oct 2026 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793104541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+i0Ir8NB1/YA/OFJN2Vo6ahQORxDCkTkkHvWg7tAU0=;
	b=VALFiym6jC5QNhPgDk4uS8ZY59hMZJ7Y3BaVeeQLQ+tqQ+aFB/nJ7xK6D9+QPm2+BiZzty
	zC+PDPCI02H57dC5vhI07HwiQEDnlVqGftt/cQPdln0yCyDk32s3GYGrlbO57Nu0mMJuMt
	HJ+Xvgohx9RfqAQ6kEDMD8S7W3hFRZk=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject:
 Re: [PATCH net 10/10] batman-adv: tt: limit local table to single TVLV
 response size
Date: Tue, 27 Oct 2026 13:35:33 +0100
Message-ID: <2934231.BEx9A2HvPv@ripper>
In-Reply-To: <179309132480.3134.3568656714789779480@kernel.org>
References:
 <20261026085309.1074911-11-sw@simonwunderlich.de>
 <179309132480.3134.3568656714789779480@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15872503.tv2OnDr8pf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart15872503.tv2OnDr8pf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 27 Oct 2026 13:35:33 +0100
Message-ID: <2934231.BEx9A2HvPv@ripper>
In-Reply-To: <179309132480.3134.3568656714789779480@kernel.org>
MIME-Version: 1.0

On Tuesday, 27 October 2026 09:55:24 CET netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> 
> Does this Fixes: tag point at the commit that introduced the problem?
> 
> 85fb027f611b removed a check from batadv_tt_local_create() that already
> limited the table by packet_size_max only:
> 
> -       /* Ignore the client if we cannot send it in a full table response. 
*/
> -       table_size = batadv_tt_local_table_transmit_size(bat_priv);
> -       table_size += batadv_tt_len(1);
> -       packet_size_max = READ_ONCE(bat_priv->packet_size_max);
> -       if (table_size > packet_size_max) {
> 
> That older check had no cap at the 16-bit tvlv_len either. So the missing
> limit seems to predate 85fb027f611b.
> 
> Blame on the parent of 85fb027f611b points at defa87f5ce75fe
> ("batman-adv: tt: extract allocation of new local entries"). That commit
> only moved this code, so the check is older still. The original commit
> was not identified.
> 
> Kernels without 85fb027f611b can still let the local table grow past what
> one unicast TVLV full table response can carry. This happens with
> fragmentation disabled and a hard interface MTU above
> sizeof(struct batadv_unicast_tvlv_packet) + U16_MAX. In that case,
> batadv_tt_prepare_tvlv_local_data() hits its check_add_overflow() path and
> returns 0, so no response is sent.
> 
> With the current tag, stable tooling would only pick this fix for trees
> that contain 85fb027f611b. Could the tag name the commit that first added
> the packet_size_max-only check? Or could the commit message say that
> older trees are affected too?
> 

The code only does it job partially after this commit. All of the previous 
commits would need a big revamp of the TT code - which is not backport-able 
via stable.

The really relevant part is in batadv_tt_local_reserve() and this was only 
introduced with this specific commit. And only for this commit, Sashiko 
pointed this out.

Regards,
	Sven
--nextPart15872503.tv2OnDr8pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCauCalQAKCRBND3cr0xT1
y8TcAQDjHcUwP2NnzQWPSyWeev4w3Dn2s9iUlhfIyglDNphWaQEApfjfe4DbHT5L
NYy4eR55gRf5HWQ8hcEEXHkCgWA/rwc=
=XFF3
-----END PGP SIGNATURE-----

--nextPart15872503.tv2OnDr8pf--



