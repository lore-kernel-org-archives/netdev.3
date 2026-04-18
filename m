Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A92472A6;
	Sat, 18 Apr 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776534647; cv=none; b=MnTHCkhU2ni9n4yFnc5Eqf0+PYxOks+9GN4+VkvZpUapyfNU1LdcB7eXsARvELm6EL/kiYir6ckmpoN9sNL6ZwKIxtKGlz8tBRyd8jK+8xjD/nqBcC4Qnf3Bx2EUQBxrvmk2SB1eIgnL11RIS+Kd8uyJtZwTRGxodU5cLN4fqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776534647; c=relaxed/simple;
	bh=UDSHJvlRLnfJws7E3rDKrzCfc6LzXqWJF3JEjKI52XU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElHMj7O2PsW+2AwsvNXZp3nNGBWDJ+FpeQB+++S5XQadWYEgYgXXa0Cfbv7XHYNh5PU/7FeXjMWUpV5oc2E0UerqB0Gntu35n46wuQLLG8gOar50VT/W7ei1cYmPpixW1jwVijr6DD0B2O6s93D8ZiOzVL7Vu06uXS93XCP/z/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rG2qAgnl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG2qAgnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525ACC19424;
	Sat, 18 Apr 2026 17:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776534646;
	bh=UDSHJvlRLnfJws7E3rDKrzCfc6LzXqWJF3JEjKI52XU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rG2qAgnlUKtwNJEQ77UFsQpKu/eMsWktXuzcX/tv4yEUc38nBVgXs+qWMVk/i2N5L
	 YJ49ocPW9yLOu9uB2qQ3XNp2dTVFyY4chObAnpykaYi3zfrr+AocPKFsD0cwUPKyTd
	 lNtpFqpbg6LhTP5MvCRgQI8/9gIArdybPksHIHOs91Ae55gMTmNKVnLkmrZdpg755t
	 BVSG2mmHDknVAtmx/QorLPpbyJ/nq5KNj6jFa81Yef8NS3Kesg8ZqAmkPCaBff15By
	 9Xb2TZqVIW86RvMEtbsDRit8S2ylJumm7auBYnec7tZHwxs5Ac/PlBed6ucw/pc1Zc
	 NO/UsxHjXYfrQ==
Date: Sat, 18 Apr 2026 10:50:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Arantes <dev.gustavoa@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: report per-queue statistics through
 netdev qstats
Message-ID: <20260418105045.2bf4e102@kernel.org>
In-Reply-To: <20260418021232.5425-1-dev.gustavoa@gmail.com>
References: <20260418021232.5425-1-dev.gustavoa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 23:12:32 -0300 Gustavo Arantes wrote:
> r8169 maintains synchronized per-CPU software counters for packet and byte
> accounting, but does not expose them through the netdev qstats interface.
> 
> Add netdev_stat_ops callbacks and report the existing software counters
> through queue 0 for both Rx and Tx. Provide zero base stats so device-scope
> qstats report the packet and byte counters as supported and match the
> existing RTNL statistics.

It'd be good to include the motivation / backstory that led you to
implementing this when you repost this after the merge window.
Benefit of having qstats with a single queue may not be obvious.
