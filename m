Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5784A0907;
	Tue,  6 Oct 2026 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304233; cv=none; b=APca00id3+CJDy6K7xMOX9gcasCVouMGVHI4p1Dr6RTMh6YTFzUHADrvcltPZzBX9VaGRfMv40toXx863HnNm4UZ50gXu/zERE0ubhuW6O97J4YAnIjC8cvgy1uJGT/1vGnP0cyvTHtQFLn2fMzsx358PXvnbNqexlIJo1UJahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304233; c=relaxed/simple;
	bh=J4+Y31h09RyR9dQoIdtiw0yUptjPlghY5+Cr7fTgizo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WV18atjzkPJvQV8dlom/SoWxGf9kEFlIAa+MCNU02RdabTfjsSE58cG9orjLBA3FgDQiLtzEOqz0IeH6anif2mKh0m6vsDWR5YmEZbXcwY0O9JgzX3ktd9Y3r2r3nbkcNELK6mHH00Fcyd+t1EWSSm+UejTPhWAcV+gb67KxrGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aQeMFmYe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ed8pIcmq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0qNLvcfB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qKpbNtGm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aQeMFmYe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ed8pIcmq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0qNLvcfB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qKpbNtGm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE26121F75;
	Tue,  6 Oct 2026 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791304226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twFRnoRdRiOMUZTL6tZdobvcNatlGDj+lN0+eQllDyk=;
	b=aQeMFmYeMpGKXQDUu/xTqXLKZMFO/w5AiMrmCGwJ3yGGmeZOV2r9ibrv/A2Vtjf/5sMfC9
	7OfGrHCdaXISTZ+kc0xaqTT77mXCO1AZaDmqeJqc4JhVIGykKqvpG9GT6C0UjmRyEltCFB
	6BaPJra9LmdqNEsYIPzSRLZgVX5gVmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791304226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twFRnoRdRiOMUZTL6tZdobvcNatlGDj+lN0+eQllDyk=;
	b=Ed8pIcmqbtFKbUTPGG82Po+WY48Lc3iyRaKRrfxciBnsPZozHnCqKNa60G3t4102gHrf3y
	vWHb8iHDfTh57PDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0qNLvcfB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qKpbNtGm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791304221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twFRnoRdRiOMUZTL6tZdobvcNatlGDj+lN0+eQllDyk=;
	b=0qNLvcfBQ9ogeHDuwMCImhmti9DIs+gNHV/te7mQ+lEgHIHMzDMoYmliam+61KWfoxgf2s
	yKIEvbOMOm99U+JdH70JBo5paTeAjixirmZsBr2AvmXCkJdBheUbyZ4Rlvr73YJhpIJdye
	NlokiBw2RTqOYFpsJd/iQlAwuOgWbb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791304221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twFRnoRdRiOMUZTL6tZdobvcNatlGDj+lN0+eQllDyk=;
	b=qKpbNtGmraLtDeUhDCNRTv2S0nOfNPWLSXQbOTAV6lRlPJ8nBIh/1mPQ+VcVt/wlSWdHXZ
	t1sVug76Dyf6a6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4641F13B75;
	Tue,  6 Oct 2026 16:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lCAYBx0ixWoxLwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 06 Oct 2026 16:30:21 +0000
Message-ID: <f9180016-cf04-4452-b1d9-5c650c997d4d@suse.de>
Date: Tue, 6 Oct 2026 18:29:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: 3ad: remove unused TX state
To: Timur Stukan <timur.stukan.linux@gmail.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261006103207.68974-1-timur.stukan.linux@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261006103207.68974-1-timur.stukan.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,jvosburgh.net,lunn.ch,davemloft.net,kernel.org,redhat.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EE26121F75
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 10/6/26 12:32 PM, Timur Stukan wrote:
> The sm_tx_state field of struct port and tx_states_t enum
> were introduced in the initial 802.3ad implementation but
> have never had any users.
> The TX machine uses ntt and sm_tx_timer_counter instead.
> 
> Remove them.
> 
> Signed-off-by: Timur Stukan <timur.stukan.linux@gmail.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
