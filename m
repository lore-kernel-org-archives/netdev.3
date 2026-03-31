Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25F2C3244
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961430; cv=none; b=CuLRxjyC2EjWSjpZhwIKe9MIQXzd8YS3IAT1RDzp+2StcruSmy9cJ71s0gWgOHECERBeoRzHGsQ0rGPhFMRUWsiKrvYZLmsd1XPvhsbRMvezhuKBH1QHdzC/mSkYr5CNLw+3SKI1Udr602OpokSezFrTMPEmlUWlYaNzVm3yV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961430; c=relaxed/simple;
	bh=kUY88OuxQ14pQ4iSLN44opP244kgxsdM/ArM7XKjUbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNME1Jekb8xwFR5e5wWabnp3sOAfWAEd6teR1T6HoygoalJtEe5oDbRHh368GCbzCSQk32gbfRiWaOVno6JcyPK4T6Bi1lSyLWL1Dg2Gf/XDtMbTKfMCGaW3P/kTh3DkktbAfUoSr4MqveopmBx5nL35TtP160MStR5hIWmS46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zvMVIKK9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RRUQ8kP0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zvMVIKK9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RRUQ8kP0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zvMVIKK9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RRUQ8kP0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zvMVIKK9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RRUQ8kP0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B96BE5BCC8;
	Tue, 31 Mar 2026 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774961425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tmFQFhsGTZkxomYTRVwynVgBeRRU4r997ACvYXwOQE=;
	b=zvMVIKK91OzaRbn6m/msGm6OCPpNoHGVq+WzaerTrUdhm9XpNA2NBnu/OrNgc+IyIBQNHy
	BZfN8sVfRMHZumurQIUXbE40O+Zz4jeF0SWPoF9r5ndhRpY3DcalpBgY0ZAv+07DfBTk68
	PN+spRT333oh6q5Kk4AZwJk7wKGXAO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774961425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tmFQFhsGTZkxomYTRVwynVgBeRRU4r997ACvYXwOQE=;
	b=RRUQ8kP0P5XvD9k8CIWIaHWwJkrCYQTDKg47mmH5Tf/HlIyIOAdBWFA/ZwvhmP50NClldG
	6zpTD0wN6S0I/XAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zvMVIKK9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RRUQ8kP0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774961425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tmFQFhsGTZkxomYTRVwynVgBeRRU4r997ACvYXwOQE=;
	b=zvMVIKK91OzaRbn6m/msGm6OCPpNoHGVq+WzaerTrUdhm9XpNA2NBnu/OrNgc+IyIBQNHy
	BZfN8sVfRMHZumurQIUXbE40O+Zz4jeF0SWPoF9r5ndhRpY3DcalpBgY0ZAv+07DfBTk68
	PN+spRT333oh6q5Kk4AZwJk7wKGXAO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774961425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tmFQFhsGTZkxomYTRVwynVgBeRRU4r997ACvYXwOQE=;
	b=RRUQ8kP0P5XvD9k8CIWIaHWwJkrCYQTDKg47mmH5Tf/HlIyIOAdBWFA/ZwvhmP50NClldG
	6zpTD0wN6S0I/XAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EE114A0A2;
	Tue, 31 Mar 2026 12:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k2gqDBHDy2kVMAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 31 Mar 2026 12:50:25 +0000
Message-ID: <9aaf6dc6-3c21-4cec-9f16-5d76cb40dc80@suse.de>
Date: Tue, 31 Mar 2026 14:50:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 Yiming Qian <yimingqian591@gmail.com>
References: <20260331115943.10404-1-fmancera@suse.de>
 <CANn89iLJUi+cA4fFr7XQESkT+5ckY6+MGg7QEM-G123RzuD5RQ@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CANn89iLJUi+cA4fFr7XQESkT+5ckY6+MGg7QEM-G123RzuD5RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,davemloft.net,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: B96BE5BCC8
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 3/31/26 2:13 PM, Eric Dumazet wrote:
> On Tue, Mar 31, 2026 at 5:00 AM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
>>
>> When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
>> allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
>> single nexthops and small Equal-Cost Multi-Path groups, this fixed
>> allocation fails for large nexthop groups like 512+ nexthops.
>>
>> This results in the following warning splat:
>>
>>   WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, CPU#19: rep/9282
>>   [...]
>>   RIP: 0010:rtm_get_nexthop+0x176/0x1c0
>>   [...]
>>   Call Trace:
>>    <TASK>
>>    rtnetlink_rcv_msg+0x168/0x670
>>    netlink_rcv_skb+0x5c/0x110
>>    netlink_unicast+0x203/0x2e0
>>    netlink_sendmsg+0x222/0x460
>>    ____sys_sendmsg+0x35a/0x380
>>    ___sys_sendmsg+0x99/0xe0
>>    __sys_sendmsg+0x8a/0xf0
>>    do_syscall_64+0x12f/0x1590
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>    </TASK>
>
> I find these stack traces without symbols not very useful.

Hi Eric,

sure, here is the decoded trace:

  WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, 
CPU#20: rep/4608
  RIP: 0010:rtm_get_nexthop (net/ipv4/nexthop.c:3395 (discriminator 2))
  Call Trace:
   <TASK>
   rtnetlink_rcv_msg (net/core/rtnetlink.c:6989)
   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
   netlink_unicast (net/netlink/af_netlink.c:1319 
net/netlink/af_netlink.c:1344)
   netlink_sendmsg (net/netlink/af_netlink.c:1894)
   ____sys_sendmsg (net/socket.c:721 (discriminator 16) net/socket.c:736 
(discriminator 16) net/socket.c:2585 (discriminator 16))
   ___sys_sendmsg (net/socket.c:2641)
   __sys_sendmsg (net/socket.c:2671 (discriminator 1))
   do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) 
arch/x86/entry/syscall_64.c:94 (discriminator 1))
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
   </TASK>

> 
> Any reason you have not used scripts/decode_stacktrace.sh ?
> 

Not really, in the past I checked other commits with `git log --grep 
"Call Trace"` and found out that most of the traces did not have symbols 
so I decided to attach the raw trace.

I do not really have a personal preference here. If trace with symbols 
is preferred I will do it like that in the future. I could also send a 
V2 of this patch if needed.

Thanks!
Fernando.
