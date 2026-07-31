Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04223E334;
	Fri, 31 Jul 2026 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526910; cv=none; b=TLrXaBMUgVFbPguR1c2j0I7hvMgpLIfoIo7o95YrDv9IKwJbBvEGN2wkybj98Cipl5EDSzYtiBvqQpEeTWH5VhgA4bXJsQdF7fmLxpUr73z5ytJHEqsOmhbqI1F9wP6CGgUYqOamJV1SBMBjUEr5Wp79pLwXgve5Q98bTjax1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526910; c=relaxed/simple;
	bh=XbEK9PJTAzriqwSWisT+qaMlBXV6L8wb8XKiHXjr6FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS7hgs0939/8jmOxK6EVtvSpX6hj93QfM3ZjBPEq7IuWKk5PhfsWoLeYaFiFFQOlybAsiwyjba/39YIetTEVPWgxW/4vD6val1/4eR0fhoqvJZ7qfr1xitS197Bl2/WJTBEg/PnlyJPglxKgGA3om29aZJ6/T3FY8CosQcOI6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AC6H5J0h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AC6H5J0h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=edtEhamcyKdVKkEP2UF1uSRSdOf0Kdf/RuTMWBRoBa0=; b=AC6H5J0hwQ5a068UTzgm3F6mGH
	WJtCJKi1a16QVexIUG0O5yk7uaef+vOdEUVd5SwkePc4Sl/TJw3aoK15nmixsPAR3epZtTpgVdtqa
	2CnK4zNL1vX7Orzn3wyP6XET+UAXzVWWqMf97DfQAyBdD4KV1CDHQ3w39lwoGtP4XRsc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpt6x-00FHkC-U8; Fri, 31 Jul 2026 21:41:39 +0200
Date: Fri, 31 Jul 2026 21:41:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v4 05/12] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Message-ID: <db165350-ba06-474e-9635-81c2083921ef@lunn.ch>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-5-2cf1f71b1dd2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-ax88179a-v4-5-2cf1f71b1dd2@birger-koblitz.de>

> +	if (!data->is_ax88772d) {
> +		data->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
> +		data->phylink_config.eee_enabled_default = true;
> +		netdev_info(dev->net, "Default: EEE\n");

Please drop the netdev_info().

In general, we don't spam the log for the normal case.

   Andrew
