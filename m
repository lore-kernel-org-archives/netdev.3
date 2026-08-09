Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311823AE87;
	Sun,  9 Aug 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786296925; cv=none; b=azayaSmOECnlkbQ96dXpFc1EW/x2yYztpxCDJ00kinkME1y7MxpYY5jgBLgegJi1u0Hr0WYEDkgVsPijlV36Xbbih4KVp50WCWFbIHfeqA1uokXAyoIzBnrINf50i/IMvuGyH2CIPLHmiwno0mai/gqDFe6V49BSe4FYL/gUK0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786296925; c=relaxed/simple;
	bh=5plvVDWWzIfJ0pdYaDwijuANiAKYDhvAgT2JOXoC1kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMCH60n+SODLarQoA09cOZz9XLJVft9eCZ6VCa0Vp2M/r9Vg/c8VqZeiHX1z0VPLnr4jOlmQgQa64uIrQDNybj+zbZZWuxfuP2NuokuQ/xc5rxLhjLc7QOo/752rSbJnBOEYJ/8AtCSdFCCc07nA5Dps2Qj9mxYd4jYUsxgK0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e17QXMv5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e17QXMv5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FMzsNibpkbclybef2IiC1pkGWDkaFZm31qCdxzMS/OY=; b=e17QXMv5usqgSTF6AttFhTz4d8
	1yCkfpV+MuoLt8Fjrb8fDyWwbdXorx21EOpwYDH87hnZwDfb2+1hq+AdWBF5xKyl4iendvsJr4r24
	sgXdpnCpkpbuoFpH1NXfvpGaYZ6pppRDfs/aUw4bewQo7iCt9VVErf2O70igG+ojgzWQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt7QX-00Gpvc-S0; Sun, 09 Aug 2026 19:35:13 +0200
Date: Sun, 9 Aug 2026 19:35:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v11 06/12] net: phylink: support late PCS
 provider attach
Message-ID: <de79d628-e149-42bd-a21b-90db2e70a7cb@lunn.ch>
References: <20260807131301.192060-1-ansuelsmth@gmail.com>
 <20260807131301.192060-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807131301.192060-7-ansuelsmth@gmail.com>

On Fri, Aug 07, 2026 at 03:12:48PM +0200, Christian Marangi wrote:
> Add support for late PCS provider attachment to a phylink instance.
> Similar to FWNODE_PCS_PROVIDER_DEL, FWNODE_PCS_PROVIDER_ADD is added to
> address the case where a PCS provider is added after a phylink instance is
> created and started.
> 
> The PCS notifier will emit the event FWNODE_PCS_PROVIDER_ADD every time
> a new PCS provider is added.
> 
> If a related PCS is found, then such PCS is added to the phylink
> instance PCS list.
> 
> Then we link the PCS to the phylink instance and we refresh the supported
> interfaces of the phylink instance.
> 
> Finally we check if we are in a major_config_failed scenario and trigger
> an interface reconfiguration in the next phylink resolve.
> 
> In the example scenario where the link was previously torn down due to
> removal of PCS, the link will be established again as the PCS came back
> and is now available to phylink.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
