Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757638;
	b=m9hN+DRdWrvyy3NDSZd8pD/VykskzNQn4oxT5HRcPH2csK2N4uBypX0DaD0/kCbJYwMX
	 WbOcd1BRHp5YWDI8XhEnX6lUax6x5JsjdRbmVO/1rN1dNDa07TbZJYzRT3TMiw5mHWrO5
	 hzUioDkIMNcxhcXAY6koqY+PTZ5zRmxOsvmyUY5BcEUZkI6sgd+e2gw86L+GQolgiKOvK
	 9j69L9QyyokwQitlir5Gq3BTt5qlvs7+6Hg7D+us/3eU1O4UvCi4ETPh08MGwgaa0xGel
	 RYTN0UmBswxbDw5JJn7nTZOPti7vDNXFXjdMoXGpTLv7cybcRpqZUHe/EjnsD3+d8IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757638;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=JA0j/epUYMxDVQZCp6JnqXfw6s/tPM4WL64oDbL7xvU=;
	b=hRdtF2c/qArJwXOQiy60ou3bl69Gmxk0RARkR6Fm5gJpLH/tMSnckVPD1omH4+QXGKhD
	 ePrjEHdyJUbPdRA0UdQhYqL7jxGwRvVJwTOmRYDKGmHqT045Jul9Wdf2BICeNwfiUNiES
	 2tDYvP+CBx1eJnjlzsNERwVwe4TW16x/eoBCCXdJsL7gcdH2tGZVAg8hGmacpGg4e2Q8t
	 D1/myDeBA5/PWJRNcdn495RF6vdEo4qoE+il+atqONeCYfig04yiFlBCbJSrSelx+ipeX
	 HGlGDO+dRDulY1Ydt0uvgx0+nb791GsjP4HOZCmbr7eVB8X3qH8bqXJXGp2BYG8N8zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=z41Swyve;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IiABPwp2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WBwPcYR3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NmsCdFn2;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AF5606A31A;
	Fri, 23 Oct 2026 12:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9AF5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=z41Swyve;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IiABPwp2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WBwPcYR3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NmsCdFn2
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C4CB22187;
	Fri, 23 Oct 2026 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792757635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA0j/epUYMxDVQZCp6JnqXfw6s/tPM4WL64oDbL7xvU=;
	b=z41SwyveHK/kpypWojGfEreU7zJSa01M3ApWrNWTN2rcfFkEsnJLuRYTSul44oyNySZSDm
	ozZ7xkD0CDSmORxJ1oP+Iz/dVHci+5kCGQWM0S7QXSm660tQfHJJnV0OA0/PPbhqKDT3WS
	++NVgtiN56oJhJrBq20vedapqMAq5VE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792757635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA0j/epUYMxDVQZCp6JnqXfw6s/tPM4WL64oDbL7xvU=;
	b=IiABPwp2bbcaONDNHSCko4k3w9RMPo+zxq/YsiTDTVv1rrzBhHFAg2pTv7eHAV8GvhaM0S
	RfXvwwJek7ReYuAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WBwPcYR3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NmsCdFn2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792757634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA0j/epUYMxDVQZCp6JnqXfw6s/tPM4WL64oDbL7xvU=;
	b=WBwPcYR3z3EMkYY+JmVrl1jMJlZbIwHiB/1jBqWXjcV5odkwP8R0Y/QSiRN9oIUrdCYafb
	r0fPvKNVCJ9BPGu1PiguuaFNEHJ9fRDKwXOCcCAYtqk1ow+K1ii9r01TUvThA55EiR3ylF
	90jrccW97CIFkmAOoRXo+BfF1LOf2C0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792757634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA0j/epUYMxDVQZCp6JnqXfw6s/tPM4WL64oDbL7xvU=;
	b=NmsCdFn2//rNQC52v+GapdrRmi/KRoY+6ED94HzUAuST3i1aCRAH5TDKp4yPxfumnJ+mVS
	K2zmcEe8mI38JGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0BCA133F3;
	Fri, 23 Oct 2026 12:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hLiQJ4FP22o4eAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 23 Oct 2026 12:13:53 +0000
Message-ID: <2bb3284c-b55a-4358-9b6a-d1def1e83c4e@suse.de>
Date: Fri, 23 Oct 2026 14:12:47 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf
 messages
To: Gabriel Goller <g.goller@proxmox.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8C4CB22187
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,proxmox.com:email,suse.de:dkim,suse.de:email]
X-Spam-Score: -13.50

On 10/23/26 12:59 PM, Gabriel Goller wrote:
> Since force_forwarding was added, changing the sysctl sends an
> RTM_NEWNETCONF notification of type NETCONFA_FORCE_FORWARDING, but
> inet6_netconf_fill_devconf() never emits the attribute. Listeners only
> receive NETCONFA_IFINDEX without the new value, and RTM_GETNETCONF
> replies and dumps omit it as well.
> 
> Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

