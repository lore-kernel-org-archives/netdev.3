Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894313;
	b=YClfgs65OpK6Gyx17ZTDaqFwxJUEHTPIPG6bdkjgmckRJ7svN7WT6Tap8GGJCnUU2z18
	 THPUop7SQ15x2IgURgJPEHgk6Mwu/sdMi84yA+Ypr4ejbsRM9oYUecrGc30/gkSWJlyBz
	 820tvhhnrrnaztdczmkqCd6+ChOtaudsP77yvcDJ3LhGU6HqF9uwfLyhldsNaWLU3rChG
	 jwR1Uav0fDEUyEpUxToDrst2PSPtQBY614wtFyYzBEqlZGLT9QGGBqqadnpQZXhOCiUc3
	 Gql2rCfoUC90uN8gt+hKYeVneX68Jw2dZvbWzoltqkFJ6JwSeNCMthxc5j+WSONG/aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894313;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=GfbFkrlXGTj8hINUijGxcgmVVtZ3dmfEWvTEJmaVTgU=;
	b=l8fduf10v2QciI2bCQawzP2q0SWAm2PIvSgStaHab4jN0YeKmSGTmShESgCZSOI7Y5Jn
	 nZxPWLsYCjQwiQwp2hwovgUnAMIYzL3hbuY1ovjW9btxnVudd8UqKaf2e70TZfk5ILQN7
	 QmFiyUMYcwwgrI4Iue33jrJLXysATFRWtm0JyRmv0kgepKdpOpgC4Wui8TtEMB2l6DHJ3
	 +s2K6Uaa0RpgHkKHvG3lss6SI2TGjWxtlIUCetQSlNMq5FEi5PNyCtWTvsHpsX3PIkoSk
	 fvE02Yin5cNN96boOB23QuKKxLbkeAVjZnO6srYnsm4ddloOstWLaXS8XJOlAiCgK3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=DRzi4VEy;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030F606D818;
	Thu,  5 Nov 2026 15:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2030F606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=DRzi4VEy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GfbFkrlXGTj8hINUijGxcgmVVtZ3dmfEWvTEJmaVTgU=; b=DRzi4VEyFWHD2rFzpj6PhsP3kN
	F39iwasjm7/8Ev+0a46CatRL0nzjNA0i4Q/FX+iV8pcMaHXoAGnwk81GdGZCth5ndauFChEK3PP8D
	raYGuwthMY9TYT5rL30Bcn9SJ6LBRUDjIv2InceHI9uxm3ZPO9K24pQpfMKXtkaLHjw8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOzqx-00EbKh-DA; Thu, 05 Nov 2026 16:58:15 +0100
Date: Thu, 5 Nov 2026 16:58:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chuanhong Guo <gch981213@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Add Siflower SF19A2890
 GMAC
Message-ID: <ba32cd69-23a3-464f-a74b-68a29e7b8202@lunn.ch>
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
 <20261104-sf19a2890-gmac-v1-1-a15965a49574@telaak.dev>
 <e134193f-ba1b-47c1-9a06-419b1b796ea0@lunn.ch>
 <CAPY4CJ74O1tFVCpcN9seoeWDF0VR9GNfKuE+rWODQamN2sjL3g@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY4CJ74O1tFVCpcN9seoeWDF0VR9GNfKuE+rWODQamN2sjL3g@mail.gmail.com>

On Wed, Nov 04, 2026 at 05:16:14PM -0500, Joseph Telaak wrote:
> > Please add minimum, and multipleOf.
> >
> > I've not looked at the code yet, but default: 0 would also be good.
> 
> Will do: minimum 0, multipleOf 55 and default 0.
> 
> > These values are odd. The RGMII standard says 2ns is required. Where
> > is the rest coming from.
> 
> They are the values the vendor bootloader programs, and I checked them
> against the hardware. Sweeping each delay over its 256 steps at
> 1000 Mb/s, TX works from 0 to about 2.8 ns and RX from 0 to about
> 1.5 ns; 935 and 550 ps sit inside both windows, and a 2 ns RX delay in
> the MAC fails.
> 
> The rest of the skew is not programmed anywhere: the switch's PCDU
> register for this port reads back 0, and with the MAC's delays at 0 as
> well the link still passes traffic. So it comes from the board routing
> or the chips themselves, which I can't separate from software.

Do you have access to another board which has a PHY connected, not a
switch?

There are unexplained delays here. Is it the switch, this MAC, or the
PCB?

We need to understand if tx-internal-delay 0 really means 0, or it
actually means 1065ps.

Just because it works does not mean it is correct. We could be in a
two wrongs makes a right situation, and as soon is it is a different
device on the other end, it all falls apart.

       Andrew
