Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759704;
	b=0NHA/6xozdNQ0cicL94bf78rwBvp3fzR3n0Ctwer8t4+bicU6yWtehfhZbV931wkmYyh
	 RCd6bNEHpA4DJ6CGfMBlNomrVCdxcXEv0CX8/yfZMlc+vcfMJoNzDkfjDnqLS7D7ONTp9
	 fgzldeNj+cnBox2rXe2eXIpcsFr7Y7Mu1cHCuH1eXM9VbHWqHurFkmN7viHyAijoDQCXf
	 TGTqL2596EGZz2qGXB04ErMk6L7k/OVkqo+IbSrSuEzz4rhsCuedNjj6DGVJgMwEBK5q5
	 PNlPlR7BHdNVkIAFUPtWCZHJ41BhBTrJ0UEFnlv9jnh36cGLLMmYb4qW7dHp9T+Hdkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759704;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ZpM2gRFCcHI3bei5VEKrgg4awIGy/+ZVNWzYY+kxMro=;
	b=rikgKRJv2BQSQTsFx/Fyz0/wDzPGkbX5O47v0s8frX1XfUtXsV1PMllipgdxV6je1pD0
	 84BQEqoCyEe5ABmua7qOqS/kUVR6M4vTX6clBKSW1mdWaD0LG7CpkVN33qTfBL/POFXg9
	 fTLmeiZuSudkleG+hW7+aFvZcV1P9CPLFKjX6Ds36BIwXSQgomqonR9XVzZ9lG0tohjQj
	 AvgAKi4szSDbRS9ED5uisIEH3yFnzDJ6ISpwVVCULtfhzlZaswUNU/kkCzUTXDu2LaAyR
	 XL+lE1C8gvbrIfLhYBYG5axnjt/LtxttMNByliYy5pyRFfs0iWX+lfXz8ZL4fuNYuig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xk2RSuZD;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CA606A326;
	Wed,  4 Nov 2026 02:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D0CA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xk2RSuZD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZpM2gRFCcHI3bei5VEKrgg4awIGy/+ZVNWzYY+kxMro=; b=xk2RSuZDD1bsSm2PYNKuhnOj7w
	+xZ0o/4Sa6q8Zj3gpiPvAvllwEcheUISSlCRbBkL+p9eJEXG8KRTikVB/X8a8HnWQso1dlz2vdTT9
	ORYi2uPx/5e9qz0CLpGwUqjL0BCb5ydG3y4Hozd57IVoUf3TIHew0rrhG6h3JkmJAguY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOQpu-00EDna-3g; Wed, 04 Nov 2026 03:34:50 +0100
Date: Wed, 4 Nov 2026 03:34:50 +0100
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
Subject: Re: [PATCH net-next v4 3/6] net: phy: mediatek: generalize cal_cycle
 function for GE SoC
Message-ID: <d2c421e2-9e16-4f26-84be-06e5fc2c719d@lunn.ch>
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
 <20261103221439.30502-4-ansuelsmth@gmail.com>
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
In-Reply-To: <20261103221439.30502-4-ansuelsmth@gmail.com>

On Tue, Nov 03, 2026 at 11:14:34PM +0100, Christian Marangi wrote:
> In preparation for support of special Software Calibration for Airoha PHY,
> it's needed to generalize the cal_cycle function as Airoha needs only
> part of its logic (the wait logic) to complete a calibration cycle.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
