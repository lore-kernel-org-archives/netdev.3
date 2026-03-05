Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1739659F;
	Thu,  5 Mar 2026 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715735; cv=none; b=ebU+QnIyApkv62Batz8cE7/JQvUAaRQ25CylQO8HhjSywQjTegiycdtrI1LnM+ixDMNMiCXHokU0ctr4ouPDYZhvRrQ4+imfaeJglRJAWVG83v9XCf80Lmadof8wJYeQgn3OLeg4hUgiw4oVJGSKAxDiqxX+f6NLEyuIyJVARn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715735; c=relaxed/simple;
	bh=lDcJsUBjGSFKl6MrvZ3cOz/hZLTpvem7Tvya63+smjM=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n23BVcbi2kO/KFxbVeR2NTHi/9MD0e0DVDwuI+Xt+0mcif30rJSInGuzmbCZkz0tAyXNobshIT0SHxFhwuC/h8g4emUIxaAHPKCkAapdzrZMlP55DiKU8cP1u3CI7PZUiAvtqp4BkDtELv39YyLm1rKsAtyr8DtkMTOaW4FI1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Cl/95vf7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Cl/95vf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772715734; x=1804251734;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lDcJsUBjGSFKl6MrvZ3cOz/hZLTpvem7Tvya63+smjM=;
  b=Cl/95vf72sVK3hA7f4jwOBfsL8dGrfYUBAnVhpgKvAURz8WBPO1IJkwi
   wgMF41HY9vPTg05rp9B/8ht/Wfg/mc/1IEnf0PZe0hgyOhT1/289R86g4
   1Vi8BA3AYgY9EOfLjs94cstSFOY0RbPDVafbKkFRK6FN6AMpqCe3jRvad
   pWzkymRRAnXth/uchatcuddo4SV8LlO3eBrcjJZlYBRyTzM/BfelwyMYw
   5PDPFiWYl7EJGRbDEyFfv7fkjPgMRYpIshDu5W93fbHa41qhnDhMUX8k+
   1fjid3Eo+Bo1/RA38R8502zaa6CAngG/PQ4xcny3r9N0rDItIo0tGs/VY
   w==;
X-CSE-ConnectionGUID: ChIxbRkOQJywFkYs2byrrA==
X-CSE-MsgGUID: TK4XrK6xQ6aXl6g7NDOFeQ==
X-IronPort-AV: E=Sophos;i="6.23,103,1770620400"; 
   d="scan'208";a="221535225"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2026 06:02:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 5 Mar 2026 06:01:34 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 06:01:31 -0700
Message-ID: <85fd888f981ef57c84977cd26f59729672523ff5.camel@microchip.com>
Subject: Re: [PATCH net-next 1/8] net: dsa: add tag driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Thu, 5 Mar 2026 14:01:31 +0100
In-Reply-To: <c56db879-7556-4e13-bd59-2045d7048dc8@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
	 <c56db879-7556-4e13-bd59-2045d7048dc8@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-04 at 16:23 +0100, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Please could you try moving these:
>=20
> > +     BUILD_BUG_ON_MSG((_fld_sz) > 32, "IFH field size wider than 32.")=
;\
> > +     BUILD_BUG_ON_MSG((_fld_sz) =3D=3D 0, "IFH field size of 0.");    =
   \
> > +     BUILD_BUG_ON_MSG((_fld) + (_fld_sz) > LAN9645X_IFH_BITS,        \
> > +                      "IFH field overflows IFH");                    \
>=20
> > +static inline void lan9645x_ifh_set(u8 *ifh, u32 val, size_t pos, size=
_t length)
> > +{
> > +     size_t end =3D (pos + length) - 1;
> > +     size_t start_u8 =3D pos >> 3;
> > +     size_t end_u8 =3D end >> 3;
> > +     size_t end_rem =3D end & 0x7;
> > +     size_t pos_rem =3D pos & 0x7;
> > +     u8 end_mask, start_mask;
> > +     size_t vshift;
> > +     u8 *ptr;
>=20
> here.
>=20
> You are passing build time constant. The compiler should be able to
> track them through the call, especially since they are inline. So i
> think it should work. Please test it, deliberately break some of the
> #defines and make sure the build fails.
>=20
> I just think avoiding the macro would be nice, if possible.
>=20
>   Andrew

Ok, I will try this, and see if I can lose the macro. Thank you.

Emil
