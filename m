Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F6361672
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993860; cv=none; b=e8yxyS62XnxbIszGdsHXyihozk46YTfKzYr89sDwd/pVKpb7qvYjEtI5J6J5MEyLmIkLle3Px3B0N8R8NXj2Zfs0J/HgAziAD/2niefu07IUJTq4+v/sUatxH2MzB2TaJ5JPSvydE5hqADSNMIo4+tyfuiJD0M7iMFWD+ooqsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993860; c=relaxed/simple;
	bh=2sI9fBZc+tFyW/laYlQW2CYE9Y/NY/KrtEOkMvCu82o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+zjXu7nAvlq/XjkYNx1pK/DItyKDDWrHgte1h/De1NcBxjcq1W/7iPM/GSo/fThlDDn5d1M/HL0FuT39o4Jy19b57r+faDhvPXF7s0YvynKx6k0BOVFUUbfmRZsr9TYSPPHN7Izsk+8Gr9dMG88SM2xx3BcNyuis95DkGXJSU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MNS9lrsD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cGug04oy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MNS9lrsD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cGug04oy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MNS9lrsD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cGug04oy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MNS9lrsD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cGug04oy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6E893E74B;
	Fri, 13 Feb 2026 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770993857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uz+FBcxpG5ZY8OWVakfbYjRzKqtKEUrlE4D/szmw/nw=;
	b=MNS9lrsDiNBxkFgsgXsPxppSKvqAQWhG9jlNPCnrcoDxMQgkej4aFUAkl4/J/w5afKSzeP
	keqTqHWLbhqAn+hzMsM1QASdKjv5X4EmLcnBNEIz2rZiwLuF6xvPgGA66bLLWBdzhKiygx
	jfbG22pWmkSq7LlPfLHTXwWfZWfhdhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770993857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uz+FBcxpG5ZY8OWVakfbYjRzKqtKEUrlE4D/szmw/nw=;
	b=cGug04oyWEy8qPtis22Psg6OQaCRXafKdNjxKsO1UoMXOKKpIhy06NwulB8DxXTFAc3WE3
	kZmWWTpE80ozEXBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770993857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uz+FBcxpG5ZY8OWVakfbYjRzKqtKEUrlE4D/szmw/nw=;
	b=MNS9lrsDiNBxkFgsgXsPxppSKvqAQWhG9jlNPCnrcoDxMQgkej4aFUAkl4/J/w5afKSzeP
	keqTqHWLbhqAn+hzMsM1QASdKjv5X4EmLcnBNEIz2rZiwLuF6xvPgGA66bLLWBdzhKiygx
	jfbG22pWmkSq7LlPfLHTXwWfZWfhdhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770993857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uz+FBcxpG5ZY8OWVakfbYjRzKqtKEUrlE4D/szmw/nw=;
	b=cGug04oyWEy8qPtis22Psg6OQaCRXafKdNjxKsO1UoMXOKKpIhy06NwulB8DxXTFAc3WE3
	kZmWWTpE80ozEXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F6603EA62;
	Fri, 13 Feb 2026 14:44:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6zY4EME4j2lOZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 13 Feb 2026 14:44:17 +0000
Message-ID: <8c9727bc-a1d5-4ea3-8318-f3fa7e558c85@suse.de>
Date: Fri, 13 Feb 2026 15:44:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: addrconf: reduce default temp_valid_lft to 2
 days
To: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Fernando Gont <fgont@si6networks.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net
References: <20260211202003.4550-1-fmancera@suse.de>
 <aY8uYmy1adhPqqbm@horms.kernel.org>
 <CANn89iL4zCq6gXNj7Yc_gXOrvtUhN+Zcdw5pbrUqZDgYez0ujw@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CANn89iL4zCq6gXNj7Yc_gXOrvtUhN+Zcdw5pbrUqZDgYez0ujw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On 2/13/26 3:34 PM, Eric Dumazet wrote:
> On Fri, Feb 13, 2026 at 3:00 PM Simon Horman <horms@kernel.org> wrote:
>>
>> On Wed, Feb 11, 2026 at 09:20:03PM +0100, Fernando Fernandez Mancera wrote:
>>> This is a recommendation from RFC 8981 and it was intended to be changed
>>> by commit 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
>>> but it only changed the sysctl documentation.
>>>
>>> Fixes: 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>
>> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> 
> I would recommend adding a comment, because final RFC states
> "TEMP_VALID_LIFETIME -- Default value: 1 week. Users should be able
> to override the default value.
> 
> https://datatracker.ietf.org/doc/html/rfc4941#section-5
> 
> So... do we still need a different value in linux, and why ?
> 

RFC 8981 obsoletes RFC 4941, the new RFC states
"TEMP_VALID_LIFETIME -- Default value: 2 days. Users should be able to 
override the default value."

https://datatracker.ietf.org/doc/html/rfc8981#section-3.8

I didn't include the reasoning because it was already on the blamed 
commit which comes from the RFC 8981 too.

https://datatracker.ietf.org/doc/html/rfc8981#section-4

Anyway, I am fine adding a comment or mentioning it on the commit 
message if needed.

Thanks,
Fernando.
