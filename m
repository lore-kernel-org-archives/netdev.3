Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6253C3E0245;
	Mon, 14 Sep 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405997; cv=none; b=f3KrTqrFlf8sml4omc5hTkr4l7jNfxYzUiaGSIPKaozRfIy1FwtbaffGvZ9AxGV5ZR9fVfJIU5nDNWYGaoh0mjFwKWgTLB6uLvrckGaFnvKvZJJ1TcD8Ybeqo9kYN+f9OBhn2N8PwAvm6rD5aXVzSXE6GKp9GOHw+cXUD06fQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405997; c=relaxed/simple;
	bh=7w3ga8RDZTZh9nq0nX1AMJzLMMuPYHm6vv1VKLt9I+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MctNmu6WqRaIhIXnMagbKXaDaFRk+1EVKkp7fzLSfqwkHGh/dOv378CPgpy0cfxyZ3kxQU8z/PfPBkWNNk2ldBGK8Ej4lBoyRJPYYRSZuwCqbVsy6IYEARyZai8qOtyraec5+1JURxqAL0UA9bSskgfJgWfihwRhSKhd3LNkfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yMUzUgG8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yMUzUgG8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2OrWTkDAaq2ZS60WCcmaZJ0cvaeS8WVVM5bplKuJDVY=; b=yMUzUgG8tNvmakPvYdwEQ4BzK/
	8XqyWcvzgRMHYg1JEyXFnniP2Y74PrFk/S2oYAgPjBCzIAdDnlMsALIFm3BTiK4vrQUJ8UpZBoSd2
	tYgE7SWQzvI7P66plpJi6Vmw0I8F3n4yuV/6qvj0lMNLhD/5gnwIgE6ClnP8vIy6D9nE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6AEr-0057LP-Fg; Mon, 14 Sep 2026 19:13:05 +0200
Date: Mon, 14 Sep 2026 19:13:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: khendry@reliablecontrols.com
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] net: pcs: rzn1-miic: Fix config array
 initialization
Message-ID: <c2f3de30-4dea-458c-b9db-ce45aa3d1bbe@lunn.ch>
References: <20260914-rzn1-miic-fix-array-v4-0-069112feec86@reliablecontrols.com>
 <20260914-rzn1-miic-fix-array-v4-1-069112feec86@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-rzn1-miic-fix-array-v4-1-069112feec86@reliablecontrols.com>

On Mon, Sep 14, 2026 at 09:41:00AM -0700, Kyle Hendry via B4 Relay wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
> 
> Fix memset parameters to initialize the entire DT value array
> 
> Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data to SoC-specific struct")
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
