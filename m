Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094773E168C
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849556; cv=none; b=QHuvr0Ap9HRS+taHd/wzaxaljcF16l0wKOzAcKlYH4V2nyu0fYAiM0WJcoB5iSMqW2GujQ0JDtPYTz57PFzrr1TtBW+vFEqvVt/ogfjOUaWmnOZkOtbHYwGADnFYyEPWzkL0Tih6JdyqVnHsxnVIM2Yc28XEiqV9Ce7SXbLsrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849556; c=relaxed/simple;
	bh=FSwPjx5kfkAW/WL/1x6EsAJx1SJiL/uEmmUU44ib9bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpd0Nq0+Sl/UY22kVesYYBCRUgkV59krr/uUhb3JsAk8HlxQ18s7IxtmxK9olxHxg9SuDZv0mPTzGc2z5i6MRkfKKUj7W56TsAHlaw3Urldx1cgM/n4M0YhHQJrkPee8SAQMauIH323JjjKNEC5BxNZangG5JG4RL9MuGGakQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DBk4/scb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8HemeNTS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BRAT7DOz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fq/fA7Rc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DBk4/scb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8HemeNTS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BRAT7DOz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fq/fA7Rc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C91D340C7;
	Tue,  4 Aug 2026 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785849548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFyC/lT41fB0pzLhZsiFwN3y4eTGyvCQsxacjWaSaxY=;
	b=DBk4/scb6GehawqvUAvg5ONR9D7noUlbU9BxkXQTbrBsE8zm6FDUzfXiXvC6Pp+3xgHtN4
	bOBxJfgRk8Th0zvFBKzpraVIYrk/pugPBNK4a0YSRgb2hV1NmRxZwq7gF+XF9CUG9O3r6e
	2A2YZ1DzPeJ/SQ9DjVpewZJ7FRt/B6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785849548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFyC/lT41fB0pzLhZsiFwN3y4eTGyvCQsxacjWaSaxY=;
	b=8HemeNTSdaivBVXh1z4qxN1vsvsBcfs20u6wud91JyKE+N8wjPbQRqexjF/nsIs3HATl9r
	Wzbow2IK0jaBmBDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785849544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFyC/lT41fB0pzLhZsiFwN3y4eTGyvCQsxacjWaSaxY=;
	b=BRAT7DOzqBIXH9Nrh/GleOHcZ4KVfN5IeMoxwj04QH2sYzh6SmF6bHAIVS5bQ8EySocuRv
	QmDXb+m1W2+/ws045Y4saAL7M6RsD5aT1CaZoeCFLqXOEabx3JZ2cra5BkqJuwuWAxxAW9
	/eXXbTV6v8xUxwW7KMOWp/j11CuDeFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785849544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFyC/lT41fB0pzLhZsiFwN3y4eTGyvCQsxacjWaSaxY=;
	b=Fq/fA7RctZuB5fpgFKWtqNIIQEDs7/vjRZ5/eGeeThlnbyqabj3qEJgs9ICVbqLJnL3gft
	7dBI6VA08ygmxlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C04D8779BB;
	Tue,  4 Aug 2026 13:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BB6OK8fmcWowfgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 04 Aug 2026 13:19:03 +0000
Message-ID: <c414bba7-761f-4bf2-a440-7dc401a03fd0@suse.de>
Date: Tue, 4 Aug 2026 15:18:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/2] hsr: Use only one MAC address per node
To: Felix Maurer <fmaurer@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: bigeasy@linutronix.de, liuhangbin@gmail.com, luka.gejak@linux.dev,
 xiaoliang.yang_1@nxp.com, kexinsun@smail.nju.edu.cn,
 ssrane_b23@ee.vjti.ac.in, michael.bommarito@gmail.com,
 2022090917019@std.uestc.edu.cn, yury.norov@gmail.com, jvaclav@redhat.com,
 maoyixie.tju@gmail.com
