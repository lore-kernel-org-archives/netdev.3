Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3ED395244
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056365; cv=none; b=atRgOcF998yPyuGfya3h74o85QbSa85OUgE9sGNQr89QSQiL+rtGhc0lZsEx2OLbkSzTx0p4tND1H6zwQoKUN25OrSv7cmWq5lz1IZqquFLmPuykr1FkyAldVqXKYDe68sldyzprdRtYj/DwiRxojAxZ8rk4i7VxvWXESYtKT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056365; c=relaxed/simple;
	bh=YyojufYY0LYZjroOWYiMQsfNe6vR2AXSNd+OKk+1nfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLiNBkFOTYRg/PiXUeIjmjTdI142BBx28sd207VcKaIn93HHjAOEWG5XbGXhDgelgg1HEOFXSmjAcmV8R2WPPcYYFnPMpul4nIcfpd2MexUp5LBV9VSdXms/z2HRUHsLEMptjDdj1pVnUIZHBoguypucTZ6tdMVYftbBKT5tAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zVH5S71m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xpbg68/Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zVH5S71m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xpbg68/Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zVH5S71m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xpbg68/Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zVH5S71m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xpbg68/Q"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64CC24D1FA;
	Mon,  9 Mar 2026 11:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773056362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PE3fqY9Qiy+MBFppkjvGzbl4zz4Ts0jBAKv3gVwYvFA=;
	b=zVH5S71mrfcxKxa6sIOT2U+eB9HZSVc1NZW8vi4BHhxmRfU37hdBTitLAIcphCXFuqd7mT
	w5c37ezn9C6k7adoKbRoGzmCWmIL/9jAo22KP4e3O4WVGJDJTrqvKgk8epEFXyti08CDPo
	N5kaylXHv4kOh3uef+3Qlp6mICFUnp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773056362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PE3fqY9Qiy+MBFppkjvGzbl4zz4Ts0jBAKv3gVwYvFA=;
	b=Xpbg68/Qo9c5OdR+dfZjII6JVJL3bbU6umnWYiHR9vM45P9Jgs6MvMooC8LoTWG6gaXndR
	9356sHs/RO1N7YAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zVH5S71m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Xpbg68/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773056362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PE3fqY9Qiy+MBFppkjvGzbl4zz4Ts0jBAKv3gVwYvFA=;
	b=zVH5S71mrfcxKxa6sIOT2U+eB9HZSVc1NZW8vi4BHhxmRfU37hdBTitLAIcphCXFuqd7mT
	w5c37ezn9C6k7adoKbRoGzmCWmIL/9jAo22KP4e3O4WVGJDJTrqvKgk8epEFXyti08CDPo
	N5kaylXHv4kOh3uef+3Qlp6mICFUnp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773056362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PE3fqY9Qiy+MBFppkjvGzbl4zz4Ts0jBAKv3gVwYvFA=;
	b=Xpbg68/Qo9c5OdR+dfZjII6JVJL3bbU6umnWYiHR9vM45P9Jgs6MvMooC8LoTWG6gaXndR
	9356sHs/RO1N7YAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB8733EE9B;
	Mon,  9 Mar 2026 11:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hyCBLmmxrmngBwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Mar 2026 11:39:21 +0000
Message-ID: <cd87ed46-b774-4896-b25e-4806eec9e0b3@suse.de>
Date: Mon, 9 Mar 2026 12:38:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and remove
 stubs
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org
References: <20260309022013.5199-1-fmancera@suse.de>
 <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 64CC24D1FA
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 3/9/26 11:22 AM, Krzysztof Kozlowski wrote:
> On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
>> Historically, the Linux kernel has supported compiling the IPv6 stack as
>> a loadable module. While this made sense in the early days of IPv6
>> adoption, modern deployments and distributions overwhelmingly either
>> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
>> entirely (CONFIG_IPV6=n). The modular IPv6 use-case provides little to
>> no practical benefit today.
> 
> It does. We all use generic kernels, thus it is one configuration for
> all boards and some setups have IPv6 and some not. The ones without IPv6
> just don't use that module.
>

While I understand this, I would like to clarify that IMHO IPv6 isn't a 
secondary protocol and it is fundamental to modern networking. This is 
why I believe it should be built-in by default. Currently OpenWRT, 
Debian ARM and others already ships the kernel with CONFIG_IPV6=y. I 
know that Alpine and Yocto doesn't do that for arm64.

I guess the most critical one here is Yocto but if the developer of the 
embedded device is sure they won't use IPv6 at all, they should turn it off.

At the same time, Alpine ships software that enable IPV6 and is 
frequently loaded as a module. So the only remaining concern would be 
the boot partition size. I don't really have a solution for that problem.

I think that the infrastructure for allowing IPV6=m is bug-prone and it 
impacts performance. Forcing the use of indirect function calls in core 
networking, Netfilter or BPF datapaths seems like a heavy tax to me.

> Also, with these generic kernels (so again all machines are using same
> ones, e.g. distro) users can easily blacklist the module.
> 

FWIW; users can still boot with kernel command line parameter 
ipv6.disable=1 and then IPV6 will be administratively disabled.

At the end this a trade-off, I still believe it is worth it but I 
understand your concerns.

Thanks,
Fernando.
