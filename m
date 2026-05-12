Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361D306771;
	Tue, 12 May 2026 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589921; cv=none; b=jCJQBhdXvEALSo+URlnnqqRVkXuYLmlVgcTs5DRz8kSCcHhr+VW+bI6NMplQUHxCv/ZN+nmVEOP0Zopf68lFUEaLThtVWJQ7soAq2IIRgfJNnmeDUEDHFtoY2MKovnTEdnH1syMsIKjraXI1GvXiYtTQcoovQezAEDo3rzp4XVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589921; c=relaxed/simple;
	bh=tmvK7vJtyO1n9+p2FcXtRrzcyz5ZzQTpIe/CpyS/cZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEhExoFyWRNks5OIFY0rhYql+A2+yvT//mb7TZAk1NZ6uTyvYba6Vj7yO6ppvN7AHPfg3fCWkqvTDteM6Dn5dJADVF9V4W8l/IiEVTxCa7WTNUNR+0lZZmH6S+E+ZvWY7FZ2hwYNGGE5TD/j7tqRKBttJmgrZfTHsh3+2u3SbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EkZYEnIA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EkZYEnIA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jsPtOQasW8k+9b3C0qUS9XIReI7uglrW9r9rMSCGlSI=; b=EkZYEnIACoO8PCR1nfN/0mrknS
	d4yEdrGvi3V5zEiGicUtSSl1ErgX8NMVqUxzjjEH+hSAz4IuC6jHzrcFgoPk0uF86THCHvRrzphhc
	Ksw/vyi1uYxjfCGkED9Wwrx94Ac8shUmNWmQfQkrZ5yA+Vq5GmX+8AAaH4zUaE2HWB2U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMmTw-002Xth-CC; Tue, 12 May 2026 14:45:04 +0200
Date: Tue, 12 May 2026 14:45:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/6] net: phy: air_phy_lib: Factorize
 BuckPBus register accessors
Message-ID: <25aea102-5621-4274-bd0e-f938b68a6da1@lunn.ch>
References: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
 <20260512-add-airoha-an8801-support-v3-3-1edb34e363ae@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-add-airoha-an8801-support-v3-3-1edb34e363ae@collabora.com>

On Tue, May 12, 2026 at 06:33:20AM +0200, Louis-Alexis Eyraud wrote:
> In preparation of Airoha AN8801R PHY support, move the BuckPBus
> register accessors and definitions, present in air_en8811h driver,
> into the Airoha PHY shared code (air_phy_lib), so they will be usable
> by the new driver without duplicating them.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
