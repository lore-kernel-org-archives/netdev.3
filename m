Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76739413D87;
	Mon, 15 Jun 2026 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542150; cv=none; b=Y7p/Lj2LHMtLrVNDGN9E2u0VjVxJiEW/UDzOUezBZEtrDKc3Ls+l7xXiK6AgiPshE8ymPuFYjFVe2tJyJvGRITyVFARQ6dUKonEA6Dvc2qAgEk4v9GepCSz1tRfBmlcJhsfcImVPYFjCQVjp57SDO3goJ+MoEWGc08EKgGqzvzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542150; c=relaxed/simple;
	bh=VqCsKRsvy+mxioqtQLOfn3znlkYCCyYsy9QnRBTu6do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2MBoJpFCPcuHChnyTpckMayZ+dIXpVgN43zwN6IRItVMr+FVKJEeKsWxVMcuVEIVkuNbSNKzetgcyqpgsAxnTfU7wZin2ZSPx6kY7GR+HJKcme2xiHFCmg9x83f5TpZUqEAKwohltGYhSD3lbbANASZLSRPhFe6kESFbI87EJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iCrFXoYM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iCrFXoYM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jC3QU4FZPqQg1AwNqnbDKfJyL5YE4F9tg8zVHB4z4v8=; b=iCrFXoYMz+xsVQ6gls0oFxtpMc
	jD3or/PzwT5ahterKZkNT0Npz5satnfMPG8wH1nDJtBSVmWfwMQ0gi/OJ7CSigQz8oAVDSSut07Ak
	jBgGPKYkpmLEGO4onHobglR0U5s0zscMls0GFQLmRcJbnH0goFxP2CXCDxrl7Phc9I5M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZAUZ-007pmW-2P; Mon, 15 Jun 2026 18:48:55 +0200
Date: Mon, 15 Jun 2026 18:48:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 3/9] net: stmmac: qcom-ethqos: fix RGMII_ID mode to
 use DLL bypass
Message-ID: <82705420-771d-41bf-a4d9-ed94dff86ff0@lunn.ch>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-3-f0f4a1d19929@oss.qualcomm.com>
 <42355330-c22a-4fce-98ab-dc22b321ff16@lunn.ch>
 <ai93X/cNWHtEQsDt@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai93X/cNWHtEQsDt@oss.qualcomm.com>

On Mon, Jun 15, 2026 at 09:24:07AM +0530, Mohd Ayaan Anwar wrote:
> Hello Andrew,
> On Thu, Jun 11, 2026 at 10:54:37PM +0200, Andrew Lunn wrote:
> > On Fri, Jun 12, 2026 at 12:06:59AM +0530, Mohd Ayaan Anwar wrote:
> > > When "rgmii-id" is selected the PHY supplies both TX and RX delays, so
> > > the MAC must not add its own.  The driver currently falls through to the
> > > generic DLL initialisation path which programs it to add a delay.
> > > 
> > > Power down the DLL and set DDR bypass mode for RGMII_ID, then program
> > > the IO_MACRO via a new ethqos_rgmii_id_macro_init() helper.  Also fix
> > > ethqos_set_clk_tx_rate() to not double the clock rate in bypass mode at
> > > 100M/10M, and remove RGMII_ID from the phase-shift suppression in
> > > ethqos_rgmii_macro_init() since RGMII_ID no longer reaches that path.
> > 
> > I'm curious how this works at the moment? Do no boards make use of
> > RGMII ID? Are all current boards broken?
> 
> Searching through the DTS, I found that we have two boards using "rgmii"
> (qcs404-evb-4000.dts and sa8155-adp.dts) and another board using
> "rgmii-txid" (sa8540p-ride.dts). No board which uses RGMII ID.

So this causes problems. We cannot break existing boards, yet it would
be good to fix the current broken behaviour.

> I don't think any of these boards have extra long wires which would add
> PCB level delay. They are against the netdev definitions for "rgmii" and
> "rgmii-txid".
> 
> But the first two boards should still be working fine since the current
> driver programs the IO_MACRO to add the delay when operating in RGMII
> mode.

Which is wrong, given the current definition. No delays should be
added, by either the MAC or the PHY.

Please could you contact the Maintainers of these boards and find out
the real situation with the hardware.

It could be the best way forward is that you issue a warning when
"rgmii" is found and pass rgmii-id to the PHY. And you also change the
two boards to use rgmii-id. Lets think about the rgmii-txid case once
we better understand it.

	Andrew
