Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704938;
	b=bnJfUIIZiyF0tDqtDEySDbB4bjnDzHWWvfaPQm0kdsnEQxf97FsgYk7qENuZ1q/CPpYV
	 vFsMoD6u92FSzu1Dl/Sq1MfVG9kTy3hVm54ZqcWFLXlISdLQjwf5PzHv8qnNxHVkVwKtS
	 MqoTkXW0Xxj3RA+Fy+E8St/ajmkAZkY+4KR66Bj1RVGF7AcBq79x+8YRtQxjO+/4EP1le
	 LsIpaBae+A80Q3DwMBzgGVLTrPdKCquj7eFZuUkbZtQcRCqdWoaXXvA4cw5k+tfnIgqk/
	 VMMWfyOyZaRe7UxMn9h7pGljj7F9oHn629v10BPu/GOpm3XsGjkZ6vLOAmq69+0DEsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704938;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fAu2ZoplK+V+G5f7JtA/l7OAvhcVaK3WJnGS7o74htg=;
	b=aidXSDnnVDM1SxRcmjUhVAjHVHw5ZGWqFMPO7eQKdfsuY1uvc6ZjZhChYhn/auUnXkci
	 l+wVOL9WMFszjDr5YIvYPmlIzT8fLafXoVwp11ApEEjq5FWEEj6FY11LtS+rIC5EtT7n6
	 EK0OxtKpPRC74zP8ISxvRxLYOwWaTfRG2PPR9priWwwzu9aO/yAsb32wTGSZKsYWinynZ
	 +7BbHisxOKzlwlU1QGvb+FhuQEHO2vUMlPbIM/NgvRDoj8ANirAeI2zYlZsK0pJ0RKL2r
	 kJZ4WwPBKKgjDFxqBSzvphO+M23R/iTFPUZpQFASfjgIUjvC7MEFRo5EfT/Eud8AJ9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuycr1Wm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173F606C566;
	Tue,  3 Nov 2026 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuycr1Wm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEA81F000C1;
	Tue,  3 Nov 2026 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704937;
	bh=fAu2ZoplK+V+G5f7JtA/l7OAvhcVaK3WJnGS7o74htg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iuycr1WmVaW8Uy3tv3ybAuDURmbtZbS4uAsRgz85ha45o8LplpX1AyUHYSzQGUU4c
	 lC2WaDxDgJg2VkhGodIqVBM+3TPiuztnJULHT78C+gPSTtAAw0jnqT8LBNG5mGC5DK
	 SYI77HKit/pD68quMCGS9WEl8z3IBx65bNDEEZl6GhN29byH+Wn3PxW8e1bQ5Ex6LX
	 M28n+vi3jvQOhXMX2B6RUT87O3CWaP2yxhTtCwYF+j6F1Oly9jzt+OkFEYSMlSaaLR
	 nZBnX+E8b5TTVWFF7xlgfRyFDAk/JTDpsdXNdHYH2BRgFJKiqA9fIDHzph+PqiXBI+
	 uC1xx9Jzwy6ww==
Date: Tue, 3 Nov 2026 11:22:13 +0000
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jon Mason <jon.mason@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4 2/2] net: dsa: b53: restore the NSP IMP port 2
 Gbps mode
Message-ID: <20261103112213.GG865646@horms.kernel.org>
References: <20261029211540.4123250-1-florian.fainelli@broadcom.com>
 <20261029211540.4123250-3-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261029211540.4123250-3-florian.fainelli@broadcom.com>

On Thu, Oct 29, 2026 at 02:15:40PM -0700, Florian Fainelli wrote:
> The Northstar Plus IMP port uses the switch's proprietary 2 Gbps mode for
> its internal link to the AMAC.  Its fixed-link description reports 1 Gbps,
> so applying that speed clears PORT_OVERRIDE_SPEED_2000M and leaves the two
> ends of the internal link configured at different speeds.
> 
> Force the 2 Gbps mode and flow control for BCM5301x and NSP CPU ports.  The
> mismatch caused switch output queue discards on both copper and SerDes
> ports, with one discard for every TCP retransmission.  With both ends
> restored to their high-speed modes, iperf3 reports no retransmissions.
> 
> Fixes: b6a8a5477fe9 ("net: dsa: b53: fix resetting speed and pause on forced link")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>

