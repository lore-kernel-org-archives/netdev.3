Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3A33688E;
	Thu,  5 Mar 2026 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716526; cv=none; b=agThM/BRbx3pP8LWcmYoyPs7kfeH8ONGv3BocRUFndgUfaqeRjGqB8NNyfECp2dr09590asFH6ygXoIadT4RQzsB/MR3/yXTcs4Y+HIcbMpFshX5TdEf5HnUtBGaQ4rB/vPyK+JyQNoYYUF8sIHnqAtmXZkv7STSPJm9PSvDvdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716526; c=relaxed/simple;
	bh=BQx82kKpAvdhRVIM+1ubkyuv941jgAB3hTgR8aXCtm0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EkJ03kfftdeHqaARQ+xyKAWVnYjMkJ1HDkPpeuELpkyh2fyFqBaA2g1pBOINd6EkXB01DrajyfY2BWiN+VEJRcfDChEgkNJYtFvSJ8i/EBGRH1YQhud5Cj0bZ0pYXqM8wiWqX0+Sd6/CHpOc0b9Mf3bhksOiJNhJBvxDTUPwByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mEL/ZzMu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mEL/ZzMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772716525; x=1804252525;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BQx82kKpAvdhRVIM+1ubkyuv941jgAB3hTgR8aXCtm0=;
  b=mEL/ZzMuBb0OqpIl6mx49G633r81X30m2+/zpepvTQNrettJgEvs7rOt
   6xn6uCVSYDO4dVZJ76/JciluXl4SFqZLR6rCrzzloZP6ois0xdsmRU1hx
   /iyu7ek8w2Y3t2fuoZ6cRD4583kjoze2mhbjOi71qYW/YFMo9Lc5A/mNA
   YGSXe3Y4CLSFdeeDNuCDKl7uuOt1U8qa0yw90ttOsC2mjGZAayvkAD7VU
   FPDG4V2k+YT73lPVRP+z/Ir7JxKmzrQgQHQcqRYHgE6DgJi8+YO13iQNr
   pvKvXM3r+Urlt5QBHRlTgS+m5FIWjbOpR8T68fYbw097/YcHmpjcNzDDa
   Q==;
X-CSE-ConnectionGUID: awX86ziwQ/CZwqV1Wg+Jdg==
X-CSE-MsgGUID: bLTt1asZT1mwBNdgK6y27w==
X-IronPort-AV: E=Sophos;i="6.23,103,1770620400"; 
   d="scan'208";a="285648949"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 06:15:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Mar 2026 06:14:52 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 06:14:49 -0700
Message-ID: <047d2e23299d06494e06781ccc7abbe505aa3807.camel@microchip.com>
Subject: Re: [PATCH net-next 5/8] net: dsa: lan9645x: add bridge support
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Thu, 5 Mar 2026 14:14:49 +0100
In-Reply-To: <20260303161751.s4ryquinp2fus37g@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
	 <20260303142048.y4vu5i57daeuezxm@skbuf>
	 <930c6381b676f6c911e3c7235be5b08c7ca24e09.camel@microchip.com>
	 <20260303161751.s4ryquinp2fus37g@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-03 at 18:17 +0200, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Tue, Mar 03, 2026 at 05:08:10PM +0100, Jens Emil Schulz Ostergaard wro=
te:
> > On Tue, 2026-03-03 at 16:20 +0200, Vladimir Oltean wrote:
> > >=20
> > > On Tue, Mar 03, 2026 at 01:22:31PM +0100, Jens Emil Schulz =C3=98ster=
gaard wrote:
> > > > We support a single bridge device.
> > >=20
> > > Why? I keep seeing this from Microchip engineers. Having two
> > > VLAN-unaware bridges on different sets of ports is a perfectly valid =
use
> > > case. On Ocelot I took the driver from a state where it had an identi=
cal
> > > implementation to yours and I made it handle multiple bridges. I don'=
t
> > > see where's the problem.
> >=20
> > The main reason is that is what we support in other drivers such as spa=
rx5,
> > lan969x and lan966x. I saw your solution for Ocelot, but I could not th=
ink
> > of the use case, where you would not just use vlans on a single bridge =
to
> > isolate forwarding domains. But I may be missing something.
>=20
> I already said the use case, VLAN-unaware bridging, where it transports
> VLAN-tagged packets from one port to another without filtering based on
> the VLAN tag.
>=20
> You can't replicate that with a bridge with vlan_filtering=3D1, because i=
t
> would then stumble over VLAN-tagged packets which you'd need to add to
> the VLAN table, otherwise they'd be dropped. And then you couldn't have
> the same VLANs being transported in bridge A as the VLANs that are
> transported by bridge B, because you would allow inter-bridge forwarding.
> It's just not the same thing.

Thank you, that is a good point. I genuinely had not thought it that. I wil=
l
investigate adding multiple bridge support, but it would be for a future se=
ries.

>=20
> > The same solution would work here, but the bridges can not be vlan-awar=
e.
>=20
> Yeah, hardware limitation, there it makes sense to have a restriction in =
place.

