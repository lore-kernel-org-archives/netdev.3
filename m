Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103563;
	b=1ch24E0U3MhhqLir/8gbrjHTycHag1imaQ2rG6HWSFFGKqIT32ZFKaqfP5wvkraft0qo
	 gFxNfCBUgg8KKLe2TNuLbdb5lWLKxelALmlGq57XcJBfaUDSdyujcfbG0iVcBDwYluq7D
	 gmBQzki9MM5Zgp+L2WbYgwK7UcboWS/Htgo2+ENekdQUVszgAf8HALseOZT+y9v2eB8ZD
	 iZ9Vn8Satqg0viQaHT9Y2sNIMeaxAHHZaucDQDmid8+FbaMtr7J/BDamUiq4PWQ8u0fVH
	 GDDpJO/jTS3Qk94LILTBx8NEvqYojxS48zsieDQ+fRAzaBznHG4AN83RkmcwpfSqwRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103563;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type;
	bh=f/nSHj2KBswUv5Xue7skD7311sQSYthAPkLKLaOPAuQ=;
	b=omzUwEcAQQNfrwV4HUOdsYxFRJLawWHd8Z8M5auvHLouuHAyj4ImybTsZzPDk9LRK4od
	 8VNuSsxcqVbbYyvqhqGJTjWa+Z7iUFrJ/yFTt1eD8BvLRhK/kIFbBdZ8gRlN+dGpavMJH
	 bUmhktBYzm3mERhnyewbqbEYjU3/xpL4sHYmNvckSeFoJt2v1uJJwmeilIg7QPWYehlew
	 ztbA1ZWAY/oSLQdBiwbD/fZ+ApDdABPtUFPANEtYJcbINV9X2xYIpKc9DW5ts56wvyZe+
	 qZtcgsuSceMiiJVxYTlRVFhTtjywRGT3s7X7qh8DUNJazO00OFOOVqYnds56nJgLv1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Zp7U7oNY;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE804606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE804606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Zp7U7oNY
Received: by dvalin.narfation.org (Postfix) id 842E420152;
	Tue, 27 Oct 2026 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793103560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/nSHj2KBswUv5Xue7skD7311sQSYthAPkLKLaOPAuQ=;
	b=Zp7U7oNYWqjdZGlbI+2p7Ilz8CDZY3TSCyRwgvLFpIwgv/iECaF8Tm/42OK3Ns9KbmnqgG
	cI+mYBzAl6MCRkO9Z1hK0viq/apk/9kpKCkDiWOmSNCExWXR0Dch172+mzJ9jzen04+zDP
	JN4pQJf6DNmtZ5SWB0ONyr/3CmRqW3I=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject:
 Re: [PATCH net 02/10] batman-adv: Close OGM aggregation before transmission
Date: Tue, 27 Oct 2026 13:19:17 +0100
Message-ID: <2498207.NG923GbCHz@ripper>
In-Reply-To: <179309132139.3134.350154128482754175@kernel.org>
References:
 <20261026085309.1074911-3-sw@simonwunderlich.de>
 <179309132139.3134.350154128482754175@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart896556100.0ifERbkFSE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart896556100.0ifERbkFSE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 27 Oct 2026 13:19:17 +0100
Message-ID: <2498207.NG923GbCHz@ripper>
In-Reply-To: <179309132139.3134.350154128482754175@kernel.org>
MIME-Version: 1.0

On Tuesday, 27 October 2026 09:55:21 CET netdev-bot+sashiko@kernel.org wrote:
> batman-adv: Close OGM aggregation before transmission
> 
> This patch makes the OGM send worker mark the forwarding packet as a full
> aggregate under forw_bat_list_lock before it calls batadv_iv_ogm_emit().
> After that, no other context can append OGMs while the packet is being
> emitted and cloned. The packet stays on forw_bat_list so interface purging
> can still find it.
> 
> > diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> > index 158d2b8f04036..85e99506a53f5 100644
> > --- a/net/batman-adv/bat_iv_ogm.c
> > +++ b/net/batman-adv/bat_iv_ogm.c
> > @@ -1909,6 +1909,11 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
> >  		goto out;
> >  	}
> >  
> > +	/* Mark aggregate as full before forcing emit. */
> > +	spin_lock_bh(&bat_priv->forw_bat_list_lock);
> > +	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
> > +	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
> 
> [Severity: Low]
> This isn't a bug, but should the kernel-doc for num_packets be updated
> to match this new use?

https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261027-kdoc-num_packets-v1-1-1fa6d584b7b3@narfation.org/

Regards,
	Sven

--nextPart896556100.0ifERbkFSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCauCWxQAKCRBND3cr0xT1
y1V6AQDt/ZAmmSaTCrxGEO6UbslKPV46riTMxbc2cltDAAYa3QEAwZLs7PPRwmpu
gtRNpov7f40kTS4qSPJyN9l4TfOWUgA=
=CHH7
-----END PGP SIGNATURE-----

--nextPart896556100.0ifERbkFSE--



