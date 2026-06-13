Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790EA3A784A;
	Sat, 13 Jun 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781345601; cv=none; b=bv78urhqAvN7JVdPyMnu7YU7B/BrvD+AK0g7b1t4dd7JKBBhFULr7IckuUum11PIroh6r9NkYLVyXZEFJ66MTRePQqaCftn6J/Ugvfwnf7xKD1RdLM3YG3hamcmPyhNuxzvV/D7tiCsCP+6hhQ4ekrafCv6euBu2eP9UBL/Kby0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781345601; c=relaxed/simple;
	bh=XWr2ViDxG+5b0tX4u/PVJgO0R0GtLLd7knuotpex0Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+Ox0pt+sV/J4tpFCdzDLqQdzkQvXju5ht+EMGOmIOqltYuyvFi3qeQeqUQJ75nr17/Y3oP1fjCv8Xu/sID1SsPBq+yHEQKpz051RXKlA10DBkRAHOABXIQlPHG8+DyVP3X63gPdzEne+s/ksL7f+7scgGl1PLdApeLKczgN7Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=qEVpVVFw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fw6eJfeQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="qEVpVVFw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fw6eJfeQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 533D614000E7;
	Sat, 13 Jun 2026 06:13:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 13 Jun 2026 06:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781345595;
	 x=1781431995; bh=oJWNqi8YiDM3/qkksN3NwWVH+hMA0LUQBNi9uZMiqtM=; b=
	qEVpVVFwlrsXa5jHCRnN7ZqKIstXvt73TY5a/PrdcHn9Mcnf8qclvCVutW2URftU
	/7dxz4LFFA+lzpPto1DhfiadvWabgU8yRm6y1WDImW58y0VUmBl5urWJ6lC25AG2
	FxUlFF5WA1Mc0oWpwqZuqijQOKEtxBfQW46kDvJsDltho0Tgz0xuy3kCcMk5dtqT
	Ho4E6bGLt6B1OhCcuOEf91cizDVsN1mPqtvP4WS1Qn5grIMJeeELawLsvhmBHuAE
	kmikoHxUOL9YD8m9Zd4kDV8AgKWpZwt9ScNJ2wRC8bgH5yePgGL/OJLjxa/zlpHz
	p+YzkM+UX0cvF0qRDH0EWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781345595; x=
	1781431995; bh=oJWNqi8YiDM3/qkksN3NwWVH+hMA0LUQBNi9uZMiqtM=; b=F
	w6eJfeQWlRTXXI5beqZS1mS6FJglDyC4ZOnMWuzuNZvJwgrP9eCtqHgH8WnpxEJl
	wYq7EN4/W/Opu65PAAx61kAoHrCmAOg9DHG2vIIhgC3bD6iyBUZC37SzRiz4ow+F
	byyjofh2Hzl2kElwCxSnZTcKN8pF2lVC4bnNgu7gXf2CSd31nd5xwUq7vHR5u2FU
	CtpyOVXKlRhgTWdVXvTNF1p1in1n6lOM2a0SEm8qe6++A2+elsyLmonpDnoUiHiL
	uQs+9Poc9ERWy7SYsb1499LFpdm5qjsNjTUzoqLHylOMBIye9E8V0SPrd1Jo82KN
	7TvRNfi6oPGD1B3s1O9pQ==
X-ME-Sender: <xms:Oi0tagWPtgkBiDlIfbSqQ_i1cj-qcHmV2mRJIcnQ0wZXQK7Z19kTPA>
    <xme:Oi0tatX-_fLsqDoM2hx4-ZtPdpfFjzJBb6-BIV47A675GapskgFLy7skDPzFBik2n
    fktjewKF9GTOunqC_uWJ0giChMbMV_ROsaXfMO8X5UCfSukEUlPc28>
