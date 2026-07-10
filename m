Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6B86329;
	Fri, 10 Jul 2026 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690381; cv=none; b=JCF09ED+JH7bbPCRqDYAF5zNSPndX6bA6u18HfUosIc4nI71p/Lr8T9ViwvO0lPOJdEH9o+6n0lFFS9kwM2nY3Xg9fBarl94T0XDEHtKyBQeiom/DTfMdjmNopsFNP34ICylTlD9V+JhdPJXpU8tgDVlJNwZEmlu8zvbQX3gK0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690381; c=relaxed/simple;
	bh=bhDiKxoEwUFW8uGI1fuybDuF7q7LAs13VJURvA1+Zcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1vyTQWVEebZgp3d4AfHrNLcRfXiNGEcEpq37+NAZEWbMaYG1UBgRp2LhZONbYihTNsF0C5rsmRu79gIkbhNxyll0OIDalU7B+l4E0DgsFi7xK2grg9C0I1ALLP0EseV366Z63RQnfmdz84fb5lnjtTTD6zPnFrTEf7Vmcdx0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pviEuWzM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pviEuWzM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jKWNcIAQGuJxJqjktfh3JBfLdnAx0v5jAErj9hzJok0=; b=pviEuWzMz/soHvvFsu7OpxGL8K
	biUVZMutQp9mZ+SyP0VgJxgHbMQSaPTrzMiMRHjjQyxSBAtabLHqgb3P9HfoVmgcfQbFL7eqtudEp
	LXBTUeuKJsF9QJk+4IFD5ip/TNPftP41EssGgjean6lw3kyEycN3pC6ELGQGv0uQO3/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiBLE-00Be7o-Bh; Fri, 10 Jul 2026 15:32:32 +0200
Date: Fri, 10 Jul 2026 15:32:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add EN7528 support
Message-ID: <f968d3fe-83dc-4b82-972b-0d4d477a1a52@lunn.ch>
References: <cover.1783680864.git.naseefkm@gmail.com>
 <1865eaedef97e593ba608764c7390209cae85b30.1783680864.git.naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1865eaedef97e593ba608764c7390209cae85b30.1783680864.git.naseefkm@gmail.com>

> +	/* The EN7528 LAN GPHYs advertise EEE by default, but negotiating EEE
> +	 * with common link partners (e.g. Realtek GbE NICs) results in an
> +	 * unstable link with dropped frames. Disable EEE advertisement on
> +	 * them.
> +	 */
> +	if (priv->id == ID_EN7528)
> +		for (i = EN7528_GPHY_BASE;
> +		     i < EN7528_GPHY_BASE + EN7528_NUM_GPHYS; i++)
> +			mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN,
> +						 MDIO_AN_EEE_ADV, 0);
> +

The problem with this is, you can still use ethtool to enable EEE.

Please look at phylink_bringup_phy(), where it calls
phy_disable_eee().

    Andrew

---
pw-bot: cr
