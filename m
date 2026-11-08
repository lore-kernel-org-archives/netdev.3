Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156636;
	b=IGNNzME7JINnt8sz1Fu/q2EOLm5MOciL+PklUQWwAbOzUDcmZ8YmRBjTc2p71f8zdE5D
	 uWS05wNE6DxiifO8nwXc06rndR7539cpQV9ptBJz0s0OXiTO4ZVWhep5r4l5WTH2qdxbI
	 8baU9oL5tiIofvsg0yd1KKCpDDoZEsRwYs6UFSxzGy0YiwX7UV1b+OJc93Wyb6x5gYN0F
	 MdBD0qG1nPIMs1e4BXqAoym+DTjKJpTXcJ+4Tkuk84ApD54QsnPOpW2P8y+ZisLL44JtP
	 EqfPAu+Vk0KVC0zxt11r80ArklxEzWtnG3DLsmbMz1UQfWEEX/JuX18zQ5NTp1+EW/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156636;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=UhVknWdLWOdCnQJdj2Amn0VVAYXtsLA3g8RN/p2HGvI=;
	b=CCCqbATYBgVEzEl9tGk2pc5I1BT3qo3iKqMoCzma16YeqzfbUtPG4Djhf77RpFXYpFD6
	 WmDovYyzSLaHVDrs31KP5FBzjfAr0SrIxJZhADTyQEFLQCMH2VAqqSyx68fFS0zD1E3X9
	 Etr5IhJ9fMct/261zsUKyVmI5xIbxslBWzhsNKnDTEVda26ev70Jvu1MOnUv2cvZZOICG
	 iN8KqbBgxzKZLH+TMFBMrItAnLLzrEQ7ddv6g8mq8T1Hm0D33NyCvOkaOJ2hj2D+LqGWN
	 mpZQB2a1epC+eT7hgoNwK3gvxe1AP3YoRAIQ0By7205h5UKgj17HlKIJD9G8KBCzt7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=T9IH8X6B;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C209606A31C;
	Sun,  8 Nov 2026 16:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C209606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=T9IH8X6B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UhVknWdLWOdCnQJdj2Amn0VVAYXtsLA3g8RN/p2HGvI=; b=T9IH8X6BhM75RmPIk6CAOF0R7w
	PA3Ezh345CTz9zRiWzqWsdcRsviaLQcsbsUR0DveqVcrNNIMCq7xNdvm7nW2cCjJlUa/ZgW2Sxz+y
	woHfhtA/0vMhVDuHK3QI4y2YIGe0bd/9dHNdpJ6c9vgtNdzO5WcMxqzENs8plCtaISCg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQ669-00F70k-0j; Sun, 08 Nov 2026 17:50:29 +0100
Date: Sun, 8 Nov 2026 17:50:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: motorcomm: Free the MIB block on port
 teardown
Message-ID: <aaed4927-d124-438a-8526-2b8f51ca3732@lunn.ch>
References: <20261108101648.1308271-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108101648.1308271-1-mmyangfl@gmail.com>

> @@ -2006,12 +2006,11 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
>  	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
>  	struct yt921x_port *pp = &priv->ports[port];
>  	const struct yt921x_info *info = priv->info;
> -	struct device *dev = yt921x_priv_to_device(priv);
>  	struct yt921x_mib *pm = pp->mib;
>  	int res;
>  
>  	if (!pm && (BIT(port) & yt921x_info_ports_mask(info))) {
> -		pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
> +		pm = kvzalloc_obj(*pm);

Is the if (!pm still needed?

   Andrew
