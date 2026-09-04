Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D84481257;
	Fri,  4 Sep 2026 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554103; cv=none; b=Bdz0kzQG/xaTgrY8l+bLlqx6vOs3fh5Xii38h6H4l/k0Rr4Hn48cUxOTgDgD1JBrR+eTzUco9jDbd9EpFK5ISMJw9EoLJKuaUCVIbvpMNpWaBELFjELdAXMMudJR8IqfSuVnjeUh2r2TUtsc8weUYhFW8zglLFfLMrxaRyP6FSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554103; c=relaxed/simple;
	bh=XHedAeEXwGd81QJWyB6iT25X0dTE3uL/aSzipJyBSiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clMZZd3Ndo6PnkvV09HdZB8RjDX5UA5DHsKTtI5TkmhMbu/buNcOyecRKgd4X6bXR/uWvWQgmy+3neTUq9qOC+Jul33A8o4Wg3dPse3VpFD5SvBUBVBbgrO38WCDOHPfD3YK6gHIZMfU187E5Ff6RYWDWny12PsrtUInkEsUwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qEtAqQDE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qEtAqQDE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rqNcMlH8o98wb+BIZdRuGcY3aOxf7W0cZQypsyRwjdU=; b=qEtAqQDE3F0xWrtVdVZTb9sYgM
	2oZobmJLx6AmyNu4af3S4ZMq+GvzGLqnVRKX8HyozkyUpJHCYzpO7HeBD8h6y3eFH0iBjW7XWXVRF
	MnzTELHNNGZ5eK+fLEylkTu3QGRK/oou7gOWvTV5yjDcddq+CP9LhPp4WGvrpMDCs0Yg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2ac7-00350F-AW; Fri, 04 Sep 2026 22:34:19 +0200
Date: Fri, 4 Sep 2026 22:34:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
	SkyLake.Huang@mediatek.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
	sean.wang@mediatek.com, olteanv@gmail.com, yangshiji66@outlook.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v3] net: phy: mediatek-ge: disable EEE on the MT7530
 PHY
Message-ID: <63a43d4c-f09f-4ca2-9003-7010ba045333@lunn.ch>
References: <20260904202800.3410838-1-vladislav.karmanov.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904202800.3410838-1-vladislav.karmanov.dev@gmail.com>

On Fri, Sep 04, 2026 at 11:28:00PM +0300, Vladislav Karmanov wrote:
> The MT7530 internal GE PHY advertises EEE by hardware default, but its
> EEE support is defective: with EEE advertised, some link partners fail
> to establish a stable link. On a 2-pair (4-wire) cable where both ends
> advertise gigabit, 1000BASE-T training cannot succeed, and instead of
> falling back to 100 Mbps the port loops, so no link or DHCP lease is
> ever obtained. MediaTek confirms the hardware is the root cause (Landen
> Chao, 2021): "EEE of the 10-year-old MT7530 internal gephy has many IOT
> problems, so it is recommended to disable its EEE."
> 
> mtk_gephy_config_init() used to clear the EEE advertisement early, but
> commit af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE
> advertisement") removed that on the rationale that the DSA subdriver
> already performs an early disable. That holds for MT7531, whose
> mt7531_setup() clears MDIO_AN_EEE_ADV on each switch PHY, but not for
> the MT7530 PHY: neither the MT7621 integrated switch nor the dedicated
> MT7530 IC ever had such a loop, so removing it left those boards
> without any working early EEE disable and the link flapping came back.
> 
> Since the broken hardware is the PHY, fix it in the PHY driver so it
> covers all users of this PHY, integrated in a switch or standalone:
> 
>   - clear MDIO_AN_EEE_ADV in probe(), before anything can negotiate
>     EEE with the link partner;
>   - call phy_disable_eee() so phylib does not write the advertisement
>     back on later renegotiations and userspace cannot re-enable EEE.
> 
> Auto-negotiation then falls back to a stable 100 Mbps link instead of
> looping at gigabit. Tested on ASUS RT-AX53U (MT7621): with a 2-pair
> cable on the WAN port, a single clean 100 Mbps link comes up and a
> DHCP lease is obtained, where the unpatched driver loops.
> 
> Fixes: af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE advertisement")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
