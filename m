Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF1339872
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773838888; cv=none; b=naFaP8gDr9LaCTnvdm3DUn6dTKUJjgkNQpWcROuflT8+y/beqjLe9F9fJIdk9QseGZpVSRyKrPoiOXbcA1mqmBUR9xIGwulkytHfJnzNVmzQMEkPdgd4yGqGCjsifkf4Hd61QTdKJ2iSGe5MB1hHoOs+w9W5BK+qOscpvKoWasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773838888; c=relaxed/simple;
	bh=xE94S/UKSZWBIOAatc8u38/0HYLkmP0zHl4wGcx5wgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUOat3j8v8C+xdfYYy/uFt54dNBlLmBEFHrxWE7s77bwJf4Nj5tFVqP5lmVmy9WWESKydIatjDopHHmMyjaKzr48iTocjcWgEgcNlHopzjrKg4KQoljEvae9QU60pug1dF75WC6HXgfnlmCsx3lLF+Sf5dPzEQUWN9Qx+XGohYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HUX4xEwa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=osJyypEd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HUX4xEwa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=osJyypEd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HUX4xEwa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="osJyypEd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HUX4xEwa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="osJyypEd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1C115BD22;
	Wed, 18 Mar 2026 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773838883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRY53vbEKD3FKKKwST2agdSjygnld5Zb67oKSGBSM4M=;
	b=HUX4xEwa9TGo/NCuFHg8JL2ARCYl4zXTb2OUr/6PlwPjmUFfiDl9hjQAVWEuMTrmtGi8QA
	lF+wEtSlXvaHT/RLFKxEaKY804YMbURK3Fz0CGHNaYjvGEbPcJm+i9BU/LCcucbMxqH5Am
	9uDSCQkma0vpsTbSxpk27rKAmNGMRe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773838883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRY53vbEKD3FKKKwST2agdSjygnld5Zb67oKSGBSM4M=;
	b=osJyypEdYy3GchkWI0Dox4MKKoE+b0qc5/CzvElD/prcZLEVD4HdusZvBdIv8Sl3oMBmDp
	q9tNUCDmMD67oMBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773838883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRY53vbEKD3FKKKwST2agdSjygnld5Zb67oKSGBSM4M=;
	b=HUX4xEwa9TGo/NCuFHg8JL2ARCYl4zXTb2OUr/6PlwPjmUFfiDl9hjQAVWEuMTrmtGi8QA
	lF+wEtSlXvaHT/RLFKxEaKY804YMbURK3Fz0CGHNaYjvGEbPcJm+i9BU/LCcucbMxqH5Am
	9uDSCQkma0vpsTbSxpk27rKAmNGMRe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773838883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRY53vbEKD3FKKKwST2agdSjygnld5Zb67oKSGBSM4M=;
	b=osJyypEdYy3GchkWI0Dox4MKKoE+b0qc5/CzvElD/prcZLEVD4HdusZvBdIv8Sl3oMBmDp
	q9tNUCDmMD67oMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29B564273B;
	Wed, 18 Mar 2026 13:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SSZHByOiumkiBQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 18 Mar 2026 13:01:23 +0000
Message-ID: <56c59fc8-06eb-4ec8-af3f-fc960d7c3c40@suse.de>
Date: Wed, 18 Mar 2026 14:01:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10 net-next v3] ipv6: prepare headers for ipv6_stub
 removal
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260317140141.5723-1-fmancera@suse.de>
 <20260317140141.5723-5-fmancera@suse.de> <20260317201236.GA3581148@shredder>
 <f67f32ef-d619-4f61-9054-e6b6340129ad@suse.de>
 <20260318124539.GA3693409@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260318124539.GA3693409@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 3/18/26 1:45 PM, Ido Schimmel wrote:
> On Wed, Mar 18, 2026 at 11:43:40AM +0100, Fernando Fernandez Mancera wrote:
>> On 3/17/26 9:12 PM, Ido Schimmel wrote:
>>> On Tue, Mar 17, 2026 at 03:01:00PM +0100, Fernando Fernandez Mancera wrote:
>>>> diff --git a/include/net/ndisc.h b/include/net/ndisc.h
>>>> index d38783a2ce57..6152401f29f1 100644
>>>> --- a/include/net/ndisc.h
>>>> +++ b/include/net/ndisc.h
>>>> @@ -69,6 +69,12 @@ struct prefix_info;
>>>>    extern struct neigh_table nd_tbl;
>>>> +#if IS_ENABLED(CONFIG_IPV6)
>>>> +#define ipv6_get_nd_tbl() (&nd_tbl)
>>>> +#else
>>>> +#define ipv6_get_nd_tbl() NULL
>>>> +#endif
>>>
>>> What is the reason for converting code that is dependent on CONFIG_IPV6
>>> to use ipv6_get_nd_tbl()?
>>
>> I did it mainly for consistency. If you think this isn't fine, I can move it
>> back to &nd_tbl directly.
> 
> It creates a lot of unnecessary churn throughout the series, so I
> wouldn't change code that is currently using '&nd_tbl'. I would also
> change 'ipv6_stub->nd_tbl' to '&nd_tbl' if the code is guarded by
> IS_ENABLED(CONFIG_IPV6), which is most users.
> 

Fair enough. I will adjust it. Anyway, for the code not guarded by 
IS_ENABLED(CONFIG_IPV6) and that was using ipv6_stub the 
ipv6_get_nd_tbl() is still necessary.

Thank you for the feedback!

