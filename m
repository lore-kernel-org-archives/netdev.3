Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781248F827;
	Mon, 12 Oct 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816471; cv=none; b=DT6b4pQAGyhCxgejt1T/R9Nea28a3nKaW8Kmnuy8WoIxdANgz29hUCZ2qTzS2p8zzEXuXI9jwchD1jlQjoW95At96cDr1qV3WlHrbdK+C0R1wZm4BBYIw72wCZYSL/Auus5yFO3X4HPR2z/VgxQPipdCUdmte1Gx5BWqOCPsyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816471; c=relaxed/simple;
	bh=sRWQ24BvreigALTr4vhtdp8Z6cN5af/h0OA9Hsa1gQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4ZAuWGCbtrAoMMik1fD5wCBlCp8y0V1UlcROLFA8Eqpek5jRn2rnnb3rxwUOyDLBVsqOS5iA61H806xL2E6AEwws0epfsVBv+WDx6lK4rmZE17qDX13GdHQzpOI5cqnaIE5csXnV+MI6rHgDZvYPbET6Nimg9K8BTLB9hz6aJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MddD1XM3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MddD1XM3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2Dnk+taR5VE4FB6PnSfOv7+73NQ/Pd4ruC75qr8uuwY=; b=MddD1XM3HBY7+vM1QpRmqfBzzX
	yOgfxEsDiNtjZqU7gFFl61ZOn2uKxnay7Pyqbnd4dOqIMu82lbXkBk6wrQawO3ll9Xqw4PmZmiPbY
	3+WFEccrhDXG8ZZB9YA3tYG2M9vB9cT70IxZtDx+10L06BWnPYFOtiIM8hPnb2NZX+8k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGHJQ-00ALOv-K5; Mon, 12 Oct 2026 16:47:36 +0200
Date: Mon, 12 Oct 2026 16:47:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v13 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
Message-ID: <69492752-8b6c-428b-80f4-a44f4d0855a2@lunn.ch>
References: <20261011025043.1859940-1-kyle.switch@motor-comm.com>
 <20261011025043.1859940-6-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011025043.1859940-6-kyle.switch@motor-comm.com>

>  static int yt921x_chip_detect(struct yt921x_priv *priv)
>  {
>  	struct device *dev = yt921x_priv_to_device(priv);
> @@ -3631,6 +3648,9 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
>  		return -ENODEV;
>  	}
>  
> +	if (!yt921x_needs_extmode_check(major))
> +		goto skip_extmode_check;
> +
>  	res = yt921x_reg_read(priv, YT921X_CHIP_MODE, &mode);
>  	if (res)
>  		return res;
> @@ -3670,6 +3690,14 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
>  
>  	priv->info = info;
>  
> +	return 0;
> +
> +skip_extmode_check:
> +	dev_info(dev,
> +		 "Motorcomm %s ethernet switch, chipid: 0x%x\n",
> +		 info->name, chipid);
> +	priv->info = info;
> +

This goto is a bit spaghetti like coding. Why not:

	if (!yt921x_needs_extmode_check(major))
		dev_info(dev,
			 "Motorcomm %s ethernet switch, chipid: 0x%x\n",
			  info->name, chipid);
		priv->info = info;

		return 0;

	Andrew
