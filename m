Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BF4968E4;
	Tue,  3 Mar 2026 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554136; cv=none; b=DWVDSHx4zGLoxx4Gc1NJ71mqK3OqgYSRy8CoAisnAaH+DbzTgz1pmNUrjHjfqhSVLHn+bIt2UdPVdJ49Ka0TVe2SaTGLQfi+jNcQgrK3MwRUUtisKO6ZnClVNkICE+KNpL6MrsTH0U7RJRdzQzGfzjAWvF5GZVFw0cbCVC8LE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554136; c=relaxed/simple;
	bh=LxDpmZIStQFl4pKJuLi1lEHlzuukqL6IbdtXzKTYw28=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KaZJaHn4o+waBnndMHU4ozJlZ5P/bo42qhgrXha2M2GVT0xpC6B3/3YyM4b78xIjQsLrwLSqikd1NWWI8t/NIbkpNV2a2H4eUM1ysWMkCFFjblkZUxWYbfftpFNxKa5zjjRv6BIHCwuBNtdCt5nWKTV3rtgorOvSwlpx0SEA0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VFMecLyX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VFMecLyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772554134; x=1804090134;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LxDpmZIStQFl4pKJuLi1lEHlzuukqL6IbdtXzKTYw28=;
  b=VFMecLyXZdg1PMdXqUawN1jPTfir56b21JYu7mwdBdqXlV8VxaYD4f+9
   wtSiHoqbjKxapSzBok8gfKw8gQE0crtQ2RTM9nSzCgwjpZCU8mdPYBAQD
   sgCoppCEpcje9+5hpZnsFxANbr2acUYJV6vQy0D0lfbD6jH0BO4GRsVan
   IRXQUO/hnO2tb1mv8/RpilJiVT+f+1kz/iYBKQCJWj49Nj/yT29R2NMuy
   OyujCYQXD6mxmHK+bynMnfMtmqjHRe7AlFsC6TfgKYcblwR1WzZHFcT6l
   4sYnUttHqx7Fhrs2ApNYc77DYpDRB8qOEeHyS759qd/hVtr4AHmMfMk2u
   w==;
X-CSE-ConnectionGUID: 8DytlORHRCqQU3ifMLJo7Q==
X-CSE-MsgGUID: DnESnoheQQSdOZ5CQBVMug==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="221420262"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 09:08:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Mar 2026 09:08:14 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 09:08:10 -0700
Message-ID: <930c6381b676f6c911e3c7235be5b08c7ca24e09.camel@microchip.com>
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
Date: Tue, 3 Mar 2026 17:08:10 +0100
In-Reply-To: <20260303142048.y4vu5i57daeuezxm@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
	 <20260303142048.y4vu5i57daeuezxm@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-03 at 16:20 +0200, Vladimir Oltean wrote:
>=20
> On Tue, Mar 03, 2026 at 01:22:31PM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > We support a single bridge device.
>=20
> Why? I keep seeing this from Microchip engineers. Having two
> VLAN-unaware bridges on different sets of ports is a perfectly valid use
> case. On Ocelot I took the driver from a state where it had an identical
> implementation to yours and I made it handle multiple bridges. I don't
> see where's the problem.

The main reason is that is what we support in other drivers such as sparx5,
lan969x and lan966x. I saw your solution for Ocelot, but I could not think
of the use case, where you would not just use vlans on a single bridge to
isolate forwarding domains. But I may be missing something. The same soluti=
on
would work here, but the bridges can not be vlan-aware.

Thanks,
Emil