References: <cover.1784024900.git.fmaurer@redhat.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <cover.1784024900.git.fmaurer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,linutronix.de:email];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,gmail.com,linux.dev,nxp.com,smail.nju.edu.cn,ee.vjti.ac.in,std.uestc.edu.cn,redhat.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,linutronix.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 7/14/26 12:52 PM, Felix Maurer wrote:
> Many places in the hsr module assumed that a single node could be using
> multiple MAC addresses to communicate in the network. The standard is
> explicit that PRP nodes should use the same MAC for frames on both
> ports and commit b65999e7238e ("net: hsr: sync hw addr of slave2
> according to slave1 hw addr on PRP") made this clear. For HSR, the
> standard is less explicit. But after quite some discussions and reading
> standards, Fernando, Sebastian, and I concluded that it never mentions
> different MAC addresses for HSR either and instead often suggests using
> equal addresses for both ports and this should be what hsr interfaces
> do.
> 
> A short history of how this assumption formed in the kernel supports
> this as well: the original HSRv0 code implemented IEC 62439-3:2010 where
> node tables had two MAC addresses per node. It was an optional feature
> to support an unspecified address substitution mechanism for _PRP_, also
> referred to as PICS_SUBS. Note that we never even supported PRPv0 from
> the :2010 standard. In IEC 62439-3:2012, the feature was explicitly
> removed. But with two addresses per node in the node table and selftests
> setting different addresses for both interfaces, the assumption emerged
> that all nodes can have two addresses. In :2010, this was optional and
> the standard is written so that a node not supporting PICS_SUBS could
> just ignore it. Since 2012:, nodes must use the same address for both
> ports in the ring.
> 
> To prevent misconfiguration and simplify the hsr code, this patchset
> removes the notion of two different MAC addresses for one node in the
> network entirely. The first patch sets equal addresses on both ports so
> that we are not running in invalid configurations. I also updates the
> selftest to not use/expect different addresses on the two ports. The
> second patch removes MAC address B from the node table and thereby
> eliminates a lot of code, including the node merging.
> 
> I am posting as an RFC for now mostly for two reasons: First, I want to
> make sure it's generally accepted to have only a single MAC address per
> node and give everyone the chance to speak up against this.
> 
> Second, I adapted the PRP address handling to HSR as well, i.e., to copy
> the address from port A to port B and master, mostly because it is low
> effort. I am not sure though if this is the best approach now that we
> touch this part of the code anyways. I have two alternative ideas how
> addresses should be handled:
> 
> 1) Make the master control the port MAC addresses: when the hsr
>     interface is created, generate a MAC address and assign it to both
>     ports. Changing the address afterwards would also only go through the
>     hsr interface which would update both ports.
> 2) Don't change the MAC addresses of the port interfaces at all. Instead
>     behave similar to bridge where the ports keep their addresses and
>     traffic from the bridge/master gets its own MAC address assigned.
> 
> What do you think? Do you prefer any of these approaches?
> 

Hi Felix, thank you very much for this work. I agree with the overall 
analysis you provided here.

I would try to go for the same solution in both PRP and HSR. Why the 
current approach isn't suitable? If we are going to change the approach 
(for a good reason) I would go for 1).

FWIW, I didn't test this yet.

> Thanks,
>     Felix
> 
> 
> Cc: Fernando Fernandez Mancera <fmancera@suse.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Felix Maurer (2):
>    hsr: Set equal MAC addresses on port A and B for HSR
>    hsr: Remove second MAC address from node table
> 
>   net/hsr/hsr_debugfs.c                         |   9 +-
>   net/hsr/hsr_device.c                          |  23 +-
>   net/hsr/hsr_forward.c                         |   8 +-
>   net/hsr/hsr_framereg.c                        | 250 ++----------------
>   net/hsr/hsr_framereg.h                        |  14 +-
>   net/hsr/hsr_main.c                            |  18 +-
>   net/hsr/hsr_main.h                            |   5 +-
>   net/hsr/hsr_netlink.c                         |  18 +-
>   tools/testing/selftests/net/hsr/hsr_ping.sh   |  33 +--
>   tools/testing/selftests/net/hsr/hsr_redbox.sh |  13 +-
>   .../testing/selftests/net/hsr/link_faults.sh  |  26 --
>   11 files changed, 62 insertions(+), 355 deletions(-)
> 
> 
> base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
> --
> 2.55.0
> 