X-ME-Received: <xmr:Oi0tajH-E5Yo0_kOPrk5Zoa1uFmtnAf1cq-RpBe8GvLgQjULbP5Uw2UkN7AEKNHctq2gkMiKhM37CC7qprZAOhszll1U>
X-ME-Proxy-Cause: dmFkZTFPjz2AtWzaPdwb3DBOUAu0g1TCZlT/a3Ha3DQQrXQlWVlfBgKGnWb3yo0sLUizn1
    g4M7BuwLK4dc5vDFjroS4x5WNEPOkUG7TMWODTPZQt+ap09VRJtA++ENhDmtJ0n0Wed37Z
    DPZPPA8105U/m+nQ6wjtt/CijwTMBswxACyELkXeX93JQCpdwmwl3zeWow+6VtS1IN1zAy
    c+1d0F3j8tdUM/FCcA2pCtOq7/KtGIe40Ra2auAteRTF11JH8JxDLOgT5yPFlhUco3jTu3
    Xq4fgb/gnJf66rREfKSMsEf/00ERDcQytMpE8sI91DJdKbM35xbH3sZ6OY2Fo+Op+EqGmm
    pop+z5roqVvDLKfn7T8eJU8N75tKAE39Ok9Kpq3J1NO5g+293uD1gRLCwqKccLH8VJoxn3
    WeMbVKx65h2In8hge6AGt8ZLVc368hdjT0osPXQ0BaIoFepGYjmnwcB4/t5BkGa8g4W0Wn
    Hp6wt5GGhBnRHTelndHWiZ72sh/CPQouvwb8ovFhHjCqO2QT/faZ7WELPSK+UfHPR14+G4
    JGv5OnklXp+7mdQkU1VuPdleIRvCOS6HKTmvWedaMJpESgxoMZVFNTak6BUsunj3bgikY9
    LAyYFKNMFU4AX6uz8uGik2lqgvUDh9DIZbVrQWvxlOCfpEBNcaP1v0IxJeoA
X-ME-Proxy: <xmx:Oi0tahvYKRI6h6MnZ0cbPLkjE4B0RVL6oR1wSFpQkQObSqQykOXl9A>
    <xmx:Oi0tauYElJIQBXtkUGriUIotMhD02DZTkb5A3RVMyN8kLPa5NDJWBQ>
    <xmx:Oi0tapVwa2Gi4YCJw409-NSUXzambu5sYZrHdaOctYVV9CiAXMTbRQ>
    <xmx:Oi0tagLX5hYc4UxXMnBFbFnni9v3YrfbR_qxuWYaTNHuQQMoU0jLOQ>
    <xmx:Oy0tar44QcaWM0rar-WgeGsh-kqZuvvuNHgb7Yax3D9haLuqNnkE1Tst>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jun 2026 06:13:14 -0400 (EDT)
Date: Sat, 13 Jun 2026 12:13:12 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next 8/9] dt-bindings: net: renesas,etheravb: Add optional
 gPTP phandle for Gen4
Message-ID: <20260613101312.GB1113977@ragnatech.se>
References: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
 <20260610102432.3538432-9-niklas.soderlund+renesas@ragnatech.se>
 <20260613-caped-ferret-of-philosophy-acae13@quoll>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260613-caped-ferret-of-philosophy-acae13@quoll>

On 2026-06-13 12:04:09 +0200, Krzysztof Kozlowski wrote:
> On Wed, Jun 10, 2026 at 12:24:31PM +0200, Niklas Söderlund wrote:
> > The RAVB module on Gen4 have no gPTP clock as part of the RAVB module
> > itself, instead it relies on an external system wide gPTP clock. The
> > gPTP clock is shared with RTSN on V4H and RSWITCH on S4.
> > 
> > Add an optional phandle so that the RAVB driver can find and use the
> > gPTP clock. Ideally this should have been an mandatory property but for
> > backward compatible it is optional. The RAVB module is capable of
> > functioning without it, but can in such cases not provided PTP
> > functionality.
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> >  .../bindings/net/renesas,etheravb.yaml           | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> > index 1e00ef5b3acd..7bc910ab3ae0 100644
> > --- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> > +++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> > @@ -122,6 +122,13 @@ properties:
> >        Specify when the AVB_LINK signal is active-low instead of normal
> >        active-high.
> >  
> > +  renesas,gptp:
> 
> Aren't you duplicating existing timestamper property? Aren't purpose of
> both the same?

Yes I am. I will switch to using the existing ptp-timer property. Thank 
you.

> 
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      A phandle to an external gPTP clock for Gen4 platforms. The property is
> 
> Explain the purpose of this in the hardware.
> 
> > +      optional for backwards compatibility, but without it gPTP timestamps are
> > +      disabled as Gen4 have no gPTP as part of the RAVB module itself.
> > +
> 
> Best regards,
> Krzysztof
> 

-- 
Kind Regards,
Niklas Söderlund
