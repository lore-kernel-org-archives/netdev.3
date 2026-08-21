Received: from mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0663DDAED
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305341; cv=none; b=niOzxClimtvcR61x79DDee94tqZn2wdwSeI6797nofSq5SgKRGUUs/ncHpfwbQWsjGHvl4QXpWAcVdwyUHRwSPiFFIUAppz08v8zli5DtMQQ3DdDlhlUwoAYDk4idGJQDNTbqOuunn3Vc3YCW7XZZMi7L5UJowZAaU2dU+gy+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305341; c=relaxed/simple;
	bh=Rxfi0wehmMz5zSrQZjn/MPFcE7dvwqlrAiXUCl2TjJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKrXxkhYtXBjpcM9rApPz8JiNNTjNKx+ZRLSPr02Ho37k3ZLYl+rQOm6Z1+o3GW4nSFgqyAv8QZGdHUFM+LRn7GjhpPQUPGtSb0yQZ9JE7o9CFrFqapLx8LZsVj28Gap21DJp71+6tZIPkdPXlT52kWN2ssjwNShRdMWWvWXDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UhJEpVZT; arc=none smtp.client-ip=95.215.58.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UhJEpVZT"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Rxfi0wehmMz5zSrQZjn/MPFcE7dvwqlrAiXUCl2TjJg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787305328; v=1; x=1787910128;
 b=UhJEpVZTtbbQqFcrIqr3Q/0sGemwzuxFT5h3xGrIakKUwzs8hnZZF7hG9oopal1EDZIYMt5F
 smrPobJZr9ffnHjYg5Br+jPNmoNzM6BA69K3BMm59tBUWaBrKnzwKmrX1a+p+A34f+wzG5cd3ml
 A5ty5jTP10UApEj+zB8VyTR8=
X-Envelope-To: netdev@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id e00fe8bc45fea054;
	Fri, 21 Aug 2026 09:42:08 +0000
X-Mizu-Trace-ID: e00fe8bc45fea054
X-Migadu-Flow: FLOW_OUT
Message-ID: <3d9ee2ae-aa8d-41d3-b034-956c9003d2f2@linux.dev>
Date: Fri, 21 Aug 2026 17:42:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 5/6] net: phy: propagate errors from default port
 setup
To: netdev@vger.kernel.org, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 kuba@kernel.org
Cc: hkallweit1@gmail.com, qingfang.deng@siflower.com.cn,
 hao.guan@siflower.com.cn, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260821070327.16147-1-xuanqiang.luo@linux.dev>
 <20260821070327.16147-6-xuanqiang.luo@linux.dev>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260821070327.16147-6-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/8/21 15:03, Xuanqiang Luo 写道:

> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> phy_default_setup_single_port() ignores errors from phy_add_port() and
> always reports success. If a PHY driver attach_mdi_port() callback fails,
> the phy_port is leaked and PHY probing continues without the expected
> default port.
>
> Destroy the port and return the error.
>
> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

I realized I made a mistake.

The Reviewed-by tag added to patch 5/6 should be:

Maxime Chevallier <maxime.chevallier@bootlin.com>
rather than:
Andrew Lunn <andrew@lunn.ch>

Sorry for the mistake. I will send a corrected version after 24 hours.

Thanks,
Xuanqiang

