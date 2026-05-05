Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321F3C2777;
	Tue,  5 May 2026 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957221; cv=none; b=B8pPsSXe+8NlFLEIWlzKmoTjQ1f/HtW7aMAl8i95zpmQvkLBpk38i7pWPRVjSNOJv0x1CwgXFlMBj5czOM/pokKDa9UGdBT5TgiJjLqNJwfTVDQX1OAgKgf2flhboO7HrAgMTBdFxVsjVT0oPBPbWpdbrhv9F1QlLQ39ajt0k+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957221; c=relaxed/simple;
	bh=rh8odky3D5jNP5n0PgVNbeWps2Fm5k419VCl6b9988k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GB2NkHDZAwOXa5szAXRrNt3qHJw8Ojm3PW7GyeclyGway1+NPnrmDJANpQjz2D+zLBBb0ch113e5rZYmc1UFzXkuu2IrKFYgtqBq9UrCU6Li/dxSpGHgw6hQyHw6TaoeVyxfHU4yRYb3uUTXD9lomKV1nco9rUXRx98gJZoH+bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=dCoS9LBa; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="dCoS9LBa"
Received: by dvalin.narfation.org (Postfix) id B1DB31FF65;
	Tue, 05 May 2026 05:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777957218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0p63Vuyg2BHhSCETxmGqmI4a7vMqL3by6SZS5CTlcLk=;
	b=dCoS9LBafapQqcaPCIGlZCEsmGIVJ5bwtRDdM5qEu1t604SHKmFW5JGuU4hGMIQ6YoB5GC
	NY/LLnm60aRptb233MQUyr838Uak5inR/AMAmxcY7ctCH+et1EFlFcRkez5UuyJHvrwVW+
	2QLLEV3uI2cIs2NMQYVFrl/DFlyPhvI=
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 stable@kernel.org, "Kernel.org Tools" <tools@kernel.org>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Tue, 05 May 2026 07:00:13 +0200
Message-ID: <2262783.irdbgypaU6@sven-l14>
In-Reply-To: <5990011.DvuYhMxLoT@sven-l14>
References:
 <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
 <20260504171051.2b3e47ef@kernel.org> <5990011.DvuYhMxLoT@sven-l14>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14003289.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart14003289.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Tue, 05 May 2026 07:00:13 +0200
Message-ID: <2262783.irdbgypaU6@sven-l14>
In-Reply-To: <5990011.DvuYhMxLoT@sven-l14>
MIME-Version: 1.0

On Tuesday, 5 May 2026 06:46:11 CEST Sven Eckelmann wrote:
> On Tuesday, 5 May 2026 02:10:51 CEST Jakub Kicinski wrote:
> > On Sun, 03 May 2026 14:22:33 +0200 Sven Eckelmann wrote:
> > > While reviewing the fixes submitted to batman-adv in the recent weeks,
> > > further problems in similar or adjecent code was identified. This was either
> > > noticed in the manual review or reported by sashiko.dev.
> > 
> > Are you CCing netdev to get this reviewed by Sashiko?
> > Please don't..
> > We delegate code to sub-sub-systems to lower the patch volume :(
> > 
> 
> Because of `b4 prep --auto-to-cc`. Will now manually remove you.

To speed up the discussion: @Konstantin, is there a way in b4 to say "stop at 
the sub-sub-systems" when doing `b4 prep --auto-to-cc`? I am just trying to get the 
`b4` workflow somehow working with the netdev requirements.

Regards,
	Sven
--nextPart14003289.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafl5XQAKCRBND3cr0xT1
y9kbAP0We2KhIMdc154ZGMvJr5fgFhZ3BuBDeXGUee0WAUaLPgEA4HdEwJwLk+ri
//HNnBYNg7ZtoVdLqMIpLaFy0KqO0AY=
=KjI1
-----END PGP SIGNATURE-----

--nextPart14003289.uLZWGnKmhe--



