Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614550;
	b=BPGLXAdsIH7myEnpOaF20A5QO3DV5x+ls0RRZ+ZorAMv8I6CpIjXuTk7H2yKVJxA2C98
	 JutmUHOBO8VvoQwtb27FN13vnfxkzPB3MJOkJV6vJ1j0qXvW9uCDb6ry9Y8tJejrARde1
	 zgv7YeaHuFttpF5PiolGWU9TWAlvh6Z66Fp4ce171KP716vo6t0ZEAEm5jVIqhk3fCo02
	 a+B9yh3Ax3c4Wd+/3z/dt+650n/MXgnl774Cl6FY2/f08CkilDzkgAXctxM15wjy/r6BC
	 iwQlbQGjfBJOQKMeVGxEXRa1HXJQND6Z5TY/8tP4AEGXjF0XfMk5dn47PV9ubuzWESg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614550;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZHIWFL8zJ5o+xyhTpRe7yjSUWqzqghhKZbRooUB7i90=;
	b=mTHIEIKRkhmfqFgSh7n0r7hhuYmO6SHty6ksjg7G1WSjMxOrFptCCt+MxO86+DcsohsY
	 rtZYE6oEEJYsCZ0j0B+AbJX4gtbPhpOEH10HFicJl+v4SjyDtY7zrXfGtCPbvRY5slVSH
	 MsEEIWhBsJbek3yRfjUOdQpmcJ0ocBzE4uYChvs4FOv3n3wsvZF9eUhTTTNN1ZWXUiGRJ
	 3SUcnwn7AVR4+8mxg/H/ElnLSyZ02QgopbhpZEIFrWRlPRBHxEO/4gkHh+SfXQbNKezgF
	 V1Sdbb2Cch/DCwZ3e/DDQ8GpHam4LxyNgVUW5oQSUfx+OIFpj4uWFCDwgGCg5bckv9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcaXHIBp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A25606A319;
	Wed, 21 Oct 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcaXHIBp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5661A1F000C1;
	Wed, 21 Oct 2026 20:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614549;
	bh=ZHIWFL8zJ5o+xyhTpRe7yjSUWqzqghhKZbRooUB7i90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dcaXHIBp3J66nXn/HJ3bLRiK1Hxch59cZRoZOCuXGMAR5SRnuEyqU1qYNklc8Lbsx
	 wK+1LucLYGOFrccc8hcXbygnmu26wKpvIGC9wr3Fqi/d1yBAqBITuiPLmovVQg0ajC
	 KCRZaajJjr3E/A0dBcjKWF9vzQjlqi4tWD1r0RLTn/jmivpssVOW4CxblXfTir/uvP
	 1xAOxjJwOCFKxYTGFI54NBNcPAWaK9ncK5OzDhgDpi3iSnrIjS7rQWtAlPRAhKQAS4
	 sY/8dbPOqdHSMmKwE0+cCkeufYvkeIMFD9IUQcN1oMTV2TtPYjLl2ScWg80cB4l1mS
	 0pSFNuR14wKjQ==
Date: Wed, 21 Oct 2026 13:29:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: phy: aquantia: fix PMA capability
 reporting and EEE discovery
Message-ID: <20261021132908.5a73ea02@kernel.org>
In-Reply-To: <20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d@oss.qualcomm.com>
References: <20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d@oss.qualcomm.com>
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

On Fri, 16 Oct 2026 11:23:17 +0800 Hongmei Xu wrote:
> This series fixes two related issues in the Aquantia PHY driver:
> - Patch 1 restores EEE discovery for AQR111/114C/115C by replacing
>   the manual linkmode_or() with genphy_c45_pma_read_abilities().
> - Patch 2 adds get_features() for AQR113C to correctly report
>   10G/5G/2.5G/1G PMA capabilities.

You need to respond to AI robots in a timely fashion.
Since you haven't and the merge window has started on Monday
we have to drop this, please repost for the next release
cycle

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
