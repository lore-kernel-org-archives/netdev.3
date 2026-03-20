Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55602284881;
	Fri, 20 Mar 2026 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027935; cv=none; b=W5hbnI9ogZSgU/ZB5dWHn/cWlVKTeOL1cykf7vwE5Z2rshvTAy9u277JSiBaWDhfvAAdk8EIZDVEyn6UDvFPlHb7PDMB+Wta+aWwklMs0H4A4/jVN/1lW5IWtxPOIx2Fc0W1z0115kEhatNdQf/05oJVgU/Tm4NtLAjGgH51kxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027935; c=relaxed/simple;
	bh=TWcQpTrWg7vW03FQCU5s0F6HRyE5dXVyDotFQye0EWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlVUTE4b+HYfUFsMx5pWTeLUOoYMEE2MxOlOgYOVXuoGKU52tn3GRe1bfgq/xIQ9svCmoEaLtRp45+8Gi5xRDp140u6esWMMUzAZixxvTptkNox8jYrozXQbrlj10YYvF0fZC0nrCYyNOfKIjMcNvZLNGMCnEx4JIWVYSzRVDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo0FnfV8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo0FnfV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C219BC4CEF7;
	Fri, 20 Mar 2026 17:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774027935;
	bh=TWcQpTrWg7vW03FQCU5s0F6HRyE5dXVyDotFQye0EWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jo0FnfV880etH8ORanw/T6IC9Joa56C2WkgvbezTCgs3CPnWj1YMiAF6nJZ/MZhPu
	 v18g+UymczeQFiPHcMm2sciXXtFFuHupkeimSDDKnxhEl/lSdqmNVIsZl4BZmk8W8Z
	 ksb0q22B4AuedmCBkidJCov0dn4jaHRcCtxGq2dOfzgjdLAilmiAYecTNiN/vX585y
	 CjMIfHT/XFCa+3yDqbq5FIVgkKxxCVzKi3UCXj6c3t3XyrLUmUnOtuDNq6zwN5e0jm
	 58RIVAKQO+wGA7FS2P1t2ZaKVgzihKg1JX3VrOqUV1oaIS7sXIEaVLuKYloc7WIXR0
	 wmoOEmd5y/WPg==
Date: Fri, 20 Mar 2026 17:32:10 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, UNGLinuxDriver@microchip.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: microchip: Don't embed struct
 phy_device to maintain the port state
Message-ID: <20260320173210.GF74886@horms.kernel.org>
References: <20260319181705.1576679-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319181705.1576679-1-maxime.chevallier@bootlin.com>

On Thu, Mar 19, 2026 at 07:17:04PM +0100, Maxime Chevallier wrote:
> The KSZ9477 maintains the SGMII port's state for speed, duplex and link
> status to be able to fixup the accesses to its internal older version of
> the Designware XPCS. However, it does so by embedding a full instance of
> struct phy_device, only to use the 'speed', 'link' and 'duplex' fields.
> 
> This is also only used for the SGMII port, it's otherwise unused for all
> other regular ports.
> 
> Replace that with simple int/bool values.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>

