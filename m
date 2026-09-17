Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918CD4B0CA0
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642993; cv=none; b=DnWalf3jiWV/gFPaqBlaxVza0BYILjynTnxmNzzPDxB0SxRX+cPvKultKvkYkWIiIZlH7XBF8VHFCIzZF/hbrh9JMOg/CMBKxrcX0R5u89pLEomVy13W5y4oPffE4ND4I2akgDxeHN3HxUsucGQcJslJL1pfe4QqH/qyMKjA7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642993; c=relaxed/simple;
	bh=VTICJhJ8zL+Mo8mGHQc1kAY4YNQpJFBcWN+AssOjL0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCJ/60p3/GmcMf9CtK94MiQdVgQT4QoMY4a0J5ToAcoCNM7Sd+UNbU9F+96SY/N76b/qj4HSwPGC0I3dOY7OCqc+aH/DoYMQa5QV9wcRYHoTqrTKPsrJufoZ3iaX2rn5gxTmfAwQ+6bL31cuBA/6DIHS9PvUURWl68btNtPXSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CEq/9QpK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NQp3dSqU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zZOlZEag; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tRz4+phZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CEq/9QpK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NQp3dSqU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zZOlZEag";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tRz4+phZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DC2221C55;
	Thu, 17 Sep 2026 11:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789642977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjuot2nlbAZYHyvdl6NethVS3DdZicBiYBn+a/Qr3E8=;
	b=CEq/9QpKYolz9kAGg1q+blMkerooaqWM/UGKtnRYfHkWPGX3akPtme30Syv/LCGJ7TFcGz
	ECVNNVM1o1NlwiGvsXybCHG11FDVWwwvbxE8SjBj/ojIlcT0I5l6Xrjensxjwen2Q1Mqgd
	DqDYg0lJMcTV9ctswgvIREWvDiE2RDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789642977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjuot2nlbAZYHyvdl6NethVS3DdZicBiYBn+a/Qr3E8=;
	b=NQp3dSqUklQC0FgQJQ3vCdwaLiGHeyy+1ZOx6EaAG0hKfEweiflh4O52g4VO4D6oZFwsTn
	44oNcXLQI0adOzAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zZOlZEag;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tRz4+phZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789642973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjuot2nlbAZYHyvdl6NethVS3DdZicBiYBn+a/Qr3E8=;
	b=zZOlZEagM928O1Gaal5LmfumeqSGSvbnS1Ff5gj9eBUwaBgJSIpNoa8STwbk7z61u5gHl0
	x9sk121FxxamWN7WayU19q0hKGlRmJJDiaBuSWfYyQR7o/GwjOIGDVCNv+SyC23xWJWZ/C
	20ZCUN8Arc5WZ+ouT7arJTV4042/LNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789642973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjuot2nlbAZYHyvdl6NethVS3DdZicBiYBn+a/Qr3E8=;
	b=tRz4+phZ4sagrjYDFXb49BAI0/hU1GCq4+XcMBoU2mXo1y/BYUX/QPlotWwNdH7qdeZjku
	d3VkwKNqBSduQrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09F8013786;
	Thu, 17 Sep 2026 11:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3moCNdzIq2pPFQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 17 Sep 2026 11:02:52 +0000
Message-ID: <af33b16c-fe84-4319-a17c-3880fb6c8ca5@suse.de>
Date: Thu, 17 Sep 2026 13:02:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] selftests: net: add IPv4 and IPv6 address
 order check
To: =?UTF-8?Q?Martin_Jab=C5=AFrek?= <martin.jaburek@suse.com>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
References: <20260914065848.10518-1-martin.jaburek@suse.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260914065848.10518-1-martin.jaburek@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8DC2221C55
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 9/14/26 8:58 AM, Martin Jabůrek wrote:
> Introduce the following new tests: `ipv4_verify_same_scope_addr_order`,
> `ipv4_verify_inter_scope_addr_order`, `ipv6_verify_same_scope_addr_order`,
> `ipv6_verify_inter_scope_addr_order` to check the ordering of a
> set of IP addresses after being inserted.
> 
> The implementations of these protocols are inconsistent
> in regard to address ordering. IPv4 addresses stay in the
> same order as inserted while IPv6 addresses appear in
> reverse order. This inconsistency has prompted attempts
> to unify the ordering, so both protocols act the same
> (as IPv4). This however caused user-space regressions in
> certain applications, which relied on the order as it
> was prior to the change (particularly NetworkManager).
> A similar inconsistency occurs when inserting different
> scope addresses, where IPv4 puts link local ones before global
> and IPv6 does the opposite. Attempts were already made
> to unify this also, risking further regressions.
> 
> The addition of these tests aims to consolidate current
> behaviour to prevent regressions in the future.
> The expected behaviour is the initial one, where each
> protocol acts differently. The same goes for inter scope
> addresses.
> 
> Conversations detailing the decision processes for creating
> these tests are linked below.
> 
> Link: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
> Link: https://lore.kernel.org/netdev/20260529112357.5079-1-fmancera@suse.de/
> Link: https://lore.kernel.org/netdev/20260721090114.GA2510713@shredder/
> Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Martin Jabůrek <martin.jaburek@suse.com>
The comments are a bit verbose IMHO but given that this already caused 
confusion it is likely to have it well documented on the tests.

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
