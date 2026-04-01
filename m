Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87DE3EF0D1
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086274; cv=none; b=q8W9ttG6vd1jlP8XIi/yEWmoXcntZbL9QqscR9Zx3E0dC/QHLU/ZuHjUl+RLtlc74emCahMdj+tjUNXJLSulCCyREZw6bSEXqyGry3e1dGYOdJ0sxbln1wPgzcK35RciBNCLy2qfWmatceAeqkL5AvBOoJa2qCYHShnMT4VfOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086274; c=relaxed/simple;
	bh=lJX14ie8LiVHEIM9qwmGx6AN3mxCvKkXGKCpHYoPQUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULKZ2FWsmjW2HQzacGQnBmSFGw5WLWZTbITWhIcmVCnVmV2RCw/xXI0x+ysBAao/vFdGernYaY3JNsTM5w9Ig8JAGWcVYuXtrwrDlSSlpPwjtl61wQQnpLGTK0ijkfKaedXNnbHlMNoTL0R5b8VG4dPFn23qwSa6dEWxgTmSUFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S0j7vhqR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lfe3igE6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ahNbzSvG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VLyWKJFa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S0j7vhqR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lfe3igE6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ahNbzSvG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VLyWKJFa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99FAE5BCE5;
	Wed,  1 Apr 2026 23:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775086270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQUiLRJhFA96l1WRYQ5Sp368FkEKEeSv8cIdNr4EZq8=;
	b=S0j7vhqRWEYmUZ/SJCtZUhYNWi4XaPcfD374fYbgO+yuTWEL4lho4lYjWQksIhxPJNIpiG
	IgWf+a6vX1jZZvc3qRFg+3gzXKg42L3uuFpC+6VaxyVZCFNTbCkpJMHkYlwagrlsYlCv1F
	epK+o8cSTGK/HHF+LDDJd40rhRzOknE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775086270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQUiLRJhFA96l1WRYQ5Sp368FkEKEeSv8cIdNr4EZq8=;
	b=lfe3igE6oiVa9MnAhtSprS1r3C84liAOiDA3kYwrt7zKhOf9vjessVYHObt7OOqxxpdBf9
	LTyAOaVbEE9QK3Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ahNbzSvG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VLyWKJFa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775086269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQUiLRJhFA96l1WRYQ5Sp368FkEKEeSv8cIdNr4EZq8=;
	b=ahNbzSvGRTRBh4yuBw7Wdn+a8e4WUbEYBL1LSm70Gk0ec1I1NVkuh8lkJpxjTVCaI7M4x4
	mPGYXQgAbrWsUfWfoEWt6bOAZBEfK21YM8/k2ROgNOhnyd/wRV6oDCv+lAy19/0PZZz+5H
	EJlfswEzVPu3yttIKGjMy7Z3IcImW24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775086269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQUiLRJhFA96l1WRYQ5Sp368FkEKEeSv8cIdNr4EZq8=;
	b=VLyWKJFaTTw73CzPqCATJMLOq227aueIdpQ12Uqf39TouGfFpC7sEV62LYYgSWHvbx2o31
	tDZ4oB9XInPHEqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 228944A0B0;
	Wed,  1 Apr 2026 23:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N+JbBb2qzWnzHQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 23:31:09 +0000
Message-ID: <78c9c953-1aaa-4d44-9c1d-b4e52a5cead3@suse.de>
Date: Thu, 2 Apr 2026 01:30:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision
 TLV
To: Luka Gejak <luka.gejak@linux.dev>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
References: <20260401092324.52266-1-luka.gejak@linux.dev>
 <20260401092324.52266-2-luka.gejak@linux.dev>
 <4549f521-6395-4c26-921e-eaead7248a36@suse.de>
 <DHHZD2L18VZT.2TLAQO4JAD79Y@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <DHHZD2L18VZT.2TLAQO4JAD79Y@linux.dev>
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 99FAE5BCE5
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 4/1/26 7:05 PM, Luka Gejak wrote:
> On Wed Apr 1, 2026 at 11:52 AM CEST, Fernando Fernandez Mancera wrote:
>> On 4/1/26 11:23 AM, luka.gejak@linux.dev wrote:
>>> From: Luka Gejak <luka.gejak@linux.dev>
>>>
>>> Supervision frames are only valid if terminated with a zero-length EOT
>>> TLV. The current check fails to reject non-EOT entries as the terminal
>>> TLV, potentially allowing malformed supervision traffic.
>>>
>>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>>> with a length of zero.
>>>
>>> Reviewed-by: Felix Maurer <fmaurer@redhat.com>
>>> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
>>> ---
>>
>> Hi,
>>
>> This has not been reviewed by Felix. Felix provided his Reviewed-by tag
>> for the v1 which was completely different than this.
>>
>> Revisions of this patch:
>>
>> v3: https://lore.kernel.org/all/20260329112313.17164-4-luka.gejak@linux.dev/
>>
>> v2: https://lore.kernel.org/all/20260326154715.38405-4-luka.gejak@linux.dev/
>>
>> v1:
>> https://lore.kernel.org/all/20260324143503.187642-4-luka.gejak@linux.dev/
>>
>> Are these contributions LLM/AI generated? I believe so based on the
>> email history.
>>
>> AI generated review on rtl8723bs:
>> https://lore.kernel.org/all/B2394A3C-25FD-4CEA-8557-3E68F1F60357@linux.dev/
>>
>> Another AI generated review on rtl8723bs:
>> https://lore.kernel.org/all/3831D599-655E-40B2-9E5D-9DF956013088@linux.dev/
>>
>> Likely an AI generated review on a 1 year old HSR patch:
>> https://lore.kernel.org/all/DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev/
>>
>> If these are indeed, AI generated contributions or reviews they should
>> be disclosed beforehand. Also there is the Assisted-by: tag. Also note
>> that developer must take full responsibility for the contribution which
>> means understanding it completely.
>>
>> https://docs.kernel.org/process/coding-assistants.html#signed-off-by-and-developer-certificate-of-origin
>>
>> Thanks,
>> Fernando.
> 
> HI Fernando,
> One more question, should I include Assisted-by tag in v5 if AI was not
> used for writing code but only for formating and translation of the
> emails to English as I previously mentioned.
> 

I think yes, you should. I also think that AI was actually used for the 
generated code and also for spotting the valid and invalid issues. If 
you don't have a real environment for HSR, why would you look into it?

Sorry, it is not my intention to be harsh but there are some things that 
don't add up for me. Maybe I am being too careful here and you just 
coincidentally found these problems.

> Best regards,
> Luka Gejak
> 

