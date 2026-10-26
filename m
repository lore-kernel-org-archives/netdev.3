Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039193;
	b=1+iKLhWmvVGQXbvrYLoWsP/+4nBNY/DcV5w1Eh/4kN5hqPkyYqyYXNSRZ1RvXaehJ9p2
	 xpFSPThDD/Iu7B1FJXNJO//HcRv9UWJsVz2jRWmvh6DEjLFrr2Ym+zJymWBLbX3An8x7K
	 T9cn9+5f4npUPOAcB8YVwR35V8ZigXoaxwOKCMVoYaMcjMCIxiFKmPTw+9tmvrtOPwl9L
	 knO1yGdzLpexF96iBjPh3hH8iTJiMK1JNbgJKFUj3W7qvnI4Gz6IjgIX4b0mtK5eckMsw
	 NKOTm3pVFdrbQcsAbvtyUt1q54yZA3OusRJpspmo0v317qNzPR/aODO+2/X+AbX7Lag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039193;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=MY5qsu8gr2cqs6WuOlJtmdylKYo+MyPPG4aE+mmr2F4=;
	b=34BD6aMWV/WQgq6veiWhgmgdcmquzAnX5kCfje8cwKUOP2kS8QZKVPHdiDtOFPveaoGU
	 BYDesUf/8SNUHcsNRTPMSpqZyNQpVNDGUwoB90IrgqXMvIuBGJExGOSSdrE2RTo46EiXD
	 ew0il773+E1OKBg5GK9VK0CQZwmsSivJqYbI5D1eMJT4L4Gqe+hwFjOqSLCDfVR8lJHKj
	 6O2i2XSdJXtpbaEaPNJyv9OBql6cGyNpRF1DBV9AoL6X+9BAVErQGVuOkl8NXImhP+LNS
	 /pyQIwgp+FEaBBbKJ74jzxfY+GTQCxVqNgDgnaR7sMWDqmEwd8i57qRX4EDUbreMBMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xx0pVhX6;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BD606A31A;
	Mon, 26 Oct 2026 18:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D7BD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xx0pVhX6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MY5qsu8gr2cqs6WuOlJtmdylKYo+MyPPG4aE+mmr2F4=; b=xx0pVhX6f4SvjX1Q1hdyoR3/La
	1J1rGjO9RFCnkN8RI3uNIkKJMcGNYaIwKb3gWUavgAJg3tu+8k1sJAeREJKCal0GnNtLaVhFrCEGi
	WETbXWGCbJ2cQ+T0R9G+ee0NyqDxI0tUDy3Bg0XUOYsxFoi2Yv90Lj2/3Gy062LB5osw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLPOr-00CpWB-2S; Mon, 26 Oct 2026 19:26:25 +0100
Date: Mon, 26 Oct 2026 19:26:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/2] net: dsa: mv88e6xxx: fix 6351 family
 statistics snapshot
Message-ID: <6cc08ebc-e387-469c-a339-6a9588fefbe7@lunn.ch>
References: <20261026164733.737299-1-f.fainelli@gmail.com>
 <20261026164733.737299-2-f.fainelli@gmail.com>
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
In-Reply-To: <20261026164733.737299-2-f.fainelli@gmail.com>

On Mon, Oct 26, 2026 at 09:47:32AM -0700, Florian Fainelli wrote:
> The 88E6171, 88E6175, 88E6350 and 88E6351 take the port number in the
> low bits of the statistics operation register. The 6320 snapshot helper
> instead encodes the port as (port + 1) << 5. On an EA4500 with an
> 88E6171, this causes ethtool -S to return physical port 0's MIB counters
> for every user port. Traffic on other ports does not update their
> reported hardware counters.
> 
> Before the snapshot operation was moved into the chip operations, only
> the 6320 and 6352 families used the shifted encoding. The refactoring
> incorrectly assigned that encoding to all four 6351 family chips.
> 
> Use the unshifted snapshot helper for the entire 6351 family. This
> matches the Marvell DSDT statsCapture() implementation, which uses the
> raw port number for chips outside DEV_RMON_PORT_BITS, including these
> four chips.
> 
> The original 88E6171 change was tested on an EA4500: pings through
> different switch ports updated only the corresponding port's hardware
> counters. The other three chips have not been hardware tested.
> 
> Fixes: a605a0fe7115 ("net: dsa: mv88e6xxx: Abstract stats_snapshot into ops structure")
> Link: https://lore.kernel.org/all/404d5f2d-24a5-4edc-897b-b1b3c54a20e1@lunn.ch/
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
