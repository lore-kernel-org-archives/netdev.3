Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9573E95B3;
	Mon, 31 Aug 2026 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177637; cv=none; b=nqmlzJZ0BfWuN8dFyblSkQk9N1tEoT6b4WAl+uYKNu7z6jVieXMVUGLNubavshPDWq6cgFSy0Ze3FPNrCaniTMED9h6lqRFOabcoxocpHsFnxQY14YbcYMzwfDI/4/cUp/mkxhQ6d1sCJ2HpF3HzkEaOfqaHrgegNJW337CD+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177637; c=relaxed/simple;
	bh=xAdhCc0paO/fytdIN1fc/MKKx/Rnq96c31nUcTqEQVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtIhhaG+KbduDaOikaXcj0Nr5lB6x+Xr2Jn9BiZkK8Q1d1OhlRGRtomczi0J8rr/znLpxHI1Johts6I1GU7MC12Az91f/MqfDUwdtwZ+EJaj4G998Mqk7hHPZ/JTaetH1t8xIOHb/l5O25ZVZw6rOUnyVKDyVzlfFzhKbUHz7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FQbhnm13; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FQbhnm13"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WAZal6+xHJOTQwuOWV0TumF+JZTtf0e2mPahMt/Ni5M=; b=FQbhnm1386Y9m1L/TOZuWY7xOy
	vo/5ZJJBfyExb/b2EP/jFdCuO03pcnfNoaVEHgA9wi2C0L2qrRE0BV+D9wgr+L1MSQJGrAV5fjCQh
	ryfAxVAjkIipeq8B6G4CQhWlfhtHXxZjUuDSP+1TDYCBpP66xth4mmWAKqgvez3FvYA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x10gU-002AVq-Op; Mon, 31 Aug 2026 14:00:18 +0200
Date: Mon, 31 Aug 2026 14:00:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
Message-ID: <bd07a661-857f-421a-9ff0-e807aade9543@lunn.ch>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
 <20260831025441.635045-4-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831025441.635045-4-wei.fang@oss.nxp.com>

On Mon, Aug 31, 2026 at 10:54:29AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> Add link status message support to the PF driver using three command IDs
> under message class 0x80 (ENETC_MSG_CLASS_ID_LINK_STATUS):
> 
> 1. ENETC_MSG_GET_CURRENT_LINK_STATUS (cmd_id 0)
> The VF queries the current PF link status synchronously. This command is
> not used by the Linux VF driver but is intended for DPDK-owned VFs.
> 
> 2. ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER (cmd_id 1)
> The VF registers for link change notification. Upon registration, the PF
> immediately notifies the VF of the current link status via a PSI-to-VSI
> message, and continues to do so on every subsequent link state change.
> 
> 3. ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER (cmd_id 2)
> The VF unregisters from link change notification.
> 
> For link status message, the PSI-to-VSI message is 16 bits wide: the
> upper 8 bits carry the message class ID, and the lower 8 bits carry the
> class code. Bit 0 of the class code indicates the link state (1 = link
> down, 0 = link up), and bit 1 indicates whether TX PAUSE is enabled on
> the PF (1 = enabled, 0 = disabled).
> 
> The TX PAUSE state is included because VF RX BD rings support congestion
> mode, but whether the hardware can actually send PAUSE frames depends on
> whether TX PAUSE is enabled on the PF. By conveying the PF TX PAUSE state
> in the link status message, the VF can determine whether to enable
> congestion mode on its RX BD rings.

I see you have hit the 15 patch limit. Do you have a patch in the next
series implementing ethtool get and set pause?

	Andrew
