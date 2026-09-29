Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE33BB100;
	Tue, 29 Sep 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670087; cv=none; b=cahI1QeSfpFFH8vDQTbUfDSgCVggJoO4wYBTeuK25FKmN1WP3XmZp0mzYnJ+oBo4uUVtAhE9YSssTvPcKJW+ZRNTj+eO/78CjTDgcnvp6fhvosTAaBqDaeRLGU9HuDAq9+yaNz2Us0k6JmYh3HWElddw73X9G9ax6g86BcNrzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670087; c=relaxed/simple;
	bh=tsNi91vKlhYDlsbL6Ugg0qFw2igZef3Z6JYRD8oRWAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JG9XUMGzOkesWlotgwcttlxeSdnSQw9nv73J3P/R4yXhiQDaAFx6YM+ZykuJo0yK3MN4lgl+M4ae5bqzP04/nyVIZlud5skplynN0JO6D4sgzOwyFgkTHeQ2k68uODo8t5oyL4XsD5kBHdanv+0n3sUFc1gCZNB/m5M+QUAm3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=simAiXG9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iGEpZFhi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pp5Q9I/U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=014etUHY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="simAiXG9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iGEpZFhi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pp5Q9I/U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="014etUHY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0D821F7B1;
	Tue, 29 Sep 2026 08:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790670076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ze4dRe5kebYmxs7Gcd2E/t3UK7Z2MpBLPtgJWt59l+s=;
	b=simAiXG9IsLL+O1IyHMfju3iugATKQ25lKSGyYcmvxCoF+wS7joD2pwhAr8SgKvsT+5eTR
	7NB5TsUpTq2YoWDzVj/IDweehhRiNXZRDFOevWg15XYR165pTYWtfqD9iGW7tEUU6RkZAh
	XsovVo+zMT5AHMrZh32PwnoAxQEFRwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790670076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ze4dRe5kebYmxs7Gcd2E/t3UK7Z2MpBLPtgJWt59l+s=;
	b=iGEpZFhiFfd6oQu63FrHmWdTGDg2Q/4bVuLEgAWs+n34NJGfb2nwqMrVGZROKq7xH1f/TB
	QskVTePTMKc/upAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Pp5Q9I/U";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=014etUHY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790670071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ze4dRe5kebYmxs7Gcd2E/t3UK7Z2MpBLPtgJWt59l+s=;
	b=Pp5Q9I/UYUdwxXaj2gVhO8jyFgI3QNYVS6G0RfF1PuCDW6VhTEaGUG8EgZK5YulBzSiPrn
	SY3FE/LtisFAMYMIQhQvptEXTAo5lB0Y6riCXJUI//DaaQVvlMjvHQXtAFWhs6BJUVDNvW
	6GXkIW04gLd6NTTd0tJ8tXEemZBMSqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790670071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ze4dRe5kebYmxs7Gcd2E/t3UK7Z2MpBLPtgJWt59l+s=;
	b=014etUHYN2pFXOWygbKwPVER0wGy265Ze8qT3gBYHwtr+1tM4MV3czur/JSVYwO+2lQ7UC
	FpwusayF+F9Jc0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AFB2136E4;
	Tue, 29 Sep 2026 08:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id raxsNvZ0u2qtSAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 29 Sep 2026 08:21:11 +0000
Message-ID: <5cdbc432-7d7e-47f7-897d-2b71a1a4a7a4@suse.de>
Date: Tue, 29 Sep 2026 10:20:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16 net-next v2] ipv4: disable IPv4-only sysctls when
 CONFIG_IPV4=n
