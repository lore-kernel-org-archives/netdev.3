Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057E25785D;
	Tue, 29 Sep 2026 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640850; cv=none; b=YTCaGdXKYysHkk4l6CtenUh5rcnn/t+S6NivqJ+6YrxINc0/bzm/wGAOtYLFVhuJOvWE1kHyczi4xzX/bWXcKD7Tb5IdTNw8QLNEYaig5kUTtn5FU7K3lwzE1lQs3OgRE5kFvwM7+KnJ2WO4UJ64ZXDPCMIO3+NR8fpbbB4Mw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640850; c=relaxed/simple;
	bh=dxNEIVTpuReRGRri20iqvkWSqOx/RwAe6GJyg55ajAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJcZXYrnaaCQOseL5li7bIgdlEXjH/AuxRSzmU7FPgwxEIyde1xdAWROLxrQrHCksSrxzyWrsCnKX+eInFQ93h2g+s0kWWLuHfVV5WtzFFlOuUZt3OQj2sJrP2xmeuWua39mAe5uC8IEZ2kx9jt7Tw81XGbNkYAsKTgP7Qct2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H+wg8S7A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H+wg8S7A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KlU0pbLWi642tnb6CKJzr+NGygW1uFLNV/kyz5I3tIg=; b=H+wg8S7AxtUDPNebZrfUkj7QEa
	Fg0bXcWsn4hM+WWFZxP33cicv2FMOt8Qt5noNW4cXsh/YsVZoBwdmOV8YfMhfokhYKJa6Q2TvT4cf
	pdLTaK0NwLjxFeMIKBs0jW11c8pCvCH6Yr5uZPLrbSt2B8/SboPeSR3gkSKYQyU4IDLs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBLTo-007pKZ-R9; Tue, 29 Sep 2026 02:13:56 +0200
Date: Tue, 29 Sep 2026 02:13:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: dsa: qca8k: propagate MDIO errors
Message-ID: <f7889e9e-8ca8-47b1-b902-c31e7c016858@lunn.ch>
References: <20260928220629.238-1-yongzhao.derek@gmail.com>
 <20260928220629.238-2-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928220629.238-2-yongzhao.derek@gmail.com>

> @@ -818,7 +820,7 @@ qca8k_mdio_write(struct qca8k_priv *priv, int phy, int regnum, u16 data)
>  	struct mii_bus *bus = priv->bus;
>  	u16 r1, r2, page;
>  	u32 val;
> -	int ret;
> +	int ret, ret1;

Reverse Christmas tree.

Please check the rest of the patch, and the others in the series.


    Andrew

---
pw-bot: cr
