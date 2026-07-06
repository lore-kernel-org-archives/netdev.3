Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E837FF49;
	Mon,  6 Jul 2026 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350457; cv=none; b=nDAlvV+xclJPZ8lO9iy28PcAFDdrNbqTOsDlyXK/YbcEiQ0apzXofUnZMLIpM8GJrzR2SWTSjiCUoTIouxMVqM13w4zbtgUPaXYHHWXRE2owGXoAiwPaAi4Kq6K32kvL1t29MrqJ6R6loSMlaxljQfHAwbYXUNPGBzlDw3/tW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350457; c=relaxed/simple;
	bh=68osxlbQyASxjtHAEF0keGr5Wv/PXnGNLo9bt1YYdwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjUFRTBgMN7YRJ/fVW9dLNtiWw7Dvj04adTyKg8Y2Xy8h8S2rrWaGoGyGKE9yKxMrgs6Ch27wHLs12GIinzzqofk0cXyPE1lqwP6SalZZH6iDiqHgmfcUlHYYF1iFpSpsC+6uYWlMC5Uf1iId/AELPdgzNnveU8Nc7CCXWwrRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g3AXrHCs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g3AXrHCs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=clHoCQYnx+BjE0eyOPInY529xHchBneL76ylB2+u72s=; b=g3AXrHCsZj30hjMt7RO11NOOg7
	AeV36whVYDQZvlP0o84X+PrOyUMJkW5MKTqApBKdKZi7Uw4gZvMAxg/PZOV0hrL0W12VYcyGgWpHI
	GFS2ra3XpHrayhjzbXPrg6rsPjT8d+Vfyo8oWlcZzngy6KDdw/LcxfeXtpLuuE9GG6ro=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgkuu-00B0fk-Pm; Mon, 06 Jul 2026 17:07:28 +0200
Date: Mon, 6 Jul 2026 17:07:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: sr9700: validate receive packet extent
Message-ID: <f4490acc-e922-431f-a37e-31189cfac304@lunn.ch>
References: <20260705083724.24494-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705083724.24494-1-pengpeng@iscas.ac.cn>

On Sun, Jul 05, 2026 at 04:37:24PM +0800, Pengpeng Hou wrote:
> sr9700_rx_fixup() copies len bytes from skb->data + SR_RX_OVERHEAD when
> a URB contains multiple packets. The old check compared len against
> skb->len, but the source pointer has already skipped SR_RX_OVERHEAD
> bytes.
> 
> Validate len against the remaining bytes after SR_RX_OVERHEAD before the
> copy and cursor advance.

Please fix the Subject: line.

    Andrew

---
pw-bot: cr
