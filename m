Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33618404BE1;
	Mon, 15 Jun 2026 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537610; cv=none; b=UTgj/1RsnPgpvWwHF71kBZT1xp8lgFjL/9G7iuPGlam5fAD3Ww3NXWhVjW93ZdI8D3eBnqH23vMpHCTMcA/nwFvf8ne0RNh/nFewP8Swh5+OtEmJUc5p3Eo5f+gHu4fd8f5hu05doY3nNY8t7lysCvTOrWD6EXrpCeSUfWXTVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537610; c=relaxed/simple;
	bh=l1uB0EgEm3OBElTfRhmlX1HSd+akqf6wyzQgXqBCLOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKet70tWkGf5HK+zJILSCoCwHAGqDa86DsmbaK8RU2RSemnrj8J7hU0Mcl7Mmti9UTZtsWmNxpsTPyGc7JdodMsiYUUIUnjLTVP7MFYDTPEzXMLEccMP5/PSrWmgHZCqeWljRFt8hW2naE7nbmllM5bq6fVAuxxMrdjlysaH46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wZ9JP-000000004Nf-1xqC;
	Mon, 15 Jun 2026 15:33:19 +0000
Date: Mon, 15 Jun 2026 16:33:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix supported_interface
 set after phylink_create
Message-ID: <ajAbPJU70G4kGw67@makrotopia.org>
References: <20260615151106.15438-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615151106.15438-1-ansuelsmth@gmail.com>

On Mon, Jun 15, 2026 at 05:11:00PM +0200, Christian Marangi wrote:
> Everything configured in phylink_config it's assumed to be set before
> calling phylink_create() to permit correct parsing of all the different
> modes and capabilities.
> 
> Commit 51cf06ddafc9 ("net: ethernet: mtk_eth_soc: add support for MT7988
> internal 2.5G PHY") while introducing support for 2.5G phy for MT7988,
> probably due to an auto-rebase, placed the configuration of the INTERNAL
> interface mode for the supported_interfaces for phylink_config right after
> phylink_create() introducing a possible problem with supported interfaces
> parsing.
> 
> While this doesn't currently create any problem/bug, move setting this bit
> before phylink_create() to prevent any possible regression in future code
> change in phylink core.
> 
> Fixes: 51cf06ddafc9 ("net: ethernet: mtk_eth_soc: add support for MT7988 internal 2.5G PHY")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

As no user-visible bug surfaces because of that it is questionable though if
the Fixes:-tag is justified.
