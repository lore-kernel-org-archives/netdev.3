Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683538DC69;
	Tue, 22 Sep 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081283; cv=none; b=P1Iqf+7U1Jxbx5MvB8EvEmN81j3jDo6FkAZivnb8CxFtQhwaQCR5Es1OAi7o2qBVuu/tBAqx+sClVYGscPjOXqFDrA4OauKtaPnLecoeeklvhEYPdvCFFFPPbNWG41qFX5MdXr/S5mpaOcTZQ2/iDUV+ybsxT8XRqnAJGEF+n6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081283; c=relaxed/simple;
	bh=w5rTtIc34TBD/Z95LMLCoJEjRn01eaOde1yWbZKNdzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3v7xiHbLklyzgp5U6f7L3dBuLKwxPxIEBPbBLsl3TQjH6mtkVisuI9nT5KkNR9Eicq/rICTeHV2wkqY7QGE97/IH+YreIBseF0wkjtT4VbsjHSlYwWsGAgrFfBQ36vIxdOkdZXzEvx9fljEzc4v1n2HVZVoYYH1Pwt6SlLCY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MGqvxvkE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MGqvxvkE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+kUOP7ye1D0usoHFJvLHG3xOqZFziwv2m2KGtDa1lPc=; b=MGqvxvkEmdKTlBF848AIK5f+NG
	yWeOGLaUW4bL20u7Mw1tcq4FKTN3c0XO/CpfrWgeFcZHYHnDvi0D6K6Xrc7nURUBVKdaSrm47yNDB
	ZYla/EOK2wDY+ePXYUky77mAGJ0WsPcEdCIp206m5KhmqaNj+eZP4yQV+GPKmabwWaGU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8zuY-006aib-7X; Tue, 22 Sep 2026 14:47:50 +0200
Date: Tue, 22 Sep 2026 14:47:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v8 2/6] net: dsa: motorcomm: use max_ports in
 series for port bounds checking
Message-ID: <e54c308b-3297-4abc-af95-5ef9c925931f@lunn.ch>
References: <20260917082236.3427168-1-kyle.switch@motor-comm.com>
 <20260917082236.3427168-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917082236.3427168-3-kyle.switch@motor-comm.com>

> @@ -402,7 +403,8 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
>  	mbus->read = yt921x_mbus_int_read;
>  	mbus->write = yt921x_mbus_int_write;
>  	mbus->parent = dev;
> -	mbus->phy_mask = (u32)~GENMASK(YT921X_PORT_NUM - 1, 0);
> +	max_ports = priv->series->max_ports;
> +	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);

A separate patch, but can this be changed to GENMASK_U32() so the cast
is not needed? There maybe be other instances in this driver which can
be changed as well.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
