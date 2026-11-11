Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402151;
	b=QIUbUyxRom+FN/VCnleeebBtvOpXOnfQPP45ulzI7YOLB6JmL/fvhlE4mC6kMJCa/7lV
	 706PIGqdrnWtnb0xdlapK4h7cLzQeJ5KBZAUdIPrK0Ce7CQl2oD8jKBY/CCLE0KMGNGiP
	 Du33TWbejPSb2a1h1Wpjs+SyztvfewRRq8FUA5yrv3g2P0q8JdPIVUIPkd2/XE+mXWpoO
	 ELfKxXO1Y6iSyQlGikt0G6rKa2RxGBtAaeQov/JAbx0b4QGq2JfdHUJQ6NjXu+GOyIxlZ
	 EM1yUBrTPD0GmOLxmHr0k13xM+do/gmZKUDA0AE50N5JirazWwpYWF4MVlVTE+THztg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402151;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZmjCZzov7nJPqrXQ8bns94ZLa5rs46LAAXyoFHfy5LQ=;
	b=vGMNvylcrbV4UHCbmsshLDhpolzQSFq2e2vZZOZzKSzZA/kCC6K/1sELa/6AHHUO0rJR
	 gq0CjcmZkrsG2j/iz70Idveydzp6km9i6KDmT7fH215uc0sYFPOwswVJSQSkmslqyv1sY
	 cDLfqB/TvyIwmvYY8yROAOJTTQeb5qZbIKogIBdYVXs0AKbRVdFA/6+FEmIcu+l9Q+BJO
	 Yy9LD5woJa0hm+xRBpGaSBsjPHpRp0P8VI3Rsc/PrhPF0bzCfTLnpywD8GVME2I1EmUw0
	 DCWvO/qFF6lDQhjrcD1jyKE7b8qs/e/dZnETVx8+Q0S59xR62UgP1kVHrN96kGZEDPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o92QQvLv;
	arc=none smtp.remote-ip=91.218.175.182
Received: from mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A65606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26A65606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o92QQvLv
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=creIoMaV/TDbJJXHBFgieSAYV23IyjnaN5agwm7HWcI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794402149; v=1; x=1795006949;
 b=o92QQvLvTiVOT85rEhrXY7WZigN9PTIc0TdKCX3N9uXsbP8w3IsKMNjBxKUcp1QcOMBmm2cf
 ovAPzIzAwpc6hYYnVfCCMwrdJSNL/BwrbAv7h5bqRsYXE5+qz7ZnBSEWv/MIYOBCFBHz8cD/Ecy
 l3D8gm98aA/wmM+8iMlnGUc4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id bc78005be9f94d47;
	Wed, 11 Nov 2026 13:02:28 +0000
X-Mizu-Trace-ID: bc78005be9f94d47
X-Migadu-Flow: FLOW_OUT
Date: Wed, 11 Nov 2026 21:02:17 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Mahesh Bandewar <maheshb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 1342116488@qq.com
Subject: Re: [PATCH net] ipvlan: update port flags only after
 ipvlan_set_port_mode() succeeds
Message-ID: <avRnWUbGFbdfirZB@fedora>
References: <20261111064655.233265-1-sunwenbo@cmss.chinamobile.com>
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
In-Reply-To: <20261111064655.233265-1-sunwenbo@cmss.chinamobile.com>

Hi Wenbo,
On Wed, Nov 11, 2026 at 02:46:55PM +0800, Wenbo Sun wrote:
> In ipvlan_link_new(), the shared port->flags is updated before
> calling ipvlan_set_port_mode(). If ipvlan_set_port_mode() fails (e.g.
> switching to L3S mode without CONFIG_IPVLAN_L3S), the error unwinds via
> unlink_netdev, but the shared port->flags has already been modified and
> is never restored.

If ipvlan_set_port_mode() failed, the unregister_netdevice(dev) will be
called. Does port->flags still need to restore?

Thanks
Hangbin
> 
> As a result, subsequent operations on existing ipvlan interfaces on the
> same lower device operate with corrupted port flags (e.g., VEPA or
> PRIVATE flags inadvertently set or cleared).
> 
> Fix this by deferring the update of port->flags until after
> ipvlan_set_port_mode() returns successfully, matching the behaviour of
> ipvlan_nl_changelink().
> 
> This issue was identified with the assistance of an LLM-based code
> review tool, confirmed by reproducing the state corruption in a
> User-Mode Linux (UML) environment when ipvlan_set_port_mode() fails,
> and verified in UML that the shared port flags remain unchanged upon
> failure.
> 
> Fixes: a190d04db937 ("ipvlan: introduce 'private' attribute for all existing modes.")
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
> ---
>  drivers/net/ipvlan/ipvlan_main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> index f29864db662a..5732b167c5b3 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -678,12 +678,6 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
>  	if (err)
>  		goto remove_ida;
>  
> -	/* Flags are per port and latest update overrides. User has
> -	 * to be consistent in setting it just like the mode attribute.
> -	 */
> -	if (data && data[IFLA_IPVLAN_FLAGS])
> -		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
> -
>  	if (data && data[IFLA_IPVLAN_MODE])
>  		mode = nla_get_u16(data[IFLA_IPVLAN_MODE]);
>  
> @@ -691,6 +685,12 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
>  	if (err)
>  		goto unlink_netdev;
>  
> +	/* Flags are per port and latest update overrides. User has
> +	 * to be consistent in setting it just like the mode attribute.
> +	 */
> +	if (data && data[IFLA_IPVLAN_FLAGS])
> +		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
> +
>  	mutex_lock(&port->pnodes_lock);
>  	list_add_tail_rcu(&ipvlan->pnode, &port->ipvlans);
>  	mutex_unlock(&port->pnodes_lock);
> -- 
> 2.33.0
> 
> 
> 
