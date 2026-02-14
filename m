Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3221D45E8
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771075704; cv=none; b=EGKODXGUdQk1Gjey1J/DbUAZWPnUE66ROTJoMDglwdCylvV1S2EU4D/WE4UAN1qcGBfbazY9Fp5GvilYS/UHfm/zO/BbPFacHv652QoQhTnsROIOar3BwH9P2ZMUQGGAyw3lEbxx7v8/DOcTJUSSyLqb89itFGvTbZsTc1eMOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771075704; c=relaxed/simple;
	bh=k9oo7HvZ5SKhwYYUrDvWQ5rumbO9yvgKCDrnpeM7nIk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q4uaqICx2+QLiikHlkmYm/B6eEbqxV54w4bbY8xRPurFuCmXnnYKcUmyFDAdZwqexgmZpN710dB4Ij4R9LFKdh51Puc30HG6uwGKUwVoiW5cICca1ayb7+ZjZVV6g/S1i4YMY3YzmypJswCOe/mfGemXGD/nFuAqll8eIHXv0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a4VpLA81; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AFEQDe9W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XuNnjal3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oKB9F3ix; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a4VpLA81";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AFEQDe9W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XuNnjal3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oKB9F3ix"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B04E65BCD2;
	Sat, 14 Feb 2026 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771075694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8js6KoJqO3Qrf8woRM4TCED+33QTpKMItchqIGkTMUY=;
	b=a4VpLA81CtT4k8zzersDxL1i8wv9aSnUGcnPEUMLLtByWGStb7vYwUXMiuLp80H5FwF2Nu
	I2/VLxqEhQbQiz+xC6J4s76qqyarjqNDk7CJVBjFBqKW5PMk+YSazvEnW24iVAE4Mm+Xjj
	BTnJjkuyeH0fZuaOzuUSfmo2AVCE8OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771075694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8js6KoJqO3Qrf8woRM4TCED+33QTpKMItchqIGkTMUY=;
	b=AFEQDe9WIenYkj4DaNuAea1RZh4L11lZJPUeg3dqaKiScuQSGA+LHCNNFwQgbCz/maVn40
	xNWBg6vYVvXomHBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771075692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8js6KoJqO3Qrf8woRM4TCED+33QTpKMItchqIGkTMUY=;
	b=XuNnjal3UnqR/bs4y9J9o0AJNFpjyRMZe3PptV1CCipSyHG3GYaBSF7i5LQvx7m0Kw8sHf
	cA3cDZ9qsoL4kanBMJ3OUt7WnWI8iaXpOylrxNRq2IMKgouyJXIrw7lcUBlCXb+/6iIzAZ
	n4bWbGWtZaDu5Mk6aNEUg7qkg3upGaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771075692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8js6KoJqO3Qrf8woRM4TCED+33QTpKMItchqIGkTMUY=;
	b=oKB9F3ix+Eya308v+q6sZpiAwvuZWhNPGewJ5XjfkUHzuuZQv9BAcHLWGgz2nl3gpfOpuy
	ZgDe0tV9s/h09EDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E8703EA62;
	Sat, 14 Feb 2026 13:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k36YB2x4kGn/JwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 14 Feb 2026 13:28:12 +0000
Message-ID: <89d03f27-2e08-4619-b556-772da4c38462@suse.de>
Date: Sat, 14 Feb 2026 14:27:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: addrconf: reduce default temp_valid_lft to 2
 days
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Fernando Gont <fgont@si6networks.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net
References: <20260211202003.4550-1-fmancera@suse.de>
 <aY8uYmy1adhPqqbm@horms.kernel.org>
 <CANn89iL4zCq6gXNj7Yc_gXOrvtUhN+Zcdw5pbrUqZDgYez0ujw@mail.gmail.com>
 <8c9727bc-a1d5-4ea3-8318-f3fa7e558c85@suse.de>
Content-Language: en-US
In-Reply-To: <8c9727bc-a1d5-4ea3-8318-f3fa7e558c85@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,ietf.org:url]
X-Spam-Level: 
X-Spam-Flag: NO



On 2/13/26 3:44 PM, Fernando Fernandez Mancera wrote:
> On 2/13/26 3:34 PM, Eric Dumazet wrote:
>> On Fri, Feb 13, 2026 at 3:00 PM Simon Horman <horms@kernel.org> wrote:
>>>
>>> On Wed, Feb 11, 2026 at 09:20:03PM +0100, Fernando Fernandez Mancera 
>>> wrote:
>>>> This is a recommendation from RFC 8981 and it was intended to be 
>>>> changed
>>>> by commit 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
>>>> but it only changed the sysctl documentation.
>>>>
>>>> Fixes: 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
>>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>
>>
>> I would recommend adding a comment, because final RFC states
>> "TEMP_VALID_LIFETIME -- Default value: 1 week. Users should be able
>> to override the default value.
>>
>> https://datatracker.ietf.org/doc/html/rfc4941#section-5
>>
>> So... do we still need a different value in linux, and why ?
>>
> 
> RFC 8981 obsoletes RFC 4941, the new RFC states
> "TEMP_VALID_LIFETIME -- Default value: 2 days. Users should be able to 
> override the default value."
> 
> https://datatracker.ietf.org/doc/html/rfc8981#section-3.8
> 
> I didn't include the reasoning because it was already on the blamed 
> commit which comes from the RFC 8981 too.
> 
> https://datatracker.ietf.org/doc/html/rfc8981#section-4
> 
> Anyway, I am fine adding a comment or mentioning it on the commit 
> message if needed.
> 

I noticed the patch is marked as "Changes Requested", is there some 
action pending from me?

Thanks,
Fernando.
