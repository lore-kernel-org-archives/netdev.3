Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A241322D;
	Wed, 21 Jan 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002231; cv=none; b=sXGJa0q1ZLGOzOJrt6IWRQy9TBm6xVC6zXn/I+EYAWOuyZyYbOSJB5UmM8SKB+e6f9F6DjWHBWGpo/KmS37E064lCKMnUHxU2O3V5KhvVliHgGxNcOfvxluDicgQppLcUk9ug+zXWyq4BXOupaUJDTD2PxDDy94tY3mFrSI9giY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002231; c=relaxed/simple;
	bh=tnpatR80AdYbdh4qpMuKqyLO03x9xSRyZzw/5Mp78wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfbT4QpHCykC2HSImyqhfrRnZpwJt4DxWqvRHj4p0wkbPbho/1CG6LqZY9/2yXovs13QscffxpKaquLNOCPeNM+WXNn79v2tYgTiFX4WQxQnd6ufEriVlswv3w3zHevR/AvCZVwqebiBMm/e4t52U694BW13/ZzAs9ZddbHk6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GEjxzqob; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GEjxzqob"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9stp7G8+jx+wDU2rs7p5oT5keVe5sNUsqmxQNNXqt2w=; b=GEjxzqobru254gC3J7+TDzCEDi
	i2iijfCHprMNPB6IdW95h8Zz5cfA/ixdbgtBwxuHqSrs15CkzwezfSQbSoraSwhTuXvPAtEQ/hXSp
	g6ZDcACxw2o8ajaSeANwxKCLgnzBThePbDbZhDBB/cgYK1vP9DDfA/imJKzjmf2Y7+Hw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viYHs-003p2V-MT; Wed, 21 Jan 2026 14:30:20 +0100
Date: Wed, 21 Jan 2026 14:30:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: ethernet: litex: use device pointer
 to simplify code.
Message-ID: <17e6bdc4-a38a-4486-a92b-bf9a1f9a4f8a@lunn.ch>
References: <20260119040446.741970-1-inochiama@gmail.com>
 <20260119040446.741970-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119040446.741970-3-inochiama@gmail.com>

> -	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
> -						      struct pcpu_sw_netstats);
> +	netdev->tstats = devm_netdev_alloc_pcpu_stats(dev, struct pcpu_sw_netstats);

Is that longer than 80 characters? netdev keeps with the lower limit.

Otherwise

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
