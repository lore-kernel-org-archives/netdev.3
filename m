Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825253AA4E2;
	Tue, 28 Jul 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246166; cv=none; b=d8Q3ghY8jqS9RUcod/+gDxoUczOYF2Kyh0TzRMnj7EejrTyCVJzufF41u978y1E2xSqb8kGL0BLEh7OL323YJfsVP1EkfHKZ50BRULKqPKY06lXskOzVPXgmAx0D1J74lyka5M5fGFK6o0+LF5s+JRYKlW0EGf3m0fDqqU1HgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246166; c=relaxed/simple;
	bh=Nx71uXges7GW2XsEONypqHwILxXGY0E+ZJTuhbGqQgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJs/d84ECXN1O5Wg+/39JNLFWcEGn8hcg5jlThveLEICvow4zBOtuw1BEAndz5+vM61s8zJH8ivBXMy+kN6+qcCsj/8g/dWT0PcEB6DGOcXkiYVu+r9gz5PdE89P73yVII2+/BUYr/R6cO1qiJM94X//IHhKJD7SVYcfRjRcq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=odHB9goA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7iuc854; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="odHB9goA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7iuc854"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EB221400068;
	Tue, 28 Jul 2026 09:42:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 28 Jul 2026 09:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785246162;
	 x=1785332562; bh=+IuxgIwm0QDAfUooXGiqVeiapgfcFg56lJ4PdzeIBNM=; b=
	odHB9goAQMz9JvQgD8kTI0Nxt0LMUFLMvmgm44eeq0JA0s2ucEgCx5+dXHBmUzeQ
	HX5vzvqRij8yTONVxTxe1pxB8v/2+wqIypeuCx4jB3QWh//SMtZjvHRAdLldjpNu
	VTd6rNHzCI+xz6oJ3O12tMCdK831lhx828zttX6GU2T7m671LlTr1XNtjjRYWpmR
	spQ+xPlaSH95acy9xXa2iR9B3YaWh2mxQQXwNchN583+MlEK6MuPZGnKPRcgG5st
	V8FeIh/7Odlj6CVMx/Xipa73tveUgeaRLpWWHeQ8lxpnumHU9qqyU0AQPQU1h8kr
	z2Otm9g1spgRs9S42oOhEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785246162; x=
	1785332562; bh=+IuxgIwm0QDAfUooXGiqVeiapgfcFg56lJ4PdzeIBNM=; b=Q
	7iuc854SNWNjLo8UV+V4rtnhViD46UNZarJqVdHHhbKhvmFOMXHdegiGtrudAJJv
	1c97aCH10D3u6iRBIF0rOx/7FyTu/vgkGKP4g+iuGLXqri/momVQcv7vjfy2TXRY
	cguLdiWL+9N6LLZvFm6/dFrNOhV7DFcW729BTVd+xbH10A2Xu2tzkrE2hW7gaY+5
	TIUGCP+IJjllwv+eS3pv/doULxZxZpoIoMfdpAADucp1YGtMjGC0RPVlbXnbt29i
	CeeLwv+1tImFuYDw82mClWumvMyvWOOQPLI7NRNn590OSf/gMgBz/euTtRe+yRxC
	NfmtwCRNJBJkVcjpVmz2g==
X-ME-Sender: <xms:0bFoalWfNtoCpieixH7bMALnhorJoQ--h0_v0cLRJdxAcXVlMew6pg>
    <xme:0bFoakFzSnQqemWTrsIYW2q42YOBl-xXag2fEEwBmUMkQ3IjQbafCd5a0xmqZmrCI
    _UfSNeDVP0bNL8FCgU7eyPZqxgN3zGs2hebtESOQm3XYbQp9aAJvrE>
