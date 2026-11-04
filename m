Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812096;
	b=gYTEAbl23pBhcssxz/TU4VYhyQXoom6XjU/DKg8n3rQS9bIE3hi32fC/FiNFp/l6ldzT
	 8elLn61GWgtbMY7YjQ5VFRk4XZm5OnSLBMqszByLD81WW+AZBLhN9UItV6DOlkPYnwFVd
	 2NF484uUhW4Fadv5m11hHOtgjJvelYH4AlszA6kdfQmeHEupFDSP77dLcDjeSk1KoeFu/
	 2wQGRczXRoUEeq5c1YCPFSb0E51q9/d9eGLrQqZxoi2QkOf5+YN06HlO03++x2i3JXOpK
	 OxM1/NS2uVJDBdrJY1LnMehDn2VR+d25kinZKxTSDNAjy7zQ/KeZDwekS7CvMsO/ezg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812096;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=KerPOCuXiJ/QZToY/uoNDeTIPUL/z8dbK1bs/3iiQhs=;
	b=ZnNxrhHM0q81jTYZGrPT/hIvWXxiJm/7oD92etJqJRGrrGJOSmF9+5jtNf9z+SDASjsE
	 a3vioPPJevUeiuHS1bASFAkXC1T0dPiC2nS5P8geMKjrtiT2wYMqpCPmh/7gyN2OABHps
	 BIdZuFt4dDuolyrsGQHZQ0/71pFd+M2j1MxJCN8Pt/SFw5qHM8HoMg+b3zle9n0iFuNDy
	 zAkQm1xbne6IaNozQbc8rR64oNVOy/fNPz9t8HIhcpvktSwsRJSt0Nm4udnkp3VNA95HZ
	 Wy9CQLnt4GKx5Ny+HReVTgOY2vvxl/QvFTW2BwlL6q1j463u5Lx+EOkk3LcbXo3swCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fjeXHbcB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sPziOhVE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fjeXHbcB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sPziOhVE;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A698606A31B;
	Wed,  4 Nov 2026 17:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A698606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fjeXHbcB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sPziOhVE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fjeXHbcB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sPziOhVE
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B404E21E87;
	Wed,  4 Nov 2026 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793812093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KerPOCuXiJ/QZToY/uoNDeTIPUL/z8dbK1bs/3iiQhs=;
	b=fjeXHbcBmeGoOsQ66MGtk7GS97PTuZ0SEVrDEHqBxbJJLqTk7k413Q5Un5kc3kzCv9DGv1
	svXJGNH7HfRr8rq2ydZrKOUWAS3UWNAooQXZml6mVQGtgM7NzwVVDEzRJerTeElyCC8OPv
	o3QHY3tzXARmYC9Rw9KUCZgK7BbaYe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793812093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KerPOCuXiJ/QZToY/uoNDeTIPUL/z8dbK1bs/3iiQhs=;
	b=sPziOhVEQebu5+LUfB7+JL50/zHMNQZED0i4bMOiXVcQLwF+IIytgIue9+9NhG+mHS857y
	VJ546hT6PFr1ahBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793812093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KerPOCuXiJ/QZToY/uoNDeTIPUL/z8dbK1bs/3iiQhs=;
	b=fjeXHbcBmeGoOsQ66MGtk7GS97PTuZ0SEVrDEHqBxbJJLqTk7k413Q5Un5kc3kzCv9DGv1
	svXJGNH7HfRr8rq2ydZrKOUWAS3UWNAooQXZml6mVQGtgM7NzwVVDEzRJerTeElyCC8OPv
	o3QHY3tzXARmYC9Rw9KUCZgK7BbaYe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793812093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KerPOCuXiJ/QZToY/uoNDeTIPUL/z8dbK1bs/3iiQhs=;
	b=sPziOhVEQebu5+LUfB7+JL50/zHMNQZED0i4bMOiXVcQLwF+IIytgIue9+9NhG+mHS857y
	VJ546hT6PFr1ahBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80407134A5;
	Wed,  4 Nov 2026 17:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wvMBFHxm62pTFgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 04 Nov 2026 17:08:12 +0000
Date: Wed, 4 Nov 2026 17:08:10 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, "open list:MEMORY MANAGEMENT - CORE" <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/rmap: use release ordering for small-folio
 mapcount removal
Message-ID: <autkT1eNM7-oSM4F@pedro-suse.tail5790ac.ts.net>
References: <20261104013139.1341582-1-bobby.prani@gmail.com>
 <750560f3-4c5a-44fe-b72a-0611be383f32@kernel.org>
 <CAJhHMCCu8ehOU37_4UpExNO3U8YPygjnht+2S+axkxTwY8bx2w@mail.gmail.com>
 <287698ab-76dc-4aee-8e6c-db1f5d18974c@kernel.org>
 <aus4ag1KxpuBNSP1@gremlin>
 <CAJhHMCChBTH3QWBFS1Hp17zj5HepN6KFucvG_5tVdpaB4fjCYg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhHMCChBTH3QWBFS1Hp17zj5HepN6KFucvG_5tVdpaB4fjCYg@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,infradead.org,google.com,suse.com,surriel.com,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.80

On Wed, Nov 04, 2026 at 08:51:20AM -0800, Pranith Kumar wrote:
> Hi Lorenzo,
> 
> On Wed, Nov 4, 2026 at 5:55 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > On Wed, Nov 04, 2026 at 02:37:39PM +0100, David Hildenbrand (Arm) wrote:
> >
> > I mean 1.54%, theoretically is even less convincing for me :)
> 
> With reducing the strength of one barrier, I think this is a non-trivial gain.

Counting cycles on an arm64 simulator for a microbenchmark is completely
unconvincing.

> >
> > In any case for something touching a sensitive memory barrier operation to have
> > a stronger argument put forward for release ordering being suitable than simply
> > stating it's fine in the commit message and updating a comment.
> >
> 
> Can you please explain what information is missing? I think the commit
> message has all the details of why release is sufficient instead of
> full barrier.
 
rmap is gnarly code and I'm not sure people have an appetite towards weakening
random atomic ordering semantics for a virtual 1.54% cycles gain in some
microbenchmark, without actually explaining why it is safe. __folio_remove_rmap()
has (indirectly) a lot of callers which may subtly expect different semantics.

-- 
Pedro
