Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F131DD97;
	Fri,  4 Sep 2026 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482133; cv=none; b=WDZrrmAv7iDji+FUixrNyh4YxKhP7RxURWHxbfWgg24LxkdimTgIH7I6OZAudB8niWzjQtpN7liM9LmrF2Rcmcn8cKEVK8J67us/QSstdeSa7cFxT7WWnrvjUdMhof43303Q5zAzKDasCZVCnNkQXKMfvCj3NEp8tmGJdK1XA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482133; c=relaxed/simple;
	bh=NW45y9Uu299D/OOTBRKsqX1KiCUSeuBk9xT6VBJbxXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpw/+7t5O+te0/NNqcX4m+Ps0lyi/HDIZy1/L77WXKNaYz5VW51yUBQ6loqIPt6J2Zhr/vAslqg7lGKHqL2t+1phSGV2cXpU+UTuolCNPqnMao8H2jI5N3bdsiX+k5pQPz5YzlaUYsfK058iYXPtIUg0AhB4YvtyV/YCT7XE5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNtntJC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNtntJC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E217D1F000E9;
	Fri,  4 Sep 2026 00:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788482132;
	bh=QQRaLYDUxy93Hz6VAFpiPT/0NSOIPKw/WnvayVAwG9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eNtntJC+ZaU5DuPCGwWC4NMYJuf1+vBiSpsBcsil3YZ/WegGG3own2Hi8iJ3Wcs6U
	 OXFgcfGVog5BiEDaue56KnV+r4azi9rCX+I2xLDr8298x4u3SFPQJfoI3y0gmEcRrA
	 bB09BNDPwatvEH9Hr+QStwvfZDfbhyb63XpSFtSI6IfoXwxjD01d1BATqwtNCG4KfS
	 zWi4QpQdhNTzCfcpe3bVA0MsBgongbtdAX1ADNWrl7hSj8z9LXFa9BeiCpnVT7xaGa
	 sIMSKIe/Lolj2BSpW/8V2kW8FadSsHEhbr7TGJaoTkIv6O2vs490WAE2fOlLzBd6gs
	 mIjZPKG9Sxygg==
Date: Thu, 3 Sep 2026 17:35:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 upstream@airoha.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: airoha: handle RX_NO_CPU_DSCP
 interrupt, not just RX_DONE
Message-ID: <20260903173355.62780188@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <17f1beec505b87a4acf16557386a978c98f94b97.1788286284.git.sochnev.v.74@gmail.com>
References: <20260831234701.206021-1-sochnev.v.74@gmail.com>
	<cover.1788286284.git.sochnev.v.74@gmail.com>
	<17f1beec505b87a4acf16557386a978c98f94b97.1788286284.git.sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 19:32:53 +0100 Vitaliy Sochnev wrote:
> Whether NO_CPU_DSCP re-latches while the ring is still empty is not
> documented. If it does, a ring that cannot be refilled (page_pool
> returning NULL) keeps reasserting it. Masking it until a refill succeeds
> is worse: a starved ring never fires RX_DONE either, so it would stay
> dead after the memory pressure clears.

Since you're not sure you should probably add a timer to retry
later? Maybe the IRQ is not needed at all, you could just check 
on allocation failure if the right is completely drained or have 
a periodic task a'la fbnic_napi_depletion_check()
