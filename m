Received: from mta0.migadu.com (out-117.mta0.migadu.com [91.218.175.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FED3845A4
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848545; cv=none; b=oi4XdcaZHIfNLiJ9/bniRyDL26rbzsp0DxJr0sdTZo9xroIAz3YU9m3BLcJ4+EFJPceSkEs1P+b24mCoOZCN5UfgUJnrf8do8HwVNUKF4F9QSkBBKlGLY+wKWo30YfkotJK0OekSBa3T2BpdbLJ36y1qAtR/FVYw34ffk2Rsj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848545; c=relaxed/simple;
	bh=z0MVAooCmQ3rZNmO0VCYVTgDQhlmc13rqoT9wo169BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0x0fJBhdDPQEXtw2I3YetN25MzW3FhUKVSkp64Q4R/QlCAdvowLYaOMzs7iUIzaUf2738l0L4+ppbpI5/xs5D4xsmlP6KJ/Plq2FkfzJIoMgmoiWbf45G4mGsohf4qZJP+zVt+t22/5FKK4vUqQ/AkTkrfUSgzKPeafK/FToBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FQc8V1oK; arc=none smtp.client-ip=91.218.175.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FQc8V1oK"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z0MVAooCmQ3rZNmO0VCYVTgDQhlmc13rqoT9wo169BE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788848539; v=1; x=1789453339;
 b=FQc8V1oKBmRocgDHXCKMMxfQRrFh69ApwKYSbOzPgSey6FyOY7rHCKZ0K5GT/vXAL6S2/IwG
 CEET4Q34UbvmkvTtESDyiQtr5fISi3e/mLuzlpsNH3g1g9OYuyHcRaFw3HphmCw1cVFaIvLKMnB
 OeizhUt8IadYeZM4A++u+W+E=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 14da612d3da88a82;
	Tue, 08 Sep 2026 06:22:19 +0000
X-Mizu-Trace-ID: 14da612d3da88a82
X-Migadu-Flow: FLOW_OUT
Date: Tue, 8 Sep 2026 14:22:08 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: faicker.mo@gmail.com
Cc: stable@vger.kernel.org, Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: net_failover: Fix the deadlock in
 net_failover_slave_name_change()
Message-ID: <ap-pkHCX6O5AOEIz@fedora>
References: <20260908040708.3972058-1-faicker.mo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908040708.3972058-1-faicker.mo@gmail.com>

On Tue, Sep 08, 2026 at 12:06:29PM +0800, faicker.mo@gmail.com wrote:
> From: Faicker Mo <faicker.mo@gmail.com>
> 
> This is a sibling fix of commit
> b84c5632c7b3 ("net: net_failover: Fix the deadlock in slave register").
> There is netdev_lock_ops() in the upper callers, so using netif_open()
> instead of dev_open().
> 
> Call Trace:
>  __schedule+0x2bb/0x650
>  schedule+0x27/0xb0
>  schedule_preempt_disabled+0x15/0x30
>  __mutex_lock.constprop.0+0x550/0xaf0
>  __mutex_lock_slowpath+0x13/0x20
>  mutex_lock+0x3b/0x50
>  dev_open+0x3b/0xe0
>  net_failover_slave_name_change+0x22/0x40
>  failover_event+0xd4/0x1e0
>  notifier_call_chain+0x62/0xf0
>  raw_notifier_call_chain+0x16/0x30
>  call_netdevice_notifiers_info+0x50/0x80
>  netif_change_name+0x200/0x330
>  do_setlink.isra.0+0xb12/0xdf0
>  ? security_capable+0x9a/0x1e0
>  ? ns_capable+0x31/0x60
>  rtnl_setlink+0x302/0x670
>  ? netlink_recvmsg+0x296/0x340
>  ? security_capable+0x9a/0x1e0
>  ? __pfx_rtnl_setlink+0x10/0x10
>  rtnetlink_rcv_msg+0x384/0x460
>  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x61/0x120
>  rtnetlink_rcv+0x15/0x30
>  netlink_unicast+0x28f/0x3c0
>  netlink_sendmsg+0x216/0x450
>  __sys_sendto+0x222/0x230
>  __x64_sys_sendto+0x24/0x40
>  x64_sys_call+0x1d5d/0x2390
>  do_syscall_64+0x105/0x5a0
>  ? do_syscall_64+0x140/0x5a0
>  ? exc_page_fault+0x94/0x1e0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> Signed-off-by: Faicker Mo <faicker.mo@gmail.com>
> ---
>  drivers/net/net_failover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
> index 3f7d31033bae..1b5213e87070 100644
> --- a/drivers/net/net_failover.c
> +++ b/drivers/net/net_failover.c
> @@ -675,7 +675,7 @@ static int net_failover_slave_name_change(struct net_device *slave_dev,
>  	/* We need to bring up the slave after the rename by udev in case
>  	 * open failed with EBUSY when it was registered.
>  	 */
> -	dev_open(slave_dev, NULL);
> +	netif_open(slave_dev, NULL);
>  
>  	return 0;
>  }
> -- 
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
