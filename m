Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8474A64CC;
	Thu, 24 Sep 2026 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265753; cv=none; b=r6Utt5gULWmVUFI8PztN+aTKj0l/zA72J0+GKWD+6rVATuJEbq8sHuLagjSBLXKmExDBlbgVA71xAFOJWVL2Yant4Tk2UNNIziidXu/TeTGD4lPzouAJe2NcpDclfYhZtxLlZttK1RzeR24+6b/DvDI48+WeFGuvyJJ4VtakI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265753; c=relaxed/simple;
	bh=m3aT+Q9KcjAVnZrusec3LFJm8HqZLZA6CLmCcSrpfAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+ZmIB/ULqJ3WryTtbPOMJaziRKUzMkP0TiBL5W946+9WXEJD67caBmvuPe4hDmXz07Vg19KNi1M5flUiOo+9aDadwG/DGTBE+J4RUKKF1O4qLDj1gK2sK7nHfIxEMFrxmygVHGc/p2OwXkTCAYE+N0hHEfM9kIxN52ETbpnjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kmx4KbUU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kmx4KbUU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5kqu4msBQ4bPA9UbwPhfUf7tiJJTHmh9JW9r09bgkbk=; b=kmx4KbUU5Z/OTnAMxRKrbvGjJ2
	tsbUFAUp8Zq2P/d+kbI2ASEwFWAxn/srG/qUNLkBpgH++jcfq3YIDgQEN5yjs3puCkJk4IJUwkgbe
	nzVe+dzzuXntHuewVTRpZhCQJWweWiAZLzTIwMQNYwq17DDMIfP6U96JtPCsZJJhk7Vs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9ltj-0071tD-RU; Thu, 24 Sep 2026 18:02:11 +0200
Date: Thu, 24 Sep 2026 18:02:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v3 0/5] net: stmmac: Add support for Allwinner
 A733 GMAC210
Message-ID: <491f043e-6dc6-4936-a490-31a3362c5b6e@lunn.ch>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
 <9cc61625-47c9-4bdf-97f0-0528f661a399@lunn.ch>
 <1j7bkb9h5k.fsf@starbuckisacylon.baylibre.com>
 <5fae3b42-552a-458a-9710-927360e58c37@lunn.ch>
 <1jv77u8yak.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jv77u8yak.fsf@starbuckisacylon.baylibre.com>

> It is not the PCB doing the delays so rgmii-id it is (in DT) - got it.

Yep.

> 
> I dunno what is sane or not, but the allwinner dwmac drivers do set some
> delays. sun8i-dwmac and sun55i-dwmac do so, even before this change.

As the document i linked to says, doing small tuning delays is
fine. We strongly prefer the PHY does the 2ns delay, if it can.

> If I understand correctly :
> 
> """
> When the MAC implements the delay, it must ensure that the PHY does not
> also implement the same delay. So it must modify the phy-mode it passes
> to the PHY, removing the delay it has added. Failure to remove the delay
> will result in a non-functioning link
> """
> 
> IOW when the gmac has *-internal-delay-ps set and honors them, it should
> also amend phymode seen by PHY to make sure it does not add its own
> delays, should it ever be fixed ?

You need to differentiate between small fine tuning delays, and the
2ns delay required by the RGMII standard. If the MAC is just doing
fine tuning, you need to still pass PHY_INTERFACE_MODE_RGMII_ID so the
PHY adds the 2ns delay. If the MAC is adding a big delay, you need to
pass PHY_INTERFACE_MODE_RGMII to the PHY.

If you have the schematics, it would be good to confirm the strapping
on the PHY, and add a comment in the DTS file about what is going on
here.

The other option i hinted at was use phy-mode = 'na'. I'm still
considering this, it has some advantages.

The problem with passing PHY_INTERFACE_MODE_RGMII or
PHY_INTERFACE_MODE_RGMII_ID to the PHY is we have no way of knowing if
the hardware is honouring it. It appears the board you are working on
does the opposite of what we would prefer. I guess there are going to
be other similar boards, but are they going to get a similar level of
review and the issues spotted? Are they going to end up passing the
wrong PHY_INTERFACE_MODE_RGMII value to the PHY?

By making the PHY reject PHY_INTERFACE_MODE_RGMII* it makes it very
clear something odd is going on here, and care needs to be taken. It
will be very much in your face for DT writers, so they are more likely
to get it correct.

And if in the future we do find out how to control the PHY delays in
software, boards using phy-mode = 'na' are safe, no change. Other
boards which got passed review could well break. Been there, done
that, don't want to repeat it.

> > But this PHY is going to cause you lots of problems.
> 
> We don't get to choose I'm afraid :)

Yes, you have just the first victim.

It would be nice if somebody reached out to the vendor and asked if:

Can the RGMII delays be configured in software?

if not:

Can the RGMII delay strapping be seen in software?

If we know the strapping we can at least return EOPNOTSUPP if the
requested does not match what the hardware is doing, and we get a
clear indication of a problem.

    Andrew
