Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9639DBFD
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432719; cv=none; b=aPFybrfFUWp+3Mj+rjjMXtzNHx4lqtaRiuAUQlVcQez1PoU/YoxsAy/cvgXp31lraAqiaZ8skRuhdVqSwfcIfo2NMB/KFxHIc3msgZ9uVVC6h1t1QsQB1JRRAomqYiI9Oz53Z5WotfsrRw7AVrLFmyEO1u2dAE4JalYIxdGcQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432719; c=relaxed/simple;
	bh=+/M+i4GQUf/WuzxfoQND6YeQVJa2UOXpbHB67Xmjp3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaJSOQEnuaJjIQ7U0WT4AID++rrKQrLvK9dlqRnzdKNOo/tdy1fKAP4hmTl7VizqlW5S4xRofZ8WyuoBghfeF9sgN7803HDP2JJTGKxybjLrIUPJMlSbJqOJPZiN6TSjcpIGBlH6m9lRfsQj3VBO8Ns99ML1fJS6A/xO4TvOYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t3Rzr/ZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m6NStZxX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t3Rzr/ZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m6NStZxX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t3Rzr/ZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m6NStZxX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t3Rzr/ZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m6NStZxX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38E136B102;
	Sun, 10 May 2026 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778432716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdzP/Xxvb7jr89HHk+vrFGBQW+EaZi2atMtnwucH4/M=;
	b=t3Rzr/ZAothvvYEaw2BmuQuaVdqh0q521a08fn7rvln3a904fgSFNzcIR1Day3hDAnNKdC
	wZYtKCzWz+jwlf6RE7GXCPFKcjt7YXCJO/OXCvyWeYFXqBdOhcc2WLCojamO6YVStvvIIY
	ohEvDnp68CKG2dGAyYwWA1/a//8yflw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778432716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdzP/Xxvb7jr89HHk+vrFGBQW+EaZi2atMtnwucH4/M=;
	b=m6NStZxX+I6i4FJph6UpOHgK8nPOwaBQNE3e2LL5IdyPdBPt6ub2eLMW6FZGmtd9/912iI
	VGrN2S5/PeKipiBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="t3Rzr/ZA";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m6NStZxX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778432716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdzP/Xxvb7jr89HHk+vrFGBQW+EaZi2atMtnwucH4/M=;
	b=t3Rzr/ZAothvvYEaw2BmuQuaVdqh0q521a08fn7rvln3a904fgSFNzcIR1Day3hDAnNKdC
	wZYtKCzWz+jwlf6RE7GXCPFKcjt7YXCJO/OXCvyWeYFXqBdOhcc2WLCojamO6YVStvvIIY
	ohEvDnp68CKG2dGAyYwWA1/a//8yflw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778432716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdzP/Xxvb7jr89HHk+vrFGBQW+EaZi2atMtnwucH4/M=;
	b=m6NStZxX+I6i4FJph6UpOHgK8nPOwaBQNE3e2LL5IdyPdBPt6ub2eLMW6FZGmtd9/912iI
	VGrN2S5/PeKipiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D9AE593A3;
	Sun, 10 May 2026 17:05:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gg/dFsu6AGq6fQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 10 May 2026 17:05:15 +0000
Message-ID: <ae8593df-e86e-4f06-ba0b-71b75cd5d589@suse.de>
Date: Sun, 10 May 2026 19:05:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
To: Jakub Kicinski <kuba@kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org, stable@vger.kernel.org
References: <af2kdW2F1gJ9U-Gg@v4bel> <20260510084520.476745b5@kernel.org>
 <agC256wVYa4Gnvy1@v4bel> <20260510100310.230b15ed@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260510100310.230b15ed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 38E136B102
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 5/10/26 7:03 PM, Jakub Kicinski wrote:
> On Mon, 11 May 2026 01:48:39 +0900 Hyunwoo Kim wrote:
>> On Sun, May 10, 2026 at 08:45:20AM -0700, Jakub Kicinski wrote:
>>> On Fri, 8 May 2026 17:53:09 +0900 Hyunwoo Kim wrote:
>>>>   			    sp->hdr.securityIndex != 0 &&
>>>> -			    skb_cloned(skb)) {
>>>> +			    (skb_cloned(skb) ||
>>>> +			     skb_has_frag_list(skb) ||
>>>> +			     skb_has_shared_frag(skb))) {
>>>
>>> We seem to be getting a lot of fixes for this issue, and this one is
>>> incorrect :| Writing to _any_ frags is incorrect. You have to copy
>>> if skb is not linear. skb_ensure_writable()
>>
>> I was testing a patch based on skb_ensure_writable() but it seems v3
>> has just been merged to mainline...
>>
>> What would be the best way to proceed?
> 
> Depends on the tree. Where was it merged?
> 

It is already on linus' tree.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71
