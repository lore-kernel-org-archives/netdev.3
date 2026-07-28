Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF83C3C10;
	Tue, 28 Jul 2026 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272256; cv=none; b=ha4qaTUHcHaSk6aUo5mg839jOP8PfoZtmCeCkDcDBreaHVUrEHCV+OR3bS3l5h7KLGcvPWzLVGgTtX/gBibhfkF8Fo49J2+bGmj6R41U1Ob0LY9qwIA3+CjIAVCsRhVLdCMNUMqTH/EwTwEYCoxQUD/SSmEquw0pO8tygTWIqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272256; c=relaxed/simple;
	bh=lg7FNxlYuK1FJK0igUpTsKSb59kQBrVYWJDr7HQ9XHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ4tD6W9ULLbCUtb/Kj6SMNCDkjXxDmQ0ZQoTVWdz34EyT4I1vkjV5TLp8+lUyN/Pbdv77xwx1ZSYEJaRbqlyY/3X1a6d/NAjgbBG6K3I3IalKTviutduApmEr4z7DtsGfOcjadvq3rPwRmjXmtSzlXZgSto1r06VgWGrXlvAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pl+pnjYY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pl+pnjYY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7pPCJpmxouqYb2+iO4LLS66Umd/QQeZr0uempkZHs5Y=; b=pl+pnjYYiKYC++aDrkiufkaS/F
	USyFANcNKazsHm1WMrEYn5mO7oKjGKBcNjVRUqNhd+SwqLrchSAaulh1Uibhbz9O8qAobeCdiZE2l
	vQLAmQ831jly0vEkuK+ZkOV8MBPHKluBiOJqT59AUYcEGhpPQPk4QxeiewK7jqG1Rpak=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1woorP-00EhKZ-F9; Tue, 28 Jul 2026 22:57:11 +0200
Date: Tue, 28 Jul 2026 22:57:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 1/3] net: dsa: mt7530: check bus->read() errors in
 the MDIO regmap backend
Message-ID: <c2ad091c-e594-436d-a245-9b3abf17de94@lunn.ch>
References: <cover.1785213071.git.daniel@makrotopia.org>
 <3c628e48276c2e5522c8795a6be60d11c7a76a7d.1785213071.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c628e48276c2e5522c8795a6be60d11c7a76a7d.1785213071.git.daniel@makrotopia.org>

On Tue, Jul 28, 2026 at 05:52:14AM +0100, Daniel Golle wrote:
> bus->read() returns a negative errno on failure, but
> mt7530_regmap_read() assigns it to a u16, truncating e.g. -ETIMEDOUT
> into 0xff92, and returns success. The garbage word is then consumed as
> register data, and read-modify-write cycles write it back to the
> switch. Check both reads and propagate their errors.
> 
> The same defect existed in mt7530_mii_read() since the driver was
> introduced and moved into the regmap backend unchanged.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
