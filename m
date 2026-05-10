Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461219D093
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426711; cv=none; b=XCcnHCTdNg8ug8QjDyFMM1+8+aGeJnXI/6e0MQ7r/S4iumZoCdifrkpMNtRv2aPYp2utJPwLVYxVf7rYg/xQEK+Rd/juQ1LUMbRdwvCnkUbTLUtJViRwSLfSnRzHBZ4Fvvl7iR8TMa9u9qugurUs6U+6Ei6t2C6Wae40nO3LgBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426711; c=relaxed/simple;
	bh=PyglUDG1Hdu/FWRtdbP7LJF86LI5UNikPQQr9L79KLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbm9/NMGAD0H/uPmz79e4+ESvWh6avqhR364QyzHI3skp0lQIrvU32spPq8+iaBK/Bke467H9j1Y0Sz5aGWvJ5p9S5GeM8ace/PdI35ZKoKi4wNevgUvIgAJHnIgzQgE418tfnzEGkyLakjLP9Czk+73jN+HvMpIeYzfb3vXKn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOpdieq2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOpdieq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683FCC2BCB8;
	Sun, 10 May 2026 15:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778426710;
	bh=PyglUDG1Hdu/FWRtdbP7LJF86LI5UNikPQQr9L79KLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aOpdieq257tGUKlFgHI2qhnPeCiaOAk6IpSewZWNbg2PQo1lTRVz9PRkrByynMLuk
	 P28oLBb+8Vc/JLqf3qez6RrID7HLxwUEdx7lPAHgvARTlm6MNbR6JzNMv/DgMIYgqY
	 OroQ1vYzwdySMQRePr0DNUqNWvcf0ipn2ZvkZWnexZHkXFWF1WzKu57SdZLw2edj+T
	 +sSC75URsCaXNRkPrl7ZRzZZNR+MSpu//UnWTo1qNo63Oic1OzSQGtM3i+NcXdhsLR
	 TgZuy4u8Uw9pkWWnXtdGgu3D4VowwztPF5CY2kFdr27OaH2YHXH7QV0crJxRKnG/Uz
	 FxDQtTFCt0HNg==
