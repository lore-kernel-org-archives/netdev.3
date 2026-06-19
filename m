Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD8372B39
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864887; cv=none; b=t+ghQlPuP87nj0FYi9V7OVRjJHYJyBv0YUhZvnbUwA2uybrJxjxMz5g4IAdF2L/UXlm8x15JKqVFaYWWv0lV0zUyNCYR+AoCmh9cRaPMlVgiFSuzfwI5xCJXrX7p+EwZSBZyUZRL/TaEDu4MF9bvKH/d+lomD8wcLBfSPVfwZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864887; c=relaxed/simple;
	bh=mahV54k5L5UoBXn8gXlwd4Yan9/Oi0mmKz/T8YnJpC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAEvfhEcJUT5wiSoJzVlPwz9v+4ZCYAvQE9SgEX224bDysfuewSQuWi4QI3Jh5giNgXc9vwFbbOscmO1cDRvhAKR+KQn8b/bTvTdI9BFg3icj6WGizLRFUDQvWuAfF0Y2JMkCMuNUaivAH/Yt7kBqIa3LpMtz3iVYlYpYff5Il8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NIWSjaDr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GHSwQQxM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jRbx3Rs/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z/LgTkA4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NIWSjaDr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GHSwQQxM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jRbx3Rs/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z/LgTkA4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED9A475851;
	Fri, 19 Jun 2026 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781864882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCqV2Y+IJp6VXKHqhrLwRSu2HPm/+yAJZPTjVXijng8=;
	b=NIWSjaDrjcazST9NAjs3uIAbpoB0O5ENP9DlpFtueOiqXT9S+TmxwLl9WF16gYE3vYUbRz
	RKq27I8TRJezTlqBkjalGkyhwW/n9XdWH4qjYm1SrMzc/9fy1q7Jhq4L7lMb6Asv13uNMF
	3bDRPk4nvOTwWL2v+XBsvCLICQYljag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781864882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCqV2Y+IJp6VXKHqhrLwRSu2HPm/+yAJZPTjVXijng8=;
	b=GHSwQQxMDQj6r9BAVXHAw+6Qqi11lY5WrE4qHA3PTNXIUbEihYQPgYi1+qpHiaKth3Nu44
	G61UzbzqFJs+ONDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jRbx3Rs/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Z/LgTkA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781864881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCqV2Y+IJp6VXKHqhrLwRSu2HPm/+yAJZPTjVXijng8=;
	b=jRbx3Rs/EHL68EbLR+TjAdArWV3LGbJwBV4vqo5bu28fcjvCPgZz2o0lMcZ7TDQgbhYOnZ
	o+QE2GiuI0h201xISNBSMw0I9qhSM+w3sYehlKWnfI7igGUY4VQmZDmtovfJYYDaSnOl2n
	3WNC5h+NvUcHFZ4HRta3NqPKg9p43Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781864881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCqV2Y+IJp6VXKHqhrLwRSu2HPm/+yAJZPTjVXijng8=;
	b=Z/LgTkA4ro3bjzXNCpMC7iQs9FUNYZWa8XrTgCaszxYn383Mm/xlvsFv3p+l9ED0a9EexD
	0rx83H0mMwDBnkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37A2E779A8;
	Fri, 19 Jun 2026 10:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CpW+CrEZNWpNLQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 19 Jun 2026 10:28:01 +0000
Message-ID: <91d77512-f741-41d1-a799-5409690da5d7@suse.de>
Date: Fri, 19 Jun 2026 12:28:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] ipv6: fix error handling in forwarding sysctl
To: nicolas.dichtel@6wind.com, netdev@vger.kernel.org
Cc: shemminger@vyatta.com, dforster@brocade.com, gospo@cumulusnetworks.com,
 ddutt@cumulusnetworks.com, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org
References: <20260618162225.4588-1-fmancera@suse.de>
 <20260618162225.4588-4-fmancera@suse.de>
 <fa7cbedb-33f3-4a79-acff-2b23cf3f57d8@6wind.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <fa7cbedb-33f3-4a79-acff-2b23cf3f57d8@6wind.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ED9A475851
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/19/26 11:34 AM, Nicolas Dichtel wrote:
> Le 18/06/2026 à 18:22, Fernando Fernandez Mancera a écrit :
>> When writing to the forwarding sysctl, if proc_dointvec() fails to parse
>> the input, it returns a negative error code. The current implementation
>> is overwriting that error for write operations.
>>
>> This results in a silent failure, it returns a successful write although
>> the configuration was not modified at all. When modifying the "all"
>> variant it can also modify the configuration of existing interfaces to
>> the wrong value.
>>
>> Fix this by checking the return value of proc_dointvec() and returning
>> early on failure.
>>
>> Fixes: b325fddb7f86 ("ipv6: Fix sysctl unregistration deadlock")
> The bug existed before the git era.
> Maybe
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> 


Hm, not really, AFAICS b325fddb7f86 is the first commit overwriting the 
return value from proc_dointvec(). See:

@@ -3983,7 +3986,7 @@ int addrconf_sysctl_forward(ctl_table *ctl, int 
write, struct file * filp,
  	ret = proc_dointvec(ctl, write, filp, buffer, lenp, ppos);

  	if (write)
-		addrconf_fixup_forwarding(ctl, valp, val);
+		ret = addrconf_fixup_forwarding(ctl, valp, val);
  	return ret;
  }
