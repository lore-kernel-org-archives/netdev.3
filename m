Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA593E92AC;
	Wed,  2 Sep 2026 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338602; cv=none; b=Ml2HBahnt09z/m5Hs4aGEdJZ+EmCGIqU2d/QGkU9KHbbBG1URVvxU2828Mf09VFwrm7OJPIs/ybxjiqu0jC+jWywAwvErQgR0y1vb4IJIKee3iiusFRnvEAwj9tZ/w+nh9dsvgWVT0NMmEOQhe9Douh3pvjIMakSR8sTfOnTAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338602; c=relaxed/simple;
	bh=fyo65rgi1I4XoYNMUJbJtRo49/ATU+C0glxBdqh4WeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcG2BSkDvVO784rZ+wAIHl7g9VgZc1vWWGFJfyIOXLCalQiUUPabZX6HplMk2u+iX+2uLlN/x6brZTNvKe4OKXtfqyF6YqO95KdaXzAv+Fzs7l7hkf50x+SQ4MJtatPnVOgTD0at9Jq29N++qB9Fhs7dRq4RWOqDqkzesmtBT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=XptBUvUP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1ubXtQs; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="XptBUvUP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1ubXtQs"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BB00140019D;
	Wed,  2 Sep 2026 04:43:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 02 Sep 2026 04:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338599;
	 x=1788424999; bh=w23wXmKVstOydYIXHqk7q3E1FXLx5/jPKALPPrzHhNE=; b=
	XptBUvUPqbsW81DaMTJyCH2pe/TKX4RFl8XgCPCK0vyQfYSK8E4sF1J+JimHaKn/
	aB98LNJQxC8lw/6wAA9/Fhu6MxEQFtcKLR8OkBpYsgmVUAcsByA3YLECXs8daK/G
	DO/BTO3W9FWsDzl2orzQHtT4+Ahst0Oi257Ei281kNDSTVVmV0+59wRDp2+pdxZF
	P9CPIe8FMReKPRC4NoX1qbs3QO4sgRAkpSj/m3MNXqbRA1+xV/hCdltQ7a1HjSas
	Ko4q5o20wGtwfvHe9TpekKYf28SzE9VtzPVBytFKTk1dH2y4k8ILlb1z+iTUQ5u2
	LA16D9pNycXpoX3wcmOW8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338599; x=
	1788424999; bh=w23wXmKVstOydYIXHqk7q3E1FXLx5/jPKALPPrzHhNE=; b=E
	1ubXtQsY/yILapAykumP8hjbhF4ta4eAtwuJDeNcldDhU6QwZtI3ja0rCjvRRklg
	wMQW6EVRfLnx94bhAcrRnAnkuU8V3bDn1m/TlS44wAOqAbRZsPlBM++g5pDYXyES
	MGuJD5Rnxp7685VnAm8CpSEYSW6juh6pe8/Ss2GmdoXvJcalknqnVvvld5YLTf2A
	/vJU7MNk99oMYI6izutPE/1xkyHhYRzBUXLGnZWs6m9Z9/7PFtaoZnz+fn7kgUMI
	pTGVHKRFUO+daXt4F4LGCMz+9fQamLeFbsPt5xwLeDsSFkwlsJUE+/3wNB8Q/Jwc
	aN4zcKJCsrHItN/s7LYYw==
X-ME-Sender: <xms:puGXahpTE3lPiD74vPR36WDJR3xbba7m3ayfgTIWliWYab5q7XGpfg>
    <xme:puGXav-HXb9rtoRyNAdT-zSZ1FLtka-0yAI1Iajea_XUBknrS3LUvWJq123rBK5OZ
    -8C3OVkD46vItkUopD7M4aYVl6HQ0BpYMlQpvNiVsQEe87jRXm13Wqd>
X-ME-Received: <xmr:puGXav2jC7594WKpq9H4XKeTywV5YQRDMisuNZi1bdmXTPVbZNP30DVwZ_rKGKe3Jt02p1yp80tr71ywNsyDz0Fmrl1GMdE>
X-ME-Proxy-Cause: dmFkZTGYV+Ldz7esYSoFXwSPlhFRnbZaD5qMVT7+OomT+XznTE+/fJaRljD+EMvmqL2YcZ
    8TP1DE+xJ8yXZ9BeO5K71Wjl5RKPAgd7dtMPDMQDY1rBCNwTP5ukqWfg6olYQRG8HxS5Oz
    m8KJkJWp+d2fjbdqHuRs9Q4w/aV5v+pCY0QbfATEZR0HTXgcA0wbem9a3PJ/12T7KzHa2J
    BiamUDVYBV8B+y/KRIpvWEkTzgB2o1R7E/x+OMQ1T3+iVJ6KVG3zehdCWseapcvD6PxWVz
    +ymzb3AM0IqXXBk9n4msnFRcF1vb2zWpjvJKWqgkdFGI73TOL9cMkuoGAnLRdMOSPBO8O7
    vdBY+UT5DXeCX3Ueitvkci3HzQ+fCrLH0ceeInM3JWvzfn80iVX3lRx+sUWAzX7RukSfOj
    RL0ln5OXxFOIplivo8L3pdB82m+7lccg6Cbme1qFjdnaXh2vrsILTt0scUqFEzlxYINTMc
    EJBxrXYIR3Y5J5zzfTzcy59f5HYZdnkAZ/sZc4hQIfdbifsrvlSCWn36c/lG6CIwxJsDkM
    mPj05wYvM9zS1bomUE3NdC5oeQKhBoJYK/e49zAFN7y5l210nc48N8s3shTU6IuqiGPdTe
    yboaDVkHMeLcdgn00NMWgRb7MS1hIbcvl5PG2fty5PExdfiyCP60c5p9Nejw
