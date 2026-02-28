Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5B175A62
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309547; cv=none; b=CJ5Pkz0EZia9h85+z3r0T6a2DfhfTabDrMPWEOa7hm0q4CdkDipZgKBaCbGJK499L15hanPy1buSC8/ffjDKrjJWKrYZ10nPXPqMCQyd3YP7AacT0+6nNAFL+5hJOOqLSLmMWxUNz9ieBS6ijcnFSd1Jiw4kiTkRiOTdQ1etnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309547; c=relaxed/simple;
	bh=JPZtJJESxZg8rRn9ievNBOELVwbecHHJk2DeYE8niUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiU6dHRfhEKGr6SHXFwnTjTwU7YVR4AGbWf4t+4WIVR1bTq2q+lL8KhLxYZdLInQVsxllP4V1/U4lbZ4oaEDcQCv2Tv/wlaGZF+qm8ChIdrBixyLm6qaQRIVOS8wxaGXwc/chTdtB5hKgo5hFGMbJLbXw8xLtp3ro+BdzdGPqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fjOQf5Fx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fjOQf5Fx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BzTqMk49lgSR8hs6PH+yNZAg+y22uSiJ506v1DkYcU4=; b=fjOQf5FxmriXR/qZflKI3TYd/Z
	EdALo4rY1f7dH3QEpNyHQOdxDHqXsl7pJaW32jepC1stmMZaO8g+8Gvbb2BHFbRmrYwcRzfaGEXGM
	rtbjm+lDWUAUVOf0j7nJFFbL9mLyADRa87AtJZDITFhRCOlLUvAnN80S7vdGJtSk/uFU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vwQfm-009DaA-48; Sat, 28 Feb 2026 21:12:22 +0100
Date: Sat, 28 Feb 2026 21:12:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 1/2 net-next] net: dsa: initial MT7628 special tag
 driver
Message-ID: <3f58e20e-8ca5-44b7-99cf-1ffc0154665f@lunn.ch>
References: <20260228185242.800836-1-joey@tinyisr.com>
 <20260228185242.800836-3-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228185242.800836-3-joey@tinyisr.com>

On Sat, Feb 28, 2026 at 08:52:42PM +0200, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch's ralink special tag.
> 
> The ralink "special tag" is merged with the VLAN TPID when a VLAN is
> appended by the switch.

Does "special" actually add anything useful to the naming? If there a
"normal" tag as well? If you where to see a stack trace with
dsa_user_special_xmit() i would think it was some sort of generic
code. dsa_user_mt7628_xmit() is more meaningful. Especially when some
other vendor thinks their silicon is special and want to use that name
as well.

	Andrew
