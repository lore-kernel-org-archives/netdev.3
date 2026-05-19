Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6C3DA7CD
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177799; cv=none; b=j4tN7qof0xZVxF4rfEMq0Hry/D8u2MyvqclXFLgMmNKLU+1+XUiMBHq5E4slEoWJMWCUu8IOC2B1L8CHalx/6e7qTbEBF/mcVGNkf78yaRnMOw/JGgtYMZWVj73xeapa08XVLHPnTeN9DHA1zijoSEpOjbzSJjwl7tCRt0pH4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177799; c=relaxed/simple;
	bh=ktgZx5lF0h915wSIOcwByhmVMLhsCSbs+u1kHLKNjdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB74kewWJ4cQXnaH6TtcUIW5HcQXUhLtFjtSgZUeOS0jxGk/oxKjskZ3UTOiVutgDNK9hVdHADZgyR13h91KDdtNM3ImCu/LpkXxG64IS018FBYB/zyLzdMe67gOoO8f0lLIU1kAgwIKgP2Yg1HrxLzEw1QtN1AZ13D4X+WVzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EtBeuN6s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A6ShaazL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vB4ii3sw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vk7m+Dco; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EtBeuN6s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A6ShaazL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vB4ii3sw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vk7m+Dco"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74A4067014;
	Tue, 19 May 2026 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q9lwj3nnlakW5KTMI7fuN3USfvSzP05/I1UZPbsbVk=;
	b=EtBeuN6sMsZjzFbbMK2RywnsywoYKYoBaSV+CK0S3E0+HPQyLA3P3Od3DFC6p+V0/iT2Bh
	ac/+9P79e7vHqvmkP/XyYhTqSx6+nemIowzwVjBYB2JJu9n/mP3PxMSVH5RJ6sAHI/ouNv
	sW/9GOI3/LgQnzN+Xa0Zk0MgPaJN8FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q9lwj3nnlakW5KTMI7fuN3USfvSzP05/I1UZPbsbVk=;
	b=A6ShaazLO+c6uvEMD7VD5cBoq66pPid8Dj0hEUESZK+R5Ej2ASB5NOZdvW83nti3kLwa8u
	MoZGoSgn2UM/3RBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vB4ii3sw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vk7m+Dco
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q9lwj3nnlakW5KTMI7fuN3USfvSzP05/I1UZPbsbVk=;
	b=vB4ii3sw2fDcdVt8rtp+d+33zCoZOZaB+VjTBSlTHPMe1jLBZ/7Yf2xJsgqnw6PXFq0+km
	Py5Y8TcaGHa+xqSabmAsVyipMjXSYC81uSr1ImR1AqN2nv6UX8dh4l/gK4hGi2O7rMjskE
	WV/jSOWwZ6Eqz9OHIeGB48jL3MEcNNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q9lwj3nnlakW5KTMI7fuN3USfvSzP05/I1UZPbsbVk=;
	b=vk7m+DcomvzmFGfUK7f6x/OzezLyzZR15fbTFl5uG/Fn4JRr5922wm9Qy16tnj/KQtKLOO
	7+Vzb+cGhWb49ZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EE70593A8;
	Tue, 19 May 2026 08:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bju+Ej0ZDGrFcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 08:03:09 +0000
Message-ID: <773a2f6f-5e58-4929-ba7b-d91042475e4f@suse.de>
Date: Tue, 19 May 2026 10:03:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/7] net/handshake: Verify file-reference balance in
 submit paths
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-7-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-7-4bbcb7e62fda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,oracle.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 74A4067014
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 5/18/26 20:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The new file-reference contract on struct handshake_req is silently
> breakable: a missing get_file() at submit or a missing fput() on an
> error path leaves the file leaked but does not crash the test, so
> the existing absence-of-crash checks pass either way.
> 
> Snapshot file_count(filp) before each handshake_req_submit() in
> the submit-success, EAGAIN, EBUSY, and cancel tests, and assert
> the expected balance after submit and again after cancel. The
> already-completed cancel test also asserts the post-complete
> balance, which pins down that handshake_complete() drops the
> reference and that the subsequent cancel does not double-fput.
> The destroy test gets the same treatment before __fput_sync(),
> which double-checks that cancel's fput() ran and the only
> remaining reference is the one sock_alloc_file() established.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/handshake-test.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
One wonders why this is not part of the kunit test suite.
But that's probably neither here nor there.

So:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
