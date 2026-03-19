Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B05356A2B
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 02:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888248; cv=none; b=FQiTrqTaTvr4eI7ctdiGb1LUj6vtz5fQ8w+KxqxWqW8+mkMQS83WeLH8OOPF12I9mndN2gllgWPz5kxOeFLkU88b8dBSg73dvMZCwMWqihcwOFMqgnQrlDqzO1KIoBC6qTk9ormTLoP9MpQQL2YHVZ/52x2vCCp0EeVSwWMrc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888248; c=relaxed/simple;
	bh=0A9EgJEpZv/tx6kddqYVH00Zurf13nb8IaH0ctTlMiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0MWPZg32x/xW7V7tPOJ+9iWnUvcIlZbwyAzGfwjguosIEt3vfN+90nGRqa/3qEFRP0RoxwUdO3LMR5UIpSK8LjlWUIbKSlJwmzWtnJ7TVVXInXiLZr+TgBglANal9wYA0V4PozLGg+ACIKOR/vp8vohZ/WAwWBpN5acZkT8uhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm8+trVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm8+trVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B357C19421;
	Thu, 19 Mar 2026 02:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773888247;
	bh=0A9EgJEpZv/tx6kddqYVH00Zurf13nb8IaH0ctTlMiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zm8+trVGKLcYoa8BY/rKSHJa7ahWB2fEDFz3ZPM47Kjj4N1lbawekKWSGw2/9RS3k
	 0j241FT5t0aYBu/6q27JgwzKovDEQz6/HRQxmAmGManeCj0Y5/8jpOcY8/zNLxGzPu
	 D7XGM1kr/CLa46/lPHJzGMyilNdBgAAfonIJNjvGSKlzDFsKMGYanky4WKGL3YkYx9
	 sOdwR2wwnSQqrQmU5rA0wj7c8P7C+sdXzTM1xc/vuD1zW5s+EHGdYkwiem44CTM60u
	 n3ROOgWD8ATO1I/6RL6TP3PCN2t9FRQ6TKX/rveP3Mr3aaFzUuGNT/MMF1r53RIvI7
	 5fzN8zx7iNSUQ==
Date: Wed, 18 Mar 2026 19:44:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net-next] net: macb: propagate macb_open() failure in
 macb_set_ringparam()
Message-ID: <20260318194405.2fd22d8f@kernel.org>
In-Reply-To: <20260317202229.193375-1-nb@tipi-net.de>
References: <20260317202229.193375-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 21:22:29 +0100 Nicolai Buchwitz wrote:
> macb_set_ringparam() silently ignores macb_open() failure after
> closing and reopening the interface, always returning 0. Propagate
> the error so callers know the interface failed to come back up.

Not sure it's worth it on its own, the driver will implode if the user
tries to change the config again or bring the device up or down.
The fact that error is nor propagated is the least of our worries.
-- 
pw-bot: cr
