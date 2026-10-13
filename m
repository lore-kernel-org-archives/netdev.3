Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437B41737C;
	Tue, 13 Oct 2026 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859105; cv=none; b=uTn1JombyeJ5jXACjO2FauliFdx7pylQbDfomC7Yln0OZyZjf7wX4SEENjHazopE+1FZuGBeX97vTInM1v4AgZGy3LbRpO4FIVt5yEHPpQqugcwOASYIFV5Ur3XtmcADJOaljQz+UpVrNFcB1as+PpqKWItxr5hCoEww5Aj2fzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859105; c=relaxed/simple;
	bh=cb90eOADoGhbAVgel/6yM3BDhXRgOkhxGZRhcq45nII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS50+dOvmcaMFGe1VAZY1m3iXEyomncwOnMLiu6WY2GEOc7Il8uaktTdgllyT+v2mDoKnhyTrF4E9Q/75GG7sJfyE8wMQePyFoPp7Ms8g3jvv0ZFhh34GFk58ZDfVapN93RZxXBykjr4XJ0fIr9JRgxP7nIu6HJWWa/uLXMdcn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FpSOO72L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FpSOO72L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GVOTkKxiXvQcSqwXe8f/f0/6P566vHomflhTXgn/0jk=; b=FpSOO72LYSoxRbQzLF9rHHEGo1
	OOlIdQcvLlQJZXb4YNLRKxkrAFVKJSlXBl2trEvfb6dIExp4FUSI79DQH3UI9NRYA9Doz6/L/Rsep
	A11Ku9OYhnQ4q79y68IAC453YfEIdNIxwO5DvFpl1FZmPTI5xw8u3O7mzwFjVBCr2x9c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGSP8-00ARKU-Vg; Tue, 13 Oct 2026 04:38:14 +0200
Date: Tue, 13 Oct 2026 04:38:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konstantin Meshkov <skyline@mail.ru>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: marvell: add LED support for
 88E1116R PHY
Message-ID: <dbccc0f3-b79e-4feb-9e10-f7218dc09305@lunn.ch>
References: <179165733751.2921261.13784246298385245617@mail.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179165733751.2921261.13784246298385245617@mail.ru>

On Sat, Oct 10, 2026 at 09:35:37PM +0300, Konstantin Meshkov wrote:
> The Marvell 88E1116R PHY (used on the D-Link DNS-325) exposes its LEDs
> through the same page 3 register 0x10 LED control layout as the 88E1318S.
> Wire up the existing 88E1318S LED handlers in the 88E1116R driver entry
> so the PHY LEDs can be described in the device tree and driven through
> the LED trigger API with hardware offload.
> 
> Tested on a D-Link DNS-325 (88E1116R): both PHY LEDs are registered and
> hardware-offloaded.
> 
> Signed-off-by: Konstantin Meshkov <skyline@mail.ru>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
