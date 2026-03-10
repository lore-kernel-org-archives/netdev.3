Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996362309AA
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180922; cv=none; b=abQX6Eyz9JZGGFzjoAXvFPa8jF28e/ikPwV0WAvJ3qjX2btLSXfSfv5yy2w+ws8RI15dlQ9QxFzdX27qLhOjoqtan0mwGQt5Jyb/pS7aE7/FcAsUIPVbMjgKUmXnnKsaPwJSZCLd8QYcr6uUBmQMjPNHQzYq5e25QuXdZgqeX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180922; c=relaxed/simple;
	bh=sLMD387+ly/Twrmi809srq8ry+BQaJHLbxOTuuku1kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alMawPtXJ1ak7Whuuw424gXkAghVbg33+gKHhRGV51urIoAaoEnxo5oxdLGyRxURQL85BIh4rAQvhCvuUxOOyHED+yFvdqX22SPv40xYIzB1mAqj3cVCOQbaPcOzQF87DDYO5aoZekBqaVvchDjVTIUFhyYS7ZerkfH8vro86oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E4/HlPae; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6pJYDWS6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UTPcP6Kf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dW4P4KEN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E4/HlPae";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6pJYDWS6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UTPcP6Kf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dW4P4KEN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D5FE65BDEE;
	Tue, 10 Mar 2026 22:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773180920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyhp05LwxPl+rlvc85cnzJ0TQFkKWpZtZnWnVTTLKGE=;
	b=E4/HlPae2ae+q0dTEU3rioYzNY9mbPygxd6B+LPyT8oLHdzMNZq5HH7RVG/fKzION9eYSD
	ssuKBcWUo+mPZVsgjbs7OeeJQLCdC+pYMC2shrauqTJnc9id+N61TvMaGhAaAzOItl0FUd
	aHypQrTWZ9XuGto95HROUcyc0p/2b9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773180920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyhp05LwxPl+rlvc85cnzJ0TQFkKWpZtZnWnVTTLKGE=;
	b=6pJYDWS6/I876JcZgiNpfjfSYMFV02x8gFsItiXyXdVaU7VxZZ00YGrJgsFZng34C235db
	WDvgOpJA35wEpRDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UTPcP6Kf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dW4P4KEN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773180919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyhp05LwxPl+rlvc85cnzJ0TQFkKWpZtZnWnVTTLKGE=;
	b=UTPcP6KfvaHt0aY30I/nhV6to3idHtwRvwR0bcs0Yy0TUTWhz5iM7mDpfNAqWsKt0jr6in
	QfztiAyEUg8QOFhZNXt0PvfiRy0iSA47YLYEEV+VRmdnAtRdscnZsyj6CG9UwOxft6egZE
	YiNsqAKspmmR3NGf2APzNm7RWLdjjFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773180919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyhp05LwxPl+rlvc85cnzJ0TQFkKWpZtZnWnVTTLKGE=;
	b=dW4P4KEN98xvqUB/yYGNf4jjnqvr9O8IUweDcDCb7zRDkv8TYo0jyNCuxk5s0xFjyBwS7Y
	LUjlDyQiBm0BUIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F4853F6A7;
	Tue, 10 Mar 2026 22:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MYAzEPeXsGkyeQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 10 Mar 2026 22:15:19 +0000
Message-ID: <b2f2514d-412f-4a65-a3cf-7d9dfac4789b@suse.de>
Date: Tue, 10 Mar 2026 23:15:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and remove
 stubs
To: Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, dsahern@kernel.org
References: <20260309022013.5199-1-fmancera@suse.de>
 <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
 <f4598201-2115-43e3-9da8-22583ae67db2@kernel.org>
 <20260309161826.46074d55@kernel.org>
 <411bcf03-5993-478d-9809-3e04567ff09a@kernel.org>
 <20260310144225.46501657@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260310144225.46501657@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: D5FE65BDEE
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 3/10/26 10:42 PM, Jakub Kicinski wrote:
> On Tue, 10 Mar 2026 21:02:40 +0100 Krzysztof Kozlowski wrote:
>>> Here is the top line of bloatometer without debug info:
>>>
>>>    add/remove: 1769/7 grow/shrink: 86/0 up/down: 374521/-228 (374293)
>>>
>>> The vmlinux increases by 200kB with IPv6 built in.
>>> Not a very dramatic increase.
>>>
>>> Please note that opening any dual-stack socket will cause the IPv6
>>> module to get loaded. And opening a dual-stack socket will fail if
>>> IPv6 is blacklisted. So I find it quite hard to believe that other
>>> that deeply embedded systems with custom configs there are systems
>>> out there which don't end up with IPv6 loaded. Whether they have
>>> a single IPv6 address configured or not.
>>
>> Yes, Ubuntu for that reasons does not have it even as module.
>>
>> This should be used as *the* argument for these changes.
> 
> Completely fair, the submission is severely lacking in motivation
> and impact analysis :(
> 

Yes it is. Sorry. I did handle that partially on v2 but will included as 
much arguments as possible in v3 and greater.

Thanks,
Fernando.
