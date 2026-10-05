Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0948847F79B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202783; cv=none; b=qHaOKp6UXkU7e5k7Gn5LkSKFzHz0x0IuATqnDJzRrGi/2NkKJyQ8dBsPMzQn+VburoM6qR6HNzwg7dXmCUQrilKIPaBE9+LVq4FSQanswpG9cCcZFhwKNmZsx/6BGT+TtVlDWOcnQNg/YPJLK1kGjJR/Nc7hh0o9t5+j4Zcp2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202783; c=relaxed/simple;
	bh=6OoO8eZU3xiwa72zNw1OpTsdf+HhLxH4DnYmoIFLiac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLzSzjrwuHcBhAZKhvrH6sh2J43bZjYUxmC3hGubNvKwKOic2cZ9YksSVj1S3T+JCg3qJSsJpSkgbg1hQGdAxPTPImmlQcEbscRrJeCKbvfb+lj6uTlDcBb2D9zMtN0BqGl1cYuwE7ieMmGn58ezHZFPL0lIuYYSVJtCdgikvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XxuRswwl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=75k25QCn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J4TFtffk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qoVDWZAZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XxuRswwl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="75k25QCn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J4TFtffk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qoVDWZAZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 796E421E89;
	Mon,  5 Oct 2026 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791202775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EC0JeyWQzvGkLUwfm9HcqWirmq0Oh6ob4reDCAugKjM=;
	b=XxuRswwlS7VrtqsvS5NM0iN8tuC5h1WQcYUtNjf6pmEwHUpZ3PVziPR5hiiSz9Q+jNKQCt
	lJsRJHlvsXC5+56kUS86rdI8himSmLvSSReVvglH7s5jkhL0JGHOovW1DOAeMTMW2U6qjE
	oWX+lChUdH45Uq9rHsogjHQ795E/Yd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791202775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EC0JeyWQzvGkLUwfm9HcqWirmq0Oh6ob4reDCAugKjM=;
	b=75k25QCnAIZpqgYed9CfLbEcgPdCfgSDNTQXAgJj2SLcyme3R0TJgrfYJTH8FXWf8iIDBS
	nztFIimU6odos6Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791202771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EC0JeyWQzvGkLUwfm9HcqWirmq0Oh6ob4reDCAugKjM=;
	b=J4TFtffkL2+e6a+GOsmA5BJ6sy0ioGPS2nKKUVfUvTwiXYzuUWClw4pFIXtl0P/AVhp4pp
	A4jhigVTvU8ltrEWNCFUyCSGNXPACIRizf6WHcMa3jleyRJ4LVtsQ+J9nHObvIgBSMqvz+
	qZ1A6Y9emlU/b0oOMQLXJojmFrxKbc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791202771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EC0JeyWQzvGkLUwfm9HcqWirmq0Oh6ob4reDCAugKjM=;
	b=qoVDWZAZLZqBZInzAyLFt6hIAq2oo05oxZbH4ddQ+8A+jK8XWRy4A/zfR9WB1xZb7KUjI1
	2QQViw4EruHQOWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF4F2132D3;
	Mon,  5 Oct 2026 12:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xAvoH9KVw2pnIgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 05 Oct 2026 12:19:30 +0000
Message-ID: <7b8025c7-2042-4e29-9e37-f283f843960c@suse.de>
Date: Mon, 5 Oct 2026 14:18:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/6] net: Order blackhole_netdev_init(),
 inet_init(), and inet6_init().
To: Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20261001204752.2572265-1-kuniyu@google.com>
 <20261001204752.2572265-2-kuniyu@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261001204752.2572265-2-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

On 10/1/26 10:47 PM, Kuniyuki Iwashima wrote:
> Commit 309b905deee5 ("ipv6: convert CONFIG_IPV6 to built-in
> only and clean up Kconfigs") started to call inet6_init() as
> device_initcall().
> 
> It explains the reason as a race condition on IPv6 addrconf,
> but this is not accurate.
> 
> The change initially used fs_initcall() but switched to
> device_initcall() due to the null-ptr-deref stack trace in
> the link below.
> 
> It happened because blackhole_netdev_init() uses device_initcall()
> and blackhole_netdev was NULL when addrconf_init() called
> ipv6_add_dev(blackhole_netdev).
> 
> Due to the order in Kbuild,
> 
>    $ cat -n Kbuild | grep -E "(drivers|net)"
>       111	obj-y			+= drivers/
>       114	obj-$(CONFIG_NET)	+= net/
> 
> using device_initcall() for IPv6 allows built-in drivers to
> be initialised earlier, which requires unnecessary NULL checks.
> 
> For the same ordering reason, IPv4 uses late_initcall() to
> initialise blackhole_netdev.
> 
> Given loopback_net_ops is registered in net_dev_init() at
> subsys_initcall(), blackhole_netdev_init() can be called
> after that.
> 
> In addition, some places assume that IPv4 must be initialised
> before IPv6.  For example, mptcp_proto_v6_init() copies
> mptcp_prot to mptcp_v6_prot, which would otherwise have NULL
> mptcp_v6_prot.h.hashinfo.
> 
> Let's explicitly order blackhole_netdev_init() -> inet_init()
> -> inet6_init() before device_initcall() with 3 different
> initcall levels:
> 
>    subsys_initcall      : 4  : net_dev_init()
>    subsys_initcall_sync : 4s : blackhole_netdev_init()
>    fs_initcall          : 5  : inet_init()
>    fs_initcall_sync     : 5s : inet6_init()
>    device_initcall      : 6  : built-in drivers
> 
> Note that both IPv4 and IPv6 can still use fs_initcall() thanks
> to the order in net/Makefile, but explicit ordering would be
> less error-prone.
> 
>    $ cat -n net/Makefile | grep ipv
>        17	obj-$(CONFIG_INET)		+= ipv4/
>        22	obj-y				+= ipv6/
> 
> Link: https://lore.kernel.org/netdev/20260309074758.0ea95a18@kernel.org/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

I have tested this in multiple environments with multiple Kconfigs and 
command line options. Thanks for looking into this Kuniyuki.

> ---
> Cc: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>   drivers/net/loopback.c | 2 +-
>   net/ipv6/af_inet6.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
> index 1fb6ce6843ad..55ecd5ebac0f 100644
> --- a/drivers/net/loopback.c
> +++ b/drivers/net/loopback.c
> @@ -289,4 +289,4 @@ static int __init blackhole_netdev_init(void)
>   	return 0;
>   }
>   
> -device_initcall(blackhole_netdev_init);
> +subsys_initcall_sync(blackhole_netdev_init);
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index f0efdc13baf4..a9b8b4b42a1a 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -1217,4 +1217,4 @@ static int __init inet6_init(void)
>   	proto_unregister(&tcpv6_prot);
>   	goto out;
>   }
> -device_initcall(inet6_init);
> +fs_initcall_sync(inet6_init);

