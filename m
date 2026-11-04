Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759641;
	b=pFs7BmvDa2HRCtiY0jx4xkobFpVTKpyyU9bFRqeE4A+soquFDQg1HYfxC7nAgDD6nYlD
	 h4JRPnAhm5cPv2PjR4MhUw/Ghm3xrJlinWPFy1QGKLlMcHi5VicYp+g5mhNKwXFyd0wIC
	 LJaR66ltbMkhyyNhd0nUpgpTlw5kxfUW0KoJZ6fAKu+wH85Nnn1StkipEdBvKYE1MpW6m
	 7gRDg+/8Oo5CtIs2GNGoG/9OgPUo0+syE/hyfzo2ghDN6vuzMW04ZvomtW+qzNYnSlA2D
	 8GEW0pygZIirABFzGmztutE2LRVxm93zUGoEPvEGM0++yUMo71ulD0WtavwrlDZ8Csw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759641;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=UngWXeSeiFLVAfajmqVKU8517kJO/u7bQBZMSqnjHsI=;
	b=dDToMutvcFJFJFU4cAcydAMyGrabJb5MMvCyYHoe/prWJpY183/pLABEKuTLlKCLzVH3
	 GbtM5ntfDJP5Xex0h2L3kEKVfRO1LA6VFLxuVBzjFilXhbDqWcJ8kMPRXLtdoIql06QqE
	 o73iZGbXx0Ay3LDoyGc8zxHsV3tKd5mKIiPlwUh+y5U5Wn/6yUun21PkO3DulL90AQPep
	 gXa6X1RHXTmsTtSseGcasfSXXn0ktUhxhMvR1tLhoNKY29dsS17z4feGtUv90CM8l8n5C
	 ZSTj2yVrpcbjVca7iqGJciFmliqzr/PcXR87P/s5c+yXp4RFiOi8/z/Gys7/QzrXf7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=MFhupODo;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DC606A32D;
	Wed,  4 Nov 2026 02:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF5DC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=MFhupODo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UngWXeSeiFLVAfajmqVKU8517kJO/u7bQBZMSqnjHsI=; b=MFhupODoadThu58oBxVFxQ34Wv
	kJ99xDxkXM9iKu6wl2wOoczIPJV+t0RjQQ6YZT/+j1Lsb/SyRsm95imnsq2kpDbrrhjRGC/bJB/3W
	UJzWDMZJIk5QXLk9HGwV4h5bcc/J7x7Bi1vukK8ak0XON5eesfvApAlyyHyLroTeeafE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOQor-00EDm8-F6; Wed, 04 Nov 2026 03:33:45 +0100
Date: Wed, 4 Nov 2026 03:33:45 +0100
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
Subject: Re: [PATCH net-next v4 2/6] net: phy: mediatek: move MTK GE SoC
 registers define to dedicated header
Message-ID: <fd99847d-e7ee-4327-8eb3-8336eb7d967b@lunn.ch>
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
 <20261103221439.30502-3-ansuelsmth@gmail.com>
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
In-Reply-To: <20261103221439.30502-3-ansuelsmth@gmail.com>

On Tue, Nov 03, 2026 at 11:14:33PM +0100, Christian Marangi wrote:
> In preparation for support of special Software Calibration for Airoha
> PHY, move the MTK GE SoC registers define to a dedicated header.
> 
> This is to keep cleaner code and permit sharing these define in multiple
> source code.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
