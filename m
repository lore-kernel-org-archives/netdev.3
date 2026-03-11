Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6531AF14
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225191; cv=none; b=eFIpQOCez/3SVbVLa+tcnVY+eujyMT1fW+n53KC9blyRZq8FfEjSX3+kCUP2WgSpxjoriiPr45FcV17JmYvl+Qu4oeMYwtTP0y7Z/ExgH6IjHOV/DG4gc+vkIZJHb00BQ01KjUt1QtJvkHsHHnRR9TOn2nmddKrZGfGTWMLeZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225191; c=relaxed/simple;
	bh=Ol7MOEzOme5ucrtf0GVgd1wTGv0R38aNhQMDyPPazcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUVAnQgdE9fOBGOmd3SosOndZb3q6D1CY3WnccrTVlH3xoGWHCYyi4/a4k2sNiEgJhYUbr91e/lF8OTDt8f4vY3flC2W1ni+a01zOPLZ104DMw2eXsh6LE5DBePiu0Cgch0vxhAlWGB4BASdOG3l3m6ANSTMmCwd8vfGfq3F/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IYfRbCnt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5ek4T3is; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IYfRbCnt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5ek4T3is; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IYfRbCnt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5ek4T3is";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IYfRbCnt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5ek4T3is"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 908CB5BDB5;
	Wed, 11 Mar 2026 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773225188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nn6jFZ03Edk4LxvnlwmnUE98fB0IuqELnmRZIWvIJ7A=;
	b=IYfRbCntWayY6PgHvn/zY+jAGxqCykwEc3r1IGg+GysscEXYo/qejrkFLlIDmrvkkiAo4J
	HwjBSn7FiXH0xsS6VHmDglGDjptOcj+XvHTw2+DmJSKQLWcEiREDum/ofgyRckyDA35YWV
	UUDTstx0U704tRUsZ301OhGOiFVK7u4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773225188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nn6jFZ03Edk4LxvnlwmnUE98fB0IuqELnmRZIWvIJ7A=;
	b=5ek4T3iseEQPbbnIJbsVuKTo0xw3nMkjI7xxfaJKbuS1RxR9hZENn2PiKIElQdMHodc6Ge
	/dGNLlfnKUFRj0DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773225188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nn6jFZ03Edk4LxvnlwmnUE98fB0IuqELnmRZIWvIJ7A=;
	b=IYfRbCntWayY6PgHvn/zY+jAGxqCykwEc3r1IGg+GysscEXYo/qejrkFLlIDmrvkkiAo4J
	HwjBSn7FiXH0xsS6VHmDglGDjptOcj+XvHTw2+DmJSKQLWcEiREDum/ofgyRckyDA35YWV
	UUDTstx0U704tRUsZ301OhGOiFVK7u4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773225188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nn6jFZ03Edk4LxvnlwmnUE98fB0IuqELnmRZIWvIJ7A=;
	b=5ek4T3iseEQPbbnIJbsVuKTo0xw3nMkjI7xxfaJKbuS1RxR9hZENn2PiKIElQdMHodc6Ge
	/dGNLlfnKUFRj0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 786B03F988;
	Wed, 11 Mar 2026 10:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fekjHOREsWmrGgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 11 Mar 2026 10:33:08 +0000
Date: Wed, 11 Mar 2026 11:33:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, lkp@intel.com,
	netdev@vger.kernel.org, oe-lkp@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>, ltp@lists.linux.it
Subject: Re: [LTP] [linux-next:master] [icmp] 64db5933c7:
 ltp.cve-2020-25705.fail
Message-ID: <abFE5PEtrkT5paKB@yuki.lan>
References: <202603091409.866c520c-lkp@intel.com>
 <CANn89iKUdtWw4ptM8ZreRP0a2FuvQOJ5FgE3o4q-zTRTmt1Umg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKUdtWw4ptM8ZreRP0a2FuvQOJ5FgE3o4q-zTRTmt1Umg@mail.gmail.com>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO

Hi!
> I do not want to know what this test is doing or expecting.
> 
> If it expects sysctls to have a precise value, it should set them ?

The test is a CVE reproducer that checks if ICMP message ratelimiting is
sufficiently randomized so that we do not leak information about the
system.

See the test source code:

https://github.com/linux-test-project/ltp/blob/master/testcases/cve/icmp_rate_limit01.c

-- 
Cyril Hrubis
chrubis@suse.cz
