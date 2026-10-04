Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388F3921CD;
	Sun,  4 Oct 2026 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122076; cv=none; b=s3UOdvIfLi5ph3FEt/WHCYv7OqtdjgpNHJKS233/s6O5w12EHRZGYaqxBnpNfbQQen3J4jFSFM1k4y/V3kYQM5mO8YJH788892qiH7qc4Wq+yUgJq0eJ056WlNVkgOFd+nRzwFlGGGVdGW4vh2uFCKKYbtHM97GSfMj0JgL9vFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122076; c=relaxed/simple;
	bh=aP8VWUv1kCe1vrsgTRPx64nTELQId9+Qu2stdec1QSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFCeJJk0JkdZx31DK/r2VwyYUL3M4W0xifTZ4ApMR9o/aj6jeAkaKzicRqfwowk0jSFjRCurpXPLy8rvHx5M14TP9C8ZtGh+q6pt/2mViVI5iEJnp4TPEIdRfTzeMntjrVAAhAIdexHriL7kLKmqLpNi/KLNbl5o8LN1W01mcgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CsyBzzTC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CsyBzzTC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KcYYYuW0cgEhfjXo9Dg+wnV+YtAbDy/DnO/i3BOzLQQ=; b=CsyBzzTChX2YTHXA14DfokLe9C
	k0DbhSU9goyC3/qKgzXunCRfhWK6BBS9WVxCCrkl2sJmuzQGLH3mAb5yj7TOstpAgnHfGe+WGp+U6
	w9P9nePxtm8G/nfE2Lgcjyo8QNeZMQy159+n3zFziFPq/lspyp3fI9QpxUPps2/2jMrU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDMfM-008su9-Jr; Sun, 04 Oct 2026 15:54:12 +0200
Date: Sun, 4 Oct 2026 15:54:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: allow stopping a suspended instance
Message-ID: <04e29fa0-3ff9-4248-bfe1-87dfe8ce3ec3@lunn.ch>
References: <20261001-submit-phylink-suspended-stop-v1-v1-1-0669fdb4a93b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-submit-phylink-suspended-stop-v1-v1-1-0669fdb4a93b@gmail.com>

On Thu, Oct 01, 2026 at 01:24:53AM -0600, James Hilliard wrote:
> After a failed MAC resume, a driver must be able to stop phylink without
> resuming it and reconfiguring the failed MAC.

This is adding a lot of complexity, for an edge case, which i don't
particularly like.

In your case, why is resume failing?

   Andrew
