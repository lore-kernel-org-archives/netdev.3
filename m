Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E33590AE;
	Sun, 27 Sep 2026 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535006; cv=none; b=eSfJjtTIxGFnkjpBveejbwMVBe9k6kPznQ1X71NWZk99L8vdq54wtR1udh3uloGfYrsEvh5G+ZgkZt9F4ML9Z5CmXzTvMMzj7GbGJjkMleQxmxPzdierQPM2MxtoJKpCH1HqtDTmLlBSMRZx4ZlwMnc01sHv7bMZzeiNOgxdeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535006; c=relaxed/simple;
	bh=ZDe/vfYFr60ID6CUjRuDiDx+zIYLf7EWijGTxdOmaI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvXO5VuXU6RFLK6vEKtLUsCWL3H6xugC/MUJvdnwonUtT5DzmuRXgN+ODamJNLCcv2AThFvVuVOhCyvs8LfU5bC8w7j51dT7r0ny1SmwE5cZQtiVvM+GplB/l1GRRJEPr2yzVd7/zziUaa4yWYQ5APeoJ+JKstM7VJzz2luolIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h9OMYNe7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h9OMYNe7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xkk0G43Izi62IE63Oro94rMuWBFwgmiIIxcAiWI1GAs=; b=h9OMYNe7Ltfvsdqcsk/z4jwILI
	7CCnze8Cq85kzyOo59dfzepQXnK6B8VKa9SuKf3NBWGQQth+0WXGcxVd8KzGqtDT7t+ro7lBD5oCy
	WjJb3dKWnPPHmhJLuEcpZ0mRB6pRqJWyNsglgP6Gvr8GJVWY2ahIoOmuqziSj3T89cy0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAtwd-007YOY-TK; Sun, 27 Sep 2026 20:49:51 +0200
Date: Sun, 27 Sep 2026 20:49:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v23 6/9] net: dsa: tag_mtk: add Airoha variant
 usage of this TAG
Message-ID: <0ab0b856-3397-4e59-9008-a3b4d8fb4d48@lunn.ch>
References: <20260925182435.21207-1-ansuelsmth@gmail.com>
 <20260925182435.21207-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925182435.21207-7-ansuelsmth@gmail.com>

On Fri, Sep 25, 2026 at 08:24:28PM +0200, Christian Marangi wrote:
> Add variant of the MTK TAG for Airoha Switch and comments about difference
> between Airoha AN8855 and Mediatek tag bitmap.
> 
> Airoha AN8855 doesn't support controlling SA learning and Leaky VLAN
> from tag. Although these bits are not used (and even not defined for
> Leaky VLAN), it's worth to add comments for these difference to prevent
> any kind of regression in the future if ever these bits will be used.
> 
> Rework the makefile, config and tag driver to better report to
> external tool (like libpcap) the usage of this variant with a dedicated
> "Airoha" name.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