X-ME-Proxy: <xmx:puGXaqDfyjwycDlBOXmRxd8WiFrhxaE7NTXH9x-iU5E8w5SwtH-HHQ>
    <xmx:puGXamCTrNH2B_rjmwufwBYlBAlvLTJfMGEOyA8C9qBgZ85kdFE4bw>
    <xmx:puGXarPYCJJvJXU2ORxk6pYG7r3RX0kPtNuhOSIna76qGZBplCBzrQ>
    <xmx:puGXagPJOCzS_rvJDovoErKeag-udyKhLnMg3ef029cUgmNHLKEpXw>
    <xmx:p-GXalZkK4Wq_ysH09gz4YfjuIkvp_SCOP6hfr_QztRFpNHGJ4pd42GK>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:43:18 -0400 (EDT)
Date: Wed, 2 Sep 2026 10:43:16 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Sergey Shtylyov <sergei.shtylyov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/10] net: ethernet: ravb: Add gPTP support
 for Gen4
Message-ID: <20260902084316.GD1116206@ragnatech.se>
References: <f140a168-0f92-4507-bf07-f5297ad92159@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f140a168-0f92-4507-bf07-f5297ad92159@gmail.com>

Hi Sergey,

Thanks for your feedback.

On 2026-08-15 22:12:03 +0300, Sergey Shtylyov wrote:
> On 8/11/26 7:02 PM, Niklas Söderlund wrote:
> 
> > While driver advertises gPTP support on Gen4 platforms it is in fact
> > completely broken. On R-Car Gen4 devices the RAVB module have no
> > internal gPTP clock as generations before it. Instead it utilizes a
> > system-wide gPTP clock.
> > 
> > This change utilizes the refactoring of the RAVB gPTP code to add
> > support for a system-wide clock and stops the Gen4 devices trying to use
> > the non-existing internal gPTP clock.
> > 
> > To remain backward compatible the ptp-timer property is optional.If not
> > present, or not enabled, the RAVB driver will no longer advertise gPTP
> > support to user-space.
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
> [...]
> 
> > diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> > index b4df5cab0e5c..4c8dc02022e2 100644
> > --- a/drivers/net/ethernet/renesas/ravb.h
> > +++ b/drivers/net/ethernet/renesas/ravb.h
> > @@ -249,6 +249,8 @@ enum APSR_BIT {
> >  	APSR_RDM	= 0x00002000,
> >  	APSR_TDM	= 0x00004000,
> >  	APSR_MIISELECT	= 0x01000000,	/* R-Car V4M only */
> > +	APSR_GPTPTIMER_SOURCE = BIT(25), /* Gen4 */
> > +	APSR_GPTPCLOCK	= BIT(29),	/* Gen4 */
> 
>    Again, I don't quite like that you switched to using BIT() all of a sudden...

Indeed, the while enum should really be converted to avoid LLM warnings.  
But doing this in this already large and way overdue series feels a bit 
too much. Once this is picked up I plan to convert them all to BIT macro 
to make life easier for the future.

> 
> [...]> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> > index 12877a8488ed..30170e92d3d7 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -2752,6 +2752,59 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
> >  	.magic_pkt = 1,
> >  };
> >  
> > +static int ravb_gen4_ptp_probe(struct net_device *ndev)
> > +{
> > +	struct ravb_private *priv = netdev_priv(ndev);
> > +
> > +	priv->of_gptp =
> > +		of_parse_phandle(priv->pdev->dev.of_node, "ptp-timer", 0);
> 
>    You now have full 100 columns, no need to break that line... :-)

Fixed in next version.

> 
> > +	if (!priv->of_gptp)
> > +		return 0;
> > +
> > +	if (!of_device_is_available(priv->of_gptp)) {
> > +		of_node_put(priv->of_gptp);
> > +		priv->of_gptp = NULL;
> > +		return 0;
> 
>    This *return* seems superfluous...

Thanks, fixed.

> 
> > +	}
> > +
> > +	return 0;
> > +}[...]
> 
> MBR, Sergey
> 

-- 
Kind Regards,
Niklas Söderlund
