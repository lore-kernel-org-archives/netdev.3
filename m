Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFD367B6A
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940524; cv=none; b=OdTc36K6CKi0Z3tMgnbiVT7dFXWJn3MDJpBEkqeZ+lEKT947twr/Nxf/9YPpUbfSKbA14i4b6l8fB04VgmWLsNxf82Zcg3zqhwnA+quy/2sV5ye4R8xUUicDnRiArM6mOEn5gfQ3AJwmm0hmx25nuL3d1JLqtvSOSDZK8OH4tJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940524; c=relaxed/simple;
	bh=BzoNkzAvNhDh69dYfkurv4pgngpj1kWvlPE8Eka7Ruo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBvHR0t/hyq2+Pe5DsBtFelJTVjXsPz1UDGrs/1NhhIYBn3sRqMZ2vqS6+nb0cYwLTf+P5tOKmAv2ZGS2bupyzynvtoM5Ep9w+/zSzfvicH1iQ9Yp9V9u3Br7e35957VSvvyvFylxS61/ToE6a6CczYs23ZYQ682INlU3N5dJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TvOG3flg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2rMQYrbm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TvOG3flg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2rMQYrbm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TvOG3flg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2rMQYrbm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TvOG3flg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2rMQYrbm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B14C16A9FA;
	Mon,  8 Jun 2026 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780940521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3tCh0jPJNjOk0TbCgUCupOL4KmSVywuiVe8aP07Buk=;
	b=TvOG3flgSAIFfwT6yUuMgzHv0re9yIQqM18BEfXr7R3DQwGWn2DGrJ8qtXOXPqzVnO5f7s
	fj69PjnGsRTYAHGEzAjYUeaiT26MCMeLMPA7bfxin4ZMPgzQTq9vJSyue8wGlTavZfKK0P
	+EDNq886/edQKDpio5PXzJyQvLrL8xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780940521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3tCh0jPJNjOk0TbCgUCupOL4KmSVywuiVe8aP07Buk=;
	b=2rMQYrbmWjkXqF3WZe25/2KhhTh9bmnq5GAEB2Xwc4keltcM9yVakPR2Zxfij+x4/wopAU
	FhM/Vv5jxPnIr4CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780940521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3tCh0jPJNjOk0TbCgUCupOL4KmSVywuiVe8aP07Buk=;
	b=TvOG3flgSAIFfwT6yUuMgzHv0re9yIQqM18BEfXr7R3DQwGWn2DGrJ8qtXOXPqzVnO5f7s
	fj69PjnGsRTYAHGEzAjYUeaiT26MCMeLMPA7bfxin4ZMPgzQTq9vJSyue8wGlTavZfKK0P
	+EDNq886/edQKDpio5PXzJyQvLrL8xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780940521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3tCh0jPJNjOk0TbCgUCupOL4KmSVywuiVe8aP07Buk=;
	b=2rMQYrbmWjkXqF3WZe25/2KhhTh9bmnq5GAEB2Xwc4keltcM9yVakPR2Zxfij+x4/wopAU
	FhM/Vv5jxPnIr4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F68F779A7;
	Mon,  8 Jun 2026 17:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vXaRCOn+JmpEAgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 08 Jun 2026 17:42:01 +0000
Message-ID: <c57b3480-3049-4e1c-8f26-4073a96cfec8@suse.de>
Date: Mon, 8 Jun 2026 19:41:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3 net-next v5] ipv4: centralize devconf sysctl handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
 dsahern@kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <20260607110123.5939-1-fmancera@suse.de>
 <20260608090333.21c94721@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260608090333.21c94721@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -4.30

On 6/8/26 6:03 PM, Jakub Kicinski wrote:
> On Sun,  7 Jun 2026 13:01:21 +0200 Fernando Fernandez Mancera wrote:
>> The logic for handling IPv4 devconf sysctls is scattered. Notification
>> and cache flushes are managed in devinet_conf_proc(), while a separate
>> ipv4_doint_and_flush() function and DEVINET_SYSCTL_FLUSHING_ENTRY macro
>> is used for properties that solely require a cache flush.
> 
> Hi Fernando!
> 
> Do you have the necessary iproute2 patches pushed out somewhere?
> I'll pull them in the CI to make sure the test works.
> 

Oh sorry, I thought this was using iproute2-next.

Yes, feel free to find it either here [0] or pick it from [1].

[0] https://lore.kernel.org/netdev/20260601143242.6729-1-fmancera@suse.de/

[1] 
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fdb064bf64e5df738f5f823a11f315340679d336

Thanks,
Fernando.