To: Joel Granados <joel.granados@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su
 <yuuchihsu@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20260928193046.6698-1-fmancera@suse.de>
 <20260928193046.6698-12-fmancera@suse.de>
 <merysy6sadsrrmkiswnxlaohuftbvtaslbqhdhg5o57a7fxnkd@fkjcxi2cv2zs>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <merysy6sadsrrmkiswnxlaohuftbvtaslbqhdhg5o57a7fxnkd@fkjcxi2cv2zs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,davemloft.net,google.com,nokia-bell-labs.com,icloud.com,gmail.com,nvidia.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F0D821F7B1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 9/29/26 9:14 AM, Joel Granados wrote:
> On Mon, Sep 28, 2026 at 09:30:07PM +0200, Fernando Fernandez Mancera wrote:
>> To avoid noise and unexpected problems, let's hide all the sysctls that
>> are related to IPv4 only when the kernel is compiled without IPv4
>> support.
> 
> You are hiding the IPV4 sysctl with "#if IS_ENABLED(CONFIG_IPV4)" inside
> the sysctl_net_ipv4.c file. That is confusing as I would expect all
> sysctl_net_ipv4.c to be ipv4 specific. Wouldn't it be cleaner to just
> have an "ipv4" sysctl file and compile that when CONFIG_IPV4 is enabled?
> 
> I might be missing something obvious as I just got to see 3 patches of
> the series. Ignore, if this is addressed at some other point.
> 

Unfortunately, under net.ipv4.* sysctls there are plenty of them that 
are not exclusively related to IPv4. For example tcp_* or udp_* ones. 
These cannot be moved out of there because it would break plenty of 
systems.  I think it is good to have them all at sysctl_net_ipv4.c and 
guard them with ifdefs..

Technically, nothing prevent us to split the generic ones to net/ipv4 
sysctl_net.c or similar.

Thanks,
Fernando.

