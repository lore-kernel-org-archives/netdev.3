Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4FE286430
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601987; cv=none; b=i7FAu5Oh/nzRM/wAROAoV/1Si+719iOEDWspEyII+DpUjheCasTIL+wLjx4G4Ba7lxd9vKE4+3/hVw6mWKTxzp8/etUiEdhQugW28WG8lABA1NjgmojFzKIIL4db8G/6Dw+JXn8HHTvkkyUT0snmrXdfrz8QzmOwP0qEtYly2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601987; c=relaxed/simple;
	bh=uSPR0RY01cqEmRWZxpE46Z1+o4rU6UsigEB9ifrCKL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0tywuxOrzLdUMREmMz9kEcKKFiw6Y72DSKOqEbKWBNC0m33dZx3jaIGownSIpaS+xH3Sged3waw7Rn0EgGd92ZNaHC6Mky4KzJQPObcaASDTOE/gafO4cEZZmVBY3O50ZTn4NP/zLjlzZzrhqLBgZSAC6UtygRgzo7zvScixRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uA5N4Kxf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tFCe3QXj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uA5N4Kxf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tFCe3QXj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uA5N4Kxf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tFCe3QXj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uA5N4Kxf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tFCe3QXj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 715655C3E4;
	Fri, 20 Feb 2026 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771601984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dNbgEbZFgxINysFV0FrPgquNnKqGEBxkuMm5EoXSSk=;
	b=uA5N4KxfhmYLX6+170VsjfQM0PbZ1eQL1lJvtwz9R9GxAkKLH/kBI2D3A+N+25T1l/1XJM
	aLEpyfAM7ps3UKIoRwCsMY1zr7c0LrINNACxFDnN/7RU9zPLBmZ/KksWbSq/GKW53IMcli
	2yWtLLNg9bb1Zz7xUGnObT1H5hjF+dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771601984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dNbgEbZFgxINysFV0FrPgquNnKqGEBxkuMm5EoXSSk=;
	b=tFCe3QXj/aCvhE9zbGTPzbJn1R9tBwDygRkQGT0tNizNW8f9KsOHl2CxnoeCA514UjtY2k
	9hOreJySYNf5bJDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uA5N4Kxf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tFCe3QXj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771601984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dNbgEbZFgxINysFV0FrPgquNnKqGEBxkuMm5EoXSSk=;
	b=uA5N4KxfhmYLX6+170VsjfQM0PbZ1eQL1lJvtwz9R9GxAkKLH/kBI2D3A+N+25T1l/1XJM
	aLEpyfAM7ps3UKIoRwCsMY1zr7c0LrINNACxFDnN/7RU9zPLBmZ/KksWbSq/GKW53IMcli
	2yWtLLNg9bb1Zz7xUGnObT1H5hjF+dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771601984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dNbgEbZFgxINysFV0FrPgquNnKqGEBxkuMm5EoXSSk=;
	b=tFCe3QXj/aCvhE9zbGTPzbJn1R9tBwDygRkQGT0tNizNW8f9KsOHl2CxnoeCA514UjtY2k
	9hOreJySYNf5bJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7EB13EA65;
	Fri, 20 Feb 2026 15:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PEYvMD+AmGkZbwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 20 Feb 2026 15:39:43 +0000
Message-ID: <b3466d97-cbd2-4288-8da4-9f30df1ae477@suse.de>
Date: Fri, 20 Feb 2026 16:39:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: addrconf: reduce default temp_valid_lft to 2
 days
To: patchwork-bot+netdevbpf@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, fgont@si6networks.com
References: <20260214172543.5783-1-fmancera@suse.de>
 <177137761857.765825.5185653389299397165.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <177137761857.765825.5185653389299397165.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[netdevbpf];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 715655C3E4
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

On 2/18/26 2:20 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Sat, 14 Feb 2026 18:25:43 +0100 you wrote:
>> This is a recommendation from RFC 8981 and it was intended to be changed
>> by commit 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
>> but it only changed the sysctl documentation.
>>
>> Fixes: 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>
>> [...]
> 
> Here is the summary with links:
>    - [net,v2] ipv6: addrconf: reduce default temp_valid_lft to 2 days
>      https://git.kernel.org/netdev/net/c/9e371b0ba7f5
> 

FTR; the patch was merged without the fixes tag. I think it would be 
good to backport this to stable kernels because otherwise the 
documentation and the real configured value are contradicting each other.

> You are awesome, thank you!

