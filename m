Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399624;
	b=BtAHCUORiEOAVH5N1W9HZeMDnLCfOLa5qA2CgglJhghTpczBRyFkQZe8SkChhK8wjrXC
	 iv3Abj1i9GVhz5KOLbOycXHqeFFxJsl/eCobMp8DHfLHpRzxs8qPNC+6Shq88wQHkXLk1
	 YrwhtL6qJhUPJy0hfTTW6zspWRIY5TWQsLyf8STW8sDmSex8Kc1hDPhyXgCy+f6IWmw9H
	 gMj5o2Y5OCyi2JWSzzpQaSwpk5ozVunLQ9GBb5jrEUt+XOFPSWkKKeWYFtVXFRQaxGdAv
	 Q4RX3lm2enNyJR/oslir5Ob6rxjVxrk4JBUGQ1J+82+WNkWLoIcdcT/tybjioYPGG+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399624;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HCDkI+BzP0zTvfHzTEgMZGxHihmLBLovpb+ZElG6bg0=;
	b=Y0sFbfXmdTH4A3SXC4MtSW9A/u87Nx6uaR6IsCoiAMM7Je71yWPqzPB1IYJ/u1TPCqKC
	 gMoyCKvjnnv4m7jVJfDRYNaRDCkdstGMa5qzY77HdAY8wa3IgD7PDejj1xULEA6ygtSQI
	 Zl52+N7ETgfITf/m914JaPvodfndbBXwhbsBbmPWBRvSF6CzqgLuwbU5+iY3KKzlBI4xB
	 7s8SxiB8TNi3mROQbnCASXJp7XS0oNvShwUvLRU9UIZ1lt5h5MxgZXXGHzCYyffLOn4KT
	 8tSdehJ7mONCygGHpoO7CkaeoQ6eDKXptPZrToap1TT1Pr/lkSbhFxw+39yho9L4uZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmY0mRE5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C0606A31A;
	Fri, 30 Oct 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmY0mRE5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461F01F000C1;
	Fri, 30 Oct 2026 22:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399623;
	bh=HCDkI+BzP0zTvfHzTEgMZGxHihmLBLovpb+ZElG6bg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fmY0mRE5zQhua/jGYMFiEduqZiWNM9z5RsG5wnWCnJhKxSxIYzNmYykqg9UCbUxNQ
	 WsTy+BNiK2YpAJdQciclRTuoPtwIW/pVenJ1P2IS+jaBb/2gbN7Z09Ue8ufpwx0RSa
	 HUIn4BwK7pixq/P8I2RwFnZD4GJ0P9FsjLsOqB30zFgTTXzZY3OnjJPqh2ilx5Ec4I
	 zjhINxkZ3bnJPBxLq8aWL8+fa+G83/V0x0pDZPsePjZRKgAoSmcEWm3C9FoeqRKpO9
	 3ODxaVhWO6hxrIn7Qvzh5ZRoSvSwvVwET2/AIVXh3qk2jafVnK0VtdHtE2sPLdLaqI
	 RVdKgsIBLoJpA==
Date: Fri, 30 Oct 2026 15:33:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Subject: Re: [PATCH net-next v4] net: phy: aquantia: Add support for 5GbaseR
Message-ID: <20261030153342.41d9868b@kernel.org>
In-Reply-To: <20261030-aquantia-support-5gbaser-v4-1-7dfb0cf306de@oss.qualcomm.com>
References: <20261030-aquantia-support-5gbaser-v4-1-7dfb0cf306de@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 15:51:42 +0800 Hongmei Xu wrote:
> Aquantia PHYs can operate with a 5G USX interface between the PHY
> and MAC, reported as interface type 12 in the PHYXS vendor interface
> status register (MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G).

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

