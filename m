Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838439C016
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953950; cv=none; b=uCZ1wdp+A7vVnYod6FFpwsm3c3d8r4LiR3dgycsQ2VCpQMy75DnYbOW7k/L3CKkHYS32dNqbZzBYHQzpmilcuvMD0qqnhHJ8UNIH6S1WBUeMO9ASoi3RjCWjUOdcqXn2sJ5A+KUcPf+x20fdOX/Q74+eg9SPT+aP7y5u9Dq7koo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953950; c=relaxed/simple;
	bh=GgAs6d1wJh4v61uUWB9nDqkx8eg0iTnYcCY7cB27CSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNVcsU3z1ij+Yf50ZdnegBb7zG500HqPpgVF/GSoNyAq9lrvnQNW7sRelz5eXVNmojrVtRzZ67pZlzmCyEJn1vzAetSwF6mitIyW0/spVQXGZsoTjfOQGc+mqiXPojkChHKfesdXoiVDpzi3MLvgk77HAWgmCH5Csubif1wMzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qHiUMEdz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Em4Sozl/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qHiUMEdz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Em4Sozl/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qHiUMEdz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Em4Sozl/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qHiUMEdz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Em4Sozl/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 713AE4D1ED;
	Tue, 31 Mar 2026 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774953947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOr7Ds+Huq/QkpWFkAuHSfaNqsyJAvJgRTnYAnKDE0A=;
	b=qHiUMEdzh4g41REizhaOZHMVuTQlM8ujqczYqm3oNbldVv1Nk+7mez+QLeWNtu5/2KR9dX
	MpibkcrhjCSbHqhdcp6hTevlnamholKvKDPzOaSYjAma0rZ7Xl0/DspzXcsJK4IQPmecNk
	y8h4tk5ioCNBjM8HnRZV+RtCIKId1Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774953947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOr7Ds+Huq/QkpWFkAuHSfaNqsyJAvJgRTnYAnKDE0A=;
	b=Em4Sozl/Pvc6DTdQ8+flKmRTz2WhWsJvambL4S7PSlCkTU3K9yInI+uwxGiUkzxRqYO8sc
	txgRMO2zkJriXuDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qHiUMEdz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Em4Sozl/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774953947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOr7Ds+Huq/QkpWFkAuHSfaNqsyJAvJgRTnYAnKDE0A=;
	b=qHiUMEdzh4g41REizhaOZHMVuTQlM8ujqczYqm3oNbldVv1Nk+7mez+QLeWNtu5/2KR9dX
	MpibkcrhjCSbHqhdcp6hTevlnamholKvKDPzOaSYjAma0rZ7Xl0/DspzXcsJK4IQPmecNk
	y8h4tk5ioCNBjM8HnRZV+RtCIKId1Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774953947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOr7Ds+Huq/QkpWFkAuHSfaNqsyJAvJgRTnYAnKDE0A=;
	b=Em4Sozl/Pvc6DTdQ8+flKmRTz2WhWsJvambL4S7PSlCkTU3K9yInI+uwxGiUkzxRqYO8sc
	txgRMO2zkJriXuDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 019EC4A0A2;
	Tue, 31 Mar 2026 10:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 45zYONqly2kCLQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 31 Mar 2026 10:45:46 +0000
Message-ID: <e56d71a6-54e3-47d0-8d00-47db1b6fecd6@suse.de>
Date: Tue, 31 Mar 2026 12:45:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next v2] ipv4: handle devconf post-set actions on
 netlink updates
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: horms@kernel.org, kuba@kernel.org, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net
References: <20260327120202.4761-1-fmancera@suse.de>
 <20260327120202.4761-2-fmancera@suse.de>
 <b3997b77-d76b-4297-bc67-a2c57c7da601@redhat.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <b3997b77-d76b-4297-bc67-a2c57c7da601@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 713AE4D1ED

On 3/31/26 12:36 PM, Paolo Abeni wrote:
> On 3/27/26 1:02 PM, Fernando Fernandez Mancera wrote:
>> When IPv4 device configuration parameters are updated via netlink, the
>> kernel currently only updates the value. This bypasses several
>> post-modification actions that occur when these same parameters are
>> updated via sysctl, such as flushing the routing cache or emitting
>> RTM_NEWNETCONF notifications.
>>
>> This patch addresses the inconsistency by calling the
>> devinet_conf_post_set() helper inside inet_set_link_af(). If a flush is
>> required, we defer it until the netlink attribute parsing loop
>> completes.
> 
> IMHO the above deserve some additional self-test triggering the relevant
> code.
> 

Hi Paolo,

sure, I could include a selftest for this.

>> This ensures consistent behavior and side-effects for devconf changes,
>> regardless of whether they are initiated via sysctl or netlink.
>>
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>> v2: handled forwarding notification and disabling LRO
>> ---
>>   net/ipv4/devinet.c | 29 +++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
>> index 8300516fb38f..a35b72662e43 100644
>> --- a/net/ipv4/devinet.c
>> +++ b/net/ipv4/devinet.c
>> @@ -2161,6 +2161,20 @@ static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
>>   					    NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
>>   					    ifindex, cnf);
>>   		break;
>> +	case IPV4_DEVCONF_FORWARDING:
>> +		if (new == 1) {
> 
> AI reviews says:
> 
> Does this check miss cases where forwarding is enabled with a value other
> than 1?
> The sysctl path allows enabling IP forwarding with any non-zero value. If
> a user sets IPV4_DEVCONF_FORWARDING to 2 via netlink, forwarding will be
> enabled but this check is bypassed, leaving Large Receive Offload (LRO)
> enabled. Could this cause LRO-coalesced packets to be forwarded without
> proper software segmentation?
> 

If a user sets IPV4_DEVCONF_FORWARDING to 2 via netlink the value would 
be rejected. There is netlink attribute validation and FORWARDING is set 
as boolean with the range [0, 1].

This cannot happen.

>> +			/* it is safe to use container_of() because forwarding case
>> +			 * is only used by the netlink path
>> +			 */
>> +			struct in_device *idev = container_of(cnf, struct in_device, cnf);
>> +
>> +			netif_disable_lro(idev->dev);
> 
> AI review says:
> 
> Is it safe to call netif_disable_lro() here without holding the device
> operations lock?
> While inet_set_link_af() runs under rtnl_lock(), netif_disable_lro()
> modifies device features and calls netdev_update_features(), which
> asserts that the device operations lock is held. Calling this without
> the lock might trigger an assertion or expose the device to data races
> with concurrent feature updates or BPF/XDP attachments.
> Should this use dev_disable_lro() instead, which acquires the required
> lock before disabling LRO?

It is not possible to call this without the holding the lock. The device 
operations lock is held when handling IFLA_AF_SPEC at 
net/core/rtnetlink.c. Calling netif_disable_lro() is the right thing to 
do IMHO. Keep on mind that FORWARDING case here is only triggered by 
netlink path and not sysctl.

Thanks,
Fernando.

> 
> /P
> 

