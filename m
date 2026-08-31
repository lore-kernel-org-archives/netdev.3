Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF046A60E
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198434; cv=none; b=PVA5nR+s0nqj+GMcPYhU1XWg7g0fuHC7rOx66b40k8Mwv/U1dyOYasUqbMvppxBVqAbvgC0AfVRmnlUqqSmdRILqVYpPH4xkVD3l+B5f4Fg5wCcW8xnEtUTx8eUOZMmSVepuWBgjY2KZflr+zLeIHHIQyxYc7hNyIBGNmg9UP8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198434; c=relaxed/simple;
	bh=UYFAL6XEkfGhblXElO+TVn78pZ8ye6jID/JzBuYtn3A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=e04gxQGvRuLez//h8d9LH7+p4jlJL3vrQRrVn9ghdNNeJRxJo+N+7bKq9dknZED+qLtqqt+NDuT60+10sL7kBqMXnuNIukmWJdKL3bs0N5OxcyxOBOK97V0n252KtKyTAK6mWtUALZtpBgWMWL8pII8JfJMUYDV3C9ZxsFo0YgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhYz5gqK; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhYz5gqK"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66b32bb75beso3457605d50.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788198431; x=1788803231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NV6WpJz2zvmdKeXrXdy7ZkfRiAgz+ohXDOiQT3pSMUQ=;
        b=LhYz5gqKLpHP8fXIP3g3ZGLgNP6dS/GR0nZDA+5hEf4d70x30P8UtooOT12J38wY4R
         2py3OgSiTl9AV5Ti1hLCuqqq6+12SmfeO9Pb3c46/L+sijLeE2TuuQLMoBId+/99I1Jj
         pajeButb85YwKme0AIoRIkmW1c8UhgTvOWDf4qjQ3rnw4N7bqUEfYdOrukW80SWquoV2
         sZQePVSenKVc2XW+YNGFOy0r6qThGsdEIwIEDlUpUvKkqV4I7wuzYX+NV39k60hU8Zmv
         jLFhkblqG6oQiAsXMo13qSi6MajvkdEhmeLcSL3Rr0+QGooNnbAL/b5NZrfNG1RoxHa/
         Rmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788198431; x=1788803231;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NV6WpJz2zvmdKeXrXdy7ZkfRiAgz+ohXDOiQT3pSMUQ=;
        b=I7gaZlul5Msxm6ApH4aroHlM3kBmkYn0dy2S8e66NGpO9TBYM897WchMh+8lGuVtrB
         g1fYp4Iv1FffkPjk5+lAJKcxf5V4Hg46KK6VaCDYTjxZsVCuoX0Gmjgkyu182bEupFqx
         CR6JEQuE9yg7XJyCV1S6hdnarBHc6L2TEUWzgo6qtoX0+1hCvpJC98Y2aWRgnGlyMUr2
         WniVWqCtXSC+cn/jkNKii3fDA41XMpXSDOYUhi+16kPIB9zLHLDDutcW013//6GvhMPB
         axbrDTNhqemKasl/HD+DkmHP0VGslssLMhP1qpbSXG31Hi7FMP+3TM0xdHRXrXVwB8Hi
         9nUA==
X-Forwarded-Encrypted: i=1; AKwUvBx7gmdTTdPLXBC3t4ilOgwwnV/u5IKWf4CLRolLjayKROIUvJIk+boNralpJbcFgdk3INBjQRU=@vger.kernel.org
X-Gm-Message-State: AFuF++nU9jsanOTtP1NpQUzHXISZcoVus41dA9RyplKVPGzhMwt2dPiK
	i79Zyvi0NsoZWXH4DUY8Z7EVUIA5By+xurHYD09026EZdt06vjySUyTz
X-Gm-Gg: AYBFou3YFtUj6vPT2j+Qw9MtVAWPQpBcw3fAvFS7V0G9hMB844ReOR0UUqFixWvWK9k
	ob1jsNvnz3OaMLpkS5ihcu9qVOolXMMn4yFNzGJ17Qsqw5J8otPxlp/mXBJRLgdg1ml6glEBhJN
	OVjUFnTGOH2a01nMcW6b/bm1vKcthUhQPm0hm4hGqhiqIDhuey4Jg77bqKfWuljkYxGQTQmLKHc
	8OR0uqn9/ks5cyxuBso9OSsEhxjghP3bKB1cWefb7V9qHbkgcUexsr91BtD6E8GfXOXogn3fWdM
	sX8O6x/z0w/Rp/fM3yv3ps5Xi51joO/ooGf9L5zFVW2OIVpoIKkbKrpjcf4NhaZyyOvu5GvQNPG
	gd+YUqC7fklKOuacWEw7c1vEVuxXuz0jm1tre0ocCN2X7jruEr1EVj4I6GFzh7XkIWoOZLGPCNg
	YDqcgjgELfUYG9wKaZ2hWeZmjD+oRuIdXsrK2o2fSC7e74NnVrvGdJ00Wrcrarc+N4FZYSqgUzR
	z2qKR4BhKT9zW4n2fSijVmTQ+SIUjqn1OnpAxnDFA==
X-Received: by 2002:a53:e192:0:b0:66c:c661:3297 with SMTP id 956f58d0204a3-66e4c65bf71mr6308964d50.8.1788198431122;
        Mon, 31 Aug 2026 10:47:11 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ecf1f6fsm6484746d50.13.2026.08.31.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:47:10 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:47:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zhiling Zou <zhilinz@nebusec.ai>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 phil@philpotter.co.uk, 
 vega@nebusec.ai, 
 zhilinz@nebusec.ai
Message-ID: <willemdebruijn.kernel.388312d1b377d@gmail.com>
In-Reply-To: <07d1a274b5144fe2ad8e30a6d3d25a5b8ea88fa7.1787998545.git.zhilinz@nebusec.ai>
References: <cover.1787998545.git.zhilinz@nebusec.ai>
 <07d1a274b5144fe2ad8e30a6d3d25a5b8ea88fa7.1787998545.git.zhilinz@nebusec.ai>
Subject: Re: [PATCH net 1/1] net: tun: reject addr_len changes with active
 lists
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zhiling Zou wrote:
> TUNSETLINK can change a TAP device's address length while packet
> memberships are active. The address lists are keyed by the current
> address length, so changing it makes subsequent membership cleanup
> lookups fail and strands netdev_hw_addr entries until unregister.
> 
> Reject link-type changes that alter addr_len while either the unicast or
> multicast address list is non-empty. This prevents address entries from
> becoming unreachable through the normal deletion path.
> 
> Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK processing")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  drivers/net/tun.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68aa..e5b7729a967de 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3341,6 +3341,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			netif_info(tun, drv, tun->dev,
>  				   "Linktype set failed because interface is up\n");
>  			ret = -EBUSY;
> +		} else if (tun_get_addr_len(arg) != tun->dev->addr_len &&
> +			   (!netdev_uc_empty(tun->dev) ||
> +			    !netdev_mc_empty(tun->dev))) {
> +			ret = -EBUSY;

Insightful comments from the bots

- IPv6 sockets automatically join the all-node multicast groups in
  ipv6_add_dev, so netdev_mc_empty is false for them from the start

- IPv6 membership may already be safe, so could be ignored

- netdev_[mu]c_empty locking requires a different lock held
