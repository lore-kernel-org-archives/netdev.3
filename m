Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A62C21EC;
	Sun,  5 Apr 2026 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775431870; cv=none; b=XI+eHoUxn6rewnzmSFK4MjFUEGqEJxb+6KTQJParDeq9iFEI8DNp4WRY+XQ/+Opzgr9WQ2puH4GepndiWi+L+qa31XKlG3jGD/5Ww3OFHhp/TdB5x07OVLIDPwm2NSak2tgT22YXKHXqU9hcM8IBjZ7vSKmx2EW1lDsxeM4ru5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775431870; c=relaxed/simple;
	bh=bEnu8ok92svY2hpN2I5bJp/F2YqmT0V6lQgyKQBT3t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la0EucY0RvBZVs6PIK5PAckEKGUpZ9yjk8bS9dmE4l7GhPXzLbE47boKA+NKhfu5+3ZFFI9jciCVLbahXRZ1CeA++9Xrk8Dq0EQMo7aVp1c2/D2lxpTubt8QJ4mvZPJ1tFA7S9xBNpGMf7tp1Uq3BeGwZKIonU8kR8Ta5RGcTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k5aOUMx+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k5aOUMx+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OrDPLTy8mH3lnHhLuKLAs0AzUjMCVtT4kpOecAwFjK8=; b=k5aOUMx+WcVPDxfyLDs2u4dfM1
	9POyf2E+FahJuvnK8GnKQUBF17Q93IJw+cE1pw1kkCELgHatvNLuST5mPCkpsquv2IBTNrinlVifB
	mZ8SbaCv3UmSH5OYUgjMAvQKbmL3A9Kzb2rqG11OStUsWzpDNT5uWZ5bE62h4Jj0kvbo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9WvQ-00Evgh-JQ; Mon, 06 Apr 2026 01:30:40 +0200
Date: Mon, 6 Apr 2026 01:30:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio: realtek-rtl9300: use scoped
 device_for_each_child_node loop
Message-ID: <479730d2-73a3-45ff-90f8-52f5e71c2b80@lunn.ch>
References: <20260405-rtl9300-v1-1-08e4499cf944@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-rtl9300-v1-1-08e4499cf944@gmail.com>

On Sun, Apr 05, 2026 at 02:51:52PM +0800, Felix Gu wrote:
> Switch to device_for_each_child_node_scoped() to auto-release fwnode
> references on early exit.
> 
> Fixes: 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Hi Felix

Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need to set the subject line correctly.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
