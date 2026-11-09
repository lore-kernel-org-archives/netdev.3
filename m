Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253986;
	b=SwKc16MaMP/Zxx5UnCsrJ94LsoqbgqD+AwFc9tMI6MQ9gCEpGXgZ8MVRWwN9IGcBymqd
	 KUMn+WlFYS2IHiouHYkhXdJwgwnVvBePxjB49L3Y7jCSznoxSx/kOWIFP71gLUacQT/Ky
	 rYpzZqHgyFjDKQ4dTpnlkplQl4TGyLUjdkhM9mfh7vHP3Ul5p4LeLXhH129MWgUUaHSzE
	 Un7nok1TOC3f9qIC7bnLeLc2Jg4cpHO/LjxtAXE47ITXPqkmhaMPoRcwYLw5Kf5hT7Xw4
	 X4cNfg5A/HFnlRJA9w4NT8089KyHuXGQiBe7zt775NPEhy43vvJ9GLj+bYn7GxinR0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gAorfxIyUvbBcX96PfMi8oF/ogo2BfVfyJbNm4STPww=;
	b=CS5nmc1sbPrGupRH1Fvdrwl7BUI25uNo2+oO3yZxFlERgHQinEN5QE0T+kD7OfpxH6lQ
	 c4lPksa8nl+cRvHfv5MW6zYDj0YnUNeXLl/yaKUKrn7FYtSBFg0fo9sQRz2mIZiOSbfl2
	 zL5SLXPsJ72ZVcslU0rPsGE5IoJgFW+Jh2PRggIs0cSQIdKrJ4cI1zMLnrTtbs9qLNp0t
	 bU4yWJQGXaIMuivzdtXdQCypjAJmrCQu99YffcIw2wRgBAMdMr2usZSJ1U0/2BO1RA09u
	 lrcswWiOe+gmqPaaeYFvEQgwGUoAqYwmrLBlcPRLmj231+akK14Cat4v5eF+9/5KRmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qWt7ITv/";
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03C606A337
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D03C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWt7ITv/
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-33e48934fa8so413027eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 11:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253985; x=1794858785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gAorfxIyUvbBcX96PfMi8oF/ogo2BfVfyJbNm4STPww=;
        b=qWt7ITv/CVwWMnO7nbLE6nC1aAG5BonHOqFPfpJ2NRQcvtRZ9dsC5eGGAEcWlg26t6
         +CT7WN6RIUhJbmYItfcn1xjHuwLfuHkFdrNFoMyaEh7XmF7G9+Y9ZIbOCeBk3fneev2h
         /JNu+ddogJjpbCGMh4BbytOPM5alPXMUa5asoR5PHa6t4dfmk1IuMgme4xdsL7hev4Dn
         QItB3o91jx11IjrEGYFriODKb5B4NfjfkLao1NTJ1JOeUtCM8R4zCJNgsaCtDYKG2RI4
         +YE/w2slWhO0xN3ZOsSzSihZE6FMtfO92PwwJLY+wjRg/XtVzhi4mPH+raWRKqayBo+d
         c9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253985; x=1794858785;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gAorfxIyUvbBcX96PfMi8oF/ogo2BfVfyJbNm4STPww=;
        b=H6fgJZDaNCd3f9PowB8nkDz+Q+iDOtb2oD4AeCnrplQo/4ZbnH0RGh2WuVY2PcNM34
         iLr0dXIFbY2gxWrM3fV08atAnoHYLBC6zOpi6JE+swyOgNEymG9Pov5To7sQAvZl3c8H
         TwBpA+WlysGRladh8MQ/F0rquAj9SKcXKum6q1fm0vt6ZhJOBrInR8lesnza9YuumNSV
         XHhxMOLOYugQIO4p1V9hc6Zkz7DTbJ+9QH0Kkju6obgxgvyUAOJD/wMMNpj8+KJ/P5Nk
         YjdYWGHBUWS96wW7Am605LmgpQNqJHCxTnD5FaFdYLGSmawtS8HxAi8F99VkXbLnD0MZ
         RThA==
X-Gm-Message-State: APuU4Z+PM1YNE4nAZOCpQAoBVv8v8KBYp2T48KIC11IVKwIAodq32X94
	OlukHfjFPk2zHwVOGTm4tFRcDNd0ijHG2RDeMV5Mh2hkI4wsbsF4fGbn
