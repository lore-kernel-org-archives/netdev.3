Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC12D780A
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826573; cv=none; b=X+/9kh6IOrLnab5Dkpl9SkVy4HwInIno9beqHP8ekD/74k0uqPhf3oNSOu7ENo7hgg51zFnI2apCHVu/cWXLmHdJmFzK6BusFjDEntt4hGEiRizbrngf9G3af07wfe1XWffB5dmM2FknQQPxZO8CRVD0GjbAFnCDzZ/iU3Rt2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826573; c=relaxed/simple;
	bh=qCcLyyesRCmSO7Iv2oP2n+FPMupIDZ8gAuzu5T9dZVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwBesjIBa+avqQPSp66TfcpZ/ANuqo6XV+DoFn5uvA1C+toKVcRcVH4JzzFfiet6ypj7TOCP6nU2w28K4TciITtNT0K4bOZcHPxhvJsDVIjxZTYyEJMhaNMQHu5YX6KoogBAuL5Yf4zBI7xxQSUS62hfl1VM0Lv2/4zGOlVJe/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=kJXIb0sj; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="kJXIb0sj"
Received: by dvalin.narfation.org (Postfix) id 0ED1120597;
	Tue, 04 Aug 2026 06:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785826559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GyKqvdPJboPC+rw5Gusa2cgeLAvNIQAvnaOSrAsjNyo=;
	b=kJXIb0sjXS6J6YN2e+ui3iWcElawhRrJGgO9Y8yzas0CSMpS5z0exulrOZiQektvxK0UOd
	qjRHf4Tmst837LEr9WNkPoUEJHN5++cuNpSYrNtcGUz03lc1nrxrmyC+c5IwEdYhqDbAtA
	bryJVhUpBf77YcQJWrVUW+u0VxLbifc=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 Jakub Kicinski <kuba@kernel.org>
Subject:
 Re: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-07-28
Date: Tue, 04 Aug 2026 08:55:51 +0200
Message-ID: <3386526.aV6nBDHxoP@sven-l14>
In-Reply-To: <20260803191920.0e6c5a2c@kernel.org>
References:
 <20260728133918.643267-1-sw@simonwunderlich.de>
 <20260803191920.0e6c5a2c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3093944.VdNmn5OnKV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3093944.VdNmn5OnKV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2026 08:55:51 +0200
Message-ID: <3386526.aV6nBDHxoP@sven-l14>
In-Reply-To: <20260803191920.0e6c5a2c@kernel.org>
MIME-Version: 1.0

On Tuesday, 4 August 2026 04:19:20 CEST Jakub Kicinski wrote:
> On Tue, 28 Jul 2026 15:39:03 +0200 Simon Wunderlich wrote:
> > here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.
> 
> Can you look thru the Sashiko comments here (especially Medium+
> severity)?
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728133918.643267-11-sw@simonwunderlich.de

https://patchwork.open-mesh.org/bundle/ecsv/pu-main/

We were just waiting for a verdict. I am guessing it it a "no, will not 
merge", correct?

> At a glance patch 14 does not inspire confidence. I guess patch 15
> removes the worst part - but is there a real reason not to use locking?

In its current state, you would need spinlocks over larger (op-count) portions 
of code in the hot-path. And since it it nearly impossible to get feedback 
from the TT author/maintainer, I am not willing to invest time in a total 
rewrite of the TT infrastructure.

Regards,
	Sven


--nextPart3093944.VdNmn5OnKV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanGM9wAKCRBND3cr0xT1
y3sqAP93VUsjB/3zBZEPOEwVl9F8KchEpqol2vmkE2mbdlui4gD/ZcZ0qOW3IWsP
+5olqy4xUDXtdwWKz+2KDX80Fe+2mwI=
=12G3
-----END PGP SIGNATURE-----

--nextPart3093944.VdNmn5OnKV--



