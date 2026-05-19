Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE610369236
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216236; cv=none; b=GRFtjKYSgu5qGIwoVeQEFAZQj80TKKarbPj8rORFAdw1wjcCl2Kmnyvw6VtG+TD0bPdC2v5zzPTliNLsHF5xf53xLTFfF/Vnb9J52ivOdiVMCb5pae4f/DP0vTNhw2PS1Y4Y5OOPAayhk/qq+ci7YnbAWWsHlIbOww+wiOeCeII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216236; c=relaxed/simple;
	bh=ojCaCmRV2q6aaMug9XlUn5A0UI7L1mBnA10xKQjljtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8brkzcSIvNj3jTDOyvci9gGVCKMyZcB/3E6QVzHVgPsZECRRWW3LRp1pJTzF8/R1or+TFM/bq/rcpLYVhDQoqk82G6Xv83NhdBWsyhNeOepEAl3q6G782t4GOdjnBZC1W7x6Roo6bYQ/znfD+SdCYpF3WlGsCS6GMY1NXaw2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LRuicSMb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LRuicSMb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QjOUNbc/r5YF9Vfca128hQFYDCLzkmMBflRxqp/7f8s=; b=LRuicSMbztDY1iZ+l0wTirZ+4E
	bLYYHL74gipri2JdLT/lBC/uxKEJ1JD4JEFHcMl/QcwDr28CB+5Fvf0MfOqvfkbWrf8LUEFkWINMY
	OhMfYGsCRv0Ufj1zKU39Y0o1KCVN4UukCPUOMnx/vpk6IAQk6ocg7xQY+T90h2+S3Jrw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPPPp-003iZR-4l; Tue, 19 May 2026 20:43:41 +0200
Date: Tue, 19 May 2026 20:43:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH 8/9] net: mdio: realtek-rtl9300: Add mask register
Message-ID: <bcfecee6-a025-4b39-91b1-bc00da3896d4@lunn.ch>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-9-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519165747.1288903-9-markus.stockhausen@gmx.de>

On Tue, May 19, 2026 at 06:57:46PM +0200, Markus Stockhausen wrote:
> MDIO write commands take a register mask that specifies to which PHYs
> the data is written. Depending on the SOC type and the number of
> supported PHYs this is either one or two mask registers. The driver
> currently only supports the 28 port RTL930x SOCs. So provide only the
> mask register for the lower 32 ports.

802.3 C22 and C45 defines that an MDIO bus has 32 addresses. So i
don't understand why you would need anything other than 32?

    Andrew
