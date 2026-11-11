Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409658;
	b=v2ejDs6x00gHyMzKASsc8jueJiWeqNelDtuYuibuV0x0i58zLhBz0wlpE3DqQzm+uFg3
	 ua1oxK5tQ0ls7xSG5Gm/risQ7mlIbP9EZImi+Onj/m4E3Vu70z2KOXWJOuMVyp6XHKJ2c
	 ZnSXzZT84E5gt7UDzA3M/0HKAWRwgkLkn0DGhV0rvbDx3VO6lRKiEfxn0Mn/cd/aOBrbc
	 R3gGl6AgB34E7SFKqqX9gP1N8xTw9MEy3TlXVCLJym1G+om2e3Hs9uVwboon6UYljadEz
	 b4S2ESg5xtDEUAR2hFKhRb8yuHA5MoybPBOd5iynEeC5J7T7gVUq1Ve7QyZ5OKxnwYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409658;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xPQJULbkU5hCzjRLb+o7Q2ZPGSrG+geDlDFuQ+ACSYE=;
	b=RALP+P3Ym11afqOjEQ2m12fjHeDTtH+ONt10tPGPLXd1pVu8EHQoIKQY4sb3cq/mr7wV
	 ySf08AW/+OyL4BReLjEydEY+8/KLXe+ebnBYZmH4vlfD7mAIRFSCXgyihU3Wq7iqfSIgF
	 mxGuTcw9PGa+O421wAdwent+n7q5W8DTrucuUBc+NKe8Q2rXMR+bC67fpH7XuFDvWw6zB
	 9kqiWVIQL4HXGcahmbKS3IZSqy88YvZTtNWpRu9nNvguHrJ/aFw2GTDNLedM2iWOxkGoG
	 dYFzpARAYAd++G0DIeh/paWGRBBaDbafD19ZQJ6gzrM9iFERgfkY7aSgSUaNYJ+hBXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrUZtdOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB1606A332;
	Wed, 11 Nov 2026 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrUZtdOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9541F00A05;
	Wed, 11 Nov 2026 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409657;
	bh=xPQJULbkU5hCzjRLb+o7Q2ZPGSrG+geDlDFuQ+ACSYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WrUZtdOIPk3rBgE7q9E0kNq7qzyNVYuaDW0vRnPknI1kqOWAElXhRHngm+iIudmfw
	 h9dJU5kkiqefwNqcPX9l3eVnXPgFQ8bRDTMjrG4KwOddDLyVMEdCo4DXSol5oX4sgq
	 Y1ahKzbm/KnSo8PLEiLnFwLH8DzEJbe9tziTQ1OrugRR/+2YaMHeSx9lDrGJvmbWJw
	 Ovkm6iZGBuFFoVCToOF847s+oZOTayNcMVUFmDjMO5uYxq4WD90CLsyoA9jd89p8/W
	 8+hjCkg/UjtJR0eF01v0IFHbY1gtE37C8/VAJ8mk5BMosrGRj3qlYR+TcmQXlk7TW8
	 tz2WNovoYFBJA==
Date: Wed, 11 Nov 2026 15:07:32 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: do not classify EAPOL MAC address as LLDP
Message-ID: <20261111150732.GE18859@horms.kernel.org>
References: <20261104220042.1421735-1-poros@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104220042.1421735-1-poros@redhat.com>

On Wed, Nov 04, 2026 at 11:00:42PM +0100, Petr Oros wrote:
> 01:80:c2:00:00:03 (Nearest Non-TPMR Bridge) is also the 802.1X PAE
> group address used by EAPOL, and the virtchnl MAC filter API carries no
> ethertype to tell the two apart. ice_vc_can_add_mac() therefore rejects
> it on untrusted VFs, which fails the whole ADD_ETH_ADDR request and
> breaks 802.1X authentication:
> 
> [  128.447213] ice 0000:17:00.2: An untrusted VF 0 is attempting to configure an LLDP multicast address
> [  128.447301] iavf 0000:17:11.0: Failed to add MAC filter, error IAVF_ERR_ADMIN_QUEUE_ERROR
> 
> Drop 0x03 from ice_is_mc_lldp_eth_addr() and treat it as a regular
> multicast MAC. Trusted VFs still get the ETH_P_LLDP forwarding rule
> through the other two LLDP addresses and the rule does not match on
> the destination MAC anyway.
> 
> Fixes: 2296345416b0 ("ice: receive LLDP on trusted VFs")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

