Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6B324B0A;
	Mon, 31 Aug 2026 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169991; cv=none; b=o5kATojcKRXiXlOYxyOXXDff9aZvGVdR156SwuCYxkF0FbZkfHuaWk0usyhg2JqWnX+E2wu2YAwrAU0PsqyLGMNhWZhNBB2u7C1oidp4WWdKA8ABhov5TqDhQGwXAK0FiCYf9jvBvBRU+BYntt3Ah65net2S6loMsn1QZIexPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169991; c=relaxed/simple;
	bh=NCRQHERr/U7EVQHV8IMGfKlB5b8/3P71llEPGxAFb28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiusL+qIVX9O21kV/iBZWszgJegBf4o3SREYWwQRuNU9xaNT4Y5eJfdxQVmqlBgF5OSroDBYdYCpKqZYv0M4clpLG64ByD91igF6bU/cbM2ed+vbxqJWYW15zTN9mfU+AL/IsXKIuklC8E5PxMwrGoZb/wTBs32J8qS61rC0y4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eq7mb0Ev; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LOTfHHpw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zRUC9Q83; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dWGD/V8d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eq7mb0Ev";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LOTfHHpw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zRUC9Q83";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dWGD/V8d"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BAA921EE5;
	Mon, 31 Aug 2026 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788169983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkqjE07mhBQ9ufIy6ol9Fa6xd8oOl8UHkfPiUnsE2Is=;
	b=Eq7mb0EvmfZ/l76Vx834DNYp4qZck+cmG0o40BcFCR6vHXE45ZUq/vTrIlrTzbC6YUhviD
	Bc1tyYCtrqbrPgT2OeEJrC1KQqiHhTPk2zGJDK/oneHodUPzjcuucst+Gc2VI+PzAclw5d
	gMXr0hH/j2l/5gstoVmlJtOXO+3h/Q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788169983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkqjE07mhBQ9ufIy6ol9Fa6xd8oOl8UHkfPiUnsE2Is=;
	b=LOTfHHpw3uljn6T2YkQ8YGnxaLXxymz2vTZeqNowxrTnxgKshH6GT8r1TXGE5ouLzSQZHM
	3Np6UyGBnISrJcDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zRUC9Q83;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="dWGD/V8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788169979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkqjE07mhBQ9ufIy6ol9Fa6xd8oOl8UHkfPiUnsE2Is=;
	b=zRUC9Q83B+qR4PqebgQjqzRCNcJ0bZAIZvohmYBYl2dIm7LLj8sXQ2hjRwNXagwSCRSX8i
	et/NV9JbYCKEZK2qynACPhHe/Ug1+1UYwNxSuQHm4vLBmD/EjaE3AaoQZP1szKZ13TBEvD
	k2Qo3SvYQ+4cg+Fto6MFCmhkSKVvLfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788169979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkqjE07mhBQ9ufIy6ol9Fa6xd8oOl8UHkfPiUnsE2Is=;
	b=dWGD/V8dILD+/klIiJ3Jskn4P+2MGnTGOkmC8vKAjoDgwmVqOwWdYcBydEOcWcwNBJn63+
	ZFUk8cOFXm+n1nAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D056F13682;
	Mon, 31 Aug 2026 09:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ToALMPpOlWqDagAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 31 Aug 2026 09:52:58 +0000
Message-ID: <58a7834d-d095-47a1-99fc-fda4eea35079@suse.de>
Date: Mon, 31 Aug 2026 11:52:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] netlink: specs: rt-link: add
 accept-ra-min-lft
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>,
 Danielle Ratson <danieller@nvidia.com>, Gabriel Goller
 <g.goller@proxmox.com>, Patrick Rohr <prohr@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260831093458.472180-1-ast@fiberby.net>
 <20260831093458.472180-3-ast@fiberby.net>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260831093458.472180-3-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 9BAA921EE5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[fiberby.net,gmail.com,kernel.org];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fiberby.net:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,linux.dev:url];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 8/31/26 11:34 AM, Asbjørn Sloth Tønnesen wrote:
> Add missing enum member accept-ra-min-lft to ipv6-devconf.
> 
> In commit 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
> the DEVCONF_* enum was extended with DEVCONF_ACCEPT_RA_MIN_RTR_LFT.
> 
> It was renamed to DEVCONF_ACCEPT_RA_MIN_LFT in commit 5027d54a9c30
> ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes").
> 
> Shortly thereafter, this spec was introduced in commit b2f63d904e72
> ("doc/netlink: Add spec for rt link messages").
> 
> This pre-existing issue was detected by Sashiko, when reviewing the
> first patch in this series.
> 
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824103816.40040-1-ast%40fiberby.net
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

> ---
>   Documentation/netlink/specs/rt-link.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index 00c915031efd..ab677801cde8 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -494,6 +494,8 @@ definitions:
>           name: ndisc-evict-nocarrier
>         -
>           name: accept-untracked-na
> +      -
> +        name: accept-ra-min-lft
>     -
>       name: ifla-icmp6-stats
>       enum-name:

