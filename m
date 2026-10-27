Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094007;
	b=I65Kh2Jpdv3r++t9KFXTIoKcQGa6VgH07nRfYA3yLKiah3R2KZyO0xkUoqqZmczqIt5e
	 ELBrqARBX4B556MO+lIlA85L3UwM8xoEVUUk6wheMDAUeUdYg+jQ4lpe4XC1sCEoaTxRY
	 c6ItguCENDfo/Z3sOPD8KKH5lj1E/f3fDU59MkAZOljX6u1jAUFGuGw+yS6BJ07m5iZcs
	 wHXblSqCpiSVCivyTfy5XNTJlx5lhElIzwBdEquieAhMo3Fn0sS1c3UTStw3Gk5C5LtM3
	 xb5E8sxZGm5Zu2nHcX25hD0VWt/OwnGnbD6rWbAAokz6c5k3qsZ0KeZ0eUbJMOcUkJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Epcnjo8vKqnZr0lewtC8oalUp2ngZLe2GtkS1cOfs9E=;
	b=G6Ic8V4jT8Brvd9OxXwSLwq5dbUJ27qifo2wpmEKn6wfXS5e0q+fqeexRN4CTwXPAJ1V
	 IuYnMMrWiuOrQNVVhSAmIFnDNKUR1mdLi2sM3xQcwkWUlbM5S5ToVSMQx9zlz1Ti0Zqph
	 SiO8njpMOFYcWHddT51OEujAr0QPVvpSzNrg7BZC16PLCA1oAMD1nrJKAfJPYov1aaWfJ
	 SRHjvSA3AV7OIPNuPzrMQcUbwMQ54QD5dCLp7gTupADrGxpSHfzXbINYLspM3gG9Pr0XG
	 aIgVoPvRv7VlqiPFp4L6gj43+76y7yLVxXmF1EbqXxY9VGIhCqty1xbteZyTkFYuq4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+4CJoRA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60698606A338;
	Tue, 27 Oct 2026 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+4CJoRA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BE41F031E3;
	Tue, 27 Oct 2026 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094006;
	bh=Epcnjo8vKqnZr0lewtC8oalUp2ngZLe2GtkS1cOfs9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z+4CJoRArW20/wge02oHP4DJww1ImpnrN8aXt5D30ehl6yBxihnU1Gz2cvViwuazi
	 6AuBYTUYs3kq8wqiFpjarHUe9tlcgvEsutz2IHr1kiG5EJSZjzlosVOTTrcZm9bZze
	 lj6PqV9Wfa0ZoRej7sF8C006gIlku8oF85DjlD0JEk54LUGA+9dCyUyenTLuBE+ag/
	 pfuK7kEErOYiyX2HgdHe7WdZMwOi8TWAhKTbwEsZXl3NVyZX2UzkCklZnfbqROW8iZ
	 oY8wXilV+DfrB41EKorTqpnOne0zXj6qG57g1K9wKL1eRuhl7FPxSSIFs00AY8i+ip
	 E1w/mMatLIJwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE71C3AA8FF8;
	Tue, 27 Oct 2026 09:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: tun: hold napi_mutex when deleting NAPI in
 tun_detach_all()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179309400557.3688860.951211168435363811.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 09:40:05 +0000
References: <179268538303.70821.16548460883330758972@gmail.com>
In-Reply-To: <179268538303.70821.16548460883330758972@gmail.com>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterpenkov96@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 Oct 2026 08:26:48 -0700 you wrote:
> With IFF_NAPI_FRAGS, tun_get_user() takes tfile->napi_mutex, gets the
> skb from napi_get_frags() and copies the user data into it before it
> enters the RCU read-side section around napi_gro_frags().
> 
> tun_detach_all() waits with synchronize_net() and then calls
> tun_napi_del() without napi_mutex.  netif_napi_del() frees napi->skb
> through napi_free_frags().  A writer that is still copying has not yet
> entered its RCU section, so synchronize_net() does not wait for it, and
> deleting the device frees the skb while the writer is using it:
> 
> [...]

Here is the summary with links:
  - [net] net: tun: hold napi_mutex when deleting NAPI in tun_detach_all()
    https://git.kernel.org/netdev/net/c/6c799b4998c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


