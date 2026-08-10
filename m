Received: from mta1.migadu.com (out-36.mta1.migadu.com [95.215.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9023F8886
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372168; cv=none; b=UxeLK7MI1UpdpEHToKro1nOm8O3lHNaRWuP6ki9f9zVk8fVvuiy2VkispGlq1CKJwrcJLA5rQAPrfpuwtfqu7ASSVk5p4NCo4AOvFDoRpyMYskcOcpRmfECA+eibqm83+9IzzAMhphXE0fbDhL3u9fAlhZy+U9bqUSu24Rp+A6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372168; c=relaxed/simple;
	bh=acvUqGrdWrUaSb9Cp4m/GdxZoe9tRRnaR/i9xvABPg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFkGlotsQ4x0vGGU8HUAu+qR+zFk1R4QdQGOfI8MCDda2XSw4fFZ4KVRfjF0lVWTp060d/bc9sPTxuKKv48tJysIBJgP5/xhZp9LgoRj75c2CkPkaM65hhZuXyINXlpjwwtN4RG1Kf45J3VYMDzuuFNmz/OcdKKhLnsXXMedxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SOsZdZYT; arc=none smtp.client-ip=95.215.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SOsZdZYT"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=acvUqGrdWrUaSb9Cp4m/GdxZoe9tRRnaR/i9xvABPg0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786372164; v=1; x=1786976964;
 b=SOsZdZYToTCM2BNbWp1tDJNgeppUTUIapSAlnk/iDTL2bwx+hb4S/bJ/e+XSdzoRK5XzLGLv
 n6D3IubeAf7ebTWCLMmdw3lxkYFW+qW5EQSmmJ5rH/xSstPdg1f6Co1yfhZjexU3mP/65+2i9bz
 +qSq3WRkD31+/+Jq/GDi6LKo=
X-Envelope-To: netdev@vger.kernel.org
Received: from [198.18.0.1] (58.20.28.110)
	by mta10.migadu.com with ESMTPS id 26b4e386f3ca03ba;
	Mon, 10 Aug 2026 14:29:14 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
Message-ID: <5b8746d6-09e4-4a28-bdc3-e9a6012db5b4@linux.dev>
Date: Mon, 10 Aug 2026 22:29:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 4/4] net: phy: dp83640: fix per-bus clock lifetime
To: netdev@vger.kernel.org, andrew@lunn.ch
Cc: kuba@kernel.org, richardcochran@gmail.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn
References: <20260810141511.73204-1-xuanqiang.luo@linux.dev>
 <20260810141511.73204-5-xuanqiang.luo@linux.dev>
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260810141511.73204-5-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/10 22:15, xuanqiang.luo@linux.dev 写道:
> From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
>
> Commit 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver
> removal handling") moved per-bus clock cleanup from module exit to the
> remove path. This leaves two lifetime problems.
>
> dp83640_clock_get_bus() publishes a newly allocated clock before the
> driver allocates its per-PHY data and registers the PTP clock. If either
> operation fails, no PHY is bound and the remove callback cannot release
> the clock, leaking the clock and the MII bus device reference.
>
> The remove path can also free a clock after dropping clock_lock. A
> concurrent probe may already have found the clock under
> phyter_clocks_lock and be waiting for clock_lock, allowing it to acquire
> a freed mutex and access the freed clock.
>
> Use the PHY package infrastructure for the per-bus clock. PHY packages
> are tracked per MII bus, and the driver uses BROADCAST_ADDR as the
> package key so the DP83640 PHYs on the same bus share the same clock
> storage. Call phy_package_join() during probe and phy_package_leave() on
> probe errors and in remove.
>
> Serialize the one-time clock initialization with the package lock because
> phy_package_probe_once() elects an initializer but does not wait for
> initialization to finish.
>
> Fixes: 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver removal handling")
> Signed-off-by: Xuanqiang Luo <xuanqiang.luo@linux.dev>

Sorry, PATCH 4 was sent with the wrong author and Signed-off-by email
address. Both should use:

Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang

