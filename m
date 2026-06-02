Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3A175A7C
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429593; cv=none; b=i/eUJWUR0BPA6ZKesv6rOI0fZDCMmmSb8MLH1o9uXEU9NMpfy0Lhibh5udO0Jw99thKybmP8g6UyWBIy3cMZDev1E7/Of6RcRgl2eddMgbhc0Vur+ITYcFOpgT1/WErD3fRhCCjx98FOEZg4lqDtRcGQ0+AASNmMNYwPKeEPV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429593; c=relaxed/simple;
	bh=7LRVPAXPzmZKk2HWqTCbpwSH9pB7ah/CE8HXSqLrL5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmq/KtTCBeenVg+U0vY0e/vTBG+4ZW3WVLYnB6iDt7aP4F9iELrPdhxdNVNwh9wiTTqC3HnvPsjDz2thK1IRcQF8ym2/7zu1mIrGviwbvZPRecUR7b5jctp27teZfLzRF2HhNcV78tIfLREd0evYXjN6L0Fn3MVBpkX10+MQcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dlrs9O3h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xx2s15e0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dlrs9O3h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xx2s15e0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dlrs9O3h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xx2s15e0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dlrs9O3h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xx2s15e0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD966671BA;
	Tue,  2 Jun 2026 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780429590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUJiLnVNYx4jl1IFMS1zPlnewmJfHuE9ykLaQxjbkqU=;
	b=Dlrs9O3hhzHay59ZnYzL+L1Ncn6bGynG632NerGF2iGo820UHsjX9j69cIQQEfFIe7UmfQ
	VcruqWZUj3Ly35VZ9/LSf9pM84WeZUTRzg1P1cSKOWbOqWX+mUkIhxiea3itHr4f4vgqsk
	k8VB0EPUtZwGPrkYAjSbGKqmjDnECNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780429590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUJiLnVNYx4jl1IFMS1zPlnewmJfHuE9ykLaQxjbkqU=;
	b=xx2s15e0ydBzRxuLGFufsLuP96gSBhih1olXAGKoRa6FCJs2n2s4zqxqKAUCmE403FlvcP
	nD+VOCsQaIjGrMCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780429590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUJiLnVNYx4jl1IFMS1zPlnewmJfHuE9ykLaQxjbkqU=;
	b=Dlrs9O3hhzHay59ZnYzL+L1Ncn6bGynG632NerGF2iGo820UHsjX9j69cIQQEfFIe7UmfQ
	VcruqWZUj3Ly35VZ9/LSf9pM84WeZUTRzg1P1cSKOWbOqWX+mUkIhxiea3itHr4f4vgqsk
	k8VB0EPUtZwGPrkYAjSbGKqmjDnECNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780429590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUJiLnVNYx4jl1IFMS1zPlnewmJfHuE9ykLaQxjbkqU=;
	b=xx2s15e0ydBzRxuLGFufsLuP96gSBhih1olXAGKoRa6FCJs2n2s4zqxqKAUCmE403FlvcP
	nD+VOCsQaIjGrMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 470DC779A7;
	Tue,  2 Jun 2026 19:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KONkDhYzH2r5IgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 02 Jun 2026 19:46:30 +0000
Message-ID: <bc71f624-e4ce-47b7-9dae-13ad0db76ad1@suse.de>
Date: Tue, 2 Jun 2026 21:46:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iplink: add support for setting IPv4
 devconf parameters
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <20260601143242.6729-1-fmancera@suse.de>
 <f97592a2-6690-4511-a98c-dacdeedf6516@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <f97592a2-6690-4511-a98c-dacdeedf6516@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Level: 

On 6/2/26 9:36 PM, David Ahern wrote:
> On 6/1/26 8:32 AM, Fernando Fernandez Mancera wrote:
>> Currently, modifying IPv4 interface configuration parameters requires
>> interacting with sysctl (/proc/sys/net/ipv4/conf/*). While
>> ip-netconf exists for monitoring these values, there has been no native
>> way to set them directly through iproute2.
>>
>> This patch introduces the support for that via 'inet' at the 'ip link
>> set'. It uses IFLA_INET_CONF netlink attribute to set the parameter.
>>
>> Example to enable forwarding on an interface:
>>
>> ip link set dev enp8s0 inet forwarding on
> 
> If an attribute can be set this way, then ip link show needs to show the
> values. What's the plan on that front?
> 

I could introduce it in a follow-up patch. I guess it makes sense to 
introduce it for ip -d link show only, right? I am happy to work on it 
anyway.

>>
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   ip/iplink.c           | 354 ++++++++++++++++++++++++++++++++++++++++++
>>   man/man8/ip-link.8.in |  81 ++++++++++
>>   2 files changed, 435 insertions(+)
>>
> 
> ...
> 
>>   		"		[ gso_max_size BYTES ] [ gso_ipv4_max_size BYTES ] [ gso_max_segs PACKETS ]\n"
>> @@ -551,6 +569,339 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
>>   	return 0;
>>   }
>>   
>> +static int iplink_parse_inet(int *argcp, char ***argvp, struct iplink_req *req)
>> +{
>> +	struct rtattr *afs, *afinet, *inet_devconf;
>> +	char **argv = *argvp;
>> +	int argc = *argcp;
>> +	int ret;
>> +
>> +	afs = addattr_nest(&req->n, sizeof(*req), IFLA_AF_SPEC);
>> +	afinet = addattr_nest(&req->n, sizeof(*req), AF_INET);
>> +	inet_devconf = addattr_nest(&req->n, sizeof(*req), IFLA_INET_CONF);
>> +
>> +	while (NEXT_ARG_OK()) {
>> +		NEXT_ARG();
>> +		if (matches(*argv, "forwarding") == 0) {
> 
> new uses of matches are not allowed. If s/matches/strcmp/ is the only
> comment, I can fix up before applying.
> 

Sorry I didn't know this. Thanks.

