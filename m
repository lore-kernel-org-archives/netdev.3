Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792998763;
	b=JHo0PGWlY+Zck186M4i8QxkJtq+8YPBrcor/iuUpBPlQtxoESWQ9xKIPG6qcxJXAYnNR
	 L+GdeLkP0QT2ZFNfQa06wilgx77gX7s0udYJA2rPbsxwOZaxGyrRMqIKm46gn10mjMvFF
	 CTeO3WJZnSq2ADeGI0PxBBGCiuGyOKK2kLENv+blp6WADaxi860e/ES5a0eAfjzct99xo
	 Q9OUNMnjA+mBNmcj82TPkQj5CdO62utOmZQgp1Z13l4sxU08pkgC+njCgftPgqtKz4cIM
	 rpdurbf3VQxab9rW7K6oIqaEOxC40Pjk6HWZoHBGaPom2gV1nngh7vadr3aBv+0+wHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792998763;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=YfFDC1jVO97rchmqhk69xUqL3nX6bi1ZD5lzwfJRjZw=;
	b=JZGzicagjWbyB8DuYlE+dT64aCkJO8KjX/MppM5TGMT1AW2y6ksVxueUFDcwKilWEZhP
	 XkfDZ/7D2Y4qQR2U3ZbnYQAUQ0BU1fkrMMjOjirJW0xqeckbAbAv056PLlONCx7I/mZU2
	 90QLIXgqKvybaHNGsL2aEMZej3wu5lrek5u84lV1wnTo+q0p5u4uXrBnHgslKO65KOnKg
	 0CtrdUNEgODjeGnqMRuGKSpTpsxpx+kXYI1TYCIfx90SRGsWp/QhyPL19UbTitwdjA9TO
	 Rz4+RB2zJRdKBGc6TWbIP+m2tjbzbCwvL7/cTZIq25GU/GJpag/kEuGSS9QziJh386w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ktPyZEdE;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65EB606A31A;
	Mon, 26 Oct 2026 07:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C65EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ktPyZEdE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1792998760;
	bh=YfFDC1jVO97rchmqhk69xUqL3nX6bi1ZD5lzwfJRjZw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ktPyZEdE7ep+IMO966Da/U2pwLXgZpsyqNB4nLyZpMZvldpvRPtoHqXwN74+Xh0cX
	 2EUxTCMp1sidVQ7hZyWAGAp7Yd1sDBof2qzgTbu/l0KpmBJJaddWtO0li/ivv21XAT
	 Pz30JcWFWmU8As6E27P1UKdwlkkscstAABmBENK8ZuQHbbMkuzVdPCnmNEA3adHTyV
	 2hCqq7q6jYDpMuW/lPlhWl0Cy9qpoPMmsXyvGEzKlpMIsTZlAhRC5kXRERsupx757f
	 +o6Se7v3VFr3Yu466NKdfKVllzHO05ftYGKFz0Z9KF2aNGkAC4TXhWvnjjJj3g4g5W
	 mjgisOE76VZQg==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 31AB66E6D4;
	Mon, 26 Oct 2026 15:12:39 +0800 (AWST)
Message-ID: <426ef7428413b8d05b6cc3ac22e24b1927ab5aca.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: free reassembly head skb when key_add
 fails on SOM
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>, Matt Johnston
	 <matt@codeconstruct.com.au>
Cc: "David S.Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 15:12:38 +0800
In-Reply-To: <179287946888.17431.11219154409333681184@gmail.com>
References: <179287946888.17431.11219154409333681184@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Joas & Guikin,

[merging two threads here; Guikin reported the same issue, around 12
hours earlier]

> When a start-of-message fragment creates a new reassembly key on the
> broadcast/bind path, mctp_frag_queue() stores the skb as
> key->reasm_head before the key is made observable with mctp_key_add().
>=20
> If mctp_key_add() fails (a race with another SOM packet for the same
> source/dest/tag, or the receiving socket going away), the error path
> only drops the key reference via mctp_key_unref().=C2=A0 The final key
> destructor frees the key itself but not key->reasm_head, and since the
> key was never added to any list, neither the expiry worker nor socket
> teardown can reach it to release the queued fragment.=C2=A0 The skb is
> leaked.

OK, good catch.

> diff --git a/net/mctp/route.c b/net/mctp/route.c
> index e7c95eeac..3d79c2031 100644
> --- a/net/mctp/route.c
> +++ b/net/mctp/route.c
> @@ -552,8 +552,16 @@ static int mctp_dst_input(struct mctp_dst *dst, stru=
ct sk_buff *skb)
> =C2=A0			 * can do is drop.
> =C2=A0			 */
> =C2=A0			rc =3D mctp_key_add(key, msk);
> -			if (!rc)
> +			if (!rc) {
> =C2=A0				trace_mctp_key_acquire(key);
> +			} else {
> +				/* key_add failed: the key is not observable by
> +				 * any cleanup path, so free the fragment we
> +				 * just queued on it to avoid leaking the skb.
> +				 */
> +				kfree_skb(key->reasm_head);
> +				key->reasm_head =3D NULL;
> +			}

We could just defer setting skb to NULL until the mctp_key_add() has
succeeded; there's already the common error path that cleans up any
remaining skb.

Alternatively, we could change the semantics mctp_key_unref() to also
free any pending reassembly, but I'm okay with the current approach of
being explicit about the state handling.

Cheers,


Jeremy