Date: Sun, 10 May 2026 08:25:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <20260510082509.1530a1a3@kernel.org>
In-Reply-To: <20260509181825.1523951-2-bestswngs@gmail.com>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 11:18:26 -0700 Weiming Shi wrote:
> __team_change_mode() clears team->ops with memset() before restoring
> safe dummy handlers via team_adjust_ops(). A concurrent team_xmit()
> running under RCU on another CPU can read team->ops.transmit during
> this window and call a NULL function pointer, crashing the kernel.
> 
> The race requires CAP_NET_ADMIN (in init_user_ns) to trigger via
> TEAM_CMD_OPTIONS_SET, plus AF_PACKET sendto() on a team device with
> forced carrier and no ports.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  Oops: 0010 [#1] SMP KASAN NOPTI
>  RIP: 0010:0x0
>  Call Trace:
>   team_xmit (drivers/net/team/team_core.c:1853)
>   dev_hard_start_xmit (net/core/dev.c:3904)
>   __dev_queue_xmit (net/core/dev.c:4871)
>   packet_sendmsg (net/packet/af_packet.c:3109)
>   __sys_sendto (net/socket.c:2265)
> 
> Fix this on the writer side by replacing the memset()/memcpy() with
> per-field updates that keep transmit and receive always valid via
> smp_store_release(), paired with smp_load_acquire() on the reader
> side. A synchronize_net() before exit_op() drains in-flight readers
> before tearing down mode state.

Barriers are between things. What are the release / acquire barriers
synchronizing.

> Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v2:
>  - Move fix from data path (reader-side NULL fallback) to
>    configuration path (writer-side per-field updates), as suggested
>    by the reviewer.
>  - Use smp_store_release()/smp_load_acquire() instead of plain
>    stores/loads for proper ordering on weakly-ordered architectures.
>  - Add synchronize_net() before exit_op() to drain in-flight readers
>    and prevent use-after-free of mode private state.
> 
>  drivers/net/team/team_core.c | 46 ++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 0c87f9972..dabee3aa7 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -534,21 +534,22 @@ static void team_adjust_ops(struct team *team)
>  
>  	if (!team->tx_en_port_count || !team_is_mode_set(team) ||
>  	    !team->mode->ops->transmit)
> -		team->ops.transmit = team_dummy_transmit;
> +		smp_store_release(&team->ops.transmit, team_dummy_transmit);
>  	else
> -		team->ops.transmit = team->mode->ops->transmit;
> +		smp_store_release(&team->ops.transmit, team->mode->ops->transmit);
>  
>  	if (!team->rx_en_port_count || !team_is_mode_set(team) ||
>  	    !team->mode->ops->receive)
> -		team->ops.receive = team_dummy_receive;
> +		smp_store_release(&team->ops.receive, team_dummy_receive);
>  	else
> -		team->ops.receive = team->mode->ops->receive;
> +		smp_store_release(&team->ops.receive, team->mode->ops->receive);
>  }
>  
>  /*
> - * We can benefit from the fact that it's ensured no port is present
> - * at the time of mode change. Therefore no packets are in fly so there's no
> - * need to set mode operations in any special way.
> + * team_change_mode() ensures no ports are present during mode change,
> + * but lockless readers (AF_PACKET) can still reach team_xmit(). Use

Why is AF_PACKET relevant here??

> + * smp_store_release() to publish safe dummy handlers before teardown,
> + * and synchronize_net() to drain in-flight readers.
>   */
>  static int __team_change_mode(struct team *team,
>  			      const struct team_mode *new_mode)
> @@ -557,9 +558,23 @@ static int __team_change_mode(struct team *team,
>  	if (team_is_mode_set(team)) {
>  		void (*exit_op)(struct team *team) = team->ops.exit;
>  
> -		/* Clear ops area so no callback is called any longer */
> -		memset(&team->ops, 0, sizeof(struct team_mode_ops));
> -		team_adjust_ops(team);
> +		/* Install dummy handlers for locklessly-read hot-path ops
> +		 * first, then clear cold-path ops that are only used under
> +		 * RTNL.
> +		 */
> +		smp_store_release(&team->ops.transmit, team_dummy_transmit);
> +		smp_store_release(&team->ops.receive, team_dummy_receive);
> +		team->ops.init = NULL;
> +		team->ops.exit = NULL;
> +		team->ops.port_enter = NULL;
> +		team->ops.port_leave = NULL;
> +		team->ops.port_change_dev_addr = NULL;
> +		team->ops.port_tx_disabled = NULL;
> +
> +		/* Ensure in-flight readers using old handlers have finished
> +		 * before tearing down mode state they may depend on.
> +		 */
> +		synchronize_net();
>  
>  		if (exit_op)
>  			exit_op(team);
> @@ -582,7 +597,12 @@ static int __team_change_mode(struct team *team,
>  	}
>  
>  	team->mode = new_mode;
> -	memcpy(&team->ops, new_mode->ops, sizeof(struct team_mode_ops));
> +	team->ops.init = new_mode->ops->init;
> +	team->ops.exit = new_mode->ops->exit;
> +	team->ops.port_enter = new_mode->ops->port_enter;
> +	team->ops.port_leave = new_mode->ops->port_leave;
> +	team->ops.port_change_dev_addr = new_mode->ops->port_change_dev_addr;
> +	team->ops.port_tx_disabled = new_mode->ops->port_tx_disabled;
>  	team_adjust_ops(team);
>  
>  	return 0;
> @@ -743,7 +763,7 @@ static rx_handler_result_t team_handle_frame(struct sk_buff **pskb)
>  		/* allow exact match delivery for disabled ports */
>  		res = RX_HANDLER_EXACT;
>  	} else {
> -		res = team->ops.receive(team, port, skb);
> +		res = smp_load_acquire(&team->ops.receive)(team, port, skb);
>  	}
>  	if (res == RX_HANDLER_ANOTHER) {
>  		struct team_pcpu_stats *pcpu_stats;
> @@ -1845,7 +1865,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	tx_success = team_queue_override_transmit(team, skb);
>  	if (!tx_success)
> -		tx_success = team->ops.transmit(team, skb);
> +		tx_success = smp_load_acquire(&team->ops.transmit)(team, skb);
>  	if (tx_success) {
>  		struct team_pcpu_stats *pcpu_stats;
>  
-- 
pw-bot: cr
