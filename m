Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B422D3A93
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780815443; cv=none; b=iCW2YEMUq+flZMoHbnUVUq18WGlb0Fi73wNnNLWsMwouF6307MWF2zMuqsF75nQh1Mzkp0cwQ2iqSiRS++BL3EjULwUVDljsPTWXo4n8rO0nqrNCLfoqv1xG6iD5yLHdlDS2Xm7k0YefMr3fNx+LaN3uEqEb1FHebeEpZ0XUqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780815443; c=relaxed/simple;
	bh=S3dDJiRlsm50JeXbDptoZWJU3AZjoV2wIuy2vkJoym4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDshUpQCMGya81hs2SUfz2DuU3VxcF/m9p6DWCJ6bMsb1ZPmAys1iU4zRkUb/sif/V4sXxNjNBRztXAGpyaGTOhhfl3SEZ/Ra0YguVeZn0btR0bXCfPBi613mRVphdWgd+kY8pBvtDTCI24cOgdZj0chIGI0efQba5DbdG1g+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zdGvlKCa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zdGvlKCa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7jK723GWVy103thqq0RJxa9T8NyGusWqP+7HRU/C23w=; b=zdGvlKCaZiOHs3EKU36wbcfRh0
	vc/XIrSejJBiS+kSNWO1brBRrnFyXu5s69/5e4CNLUQizxx8nIOwDXniXdSXlbul97ErQ7ckFcFEo
	3QWmWDi1gWMGCQ6M4jrZDgBDTwvqT+7FbDc7QTxYq4E7hTT/gSMnwBLPmV/7O/JntSPk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wW7AO-006RI4-DC; Sun, 07 Jun 2026 08:39:28 +0200
Date: Sun, 7 Jun 2026 08:39:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	'Jonas Jelonek' <jonas.jelonek@protonmail.ch>
Subject: Re: Realtek Otto PHY hardware polling
Message-ID: <1a025904-4518-4e48-bbe1-c203e409ee4d@lunn.ch>
References: <02d001dcf5d4$540aad50$fc2007f0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d001dcf5d4$540aad50$fc2007f0$@gmx.de>

> Basically there is no need to disable/enable polling for an access. 
> We are running OpenWrt with polling enabled all the time without 
> major issues. 

> - It is only used for special functions (fiber, EEE, hard reset, SerDes
>   calibration).

One obvious question is, why are these special? Hard reset i can
understand, you need to know the reset is complete before trying to
use the registers. But the others?

Either we need some documentation from Realtek, or we need to reverse
engineer the hardware to understand what it does.

Can you snoop the bus with a bus pirate, or similar? Can you see the
transactions it does for polling? Does it read the page register
first, do what it needs to do, and then restore the page register? If
the timing of the poll and driver accesses overlaps, do you see it
correctly defer the driver access until after the poll completes?

And if EEE needs to be special, how are you going to implement that in
the kernel?

	Andrew
