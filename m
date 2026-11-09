Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253984;
	b=OmVTGMl+3VjyD/WbjLfFDP0p3dPAXRg+vVwczTof/pS8abUYISVqDq9US9eIXSO9ga0a
	 wl24VS44my3YENW4smB1dqu6I6h9/8u4RdMMgbc/k4OD/Z/mLr0L2vUUNDAXwX9yL/0FW
	 g7xVuOEECsnIyg+npRBoUMkc4m0WeTlZ1G/TZofe2pijU8QLHNNwAFah19wqXbN2fjijF
	 Keic+D8AUPuMCXKnud+cFonRcObC+QE5h8i5otSK6BWxQdZqfj08Hq5NExAjvAJzm7eSA
	 LiExFatquHr1N/HsM3f92nvOM+uzO8JV+EaL9Lj9iwtGqhhTJPq91+oMUDI3OHqyBAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FMtzZSTePsqyAZZxCGo8MwfwBr67cppzq+ZS1S4y9wI=;
	b=Y4YfystU7iF2QcgK9V7FgfjpCdoInGrEY88XNNDuGko2EAFF4u8mV/cDIjyjBdIMykge
	 Danzk/XxOti9VcLTHjlpNex7Ul9leAUWdQ7lo0HOAIlJ06cNg1XWAqg3n8ighjw7w19z3
	 FOAQfsBH49aR7Z/0NPuf7JrCxEm+htmXHsUYGCkV76DMIUE19q31KtZesnDnmPXv/tLeL
	 +suzaDD62t5E6T5/AMrkw9FxfghySCI2nWXDVLAORiikF5h6CZjjUKYkCXX+CT13vRJMe
	 uEqccJeUvdl+bHlhH/YWbvFa4V80yWGNULVvlFzzw9NW30bTh9KIaRW5VaSitb6GtTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNCWuayX;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A12606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77A12606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNCWuayX
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso982437eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 11:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253983; x=1794858783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FMtzZSTePsqyAZZxCGo8MwfwBr67cppzq+ZS1S4y9wI=;
        b=PNCWuayXaw6cdsnihksxBFStS1vdDbWuT5N2TsQ7QXhUAMyQtRbJLKqVNoaOEG1Vs8
         QoXGYdLae7VvZIScE77VdhcODq5NFWR1ZA0LkVPG1k8npy6YIHYEyQGUTP3MwnYbZ67P
         SgvwBWSrWuh2CsR3GK6Ez9wvx22SokHJMaVrDKnWoMPan36LxuxrrtWX2G0mCD8BmmPS
         XXpcbQAudBOVxiB82PHK9SxAV9eypHgAC+4YBGaCP/JiJyZZ6hwlZU4f/XZr5Ms1+HLR
         StnrhupHc2YUYWtj5ZEuU8xIe0LunAUh7CTt4rhkHvORHsC7hxyT/NVmsZC9tM7rA8qg
         eOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253983; x=1794858783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMtzZSTePsqyAZZxCGo8MwfwBr67cppzq+ZS1S4y9wI=;
        b=AUMQuSijsjdfQ+GUIqncAYHBvcqAqnBmvtJSxpu4ouLMbia632YXYAKWRXYpB+vWSu
         Mgojr5yRdLU8taOeg4MJ9bpZEpj11nh1ESzeGBea5hqWNhcY01H6l4CzI8PWBC7xEiA+
         Kht3gddzJ431cfjm3uhEGcOvRxeBA9cpwxpWmy0xaLsZzp42M33eG2IFf4x+z1/Tux54
         HUF6VFjPR6fIqYoEmB+OjggYPhTp6zPO17VHPIpuJ4v1tCfSSAJ6tE/kHjYAwAqQ3vqv
         mmzepaAWCjT2ohojtK3NgNQdBwmqVNVcMhDVPreCvBFh3zmTnNiw4Gtvx/Do8nNDb7fo
         cl6A==
X-Gm-Message-State: APuU4Z8pr/tUDWU2jTUG9hwZ97LM6qGnmJ17NGdPplaMnD8jpRgICZaV
	/fWIxjstFm1KY6n8kS4/NZBR9ZLieqnhl6ekcI7Giy2CyhEE2Hy70a1J
