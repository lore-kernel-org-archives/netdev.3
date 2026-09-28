Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528C4E73B9
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622995; cv=none; b=llKZPtuzWJYxjDDLivFmO4OqBTB/ZzUjnk3XdXqtdGyqMDuobnqWf1Wl/XI0nt6sxqpZq7HRx0ktgsgv0VcFoH+5+1JUn5Z+2hQ5qVTh8p1+K/hiH/wJZ1wvhJxqjRBOY9+WrzoL5X6K+G25UMCUAyzGqv2lOnHvjjFL2D7kQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622995; c=relaxed/simple;
	bh=4fGb1KzeQzVp9ReKrUNPoyNnMbpYbPDqqlQoRYnfpyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqFuko+m1v5HyfWyu+XIFoJWPQr1Eja4QxFDdSCIJJfPpYfAaJUxF5O15wcfO4aFccZH9dTRTNXm4GS7b4/wc7DByoofCK0OqQqzfiVA9cfCLiXSTfG4Fm4FCWXj+7orLNPoGK8igtlhVlOdY8qCxYLNXnPFidPF7y6atUV4sJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bomA0Js7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dP1s9U9A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gr3MM3Yg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zX8MkUFc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bomA0Js7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dP1s9U9A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gr3MM3Yg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zX8MkUFc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F0AD1F7B8;
	Mon, 28 Sep 2026 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790622986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T20x+EWLDNftUUAPVcWETUh7OzbpWrgXF4Q4AwcpMdQ=;
	b=bomA0Js79etIVqKHRX4xWPB6aY/NMsvBkcQ3gmCDdsQLfpaPOXdsS91gNZC6mY1DGTYk5r
	Zp9FUk7u9bYhZ2dJ6uyPt2SPqbqnlTOHiWhRfv+iIYOzYpiOEk7ZoebbRHX37hF78/mpLr
	/qQsUlipD45V6sQWC1IbiGJxRNBWpFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790622986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T20x+EWLDNftUUAPVcWETUh7OzbpWrgXF4Q4AwcpMdQ=;
	b=dP1s9U9AY7ugT+usZKiYlkFj0mPNIZ/8j1LCNtG8S5965HBqzeW6SbzDa8A78jm1KkQkWD
	VEHFyRoa/OiJUzBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gr3MM3Yg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zX8MkUFc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790622982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T20x+EWLDNftUUAPVcWETUh7OzbpWrgXF4Q4AwcpMdQ=;
	b=gr3MM3Ygdy6ZfEHEm1Er4T8GY4aeIIUIh/TMaBGkulfGbnPTKeeQQdkpHzxuJxtv5Q46CA
	DgIkN+0M72QVo3gQJR7apLrlDdGGGXxktv3gX/TO2W1RLAmepyoE0Oc4fcA0+sLo85M3lu
	D+udOECExxjhz3qHTGN3x10ckEIcphk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790622982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T20x+EWLDNftUUAPVcWETUh7OzbpWrgXF4Q4AwcpMdQ=;
	b=zX8MkUFciR+XoE7JxQfPHH8N5z/QJLs2O+cr23R5CDigCSQCyHjHyC9/0U/ODKTKRuYqDF
	TLRHsPYNy4Fn8uCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB77D1340F;
	Mon, 28 Sep 2026 19:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vrKoLAW9umr/KAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 28 Sep 2026 19:16:21 +0000
Message-ID: <f6f141ec-6294-4fbc-be13-04b9b0e6b45f@suse.de>
Date: Mon, 28 Sep 2026 21:15:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13 net-next] Allow compiling an IPv6-only kernel
 network stack
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260914172459.04db43b2@kernel.org>
 <5d1557c8-6e0b-42cb-9132-b150f211444a@suse.de>
 <willemdebruijn.kernel.736256d759b9@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <willemdebruijn.kernel.736256d759b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 8F0AD1F7B8
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Spam-Flag: NO

On 9/28/26 7:08 PM, Willem de Bruijn wrote:
> Fernando Fernandez Mancera wrote:
>> On 9/15/26 2:24 AM, Jakub Kicinski wrote:
>>> On Thu, 10 Sep 2026 16:48:25 +0200 Fernando Fernandez Mancera wrote:
>>>> The primary goal of this patch series is to enable the compilation of an
>>>> IPv6-only kernel by decoupling the core networking infrastructure from the IPv4
>>>> protocol.
>>>
>>> Could you useful to know for example how many of the recent CVEs were
>>> IPv4 specific, if you have enough token budget to get such data?
>>>
>>
>> Hi Jakub I will include the numbers in the v2 cover letter but in essence:
>>
>> 0.3% (32) of the released CVEs since 2025. FWIW, this only includes
>> strictly IPv4-only code. The percentage is also stable over time if we
>> extend the search up to 2020, 0.3% (57) of the released CVEs.
>>
>>> High level, I don't have must to say beyond what you already know -
>>> the code movement may be too painful for backports. There are too
>>> many ifdefs (as Stan pointed out).
>>>
>>
>> Yes, the code movement is the biggest pain. Regarding the ifdefs, they
>> are being reduced greatly in the v2 as I have decided to rely on DCE
>> (Dead Code Elimination) to avoid using them. The code looks much better
>> this way.
> 
> On code movement: are the large code block movements into separate ipv4
> files needed, or could those just as well stay in place, behind an if
> enabled check?

It depends. Most of it could be guarded with ifdefs but that would IMHO 
make the code ugly and quite confusing. That code is 100% IPv4-only so 
it should be moved out..

In addition, this happened in the past too, e.g net/ipv4/tcp_ipv4.c was 
splitted from net/ipv4/tcp.c even before this series.

Of course, I trust maintainers' taste here so if you all insist that it 
is much better to put ifdefs.. so be it! But in my opinion, this make 
completes sense (while acknowledging the pain it might introduce for 
backports). FWIW, the code does not change.. so finding the function in 
the other file should be rather easy.

Thanks,
Fernando.
