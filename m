Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB44387344
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527267; cv=none; b=YO0b80je6P/D/ndto0QgQ1m2bFfb6fMUXFPbx4bbCeS0pdiNlYnCNECOLyHLElmLmXYqCHhSHlMJSTxBKxlQRkwqdFg/5917QS+ZYmYpvgVk1DboBe3q7z9nNmOzHgUW6LNsqdFIKdVPrmzHwUP8mE0Cy9FN3bpsfpyDq+ksjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527267; c=relaxed/simple;
	bh=rT8Fkif7BqKMnIB2XsTOFaBhv6+TxHOx57ZE5yrK8tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXZcEnVLwaJlMYtKz/n55hyfkav/v2bMXvOL8FC3Aqntt0na83UDFtc19Q77PhrV0D37ccLUh+gRcVuLxmpslt+ODpn7XoDy3JBvsag2PiOVN02rcW+hU+Fk0UeRrykR48nPZnmrMir9ht8xkeQkY5fE4O+yZwcKiUCFPB8TyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aGQ3g/fy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aGQ3g/fy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sd3HnYHwrvQfSw2yT41GkMgTViyo9N7uJ9ebYI1iadw=; b=aGQ3g/fyXF9zL8llOarDhmZx9X
	e4atWgS0MEtKdWsyOCUifAXoQIRAfs1vFE3peXPk9u6VD/Axw4vlfA+r7OlD6WXMx+M0Suk6B8Q51
	q60w1pR/jwJMSxFcAOg3Ew1xv3KZ/XB8Ej0LLgMiB4+y20mfjQSxVZ3Vhi1TrmGPZ5BjB2OIhmXYD
	SXLN6TiPI01U8HO9EKex4FGwqFAwIWUy0KwovDTMkTZS/UE9gBpgqKMr58+XycWoYxttKRf8F/uty
	m/2FDHlvqAZhrH98cQO92Gbve3v2VIk7zXRZf7e3jEZ4Yd8jUHmqfX8M9ZtAn5EEQD6+X1rGzly6v
	U2ZGTNog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49962)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxLJG-000000004ta-3CiY;
	Tue, 03 Mar 2026 08:40:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxLJA-000000006nO-17VQ;
	Tue, 03 Mar 2026 08:40:48 +0000
Date: Tue, 3 Mar 2026 08:40:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>, Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net-next v3 1/9] net: ngbe: move the WOL functions to
 libwx
Message-ID: <aaaekLi5vE7Qid3O@shell.armlinux.org.uk>
References: <20260303030331.24076-1-jiawenwu@trustnetic.com>
 <20260303030331.24076-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303030331.24076-2-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 03, 2026 at 11:03:23AM +0800, Jiawen Wu wrote:
> +int wx_set_wol(struct net_device *netdev,
> +	       struct ethtool_wolinfo *wol)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +	struct pci_dev *pdev = wx->pdev;
> +
> +	if (!wx->wol_hw_supported)
> +		return -EOPNOTSUPP;
> +
> +	wx->wol = 0;
> +	if (wol->wolopts & WAKE_MAGIC)
> +		wx->wol = WX_PSR_WKUP_CTL_MAG;
> +	netdev->ethtool->wol_enabled = !!(wx->wol);

Please see net/ethtool/ioctl.c::ethtool_set_wol() and
net/ethtool/wol.c::ethnl_set_wol(). Both of these call your set_wol()
method, and then if it was successful, sets
netdev->ethtool->wol_enabled as appropriate. So whatever you do here
will be overwritten by core code.

Maybe an initial patch to remove this prior to moving the code would
be a good idea?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
