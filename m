Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BA3644C6;
	Thu, 16 Jul 2026 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234146; cv=none; b=fO8a228XSm8U/wXqSPx8uv9rGWizMXkVRZQRnjxV2rYJzm+g7PNx0QBn5pLGaJT0+wbfzalIWRqi8seOiRkqX3D/T/nLbNEW1hlCXykksOjLpJRPKOAHN9crojNRPWfHob6D3hv2wS+t8itUGdgwVTVFZPTUfTnjffhWVWF0WF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234146; c=relaxed/simple;
	bh=jj0np0QtMlyIQ6kXlCqS8Kdd2b5pTK+Gljh7O9vjYHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmZgtkszA4o8Uo1htrsAv36bKzF1Bec6bOAbOnzauYyRJzmxM1n0z1RmYsQjKRvHM3H1IpcbTEXtFWWJup0BCQ5rS3+4TiwdV9f+wjNT4CswobDtL8ih4dNUxq0q1DbrHZqipCQQ7NRAz8S/u/Dx8T3UzpbHZZLWz2nrIIj3MCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=IxxvbIgC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RWuboJiI; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="IxxvbIgC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RWuboJiI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8091B1400058;
	Thu, 16 Jul 2026 16:35:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 16:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784234142;
	 x=1784320542; bh=70ee6iMesh7z1UVWrQ0so5yKYpt+/QuMK+4/CN0rL4U=; b=
	IxxvbIgCrYWSXMv6H5Jny9x1bU21lrZqLV3cvHcmw7Xs6HoUp+ftSVTSmZwFurCm
	i1pWi3l1HbYtMf9BzsLEMUIGzMfyXpREJ8H2ziW0ppzYO+ubEfrMWwaME9tWX8IZ
	Z7kxTgb+ZpTQR31ZzfL8YxzE0GS0B0NImP63+wpH4wKjd3QCjIE7NNP58oqwbtVj
	1tzLhpnWtYY6w9M0BDWLLUUtLrCgs3GKCDO6zjL0vnuXcUMWuIMkPuHr2CvWEml2
	ctjqJbH4pGrb7rYG/0p0zpxhrEVnyuiVXHKahFslhIoUUgpOb5bn0Tt+K2y7HNu4
	xp2/yBmGwVlWb2oaA+4j9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784234142; x=
	1784320542; bh=70ee6iMesh7z1UVWrQ0so5yKYpt+/QuMK+4/CN0rL4U=; b=R
	WuboJiI5dczic1JR1yJ8aQkDaRjBHU63oaXm5BMHSOagJRbBVLiabh1QQC66DJru
	BEEAOh/6sd+L1SWQwOsTEmudGGENMrI5yiCmETBP4lX+pnt2Y7MBjI5CtVVbSR2k
	5yYc59rPYq4Fhi/DXh63pEiB8KoDxHE1xX3Pf6qV7Xbfsra/aGDQlQznFVDO+Xrx
	kkQ/VKQrbU7iIpvHCtXMC+wbtHsqjdTHjV5wjvMso9czs5M40179TY8qQ5VnVHes
	XWHFVICyCFbr8shMGtGkoJu6R+3gSAzpLWyFprPivaege3Z7hJRDT3VZMaL8y/nm
	Hrf6Ev3Ujz/eJUGwcL4aw==
X-ME-Sender: <xms:nUBZai829ZSeF9iaHV_zNScm9zeMDhMvvMmI2lD_NkerDs_ljM1aKg>
    <xme:nUBZahOK8E_evjHlEizjBVuQr7mq4svNPHNPvNvrIwA-JNGddFMQYMli91CDfZ3fE
    q05X3kPKVsSsERQIHDPePO2CphwsXKH2yKPMjBNlkS5tzrubRiaMw>
