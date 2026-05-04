Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E603A3E80
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890673; cv=none; b=PKHIKeeDnUzd5r7ELmdXsBk94cJKFgmg8rbsyWFnsNOi0mDKXRWWJs1BREi0lfaxVtOdaDvtIZ9qGo1wP/jor0O26ht83Frs9DEXQUabM/qQlWyRcQYn2Ayidfmw+fJArgthFsLG5wAvUYQ88xy4Ly9wFGrG7DcHW7zmxq1W1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890673; c=relaxed/simple;
	bh=wJhXnbFY0+jDbtjduHzwvEhN6qvojnft62Jqr7eALSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODLNd/8sfJwRvVykh6ETAinjQE3Rdhwj9muLlfetwXUbluzgL6k4/bRTgPz17da8+Iv287GRPma/ltaXy7rv2IhnbgSKbaIfra6Kdi+Wqx+SiCsL+OSl04z0x+LY7f/2e/HV0kxOr3XYFKlM9Ggede4FL0BEXNve+N8QYaMa8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xYxjMFmh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YqBbdDuY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xYxjMFmh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YqBbdDuY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xYxjMFmh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YqBbdDuY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xYxjMFmh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YqBbdDuY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E5FC6AE96;
	Mon,  4 May 2026 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777890665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka224WK7K1NxjuenX+lj710v1T/IIc0xGm98n+lp5eQ=;
	b=xYxjMFmhJkVU88eqHwBBE7zdZkZNiftCpctn3szT6mC8sFmCcZjlC0RTtHy11fYlm5mG8/
	48TNge6OBok5STGdDKuNayeUqxLctbepeMQAn57vFz6ImJcKmpyMg4N9Ax91e/ACkplEa2
	/G8+Xsx1Gb2nvPWVgdcM1E6POoA43TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777890665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka224WK7K1NxjuenX+lj710v1T/IIc0xGm98n+lp5eQ=;
	b=YqBbdDuYQmXXdDFphvGgzkQ4kvU6TT04BJwDmbztlDXA08PEfnoSESp6ozq62PD/g+fZjz
	2EFStI1bTa4sc+CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xYxjMFmh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YqBbdDuY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777890665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka224WK7K1NxjuenX+lj710v1T/IIc0xGm98n+lp5eQ=;
	b=xYxjMFmhJkVU88eqHwBBE7zdZkZNiftCpctn3szT6mC8sFmCcZjlC0RTtHy11fYlm5mG8/
	48TNge6OBok5STGdDKuNayeUqxLctbepeMQAn57vFz6ImJcKmpyMg4N9Ax91e/ACkplEa2
	/G8+Xsx1Gb2nvPWVgdcM1E6POoA43TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777890665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka224WK7K1NxjuenX+lj710v1T/IIc0xGm98n+lp5eQ=;
	b=YqBbdDuYQmXXdDFphvGgzkQ4kvU6TT04BJwDmbztlDXA08PEfnoSESp6ozq62PD/g+fZjz
	2EFStI1bTa4sc+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ED53593A3;
	Mon,  4 May 2026 10:31:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8XEJIGh1+GmwYgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 04 May 2026 10:31:04 +0000
Message-ID: <5f676587-fcdd-4704-9523-07a7fd98455a@suse.de>
Date: Mon, 4 May 2026 12:30:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ipv6: default IPV6_SIT to m
To: Alyssa Ross <hi@alyssa.is>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260503192515.290900-2-hi@alyssa.is>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260503192515.290900-2-hi@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,alyssa.is:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2E5FC6AE96

On 5/3/26 9:25 PM, Alyssa Ross wrote:
> This basically defaulted to m until recently, since IPV6 defaulted to
> m.  Since IPV6 was changed to a boolean with a default of y, IPV6_SIT
> started defaulting to built-in as well.  This results in a surprise
> sit0 device by default for defconfig (and defconfig-derived config)
> users at boot.  For me, this broke an (admittedly non-robust) script.
> Preserve the behaviour of most configs by avoiding building this
> module, that's probably overall seldom used compared to IPv6 as a
> whole, into the kernel.
> 
> Fixes: 309b905deee59 ("ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Hi, I am not sure about this. IPV6_SIT was already defaulting to 'y' for 
most distributions (except for ARM). Sure, if you had CONFIG_IPV6=m then 
CONFIG_IPV6_SIT was defaulting to 'm'.

Hm. Maybe we can aim this for net-next tree instead of net? I just don't 
think this is a fix but a change in behavior. FWIW, it makes sense to me 
to have this as a module by default.

Let's see what do others think.

Please respect the 24 hours period before reposting

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

Thanks,
Fernando.

> ---
> v2: update help text as well
> 
>   net/ipv6/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
> index c024aa77f25ba..c3806c6ac96f9 100644
> --- a/net/ipv6/Kconfig
> +++ b/net/ipv6/Kconfig
> @@ -164,7 +164,7 @@ config IPV6_SIT
>   	select INET_TUNNEL
>   	select NET_IP_TUNNEL
>   	select IPV6_NDISC_NODETYPE
> -	default y
> +	default m
>   	help
>   	  Tunneling means encapsulating data of one protocol type within
>   	  another protocol and sending it over a channel that understands the
> @@ -172,7 +172,7 @@ config IPV6_SIT
>   	  into IPv4 packets. This is useful if you want to connect two IPv6
>   	  networks over an IPv4-only path.
>   
> -	  Saying M here will produce a module called sit. If unsure, say Y.
> +	  Saying M here will produce a module called sit. If unsure, say M.
>   
>   config IPV6_SIT_6RD
>   	bool "IPv6: IPv6 Rapid Deployment (6RD)"
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

