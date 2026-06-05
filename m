Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367994A3410;
	Fri,  5 Jun 2026 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661166; cv=none; b=fPhsl3IOxYvAWq55swUV96Z8wxhyBPdAh8aszVWbPaS7pJcG4k/rrNXSPsHs0unGBm+KNJ59g+qbsac3e0JoaAa6URG19WquOUzewJS5p/caz8iVFpIiSvSQ32oidqC1joqiE892WcLBQRM79Zqj5UbfUHSje1Y5JdtjWbMC3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661166; c=relaxed/simple;
	bh=Vxh3wg9HhEr1qAX4WFzBiSO8Vz9T8RHOzpTn4p1z3tg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YLfdWN3196xMaPEqGgutMSYjB0BsTwCE+g9UFvpGQzFrNtxJlqTJwd0KgULqaH0rq/iqm9aiXGyGCGmCnxCv81xzVn/uXlp1IaieX/9laTy8qdDDZbpeRyG+28fSmk07jgZO7kUvdCF3YrS8j4KTla29rtWQYzbCBG0wLbg5x48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=y9Bu3EFF; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="y9Bu3EFF"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 5A7B760C11;
	Fri,  5 Jun 2026 08:05:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780661155; bh=Vxh3wg9HhEr1qAX4WFzBiSO8Vz9T8RHOzpTn4p1z3tg=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=y9Bu3EFFo/XPLXE6WcTk9fDcnEGy/hmWKfOwBDzLbTIuIF78Ms1Co57a9r0yrpZE9
	 C8tA84J+e/6YSe12URoFkXpJDrdCKgNJOC0LbF8eB64d+1J/OdAs7+UQcTzLIfsbAH
	 Y2QZHGKdTkFqehfxNwcDdLHCOvoqYVKov8c9JWvWHEO9MF79FFlhpK01BimML8BDxR
	 4aptKO3jP+CSX8iSL0KfIlYiv9yURIAZRsNT9kXHbDlcAW0UWUZ9bhwAsj1q/VFBwf
	 jHONYOv1o6vYGLvwgwncQYgZT3u3/rM5J+5B1l4AvZZXCWKeaAEIqb5tbevBKXkt6h
	 CbTq54tBhlnvw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb pcp
 app
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <B9290FD7-FB84-4FF7-BA30-529484B8A01F@padl.com>
Date: Fri, 5 Jun 2026 22:05:35 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 cedric.jehasse@luminex.be,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Max Hunter <max@huntershome.org>,
 Kieran Tyrrell <kieran@sienda.com>,
 Nikolay Aleksandrov <razor@blackwall.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC4059EC-F03D-4F7C-8F76-3D8C30E94A14@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
 <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
 <E43832AD-0F8A-465F-95E3-2AF5E72FB7B9@padl.com>
 <4d6e6d83-af79-4a06-9736-d6d81e705a61@lunn.ch>
 <B9290FD7-FB84-4FF7-BA30-529484B8A01F@padl.com>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> On 5 Jun 2026, at 11:13=E2=80=AFam, Luke Howard <lukeh@padl.com> =
wrote:
>=20
>> Ideally, the user should not need to know if some functionality has
>> been accelerated by offloading it to hardware. They just configure it
>> using the standard Linux model of the feature.
>=20
> Absolutely, and that was the model I used when building a SRP daemon, =
which I first tested with the software bridge and some i210s.

Which does beg the question why I hadn=E2=80=99t considered the =
admission control issue when originally implementing against the =
software bridge. That=E2=80=99s my bad, and perhaps had I discovered =
tc-flower earlier I would have a different mental model of how to map =
this to mv88e6xxx.

Also whilst the admission control is necessary to correctly implement =
802.1Qat and pass the Avnu test suites, it might not matter for many =
networks.

I will think about how to implement these semantics with tc-flower/TCAM, =
likely after I take a look at submitting your DSA in-band/Marvell RMU =
patches.

Luke=
