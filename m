Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4278448BD29;
	Mon,  5 Oct 2026 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208881; cv=none; b=YJSyEvUDbo5wgxK1tN7KvZ6xqqFDUWTp9JIhE1eogK1pWYJi+v0Oh6XmKAVFjQzyPWw3lqV4zhFm4GcQ5mrs7bsqczicLa9BPeE0kYaP/R3miYDmHGwZbO4mZr/FjNc8Ba8VWFFDggUe2Z1b+4w5acZVoCKt9A7WflCRjKklZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208881; c=relaxed/simple;
	bh=/s8QF0d1NfFKp+TDTgUFxcVXsHY1mVe6YbVKJ/Y+i5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgcHBw9s6YfEp9pugFsOLYp7BT/fhdhH5cPjwJU3ZVg5qdDNMm2lSVol0vfjsIvMi2tG+R2/VW+U0Kg5O722PcJZLV1nG6VC7vizMYgsGN5WD4nDbBklZVoLT/EHqk8UbK8HC8B0RSsq/Kt6GHyazbcMZY63Wzbc21eLnob6+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kAWlwXeT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kAWlwXeT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P3F315K0qJdSKIuuGbIvWLRuMzIRgjrnVfOHocrxmxM=; b=kAWlwXeTR8cMY89ktRtjo8ceZG
	hvMaxFA/eofXNsAb035de+uQE42jALxXO3R4klt/2LJ6nskNItlnfSp+SajtrzZkZfJhw9wCDPMxJ
	Z+/6oIRZvndmZ/v0rn/ojk5a3PesPW09uzhE9PCFSm4zTyhfcwK/d1PZ46Su6dz5B00k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDjFT-0093BG-UM; Mon, 05 Oct 2026 16:00:59 +0200
Date: Mon, 5 Oct 2026 16:00:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Damien Dejean <dam.dejean@gmail.com>,
	Manuel Stocker <mensi@mensi.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: realtek: fix RTL8224 package address
 selection
Message-ID: <0cda40ae-b468-430c-8de9-10fdde8e2beb@lunn.ch>
References: <20261004204637.721148-1-oskari@lemmela.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004204637.721148-1-oskari@lemmela.net>

On Sun, Oct 04, 2026 at 11:46:36PM +0300, Oskari Lemmela wrote:
> From: Manuel Stocker <mensi@mensi.ch>
> 
> The RTL8224 driver rounds each PHY address down to a multiple of four
> to select the package base and uses the low two address bits as the
> port index. For a package starting at an unaligned MDIO address, this
> accesses shared registers at the wrong address and selects incorrect
> MDI pair order and polarity fields.
> 
> The Hasivo S1100WP-8GT-2S+ uses two RTL8224 packages at MDIO
> addresses 1-4 and 5-8. The aligned-address assumption splits each
> physical package into incorrect software groups rather than using
> the actual package bases of 1 and 5.
> 
> Use the base address from an ethernet-phy-package node when present
> and calculate each port's offset relative to that address. Reject
> PHY addresses outside the four-port package and propagate explicit
> package errors instead of falling back to another base address.
> 
> Keep the existing aligned-address assumption when no package node
> is present.
> 
> Fixes: 330296ea9e15 ("net: phy: realtek: add RTL8224 pair order support")

I suggest this gets merged to net-next. It never worked, so it is not
a regression. This patch just extends the current implementation to be
more generic.

And now you are looking at DT properties, you need a DT binding
document.

    Andrew

---
pw-bot: cr
