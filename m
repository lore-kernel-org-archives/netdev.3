Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B20374A15
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641609; cv=none; b=BL0r7gQvhgsHH/RM3EydniY5ChucvbYNIgANaD+cHtJGp+zhG1kjWovE2iyNUDHS9Lz6aC6lAvHeHQ/QhAhdozfm0YL79vRzNZQFYe4roj5iyBa1d8rbXgRrb1USV+Hs9pPmJ/te78auJRyBmoU4+27ZZX/un0rLRohzvGkHpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641609; c=relaxed/simple;
	bh=q+xanD6YEoFZyVnBRsavSy1BfgyQB1vmB4lgVwYEizM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVI1P4WM0kdHnFK1HXm92JwAwt3hSxxFmFAfN52fAz2uS7ptPdjnNLD1I1s5iW6gkNJBaU48sV3fIDpfxDb0jyiGI66kjarqypeN1oyFpR2qZUtftcCy4qB02DYkrJf8AFv2XBve0Nucg7uD5RDNPqUkd2Hsbizpc8ernfC4IF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D3y0rz4a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IoWn1+6H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D3y0rz4a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IoWn1+6H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D3y0rz4a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IoWn1+6H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D3y0rz4a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IoWn1+6H"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4DED3E1D;
	Tue, 21 Jul 2026 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784641605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hExJAmR4nU8M+iDToxbr9TsJPyomLt4NjBmlJ+ndyoM=;
	b=D3y0rz4a1m2rOgKCldrfEtQ0ub3SrsnelVZo94z3vmSFAITrACVV/w/zo+jEwm1g7c9HT8
	9e4mpPO4TYPJzk6kjYCB4vyg9vHzubCN5q/Xx0D1dEdDYZeb7hPGNmx+IrvcVQlQmx5RO4
	aHq0iC0TJMKXfkoQZ7ZjjB3BpPaFu8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784641605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hExJAmR4nU8M+iDToxbr9TsJPyomLt4NjBmlJ+ndyoM=;
	b=IoWn1+6HzJSC5eC+VC7ynjDT6NGtxsYZ4UekbJxKberBs91FxK8njS8hlwqbSu+ZxTYIXB
	r6ClLCUbVPH7JPBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D3y0rz4a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IoWn1+6H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784641605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hExJAmR4nU8M+iDToxbr9TsJPyomLt4NjBmlJ+ndyoM=;
	b=D3y0rz4a1m2rOgKCldrfEtQ0ub3SrsnelVZo94z3vmSFAITrACVV/w/zo+jEwm1g7c9HT8
	9e4mpPO4TYPJzk6kjYCB4vyg9vHzubCN5q/Xx0D1dEdDYZeb7hPGNmx+IrvcVQlQmx5RO4
	aHq0iC0TJMKXfkoQZ7ZjjB3BpPaFu8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784641605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hExJAmR4nU8M+iDToxbr9TsJPyomLt4NjBmlJ+ndyoM=;
	b=IoWn1+6HzJSC5eC+VC7ynjDT6NGtxsYZ4UekbJxKberBs91FxK8njS8hlwqbSu+ZxTYIXB
	r6ClLCUbVPH7JPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4856B779AA;
	Tue, 21 Jul 2026 13:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nf/QDkV4X2ruHQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 21 Jul 2026 13:46:45 +0000
Message-ID: <4087bf3c-90ac-40d3-9c46-f0f95a60284c@suse.de>
Date: Tue, 21 Jul 2026 15:46:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 net-next] ipv6: add CAP_NET_ADMIN check for forwarding
 and force_forwarding sysctl
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, dsahern@kernel.org
References: <20260716203713.17392-1-fmancera@suse.de>
 <20260716203713.17392-4-fmancera@suse.de> <20260721122430.GC2592863@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260721122430.GC2592863@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B4DED3E1D
X-Spam-Score: -4.51

On 7/21/26 2:24 PM, Ido Schimmel wrote:
> On Thu, Jul 16, 2026 at 10:37:13PM +0200, Fernando Fernandez Mancera wrote:
>> As commit 8292d7f6e871 ("net: ipv4: add capability check for net
>> administration") did for IPv4, make sure that CAP_NET_ADMIN is required
>> to modify IPv6 forwarding and force_forwarding sysctl. This keep the
>> consistency of permission check logic between both protocols.
> 
> What's the value beyond protocol consistency given that it creates
> intra-protocol inconsistency (none of the other IPv6 sysctl handlers
> have this check)? 8292d7f6e871 does not explain why only forwarding was
> changed. As-is, I don't see much value in this change. Tested using
> [1].
> 

Ideally, all IPv6 and IPv4 should require CAP_NET_ADMIN as they are 
indeed configuring networking interface configuration. I thought 
changing all of them all of a sudden would be too much so I went for 
forwarding only.

As to answer why it was done for IPv4 in first place, I guess it was 
done because forwarding is the most popular option and also quite 
relevant in terms of impact in the system behaviour.

If we don't want to merge this as it is, I see 3 ways forward:

1. drop this patch from the series
2. drop the permission check in IPv4 forwarding sysctl
3. extend the check to all sysctls of IPv4 and IPv6

Ideally I would go for 3. if it isn't too much in your opinion. 
Otherwise, likely 1.

Thanks,
Fernando.

> Before:
> 
> uid=0(root) gid=0(root) groups=0(root)
> v4 fwd: 1
> v4 rp_filter: 0
> v6 fwd: 0
> v6 accept_ra: 0
> 
> After:
> 
> uid=0(root) gid=0(root) groups=0(root)
> v4 fwd: 1
> v4 rp_filter: 0
> v6 fwd: 1
> v6 accept_ra: 0
> 
> [1]
> #!/bin/bash
> 
> id
> capsh --drop=cap_net_admin -- -c '
> 	sysctl -wq net.ipv4.conf.all.forwarding=1 &> /dev/null
> 	echo "v4 fwd: $?"
> 	sysctl -wq net.ipv4.conf.all.rp_filter=2 &> /dev/null
> 	echo "v4 rp_filter: $?"
> 	sysctl -wq net.ipv6.conf.all.forwarding=1 &> /dev/null
> 	echo "v6 fwd: $?"
> 	sysctl -wq net.ipv6.conf.all.accept_ra=2 &> /dev/null
> 	echo "v6 accept_ra: $?"
> '
> 