X-ME-Received: <xmr:nUBZau33916es_Yaq5iDCVHDY3sN44P_xxqKQrwHmqKdTcxwQgw5wNl6VdzuURQEN7LFg4noGNzodieCIREJv6XK8nfsTjs>
X-ME-Proxy-Cause: dmFkZTGv8aoSwGG63X9SFS8XoBJfewcwNinENxG8gtapi20Kuv6CwpQ9gNQeImuA1INHuE
    QUhaKjOagaYuSxBlr0wYzcrS7XV1bu5KkIYs291Ky+B8sSM/zsyEA6NW1EaakGR6bvZdtK
    CU92VXkAmLXeQX6kMKN/iVGCwMdC0/ff49XBQjmob9f7Nty6pm7V8nuBUi6kTFa4vqrhgp
    Fcf1/QEidh4tNOiWFEUO8nK3eteQt4TstCBxxPfT+Z0nwX1ZxeMAkqxuzUQ9CXFpSV/Oqd
    HMLGksnq0puQUYwql5rB+vs9h79Rs9UnNMTdSl992BeujeW9FfQHRlSdIddon+ZV3BBoXu
    Tj70Nx5yGze9GbZv9ycTvK6DHYo16CwmFnwqyld4nzKEQZ/EzfnsCb1LzGC0AjgvrQL37l
    dFgs5m4hk3XDUEm/plkkJfSYOaEYPYw70wIC9mCv1EnBkyAGIYPkbm3nl2NT1XVh1nuRTO
    C/0bO+t02wpQ0QXfQpDzpyRvO4IgaUSqakEI1u3eVMBr4jlfaCG0rMcnsOnqaLYy+PIcdA
    OiD2v0pQrPm5K3CfyCLIfsUJinbAPjbHjJrIrI4LKR5ULgxBd709YuiGthGwHMBkA8PqNb
    TNg+Ts+PTb239AWV+7bcWdWIFT9EdRpFYjZVK4bee6E8znV1IsXjDLHWcWdw
X-ME-Proxy: <xmx:nUBZaqfJNR5b6P4t6zZVeGjnd0LmXTswcKLwkm-uh3u0sxRGm7YDxw>
    <xmx:nUBZavYjBriTjZWTZG9Pi2KhXHVMH-y08nJJ1ALJzLxbpNSYNhVUYA>
    <xmx:nUBZavXR7JV_Aas3BkNxudf_fj0-YCmKDvTGHywd_8vvhrTlzOJvOA>
    <xmx:nUBZaiSJAH2zyTo7Xk-ZRUDjnYW7hmZmf2ctpDGURWsqZFV_VH9tfg>
    <xmx:nkBZalEPafyH24qmvolwh57SuKckv3z9U4qmmBqD-8e5sQZRW8M0l8JQ>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 16:35:41 -0400 (EDT)
Date: Thu, 16 Jul 2026 22:35:38 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] ptp: Add driver for R-Car Gen4
Message-ID: <20260716203538.GD1593320@ragnatech.se>
References: <20260702125525.2230427-1-niklas.soderlund+renesas@ragnatech.se>
 <20260702125525.2230427-3-niklas.soderlund+renesas@ragnatech.se>
 <21d2e632-5307-4b48-be7b-1269b55f70fe@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21d2e632-5307-4b48-be7b-1269b55f70fe@linux.dev>

Hi Vadim,

Thanks for your feedback.

