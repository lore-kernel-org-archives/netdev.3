Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103A270540;
	Wed,  6 May 2026 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050773; cv=none; b=p4r2XP5JwQrMcOBzGN9koqj3oSYQyodUlG9RyNtp6/XPZLg30VeVktg1wZ8XmBkljlg/flr9SHwyKPfnuwP9cwxz0TnUHwDE4mDUGLD5NgZZVhhLoDcBbsqVcA1iAWiF4gqlKdX2ndk/P57etI16BqsCQZzWFzfiAU/LPhgPy9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050773; c=relaxed/simple;
	bh=OuBEQNey1grD/IYbbeoP5nsU82zoSbQOL9Q0E7vD3dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkijhYW68YqpM8gGb7HHnzjmjdLOhKvhxXscgnr9eGSgXjULWmcCI748Jwm5phh214/XM+FYdp76VeqXneD/t4+2Tlru3GVbbF6HLkS44bRnBzdQ6ILn0XFt7wCwyAYvtJQzgxVmJNQAI4AoQPkDCOLr31MXFcw+j/kJRPDbuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=JjglE0W1; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="JjglE0W1"
Received: by dvalin.narfation.org (Postfix) id 502FC20DBE;
	Wed, 06 May 2026 06:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778050762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWVaLyHPZtQIn5sUjDowWMmG8VQiZnZt08qHxOQJwuQ=;
	b=JjglE0W1bfq7CphEirApsrNeQYJaIS6NCjTH4w6oaUSZnTubnpGXNM4D73Qn4sPK4Qk+p0
	iqA/gOzCTPfEzEzqflV/fXf5HwcyLJgQAdZUYH1JSAotz5mSxIKmBWb9gf8lnkFNV0BGCN
	eZ81mGfDt1HRb5suqbqyZ+kFwIPlcAs=
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>
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
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Wed, 06 May 2026 08:59:19 +0200
Message-ID: <5367405.irdbgypaU6@ripper>
In-Reply-To: <20260505172017.6caf7347@kernel.org>
References:
 <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
 <5990011.DvuYhMxLoT@sven-l14> <20260505172017.6caf7347@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17108528.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart17108528.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Wed, 06 May 2026 08:59:19 +0200
Message-ID: <5367405.irdbgypaU6@ripper>
In-Reply-To: <20260505172017.6caf7347@kernel.org>
MIME-Version: 1.0

On Wednesday, 6 May 2026 02:20:17 CEST Jakub Kicinski wrote:
> Ah, I see. I was asking because I don't recall us getting much batadv
> patches CCed to netdev. Maybe it's simply because there wasn't that
> many of them to begin with.
> 
> If the rate keeps up let's add an X: to MAINTAINERS to avoid
> netdev@ being CCed. IDK if that's what X is supposed to be used for 
> but we use it for wireless and bluetooth already. The PRs still
> flow thru networking tree, but there's no need for netdev to be CCed
> on 99% of the patch submissions.
> 

Thanks for the hint, queued up a patch:

$ ./scripts/get_maintainer.pl -f net/batman-adv/*
Marek Lindner <marek.lindner@mailbox.org> (maintainer:BATMAN ADVANCED)
Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED)
Antonio Quartulli <antonio@mandelbit.com> (maintainer:BATMAN ADVANCED)
Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED)
b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
linux-kernel@vger.kernel.org (open list)


$ ./scripts/get_maintainer.pl -f Documentation/networking/batman-adv.rst
Marek Lindner <marek.lindner@mailbox.org> (maintainer:BATMAN ADVANCED)
Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED)
Antonio Quartulli <antonio@mandelbit.com> (maintainer:BATMAN ADVANCED)
Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED)
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Shuah Khan <skhan@linuxfoundation.org> (reviewer:DOCUMENTATION)
b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)

$ ./scripts/get_maintainer.pl -f include/uapi/linux/batadv_packet.h include/uapi/linux/batman_adv.h
Marek Lindner <marek.lindner@mailbox.org> (maintainer:BATMAN ADVANCED)
Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED)
Antonio Quartulli <antonio@mandelbit.com> (maintainer:BATMAN ADVANCED)
Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED)
b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
linux-kernel@vger.kernel.org (open list)


@Yuan: Thanks for updating your internal rules. But the main problem (more 
patches send to netdev) was caused by my oversight. Btw. thanks for all your 
contributions.

Regards,
	Sven
--nextPart17108528.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafrmxwAKCRBND3cr0xT1
y4M7AQD3C+0KX+H35fwADJMKyyDf2c6YpeMAzo+O1stjymGMpgEAwQzkhEb6I/tf
HEOwkJ70VPq8m4RGK8qvBwrpKpKFNgc=
=cvFu
-----END PGP SIGNATURE-----

--nextPart17108528.uLZWGnKmhe--



