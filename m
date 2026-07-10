Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3119DF4F;
	Fri, 10 Jul 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690541; cv=none; b=s5ntTcNIU8TziYy/ylJiQY9zdZZd5oAF7ksWI5bbY8dtMk8qVa3rbsh3Y3fZnmg22QmV9hwzEjfLJBFbt4BXCf6/aFFORSc/S9xmk4rnFqEAVzlgMUDEoes2cYzfFAeKmukl3gexD1cNZD5myLJT+GXSkjvKYeiweMq3rq1+c9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690541; c=relaxed/simple;
	bh=cOGvnj5Q/utsbCzda0NpafgVuUu/B4SczZbnDIHiPWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIWh07aak5jmzjueXe85MVrkINlUd735PBTpOtixLojEYMmfHYBRJZo8+u5JrlSDM0V1Vc+hZO83KBhsrFMgKUhyFYx5s23h+1wwrz+GadGGlmw6ui4SkqR7dWTLTW/X2Vngb79j/6xJC+G0mCawQ3lD9zsfN0QlaWNxgeqBDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QG36ZvFH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QG36ZvFH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1zpxir8kPjpVYUNzqhODBD4/GTqr/OadsQZ2UHLHZvw=; b=QG
	36ZvFHiIJjY4iZpgzBPn4sD/3LNBfbSrTlVSxZguEOBGvjVpJsLEoDeLwaWS0FFf7i06H6y/X+s9M
	vTI4ayoY6WKZOW57/dqwlNzmLGoFWmomn+GR7HvTqCLovAZM/F29KvDcyNW/ixt19o+tCWH4KW2+G
	AQlQYrdWrrTFmV0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiBO4-00BeAD-W4; Fri, 10 Jul 2026 15:35:28 +0200
Date: Fri, 10 Jul 2026 15:35:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Biao Huang <biao.huang@mediatek.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 1/6] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
Message-ID: <b7dc2135-e6c8-4b1d-a03b-c5258cbd7dc8@lunn.ch>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
 <20260707-dwmac-mediatek-mt8189-v1-1-17f345eaaca3@collabora.com>
 <b810b9cd-8f5e-4c9d-8496-908aae55dac1@lunn.ch>
 <8304b0a704c8db697767584b8c34388f07ba401d.camel@collabora.com>
 <6ea11726-8d50-411e-afab-da346e09ab9b@lunn.ch>
 <f85e08cf5e119e30ab4513e78ffa833fbe0832b7.camel@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f85e08cf5e119e30ab4513e78ffa833fbe0832b7.camel@collabora.com>

> I don't. 
> All the MTK Genio boards (510, 520, 720, 1200 EVK) I have are using
> RGMII only.
> 
> > Ideally, for a new device, we should not repeat past errors.
> 
> So, do you want I remove this clock from mt8189 clocks list for v2?

Yes, lets remove it, until somebody actually has an RMII device, and
we can figure out the correct way to do it.

   Andrew
