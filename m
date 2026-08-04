Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140373B05B0
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839914; cv=none; b=p4gSeXAHDll9VV9GA4Nk8hk3nN/9+2/kfd19yTwk9TaqQ8MO1/4w3g+q9Kic6EDf/9BUbPNB5Voq11erJ4uTZ0Jj6xOxE7L7hGgluUnEfYNXBgSydZGA8obQhcr/QRfw2sun9znkMmuYNmPzzUIwZ4WhjrH02LA3PNG79r0+GqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839914; c=relaxed/simple;
	bh=QbynUGj5sF8O+NY2vlowomFhyZrmatWj5NoRqlp2B/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMj5koSM/aqUZTc6XNEW7SHi5gG/uCutezZu8Fll2akBL5l3m66dOnFNvBlBMsX7hGOp0r70XpuZdgTj1lmGe+/c5YbJK80GzyOo+zFGSJ/HY5tnZPtgqgKa2gs/ADVeX6p3rIQvcLUXmsLhcUYN3qxEYYA8ol30aNFlXfbhqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Xqb8fs9j; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Xqb8fs9j"
Received: by dvalin.narfation.org (Postfix) id 59A85200A3;
	Tue, 04 Aug 2026 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785839906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WtJy2MfaXTaEOmlC5rfqzTgy+eUfkYpLXbncaIJYzvg=;
	b=Xqb8fs9jBaghyfcphqr6xlbpr8U9hGzTJPg7ag836MrBfSOT4akI41uK41Dx2F3AUgc2AP
	VQ8oprJkKwQ5rOj7WVNyhMWP64Zff/xx/AI9V5k3w1mLrkpmi/9jJNAjuIkLXKyPJcxHqO
	Zn9OtmCUNjFw+hOSgHV1OFCy45RBhgY=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
Subject:
 Re: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-07-28
Date: Tue, 04 Aug 2026 12:38:23 +0200
Message-ID: <5248054.31r3eYUQgx@sven-desktop>
In-Reply-To: <7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com>
References:
 <20260728133918.643267-1-sw@simonwunderlich.de>
 <7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4880609.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4880609.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2026 12:38:23 +0200
Message-ID: <5248054.31r3eYUQgx@sven-desktop>
In-Reply-To: <7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com>
MIME-Version: 1.0

On Tuesday, 4 August 2026 12:19:13 CEST Paolo Abeni wrote:
> On 7/28/26 3:39 PM, Simon Wunderlich wrote:
> > Dear net maintainers,
> > 
> > here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.
> 
> Note that it's preferred to avoid fixes and stable tags for changes
> targeting the net-next tree. If the fixes are really minor, both could
> possibly safely dropped. If there is some real problem behind, such
> changes should instead target the net tree.
> 
> Can you easily rebase your tree and adjust the PR vs the above?

I have a different statement from Linus:
https://lore.kernel.org/lkml/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/T/#u

This is why we started to not send out net.git fixes PRs for things which 
aren't highly critical or for Linus' "just merged for this release commits"  
late in the development process.

Regards,
	Sven
--nextPart4880609.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanHBHwAKCRBND3cr0xT1
y/8QAQDzUcTw7FHaaCVpHMlzRh2IWzL1KDQNhQYlWN3UCPzYawD+Lq761nAESYoH
ZJYYYX7K7shuAGSuyAGLY51vTpi+Iw4=
=dPxd
-----END PGP SIGNATURE-----

--nextPart4880609.LvFx2qVVIh--



