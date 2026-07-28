Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6F408018;
	Tue, 28 Jul 2026 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272451; cv=none; b=ryxb+oIR/+Aq6pf6fZSEC2vFSpJWIQb9klNnGpL4kLsZPGAf+TLsr5PzLgVy/IAXJ/8FUydumrn1+Sm2Wg4H8KI75R/rTbqsmAX29TL6g0boLKtxRYNY0ge3P9hbIWuOZtndbQuqk9K+1vknObARXyj8bDsIcmvtTRmPc/a/Tuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272451; c=relaxed/simple;
	bh=Poc44Rbv8x88TO3VazvB+j28VIvQpzzydpx2gMQ7r3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3iSEWFWCWzPVStK79Rf/HccvncAom/UHv1KO3AZyOvkQPrrCYADdxVWK3j/q63DIiUeaQ+V8AjAMtOFOBpuT3IdMKn65aru+glYkfVayQs12qTVcUsktBN8rAp+OH8dwCyx11DpKXtkJ6AEKxXkm0ZtDL1QoZGeI5GP2FmUWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nXFp35a8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nXFp35a8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HfhT+ID3fPeDtksWdXaPKj48BAsIgjyAU5KW0xjSCGE=; b=nXFp35a8/fHtQEC4CyFsp5EGXl
	KaWzXbyWojsL2GTsNFuUJSn/UnkBPcJcgF34T2AqKNObB0cSvLg8IC2vDqwE5KJBUsimPcNBARSmG
	qdwvZBMj4u+O4XGIZKU41rat3viDuejjTSQjLHtFOazfbcGMqCBD9UMJefuWJeami21o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1woouc-00EhO7-Ij; Tue, 28 Jul 2026 23:00:30 +0200
Date: Tue, 28 Jul 2026 23:00:30 +0200
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
Subject: Re: [PATCH net 3/3] net: dsa: mt7530: error out on failed reads in
 MT7531 PHY polling
Message-ID: <5f305d2f-7f5a-46b6-be73-2ab52f4ec016@lunn.ch>
References: <cover.1785213071.git.daniel@makrotopia.org>
 <79e85d68d210cc37342978171aa6432aa2954333.1785213071.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e85d68d210cc37342978171aa6432aa2954333.1785213071.git.daniel@makrotopia.org>

On Tue, Jul 28, 2026 at 05:52:29AM +0100, Daniel Golle wrote:
> The MT7531 indirect PHY access functions poll MT7531_PHY_IAC through
> a helper which returns 0 when the underlying read fails, so a failed
> bus transaction clears MT7531_PHY_ACS_ST and the access carries on,
> returning garbage PHY register data to phylib.
> 
> Poll using regmap_read_poll_timeout(), which stops on read errors and
> propagates them. These functions hold the MDIO bus lock across the
> whole sequence, so the unlocked regmap accesses remain correct. Remove
> the now-unused _mt7530_unlocked_read().
> 
> Fixes: c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
