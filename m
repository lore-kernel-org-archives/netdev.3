Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770549EC4D;
	Wed, 16 Sep 2026 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596173; cv=none; b=FB7YfR1Tz7oMmpyugzRP/9XhVTiw/nksTdhLo/PZHwaJiRlnX3XXuuojH8OooXSa9ca2pPVST+94ffXek2k24JS3Yz1PctpVxF3W2jJlutZAnooW/cNkPZZjm1VqdZUdFJ/yzA5CWh7YG2TciAcWIQdG7xEH2cyOuwZHWkPttgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596173; c=relaxed/simple;
	bh=yvaYPUSAVBXif2VD8ETt5A9LfP2XlP8+PnM7JZHdxKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXhaBsrrNk13qvKHbY/0xrQJQ2jN8vYic87nDU0qMvgQKHs2MF2AtLjYlTSsB4lBl23ZCiKEIy6grkM7BT1y/irYSn4CrzOrB0aHmnat38toa0cG+oexmWgZ6dd7RvEuL3okGPe7AgHC6FH21FVyn38ybHdRLKHREq8G2df9JoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0lCpIV9B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0lCpIV9B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R09EUTNlCcJk2z7rGxtbYRTCr9P2/JpM5inRpk2akXk=; b=0lCpIV9BVIhpmI9zCoqTMNHxvF
	m4Iir6PtUsyWGHuVhTLaOds2wv6fTFnc4ChFCgfP/IdJiU+5QW3+P8nUbFV9RDV0FPO1IgP24h69X
	9UV386sxjxRlbOV6acnETm6/KAaIqzHE8ziA/OQFz6tQ37P+7YTwAPq5FwzcGOFXxnaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6xhx-005YUL-Ep; Thu, 17 Sep 2026 00:02:25 +0200
Date: Thu, 17 Sep 2026 00:02:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] r8169: release firmware on application
 failure
Message-ID: <fcaf8c8c-f6df-46c0-ac9d-7924c732283c@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-4-matheus.aalmeida@inf.ufrgs.br>
 <fe23c6bb-2cdf-4641-aae8-25b03b38be42@lunn.ch>
 <4ee3cd8a9a299d504fc95ba86a3f387a@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee3cd8a9a299d504fc95ba86a3f387a@inf.ufrgs.br>

On Wed, Sep 16, 2026 at 06:15:00PM -0300, Matheus Alves de Almeida wrote:
> > If the firmware cannot be written, is the device dead? Should this
> > return an error, so the caller can abort the probe?
> 
> A timeout while applying firmware could indeed indicate a PHY access
> problem. However, firmware loading failures are already non-fatal,
> and the callers of r8169_apply_firmware() do not propagate errors
> either. Making firmware application failures fatal would require
> broader changes to several r8169 PHY initialization paths.

But you are making such changes, returning errors up the call chain.
Why are you making these changes? We either assume nothing can fail,
so we throw away the return code, or we should assume everything can
fail, and propagate the errors.

If we assume error can happen, if there is an error in firmware
download, isn't that fatal? Should we even care about care about PHY
read/write errors if firmware download has failed? And since firmware
download is probably the first thing to happen, if anything is likely
to fair, i would expect firmware download is what is going to fail.

   Andrew
