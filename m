Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA42D592D;
	Fri,  9 Oct 2026 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555759; cv=none; b=BQoZ+zWcC/e3FUfB0R5bAnX0mUvMDT2aV932Jyg1f9e2CSvZiq4iah8l0QpigUZMnMw1owSWGjpQN9ypfHBeNFKKMrRVX/OFEkVJcwA8Uk+A50eEuUlPsS5DbmKlB0BKXgM6QoBGRq+GCChz6leXGRsUMfI+yQZEAxBx6Mv04lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555759; c=relaxed/simple;
	bh=exHWLYXzTM9mtKFd836x2uxs9t7AR1nHynd6k/ACquo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRH3dfs1RTVsdmxsHtYroWhChFpidmcKI9/S5FSLIIuT443T3d9IgMzsRXChVyF0gL2LGsSK+NK4X7vdFHGHAMj1c47R8Jmw9PLCN0P2WM6Fp+3aJNhWj2jEEMeWqU5BlUF9/Nt+YSGr03PtKUcVkeQq89bwFSWGUDW0uGAFMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC5xPhha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC5xPhha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7E21F000FF;
	Fri,  9 Oct 2026 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555758;
	bh=akDjDkPdZ0AvHVYfxU8nsaUfV+VZNeoojr+Xd8f2sYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kC5xPhhaj1OTL5O02pSXnFbEPOuDTp6eWShL6/0dP6yfCEitz4zgsi1aeMlb0kTMP
	 SS28+vfsPxEOPQjslZxFzB39S/fHzz5IOtvQceYpkuKzDMx7ZeyaqBob+jgso+OSAg
	 pb5Dp+4URs7GrHZjoc2s0C9O+Nzn/qBfCc5jAIwEZ0dybZqJ++Rvm2wThwWrnkjGMJ
	 kJg2FbwVrVfYiqdHi/vWfbpNTNoYjE81eYUFE8aE5tXKQNgLCZ6aGKU8lGx8bqe56e
	 4iqQLpj/6gm2Sl0ThLdcduOBwNCLzjBoLaddrmq++D4LRCX/gYblL72BPvWHlqS8Jt
	 srSiNK4DTc7rQ==
Date: Fri, 9 Oct 2026 15:22:33 +0100
From: Simon Horman <horms@kernel.org>
To: khendry@reliablecontrols.com
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: pcs: rzn1-miic: Update port
 numbering for RZ/T2H
Message-ID: <20261009142233.GD83879@horms.kernel.org>
References: <20261006-miic-validate-dtb-v3-v3-0-68617b3dca5c@reliablecontrols.com>
 <20261006-miic-validate-dtb-v3-v3-1-68617b3dca5c@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-miic-validate-dtb-v3-v3-1-68617b3dca5c@reliablecontrols.com>

On Tue, Oct 06, 2026 at 09:48:11AM -0700, Kyle Hendry via B4 Relay wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
> 
> The port numbers on the RZ/T2H are documented as 0 to 3. Update the info
> structure and change the member name to miic_port_last to be more accurate.
> 
> This value was being used as the number of miic registers when setting
> default values. Add logic to get the total port count and loop over that.
> 
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

Reviewed-by: Simon Horman <horms@kernel.org>

