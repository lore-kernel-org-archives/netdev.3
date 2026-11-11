Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794441274;
	b=sBUbF3YemsPOZJtuXwGji4y90Xr5OJaPoGzki9EQsLiNQwwcSQmipoeqyWdNp0zsBNPs
	 3ZJ5vCqIUoerqz4dSH8X24Ca8aD++p25c6anWHdTEAPmNfhf0RY8EE6lcGyxUwyCEpIyY
	 KYVDHxEki427IOSOyqv2QRavrLtRAByWNOcwVF6JAM4lwKAA6sqNaPUU6Fa1muSMjerYe
	 DV0tdTox19nJIq5bgl8VfTVgks95hDepfx0BO1K9Xxqcbf9RycN2XPzCZS7HLbT1kI3sv
	 NKmewHCB8+w/tOEpF1lAkstBJCMjC6O9bjYe3amf0DhJkITx80eLkJTYm+2jj1aDyAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441274;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jGvFpDsz598JX1tRXTqbNVLCtafK4G/dmHbNByWRzkY=;
	b=rJwjnG/pFSIV0aEYsITUhsFnMXWxm4mmJ/YMb5JPDaBzSKMcglYbTFLv/WykPoBW4LGa
	 kj9N82htkTAlmzsQfgrYvTQeoz2qCucJ5zj8hc1NZbXkElQJ6HwtYc0Hkd0AsbWKtCoq8
	 0kmhTKQTonH51AdLvCizRnmCIWSGDCudpiE3wNjpAjUpwmi2xBjY8ZhcqKBw26Oc0bEBD
	 lMetMFHIqRsEtZiRl+Zcsyg2KQU5n3zzhb7P0jpz2UxSt7qLwwu/ZRIB9/NS4KQ9EcgAN
	 bRQJyFU/AShGfvDqeOzt6h+uKGtdM7pfywgjtNrCC+75VlSv+U1MwgDPgeaRMXOCF9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=AFkFNMTq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1D606A339;
	Wed, 11 Nov 2026 23:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E1D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=AFkFNMTq
ARC-Seal: i=1; a=rsa-sha256; t=1794441206; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=e7RVnaCvhoD/9oippd2IGtyP6w2g50/JUyV/VOGPkmXC47tOZmMwknBiCYeh5+/2prSpPVCGBP/JoxTjhJi2k2mjOSJ753yHsK5WqGbVxt2goc+D1vijFtaYKhLxbE1p8m5xBQp87Rnw9ds+dl2kkAb1hpuWypmj1qRmqZj7g/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794441206; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jGvFpDsz598JX1tRXTqbNVLCtafK4G/dmHbNByWRzkY=; 
	b=fKLp95xd/xUni1BBl97Ctd3K61CcUKlqKeuWO0vpkstuiMUIqGsZXXA5TMxyT2reYJVsRDMBOGQQtIEj3rNpVbFugHemuCeaQKhwIElciH6r9ileWALhO6sTRHtmLFotiB6aU+SWyGxfnc4GAlCo1udWnNPgli6brRNZacDqT84=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=AFkFNMTqWkB5Dz0mtDydGaCnJEop9b9YsAr3K8AAmmJWZRVdS/yxYRdJr9IVl7V7lKlbnAaf7mMciL+G1F6Kl4RvwRQnFDd5QbM/zUI7DMFaoWzC4HbKPdpgUa3qe3zEVDyoSR5/6ozJnsWAoHjWQXefrTCbODLE5Kt/hY+7aKA=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=jGvFpDsz598JX1tRXTqbNVLCtafK4G/dmHbNByWRzkY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 179444120369778.37346185581566;
	Thu, 12 Nov 2026 00:53:23 +0100 (CET)
Date: Thu, 12 Nov 2026 01:53:21 +0200
From: Igor Velkov <iav@iav.lv>
To: Haoning Cheng <Haoning.CHENG@cn.bosch.com>
Cc: Igor Velkov <iav@iav.lv>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Lukas Wunner <lukas@wunner.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wei Fang <wei.fang@nxp.com>,
 Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <opendmb@gmail.com>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/4] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
In-Reply-To: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
Message-ID: <20261112-phylib-v5-haoning-retest-1@iav.lv>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Haoning,

Thanks for testing v4. v5 changes patches 2-4 (freeing the interrupt,
a failed resume, the wakeup policy for MAC-managed PHYs), so I kept your
Tested-by on patch 1 only. Could you rerun your fec tests on v5?

Igor
