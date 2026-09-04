Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3936C0C8;
	Fri,  4 Sep 2026 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527850; cv=none; b=l/AeqMOL5qdX+5XQy6VVL6/dBQ8hdmi41xb9f9kSOsPW2m4Uj1Fv4WjCzfBuf2UoQje0qjGLku6hlw1d8DmTlelGZLQ4O6gRNcTksc0o+bwLvO+rchkFtkwL/bdQp7ktcOSHrrPGsigAddhkkoUryKLL+XPQUCKm81C9Fh7ddNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527850; c=relaxed/simple;
	bh=FTS4cE55yADgaHRhQyk5p43yy2g7ZytCSEqWU5OvRW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwQx72N8xsVW/mXV9ksitwWC1pwOh+in2mqIkRixJngEygp2AJkB/aHvE6QJtaQLHbF3mny182HuGhm/UtFggTHUX8q/dnpfDmeL0o3ePScHQlZ7kZMpR3tPBBVyZXO0/7ZW+Qchv5jxp4hr8bjlo3WeEkX+MkMYcjNhgSR3bFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kmEthYfW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kmEthYfW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0PYTQUfP3ctWkUcvxpc6YNYrfO9V7csihq+RDV0yoTs=; b=kmEthYfWsOFvjJYsOYSeFk7nOo
	00YBq00eTsj2MDW6qmTf4O6zW+63+5LmMAYdYwEWWTu7Yv3A7FJQJTjvcYu6gePWZS91YtF6DHoAh
	xDRaFiDszIxhG7k7GtEMDYHWKrqcaEjS4k0y8CuA0wl4lGahc1ZK+7k6v9zng6SP30q4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2TnI-002ywC-Ad; Fri, 04 Sep 2026 15:17:24 +0200
Date: Fri, 4 Sep 2026 15:17:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] mii: fix typo "asymetric" in comment
Message-ID: <2d58903b-4841-4b62-b580-5cd638dc54ec@lunn.ch>
References: <20260904104107.12832-1-hemanth.selam@gmail.com>
 <20260904104107.12832-3-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904104107.12832-3-hemanth.selam@gmail.com>

On Fri, Sep 04, 2026 at 04:11:05PM +0530, Hemanth Selam wrote:
> Correct "asymetric" to "asymmetric", reported by scripts/checkpatch.pl
> using the misspelling list in scripts/spelling.txt.  Only touches comments,
> no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
