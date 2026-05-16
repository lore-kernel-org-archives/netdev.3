Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2461DE4F1;
	Sat, 16 May 2026 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778941398; cv=none; b=EZA0zwpwJGHpnkHHZ+ufvUlbQZTh2TpA4oknWQBw5R30vxQs6hLF3F6LvrZfYmScW7iuNe9LVvXK/TKetfI80ktPf+JC9lhB4fmsvIX6q19rYwDRPSn+0MlzgrTsNq52iGa9Rxl5opC0shK2ZqpB0sAwJgU0lR4gImEh+Wst0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778941398; c=relaxed/simple;
	bh=q0N3KNRJYwJwnRI8d333jz7zOiNhQp8T1LorPsbeh38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN2fqIOs2S7OEE71gxXTxrTVcQCm7lJ8YlcA4gBQGNOx4FIm403cceS1HD6vUj0RvumR+Y4HQJurpTX7ujrUGVtjRpeR+ZNG5p18KJLRZ4Cvv8e35EIjfBexRVE5tqk5L7JR9QtnC/gfPCsc3dfbkGU5H8CCDXUvgv/75OumRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sNXYFhjB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sNXYFhjB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GMCw10cYgLQgvy4RUSFT9Msp0F/MDrne5yM3tWepb+s=; b=sNXYFhjBjEiNILvKe9kly5W2y7
	sgEb/WgBaplBA18pcXaoh1mgg4YVI4nzeX2Zgst62hQoprFW5J6EGiWZncCORKq2+oDET1M5X2Q+6
	FTaKUCcMHac1/oqO8xtr+fxG24+EW7KWIc/gRzfnFux6vuvQZdVm9Ubm1TzgPTZU1VNI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wOFuv-003EDA-6m; Sat, 16 May 2026 16:23:01 +0200
Date: Sat, 16 May 2026 16:23:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nerijus =?utf-8?B?QmVuZMW+acWrbmFz?= <nerijus.bendziunas@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip EEE advertisement write when autoneg
 is disabled
Message-ID: <42734eb0-2005-4d6f-b973-9abfeea31bbf@lunn.ch>
References: <20260516114334.812828-1-nerijus.bendziunas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516114334.812828-1-nerijus.bendziunas@gmail.com>

> On at least the Broadcom BCM54213PE PHY, however, the indirect MMD
> write triggered from this path while the link is currently forced
> (autoneg off) disturbs the receive datapath


> +	/* MMD AN advertisements are only consumed during autoneg. */
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		return 0;

You are not adding this condition because it is not consumed, but
because it is consumed and then bad things happen. Please could you
make the comment accurate.

    Andrew

---
pw-bot: cr
