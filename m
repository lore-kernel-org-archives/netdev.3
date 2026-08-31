Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93A34B1A2;
	Mon, 31 Aug 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170105; cv=none; b=HurdNcVRAFMjH2J2xqAYZ7PUPokg9lDNeIC3+W6bcrLm6SHwyffer9Rab8b1Ftyk2wyvQMJkhd6+NeezH8Kej+qZIxvK9cORIi82Lp8YhTgS8sIQ6BpZGGEYX50822V0vuq88YGHVbuZleRsLRq9h9uiOssmSrpLFixGXXQfOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170105; c=relaxed/simple;
	bh=qlLQLnyCXGE9Hp11W4vB8dOZgiLIXNQqM5oc0Xd7VZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyfrRtOU8PXWkpliFXzEv43XL6A6ZbsoUibhz+XVl4brkREq2lpR7N5NmyNhF1DEXnyXe6y2jwyvK3yCd8fQg7mdTz+yRwxpqQOPUh51DrP/1Pku0ZiFKdJ5yoLoYnYezP6b0YSccmPvWrop1Mpz/J1PkIBCL2No2M1yfRJWUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d3oIqSCP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TLP2rkyZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ui08yPzM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/OP5WXl6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d3oIqSCP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TLP2rkyZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ui08yPzM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/OP5WXl6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ADE7C1FBFA;
	Mon, 31 Aug 2026 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788170069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2BHp7IdEBTPw00fqiXSv3SREna7umalwnHvJepzYSM=;
	b=d3oIqSCPgHoBy2frvH1j3NqgtVcIN63HZIuXXBW84cHlA0sT5bQK9t6QzkNFDgrY6dLq7l
	KMh8ysQBfwUQkgSEe7TuONLneoti6hAXIbPJV4aVjdzvoqpHbx8Rak3EsLN5156seBroeb
	o/x8OexpcFnFfrq9zEJzkXyanHS2sMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788170069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2BHp7IdEBTPw00fqiXSv3SREna7umalwnHvJepzYSM=;
	b=TLP2rkyZOf3VF+3tPj7dIViIVkgvV7GnZrX6chNlaVnbQ9cxk7oTyQWmTpcKtvtazB+gNZ
	IJMhYgvy4uNXmNBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ui08yPzM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/OP5WXl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788170065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2BHp7IdEBTPw00fqiXSv3SREna7umalwnHvJepzYSM=;
	b=Ui08yPzMhqGUSTxWNIA2M7u4BKvMCEpKZ0CKty2XXF1ViUrA8XnK7k7v2HJQjakl7ukRKu
	NyC1aDMGhx9+ZQoQT+GeRAagyjM2hUIlVjjrPwJLn7eJ3x9P3NVeXnUPHMo81II770GN7r
	tqalzSG74plS7T8lf6p0adAM5RfJ09c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788170065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2BHp7IdEBTPw00fqiXSv3SREna7umalwnHvJepzYSM=;
	b=/OP5WXl6QO5MBpmlnY50XXDV6TN+ceC/nlJ+kW9ETXpYry8ksTqqUJxpslpiEc1Lbhu8Oh
	KVJ2Opg67rJzerDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E465813685;
	Mon, 31 Aug 2026 09:54:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ypPRNFBPlWpyawAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 31 Aug 2026 09:54:24 +0000
Message-ID: <f47f6b03-4b48-4757-9ed5-006975a6b895@suse.de>
Date: Mon, 31 Aug 2026 11:53:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] netlink: specs: rt-link: add
 force-forwarding
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>,
 Danielle Ratson <danieller@nvidia.com>, Gabriel Goller
 <g.goller@proxmox.com>, Patrick Rohr <prohr@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260831093458.472180-1-ast@fiberby.net>
 <20260831093458.472180-4-ast@fiberby.net>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260831093458.472180-4-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: ADE7C1FBFA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,linux.dev:url,fiberby.net:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 8/31/26 11:34 AM, Asbjørn Sloth Tønnesen wrote:
> Add missing enum member force-forwarding to ipv6-devconf.
> 
> In commit f24987ef6959 ("ipv6: add `force_forwarding` sysctl to
> enable per-interface forwarding"), the DEVCONF_* enum was extended
> with DEVCONF_FORCE_FORWARDING, however Gabriel forgot to add it
> to the spec.
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
> index ab677801cde8..61ebb9a2bad5 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -496,6 +496,8 @@ definitions:
>           name: accept-untracked-na
>         -
>           name: accept-ra-min-lft
> +      -
> +        name: force-forwarding
>     -
>       name: ifla-icmp6-stats
>       enum-name:

