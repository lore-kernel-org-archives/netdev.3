Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BF493636;
	Sat, 22 Aug 2026 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787419834; cv=none; b=G+ubeBYz1om3H9dfksjYM+l30qZq2X5+9cCkFFqMsvH2CG7m3RnCYBTKyoL22wsVsPIDe7Xu+Z6XDbSyBt8HnDkvAkO873nSvveFo9OAyU2mPmN+Ix2jHMlS2rcqvWyxh6RFODcSfa0uENylzrGoYUfkPBoDFUdrX1qvseePawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787419834; c=relaxed/simple;
	bh=ilXRyyPepSfCs5KePItU5VWlcXkmgIW85riIzKWvsmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fupl9LGaDWMBHywuTHrmP5ApanD6Pg9fNdHf5PfrBBYtIOtyGWpQasDxyNkMltdHPs2TvycUg5UrzPWjOisvaRHZtAoJtWFFLBrRe3kWktCYIhDAyMTtM9pXt9p3Mt0mucEGHwRcMrWCG504Aser9NLAg85qzmDxCpPjF9WmdNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OiC5shAI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OiC5shAI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x6Z0v5LOtV4HD1MxB1uouNNJOqh6vVSdo9Um1I1YBqo=; b=OiC5shAIn0NIaaE3xcUTgYORcB
	PCWQ0dJ3BmCg0EPkfds8UdjuV7LLkLE9LbxMcyJj39UpVyLnxoSLmruEI+CqhzJ7lOanhd8X0GFYJ
	h6yO35yCBBSmx+SrzyxWQu9Y2FSvwjRWjUO/LiwtEu0imU9HJ7ze4wVakkzt+rBZRyYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wxpXt-0012x1-Vq; Sat, 22 Aug 2026 19:30:17 +0200
Date: Sat, 22 Aug 2026 19:30:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phylink: unwind the PHY binding when
 bringup fails late
Message-ID: <7da05cd4-be4c-499a-ac90-2add64e48b92@lunn.ch>
References: <20260822155259.87146-1-f@lex.la>
 <20260822155259.87146-2-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822155259.87146-2-f@lex.la>

> +	if (ret) {
> +		mutex_lock(&pl->phydev_mutex);
> +		mutex_lock(&phy->lock);
> +		mutex_lock(&pl->state_mutex);
> +		pl->phydev = NULL;
> +		pl->phy_enable_tx_lpi = false;
> +		pl->mac_tx_clk_stop = false;
> +		mutex_unlock(&pl->state_mutex);
> +		mutex_unlock(&phy->lock);
> +		mutex_unlock(&pl->phydev_mutex);
> +	}

This is the same as the inner part of phylink_disconnect_phy(). Maybe
pull it out into a helper?

     Andrew
