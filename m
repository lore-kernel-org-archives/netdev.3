Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA255494A18;
	Mon, 14 Sep 2026 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406303; cv=none; b=Pa2h3Mji4ObRhKM1y3L1m2/LSMeZUWG1Ol5EDztcKuoJY2Tq4ZPz+bxS2AnYGEgATS7sClm1B3WpNy2p+EslkF7/Q8aqGDLiPxXThV8dU8+YaXkYqK/FzV7CLtQGnss3q4gpufCu4pDCD28KxKol9J5SqVkaqUbcP2H/Jb6mL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406303; c=relaxed/simple;
	bh=WPwatUneO7ZNR813f5MdX96lQBjrtNi2JogQX8K8uiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEISsb2SryGFCWADKDRR1qg1C+hXmd2EAjy7tOLubNFNHPGUxT+PYQnuMiDmtz1eKXPnZzvnSmc1HvC7udcuD2nggldqXw6IHQp9JbIouGDhVAqJNj10XfN2TPfq0JuTrxSYuB8QrI1Y9URbuCcNCIabnEPEA8ifI+IBLEREZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0g1HkNo6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0g1HkNo6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kEKC+YPHKBUVIIQahdqo/X9v1kaMleI8WaJBL2KlmVI=; b=0g1HkNo6Vn0TwYaVRDoEtH51Ck
	7P7g00p79cTD2uraave6EwIioJKX0uHvZo/uCPOELLbgp8z/Lo0TtXBnXmom02ugt0XWpjFQVlXCq
	Q4vdnwxDdqhw8AozKaORjeV+ggtgvRjkrJT8vT6lvlKEw0jBMfyvL5v1Wb9s9TovbMaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6AJl-0057Oa-NH; Mon, 14 Sep 2026 19:18:09 +0200
Date: Mon, 14 Sep 2026 19:18:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v2] net: phy: realtek: improve firmware write
 speed
Message-ID: <a96dce5c-745d-47dc-a89b-c0b5b6d20806@lunn.ch>
References: <20260911094527.1928-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911094527.1928-1-javen_xu@realsil.com.cn>

On Fri, Sep 11, 2026 at 05:45:27PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Firmware execution routine unconditionally uses phy_modify_mmd() for
> all OP_WRITE entries which introduces an unnecessary read transaction
> when updating an entire 16-bit register. So we optimize this by
> checking bitmask boundaries. Use phy_write_mmd() directly to speed up
> firmware loading process.
> 
> Benchmark number from tracing MDC/MDIO hardware transactions during
> firmware loading process:
>  - Unpatched: about 28,000 MDIO transactions
>  - Patched: about 9,600 MDIO transactions
> This results in an approx 65% reduction in MDIO traffic.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Thanks for the numbers.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
