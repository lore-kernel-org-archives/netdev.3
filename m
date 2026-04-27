Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F83D34A0;
	Mon, 27 Apr 2026 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299578; cv=none; b=iJsWmE+X4KYunOlAmri80hYOkDJreeb9zI4iwAtirOTROyk+sq8k2NSb7h3IKhQg+yQvG9DA+NGYIWJINHx95+DIGVkzRqQbNdXjejLwrH6WwuN79EhJ1k6doZsG7Z25oyCq7X1FtjVl8yzCR9e2+P6d+cqgOm2UZCbCUfGtvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299578; c=relaxed/simple;
	bh=R+582z6KuOZm32OAUc/Aw4Nzhq+aywRFgnNyTKawiqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1CX+48rMtTIWOHrEaEZHCQU79V/B2Qy/DK8HJyshk4WL+i0g+4SdbHzbH5ECMRIOYEw3OTMBU3Y0D/2eGVgaLuuYfT0jR8aCOxu/euHU7lzEa1fvtg9u7eQHtVN0tMUFSZAU1YwMflrTjahWl0QN17LfUUBHbRADb+s0REnrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GooT9vkp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GooT9vkp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GEpkskhKvoKgL3hqgrxpncDprXd6TTl8aeJyXbSaKVI=; b=GooT9vkp6nwOrUMSDoFk8Hh/M1
	+vI1dozXaD0e38IsyrhmGC3n+tdzzkcRDJBc37up1bLdpZ3OZlrHdCYQCDyy52zvmBhCJuB9LQO5f
	WdtmueUT1EYGELA+LG9iidR0Wu/ON5CMtrdmRPglAzXqPCdkOwmF7/I0tVGMKgvQ39nQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHMo5-000Anb-Tl; Mon, 27 Apr 2026 16:19:29 +0200
Date: Mon, 27 Apr 2026 16:19:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: enc28j60: use of_get_ethdev_address
Message-ID: <b1dcbb65-8fce-40d9-b259-6d9bc9f3d454@lunn.ch>
References: <20260427052533.960487-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427052533.960487-1-rosenp@gmail.com>

On Sun, Apr 26, 2026 at 10:25:33PM -0700, Rosen Penev wrote:
> Since this is an OF only driver, of_ instead of device_ allows nvmem to
> be used to specify the MAC address.

Now that is usual, somebody converting device_ to of_. It is normally
the other way around, for not particularly good reasons. Nice.

> -	if (device_get_ethdev_address(&spi->dev, dev))
> +	ret = of_get_ethdev_address(spi->dev.of_node, dev);
> +	if (ret == -EPROBE_DEFER)
> +		return ret;

/**
 * device_get_mac_address - Get the MAC for a given device
 * @dev:	Pointer to the device
 * @addr:	Address of buffer to store the MAC in
 */
int device_get_mac_address(struct device *dev, char *addr)
{
	if (!fwnode_get_mac_address(dev_fwnode(dev), addr))
		return 0;

	return nvmem_get_mac_address(dev, addr);
}
EXPORT_SYMBOL(device_get_mac_address);

This appears to support nvmem. Would device_get_mac_address() actually
work? I'm not against swapping to of_get_ethdev_address, but the
commit message should be accurate.

   Andrew
