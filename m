Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613148;
	b=saNbDYlwYsftzmcI3IdxfkLIC9ZlnS1nF9PvXoLPGr/GO+t5XSUAI7C5iWaGSbx0qITS
	 /ChO5XHfBvkEluXikq0/kA8A7HMr1C8wkADP8bUdnc24rVD9BlznYFMHXLAQFZCBOvhca
	 3dNC/4/HoB3PNEmUVX2dvXXdYlLYpdEfuDXWkO3Iu/s4GgeYROw9QtZfWx4p9Yb08TTzO
	 G3jdZJ6X/PqI5x7ZWFidBcEYL9yYD7dzwXy93TzMpkjjGrECfJFgzTsVOy/Ftu4XGj0k9
	 aK52axYMKg0l67+ILYcXrlA2HPXd/CfdeEQPQsGZntHTUQTBX74CBhkynGA4iA5n9yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613148;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rZQZ9LD31fveDUvnNj2TrbO5PJhxMz1G61FB7GoabGg=;
	b=zB1R/+4RWaA/BAkN/q9IDsq9fq3jpkrerJ/NkW6Yv7fJg6Uujbs4pbgDzabGqySAljLH
	 5M32ABl1OmLWC6oP/8oABHrlNbFMpgcaeIi6/cSWf80yJQ9+kkRSS+jDEWLeeynJjtj8z
	 iO7lk0AzCkL88ajhnNMn5cBqsFwNJNCgMkM4GgQkWYqRks6Wd0VWua0dZ/RO78HGgZewU
	 sXVzu5tDU5p6IPKwKnRiOtGeMfN8ez+nUC7258h++UMqW8ZmKaYlrvquJmcDV9YTxfzox
	 7ILRhIPYjvZtqK1TvyD3+jiNMbcZhObIVAPYdROZgdTmyw4Dg/nzsaIHFhp5ocgwqtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtTdY4e+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4F606A336;
	Mon,  2 Nov 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtTdY4e+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC991F000C1;
	Mon,  2 Nov 2026 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793613147;
	bh=rZQZ9LD31fveDUvnNj2TrbO5PJhxMz1G61FB7GoabGg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EtTdY4e+ymjbKQD5SPt0J1THvc5M1fEsC7Bbyi06gWTWFkRHSSlDa+oKSiYau/6kn
	 wWt3hXKgFeaaR3uU7HzfkJ1D/yqZWxg4Ld5M6YjOCnTTnp8R6nikvuZAzeG7BNDcLg
	 zytDvA5sJ8klM8Wb82edshgglXaScig0Nq6V6/wg5po8LtaUS8rGPiB5FN+3ldaGg3
	 8uMi8niOy24D2Yvpye4HBCs6y5uIt9xc1B0oV3b+kxNAv9tN9ttLPgI5ayAuwOfFgO
	 h0cDoDJxDq1q7pLHGprMAtnQHgVVMktgKAsxIl05pB703z42mix7RFhMfoKOZpHwVX
	 Dq2dRf8781ZYQ==
Subject:
 Re: [PATCH net v4] net/packet: account user-triggered allocations to memcg
From: netdev-bot+sashiko@kernel.org
To: ahmadag1001@gmail.com
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable+noautosel@kernel.org
Date: Mon, 02 Nov 2026 09:52:26 +0000
Message-ID: <179361314688.3131.15505744143383263524@kernel.org>
In-Reply-To: <20261101094847.664612-1-ahmadag1001@gmail.com>
References: <20261101094847.664612-1-ahmadag1001@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch only partly closes the PACKET_ADD_MEMBERSHIP memcg
  bypass.

--

net/packet: account user-triggered allocations to memcg

This commit changes several AF_PACKET allocations whose size or count is
chosen by user space to use GFP_KERNEL_ACCOUNT, so they are charged to the
caller's memory cgroup. It covers the ring blocks and block array, the
rx_owner_map, the fanout group, and the packet_mclist entries created by
PACKET_ADD_MEMBERSHIP.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index cf6429f094772..ec6ab96c4f87c 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c

[ ... ]

> @@ -3773,7 +3774,7 @@ static int packet_mc_add(struct sock *sk, struct packet_mreq_max *mreq)
>  		goto done;
>  
>  	err = -ENOBUFS;
> -	i = kmalloc_obj(*i);
> +	i = kmalloc_obj(*i, GFP_KERNEL_ACCOUNT);
>  	if (i == NULL)
>  		goto done;
>  

[Severity: Medium]
Does this fully close the PACKET_ADD_MEMBERSHIP bypass described in the
commit message?

For PACKET_MR_MULTICAST and PACKET_MR_UNICAST, packet_mc_add() then calls
packet_dev_mc(), which adds the address to the device list:

packet_mc_add()
  packet_dev_mc()
    dev_mc_add() / dev_uc_add()
      __hw_addr_add_ex()
        __hw_addr_create()

Each distinct address gets a struct netdev_hw_addr, and that allocation
is not charged:

net/core/dev_addr_lists.c:__hw_addr_create() {
    ...
	ha = kmalloc(alloc_size, GFP_ATOMIC);
    ...
}

A struct netdev_hw_addr is about 104 bytes (kmalloc-128). That is larger
than the packet_mclist that is now charged (about 72 bytes,
kmalloc-cg-96). Neither packet_mc_add() nor dev_addr_lists.c limits how
many entries can be added.

On devices with ndo_set_rx_mode_async, netif_addr_lists_snapshot() ->
__hw_addr_list_snapshot() also makes two more GFP_ATOMIC copies of each
uc/mc entry. These copies stay in dev->rx_mode_addr_cache, which is only
flushed in free_netdev().

So a CAP_NET_RAW user in a user namespace can add many distinct
MR_MULTICAST or MR_UNICAST addresses on lo. Each one still pins more
uncharged memory than gets charged.

Would it make sense to also add __GFP_ACCOUNT to the allocation in
__hw_addr_add_ex(), which runs in process context?

The commit message says:

    100 sockets with 2000 PACKET_MR_PROMISC entries each
    on lo (45220 KB used, 124 KB charged) behave the same. With this change
    all three are stopped by the cgroup's OOM killer.

PACKET_MR_PROMISC only calls dev_set_promiscuity() and never reaches
__hw_addr_create(), so the reproducer does not exercise this path.
Should the commit message be narrowed, or should the device address
entries be covered as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101094847.664612-1-ahmadag1001%40gmail.com
