Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E762E11D2
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130802; cv=none; b=Oyg6v85XVaMvoROoNlelsokoalzhC24SyZ6Cr8C/ehjKCHPgrkXM8pj4QSbQ3nD6thczXhN+tOCVFVSEZ5FRH6mmmbuy3MqEl7D0C05abjyLVwUi7AVcaFxihmbVPIBQpZIwQLsF0qMvXKCOLEDo0xcJigGY/wm2kzrmYmpnUSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130802; c=relaxed/simple;
	bh=0VevDQVTDaErw8iSWjbcNXbDaAtDjLJbzkmyX9pzlWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BB/XNhirzVEKBNjrQADv8TiprgrW0aMYrOqNS1yyhajkaVmaDFNTc5MpJvslnQe97O70lnDLxMcgf5G2yq3GJr/wnJ9pFqoK+L6FpqUw6a3W1O60O+l3L1g0zbmTfrfipl+hxsUktA3Y7zKjBdkF3H5j9vhD1NvpYwjwsqZc7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jqoeueEF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U3RfeZ++; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jqoeueEF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U3RfeZ++; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jqoeueEF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U3RfeZ++";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jqoeueEF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U3RfeZ++"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5146C758EB;
	Mon, 22 Jun 2026 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782130799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ohf9ubqdDTE4+SiZNzzPsJ/5S73zeXWMQQIAR1OJgU=;
	b=jqoeueEFaWbTzRfb/VpkWvTyS9AMGVQpoJtOJiQvOrwpLflflMZcJfHGXLGo2aLVdkR8tD
	+VotYY6YdcAXHQPny+fEhVLrgoMMcOEPB09GxumhZ3MFPZUPN527vIJLY9JvP+qgV9hRbG
	7eP9vbw7nJWWyMkv2yjH71SsMhlfDcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782130799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ohf9ubqdDTE4+SiZNzzPsJ/5S73zeXWMQQIAR1OJgU=;
	b=U3RfeZ++6Ix1706n6ETN1Z6qkYiiyWtTwmBcWh+G1Sm6+An5sp0NOK6ywxk1+aZ+xtqN9L
	Dkf6Wn2tBr8OJJAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jqoeueEF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U3RfeZ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782130799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ohf9ubqdDTE4+SiZNzzPsJ/5S73zeXWMQQIAR1OJgU=;
	b=jqoeueEFaWbTzRfb/VpkWvTyS9AMGVQpoJtOJiQvOrwpLflflMZcJfHGXLGo2aLVdkR8tD
	+VotYY6YdcAXHQPny+fEhVLrgoMMcOEPB09GxumhZ3MFPZUPN527vIJLY9JvP+qgV9hRbG
	7eP9vbw7nJWWyMkv2yjH71SsMhlfDcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782130799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ohf9ubqdDTE4+SiZNzzPsJ/5S73zeXWMQQIAR1OJgU=;
	b=U3RfeZ++6Ix1706n6ETN1Z6qkYiiyWtTwmBcWh+G1Sm6+An5sp0NOK6ywxk1+aZ+xtqN9L
	Dkf6Wn2tBr8OJJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A17DE779A8;
	Mon, 22 Jun 2026 12:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F1JPJG4oOWpyXwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 22 Jun 2026 12:19:58 +0000
Message-ID: <05b42695-82a8-45c4-8f99-074a9767ceb5@suse.de>
Date: Mon, 22 Jun 2026 14:19:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 7/7] ipv6: reset position for force_forwarding
 sysctl restart
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
 stephen@networkplumber.org, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org
References: <20260620161850.7114-1-fmancera@suse.de>
 <20260620161850.7114-8-fmancera@suse.de> <20260622114223.GA233619@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260622114223.GA233619@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5146C758EB
X-Spam-Score: -4.51

On 6/22/26 1:42 PM, Ido Schimmel wrote:
> On Sat, Jun 20, 2026 at 06:18:50PM +0200, Fernando Fernandez Mancera wrote:
>> When handling proxy_ndp, if rtnl_net_trylock() fails, the operation is
> 
> s/proxy_ndp/force_forwarding/
> 
>> retried but the position pointer was already advanced meaning that the
>> restarted sysctl will read from an incorrect offset.
>>
>> Fix this by restoring the original position pointer before restarting
>> the syscall.
>>
>> In addition, remove the redundant position pointer restoration at the
>> end of the function.
>>
>> Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   net/ipv6/addrconf.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> index cbe681de3818..8c0741e9dfcc 100644
>> --- a/net/ipv6/addrconf.c
>> +++ b/net/ipv6/addrconf.c
>> @@ -6825,8 +6825,10 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
>>   	ret = proc_douintvec_minmax(&tmp_ctl, write, buffer, lenp, ppos);
>>   
>>   	if (write && old_val != new_val) {
>> -		if (!rtnl_net_trylock(net))
>> +		if (!rtnl_net_trylock(net)) {
>> +			*ppos = pos;
>>   			return restart_syscall();
>> +		}
> 
> Are you sure that this is needed?
> 
> AFAICT, the position pointer is only advanced if the return value is
> positive. From new_sync_write():
> 
> kiocb.ki_pos = (ppos ? *ppos : 0);
> [...]
> ret = filp->f_op->write_iter(&kiocb, &iter);
> [...]
> if (ret > 0 && ppos)
>          *ppos = kiocb.ki_pos;
> 
> And restart_syscall() returns '-ERESTARTNOINTR'.
> 

Hm, I think you are right. I was not aware of this check, thanks for 
pointing it out. That means we can get rid of position pointer reset 
from the rest of the code.. the are plenty of sysctl following this 
pattern. I will prepare a batch for net-next.

I am sending a v3 dropping this patch.

Thank you Ido!

>>   
>>   		WRITE_ONCE(*valp, new_val);
>>   
>> @@ -6851,8 +6853,6 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
>>   		rtnl_net_unlock(net);
>>   	}
>>   
>> -	if (ret)
>> -		*ppos = pos;
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.54.0
>>

