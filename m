Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA3350A1B;
	Wed,  4 Mar 2026 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661461; cv=none; b=e0i+1PtbxjOYGB7/zYgcFn+qsRKxNgG/sqAcr37b8JVg4m8RoOebOv8jnLrLgXz6xRepzxD2Si9NCevbXbDwcFEyAo1FwNmIn8E5+BR2oW3LeV6k9SoxZCY93op0Ol0zKmpW1qqiQBRHoS56pe8dRIBBHYawYTZq7wOP2O0b6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661461; c=relaxed/simple;
	bh=5soMW4aNp7iFsOYNETdn8IhUIEKg/x1IGH4TY7VqBfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+3jIDLvbO1LF2tw5ttl2sCIi/RstIBa6S2iAi4hdc+hOBYeO6hxvLBNdygNtwjcBairKRSNnloeNRvlVQWzcc7+kg0Aep5IbiS87HLXAs2AB+rpplbcLtccfIQED/qERTZaeyuJeHcFZgDc04Dg7RVFfvFD/RGuXLHNlrEXmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VOgGVB59; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VOgGVB59"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5wtEcQbkHH7RQPJdQSDw5NIynjI0hasjRRVJitQYmLY=; b=VO
	gGVB59ss7jgaZGzrQcTCN3WctHEQJt+AHh7wwHD/RVdKBkcPT4ps0zr7y2ZXg1CrHW/KsoJb1Da/k
	rq2/rEyyYnWIUiXmplDCTBW8OcOL0/KGtJNxnoMIdxkEKFrX3Tsq7JJHEqtBMqBJQIWupA3yJ1x//
	D0D6ntIiWtePFhs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxuDc-00ABDR-Ly; Wed, 04 Mar 2026 22:57:24 +0100
Date: Wed, 4 Mar 2026 22:57:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: fix bcmgenet_get_eee() clobbered by
 phy_ethtool_get_eee()
Message-ID: <fd675389-b044-4783-be16-c5ba34163ef2@lunn.ch>
References: <20260303153918.538902-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303153918.538902-1-nb@tipi-net.de>

On Tue, Mar 03, 2026 at 04:39:18PM +0100, Nicolai Buchwitz wrote:
> bcmgenet_get_eee() sets the MAC-managed tx_lpi_enabled and tx_lpi_timer
> fields, then calls phy_ethtool_get_eee() which internally calls
> eeecfg_to_eee() — overwriting eee_enabled, tx_lpi_enabled and
> tx_lpi_timer with the PHY's eee_cfg values.  For non-phylink MACs like
> GENET, these PHY-level fields are never initialized (they are only set
> by phylink via phy_support_eee()), so the ethtool report always shows
> eee_enabled=false and tx_lpi_enabled=false regardless of the actual MAC
> state.

I think the MAC driver is missing a call to phy_support_eee() to let
phylib know the MAC supports EEE. Have you tried that.

       Andrew
