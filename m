Received: from mta0.migadu.com (out-160.mta0.migadu.com [91.218.175.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3145E26A1AC
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123451; cv=none; b=FkLSXBDiOSUxULn/Tnfny1kvDY3ZXgZ8s8Wcp+3sLOPocGky2CalL1T6le3M7wF/VH4Gae0zA1nsY2wIwLgkyG8hZBDVmZm8TD22QPAGSc5NdIY5ORBq81o7E9ruRpnzwpbQgeOJ/tAQVF6QF4UGbgvTSYb0Wsco2tZahv04x0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123451; c=relaxed/simple;
	bh=yRsnCz6Z1zTV3fHisgw+D/7XSu7IUkTnZoqP0dDh6r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cj2HvKGaKhred/8TrQsNv5T2uPmoF9T5Dl+Bcsq/Qs+uxA+JWoIL//aGQxiEogsuWWSi2flHtBu+xzNZBm7uUG3T0mka6jU5qTWA7rveUbk2bFS6DB8WKGSLqnvlGrgp1NUgsjrSZykkPZPknxHGuTWB7sxcr9NC+Dx2hpvPjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=szR3l1hc; arc=none smtp.client-ip=91.218.175.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="szR3l1hc"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yRsnCz6Z1zTV3fHisgw+D/7XSu7IUkTnZoqP0dDh6r8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787123447; v=1; x=1787728247;
 b=szR3l1hcqmWVsQrSpzlb575Cd37Qh9BjqRQmbKUxl1hVZRL4fhPk4g0kFALUAsyvUq04TfzV
 eCN+uySJM7rfySdyUBVfWUwBdUSqCEB6amnANC2V9RNeu0c2GbQsoA/8OqYVdk5ZPCVO9KkjzED
 IQXInd2HSMUMwuf/o60f+EaU=
X-Envelope-To: netdev@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 0996cf46c951f138;
	Wed, 19 Aug 2026 07:10:37 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <bd7082e6-fc4e-45f5-bd0a-505be79b05d5@linux.dev>
Date: Wed, 19 Aug 2026 15:10:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: macb: Move macb_{alloc,free}_tieoff() out of
 CONFIG_OF block
To: Nathan Chancellor <nathan@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nicolai Buchwitz <nb@tipi-net.de>
References: <20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org>
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/8/19 09:14, Nathan Chancellor 写道:
> Commit 5262eab9462a ("net: macb: allocate tieoff descriptor once across
> device lifetime") moved macb_alloc_tieoff() and macb_free_tieoff() into
> a CONFIG_OF block, breaking the build when it is disabled:
>
>    drivers/net/ethernet/cadence/macb_main.c: In function 'macb_probe':
>    drivers/net/ethernet/cadence/macb_main.c:5951:15: error: implicit declaration of function 'macb_alloc_tieoff' [-Wimplicit-function-declaration]
>     5951 |         err = macb_alloc_tieoff(bp);
>          |               ^~~~~~~~~~~~~~~~~
>    drivers/net/ethernet/cadence/macb_main.c:5973:9: error: implicit declaration of function 'macb_free_tieoff' [-Wimplicit-function-declaration]
>     5973 |         macb_free_tieoff(bp);
>          |         ^~~~~~~~~~~~~~~~
>
> Moving macb_alloc_tieoff() from its original positive does not appear to

nit: s/from its original positive/from its original position/

> be necessary, so move it and macb_free_tieoff() back out of the
> CONFIG_OF block to clear up the error.
>
> Fixes: 5262eab9462a ("net: macb: allocate tieoff descriptor once across device lifetime")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang

