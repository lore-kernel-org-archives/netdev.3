Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1C3314DD
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382480; cv=none; b=ri+ftJS/Lii+xtVY9/W8PH90W57KWLiQqlE4Fg3uWGJzPOOayrdjCfmJY844X3MYKhxjZJX+LOFG00h93gJYiA1NQ5kIlOK1GBhgZLbyJUqK3XCgwldbW1KXQYQcYrWdvBXoKa9ZzyxHytR2/PDSQz8CZ7+NKZeG5oADp5/dBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382480; c=relaxed/simple;
	bh=e15gRBrIzetrI6KD4QShDQk3TNLCEqY7g/MxM4CS7Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OL4iUpl5a4jSQpKVBlvgSoFu37nzHLSTLr9MP0w4xA+XXpNtb/zzM0rlUmiy+JWRKVYjnAVFofIWr94DnmhrV+YIUwff/t9RPZTSs4sH2vsJAkDyL6AWaZevoRa/QxkYZIGjwbu65pKgSxXIGGHJhQISQs3cyS+uDA8SnvmpvqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xjLZHVnW; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xjLZHVnW"
Message-ID: <3ea3ab8b-6b12-4741-b442-b41a396ec9ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770382468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwxV06tM7H5Mm8XnKv9F0cpXJjB4KJtL/VybwYnpRg8=;
	b=xjLZHVnWfRGt9/1AtxWzkEHINOvdlHQ5R69z8Koo263g8iEiUlOHrlZQCWCNnHwIR4sSvZ
	pckyuHihm2+AA0K4n4D0E9YBGqYaac33sA7MD38eOu2bTn70c0gStHnEaJb3iK/n32fdvq
	s5IQEzuTus9ni4BD2Uy6ujNE1nItlqw=
Date: Fri, 6 Feb 2026 12:54:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] [net-next] hinic3: select CONFIG_DIMLIB
To: Arnd Bergmann <arnd@kernel.org>, Fan Gong <gongfan1@huawei.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Zhu Yikai <zhuyikai1@h-partners.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Xin Guo <guoxin09@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260205161530.1308504-1-arnd@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260205161530.1308504-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/02/2026 16:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver started using dimlib but fails to select the corresponding
> symbol, which results in a link failure:
> 
> x86_64-linux-ld: drivers/net/ethernet/huawei/hinic3/hinic3_irq.o: in function `hinic3_poll':
> hinic3_irq.c:(.text+0x179): undefined reference to `net_dim'
> x86_64-linux-ld: drivers/net/ethernet/huawei/hinic3/hinic3_irq.o: in function `hinic3_rx_dim_work':
> hinic3_irq.c:(.text+0x1fb): undefined reference to `net_dim_get_rx_moderation'
> 
> Fixes: b35a6fd37a00 ("hinic3: Add adaptive IRQ coalescing with DIM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/huawei/hinic3/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/Kconfig b/drivers/net/ethernet/huawei/hinic3/Kconfig
> index ce4331d1387b..02d6f91a7f4a 100644
> --- a/drivers/net/ethernet/huawei/hinic3/Kconfig
> +++ b/drivers/net/ethernet/huawei/hinic3/Kconfig
> @@ -11,6 +11,7 @@ config HINIC3
>   	depends on X86 || ARM64 || COMPILE_TEST
>   	depends on PCI_MSI && 64BIT
>   	select AUXILIARY_BUS
> +	select DIMLIB
>   	select PAGE_POOL
>   	help
>   	  This driver supports HiNIC 3rd gen Network Adapter (HINIC3).

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