X-ME-Received: <xmr:0bFoaoOUJ3sXlkVIf0KQBNC0emrLjFhLJYu3yoRM6WRqxbTHePwgvkO-VNmP4Snp_jKZhihVRyALbzf4M0EL1GfY_qDQBNY>
X-ME-Proxy-Cause: dmFkZTFUEAfTR2otyDl6BVd8V0kHyhLOk26+2XF3ZMmznGHTE6GKM5/jn0zrfALvSFd082
    AhD44ziiI51BkrOyGavBf91CxlMrd9xekR3kFu9kxVtLJTo/NgzujTSd8+szGes2GPFaXe
    VD0FrDT7Tg/RXUAWalydQgrZrI6TEJhaRoULWqadGQCEsD6VsgG/axl1TMA58r6Xv5sY5N
    G193Py4ZJyXtlHj/p2dtPM9wP1bZBjUxzZCXgbZIZwBfc6d9m2Lb+RSWvOdDiM2eVzLcG0
    ixVxKQbqdXd0uyGvf5OVMSGhe2w2OPuG2b3sdlJpCQEAJ0sTyo2sF9zF9ezCHIG/NoaHXr
    rcFwAnijONPiNRCNN5Vj2BNpb2BndfM9iS5fXaDLCS/OObMuE2hF27RFH7MJC3uUysg65Z
    MGSCdXMLbfXEGdP4YpfBFeiRkjix8lmjLtePMH68zQNS1c9k1aaSpb01kNfXcj5QLhfTmd
    iJZFX38hfO9I1qmWwNccajOyy09pbi4ILctD2kHWqlWYAcCy2WYdGV2krrAMhPXoQu0a1B
    Y7C+OTca6Hn17RmnDB/MbI6kyi+gmtrqvR3GxqGRk1rsFBHJqRHCW7HwxKYrpOf6GOoM4h
    56kf3k4lnBDfHQyrX6Xjj5joK4LuwGjSPvBUywQxoXcQ80kllJ2rF4eApwDA
X-ME-Proxy: <xmx:0bFoaoU5clMDofBAzv11FGhvbSctjl8L2M9Ztg3OTsH2xtLJCk5IPg>
    <xmx:0bFoanw561Nkx4uVmtCxLlBU-b1rkdUuVWL9kdxYlUUM7ZBFOpUlqA>
    <xmx:0bFoagNgVdO35SK-YQf12EHiUmBOmzv808xVNXY4czfNBkC3JkCY1g>
    <xmx:0bFoahqZDatg8KJdIYRd9Mjb9lIJzPqFHaJBN2wZUd-xWEfIms27_w>
    <xmx:0rFoaqyH21baMVJGCXcrWoIRlTBTEivhfGrHqpirJgkkux9AZJVe_SKP>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 09:42:41 -0400 (EDT)
Date: Tue, 28 Jul 2026 15:42:39 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/3] ptp: Add driver for R-Car Gen4
Message-ID: <20260728134239.GB2187218@ragnatech.se>
References: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
 <20260721132936.1331318-3-niklas.soderlund+renesas@ragnatech.se>
 <1ee51bd7-3667-4184-b018-8a8cf29512c0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ee51bd7-3667-4184-b018-8a8cf29512c0@redhat.com>

Hi Paolo,

Thanks for your feedback.

On 2026-07-28 13:18:59 +0200, Paolo Abeni wrote:
> On 7/21/26 3:29 PM, Niklas Söderlund wrote:
> > +static int ptp_rcar_gen4_probe(struct platform_device *pdev)
> > +{
> > +	struct ptp_rcar_gen4_priv *priv;
> > +	struct device *dev = &pdev->dev;
> > +	unsigned long rate;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	priv->clk = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(priv->clk))
> > +		return PTR_ERR(priv->clk);
> > +
> > +	rate = clk_get_rate(priv->clk);
> > +	if (!rate)
> > +		return -ENODEV;
> > +
> > +	spin_lock_init(&priv->lock);
> > +
> > +	priv->info = ptp_rcar_gen4_info;
> > +
> > +	/* Default timer increment in ns.
> > +	 * bit[31:27] - integer
> > +	 * bit[26:0]  - decimal
> > +	 * increment[ns] = perid[ns] * 2^27 => (1ns * 2^27) / rate[hz]
> > +	 */
> > +
> > +	priv->default_addend = div_s64(1000000000LL << 27, rate);
> > +
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_get_sync(dev);
> 
> Both sashikos agrees pm_runtime_resume_and_get() should be used instead.
> This was already raised in v4, with no reply.

Ahh now I get it. The sashikos reply says that the return value of 
pm_runtime_get_sync() is not checked, not to use 
pm_runtime_resume_and_get().

I only greped for other users of pm_runtime_get_sync() and saw none of 
them checked the return value and ignored the sashikos reply. Will fix 
in a new version.

> 
> /P
> 

-- 
Kind Regards,
Niklas Söderlund
