Received: from mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD485412294
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340620; cv=none; b=dIc0ZnudHTb7ehC0Z2Q+bu0zfOmz2C4OQ/A0JV0/v7pCtXB6DHSsXGI78tWXaeVpmk2Yo4VorLVTKSgZ/oGle/IhfVfajrA+EmM4pVnr0sM75O51IQ1vxjflSu6SbNrMyEaEmcU7O/A9DZW0T5r+TSBAtUyPKf+TQ+ExwIZK3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340620; c=relaxed/simple;
	bh=2YBpcQAOPUJ9VseJE3U5VpLyuwZmbH18VY49scieT8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVLRwZwZl47qd1uRyWDtiz6NFO53l7XMGDStxqjIg7eQQkSY8xhMHLrXmkZr+vZ8vOOddkRxNGRKaUzdgpl5U27U+e6IE6hhcENfmfK0XmbJ1FyfqcBfqmkX3/GFORGDxvI7guPuYVZU4ykcugxVOicH6+4/zrqJ0Kgk1Bc9RJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eTfqQ/gG; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eTfqQ/gG"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2YBpcQAOPUJ9VseJE3U5VpLyuwZmbH18VY49scieT8s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788340615; v=1; x=1788945415;
 b=eTfqQ/gGCVf9saaEmYA13NgUaHOgYcNzYMKHHacwkYUho6EPeEYh8iQEfYvbX7MlBLGEBGTu
 i9AGm302CCRT7S/qsMF4BHfBkpZqILVhLwULDD/KY8wAG9Bytugp/ZGfkYs2D69c3TpXZ2/5e6Z
 U+qZFaL/p3XVKQ5Z41Q3paRk=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 70422e1d2167aac2;
	Wed, 02 Sep 2026 09:16:55 +0000
X-Mizu-Trace-ID: 70422e1d2167aac2
X-Migadu-Flow: FLOW_OUT
Message-ID: <a59a2f22-dca0-443b-a0de-f580ed2c4438@linux.dev>
Date: Wed, 2 Sep 2026 17:16:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: microchip_t1: fix NULL pointer dereference in
 lan887x_phy_init()
To: huhai <15815827059@163.com>
Cc: netdev@vger.kernel.org, huhai <huhai@kylinos.cn>, kuba@kernel.org,
 andrew@lunn.ch, divya.koppera@microchip.com
References: <20260902083342.221050-1-15815827059@163.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260902083342.221050-1-15815827059@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/9/2 16:33, huhai 写道:
> From: huhai <huhai@kylinos.cn>
>
> mchp_rds_ptp_probe() may return NULL when CONFIG_PTP_1588_CLOCK is disabled.

When CONFIG_MICROCHIP_PHY_RDS_PTP=n, the stub for
mchp_rds_ptp_probe() also returns NULL, even if
CONFIG_PTP_1588_CLOCK=y. Please mention this case in the commit message.

> lan887x_phy_init() only checks for an error pointer before using the returned
> clock to configure the periodic output pin, which can result in a NULL
> pointer dereference.
>
> Handle the NULL return as PTP being unavailable and skip the event pin
> configuration in that case.
>
> Fixes: 8541fc12edcd ("net: phy: microchip_t1: Enable pin out specific to lan887x phy for PEROUT signal")
> Signed-off-by: huhai <huhai@kylinos.cn>

Since this is a crash fix suitable for the net tree, please mark
the patch as [PATCH net] and add:

Cc: stable@vger.kernel.org

Thanks,
Xuanqiang

