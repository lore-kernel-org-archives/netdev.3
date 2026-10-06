Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BF547063;
	Tue,  6 Oct 2026 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791248925; cv=none; b=ZulbZD93hufx43Sk0jyPTVLApXHnkHR1oi0ce3J+69hACgU3ysp0kF/jv+2Gc1w9p+NKIIVtdMhZbhFmEEr1npettPn3HEO/x5x/lFB8hCMv+kzrkxjZpXfXk9rn39ifyuYW21oI9k1qcSw3QC5p0TOK1ONYCPzxzFOeO+fAhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791248925; c=relaxed/simple;
	bh=N8sqI1CPH0eSK+G9bw1m35JiWFuh4K8kX4nGNFqCOlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEBfzGMDO8+ez2m/ZKX4/CqUD8CpUkHk+ukKr9tlNJJVUwLAdHMrSLPIo5iVSbyIWnIsQfeKL1QsbY9x7Ijsl+gy4U36EkB7eZRBkkZsS0xxBWdrGrppWnR4Dme2hpyj8bdTEfuj9RXD9SDP1ojUapzYb0DZHoDgpbcO8k6FSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSZ+8bI4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSZ+8bI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF37E1F000FF;
	Tue,  6 Oct 2026 01:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791248924;
	bh=2C4N+psukrgKAhqwAEvqMuMs81YNQ0KK//dkU/t6pOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gSZ+8bI4pFr/2LPX+ZoRUjwittT3Jswb+Hpyy5XPytgGZTVQMokyjtCkUxSihWI/E
	 uuqbDjHjBwNIbSUx7lt/jZotDhppSqupzQcMoVTpXWLiFeG5aL6NXvgFvn+t7TRXvx
	 s7GroHrUHc+f3Ps6MjoA7yKVFKl3YnZVEqSOoOfup0PK8r+Io02elLBRg7nWexExe9
	 it4br3fgDpIh96FJ+feykuiHhWMMkAK/MoX+oivcZiQy8r6XPC9GM+vxx9FUMDA9MD
	 mEfn+gOgK38iPlsNvN/WqkpsxXxEuGvSzGicbYEsuwoDQzjuxa/NzKj3zTwyUCbOU3
	 wArdfryTzJDqg==
Date: Mon, 5 Oct 2026 18:08:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Selvamani Rajagopal via B4 Relay
 <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Cc: Selvamani.Rajagopal@onsemi.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Piergiorgio Beruto <pier.beruto@onsemi.com>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jerry Ray
 <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v8 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
Message-ID: <20261005180842.66ea6c93@kernel.org>
In-Reply-To: <20260928-s2500-mac-phy-support-v8-5-7e011aacc309@onsemi.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
	<20260928-s2500-mac-phy-support-v8-5-7e011aacc309@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 15:25:12 -0700 Selvamani Rajagopal via B4 Relay
wrote:
> PTP register/unregister calls are implemented in oa_tc6_ptp.c.
> The APIs that work with the hardware for timestamp is provided
> by vendor code as it may be vendor dependent.

drivers/net/ethernet/oa_tc6/oa_tc6.c:1650:7: error: no member named 'vend1_mms' in 'struct oa_tc6'
 1650 |         tc6->vend1_mms = -EOPNOTSUPP;
      |         ~~~  ^
-- 
pw-bot: cr
