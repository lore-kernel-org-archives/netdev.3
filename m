Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759606;
	b=5jU7KYjlXRadaBKskngrwQ3TN/US0u10nHPRae2rouMrM7Z1PU75HbhrCgHqOH3jxzEc
	 HpLRdPXWqEXj3dv7Q0Qe8y6JBTeRGmlqtYS3Kl/HdEaCRa6O13WTpaqCUsHM+q3EtewQ0
	 nhMGdsFE5QNT9iSmZl3F96h01s8LwXvgWiC0TANH6plizyO8bJGpcxFOZBoa+xYJ4jqbZ
	 AilysAGIR4g1AFuBI8U2VzY/gYDMV7SIxxceaPVqyLyw3oXuI/I48VrqdPtt0G0NBlWKR
	 wM94Em5vaCa6ewlLJHhiicvVfzaT0VPh0fD0vw+ChMlin8OK/MhKz8JL6hJiZUhIB6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759606;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=44sRRDwl9anK1R2znFsd4YZuaIspdZA1Io6aW5ME0gY=;
	b=mHoMCdFkFfl4iNWM6iC7llWGZFlaKkePVFsQlLKJXOw0WMTPOBlbiVOnxtRy4KMk9f3D
	 JZMCyvRLDTye2gRcEKhs8RmVYljlcZlSjN649agxX9nQKPJ1CGiKhnmjX0E7YcPsI5HA6
	 jA9931HCuewm5UK+zIVJ4JDhc8ecb/CCnrUYxRh4J8b/OaX10wFfwLxDRy7wcIQKWBQaL
	 +tw8mLmhO0HuJvF0hOcnSaSDjyXNhDGvFPmp3PyfGc8ZRcwXHfLu4fqMixORBnPwiegv2
	 k21qhMyUW9C6PXE9b3AkqLL6hgJQCUM1383IxFBEmfsIVE6TQ9SqqsrS5dBtmJryy3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uTbK0dvH;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0294606A31B;
	Wed,  4 Nov 2026 02:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0294606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uTbK0dvH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=44sRRDwl9anK1R2znFsd4YZuaIspdZA1Io6aW5ME0gY=; b=uTbK0dvHx1D0gtV0VNBn+6tklF
	ucpF4DcfXrfJDac/aQj6Q7BNa56YLZ/ch5eoGtbFH6MnvMGztsQtkDhqrNyMx26aqu1SqdDs1T/GY
	kVwjaFCvJvFiZcnbqmnkmiDtEDWaDPW1bzhWRvoOTpTU+quRF7MJynsYBjF4iRCg/xlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOQny-00EDkm-4R; Wed, 04 Nov 2026 03:32:50 +0100
Date: Wed, 4 Nov 2026 03:32:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	Ahmed Naseef <naseefkm@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 1/6] net: phy: mediatek: export __mtk_tr_write
Message-ID: <556b6194-4d03-4ef3-b9b1-8c256d42130a@lunn.ch>
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
 <20261103221439.30502-2-ansuelsmth@gmail.com>
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
In-Reply-To: <20261103221439.30502-2-ansuelsmth@gmail.com>

On Tue, Nov 03, 2026 at 11:14:32PM +0100, Christian Marangi wrote:
> Export __mtk_tr_write to directly write to debug register.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
