Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618443;
	b=N7gBjRp9G312CMP/8A4mKozu97oYy9qnJZ5VAQzS59uqFIyZK1BUKTmBuYeYxpUC1ZDA
	 h1U07q61v0LK9X8pQ6wDJBZmmihAi6rA+HoTCUs+8ieuClAA0IoHmcF6sRY7MKVGhXQm8
	 AhWoFwXyYcYk0R+oZDphmtT/DO747RfHnMop+s5m8EanKm7HDCTtK2EPmgGUF/uDL+UKq
	 NWNwodqXS3Mf1LlDVrSYAZv8ys100OnP9QSJRo2jE6w6fTsgi7uh5zqmuASYtBHcfStxV
	 kAbNWPzDTPTKUkMJCgSYbLj5kScOChwongLMPDTI/IeeXma4LkDNMzVRllNFMI4cv9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618443;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PnYoRuEzE+xgFhnwhVLkbkJXXLkktMsCoYEFZrhDsTo=;
	b=rIzpne4b2MYY5FP7yOp8CSEmzzprEB/zVk+hTV3xTSrjpHDraKgnLCK6m9uCGTeHZbXj
	 ja5lJCDW3hUlv7qEFV3LpByY6eFdLL+YmyqnWhgcN7IqJSSuy9PZ6cB/CFMAKmKMWoOF/
	 wWHucBaO3V7nLH26HYU54batCAVTxsCDbwa0+4EHcvu5fWdvLvY6AHdCRo1ywBC3tl8lG
	 Rg55mK1NlGDfwiPPmm3izgELzWxY9Se2Akt/CqoMcfGYgiNHvUdnSC5rmt47VyU9t6BQC
	 r966WuJQJ2w5uqMM2y5XlCxw2ErGtv7rBCeEcC6h/Cimv/e1KosPIzQIgHRuJVXypeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GJKas5xZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99547606A31A;
	Wed, 21 Oct 2026 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GJKas5xZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19C01F000C1;
	Wed, 21 Oct 2026 21:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618443;
	bh=PnYoRuEzE+xgFhnwhVLkbkJXXLkktMsCoYEFZrhDsTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GJKas5xZN0q3enl9LdgNO5axUydK/sPkMDqEAgIGPk1jR/mIJaCXKUzqdpsGroo9k
	 qAmGC84NdZIGH9qcLaWtcV/0OuCGSjRHZ/c+MZ6GLP98z+dUxQs75zE5HuwZGYOBZK
	 bwqHg9cuchp2Ko/bYdd+O9CavWtHswEO4V5zAgSB8D1pI0s5aXKZHJA6lv/WRnDhrC
	 7dXV6WxiJSD3DlnGBKkGHCMNey85r+FshNxSwMa0EQY0DV4LLsRS1rt5HH2G8JgbyC
	 XvKtA863u8uqPxZuPF8tOHM6NRPGOCpfTMLbukttBjGj+TP14fbqYqLsNRkQCfLOoC
	 WcI16ZUFgLDMg==
Date: Wed, 21 Oct 2026 14:34:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v32 net-next 0/8] nbl driver for Nebulamatrix NICs
Message-ID: <20261021143402.2c04af68@kernel.org>
In-Reply-To: <20261021062113.2158-1-illusion.wang@nebula-matrix.com>
References: <20261021062113.2158-1-illusion.wang@nebula-matrix.com>
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

On Wed, 21 Oct 2026 14:20:59 +0800 illusion.wang wrote:
> This series continues and refines the previous v28 NBL NIC driver patch
> set for Nebula-matrix m18110/m18000 (SNIC s1000) Ethernet adapters.

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

