Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E227A91D;
	Fri,  5 Jun 2026 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622054; cv=none; b=BztTgN/Byl+Adb0ETkGk0lmwgQXoQT+4oPtj3RTOk70hAHDYCDfwRnqnR1E31gYCxc9/vKMhaVSBOxUJ55Vdu5foyzNEN3TMHqNuBeygd+bfNc5A+9vfy496+j0Kk/CYJdSbEneZy4CR3r7tvMhn2a05DJTz7bjvD/1BMHdvJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622054; c=relaxed/simple;
	bh=DrfrjKEiOQMi4PdJ4tlqIf5bMHmaoVxpAStGpcKRSzc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=txK6xQkU6sEiyNsXjgcbPlBVgD+HrngSimttoW4tyi4n5TCMvlcmsKsciT0iFCVGsom9XmyM8SMrVFACc7o5nekg53g/jqmd3YBCmbWu8LubAsm6+RYHQ+fc9SLrSLGdvTYiZvpONVcojNePq3tcudRXGL51EybvdOsokkKWpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=oDmkyogF; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="oDmkyogF"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 2831C60937;
	Thu,  4 Jun 2026 21:14:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780622051; bh=DrfrjKEiOQMi4PdJ4tlqIf5bMHmaoVxpAStGpcKRSzc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=oDmkyogFljIzJqXnVOl8N6/Z1kZ8rd/mJgU/o0OrOpVUeL8DjCpBOfUpS0pR0IKxn
	 4Ulg+dMVm8mI5d598F3TyKPE9gre0i6QECupfnwYmae7zkb74kYp3+v/7qdWhZPc89
	 8xlnQl18znnEZMBZ7wLva1NbgYrVBqnhxYeB13mFqcaxMbguXpY5KhEMRmPwHDvzUm
	 MWpfb8ssI7lKribphXyl89P+batCi/NwOgz27KyR4RCupNVR+pDPCodmbnjT3niroz
	 ZqCKdTG1QrdOG0NVcWtrpw7xc0wzre/SnHbyl0xpha357iFkxy6EcyVeLj4V2nc6RL
	 Ur4T9AVp8AHbA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb pcp
 app
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <4d6e6d83-af79-4a06-9736-d6d81e705a61@lunn.ch>
Date: Fri, 5 Jun 2026 11:13:55 +1000
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
Message-Id: <B9290FD7-FB84-4FF7-BA30-529484B8A01F@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
 <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
 <E43832AD-0F8A-465F-95E3-2AF5E72FB7B9@padl.com>
 <4d6e6d83-af79-4a06-9736-d6d81e705a61@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81)

Hi Andrew,

> I don't know enough about AVB, so this might not apply here....
>=20
> What does the pure software version of AVB look like? Is there a need
> to configure these parameters? If not, why not? If there is, what API
> is currently used?

Qdisc configuration for AVB is described here [1] albeit with reversed =
numbering of TCs. CBS parameters are usually managed dynamically by SRP =
(in user space), but static configuration as shown in the link would be =
common for automative AVB/TSN.

> Ideally, the user should not need to know if some functionality has
> been accelerated by offloading it to hardware. They just configure it
> using the standard Linux model of the feature.

Absolutely, and that was the model I used when building a SRP daemon, =
which I first tested with the software bridge and some i210s.

One issue is that AVB is typically configured using MQPRIO, which =
configures egress queue mapping. The Marvell switches support ingress =
queue mapping (the subject of this patch), although there is a special =
case for AVB traffic which does allow for egress queue mapping.

The main issue is that inbound frames belonging to AVB TCs that do _not_ =
have a SRP-managed DA must be dropped. This permits those queues=E2=80=99 =
CBS bandwidth to be reserved for AVB streams.Marvell implements this =
with the STATIC_AVB_NRL entry state, combined with an ingress port flag =
that enables the packet filtering.

My patch mapped the Marvell model to the software bridge, i.e. new =
IFLA_BRPORT and MDB flags. However, Nikolay (correctly) points out that =
these are unidiomatic for Linux.

My understanding is that these should likely be managed with tc-flower. =
The SRP daemon would manage tc-flower entries along with the MDB when an =
AVB stream is admitted. Unfortunately, implemetning this in mv88e6xxx =
would be more complicated: it would either require intercepting the =
tc-flower requests and mapping them to native AVB admission control =
(which may be fragile), or adding PCP/DA matching to the TCAM =
implementation (which may not be sufficiently performant, more research =
is needed).

Luke

[1] https://tsn.readthedocs.io/avb.html
