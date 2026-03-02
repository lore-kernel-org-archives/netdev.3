Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43C2FE066
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440518; cv=none; b=Rt1i1JlL6+Iz1dsDuq1kyfsMJSW9d+8Ay1y7/tXBR26tR5q81ikiWS8GUc/PzfEOSSZE9WghTfCKSneENrKUOShPCbLaGBGc72xs1dvDOaZip/kUwKP4fO/Gmo+olarUHZMKADIL9EmAckAap/ijBINkh4Uje5YBZVg5QzYt1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440518; c=relaxed/simple;
	bh=zqsCZaRLgS9//bID8YrlJlZYDny6laW422OiUAAup8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caQTmzMR6sOTRpfig6BGj3vgC7RHbw4sieL5qp8Jqtr2TbAt+tYY1ek4HSMUjh8RxNJAIccrFIefb5+8NvHlSV6GweR7IwxLTdJaZs3cspdaYaVh3tJiFTSYNM+7+wOioUigkfIYMOOSUO/CkaCA6RuIGmYe16wnwGaW9INZzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wwBaRn5/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R5dYHHKi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wwBaRn5/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R5dYHHKi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wwBaRn5/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R5dYHHKi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wwBaRn5/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R5dYHHKi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 270563E70E;
	Mon,  2 Mar 2026 08:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772440515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPgcW5neywpnPIlzr1xLjRYZg3aq2nGoODPhlVmZfk8=;
	b=wwBaRn5/l19AKf3dtPx8aXy35cbAqE16k2MHxN4kP7KCZTQiut2mnEcPHPUanWOZISF8b/
	TnaOpoPZ3FvAOeSMc+uVFHQX2ylOvKbm/T6R+BH+XtuEkodNEuzq8ILVLbHNBNXxOO6sUK
	3G92gLPEh9NgihkKJRUICC6de21qmoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772440515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPgcW5neywpnPIlzr1xLjRYZg3aq2nGoODPhlVmZfk8=;
	b=R5dYHHKiT0n9wP5UoghkX7LVnzuZQSkKQMDd9hdDu1uTz+C37nj3iuRMKdFnbjoSHSwBcw
	hkG54yj5jSiTmDBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772440515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPgcW5neywpnPIlzr1xLjRYZg3aq2nGoODPhlVmZfk8=;
	b=wwBaRn5/l19AKf3dtPx8aXy35cbAqE16k2MHxN4kP7KCZTQiut2mnEcPHPUanWOZISF8b/
	TnaOpoPZ3FvAOeSMc+uVFHQX2ylOvKbm/T6R+BH+XtuEkodNEuzq8ILVLbHNBNXxOO6sUK
	3G92gLPEh9NgihkKJRUICC6de21qmoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772440515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPgcW5neywpnPIlzr1xLjRYZg3aq2nGoODPhlVmZfk8=;
	b=R5dYHHKiT0n9wP5UoghkX7LVnzuZQSkKQMDd9hdDu1uTz+C37nj3iuRMKdFnbjoSHSwBcw
	hkG54yj5jSiTmDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8A4A3EA69;
	Mon,  2 Mar 2026 08:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5GpEJsJLpWmwOQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 02 Mar 2026 08:35:14 +0000
Message-ID: <a038563b-05f2-4e11-9cd4-ad6374d379aa@suse.de>
Date: Mon, 2 Mar 2026 09:35:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net-next v2] ipv4: validate IPV4_DEVCONF attributes
 properly
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
References: <20260226133949.17070-1-fmancera@suse.de>
 <20260228104328.260172d2@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260228104328.260172d2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO

On 2/28/26 7:43 PM, Jakub Kicinski wrote:
> On Thu, 26 Feb 2026 14:39:48 +0100 Fernando Fernandez Mancera wrote:
>> As the IPV4_DEVCONF netlink attributes are not being validated, it is
>> possible to use netlink to set read-only values like mc_forwarding. In
>> addition, valid ranges are not being validated neither but that is less
>> relevant as they aren't in sysctl.
>>
>> To avoid similar situations in the future, define a NLA policy for
>> IPV4_DEVCONF attributes which are nested in IFLA_INET_CONF.
> 
> Very nice, I think we should drop the Fixes tag tho.
> Adding missed validation is always tricky, we don't really want people
> to backport this to stable releases, the risk of regression (of broken
> user space) is too high. Unless there's some crash this prevents, in
> which case we'd need a more targeted fix for just those values in net.
> 
>> Please note that MEDIUM_ID is defined as NLA_U32 too because currently
>> its usage through netlink is broken for its valid value -1. Modifying
>> the type to NLA_S32 would break existing users of set/get netlink
>> operation.
> 
> Say more? The policy type not matching the accessor used by the kernel
> is probably fine in this case (since there's a common accessor used for
> all attrs). If it helps the policy, we can use a different type.
> 

The problem is not only not matching the accessor.. the problem is that 
while it was not validated if users were using NLA_U32 as indicated by 
the original implementation (see blamed commit), this would break them.

Is it one option to set the type to NLA_S32 and wait to see if someone 
complains? I am not sure how many people might be using it considering 
the type is wrong.

Thanks,
Fernando.

>> +static const struct nla_policy inet_devconf_policy[IPV4_DEVCONF_MAX + 1] = {
>> +	[IPV4_DEVCONF_FORWARDING]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_MC_FORWARDING]			  = { .type = NLA_REJECT },
>> +	[IPV4_DEVCONF_PROXY_ARP]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_ACCEPT_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_SECURE_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_SEND_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_SHARED_MEDIA]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_RP_FILTER]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 2),
>> +	[IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE]		  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_BOOTP_RELAY]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_LOG_MARTIANS]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_TAG]				  = { .type = NLA_U32 },
>> +	[IPV4_DEVCONF_ARPFILTER]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_MEDIUM_ID]			  = { .type = NLA_U32 },
>> +	[IPV4_DEVCONF_NOXFRM]				  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_NOPOLICY]				  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_FORCE_IGMP_VERSION]		  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 3),
>> +	[IPV4_DEVCONF_ARP_ANNOUNCE]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 2),
>> +	[IPV4_DEVCONF_ARP_IGNORE]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 8),
>> +	[IPV4_DEVCONF_PROMOTE_SECONDARIES]		  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_ARP_ACCEPT]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_ARP_NOTIFY]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_ACCEPT_LOCAL]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_SRC_VMARK]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_PROXY_ARP_PVLAN]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_ROUTE_LOCALNET]			  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
>> +	[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL] = { .type = NLA_U32 },
>> +	[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL] = { .type = NLA_U32 },
>> +	[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN]	  = NLA_POLICY_RANGE(NLA_U32,
>> +									     0, 1),
> 
> The indentation is rather awkward, please adjust to fit the common case
> on one line and special case the long ones.
> 
> 	// mis-adjust when needed
> 	[IPV4_DEVCONF_PROMOTE_SECONDARIES] = NLA_POLICY_RANGE(NLA_U32, 0, 1),
> 	// common / normal case
> 	[IPV4_DEVCONF_ARP_ACCEPT]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
> 	[IPV4_DEVCONF_ARP_NOTIFY]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
> 	[IPV4_DEVCONF_ACCEPT_LOCAL]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
> 	...
> 	// overflow type fully to next line if doesn't fit even mis-adjusted
> 	[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL] =
> 		{ .type = NLA_U32 },
> 	[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL] =
> 		{ .type = NLA_U32 },
> 	[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN] =
> 		NLA_POLICY_RANGE(NLA_U32, 0, 1),

Thanks for the suggestion!
