Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168B18BBAE;
	Sat, 25 Jul 2026 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784957282; cv=none; b=biuV2WU/CDOSNI+e0zv9sKiaViJsJRROzgOXFRxK09ijHHJf7UQ2cpOvS4g3aJLadtTSZ7VzT0J+R8J3GqJPas8hFBYNL71Ntcf6eseZz6ozBj16ISTDO2qlDPOcUW07GQ7+iFIyqddL0m3NmpgTKNNSOL4bU4pQ+8SXns/+/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784957282; c=relaxed/simple;
	bh=WbXVHduCuDrs2y1sGvPjYKTLP1W/0GdYZZI3+mhHJBc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PmFjdEWa5dWIAkiSA/6RKSRrtY1YsFQS2GOKkjCG1TKXFocDwYnjRQleDL5qdO3f6uHVN1s8eIyf45hk1i9Nv9fRJ8Ps2+2vj/xELDvwXXLNocovi9JjVQpiKjPutgK4hY1xOjR9TGaADwL1gQcBor59NeLiwZ+WXTGJI9+odQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=1zw4qVor; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="1zw4qVor"
Received: from smtpclient.apple (unknown [119.17.43.2])
	by us.padl.com (Postfix) with ESMTPSA id B1FDF60C2D;
	Sat, 25 Jul 2026 01:27:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784957272; bh=WbXVHduCuDrs2y1sGvPjYKTLP1W/0GdYZZI3+mhHJBc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=1zw4qVorQ/w6Sbp8ZSOn3FBPCi/n7QJ7oDEibuYGxQwbibJgcD4sFgXB5hiCZOqO0
	 xF2ZXa1vATZb8nFqB/yrgSvy7pIny0ZlcwAIzn2NzCRXsOSPyeZ7Xkj0kKYFa0SjaO
	 TsVsulzGQ3TtaWKB6yX3ceWLtHywe0EmnVCSP3tLzksK9qLEkPdLGcGBvMfJmKU8L6
	 ot5g0diZ+7qhyr/N6wnYMR98Z3Vu1IsYTu66J3zDaSg6kXgNG3g6KBy1LHti6X80e8
	 GRQ6vl36Czpt/NhSPGJL/AvkJq0XMG73OSGBDKfvbfEEE48iHHwIXbB9pHSiHXjhLk
	 QI3Ea5QOHXv9A==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next v3 0/3] net: dsa: mv88e6xxx: various hwstamp
 fixes
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260724165207.6a03c9db@kernel.org>
Date: Sat, 25 Jul 2026 15:27:23 +1000
Cc: Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>,
 Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CBF2EA4-E550-4763-A6BD-56484278E81F@padl.com>
References: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
 <20260724165207.6a03c9db@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)



> On 25 Jul 2026, at 09:52, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Sun, 19 Jul 2026 15:30:52 +1000 Luke Howard wrote:
>> Three fixes for improving the reliably of hardware timestamp =
acquisition
>> on Marvell switches. In our tests this eliminated missed timestamps =
in
>> ptp4l, whilst also preserving PTP event and general message ordering =
on
>> switches that support embedded timestamps.
>=20
> Do you know if there's any precedent in the existing upstream drivers
> for overriding the reserved bytes? It's not normal for devices to =
modify
> the ingress frames. Perhaps there's some precedent, but if not I think
> we should gate this (eg with a devlink param?)
>=20
> Andrew, do you have any opinion? Or perhaps Richard?

See hellcreek_get_rxts() in =
drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c.

In any case, Vladimir proposes to gate with a new DSA tag protocol (I =
haven=E2=80=99t heard any objections to this). I will include this in =
the next revision, I just have not had an opportunity to test.
=20
>> Note: squashing the two embedded timestamp patches into a single =
commit
>> may be desirable.
>=20
> I think it would be great to invert the order. Revamp the locking as
> patch 2 then add the new feature as patch 3.

Can do.

Luke=
