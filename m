Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD53FFAC6;
	Tue, 28 Jul 2026 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272376; cv=none; b=A1zF/Lh71uX/748nRzdsx2MaksJZQtPbc4/FMKBMlDscjNdMLyylFYNcX2FV5+YSOrP8U9qbfswROCCJbRErRfyLrUzZUKIF0MTSHljv3RPj6F8M60JQuoFV7joTMD/1USEXFhzVo4dKTF7U9WZRpEIQI7y4H+WOiOt4GMBABL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272376; c=relaxed/simple;
	bh=qJtQtq20/6GX5dweJZe+nfqgesGBGUtTQL1fChdNrRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxHljsieO5EY8ax07qqtmJMkcxSdnEupx94uL4qA6SwZL6ovgsUcvLj0jTJegeWwDOzrf0lYRAlGzo8YtIKMH+0JI0Lm595jA0lJ2vmV2Fzor0pn7yeR6g3pbqTDgXue8epTIcPQ3n4vtUUWj92HsYEyNP88UagfttBzMk5axLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J4rTOcH7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J4rTOcH7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yqFpRE1TaLcYQTYUmiej5bLJgJn3ouN/OqeUA5dEOaw=; b=J4rTOcH7idYaNPYf9IxBN9iBK1
	+pgSZX/JVqtfpxFdxcrnlkdTajLxcpWhUJTqpSdas8gQukLcT1Fh6EY8YRpiSEvXYz91uFzXI7DX1
	93tHrRWfSU80vrl/md7l3WXvPqVHeZUQBaydmyLI9tyBSsI6v46mNngkXDaDaBjX1c2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wootT-00EhMm-LT; Tue, 28 Jul 2026 22:59:19 +0200
Date: Tue, 28 Jul 2026 22:59:19 +0200
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
Subject: Re: [PATCH net 2/3] net: dsa: mt7530: error out on failed reads in
 ATC/VTCR command polling
Message-ID: <0c740a09-fd5f-4ca3-b940-9e034519304c@lunn.ch>
References: <cover.1785213071.git.daniel@makrotopia.org>
 <eea1d8f15c54375b3770c23e09fb3217df487169.1785213071.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea1d8f15c54375b3770c23e09fb3217df487169.1785213071.git.daniel@makrotopia.org>

On Tue, Jul 28, 2026 at 05:52:21AM +0100, Daniel Golle wrote:
> mt7530_fdb_cmd() and mt7530_vlan_cmd() poll the command register
> through a helper which returns 0 when the underlying read fails. A
> failed bus transaction thus clears ATC_BUSY/VTCR_BUSY and is treated
> as successful command completion, and the subsequent ATC_INVALID and
> VTCR_INVALID checks are defeated the same way.
> 
> Poll using regmap_read_poll_timeout(), which stops on read errors and
> propagates them, and check the completion status read as well. Take
> the MDIO bus lock across the sequence as the switch regmap is set up
> with locking disabled.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Fixes: 83163f7dca56 ("net: dsa: mediatek: add VLAN support for MT7530")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