On 2026-07-02 15:39:25 +0100, Vadim Fedorenko wrote:
> On 02/07/2026 13:55, Niklas SÃ¶derlund wrote:
> > Add driver for the gPTP timer found on R-Car Gen4 devices. The timer is
> > system-wide and shared by different Ethernet devices on each Gen4
> > platform. The operation of the timer is however not completely in
> > depended of the systems Ethernet devices.
> > 
> >    - On R-Car S4 is gated by the RSWITCH Ethernet module clock.
> > 
> >    - On R-Car V4H is gated by the RTSN Ethernet module clock.
> > 
> >    - On R-Car V4M is gated by its own module clock, the system have
> >      neither RTSN or RSWITCH device. But the module clock is the same as
> >      RTSN on V4H and the documentation referees to it as tsn (EtherTSN).
> > 
> > The gPTP device do have its own register space on all three platforms.
> > But on S4 and V4H it will share its clock and reset property with
> > RSWITCH or RTSN, respectively.
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> > * Changes since v3
> > - Clamp increment calculated to register limitations.
> > - Check return value of clk_get_rate().
> > - Disable PM if ptp_clock_register() fails.
> > ---
> 
> [...]
> 
> > +struct ptp_rcar_gen4_priv {
> > +	void __iomem *base;
> > +	struct clk *clk;
> > +
> > +	struct ptp_clock *clock;
> > +	struct ptp_clock_info info;
> > +
> > +	spinlock_t lock;	/* Registers access. */
> > +	s64 default_addend;
> > +};
> > +
> > +#define ptp_to_priv(ptp) container_of(ptp, struct ptp_rcar_gen4_priv, info)
> > +
> > +static int ptp_rcar_gen4_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> > +{
> > +	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
> > +	s64 addend = priv->default_addend;
> > +	bool neg_adj = scaled_ppm < 0;
> > +	unsigned long flags;
> > +	s64 diff;
> > +
> > +	if (neg_adj)
> > +		scaled_ppm = -scaled_ppm;
> > +	diff = div_s64(addend * scaled_ppm_to_ppb(scaled_ppm), NSEC_PER_SEC);
> > +	addend = neg_adj ? addend - diff : addend + diff;
> > +
> > +	/* Clamp value to register limits, defined as in nanoseconds.
> > +	 * bit[31:27] - integer
> > +	 * bit[26:0]  - decimal
> > +	 */
> > +	addend = clamp_val(addend, 0, UINT_MAX);
> 
> is it always positive number?

Yes.

The value written to the PTPTIVC0_REG register is the timer increment in 
ns per clock pulse. The PTP is clocked by different rates on different 
SoC. 200Mhz on V4H and 320Mhz on S4. On each pulse the PTP timer is 
incremented by this value. For example,

If clock frequency is 50 MHz, 100Mhz, 200Mhz, 320MHz or 400MHz,
it should be respectively set to a value around 0xA0000000, 0x50000000, 
0x28000000, 0x19000000 or 0x14000000.

> 
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +	iowrite32(addend, priv->base + PTPTIVC0_REG);
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	return 0;
> > +}
> 
> [...]
> 
> > +static struct ptp_clock_info ptp_rcar_gen4_info = {
> > +	.owner = THIS_MODULE,
> > +	.name = "R-Car Gen4 gPTP",
> > +	.max_adj = 50000000,
> 
> even though clamping addend may work, I would suggest adjusting
> ".max_adj" value to the one which will not make addend overflow.
> And as a reminder, .max_adj is the absolute value in ppb that can be set
> for a single call of .adjfine - the value is checked against
> [-(.max_adj),.max_adj] range.

Thanks for the reminder, but is this not then correct and prevents any 
overflow? From the calculations above.

(a)     s64 addend = priv->default_addend;
	...
(b)     if (neg_adj)
(b)                scaled_ppm = -scaled_ppm;
(c)     diff = div_s64(addend * scaled_ppm_to_ppb(scaled_ppm), NSEC_PER_SEC);
(d)     addend = neg_adj ? addend - diff : addend + diff;

Section (a) copies the default addend value. This value is calculated at 
probe time as a function of the PTP module clock (50 MHz, 100Mhz, 
200Mhz, 320MHz or 400MHz) to a known value. The max value being 
0xA0000000 for a 50Mhz module clock.

Sections (b) and (d) deals with the value we add at each clock tick is 
in fact based on the PTP module clock itself.

So the one place we could overflow is in section (c). Lets look at the 
worse case scenario.

addend = priv->default_addend = <from PTP clock worse case 50 MHz> = 0xA0000000
scaled_ppm_to_ppb(scaled_ppm) = .max_adj = 50000000

    addend * scaled_ppm_to_ppb(scaled_ppm)
        = 0xA0000000 * 50000000
            = 0x1DCD65000000000

That is OK and fits inside a s64.

    div_s64(0x1DCD65000000000, NSEC_PER_SEC)
        = div_s64(0x1DCD65000000000, 1000000000L)
            = 0x8000000

That is OK and does not overflow.

But I agree it's not very clear and depends on knowing from the 
datasheet that the possible PTP clock rates are.

How can I best move forward here? Drop the clamp added and depend on the 
.max_adj value to prevent the overflow with the implicit knowledge of 
the clock rates? I can extend the comment in the probe function of how 
priv->default_addend is computed, but for somebody looking at the 
calculation that might not help much.

> 
> > +	.adjfine = ptp_rcar_gen4_adjfine,
> > +	.adjtime = ptp_rcar_gen4_adjtime,
> > +	.gettime64 = ptp_rcar_gen4_gettime,
> > +	.settime64 = ptp_rcar_gen4_settime,
> > +};

-- 
Kind Regards,
Niklas Söderlund
