Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704923;
	b=AmotFssvAFpluQDtX3gbxN6XQMfWYTa/LWRuIYPvQNX0gUE4j7V34rf0ox/lh+1acboO
	 OZZo7Hkllt2x0mfx+62lPXYfVNgBMGmYlKHu5+2blM2hOrPqJUwB6nw4sEh9KlepZ/Rd9
	 EZkwd782iHZ0802iEajGOWe+ryGb5TEcuT++CQpKBTLjW6BOLYhtNK+PAGEGud5qVbLUG
	 Opu2aRuFvqjqvS1RfVaPjNhVRopOpPHb0mkMN8rqLEazsdyJl2HJlMkfe/p/ZICZ0iG+9
	 CGY7wxsRB22yUCF5Gwk0+JryS3lrTGzf38aGwIroWzH+AWmiGYmkqu+sre5ujjFw51Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704923;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AQ2hz4bwVPPUXsJ+ONg4zBrOUFBcUF8wkq7XkDRqNfs=;
	b=WDriNSqlSGVRJR2ysi30/TfMepfndpilZIL9/cBhiO3LTaF7gBvVPI4FbePmxYeFSTRh
	 eH65VDsA477b7EMzAXhSA/RRa7KmHrNPQLVcd7nEs9SdkedZkb/z2cnA1QJQx+V2oxb0t
	 s2lw2N7iVl5/6yuKVmH0jJ4yYFi4BipFQKRWfctCbghvJJsAINpefIgO7O56xI5OvxDlw
	 ROHX8b7GIuM0083sF3Jcvh70P47XNcaiUvxCzs4Jsc7cJONptP3HPSsDen3P6ZpaMe5/5
	 Wjy4S5gk1ZZerEITySPy62fIVk8Vuc6CdBisUDS/gj4xddAS+mAkfUlkZiH9+63tlFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b/oiLOsV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD10606C59F;
	Tue,  3 Nov 2026 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/oiLOsV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9071F00919;
	Tue,  3 Nov 2026 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704923;
	bh=AQ2hz4bwVPPUXsJ+ONg4zBrOUFBcUF8wkq7XkDRqNfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b/oiLOsVN53J1MO1M54KG6mm6QOr97VAVAQ3Tpw+ekDnTPDXv1E4bXcgcIkotc6q2
	 SMwRW8nVlN/dHkvit7HtH4n1WZqPNRaHYp57oZIyf/fzQDXSYxxLwl/kYa0VegulC+
	 OnYMhi5XX0rladq8hWMIgqa68/O9rR4eecZJ+lczF8hvHtTAoyvd42yJaM/byyTEVu
	 oMQgZnPB+T9OeNLn2Mi6KZF/l6tTO8IoEyD1dwb2cD2+XjUFaaFEfbLsrOSr8grZ5q
	 0tYNpjA+n6IYbT7ksSVPAMkKh4bF28cNBEdDtXVp4kfZLIGez10Vuh0q0wpUHdnlhZ
	 nvzYT17kZyefA==
Date: Tue, 3 Nov 2026 11:21:58 +0000
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
Subject: Re: [PATCH net v4 1/2] net: ethernet: bgmac: preserve forced 2.5
 Gbps link speed
Message-ID: <20261103112158.GF865646@horms.kernel.org>
References: <20261029211540.4123250-1-florian.fainelli@broadcom.com>
 <20261029211540.4123250-2-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261029211540.4123250-2-florian.fainelli@broadcom.com>

On Thu, Oct 29, 2026 at 02:15:39PM -0700, Florian Fainelli wrote:
> Northstar and Northstar Plus use a 2.5 Gbps internal link between the
> AMAC and the switch.  BGMAC_FEAT_FORCE_SPEED_2500 makes bgmac_miiconfig()
> configure that speed, but bgmac_adjust_link() subsequently replaces it
> with the synthetic fixed PHY's 1 Gbps speed.
> 
> Use the forced speed when processing link changes so the MAC remains at
> 2.5 Gbps.  Together with configuring the switch IMP port for its 2 Gbps
> mode, this eliminates the output queue discards that caused approximately
> 1000 TCP retransmissions per second during an iperf3 transmit test.
> 
> Restrict the platform forced-speed flag to Northstar Plus using the SoC
> compatible, since Hurricane2 shares the AMAC compatible. Other platform
> AMACs without a phy-handle must continue following the fixed PHY speed.
> The BCMA path already selects the flag only for the Northstar family.
> 
> Fixes: f6a95a24957a ("net: ethernet: bgmac: Add platform device support")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>

