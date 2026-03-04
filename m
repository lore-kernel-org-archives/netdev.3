Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8335BDC9;
	Wed,  4 Mar 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639912; cv=none; b=XSo+7pyI8g8QZ6rhsWhCzH+svZxySFrplVMtt2jdiCLT0UeZkpvGKu7u5FfcLoavV8KsS764GGkOXbQcJBYT18HAV+kR8fQ4yUi35W0J6cOFPk0LTeAOBby6ZvZ0MhcMjnCHDZ92EJrnZZbImdFJJ6777q5Mfx4TMD0S+Gjf2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639912; c=relaxed/simple;
	bh=1RRTbY3SGktJdyWOPOzQaSYkqAKmrqU4ZpxOmRLTR7o=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPiPnFlR3YZi6hhHKIkSXhSPqGcGGvKrzsQChmlcs3sd3PBvb4NdLWEc0SOH2pbvbSg0AzH4udQLS/gtchos8YbmkDeZ+aJ7h3zMqie49YQJm6RbvIu9vriuqEtHbyPR6s54hu0w+1/etcFR7u2Seo1Zc1mfDy+ixQA2Ku9RDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VnyvY7Zk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VnyvY7Zk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772639911; x=1804175911;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1RRTbY3SGktJdyWOPOzQaSYkqAKmrqU4ZpxOmRLTR7o=;
  b=VnyvY7Zk7RxSkfl0Lo9Yow2aG5ip+WfI6Z3+g8J11/F2mEazqEe36KWP
   nlDRnR+VpaK2pChL5c1kuwrMg062CYHs2JCgh2Kl1TdaPTyjLQ023re2M
   iNNUjy49Fqtsc5pwBxcY5sQJ1Kco/rIMd6r73EDke+FLN0VZf7a2kWmbn
   TMxlGqtdx77DRIXpF61uvbywSjzijEO7PMm6qSbvTa5ZAahZdkuIpioZe
   1bs9wjsKrfjGj1Xvu6OzETl4LrOWzC/11O0XdTnZJ6BQMrlQJ82Qdv6Q9
   o62/zvMMUH9FxNAwOR29A7brzUAGKY65RKijm9nRa3pZKRRwD1k4E8z4j
   g==;
X-CSE-ConnectionGUID: qihZI3FOR56kF+DH8Kf2+g==
X-CSE-MsgGUID: 8aACVApmRCe8QnD3hjp4BA==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="285599485"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2026 08:58:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 4 Mar 2026 08:57:52 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 08:57:49 -0700
Message-ID: <ce78c1219945039b36efe61a1192190276dc10a7.camel@microchip.com>
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Wed, 4 Mar 2026 16:57:48 +0100
In-Reply-To: <20260303-mosaic-debate-90cf8c8bbb33@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
	 <20260303-mosaic-debate-90cf8c8bbb33@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-03 at 19:04 +0000, Conor Dooley wrote:
> On Tue, Mar 03, 2026 at 03:18:45PM +0100, Andrew Lunn wrote:
> > > +        properties:
> > > +          microchip,led-drive-mode:
> > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > +            description: |
> > > +              Set the LED drive mode for the copper PHY associated w=
ith
> > > +              this port.
> > > +
> > > +                0 - LED1 and LED2 in open-drain mode
> > > +                1 - LED1 in active drive mode (can be used for singl=
e-LED
> > > +                    configurations requiring active drive)
> > > +                2 - Reserved
> > > +                3 - LED1 and LED2 in active drive mode
> > > +            minimum: 0
> > > +            maximum: 3
> >=20
> > I doubt the DT Maintainers will accept that. This looks a lot like a
> > value you write into a register. How are active drive and open-drain
> > described in other DT bindings? Is there something you can reuse?
>=20
> I had a quick look and I didn't see anything really that stood out to me
> that would be a drop-in replacement.
> I also tried looking in the datasheet for more information on these
> modes, but I couldn't see anything obvious. For example, there were zero
> hits for "drain" in either LAN9645xS or LAN9645xF datasheets.
>=20
> That said, yea you're right about DT maintainer feelings about it.
> There's a couple things I could suggest, but I'd like to know about what
> mode 1 means for LED2 first. If there's actually nothing similar, what
> about representing each led with a child node and having open-drain be
> the default with a property in the child for active-drive?
>=20

I will ask design about mode 1 and LED2, and get back to you. The register
model I have does not mention LED2.

> >=20
> > For 1, what happens to LED2? Not used at all?
> >=20
> >     Andrew

