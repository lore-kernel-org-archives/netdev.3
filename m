Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC0379EE9
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440035; cv=none; b=nidiZkkEOQLgxVd9e7epl5lqg1N2owrP2nSY0/XAc25CSoiC00iiBtLhJwD5cRTezlndsRDnBhNasEuxNos0eBO8fH+OaWTr68UprHGz8JGHdI9q+kTbDtahtsmj2qMO1ZDkraAPRGKJMdTv5tp+MGsr91whYLaicHTG3uQzCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440035; c=relaxed/simple;
	bh=abl639WzpFQrR9CsLzLZvpA2dEn59beOrRf7yzNvngg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZxrwJk2L9GvzKjIbSs9h7op0Kow7wLBCTc9wxrEfdVHpdHWmzpfLaZTzHdxDNOSKpuSh2lHeB2NXfhigx/DBmGr2axyyGfjWl6zQdCxm+5dL46u2Tygc9lNZqJhHsf7ZmqpczbW/cTOVLy0HhqDBzZiK/atfK8wB2puTKnOj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OfONxUxC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DeVR/7o6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OfONxUxC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DeVR/7o6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OfONxUxC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DeVR/7o6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OfONxUxC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DeVR/7o6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C68AD5BD0E;
	Mon,  2 Mar 2026 08:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772440032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV1vbnGXh04kFzK1MuebINiw2OSlvF2TcWr6i4Oav/Y=;
	b=OfONxUxCs5rYaBnwubUaZdpN716zwjgmqHQeBJJpQZRSxABadsBK2TkhbhwjZoJZM+Shut
	XtPuOU/xjl/pHUT/rGKb5WW30i3SQhVrcyE49TSQ9BWsmRbn/XGn3n3AOznby01ZVsxz1W
	PN1RYFND1VRgf8Vf4bMz2RGObAdoV3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772440032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV1vbnGXh04kFzK1MuebINiw2OSlvF2TcWr6i4Oav/Y=;
	b=DeVR/7o6L/t5dwf/fQhC2+CsoyfEcG3bCnJKl0IoEJswC4hzp3YVMHpT7pZhVUOHAj2b1b
	2bQctWxEzOiurOCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772440032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV1vbnGXh04kFzK1MuebINiw2OSlvF2TcWr6i4Oav/Y=;
	b=OfONxUxCs5rYaBnwubUaZdpN716zwjgmqHQeBJJpQZRSxABadsBK2TkhbhwjZoJZM+Shut
	XtPuOU/xjl/pHUT/rGKb5WW30i3SQhVrcyE49TSQ9BWsmRbn/XGn3n3AOznby01ZVsxz1W
	PN1RYFND1VRgf8Vf4bMz2RGObAdoV3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772440032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV1vbnGXh04kFzK1MuebINiw2OSlvF2TcWr6i4Oav/Y=;
	b=DeVR/7o6L/t5dwf/fQhC2+CsoyfEcG3bCnJKl0IoEJswC4hzp3YVMHpT7pZhVUOHAj2b1b
	2bQctWxEzOiurOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 517D73EA69;
	Mon,  2 Mar 2026 08:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JJbPEOBJpWmsMAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 02 Mar 2026 08:27:12 +0000
Message-ID: <65e44884-2db7-4db0-8f48-138983314450@suse.de>
Date: Mon, 2 Mar 2026 09:27:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next v2] ipv4: bump rt_genid when a relevant
 devconf value changes through netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
References: <20260226133949.17070-1-fmancera@suse.de>
 <20260226133949.17070-2-fmancera@suse.de>
 <20260228104547.56186b2d@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260228104547.56186b2d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/28/26 7:45 PM, Jakub Kicinski wrote:
> On Thu, 26 Feb 2026 14:39:49 +0100 Fernando Fernandez Mancera wrote:
>> When modifying IPv4 devconf values using netlink for some relevant
>> fields the rt_cache_flush() call was missing. In addition, if forwarding
>> is enabled on the interface then disable LRO.
>>
>> This is needed to avoid possible connectivity issues and ease the
>> responsabilities of user space tools.
>>
>> Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> This OTOH probably deserves to be a real fix for net?

Okay, makes sense. Let me re-send this to net.git without relying on the 
previous patch. Then once is merged and net-next is synced I will 
re-send the validation one.

Thanks,
Fernando.
