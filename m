Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134853D3CE3;
	Tue, 23 Jun 2026 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213906; cv=none; b=VyKWeniMFAzHg3spORpfnabpdOl9w4/y0nAxXQ7ezfyrBKmekaVB/7d99pEgxcMlNjqerRhbqNCmJNe/RU1/9K13BLZUWGr+RbePhvgSVp6Vm2iUDOy9ArUuJwL7EFgFtB3ejkOelpNVHStcQJ6Q19z0iCNo8csL0u39Vl1Hvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213906; c=relaxed/simple;
	bh=0KCCvXPfVd2bmw0jPy+5myZTaMJmyhSuOOs8jT7M4EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olXkb/bBJxcDZ1Cr8vq4X2UiAPPhlJXV8STJ0yQDREYZNj8mwDzqTB9/tiMow10uOlpFUX+nQ4m8QdoSRh81TtbI64o9PHfIsLit+ULCgMRqKwhWAGwVoJhUCi7dg328A1Yh7Q3wocFhNYaK0KtjLh2kHJOiEsSD5188QPT1/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SurS4QPs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SurS4QPs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pl+BzDIKoo4boeq72u3k+4d6jfCuyZ9nFHxEzrKKC4Q=; b=SurS4QPsVJ821ItLjf8S85xBld
	JQYan5wzaJiy6Rk8F8na6uX/nRIjB9JlMhhJ3R/aqIroktz6X4fQL9W0p3v1pZt5ZEurB8kC79vWf
	6xnBKHdQ+GdjbgaqTdym6ePtV8TyMtYjQiDvLHud66r/aroYkE7cYnZaGKn7SIUjRYMc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbzFS-008wdt-E0; Tue, 23 Jun 2026 13:24:58 +0200
Date: Tue, 23 Jun 2026 13:24:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Wells Lu <wellslutw@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net v3 1/2] net: ethernet: sunplus: spl2sw: fix phy_node
 refcount leak in remove
Message-ID: <7f24bb41-dd32-453e-a478-487937ecf698@lunn.ch>
References: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
 <f3bdd4c91f3e2269b4e256075f9dc70808b1b8e9.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3bdd4c91f3e2269b4e256075f9dc70808b1b8e9.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>

On Tue, Jun 23, 2026 at 12:11:42PM +0530, Shitalkumar Gandhi wrote:
> mac->phy_node is acquired via of_parse_phandle() in spl2sw_probe() and
> stored in the mac private data, transferring ownership of the
> device_node reference to mac. On driver removal, spl2sw_phy_remove()
> disconnects the PHY but never drops that reference, so each
> probe-then-remove cycle leaks one of_node refcount per port permanently.



> 
> Drop the reference after phy_disconnect(). While at it, remove the
> redundant inner "if (ndev)" check; comm->ndev[i] was just verified
> non-NULL on the line above.
> 
> Compile-tested only; no SP7021 hardware available.
> 
> Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
