Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49830394496;
	Sun, 20 Sep 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939316; cv=none; b=YLPVRRXh/VSJK6fleyxOfNFNN6S5/kMes2HQl8PkGCGb/nPTN0P54dfbisEcTNr8k7jwRlWAgJZAbCBFXOvfaSGt2DsUJ3h3+0JFZUlVTajAAIRuO3pmZmsQWRS52n1E6LGciPknTXgmBXYu2zc5+BfH0a5A7mDUDeIgQ0x0oyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939316; c=relaxed/simple;
	bh=sCqdG5tITi+sEKmQe9DaKyTZUt8EyLeQx0yjxQY2mvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTd+bJIpe4qQxwI/kY6GnW5bUolt/cHIiKwQJTcHPfix3JkUbd3MeRq7p+idlPnPmwvgCJWiviR1ToarVH2MU8qK/EybAjzYA8wA5H1oKwJJWTP2lwdWIvHH3UslAGjJJpLBO1JTuk94qwdAO6MH+s0bsATVuCnSa0Uryedww6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0iaJtTrE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0iaJtTrE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FB0KgZnHO+5TeXbVP5m2pN484ljj1MT+O70LAuAOPFk=; b=0i
	aJtTrEr8Cou6guI+SGDZ0ioW/Zsjy9PtA351tz1XKeFyop0N97odAxrO2gywy7f0l8xG9p6UTx4eS
	colNvFndUPwAWOxL1qWCasBjeqf+Ocg58ZFqZKtwgTw2pFsstkwB2k2ZEQ5l3oSppMsJVTkGTGFNV
	UCGXzaDq4QmCicI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8Oyh-006Ctb-Ti; Sun, 20 Sep 2026 23:21:39 +0200
Date: Sun, 20 Sep 2026 23:21:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Nicol=F2_Giuliani_-_nicolo=2Egiuliani6=40studio=2Eunibo?=
	=?iso-8859-1?B?Lml0?= <nicolo.giuliani6@studio.unibo.it>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: R: R: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if
 the TAI period is invalid
Message-ID: <f5d30e0b-9b10-45b4-a158-19c946c0c8bd@lunn.ch>
References: <20260919-send-net-v1-1-4355c72465ee@studio.unibo.it>
 <66937bde-51a0-49d2-9ae7-f27fb4f8ecde@lunn.ch>
 <DU4PR01MB12163870875DEF21E5C39DD2D80852@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>
 <fde8b48a-10ed-46fd-b477-18ac57df8a88@lunn.ch>
 <DU4PR01MB12163D71C8AF5C7695B2FB8BD80852@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU4PR01MB12163D71C8AF5C7695B2FB8BD80852@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>

On Sun, Sep 20, 2026 at 07:08:57PM +0000, Nicolò Giuliani - nicolo.giuliani6@studio.unibo.it wrote:
> Hi Andrew,
> 

> Thanks, that is what I needed. I checked it on the board (chip ID
> 0x1930, so the driver entry is the 88E6193X, family 6393, which uses
> mv88e6390_avb_ops and mv88e6352_ptp_ops):

Marvell names all there devices 88e6xyz. The x indicates the model
within the family y. The lower the value of x, the less features the
device has.

So i could well be the 88E6193X does not have avb, tsn and ptp.

Marvell has a vendor driver for these devices called UMSD. It has an
open source licence, but it is well hidden.

include/driver/msdSysConfig.h:	MSD_88E6193X = 0x193,   /* 88E6193X  - BGA package - No AVB, No Routing, No Cut-through*/

So i would say PTP is not available on this device. Please could you
submit a patch removing the mv88e6390_avb_ops and mv88e6352_ptp_ops.

There is also:

        MSD_88E6191X = 0x192,  /* Amethyst 88E6191X  - BGA package - No AVB, No Routing, No Cut-through, No TCAM, No 802.1BR*/

Maybe you can review that entry as well.

       Andrew
