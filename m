Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3DEAE7;
	Tue, 25 Nov 2025 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039646; cv=none; b=Jiog+F+dcPOMP/8gz7h6ZL6wN4d4Ok7jynzmZlnSy6KTho6qGE/NLiXLydqsCQDf1oBmCAtZLkQcSNcYkYJJdtRYbMpdqh94BsNKpAM7tEP/aUcNd0f9CwVPZguu53duuUKaHVEtW24GjQWwgWt3NK4yekDHp4V3xggksHOOAo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039646; c=relaxed/simple;
	bh=zFtdzTL6CPluWH89XZnAMumzLqaDtVKMSsqHF99jyWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOZNCrLgkhVZAw2A3g53JzbaXRV1o+y0DEkDuvzngQD1vYmzBRKJWjVTeKgUQG0MHCFuLZy6jJR7NBjhwDd/YWmH5nN79z/OUrzfy2o6gJ2XpuT1m1S2SyrEJz4AHzhl/aVFGhx9kT2jzGllyr1Jev2eA1J6y3r3A9pkdtzSw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4e3CcUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4e3CcUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AF0C4CEF1;
	Tue, 25 Nov 2025 03:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764039646;
	bh=zFtdzTL6CPluWH89XZnAMumzLqaDtVKMSsqHF99jyWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V4e3CcUnj4e/rHYFqLK7QVMxJ99YtCqUmWdh6+URslcSbb3NQJdndnd2Uht3TLg2l
	 5vN0j2sFUeXOqsKxLBnaFltxN60rtNHKZ5vVTBhY2TyY/PTw50+Lff3C/oed60avJ4
	 mKSLZQIICjxvGd9G32OuKZ2e6V7Vjsgy0Khv7S+2tlDUyXySCXP+btIBJgOrgUbue+
	 5AV7jArJC3gM9m6Qsht7T7d58/GwwId7bcrEb8jM9h6rM//XlpBJms0yL7UcMKIDDI
	 TdE8VRic7dsYxufHG5FS8lAWtOBQXbLGRr5zwwsicxOBwFXqqBP2Rtj5GUUDZ2tCHi
	 ZVzRVu1msn+HA==
Date: Mon, 24 Nov 2025 19:00:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: azey <me@azey.net>
Cc: David Ahern <dsahern@kernel.org>, nicolasdichtel
 <nicolas.dichtel@6wind.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Message-ID: <20251124190044.22959874@kernel.org>
In-Reply-To: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 14:52:45 +0100 azey wrote:
> Signed-off-by: azey <me@azey.net>

We need real/legal names because licenses are a legal matter.
-- 
pw-bot: cr
