Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669133;
	b=QilvyMxTg/cRstNX7vIIWcoFBSQjKA6EEruGVJMn26vU28YVHGH+UCFbrhs/o21PU5sC
	 EeoMsOsDQc1g4ZroNe5KSXAMZhdw/caoOZPcnDNqLV8dRAdVcCM3OAlbFGtFUULYQ80xZ
	 zyyvhAb65L0kGoQrnT4fbJqZ1GFkkt68/uA64GQwt0SaEU9OfH8Dwvw1tzHUFTu+gzVKh
	 ws7vBvasdl5fufcy41UUFuU5Ep9cMdE3CPqmIOzdWr1YwMSpa/mjPBURVP7QjPFH80i4j
	 zW1QNSPM6WWGfv2ZoIbwKSQpAh8+VKyhNNe16DhwSUvUkcleyUZD1ChNd/GlK5iGYoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669133;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=OTzg4Bp5wkAPLL8TAcLUbsA24w/kgYQwIZKdSllPUZA=;
	b=lxd5ZCIQzlU4yj1XvedOrVwofuMrO7mZ1GBF9+0ABr9Jchc/NmPM20L9hB4jY2/Ea0E6
	 +xd4gX4+tHrq4SjcvP2xPtJJyy6GUvDr8FQqHrNIM+E6exIKD3hkpw2EC+UJcGjaDu2SP
	 BQeMGt5KFwmLtn4Ji/1LC5ZFxsDqQjdTCOJwAeecg3FoEZD6Z1h587Gk0oN1R+PZyc7UB
	 31YPyPSi7WeU6ngmDx/2HpKvG2cOaWWkOptLUiZXltnn7N1U5FbIOrCDhRgFp49UlcRnO
	 0ynIF2wT/pj4vI6epldzCqUUpgkmUfoTOOLF57GW8LbVYOAVr5BaMvFg4rmStYW5C0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=sXYeMUZ3;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE8606A324;
	Tue,  3 Nov 2026 01:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9EE8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=sXYeMUZ3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OTzg4Bp5wkAPLL8TAcLUbsA24w/kgYQwIZKdSllPUZA=; b=sXYeMUZ3zU61vV6VBsT/w5UwLp
	kt7+FBHGBw9zqTijv5/VuQQCcV2kdMCBaJPS5Cn50KaZQPqW5l/g3/jzu3zQXUGaEFKY52EWcw0e7
	TLbgOGx7d+9eHoRhV4K+OLwcgzWzMhCStwuf9Ar4B6bliGiCayaeUw9wAXrTucG/DMZs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xO3HC-00DvyF-UK; Tue, 03 Nov 2026 02:25:26 +0100
Date: Tue, 3 Nov 2026 02:25:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: acx00: report receive statistics
Message-ID: <1e9d3060-81f9-4d22-a72c-de3af4f8f196@lunn.ch>
References: <20261102-submit-acx00-phy-stats-v1-v2-1-3c8a664407c1@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-submit-acx00-phy-stats-v1-v2-1-3c8a664407c1@gmail.com>

On Mon, Nov 02, 2026 at 04:28:28PM -0700, James Hilliard wrote:
> Expose receive frame and byte totals through the generic PHY statistics
> interface as rx_packets and rx_bytes, alongside CRC errors in rx_errors.
> Report the hardware totals directly: the packet and byte counters include
> errored frames as well as successfully received traffic.
> 
> Collect the free-running 32-bit counters through phylib's
> update_stats callback and accumulate wrap-safe deltas in 64-bit totals.
> Read the high half on either side of the low half and retry until both
> high-half reads agree.
> 
> Hardware testing confirmed that the receive-byte counter wraps at
> 4,000,000,000, while the receive-packet and CRC-error counters wrap at
> 2^32. Use the corresponding modulus for each counter so rollover does
> not inflate the software totals.
> 
> Serialize collection and reporting with the package-state mutex so reads
> cannot race reset or power-off, and the totals are safe on 32-bit systems.
> Commit a sample only after all counter reads and page restoration succeed.
> The reporting callback returns cached totals without accessing MDIO.
> 
> Take a best-effort final snapshot before soft reset and suspend. Invalidate
> the hardware baseline before reset or power-off, including failed power-off
> attempts, and establish a fresh baseline after configuration. Preserve the
> software totals across these transitions and retain the live baseline when
> resume reconfigures an already active PHY. A failed initial snapshot can be
> retried by the periodic collector without preventing initialization.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
