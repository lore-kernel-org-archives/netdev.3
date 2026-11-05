Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916853;
	b=C5YCW7WUupozhYxL0JwshXKg9eZKPwGfeeohrRWPjNp1ZuObI6N1KZGi2wYWLTg9QxN+
	 Ye56HUNXvAFsxY+x97TMInfdhGAo8IU2bJLAfTpx9KimpVh6ggk8AmBePEcH3GUDkBTRR
	 5jgiylS2R4Mqtc9OqmnJjRY0HK8plqfsGEet4+P9k8JufGvt/bayhmB/NWohv0Y0456cR
	 vdAE9Nsy5NRmkB+5eKnfxeSOqi6bhSYnLB6P+qIzfDokht+TS4GBl6XWJS5sj8YF10rXl
	 h1NX5SUQ9175zHN/a9Qb72JH5D4pRMrOgf6Hg+qF11hMWmBSu36niXj7a+BBtsdmgMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916853;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZOUsTfcBcuVJ6gLGMQ6tAEOI9CGBgTAWtYSuv6u4PGg=;
	b=llT93MtL4geaJZ6sSjUdsO4FvykMZgDyeIidMewSS8C4BTBaLbn5Wa/vWDwD3IqFdUip
	 EcqjAU1k5c/61f1xZfBiYgZ03PE+F80cwvEfKEyczlofHTl1ZeQ85xJaIVLb8RXdH2FSq
	 NFyktop1AJ93Q2psaTymSZy5l7//fsoxENPQ77QrmN2kPKtSF6uR/JrxeEOBN9WWJUd4T
	 WHEcaWvbqSAJ+N3Fj3Yy6mLzWezjz3pFVCbKXhUQBUJzt9Uw7Kecy//+eofpM1uimwrb1
	 dnXn5S9OxxEHCi1E8424pd9jAJ/t7T5vIXU/PBbl9ViKyM+YuUBlNVG/YWESYLg+VXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FqI5VcPT;
	arc=none smtp.remote-ip=95.215.58.1
Received: from mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93D606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D93D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FqI5VcPT
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5zm3bZakGmybjvQK0MMBjwto+FXGetyeWyr+G3hY9W0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793916850; v=1; x=1794521650;
 b=FqI5VcPTNmLYhp+5oqltZz4rrqkX+tX5jzl5+t6tV/S+rQaXObybFlIaJEz0+ltRbV8ky7LJ
 7Ddwrr8Gjng0OLPqWqcTBY9+7PvFIirQCALkUdGQdW8pyxIdSYMjzgyPVoCaQi76sggiftfej47
 bBp4e63raCiPUhpSarMvsQSQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c05158efb375ae9f;
	Thu, 05 Nov 2026 22:14:09 +0000
X-Mizu-Trace-ID: c05158efb375ae9f
X-Migadu-Flow: FLOW_OUT
Message-ID: <546481b8-43b3-4812-9b04-78367a071453@linux.dev>
Date: Thu, 5 Nov 2026 23:14:08 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] dpll: notify about a reference sync pair only if
 it was added
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Milena Olech <milena.olech@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Michal Michalik <michal.michalik@intel.com>, linux-kernel@vger.kernel.org
References: <20261105131145.1010406-1-ivecera@redhat.com>
 <20261105131145.1010406-2-ivecera@redhat.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261105131145.1010406-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2026 13:11, Ivan Vecera wrote:
> dpll_pin_ref_sync_pair_add() sends a pin change notification even when
> xa_insert() fails and nothing has changed. zl3073x gets -EBUSY when
> another channel has already added the same pair and ignores it, so user
> space is notified about a change that did not happen.
> 
> Send the notification only after a successful insert.
> 
> Found by code review. Reproduced on a ZL30732A board with kprobes on
> dpll_pin_ref_sync_pair_add() and __dpll_pin_change_ntf(): loading the
> driver adds one pair twice and the add failing with -EBUSY sends a
> notification. With this patch it does not, and the successful add still
> does. A test module adding one pair twice shows the same on the monitor
> group.
> 
> Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 8389983f425695..277692d12d3d1e 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -1081,7 +1081,8 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
>   	mutex_lock(&dpll_lock);
>   	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
>   			ref_sync_pin, GFP_KERNEL);
> -	__dpll_pin_change_ntf(pin);
> +	if (!ret)
> +		__dpll_pin_change_ntf(pin);
>   	mutex_unlock(&dpll_lock);
>   
>   	return ret;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
