Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7683AC17;
	Tue, 29 Sep 2026 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640949; cv=none; b=dUkGcI4cyDQuNE3RuLAJn9uBHUgSfp24bZeEezL+oBKnhjGEc2EqVCWIumwLFywSu1Dt+4czJy0brLhgxXT2/jX1lQtzXKN/8jdd06WywS8KrbPIOszX4lxZaGcfjQl4xb/cuKjUmZFh63rteI86RIdjju8nmozxoeGltSkQ1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640949; c=relaxed/simple;
	bh=ShelDO3NpNHQZSbX2Kq3c8AlgNIxCT5hJo54oLxThd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7uUBfXZaB60qpLjla/yl/dVW5Mn8ZXRwvjuqrRJmDCDDOcWlvn2BlxEyA6gdUbeC8wwYUCu7Z8CCtth8gQJNG2G5K0cXQsoRgFdubZnjM4gRk7dmTcgw4S+EHotfga+JOXwm/DY0nbEeGALgaBgMHymuNLHQEmWSdPvJ+AVcbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vMVpkmJ+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vMVpkmJ+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tBH0lwTd+7dFVk/k1VZ7XF/ATUOM9YQMm25KiR8VP7o=; b=vMVpkmJ+cDe8YKkr2462/QbTgO
	7/JTAzPITLdqBVW73Ji1TqYNBpKOwoWm0iJthu4lGx4P/RzbOpb2S1wKa5BwDwO5BRDSIrcLXccyI
	tN8XG/m6qJuyQoT2OMzJpP7YeNex/wUoBr/SnOmXqHBoRz6QIM6w2pAJn3gjSOUt1YR8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBLVV-007pLb-GY; Tue, 29 Sep 2026 02:15:41 +0200
Date: Tue, 29 Sep 2026 02:15:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: dsa: qca8k: propagate MDIO errors
Message-ID: <12875133-1659-4507-a007-c3cfa425ec76@lunn.ch>
References: <20260928220629.238-1-yongzhao.derek@gmail.com>
 <20260928220629.238-2-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928220629.238-2-yongzhao.derek@gmail.com>

On Tue, Sep 29, 2026 at 12:06:27AM +0200, Yongzhao Chen wrote:
> qca8k_mii_write32() ignores errors from both 16-bit half-word writes.
> Its callers (register writes and read-modify-write helpers) then return
> the earlier successful page selection or read result, incorrectly
> reporting success even when writing the switch register failed.
> 
> Propagate write errors from both the low and high half-words through the
> regmap paths and internal MDIO master transactions. Attempt to clear
> MASTER_EN even if a transaction fails, preserving the initial error, and
> report a cleanup failure if the transaction itself succeeded. Preserve
> the existing Ethernet-to-MDIO fallback order.
> 
> Propagate read errors through the internal and legacy MDIO bus callbacks
> instead of masking them as 0xffff. Returning 0xffff causes PHY
> read-modify-write callers to treat the failed read as valid register
> data, which can corrupt unrelated bits on writeback.
> 
> Stop polling when reading the MDIO busy status fails, and return the
> error immediately. Because the read helper clears its output on failure,
> checking only the BUSY bit mistakes an unsuccessful read for transaction
> completion.
> 
> Fixes: 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx family")

Does this actually bother anybody? Have there been reports of actual
MDIO errors?

If not, please drop the Fixes: tag and post for net-next.

   Andrew