> Best
> 
>>
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   net/ipv4/sysctl_net_ipv4.c | 407 +++++++++++++++++++------------------
>>   1 file changed, 205 insertions(+), 202 deletions(-)
>>
>> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
>> index 0e7fef5973db..6096e9e4d82d 100644
>> --- a/net/ipv4/sysctl_net_ipv4.c
>> +++ b/net/ipv4/sysctl_net_ipv4.c
>> @@ -31,8 +31,8 @@ static int tcp_min_snd_mss_max = 65535;
>>   static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
>>   static int ip_privileged_port_min;
>>   static int ip_privileged_port_max = 65535;
>> -static int ip_ttl_min = 1;
>> -static int ip_ttl_max = 255;
>> +static int ip_ttl_min __maybe_unused = 1;
>> +static int ip_ttl_max __maybe_unused = 255;
>>   static int tcp_syn_retries_min = 1;
>>   static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
>>   static int tcp_syn_linear_timeouts_max = MAX_TCP_SYNCNT;
>> @@ -48,7 +48,7 @@ static int tcp_plb_max_rounds = 31;
>>   static int tcp_plb_max_cong_thresh = 256;
>>   static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
>>   static int tcp_ecn_mode_max = 5;
>> -static u32 icmp_errors_extension_mask_all =
>> +static u32 icmp_errors_extension_mask_all __maybe_unused =
>>   	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
>>   
>>   static int tcp_min_rcvbuf = 4096;
>> @@ -201,8 +201,9 @@ static int ipv4_ping_group_range(const struct ctl_table *table, int write,
>>   	return ret;
>>   }
>>   
>> -static int ipv4_fwd_update_priority(const struct ctl_table *table, int write,
>> -				    void *buffer, size_t *lenp, loff_t *ppos)
>> +static int __maybe_unused
>> +ipv4_fwd_update_priority(const struct ctl_table *table, int write,
>> +			 void *buffer, size_t *lenp, loff_t *ppos)
>>   {
>>   	struct net *net;
>>   	int ret;
>> @@ -441,9 +442,9 @@ static int proc_udp_hash_entries(const struct ctl_table *table, int write,
>>   }
>>   
>>   #ifdef CONFIG_IP_ROUTE_MULTIPATH
>> -static int proc_fib_multipath_hash_policy(const struct ctl_table *table, int write,
>> -					  void *buffer, size_t *lenp,
>> -					  loff_t *ppos)
>> +static int __maybe_unused
>> +proc_fib_multipath_hash_policy(const struct ctl_table *table, int write,
>> +			       void *buffer, size_t *lenp, loff_t *ppos)
>>   {
>>   	struct net *net = container_of(table->data, struct net,
>>   	    ipv4.sysctl_fib_multipath_hash_policy);
>> @@ -456,9 +457,9 @@ static int proc_fib_multipath_hash_policy(const struct ctl_table *table, int wri
>>   	return ret;
>>   }
>>   
>> -static int proc_fib_multipath_hash_fields(const struct ctl_table *table, int write,
>> -					  void *buffer, size_t *lenp,
>> -					  loff_t *ppos)
>> +static int __maybe_unused
>> +proc_fib_multipath_hash_fields(const struct ctl_table *table, int write,
>> +			       void *buffer, size_t *lenp, loff_t *ppos)
>>   {
>>   	struct net *net;
>>   	int ret;
>> @@ -492,9 +493,9 @@ static void proc_fib_multipath_hash_set_seed(struct net *net, u32 user_seed)
>>   	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed, new.mp_seed);
>>   }
>>   
>> -static int proc_fib_multipath_hash_seed(const struct ctl_table *table, int write,
>> -					void *buffer, size_t *lenp,
>> -					loff_t *ppos)
>> +static int __maybe_unused
>> +proc_fib_multipath_hash_seed(const struct ctl_table *table, int write,
>> +			     void *buffer, size_t *lenp, loff_t *ppos)
>>   {
>>   	struct sysctl_fib_multipath_hash_seed *mphs;
>>   	struct net *net = table->data;
>> @@ -636,15 +637,6 @@ static const struct ctl_table ipv4_net_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= proc_dointvec
>>   	},
>> -	{
>> -		.procname	= "icmp_echo_ignore_all",
>> -		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_all,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= SYSCTL_ONE
>> -	},
>>   	{
>>   		.procname	= "icmp_echo_enable_probe",
>>   		.data		= &init_net.ipv4.sysctl_icmp_echo_enable_probe,
>> @@ -654,56 +646,6 @@ static const struct ctl_table ipv4_net_table[] = {
>>   		.extra1		= SYSCTL_ZERO,
>>   		.extra2		= SYSCTL_ONE
>>   	},
>> -	{
>> -		.procname	= "icmp_echo_ignore_broadcasts",
>> -		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_broadcasts,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= SYSCTL_ONE
>> -	},
>> -	{
>> -		.procname	= "icmp_ignore_bogus_error_responses",
>> -		.data		= &init_net.ipv4.sysctl_icmp_ignore_bogus_error_responses,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= SYSCTL_ONE
>> -	},
>> -	{
>> -		.procname	= "icmp_errors_use_inbound_ifaddr",
>> -		.data		= &init_net.ipv4.sysctl_icmp_errors_use_inbound_ifaddr,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= SYSCTL_ONE
>> -	},
>> -	{
>> -		.procname	= "icmp_errors_extension_mask",
>> -		.data		= &init_net.ipv4.sysctl_icmp_errors_extension_mask,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &icmp_errors_extension_mask_all,
>> -	},
>> -	{
>> -		.procname	= "icmp_ratelimit",
>> -		.data		= &init_net.ipv4.sysctl_icmp_ratelimit,
>> -		.maxlen		= sizeof(int),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec_ms_jiffies,
>> -	},
>> -	{
>> -		.procname	= "icmp_ratemask",
>> -		.data		= &init_net.ipv4.sysctl_icmp_ratemask,
>> -		.maxlen		= sizeof(int),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec
>> -	},
>>   	{
>>   		.procname	= "icmp_msgs_per_sec",
>>   		.data		= &init_net.ipv4.sysctl_icmp_msgs_per_sec,
>> @@ -774,13 +716,6 @@ static const struct ctl_table ipv4_net_table[] = {
>>   		.extra1		= SYSCTL_ZERO,
>>   		.extra2		= SYSCTL_ONE,
>>   	},
>> -	{
>> -		.procname	= "ip_dynaddr",
>> -		.data		= &init_net.ipv4.sysctl_ip_dynaddr,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -	},
>>   	{
>>   		.procname	= "ip_early_demux",
>>   		.data		= &init_net.ipv4.sysctl_ip_early_demux,
>> @@ -811,15 +746,6 @@ static const struct ctl_table ipv4_net_table[] = {
>>   		.extra1		= SYSCTL_ZERO,
>>   		.extra2		= SYSCTL_ONE,
>>   	},
>> -	{
>> -		.procname	= "ip_default_ttl",
>> -		.data		= &init_net.ipv4.sysctl_ip_default_ttl,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -		.extra1		= &ip_ttl_min,
>> -		.extra2		= &ip_ttl_max,
>> -	},
>>   	{
>>   		.procname	= "ip_local_port_range",
>>   		.maxlen		= 0,
>> @@ -841,36 +767,6 @@ static const struct ctl_table ipv4_net_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= proc_do_large_bitmap,
>>   	},
>> -	{
>> -		.procname	= "ip_no_pmtu_disc",
>> -		.data		= &init_net.ipv4.sysctl_ip_no_pmtu_disc,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -	},
>> -	{
>> -		.procname	= "ip_forward_use_pmtu",
>> -		.data		= &init_net.ipv4.sysctl_ip_fwd_use_pmtu,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -	},
>> -	{
>> -		.procname	= "ip_forward_update_priority",
>> -		.data		= &init_net.ipv4.sysctl_ip_fwd_update_priority,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler   = ipv4_fwd_update_priority,
>> -		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= SYSCTL_ONE,
>> -	},
>> -	{
>> -		.procname	= "ip_nonlocal_bind",
>> -		.data		= &init_net.ipv4.sysctl_ip_nonlocal_bind,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -	},
>>   	{
>>   		.procname	= "ip_autobind_reuse",
>>   		.data		= &init_net.ipv4.sysctl_ip_autobind_reuse,
>> @@ -880,13 +776,6 @@ static const struct ctl_table ipv4_net_table[] = {
>>   		.extra1         = SYSCTL_ZERO,
>>   		.extra2         = SYSCTL_ONE,
>>   	},
>> -	{
>> -		.procname	= "fwmark_reflect",
>> -		.data		= &init_net.ipv4.sysctl_fwmark_reflect,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -	},
>>   	{
>>   		.procname	= "tcp_fwmark_accept",
>>   		.data		= &init_net.ipv4.sysctl_tcp_fwmark_accept,
>> @@ -952,37 +841,6 @@ static const struct ctl_table ipv4_net_table[] = {
>>   		.proc_handler	= proc_douintvec_minmax,
>>   		.extra2		= &u32_max_div_HZ,
>>   	},
>> -	{
>> -		.procname	= "igmp_link_local_mcast_reports",
>> -		.data		= &init_net.ipv4.sysctl_igmp_llm_reports,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -	},
>> -	{
>> -		.procname	= "igmp_max_memberships",
>> -		.data		= &init_net.ipv4.sysctl_igmp_max_memberships,
>> -		.maxlen		= sizeof(int),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec
>> -	},
>> -	{
>> -		.procname	= "igmp_max_msf",
>> -		.data		= &init_net.ipv4.sysctl_igmp_max_msf,
>> -		.maxlen		= sizeof(int),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec
>> -	},
>> -#ifdef CONFIG_IP_MULTICAST
>> -	{
>> -		.procname	= "igmp_qrv",
>> -		.data		= &init_net.ipv4.sysctl_igmp_qrv,
>> -		.maxlen		= sizeof(int),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec_minmax,
>> -		.extra1		= SYSCTL_ONE
>> -	},
>> -#endif
>>   	{
>>   		.procname	= "tcp_congestion_control",
>>   		.data		= &init_net.ipv4.tcp_congestion_control,
>> @@ -1154,42 +1012,6 @@ static const struct ctl_table ipv4_net_table[] = {
>>   		.proc_handler	= proc_tfo_blackhole_detect_timeout,
>>   		.extra1		= SYSCTL_ZERO,
>>   	},
>> -#ifdef CONFIG_IP_ROUTE_MULTIPATH
>> -	{
>> -		.procname	= "fib_multipath_use_neigh",
>> -		.data		= &init_net.ipv4.sysctl_fib_multipath_use_neigh,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= SYSCTL_ONE,
>> -	},
>> -	{
>> -		.procname	= "fib_multipath_hash_policy",
>> -		.data		= &init_net.ipv4.sysctl_fib_multipath_hash_policy,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_fib_multipath_hash_policy,
>> -		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= SYSCTL_THREE,
>> -	},
>> -	{
>> -		.procname	= "fib_multipath_hash_fields",
>> -		.data		= &init_net.ipv4.sysctl_fib_multipath_hash_fields,
>> -		.maxlen		= sizeof(u32),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_fib_multipath_hash_fields,
>> -		.extra1		= SYSCTL_ONE,
>> -		.extra2		= &fib_multipath_hash_fields_all_mask,
>> -	},
>> -	{
>> -		.procname	= "fib_multipath_hash_seed",
>> -		.data		= &init_net,
>> -		.maxlen		= sizeof(u32),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_fib_multipath_hash_seed,
>> -	},
>> -#endif
>>   	{
>>   		.procname	= "ip_unprivileged_port_start",
>>   		.maxlen		= sizeof(int),
>> @@ -1563,15 +1385,6 @@ static const struct ctl_table ipv4_net_table[] = {
>>   		.proc_handler	= proc_dointvec_minmax,
>>   		.extra1		= SYSCTL_ONE
>>   	},
>> -	{
>> -		.procname	= "fib_notify_on_flag_change",
>> -		.data		= &init_net.ipv4.sysctl_fib_notify_on_flag_change,
>> -		.maxlen		= sizeof(u8),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dou8vec_minmax,
>> -		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= SYSCTL_TWO,
>> -	},
>>   	{
>>   		.procname       = "tcp_plb_enabled",
>>   		.data           = &init_net.ipv4.sysctl_tcp_plb_enabled,
>> @@ -1656,6 +1469,196 @@ static const struct ctl_table ipv4_net_table[] = {
>>   		.extra1		= SYSCTL_ONE_THOUSAND,
>>   		.extra2		= &tcp_rto_max_max,
>>   	},
>> +#if IS_ENABLED(CONFIG_IPV4)
>> +	{
>> +		.procname	= "icmp_echo_ignore_all",
>> +		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_all,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE
>> +	},
>> +	{
>> +		.procname	= "icmp_echo_ignore_broadcasts",
>> +		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_broadcasts,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE
>> +	},
>> +	{
>> +		.procname	= "icmp_ignore_bogus_error_responses",
>> +		.data		= &init_net.ipv4.sysctl_icmp_ignore_bogus_error_responses,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE
>> +	},
>> +	{
>> +		.procname	= "icmp_errors_use_inbound_ifaddr",
>> +		.data		= &init_net.ipv4.sysctl_icmp_errors_use_inbound_ifaddr,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE
>> +	},
>> +	{
>> +		.procname	= "icmp_errors_extension_mask",
>> +		.data		= &init_net.ipv4.sysctl_icmp_errors_extension_mask,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= &icmp_errors_extension_mask_all,
>> +	},
>> +	{
>> +		.procname	= "icmp_ratelimit",
>> +		.data		= &init_net.ipv4.sysctl_icmp_ratelimit,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_ms_jiffies,
>> +	},
>> +	{
>> +		.procname	= "icmp_ratemask",
>> +		.data		= &init_net.ipv4.sysctl_icmp_ratemask,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec
>> +	},
>> +	{
>> +		.procname	= "ip_dynaddr",
>> +		.data		= &init_net.ipv4.sysctl_ip_dynaddr,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +	},
>> +	{
>> +		.procname	= "ip_default_ttl",
>> +		.data		= &init_net.ipv4.sysctl_ip_default_ttl,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +		.extra1		= &ip_ttl_min,
>> +		.extra2		= &ip_ttl_max,
>> +	},
>> +	{
>> +		.procname	= "ip_no_pmtu_disc",
>> +		.data		= &init_net.ipv4.sysctl_ip_no_pmtu_disc,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +	},
>> +	{
>> +		.procname	= "ip_forward_use_pmtu",
>> +		.data		= &init_net.ipv4.sysctl_ip_fwd_use_pmtu,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +	},
>> +	{
>> +		.procname	= "ip_forward_update_priority",
>> +		.data		= &init_net.ipv4.sysctl_ip_fwd_update_priority,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler   = ipv4_fwd_update_priority,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE,
>> +	},
>> +	{
>> +		.procname	= "ip_nonlocal_bind",
>> +		.data		= &init_net.ipv4.sysctl_ip_nonlocal_bind,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +	},
>> +	{
>> +		.procname	= "fwmark_reflect",
>> +		.data		= &init_net.ipv4.sysctl_fwmark_reflect,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +	},
>> +	{
>> +		.procname	= "igmp_link_local_mcast_reports",
>> +		.data		= &init_net.ipv4.sysctl_igmp_llm_reports,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +	},
>> +	{
>> +		.procname	= "igmp_max_memberships",
>> +		.data		= &init_net.ipv4.sysctl_igmp_max_memberships,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec
>> +	},
>> +	{
>> +		.procname	= "igmp_max_msf",
>> +		.data		= &init_net.ipv4.sysctl_igmp_max_msf,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec
>> +	},
>> +#ifdef CONFIG_IP_MULTICAST
>> +	{
>> +		.procname	= "igmp_qrv",
>> +		.data		= &init_net.ipv4.sysctl_igmp_qrv,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ONE
>> +	},
>> +#endif
>> +#ifdef CONFIG_IP_ROUTE_MULTIPATH
>> +	{
>> +		.procname	= "fib_multipath_use_neigh",
>> +		.data		= &init_net.ipv4.sysctl_fib_multipath_use_neigh,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE,
>> +	},
>> +	{
>> +		.procname	= "fib_multipath_hash_policy",
>> +		.data		= &init_net.ipv4.sysctl_fib_multipath_hash_policy,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_fib_multipath_hash_policy,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_THREE,
>> +	},
>> +	{
>> +		.procname	= "fib_multipath_hash_fields",
>> +		.data		= &init_net.ipv4.sysctl_fib_multipath_hash_fields,
>> +		.maxlen		= sizeof(u32),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_fib_multipath_hash_fields,
>> +		.extra1		= SYSCTL_ONE,
>> +		.extra2		= &fib_multipath_hash_fields_all_mask,
>> +	},
>> +	{
>> +		.procname	= "fib_multipath_hash_seed",
>> +		.data		= &init_net,
>> +		.maxlen		= sizeof(u32),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_fib_multipath_hash_seed,
>> +	},
>> +#endif
>> +	{
>> +		.procname	= "fib_notify_on_flag_change",
>> +		.data		= &init_net.ipv4.sysctl_fib_notify_on_flag_change,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_TWO,
>> +	},
>> +#endif
>>   };
>>   
>>   static const struct ctl_table *ipv4_net_table_dup(struct net *net)
>> -- 
>> 2.55.0
>>

