Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6CD4503EB;
	Thu, 30 Jul 2026 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428023; cv=none; b=uHMUG8T/5WnEGC85ABzOBGy8frv5JzDyePXYrgdjELQG6apI4PZHELSFXgr9CdlMy+YAAsfjJ783+pfPIQgPsbcvTH2Csu3EP+3SAExA3qUGMfpIoeCtuFovXhG1XZhrus9JVCpJon0Xer2AZoYG909zgrCtSxSo31AUeYNtVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428023; c=relaxed/simple;
	bh=78pCTzCj4OYGlTrh48pBob8ng6R7FrJDyhMbsvTXUXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la4C2bH/eHHC40PwDfBiKtfkYitTU+ZTmeWgZEp2OGFwWGsmgfPYzoHJEVWyaGM6Tayt/YY+DzmG8Nmgtu5PhE0xE9Tnli4PHuWTet0IFCWaFUmtZpz2MiZl9ixvG9ZTc3jqRdd7Uh1GR9yTc+YuyYft7bBMfQdNt0wsWzC4V28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QJHbkG9i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QJHbkG9i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U8MQ+sboj6Emxgip/vMO33V3JD1l2EBPOqtHqVRFw3I=; b=QJHbkG9inB4HeB0zhPf1Ecu+Jd
	PDG/oyKlbHHjqGSmdYTafJnH93wJVo47oZ4UcPWG1nshVtZbn1+iGB/krH9MxR5Vt8ty4rvEjUneS
	o4x4KUf9tAEAvjtZVhgHcnRDYAyZTyOPenqKYB8uxIPn16mpoIYXIJxcjhoHt1W5Q3jo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpTNh-00F29y-48; Thu, 30 Jul 2026 18:13:13 +0200
Date: Thu, 30 Jul 2026 18:13:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 1/4] net: pcs: mtk-lynxi: check regmap reads in
 mtk_pcs_lynxi_get_state()
Message-ID: <e2ae2cba-e62e-447c-b5f4-25411cac11ff@lunn.ch>
References: <cover.1785427248.git.daniel@makrotopia.org>
 <c41c256a5b4695bec24abc6baa4f990fca88f834.1785427248.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41c256a5b4695bec24abc6baa4f990fca88f834.1785427248.git.daniel@makrotopia.org>

On Thu, Jul 30, 2026 at 05:03:11PM +0100, Daniel Golle wrote:
> mtk_pcs_lynxi_get_state() ignores regmap_read()'s return value; a
> failed read leaves bm and adv holding uninitialized stack values
> which are then decoded into the reported link state. The regmaps
> backing the MT7531 SGMII PCS instances sit on an MDIO bus where
> reads can fail. Check both reads and leave the state untouched on
> error.
> 
> Fixes: 4765a9722e09 ("net: pcs: add driver for MediaTek SGMII PCS")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
