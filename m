Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47A2E6CC5;
	Thu, 22 Jan 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087869; cv=none; b=cIPEpNTHPQMGRGiL4F77OiYMzGoc+A9mYnv/XsAsP7ULjNLQbfLqjSm/R7EzWCEmdMnLcb3awwshjkDYQxMSEXv1ZZtZsyhzM4ha4jW3d0z9AeKqs04GSIjUzXjJj527pBWSw14tG/TydCD1gbzp2wfCIw2YdDVQn+33tcSN1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087869; c=relaxed/simple;
	bh=E8ujsvvpS9e727bWjaY1C7H9rvr65j2aOHT/wGSWqw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8DtuuJ+nmMdv2PhTO05nrDdhjTrJNJ6MFm1+cs+dMbh1uZa3FXD90nRmiGmM3PrxY66+oi7HHnYq0QNfP7v5nT+Kf7w6t6w3CB5zT6ARlAV+3nusLxEAUtydIdiRfmpL8nwzXPKPYuWXJyXuttU8OCzn/0tLts7C6pwIQFMu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2qRBYCS1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2qRBYCS1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gmRCqXSnQWS9fdVWGswfFh7XixYJdcyajsnRAYEfYcw=; b=2qRBYCS1v/AwxR1+18R8KWM/dI
	8+tL0g4HLaPmUnaHbJUVHROgo/hWpRtJnqf8Q6x4MQvFWfh57Xn95ciC9qV5itRJ1fW8VTQ64nQTe
	nrcgNkKfgr0Xf7o3SdRVd6RamysgcezF9Bl0DjVjgDGj5j+FBWeKrUg4pymObHBMojqw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viuZ3-003yOv-DK; Thu, 22 Jan 2026 14:17:33 +0100
Date: Thu, 22 Jan 2026 14:17:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Yixun Lan <dlan@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] net: spacemit: display phy driver information
Message-ID: <b4e0b1d2-cd6d-40f3-89fc-c1bd41c82480@lunn.ch>
References: <20260122080001.73921-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122080001.73921-1-amadeus@jmu.edu.cn>

On Thu, Jan 22, 2026 at 04:00:01PM +0800, Chukun Pan wrote:
> Print the PHY driver used and interrupt status after connection.

The standard way to do this is call phy_attached_info(). Is it missing
some information you need?

    Andrew

---
pw-bot: cr