X-Gm-Gg: AYBFou2EvKrUlOZ84ygsJEptJX9CmPDEiI8rgyLOXxJ9dYXY4EBy5fgfvDJYqH2Znpn
	UECWdvjDkTRu/WqASMFDcCp5raaBW+yAOzygTzYcp7SFy+gXv+mdHz4bUT6wIkhRGgTYN4gbyWX
	oaXtQHN0rPGVbc9X9km1D3u5gwWKwrpETmtLjJ9A3rmGlT15n7Xx7xPYybHeaL4IkJA+E6d/2gW
	hppyCd/Kt9KUDMnZLapShvZh5AIkI4Zq4S/huAUmHN8JrRPNZBokYL/wQjElOa4S6iuYAnoNwcT
	Mxx6b4ELcnu6MwKuPbNGqMJyARmgGgnJT65xrrxyP9yyc68/YqS9/clpbMrO2GMFhWkOBCQJd0Q
	0A2zfg9HJHaDgSkvjrue0S8O5WU7pk8KMUZl2gxA1yq7VQIS0lN9yZNPJw7hRhRMHitr9oJg0Mi
	O5B5GrX0oRteCc0R1xrWkJydY1p+TfFG0F8fKVxalCQlLp5uWIyEmT0mCWyQn8wPt3oh/QSjCVH
	oO/17CeeE0/xcpe176Wo+oyDjYq+4I+lywkD0jx7Bmzh69O1Mi9C/iJK7a3izjCvgk9sfXNILGZ
	yh9l3lCI/WxBlXwJjukMdA==
X-Received: by 2002:a05:7300:a8d:b0:36a:75aa:33bc with SMTP id 5a478bee46e88-3751f56033dmr328827eec.24.1794253983392;
        Mon, 09 Nov 2026 11:53:03 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:66::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm839952eec.18.2026.11.09.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:53:02 -0800 (PST)
Date: Mon, 9 Nov 2026 11:50:48 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Wei <dw@davidwei.uk>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2 3/6] net: guard memory provider RX queue open
 and close on unregister
Message-ID: <avIbO71p_947-PIf@devvm16445.scu0.facebook.com>
References: <20261108055809.2122934-1-almasrymina@google.com>
 <20261108055809.2122934-4-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261108055809.2122934-4-almasrymina@google.com>

On 11/08, Mina Almasry wrote:
> When a memory provider RX queue is leased to a virtual netdev,
> netif_mp_open_rxq() and netif_mp_close_rxq() redirect through
> rxq->lease and lock the physical backing netdev directly rather than via
> netdev_get_by_index_lock(). This raises two issues during netdev
> unregistration:
> 
> 1. In __netif_mp_open_rxq(), the physical backing netdev may already be
>    in NETREG_UNREGISTERING (after dev_shutdown() and
>    dev_memory_provider_uninstall() have run on it, before cascaded
>    unregistration of the virtual leasee tears down the lease). Reject
>    opening an RX queue if dev->reg_state != NETREG_REGISTERED.
> 2. In __netif_mp_close_rxq(), when the physical backing netdev
>    unregisters before the virtual leasee, dev_memory_provider_uninstall()
>    on the physical netdev does not uninstall the virtual queues, so
>    phys_rxq->mp_params remains populated until the virtual leasee's
>    netif_rxq_cleanup_unlease() or socket teardown runs. At that point
>    the physical netdev has already gone through dev_shutdown() and must
>    not call netdev_rx_queue_reconfig(). When dev->reg_state >
>    NETREG_REGISTERED, clear rxq->mp_params and return 0.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  net/core/netdev_rx_queue.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index a7261fedd5e76..85ae5abf16b8e 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -193,6 +193,14 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  	struct netdev_rx_queue *rxq;
>  	int ret;
>  
> +	/* A leased physical dev is locked via rxq->lease rather than
> +	 * netdev_get_by_index_lock(), so check reg_state under its lock.
> +	 */
> +	if (dev->reg_state != NETREG_REGISTERED) {
> +		NL_SET_ERR_MSG(extack, "Device is being unregistered");
> +		return -ENODEV;
> +	}

nit: wonder if we should keep lease vs non-lease handling in the callers?
netif_mp_open_rxq/netif_mp_close_rxq already handle this, and __ variants
seem to be unaware of the leasing abstractions.

Maybe put them into some new lease-valid helper? So we can keep these
tricky details in a single place, similar to netdev_put_lock?

  netif_lease_valid() { return netif_is_alive && netif_device_present } ?
