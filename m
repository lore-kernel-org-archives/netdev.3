Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476916;
	b=JCKmrnuU1u/LIIZcDH9gP0qf6lV+P1H8NkXZCB9hO6YFhcTF7jvY9EmEYIoMZFa3/Oaj
	 9xXtNZnuM2UV1pYXkWH6PfrFBumix4ZEssLxba5aDF4v7VI6RnLOiFq3ojQ30cRXfUazm
	 OdgYrrXBtWXtaKycY/HK0P9tZY+RB3VW4YWi0g2ZeuYOfaZ+Yoq8RSoMYUhbvVXg8IE8R
	 1h+v/2duyxrB0vk9TxNgPCCENYjfqBwxi8RMhztQXi1vT1RXb6eQf2KHtHSdBT0357gCe
	 fkbznlbl5ox25m4f9pwlxkJbYOIPzsdqL8acdmkV7WEGxsLWuenF0A2OrhbLl9HRZUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476916;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=S1I6Hq1LNxJ2AM3XAIf6COuRQm5+kbnmORhmffuAx1E=;
	b=cs42tKHUIMlMRcUUloTWmUkzCI/moHOS402m8IJLnnndFZDU/z55g/0WQazI2ze5gEQs
	 iNjPniq1PE2U1UnMmBuiSKgO9ZbJ1KQ73NmlkhFiQ2C1AP5nNBpx5k1zCt7IwVe2yIHqb
	 JorJjnbzBT7JcfOT3ZR86j2hTMbPRQi+Mj99pzZ5bh4RFfuCRBjNC+y9vWvHMk5MUrsyS
	 fO1tX3mTDiU5yooNPd9DHhmnHSjJtWk2veCyW6pA48f+TUZCpzBV9Tsea4Wl4GU8P6o+K
	 MJyN/o1mfFpUx2b+XsAj43ye5jNVtNpBApFd0Dg+B0NA7QTRRTXrRHoOYayIMyXPovg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jqc36Bwe;
	arc=none smtp.remote-ip=95.215.58.80
Received: from mta1.migadu.com (out-80.mta1.migadu.com [95.215.58.80])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A0606A33F
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 395A0606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jqc36Bwe
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UzHD0xBypvN0pN6/OIEvkmDF15pe0Kzfmzwbbwx3SyI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794476913; v=1; x=1795081713;
 b=jqc36BweYDZmBlcdZqY8WdSEIykwJhcihOwVZJ3SkVL6iD+HGInr4Dr8GNd27wsy2kvtnsJe
 qJHZObmF0ZRyiMIqBLHvQHT0ITV9xjDwxQXawwWgrzT8H+v1UckOdTQPwrq8xbmxthHvNQRE7DQ
 LV4fq5vAEmo7w7tvzO+PEzr4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 07b5a578b5343b43;
	Thu, 12 Nov 2026 09:48:33 +0000
X-Mizu-Trace-ID: 07b5a578b5343b43
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 17:48:21 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	MD Danish Anwar <danishanwar@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 1342116488@qq.com,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v2] net: hsr: clean up synced addresses and allmulti
 in hsr_del_port()
Message-ID: <avWLZTnYPQJ2-z7_@fedora>
References: <20261112064716.85381-1-sunwenbo@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112064716.85381-1-sunwenbo@cmss.chinamobile.com>

On Thu, Nov 12, 2026 at 02:47:16PM +0800, Wenbo Sun wrote:
> hsr_set_rx_mode() syncs unicast and multicast addresses to slave A and
> slave B devices via dev_uc_sync_multiple() and dev_mc_sync_multiple(),
> and hsr_change_rx_flags() propagates IFF_ALLMULTI via
> dev_set_allmulti().
> 
> When an UP HSR device is deleted via hsr_dellink(), hsr_del_ports()
> removes all ports from hsr->ports before unregister_netdevice_queue()
> leads to hsr_dev_close(). Consequently, hsr_dev_close() iterates over an
> already-empty port list and cannot execute dev_uc_unsync() or
> dev_mc_unsync() on the detached slaves. Likewise, when a slave device is
> unregistered while the HSR master is UP, hsr_netdev_notify() calls
> hsr_del_port() directly without running hsr_dev_close(). In addition,
> hsr_dev_close() does not release IFF_ALLMULTI on slave devices either.
> As a result, detached slave devices can retain synced unicast/multicast
> addresses and an elevated allmulti reference count.
> 
> Clean up these states in hsr_del_port() when detaching slave A or slave B
> by calling dev_uc_unsync(), dev_mc_unsync(), and, when IFF_ALLMULTI is
> set on the master device, dev_set_allmulti(port->dev, -1).
> 
> This issue was identified with the assistance of an LLM-based code
> review tool, confirmed by reproducing the retained allmulti reference
> count and synced multicast address in a User-Mode Linux (UML)
> environment upon deleting an active HSR interface, and verified in UML
> that both states are properly cleared after HSR port deletion.
> 
> Fixes: 36b20fcdd966 ("net: hsr: Add support for MC filtering at the slave device")
> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
> ---
> Changes in v2:
> - Clarify the commit message to explain explicitly why hsr_dev_close()
>   iterates over an already-empty hsr->ports list on hsr_dellink() and
>   does not release IFF_ALLMULTI, answering Hangbin Liu's question.
> - Add Reviewed-by from Hangbin Liu.
> - Link to v1: https://lore.kernel.org/r/20261111060143.183670-1-sunwenbo@cmss.chinamobile.com
> 
>  net/hsr/hsr_slave.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index a546f70f9cc8..bab0c27dd06a 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -245,8 +245,14 @@ void hsr_del_port(struct hsr_port *port)
>  		netdev_rx_handler_unregister(port->dev);
>  		if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
>  			dev_set_promiscuity(port->dev, -1);
> -		if (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B)
> +		if (port->type == HSR_PT_SLAVE_A ||
> +		    port->type == HSR_PT_SLAVE_B) {
>  			vlan_vids_del_by_dev(port->dev, master->dev);
> +			dev_uc_unsync(port->dev, master->dev);
> +			dev_mc_unsync(port->dev, master->dev);
> +			if (master->dev->flags & IFF_ALLMULTI)
> +				dev_set_allmulti(port->dev, -1);
> +		}
>  		netdev_upper_dev_unlink(port->dev, master->dev);
>  		if (hsr->prot_version == PRP_V1 &&
>  		    port->type == HSR_PT_SLAVE_B) {
> -- 
> 2.33.0
> 
> 
> 

Sorry, you post v2 version to fast. Please check if
dev_uc_unsync()/dev_mc_unsync() could be called from hsr_dev_close(). If not,
should we remove them from hsr_dev_close()?

Thanks
Hangbin
