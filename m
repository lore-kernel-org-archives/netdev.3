Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B453359E;
	Tue,  8 Sep 2026 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868257; cv=none; b=Uaf+cA/PV1zjfPEmstohmI9ai3dC5kp9QK8a0y0Dhm3HP9CmJXmkcctyblJMugCs12xWgVGvvmg2UXfQ8SYzT/gvAEl5c5BQ/YSX/7zkEpQ+HYdSPX/KZEPBccSa9UYjEAXvvDptHKe8FzgOU1jolsgAax6a3m17IncRGq9mInY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868257; c=relaxed/simple;
	bh=ANLjYav43Qgpp8LogkfF7k4/1uwRinARijYqMXyvIs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNEWPi4jQQd24bEnkqlMfAA10H3IPUE/8RiXLmf8MEanrIIj5QFbtE2SwCOmjyAnjcOgvuchNxiFyyGgejRS3stQb4rb0du14MW3KwaZqpgYj1t6mu0UA1CVIbAW5CWzO73VZA5NsmUAg+jOtI3L7K7h0qwaH9S5KvMA2jb4WMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O5MHOcXP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O5MHOcXP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rZKv0oYjH9kU/nuci5sCum5K2+eqIbaQ7+tvedim76Y=; b=O5MHOcXPsz0LcqpFph/kaXwzwB
	oCWC8hpACK3hNGWb/dxcAcjVVLo4yGdYDC18qRMAEaoeR/IaySPYoPAV26ft1sAN4WGo4XzCzGbo6
	D59jmBtBOVPMIDsyUxliOGzzlM/RIWxJxbGZg/IY7+3spUZFodkci+2iET+mNm20/Yz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3uLW-003s8L-00; Tue, 08 Sep 2026 13:50:38 +0200
Date: Tue, 8 Sep 2026 13:50:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Amitesh Singh <singh.amitesh@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, olteanv@gmail.com,
	kuba@kernel.org, davem@davemloft.net
Subject: Re: [PATCH] net: dsa: tag_rtl8_4: push VLAN tag into payload before
 DSA CPU tag
Message-ID: <6ec8d359-727a-4fbb-9ef1-3b96d05c2942@lunn.ch>
References: <20260908040041.124640-1-singh.amitesh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908040041.124640-1-singh.amitesh@gmail.com>

On Tue, Sep 08, 2026 at 09:30:41AM +0530, Amitesh Singh wrote:
> When a socket buffer has a hardware-accelerated VLAN tag (skb->vlan_tci
> set), the upstream NIC (e.g. imx-dwmac with tx-vlan-offload fixed:on)
> inserts the 802.1Q header after the DSA CPU tag, producing:
> 
>   [8100 VID][8899 CPU tag]
> 
> on the wire instead of the correct ordering:
> 
>   [8899 CPU tag][8100 VID]
> 
> The switch reads 0x8100 as the EtherType, does not recognise a valid
> CPU tag, and fails to strip it on egress. The raw 0x8899 tag then leaks
> to the peer port, breaking any protocol (e.g. batman-adv over a VLAN
> subinterface) that relies on seeing clean 802.1Q frames.
> 
> Fix this by calling __vlan_hwaccel_push_inside() to move the VLAN tag
> into the skb payload before prepending the RTL8_4 DSA CPU tag in
> rtl8_4_tag_xmit(). The helper frees the skb internally on allocation
> failure, so returning NULL directly is correct and consistent with how
> tag_sja1105.c handles the same pattern.

Please take a step back. Rather than have two drivers do this, then a
third, a fourth, ... should the core be doing this?

       Andrew
