Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CE3A1E92
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474010; cv=none; b=dtBHuOqryZJgKC5VeFixK52W/koK4SexYWzhFR1NZcvmDDv+oVa2fB2ZPrLby64xAMQXwsAj6CKNOU1++2Sm7/BPNemviCJiNyemF4W7lSuAHHVOMz2kvVI9mRqM+HVYdT1QerxYAvp/jc7CkK7pyK+UjpP0XqnLAY0IOI64CKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474010; c=relaxed/simple;
	bh=uNLmpf/k3Ziojy6QPrnaI3HjQUJYLRWSA+Yhe4miGK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgXJd3qs8Na3h16TbS1y5qTBOvLMli0FUP7UX6jkonxIxVKkokz98Pi+5d8qhMwCH63FrDZORZ2dzEALtccomwEqu8a2aXkstYY9fxx8UX29VMaL5eWWYhqh/YXvK438zyWYi/ZJLUz+I6puMh8Q9tLorTwUKAUyUjO1bPDSbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z8HEmMBD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ikfok4Ji; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z8HEmMBD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ikfok4Ji; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z8HEmMBD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ikfok4Ji";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z8HEmMBD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ikfok4Ji"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B92B6A85D;
	Wed,  3 Jun 2026 08:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780474007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS7RSJTXsuBLhvU6DXs2m5xgrYaSH9R03tpC93168TM=;
	b=Z8HEmMBDA58cRYv1o67pfeOIMwKfRVZDDrZYPlVOlMxy53Y0kKa9wbR3rMLHhaqfr6sr80
	a3w7fQ1SI1bAfKw5sbws87aJPFXoWNXzjWYp8Dksw6V7hU6GYqmENJsxjkkvoFynjSW0Cy
	msR7/v0t+SollDbWh+IJDVUr+Wdrjo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780474007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS7RSJTXsuBLhvU6DXs2m5xgrYaSH9R03tpC93168TM=;
	b=Ikfok4JiZCo0053fk6f6XYUJXYzeT3QS1o1aqwQVSeAfgmpcxfs8fhTXXi+fe+GbicCf0G
	JbWsdWgdnWY1fUCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z8HEmMBD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ikfok4Ji
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780474007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS7RSJTXsuBLhvU6DXs2m5xgrYaSH9R03tpC93168TM=;
	b=Z8HEmMBDA58cRYv1o67pfeOIMwKfRVZDDrZYPlVOlMxy53Y0kKa9wbR3rMLHhaqfr6sr80
	a3w7fQ1SI1bAfKw5sbws87aJPFXoWNXzjWYp8Dksw6V7hU6GYqmENJsxjkkvoFynjSW0Cy
	msR7/v0t+SollDbWh+IJDVUr+Wdrjo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780474007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS7RSJTXsuBLhvU6DXs2m5xgrYaSH9R03tpC93168TM=;
	b=Ikfok4JiZCo0053fk6f6XYUJXYzeT3QS1o1aqwQVSeAfgmpcxfs8fhTXXi+fe+GbicCf0G
	JbWsdWgdnWY1fUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0A13593AC;
	Wed,  3 Jun 2026 08:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hGPQN5XgH2plCAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 03 Jun 2026 08:06:45 +0000
Message-ID: <30906ad5-43b8-4192-946a-8c2533f976ff@suse.de>
Date: Wed, 3 Jun 2026 10:06:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
To: Ido Schimmel <idosch@nvidia.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
 netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, Chris Adams <linux@cmadams.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Beniamino Galvani <bgalvani@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 regressions@lists.linux.dev
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org>
 <20260601153525.546746a8@elisabeth>
 <CACT4oueDv=KRZmJw=1N58EN7eoFz5AqbBBMP8FE4=+rQ99oFEg@mail.gmail.com>
 <8e9cbf0a-caff-4575-afb7-fe852df8a51a@kernel.org>
 <CACT4oueJ3GsVvnWcZHgYVL-fCjpt5nOw+2=0BTmiz-9xKY4B0w@mail.gmail.com>
 <eba11df5-3ae6-4bc4-bbe7-be358a0d4717@leemhuis.info>
 <ee2b92e5-6d95-4c36-9fa8-6cd2a1572556@suse.de>
 <20260603080023.GA575206@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260603080023.GA575206@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[leemhuis.info,redhat.com,kernel.org,vger.kernel.org,gmail.com,google.com,davemloft.net,cmadams.net,gibson.dropbear.id.au,lunn.ch,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1B92B6A85D
X-Spam-Score: -3.01

On 6/3/26 10:00 AM, Ido Schimmel wrote:
> On Wed, Jun 03, 2026 at 09:29:55AM +0200, Fernando Fernandez Mancera wrote:
>> We should document that the order matters, no that it is "random" because it
>> isn't.
> 
> Did you consider writing a kernel selftest for this? Unlikely that the
> order will change again when we are explicitly testing for a certain
> order.
> 

That is a good idea yes, I am adding it to my TO-DO list.

Thanks,
Fernando.
