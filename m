Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588944DC550;
	Thu,  3 Sep 2026 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452248; cv=none; b=jE9U9z9SKXSIjtbt6zov5VOKB8jKO0LDaKB/4okYokZlbVMSLYHdNqrv80/o4mSBe+29XFRcKruy6Zo7L/D6wxCJP4FokCQR/aopPWETVUV534QKpnQB9vOatSHqWztksAr5PnE+ASt1isRVmNyFFGjIcNyWhu9hpwu/LucpNRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452248; c=relaxed/simple;
	bh=3sh///itIsoTKfcWmE25u2y0I7EuYjWA/H8sylTsHz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3tSu45u/8ARC3PSINEgL7iMgS+Qyi9rp/mGRkVYnl6M/ctgkVm2aMxrfrI1TJsYOZfJ2nlCauVhAmfQKWb/+ChukzMQD2EzTLu1oOs3knkrruZ/TGIp4tYiqyKv2QdQ+0qGAsFlbPwPZv1kAgZAz4Nqvb6mrOMidZbeF1lerFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vtZr2YRH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vtZr2YRH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QJL5YYen0/QvqwSdxVCBnW1IHbfwX+hz9GYg+hZHlog=; b=vtZr2YRHzMODaWAj8YN+XZRuCY
	5hniUse2Bkwjs8SvCC6gkiZtqfEC0c3ceBQtZeC+UJaszo9NPa7wKjWFYs379b6wf2ZF0udsqqnBD
	zkkHYIQf/aj8Wge81let1VZFr3otfSNki/2lOh7ihj+7aCFq4KDLqFG52w7gsktzw300=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2A7o-002ks7-1s; Thu, 03 Sep 2026 18:17:16 +0200
Date: Thu, 3 Sep 2026 18:17:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: motorcomm: Split MIB buffers
Message-ID: <3716dd9c-1b85-4534-98e9-08999824c02f@lunn.ch>
References: <20260903143514.532023-1-mmyangfl@gmail.com>
 <20260903143514.532023-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903143514.532023-3-mmyangfl@gmail.com>

On Thu, Sep 03, 2026 at 10:35:07PM +0800, David Yang wrote:
> With MIB improvement introduced later, struct yt921x_priv will be over
> 20k which is not very good for a single kmalloc(). Dynamically allocate
> the MIB structures to reduce the size of struct yt921x_priv, and do not
> waste memory on dummy ports.

When you read this....

>  
> -struct yt921x_mib {
> -	u64 rx_broadcast;
> -	u64 rx_pause;
> -	u64 rx_multicast;
> -	u64 rx_crc_errors;
> -
>  
> +struct yt921x_mib_stats {
> +	u64 rx_broadcast;
> +	u64 rx_pause;
> +	u64 rx_multicast;
> +	u64 rx_crc_errors;

It does not explain "Why?" this structure got renamed.

> +struct yt921x_mib {
> +	struct yt921x_port *port;
> +
> +	struct delayed_work work;
> +	struct yt921x_mib_stats stats;
> +	u64 rx_frames;
> +	u64 tx_frames;
> +};

And the old structure gets new contents.

I find this confusing, and not easy to review.

Maybe avoid the rename, and call this new structure something else?

Maybe break this up into a number of patches, do things one step at a
time, making it easier to review, lots of small changes which are
obviously correct?

	  Andrew
