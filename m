Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712570;
	b=PFoDdAqjGOQEjKiPjAlrxL5MbUZ9qvTvO+IY9HmESHR2YDivOYhMB9uGpwCis5m24GzZ
	 +vtzdW7ThBoVdLq+AyEFO2lQmQfYJl2PNE8NcrmajTVH926CjBUjPwPjCrAMm367kG8M3
	 JPUoIemV/sMOYFojsAK3gz5YQ2QNA0603ZEW52ijwSevGq1s9mCDvnO6FqiA+qmQEa/g4
	 DJyRTdL57R5gsooK99DCqwbyhCuQUR0Eo/Mv7oe8qWQwfZkT6ptCum47dcsSAkqUirZ0K
	 o8ZeIeALjwBCbxRcpdf14nUQo3eUPb8dSYms1WWg0/zpbUTOkqj3NBYJyScPu+hRGTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712570;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=sBRxABsGWngd6btHwZmIdWWCCLbRUAlEpuoe37Pf0NM=;
	b=nN5wgwa5h6WInUj59Utd2UTuiKUt0o/Qe+33tCEfQwbCYjJYDvYL3Zy+CNTZfXjWCtqU
	 e+Rmtg4z9XXJB4eU5icB0/E/Jc4o99gNl6kGXhDLz1GZSckyiQomv/1XDdKqoVnJK6BEB
	 FaI8mVqgc5daN8onjqQ/kB/hNv+Ff5RcI0uc+sSB0jKanZJ/Dqc08yxoDW1BYSjQiP9Kz
	 42WAf7BVfJmPG9m14qQXWBuzSmrm2gxlUelD86x8lVz/EsX7MmZTkyAJkgxdYLyK8/p8F
	 0qghJ6ecEz9HBWiQ8DGCoyAetNNE1suyO0MRpgZR4mWDbe4BUstoC1wTRjbrVQpN5qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=DDPkZomE;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24D606A327;
	Tue,  3 Nov 2026 13:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC24D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=DDPkZomE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sBRxABsGWngd6btHwZmIdWWCCLbRUAlEpuoe37Pf0NM=; b=DDPkZomEVo62gJ6lPLeISbztjq
	NCA82tMmpvOHSxiGzvmCzmUFOTet2uIiiFDbSQKMflSvHktFIL+CDGK0Tk2U8yN9nc0IGWfOXFl8x
	2q6402X1Mbdmf/Q9ayF4rfKVN1GXNR+TPeoxqKQ/SVCyErlIbD5Xkzal/M33iWzg9gUY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOEZe-00E3ue-M5; Tue, 03 Nov 2026 14:29:14 +0100
Date: Tue, 3 Nov 2026 14:29:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tommy Shih <tommy.shih92@gmail.com>
Cc: netdev@vger.kernel.org,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Lucien . Jheng" <lucienzx159@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: air_an8801: add WAKE_PHY Wake-on-LAN
 support
Message-ID: <7e1ac14e-b306-4921-84fa-8266b3263f2d@lunn.ch>
References: <20261102132903.713908-1-tommy.shih92@gmail.com>
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
In-Reply-To: <20261102132903.713908-1-tommy.shih92@gmail.com>

On Mon, Nov 02, 2026 at 09:29:03PM +0800, Tommy Shih wrote:
> The AN8801R can wake up the system on a link change, but the driver
> only supports WAKE_MAGIC and always masks the link change event on
> suspend. Supporting WAKE_PHY allows the system to be woken up when
> the cable is plugged in or unplugged.
> 
> Add WAKE_PHY support:
> - Keep the link change interrupt enabled, and only disable it on
>   suspend when the PHY is set to wake up by magic packet only.
> - Report a wakeup event when a link change interrupt is seen with
>   WAKE_PHY enabled.
> - Enable device wakeup when either WAKE_MAGIC or WAKE_PHY is set.

This is an interesting definition of WAKE_PHY.

Are there any other drivers which use change in link to trigger a
wake?

How are you using it? Is your device plugged into a manages switch and
you are making the managed switch down/up the link?

Is the hardware capable of waking just on link up? Is there any point
waking up if the link goes down?

	Andrew
