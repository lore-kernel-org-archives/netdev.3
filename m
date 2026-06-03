Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27812399354
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500639; cv=none; b=YknmP2OgL0M9fMVS9nBl6jIv4zTcF4vV3OVdURlifUlHQ3GGtF8wSqniGfKCeomaio1PnqU8XVHHVfpBbRMf4bLryfRZwI71NuaAMhk00DvZcomSn1Xy7Lg2K4ZZF3KZIXiYTFJKBh8Uc0d0LJZ5hV94QyCavAkbGAXzZ2b7Jpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500639; c=relaxed/simple;
	bh=YH8QjehUUHYXfkOR4RyLOOM+FbbCxkFsYCObtfNRgrY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vh9fv5wNZ6qRqCRYvxo0LJHKzgNadBfGWhfIPMUGFomM2HwurXQaPgBawt1aYFHKRkdAvlP5i7XhWcKBtCM2FDlM7chsMa/8o+fMiJcN6K+2QERj7jJMXvaA8jl1DiKUOQgYqT2tG0DP/eGvufUv53NIzePFBldVD0+3PrOVupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o4I8gxWG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A4APNyNv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o4I8gxWG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A4APNyNv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o4I8gxWG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A4APNyNv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o4I8gxWG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A4APNyNv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2712C6AA6B;
	Wed,  3 Jun 2026 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780500634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57At0JKhdOkr3+R8RYksb9H2Pj7UIRMYAWqKjWDhXX4=;
	b=o4I8gxWGpIoZXreFOB/xliyGXxZ0HLZnAMPki4b4mYEQzMfCv+bhtbWXW4R0X6gF6fjFP5
	tLSBIQRtvQPZ6VuUske99pv/UmLSLOBM7lE8Lx6hPA45ezuJhqEMwo0pQSRuRYHERa5FFt
	2ljSS5pnllXz7mrxvHSscHNA6hU2aT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780500634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57At0JKhdOkr3+R8RYksb9H2Pj7UIRMYAWqKjWDhXX4=;
	b=A4APNyNvl++JpI+XhxpH2hcedvPp9FjZO8JCNvpUSUP5B+WOu3Qqh0l/eqfi6du+tSgRJ+
	R4OkKvssd6rGZdCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780500634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57At0JKhdOkr3+R8RYksb9H2Pj7UIRMYAWqKjWDhXX4=;
	b=o4I8gxWGpIoZXreFOB/xliyGXxZ0HLZnAMPki4b4mYEQzMfCv+bhtbWXW4R0X6gF6fjFP5
	tLSBIQRtvQPZ6VuUske99pv/UmLSLOBM7lE8Lx6hPA45ezuJhqEMwo0pQSRuRYHERa5FFt
	2ljSS5pnllXz7mrxvHSscHNA6hU2aT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780500634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57At0JKhdOkr3+R8RYksb9H2Pj7UIRMYAWqKjWDhXX4=;
	b=A4APNyNvl++JpI+XhxpH2hcedvPp9FjZO8JCNvpUSUP5B+WOu3Qqh0l/eqfi6du+tSgRJ+
	R4OkKvssd6rGZdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7F1C779A9;
	Wed,  3 Jun 2026 15:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SekGKplIIGqKOQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 03 Jun 2026 15:30:33 +0000
Message-ID: <15a1950d-1a67-45ee-ab0d-588b5504ef08@suse.de>
Date: Wed, 3 Jun 2026 17:30:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iplink: add support for setting IPv4
 devconf parameters
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: David Ahern <dsahern@kernel.org>, nicolas.dichtel@6wind.com,
 netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
References: <20260601143242.6729-1-fmancera@suse.de>
 <6365ef1e-d62d-4b2d-8e41-526881bbbe37@6wind.com>
 <491689b6-95f9-4e32-ae70-fdae464af353@suse.de>
 <0bc2dcd4-b29e-4a82-8d1b-5170e78c2d74@kernel.org>
 <78284e03-c868-4ae4-a74f-f8c98e2a3945@suse.de>
Content-Language: en-US
In-Reply-To: <78284e03-c868-4ae4-a74f-f8c98e2a3945@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,6wind.com:email]
X-Spam-Level: 
X-Spam-Score: -4.30

On 6/3/26 5:22 PM, Fernando Fernandez Mancera wrote:
> On 6/3/26 5:18 PM, David Ahern wrote:
>> On 6/3/26 7:24 AM, Fernando Fernandez Mancera wrote:
>>> On 6/3/26 2:50 PM, Nicolas Dichtel wrote:
>>>> Le 01/06/2026 à 16:32, Fernando Fernandez Mancera a écrit :
>>>>> Currently, modifying IPv4 interface configuration parameters requires
>>>>> interacting with sysctl (/proc/sys/net/ipv4/conf/*). While
>>>>> ip-netconf exists for monitoring these values, there has been no 
>>>>> native
>>>>> way to set them directly through iproute2.
>>>>>
>>>>> This patch introduces the support for that via 'inet' at the 'ip link
>>>>> set'. It uses IFLA_INET_CONF netlink attribute to set the parameter.
>>>>>
>>>>> Example to enable forwarding on an interface:
>>>>>
>>>>> ip link set dev enp8s0 inet forwarding on
>>>>>
>>>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>>> Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>>>>
>>>> Do you plan to add the ipv6 part also?
>>>
>>> Yes, it is cooking but I want to get merged IPv4 first.
>>>
>>
>> If I merge the ipv4 patch today that means you are signing up to send
>> patches for ipv6 set and then ipv4 and ipv6 show in detailed device
>> dump. All of that in the next 2 weeks before 7.1 is released. Just want
>> to make sure we are clear on expectations.
>>
> 
> Sounds good to me. I am already working on it.
> 

Just to clarify, the IPv6 support depends on a series I am testing for 
kernel as the current support is quite poor. The "get" operation is 
rather simple and works fine without any kernel patch.
