Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A9443A86
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788389917; cv=none; b=q7qSos8Ek7UeClOnOW8KEH/s8lDIYMpCxo/Do3hL2cjQfrTpF1v7aI1pB7pGvueG/JLgpRc1K95F6FB2ycahdp8OHg2ECujhDVGed75SRV+SL3dhjSshL8cxGG/fHnvf7vOGUZOlq2nh4FgwDAqX8TF0+uLZhwJYXJB7NJf1mMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788389917; c=relaxed/simple;
	bh=VneFzBugj/kfJvz99X2rDsCHmMVhGYnQa5voXhxQ3Po=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7k2uOw319YxK/RqfABbyG6HCNxxYHxQ3ZyFItD35RHURDD1vbAniDLmc76dfy0wEuJ2UJ1jmthCPn7Q0e//cC/skbl4fuAAAbxYFt5ekiChCA9oiBq4KfNFAzHL9esVrS4a9DhzIQzt/1ezYb4rPyT7jC58eEBw3mY3ahIefcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVds7fkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVds7fkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AA81F000E9;
	Wed,  2 Sep 2026 22:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788389905;
	bh=5iEl6MqRuofjjRdvYG8kYpZfAP9r1v1X/olIxd6EuZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UVds7fkSD66SJt8rgZusngbIwWTdGTQBEgVQAOhuTPEE29/b/eHyqPmgLyog+2FFW
	 j/q75f75onKVpl+34ydrV3qkyehaA6Xj+JxewpteLx4wBTdYxzZizBKl/Yzh/PSm1U
	 IvqzZWNLcP/v4/0cZhsrcOf+yPnklIGvfARr28EogGeuUu2s0BUvhI354buFi8WGaD
	 131mpSOkWr1QcwwhybChuLPiHwQK2eIlG0aWR1hOf64xnKNVLZQvqD3P/c2BP0mpV+
	 0gKOpM2PlqLxbA3ePa0JWvM1tn2y+9Ra13DIR7kHqNZWoX3218RuAflb17D0wEMPoA
	 ff5ks3lXmi6QA==
Date: Wed, 2 Sep 2026 15:58:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>, huhai <15815827059@163.com>
Cc: netdev@vger.kernel.org, huhai <huhai@kylinos.cn>, andrew@lunn.ch,
 divya.koppera@microchip.com
Subject: Re: [PATCH] net: phy: microchip_t1: fix NULL pointer dereference in
 lan887x_phy_init()
Message-ID: <20260902155825.63974224@kernel.org>
In-Reply-To: <a59a2f22-dca0-443b-a0de-f580ed2c4438@linux.dev>
References: <20260902083342.221050-1-15815827059@163.com>
	<a59a2f22-dca0-443b-a0de-f580ed2c4438@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 17:16:48 +0800 Xuanqiang Luo wrote:
> > mchp_rds_ptp_probe() may return NULL when CONFIG_PTP_1588_CLOCK is disabled.  
> 
> When CONFIG_MICROCHIP_PHY_RDS_PTP=n, the stub for
> mchp_rds_ptp_probe() also returns NULL, even if
> CONFIG_PTP_1588_CLOCK=y. Please mention this case in the commit message.

Speaking of improvements to the commits message - please also explain
how the issue was found, reproduced, and fix validated.

It'd be good to improve the spalling of your name (rather just
repeating your email login) a little; or just add your real name in
unicode characters in () brackets, like huhai ($unicode chars) <email>.