X-Gm-Gg: AYBFou2S3mCbvh89207l1/SkFJqynN3W7bbXPl1TdYO193hO4OCra7HUrOWxrDDI/d9
	jnVcTAw2HiKzR1PeIUfFu5m36kkeh61nLU3H8qR/GyiePH+ZSUeWckcqtDrwv8ygLpj/JYID0f6
	huoLR+gA5hIqovTujfkrwAuZrFBhce6yBBTqY2ExYkEuK5HTUocMyAELpI0l/0rjPcvw8xT0coe
	aSGEe6tMKpFrR1ymWd7CUlPI9XmiQJR1WIpydIRFLL1llhyOdalxFzDBUXFloLnmSeg8TxGNGFy
	bkWsicyZnnCwWWg7SEWnQlk+4QQru8nv2t4RS40VfPZ/7sXhxKyAhJrq7FNWnB2fwcpS4S74/l9
	8nvwHzcpXkISE94RyiBujykBesgihrqMcENFW9wgCOAmG6iGMvKUyuJH6eBR14RFxhyJuGI89Xr
	LbXarhrphF+52Ix97BlXaTiPVtHHJb/c+3NyoyCIAQCcr1poVXxGJmGesL9Z9XJwXXM6VQ852Di
	2MENGrESISN12upaZeMVQEN5KBpLqVed6NHL4vrYOYD24R/3zC6FCa++mpbNIcwB6gz29/NL0BL
	CILEyYQ/O0SJW4oZVc8Tew==
X-Received: by 2002:a05:693c:6007:b0:36c:da71:37e0 with SMTP id 5a478bee46e88-3751c6350e1mr401135eec.2.1794253984600;
        Mon, 09 Nov 2026 11:53:04 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:70::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm447069eec.28.2026.11.09.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:53:04 -0800 (PST)
Date: Mon, 9 Nov 2026 11:52:55 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Wei <dw@davidwei.uk>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2 5/6] net: devmem: resolve physical map_dev
 for leased RX bindings
Message-ID: <avIkaDJ_G89_BYH9@devvm16445.scu0.facebook.com>
References: <20261108055809.2122934-1-almasrymina@google.com>
 <20261108055809.2122934-6-almasrymina@google.com>
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
In-Reply-To: <20261108055809.2122934-6-almasrymina@google.com>

On 11/08, Mina Almasry wrote:
> Previously, netdev_nl_bind_rx_doit() passed netdev as both map_dev and
> bind_dev to net_devmem_bind_dmabuf(), so leased RX bindings stored the
> virtual netdev in binding->map_dev without tracking the physical backing
> netdev at all. Unregistering the physical backing netdev while a leased
> RX binding was active failed to detach and unmap the dmabuf.
> 
> Return the physical backing net_device from netdev_nl_get_dma_dev() when
> the RX queue is leased from another netdev, lock map_dev around
> net_devmem_bind_dmabuf() when map_dev != netdev (matching
> netdev_nl_bind_tx_doit()), and assert in net_devmem_bind_dmabuf() that
> both bind_dev and map_dev are locked.
> 
> Because a leased map_dev is reached via rxq->lease->dev and locked with
> raw netdev_lock(map_dev) rather than netdev_get_by_index_lock(), it may
> already have entered NETREG_UNREGISTERING and completed
> net_devmem_dev_unregister(map_dev) before cascaded unregistration of
> bind_dev tears down the lease. Reject binding in
> net_devmem_bind_dmabuf() if map_dev->reg_state != NETREG_REGISTERED.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  net/core/devmem.c      | 12 ++++++++++++
>  net/core/netdev-genl.c | 19 ++++++++++++++++---
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index bb785a871d1c4..2dac581a57e13 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -321,6 +321,18 @@ net_devmem_bind_dmabuf(struct net_device *map_dev,
>  	size_t i;
>  	long err;
>  
> +	netdev_assert_locked(bind_dev);
> +	netdev_assert_locked(map_dev);
> +
> +	/* When map_dev != bind_dev, map_dev is locked via the queue lease
> +	 * rather than netdev_get_by_index_lock(), so it may already be
> +	 * unregistering before cascaded bind_dev unregistration runs.
> +	 */
> +	if (map_dev->reg_state != NETREG_REGISTERED) {
> +		NL_SET_ERR_MSG(extack, "Device is being unregistered");
> +		return ERR_PTR(-ENODEV);
> +	}

And you can call this new lease-valid here as well? Otherwise, the changes
are too LLM-y, testing some super low-level conditions and are a bit hard
to read/follow?
