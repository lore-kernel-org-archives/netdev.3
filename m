Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6924C8FFE
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602734; cv=none; b=TN9lDbpn4kN3XU7fHbyxuAPemJzrzaOHSD075omf7lriV6yMdPvPjZwytkg8OGpQ70h52tvDFd3U2uVOOsjcbdyU7tzKzJKq4nxiIor8AniN0Wchx0r44EFKfGoZk7uwou6OfFpvydg8UjgCYqAEwtXHvEAe2W8E+q6ZaxBZXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602734; c=relaxed/simple;
	bh=vahJ5DHv1S2bN7JNgpwNjmzEjm97yqe2Yvsx5AMmGtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKkL3FGtyPTI10lx7mxmt6lV0M8nx0ZfxoO18QnqlYdQCjUeKXOdbm+S0LqKNCyiA/5jShcII6kmLhEWSTjAItrNk+zH5Zm4i49Wuqe/21VZoI62yfMF29JaEP/7mrGHYgi77Tu4drnf4k5ppm2G5Q4LgyKed/oS+T3lxaqNT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vW0mHRfA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VDAcXRdS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uWgGHuml; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gFz0KqVn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vW0mHRfA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VDAcXRdS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uWgGHuml";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gFz0KqVn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8841E1FB30;
	Mon, 28 Sep 2026 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790602726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kR9WOR6jCK00G/Ja8/3+15SsvO53AFtgt/QXns9cQyc=;
	b=vW0mHRfAN7jY+6UmSZcWosaC4U5bwxFxDPbvEyLT3WHqEC7DdA1pvM3f+vJIecrz7W7HY+
	FgPpD1NNnuqHV8g3xAMEdyyuJ7RYkw2m6vSQolDdR+iG1eeL8ps6NO3fhSHFdOAnaTNhXw
	q7jOOs7xlS30lDH6K3T81RKWstcAxtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790602726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kR9WOR6jCK00G/Ja8/3+15SsvO53AFtgt/QXns9cQyc=;
	b=VDAcXRdSzhj853LuJR1s2FOSAEn6sMrm0vZOVEyLx1zRJV+tkrHZXj4feSZL5TUhb3EQb6
	cimkglCpWk1xTnBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790602722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kR9WOR6jCK00G/Ja8/3+15SsvO53AFtgt/QXns9cQyc=;
	b=uWgGHumlEwSCDHRBPwqOpYpwXSIBt7wyP0FPT3e7mImRxf/fo6uv7u2EMIpckhVsGgYW9F
	XWGprPKxfHNkWt3RSh5OF5kIAGjArjpkaN5kDPJjaF5Pi5xNApQexmf2c80JdsDwjebtUh
	GzAi3jF6SQ/JuSvCdBVHdrl2IqXohPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790602722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kR9WOR6jCK00G/Ja8/3+15SsvO53AFtgt/QXns9cQyc=;
	b=gFz0KqVnpJW3pcGLa+oQG4eOAiEITmmyzkVjXr2OArvAUxLBx69Cv/FwNYXahoeExzdlGX
	F4Ql9Y7mFpJ4/rAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 160EC133F3;
	Mon, 28 Sep 2026 13:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vwJaNuFtumrbRgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 28 Sep 2026 13:38:42 +0000
Message-ID: <5d1557c8-6e0b-42cb-9132-b150f211444a@suse.de>
Date: Mon, 28 Sep 2026 15:37:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13 net-next] Allow compiling an IPv6-only kernel
 network stack
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260914172459.04db43b2@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260914172459.04db43b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On 9/15/26 2:24 AM, Jakub Kicinski wrote:
> On Thu, 10 Sep 2026 16:48:25 +0200 Fernando Fernandez Mancera wrote:
>> The primary goal of this patch series is to enable the compilation of an
>> IPv6-only kernel by decoupling the core networking infrastructure from the IPv4
>> protocol.
> 
> Could you useful to know for example how many of the recent CVEs were
> IPv4 specific, if you have enough token budget to get such data?
> 

Hi Jakub I will include the numbers in the v2 cover letter but in essence:

0.3% (32) of the released CVEs since 2025. FWIW, this only includes 
strictly IPv4-only code. The percentage is also stable over time if we 
extend the search up to 2020, 0.3% (57) of the released CVEs.

> High level, I don't have must to say beyond what you already know -
> the code movement may be too painful for backports. There are too
> many ifdefs (as Stan pointed out).
> 

Yes, the code movement is the biggest pain. Regarding the ifdefs, they 
are being reduced greatly in the v2 as I have decided to rely on DCE 
(Dead Code Elimination) to avoid using them. The code looks much better 
this way.

> sparse also complains about patch 9.

It should be fixed too, thanks!
