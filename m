Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0F2D837C
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887686; cv=none; b=e48SKrp4sZTjQEd+MLxiWm88fa69+AZf0y/veM+fBHnvha87owoZ3Z3UQKbG5E54Zq+e3U6i+V/RIL2VsR+Io7yJq1qmSMk7mCyXd/tV53O7E16P1pNHF2dzUSZ+I/RmBsywj5oWQdOrD5mYuvtn5CcTzYtiaPGWfOcYeElrlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887686; c=relaxed/simple;
	bh=RF9yKM7HdRUCLkef2ihnPa2GruMTDRe4TXbSuvEyt5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clrzAJI7nNZ9IGWnSqF4Aln27mFa99SwwAk6ZbhnkTn5cDDD9qcpD0X07Hh9sXppAF678s98DNSw08OATH9L0DmRqTVdfqFvKSVjJQ3aeDsjZBt943wfKBLUlC7FxUDTs/BbN+SsYZwX7i0unJe+3q2geJjh2yd9gpftQTSffSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uZCdXCV2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fvusH3Cj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uZCdXCV2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fvusH3Cj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uZCdXCV2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fvusH3Cj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uZCdXCV2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fvusH3Cj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0120A6DCD3;
	Fri, 19 Jun 2026 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781887340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXQ3wtdV83d3xjwQk+9qyaGwpV9Wn1moUT/NnM6Vprc=;
	b=uZCdXCV2CLgyNxUkwWUDryvasqnlxkuFCM+F4xE4ix4GYhXYmJvHhUCUGwNc7Mu3IOFgJH
	jMkXU0nNn1HrPlKGAAKvkmY/qpoO8asYhJ9kHRYX0VadDlFT6JZpMcB7/rEkcP4ASc7vdb
	y8AUOxl9BE4+1E09j+yQ3veSSBrLBJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781887340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXQ3wtdV83d3xjwQk+9qyaGwpV9Wn1moUT/NnM6Vprc=;
	b=fvusH3CjGDele0c4kACYrzFH4jaTZFVJegP+J+1hWH8KmybfzjkVozls8SU+aCQwZ3qfjr
	tS9/pO/cYD9pT8CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781887340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXQ3wtdV83d3xjwQk+9qyaGwpV9Wn1moUT/NnM6Vprc=;
	b=uZCdXCV2CLgyNxUkwWUDryvasqnlxkuFCM+F4xE4ix4GYhXYmJvHhUCUGwNc7Mu3IOFgJH
	jMkXU0nNn1HrPlKGAAKvkmY/qpoO8asYhJ9kHRYX0VadDlFT6JZpMcB7/rEkcP4ASc7vdb
	y8AUOxl9BE4+1E09j+yQ3veSSBrLBJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781887340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXQ3wtdV83d3xjwQk+9qyaGwpV9Wn1moUT/NnM6Vprc=;
	b=fvusH3CjGDele0c4kACYrzFH4jaTZFVJegP+J+1hWH8KmybfzjkVozls8SU+aCQwZ3qfjr
	tS9/pO/cYD9pT8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 384BA779A8;
	Fri, 19 Jun 2026 16:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RxPFCmtxNWqpIAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 19 Jun 2026 16:42:19 +0000
Message-ID: <ce2dd6b5-5716-4ae7-8183-8a96642c6be4@suse.de>
Date: Fri, 19 Jun 2026 18:42:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6] ipv6: fix sysctl error handling and missing
 notifications
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com, shemminger@vyatta.com, dforster@brocade.com,
 gospo@cumulusnetworks.com, ddutt@cumulusnetworks.com, brian.haley@hp.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org
References: <20260618162225.4588-1-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260618162225.4588-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -4.30

On 6/18/26 6:22 PM, Fernando Fernandez Mancera wrote:
> While working on a different IPv6 patch series I have spotted multiple
> minor bugs around sysctl error handling and notifications. In general,
> they are not serious issues.
> 
> In addition, there is one more issue in forwarding sysctl as it does not
> check for CAP_NET_ADMIN for the namespace. I am keeping that patch out
> of this series and I am aiming it at the net-next tree once it re-opens.
> 
> Fernando Fernandez Mancera (6):
>    ipv6: fix error handling in disable_ipv6 sysctl
>    ipv6: fix error handling in ignore_routes_with_linkdown sysctl
>    ipv6: fix error handling in forwarding sysctl
>    ipv6: fix error handling in disable_policy sysctl
>    ipv6: reset value and position for proxy_ndp sysctl restart
>    ipv6: fix missing notification for ignore_routes_with_linkdown
> 
>   net/ipv6/addrconf.c | 35 +++++++++++++++++++++++++++--------
>   1 file changed, 27 insertions(+), 8 deletions(-)
> 

So I have checked the feedback from sashiko.dev [1]. In general, it is 
real but I have doubts about this one. While it is real, I am not so 
sure we actually care about this scenario. In any case, this is a 
pattern around kernel code and it would require fixes everywhere 
(IPv4/IPv6/other places (?)).

The easier thing to do is what Nicolas suggested about taking the lock 
before parsing the value i.e before calling proc_dointvec().

I also do wonder if I should fix them in individual commits or together 
in the same commit as they have different fixes tag. Or maybe we can aim 
this last part to net-next. Thoughts?

Please, see the feedback attached below.

Thanks!

[1] https://sashiko.dev/#/patchset/20260618162225.4588-1-fmancera%40suse.de

 > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
 > index 8ff015975e279..1cfb223476bd6 100644
 > --- a/net/ipv6/addrconf.c
 > +++ b/net/ipv6/addrconf.c
[ ... ]
 > @@ -6493,8 +6494,12 @@ static int addrconf_sysctl_proxy_ndp(const 
struct ctl_table *ctl, int write,
 >  	if (write && old != new) {
 >  		struct net *net = ctl->extra2;
 >
 > -		if (!rtnl_net_trylock(net))
 > +		if (!rtnl_net_trylock(net)) {
 > +			/* Restore the original values before restarting */
 > +			*valp = old;
 > +			*ppos = pos;
 >  			return restart_syscall();
 > +		}
 >

Does this rollback introduce a race condition that can silently discard
concurrent writes?
The sysctl core does not serialize concurrent writes to the same sysctl
parameter, and proc_dointvec() modifies the global sysctl memory pointed to
by ctl->data directly.
If Thread A and Thread B concurrently write to proxy_ndp, and Thread A fails
to acquire the RTNL lock, setting *valp = old will unconditionally reset the
global memory back to what Thread A observed before its write. This seems
like it would clobber Thread B's concurrent update.
If Thread B successfully acquires the RTNL lock, it will evaluate its local
old != new stack variables as true and emit a RTM_NEWNETCONF netlink
notification. However, the notification will read the corrupted *valp 
memory,
leaving the emitted event and internal sysctl state out of sync.
Could this be avoided by duplicating the ctl_table, pointing the data field
to a local stack variable, calling proc_dointvec() on the local variable,
and only updating the global *valp after successfully acquiring the lock,
similar to how it is handled in addrconf_sysctl_forward()?

