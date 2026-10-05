Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CD415F1F;
	Mon,  5 Oct 2026 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236606; cv=none; b=HmAhwA49mO8sxTufiNOuLaxOBuhjP2nkBYP8KE/ZlAm3h7665dKBPAMaZt0+U7df4k5zmMCmM+s3GqxFPkUwy7GrtiLW/cuIFLC55RZXle+nzBnNI0fv+OvhuGj6p9RKhI87WfZiNUOCorDe7n5KKCvZPGJ2m9ejIpal0n9BT4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236606; c=relaxed/simple;
	bh=4yX5Iu6m8uJ1dUnT9HHG8b8wfBJH/tTk8YUW9rO643w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNN47ZJmnegKT0PaoQal40/pTjkmjpKPT1D93fIB/l42ywEvtZOayY8XuZeBvEwAWO5IxjqfP5vklvrqetQLDihlKkXQmC9vbPtmyhybLc07w3PbBbggrzxzkUngd4SFl4/+Gua5+mqwLGf8wVUTfgAocnBzz59dd2NayJExQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNXt2f1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNXt2f1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9567B1F00893;
	Mon,  5 Oct 2026 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791236603;
	bh=TxAZ85y4jPD5s6/gsYfi/z3sFIrC/VFwdMDoYbCyWJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iNXt2f1D5yr4eLJJkViQNyvzNJcHgpioVSb3IhMAnCtXQ2GkFWptccYPOSqGMdEyh
	 f4CGWgQuthldVyHWoxchFv4aaWL8K+Y8wEJkuoPQDGYI9saAxK73d6BVmcFfG3FazF
	 s5ERiUy3ivGiCf2UKzbTearhuPI8+aT3KAlXirdRTeJP17Qaj/6luDZTMEN1EkJHcJ
	 Gk1i4A2p9I+njIzrKC8BOrjAdi3qHK1CAdZvGHqTaCbeE4Wzqu5BzNMo/iBVFiab7c
	 gaboAHRTlQ+koKcYUyZDgBwjvavGT7IhYw2m2j9pFKMz890QpF0JBYaRt6T57BQwOC
	 LC6jF5s/A/1CQ==
Date: Mon, 5 Oct 2026 23:43:19 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v10 03/11] phy: rockchip: naneng-combphy: add
 SGMII MAC selection for RK3568
Message-ID: <asQZ99CMsQF10-RZ@parshuram>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
 <20260922200336.2201212-4-coiaprant@gmail.com>
 <20261005135939.01ccde50@kernel.org>
 <CALj3r0h7j-4ZAiX67LmbgpmYCvK-Xmzd_qnYYgoBmniAW+eiWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALj3r0h7j-4ZAiX67LmbgpmYCvK-Xmzd_qnYYgoBmniAW+eiWw@mail.gmail.com>

On 06-10-26, 05:15, Coia Prant wrote:
> Jakub Kicinski <kuba@kernel.org> 于2026年10月6日周二 04:59写道：
> >
> > On Wed, 23 Sep 2026 04:03:27 +0800 Coia Prant wrote:
> > > On RK3568, the SGMII interface can be routed to either GMAC0 or
> > > GMAC1 via the GRF register pipe_sgmii_mac_sel.
> > >
> > > Add support for this selection by introducing
> > > the "rockchip,sgmii-mac-sel" DT property.
> > >
> > > From the RK3568 TRM (Part1, Page 229), the PIPE_GRF_XPCS_CON0
> > > bit 1 (pipe_sgmii_mac_sel) is defined as:
> > >
> > >     0: SGMII routed to GMAC0
> > >     1: SGMII routed to GMAC1
> > >
> > > The hardware reset value is 1 (GMAC1). If the property is set to 0,
> > > the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
> > > remains at GMAC1.
> > >
> > > This is necessary for boards such as the Ariaboard Photonicat, which
> > > uses the SGMII interface connected to GMAC0.
> > >
> > > Out-of-range values are rejected by dtschema, so the driver does not
> > > duplicate the range check.
> >
> > While looking thru the patches again I noticed this is changing generic
> > PHY. Maybe you can send it separately to Vinod? I don't see a hard
> > dependency? The code can "converge" during the merge window for the
> > whole thing to work.
> 
> Hi Jakub,
> 
> Thanks for the suggestion. I looked at this again, and I think the
> dependency is a bit more involved than it might seem.
> 
> The PHY patch (03/11) adds the driver support for
> "rockchip,sgmii-mac-sel", which is documented by the PHY binding (02/11).
> The DTS patch (10/11) then uses this property. If I send 03/11 separately
> to Vinod and keep 10/11 in net-next, dtbs_check will flag the DTS property
> as undocumented until the PHY binding lands in mainline. That would break
> DTS validation for the net-next series.

Typical order is that binding and driver goes thru subsystem (in this
case phy tree) and dts thru the soc tree.

I can review and pick these if you would like
> 
> Also, splitting into separate series means each has to queue and get
> reviewed independently, which I'm worried might not all make the merge
> window in time.
> 
> So unless you strongly prefer splitting, I'd rather keep the whole series
> together in net-next. If that works, would it be possible to coordinate an
> Ack from Vinod for the PHY part? Or if you still think it should go
> separately, I can do that too, but I wanted to flag the dependency and
> timing first.
> 
> Thanks,
> Coia

-- 
~Vinod
