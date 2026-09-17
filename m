Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06025A5121;
	Thu, 17 Sep 2026 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657020; cv=none; b=a/xP47xt9RkBhNqZ+SXlhlPxpKZTko5SAh/w1QHqiCZN80iM1ZjSACndUCY+1rV9RXhDR9YRzhxIHdwDu41re7ZMHj+KFpb4oWtDXRnp3V5i5prMDf6MfCZHXZVk1VTMRBeyKs+eIRRX1YldUzuwxR9mggl8NuGa0nIjoYPK3wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657020; c=relaxed/simple;
	bh=GbWu6D//pleUKG4KsB5vWUuB7L5XpKl8uA++urGCcvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAroqTTNSMxkY0gMB7VdxCnGfV9lGKXLCxUN80AG32jBM+IpumhdNTxX7TxLLFmqa/b2yLZDXaWzKtTo5rVM0u8WDXfUFpmSji3So9tExDNVeNQjArF3yi9anbE0wKjk6602BzahvFkrphAhIS4zNKGZAsJ5UQkY+UVq9jSknj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v7DAdW/g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v7DAdW/g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2CCjRSePQK87rby+Jo+8UB7gqMUek6+WZFLJ8cqsPxc=; b=v7DAdW/grCSGofGdk47k0YE6TF
	VrgoTQek/r/FKfCyEHbAvXKc/ou8tbRAekvDuvJri0SHr5r2mbGo27ZpkXX4jb//NrCyncYwLIvBf
	oFy3slC3zawvslDoI9jiQkkngI81GAkTpcJ19ZyCoev+mr/GMw9K4lKygYKsNY87b3zU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7DXM-005hBY-O1; Thu, 17 Sep 2026 16:56:32 +0200
Date: Thu, 17 Sep 2026 16:56:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net-next] net: fec_mpc52xx: remove dead resource size
 check
Message-ID: <1ce3192c-d052-4936-9567-8a1d9b13f54a@lunn.ch>
References: <20260916223228.271815-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916223228.271815-1-rosenp@gmail.com>

On Wed, Sep 16, 2026 at 03:32:28PM -0700, Rosen Penev wrote:
> The check bails out if the FEC register resource is smaller than
> sizeof(struct mpc52xx_fec), but every in-tree device tree describes
> the FEC node as a 0x400 byte region, which is exactly the size of the
> struct, so the condition can never be true.

We generally don't fully trust DT blobs.

Does this test do any actual harm in its current state?
Why remove it?

	Andrew
