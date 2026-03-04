Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53DD384244;
	Wed,  4 Mar 2026 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663362; cv=none; b=mzuEVEC59IUWI8DTe5IBtrz25TAdxgonITjuEHXE6U2+p/mH2L7kfsXpxkwEBw3eCCiDBjdFy1eMEFsowyfo4tMDcIICnx0knyESUC82qg0dZH58gau5h0wDNaGZlmQ8y+AoF7jdrWmVnBzv+frshisUnUJNEQsc42dNx13jRxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663362; c=relaxed/simple;
	bh=hP+D4QE9xksD/WvSztrk2ZIAVMy+HTU4vrPxs7NRpXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxSrW6OR7bN5YRwVsmzcZc0VdBxLRGfBiGW0T8nT45RxUnMxJcIF6k85a4nfL/ZcYiOH2oW3HLFy8BC/MUW5ZJRKQ6vhUcLNbzIKu9UCDPKWXCEEsLN7tQXmGfTW+ptfAkr5dHrCEFlaQSOuChXx/er4ny341XL7rSWypFDfRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n2HElQtP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n2HElQtP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ndwHByA9+rPpcw7aenooep5yaqS0L412XpVw3mJ5S2Y=; b=n2HElQtP92EIhUCnCa6CVlf3pY
	qxyCOpqdiH2QBUshhls/62Vq1l7ycd4FOoPGXh2Vb/+9jUbdsHKLKOCqrX5QRHHAXc1928LyimG1A
	3o2UK3eYpUmBdotImYqAhQ5xtRaVAPnyrQ1X8+1isNr0xbZO1dN05ATmXsjomU9lYL2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxuiH-00ABPT-Mx; Wed, 04 Mar 2026 23:29:05 +0100
Date: Wed, 4 Mar 2026 23:29:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	heiko@sntech.de, romain.perier@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: arc: fix use-after-free in probe error
 path
Message-ID: <b6ac1471-e33a-41d3-9e67-e6463612f05b@lunn.ch>
References: <20260304025303.145493-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304025303.145493-1-fanwu01@zju.edu.cn>

On Wed, Mar 04, 2026 at 02:53:03AM +0000, Fan Wu wrote:
> The arc_emac_probe() function calls devm_request_irq() with the
> net_device as the dev_id. However, in the error path of
> emac_rockchip_probe(), free_netdev(ndev) is called before the devm
> cleanup happens. This creates a race window where an interrupt can
> fire and the ISR (arc_emac_intr) will access the already freed
> net_device structure.

It looks like interrupts are only enabled in arc_emac_open(). Have you
seen interrupts before this?

     Andrew
