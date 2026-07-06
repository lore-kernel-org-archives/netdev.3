Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56637C0EC;
	Mon,  6 Jul 2026 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350408; cv=none; b=gt+xIJSdldHpFwyxbbkUcyLPzKntAB+fBenhD7v+fBCQo0Ily/76625y1rY8aFDCLR+cBBM3oWy+y6HWvjwn/8sv6dEFILDH6sB3MnSFXz2mtNWuxwC7Icc2BWPLaeT4/DLSK6ClDKcQof0o/Uh9YHAqmzC67+BVkw3teGOU4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350408; c=relaxed/simple;
	bh=gMB0gtTMqL2ZMVwjs5sXDPpPxgv1lBphzfkLjZBJRZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUuL8+npTD/oW3Ap0j6BoPJAJ53vmfNVdTMdNXvVcEo0yAZU6iisGjexRF8s/FdlQLiNmv5GQQZUUAaxvWYepemy8hP2ReTSQbajalTilNUaqcdyY6qGFJ2phfsnF8w3W/I+Bp0p4sY9dXzovyTSE6knxZ7rnQlyxoDEdfEmmq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iFSd+Lp8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iFSd+Lp8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7T9lKLBCurJx7NULGnJPFkaWnZSHCHAuJLKjzAT+Hl0=; b=iFSd+Lp8lGBOZ23doP8kq/0DEl
	x8P7JgYPLYwXYdN4e8q02nbnhWfvhQMt8Zk9h1/kwtFdY/+2/wYifu6J6lyX/XscKIV7YLhHvRlRY
	2n0+Cs9vjNAWOt9wAMScq5Je1AzNYNV8NJ/PSe/7pWKmuZ8ofj04LPmEpi/Hqf7U4MAs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgku3-00B0e7-BF; Mon, 06 Jul 2026 17:06:35 +0200
Date: Mon, 6 Jul 2026 17:06:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: cx82310_eth: bound partial receive continuation
Message-ID: <8ed2790f-05ab-4c6b-9982-e92a08c6c99d@lunn.ch>
References: <20260705083609.23977-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705083609.23977-1-pengpeng@iscas.ac.cn>

On Sun, Jul 05, 2026 at 04:36:09PM +0800, Pengpeng Hou wrote:
> cx82310_rx_fixup() completes a packet that started in the previous URB
> by copying dev->partial_rem bytes from the current skb. It then pulls
> the same continuation extent, rounded up to an even byte count. The code
> does not first prove that the current skb contains that continuation.
> 
> Add a fail-closed bound check before the copy and pull. If the
> continuation is shorter than the pending packet state expects, drop that
> pending partial packet before returning so later URBs are not consumed as
> stale continuation bytes. This keeps the existing cross-URB packet
> model, but avoids consuming bytes that are not present in the current
> skb.

Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The Subject: line is wrong.

How has this been tested? 

>  static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
>  {
> -	int len;
> +	int len, pull_len;
>  	struct sk_buff *skb2;
>  	struct cx82310_priv *priv = dev->driver_priv;

Although the reverse christmas tree is already broken here, you should
try to keep with it, and put the new line at the end.

>  
> @@ -251,6 +251,13 @@
>  	 * end of that packet at the beginning.
>  	 */
>  	if (dev->partial_rem) {
> +		pull_len = (dev->partial_rem + 1) & ~1;
> +		if (skb->len < pull_len) {
> +			dev->partial_len = 0;
> +			dev->partial_rem = 0;
> +			return 0;
> +		}
> +
>  		len = dev->partial_len + dev->partial_rem;
>  		skb2 = alloc_skb(len, GFP_ATOMIC);
>  		if (!skb2)
> @@ -261,7 +265,7 @@
>  		memcpy(skb2->data + dev->partial_len, skb->data,
>  		       dev->partial_rem);
>  		usbnet_skb_return(dev, skb2);
> -		skb_pull(skb, (dev->partial_rem + 1) & ~1);
> +		skb_pull(skb, pull_len);
>  		dev->partial_rem = 0;
>  		if (skb->len < 2)
>  			return 1;
> 
