Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE423E3DBB
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535923; cv=none; b=NsyKQv09uCRruyvZVtj3E0jXS68vHsRcYV0de9vN2RkCAUJ3bdw+m5l05+qxPr04SgR2b+fsktqsCUGPIorvwMFUCYwY0mi79VWIst22hzLdGgalarRYvUWT+9angl6OOJT4zqnHaK9SpOtdV4kJlFFaU4UENzTE9mKUPkwUj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535923; c=relaxed/simple;
	bh=P8ym+bKfgQVp7qPiXwBVzyeMDcrkTQz1efo6EdXNQss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbddnbjxkhW6+gIF+U00mYfyaRJ6Cf07fSDA+2m1y6+qBU0oAPpeDuBMkTtuZXNgJaX3xprSWC/ZB+z6xxikw56B0FHDWfMLcUGvkWNelVSZGYhzls/5Hsijii+ptpB0Nya88+5RSubbvWFTsnsGdWn104AJaey3T9AgGjTbVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iFoHbrhh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IkRsL+RE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OAa0d3Uf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dgPoNKy9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iFoHbrhh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IkRsL+RE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OAa0d3Uf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dgPoNKy9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 367E65BDF1;
	Tue,  3 Mar 2026 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772535920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68xl/I4u4RtUcOi/oKXaVJdZ21aE1MjrJ4Bg6odh8XM=;
	b=iFoHbrhhgnLPieBtuPDT/IiqXpUyU37RRATeSx962Q4LK+VmPf027mbePIOo3RTTPhV7jg
	QwcEEiMKhSHmtwBpVKoQceYSK22IybhDFDcKDjXviDVHEWqB3qyCiXEtTAOxBGrBG1KA4u
	5eg0f/IOpEmAfWGXMRXbs9VqyGeXrdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772535920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68xl/I4u4RtUcOi/oKXaVJdZ21aE1MjrJ4Bg6odh8XM=;
	b=IkRsL+RE6OX3Fr0AVkmhRDpCFpCjmO/XYqe95QOZVv3EoIKrjhUz+qWzmyjVjdwf9pgLZM
	d23xf/Xj1GKWljCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OAa0d3Uf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dgPoNKy9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772535919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68xl/I4u4RtUcOi/oKXaVJdZ21aE1MjrJ4Bg6odh8XM=;
	b=OAa0d3UfSQaZCbU4qmy5DCq7icCQEdD33y8nm420+22IGMX4l/4LNckU4BFSkrMo3jcNYK
	8XNLVHaa9ZzFgB5X6VIdTkYpPMirr9rCx1abpGSb/TrIL4dqpy7cG8Z0HAmwWZaFkXiNRR
	dE12iQfd2WeXb0uJjapRhEQQ8LqzfxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772535919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68xl/I4u4RtUcOi/oKXaVJdZ21aE1MjrJ4Bg6odh8XM=;
	b=dgPoNKy98VY7PuA4URPFcU0r8M2p0ZRpG7DuophkKRkMSwJKyc68Us5Bhxa7B1kfgq5LXE
	+TrbHHTid3obmQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C9C13EA69;
	Tue,  3 Mar 2026 11:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3FGKD2zApmnyNQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 03 Mar 2026 11:05:16 +0000
Message-ID: <a7cfab1f-24a3-47db-9c71-8d3610809460@suse.de>
Date: Tue, 3 Mar 2026 12:04:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net-next v2] ipv4: validate IPV4_DEVCONF attributes
 properly
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
References: <20260226133949.17070-1-fmancera@suse.de>
 <20260228104328.260172d2@kernel.org>
 <a038563b-05f2-4e11-9cd4-ad6374d379aa@suse.de>
 <20260302161824.0cb19417@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260302161824.0cb19417@kernel.org>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 367E65BDF1

On 3/3/26 1:18 AM, Jakub Kicinski wrote:
> On Mon, 2 Mar 2026 09:35:06 +0100 Fernando Fernandez Mancera wrote:
>>>> Please note that MEDIUM_ID is defined as NLA_U32 too because currently
>>>> its usage through netlink is broken for its valid value -1. Modifying
>>>> the type to NLA_S32 would break existing users of set/get netlink
>>>> operation.
>>>
>>> Say more? The policy type not matching the accessor used by the kernel
>>> is probably fine in this case (since there's a common accessor used for
>>> all attrs). If it helps the policy, we can use a different type.
>>
>> The problem is not only not matching the accessor.. the problem is that
>> while it was not validated if users were using NLA_U32 as indicated by
>> the original implementation (see blamed commit), this would break them.
>>
>> Is it one option to set the type to NLA_S32 and wait to see if someone
>> complains? I am not sure how many people might be using it considering
>> the type is wrong.
> 
> Sorry, I'm not connecting the dots.
> 
> 	[IPV4_DEVCONF_MEDIUM_ID]	= { .type = NLA_U32 },
> vs
> 	[IPV4_DEVCONF_MEDIUM_ID]	= { .type = NLA_S32 },
> 
> makes absolutely _no_ difference. For bare types with no ranges
> the validation will only check the attr is 4B which is identical
> for both.
> 

I was not connecting the dots neither. Thanks for explaining, I already 
knew this but somehow I forgot about it when working on this.

> For S32 you can add a range, however, the NLA_POLICY_RANGE() takes
> two signed 16b values. So a range of -1 .. x is completely fine.
> 

