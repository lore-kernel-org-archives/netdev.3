Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62641C2E3
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118729; cv=none; b=jOE7OSOktEyvWiRWOzg9O+hLpNcbs2U1e8PZ+RxqEC0y9mdZftJS1/h+wJl+bicSvC38sHOxdlUQ4UGZ2SYeSXmSnU5C8ljLWMC333S4ow0R8QepGJxn9IGYaM5mj6qSlbeg9nZaMvK0NVe56M4Ghz28yoz7owsB5YNI466rrZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118729; c=relaxed/simple;
	bh=kPHygWe2jbtSUP7zW5kgWVyEx1bg3NULJKIn+Ov37sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oZE7vWRvDYuFX5K+6n4OPez/Ovlw8kr2q4I4q/jxYSDLGTsKZ7ncZbi5SdC8lQCbSh7k8zxhNAedFYdROjOAmlHHverKhlTRyWNpKN5lWPPlIjDtbsucxj1QPPnMHmCH2r5dQ/FF5ft+vBjIAtFI2AZDWXTPsVvHWDRyA+H7Kys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QYDBiJUO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DlFZsMlf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QYDBiJUO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DlFZsMlf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QYDBiJUO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DlFZsMlf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QYDBiJUO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DlFZsMlf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C79981FA90;
	Thu, 26 Feb 2026 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772118722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdufMlCZQDp9ZXMcX56HdtTjDnN3EG8pEvb9VFS/2YI=;
	b=QYDBiJUOj0+MrhAnzP+aa/DRAWjZv1B6WCYhwsqZkb4dcMLrPzGG6ah9hZDU3bcsbSMbEQ
	8peAjDoetMTds8elsrwxnC1a8WbZqZfaqXJeAXM1CMpmgyf+8+PxMoemSksk7Q8CMAdzHN
	1W++k3/zYh+u/rDJqSYQM5rv3r47Cac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772118722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdufMlCZQDp9ZXMcX56HdtTjDnN3EG8pEvb9VFS/2YI=;
	b=DlFZsMlfI9xCEro4v/rlT2MK5XcHNhllExlqNuH0OIe9rPyW2F2+w98D5iogSXXeUGka4S
	bD+2hPQMASpapeBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QYDBiJUO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DlFZsMlf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772118722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdufMlCZQDp9ZXMcX56HdtTjDnN3EG8pEvb9VFS/2YI=;
	b=QYDBiJUOj0+MrhAnzP+aa/DRAWjZv1B6WCYhwsqZkb4dcMLrPzGG6ah9hZDU3bcsbSMbEQ
	8peAjDoetMTds8elsrwxnC1a8WbZqZfaqXJeAXM1CMpmgyf+8+PxMoemSksk7Q8CMAdzHN
	1W++k3/zYh+u/rDJqSYQM5rv3r47Cac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772118722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdufMlCZQDp9ZXMcX56HdtTjDnN3EG8pEvb9VFS/2YI=;
	b=DlFZsMlfI9xCEro4v/rlT2MK5XcHNhllExlqNuH0OIe9rPyW2F2+w98D5iogSXXeUGka4S
	bD+2hPQMASpapeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9796C3EA69;
	Thu, 26 Feb 2026 15:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T/XUIcJioGlJSQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 26 Feb 2026 15:12:02 +0000
Message-ID: <d71fbf78-4950-42c1-b941-b6356f42c74e@suse.de>
Date: Thu, 26 Feb 2026 16:11:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Kernel Panic in br_do_suppress_nd when ipv6.disable=1 (NULL
 pointer dereference)
To: Guruprasad C P <gurucp2005@gmail.com>, netdev@vger.kernel.org
References: <CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C79981FA90
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/26/26 12:14 AM, Guruprasad C P wrote:
> We have identified a 100% reproducible kernel panic in the bridge driver 
> (|net/bridge/br_arp_nd_proxy.c|) on kernels up to at least 5.15 and 6.x.
> 
> *Description:* The crash occurs when the kernel is booted with | 
> ipv6.disable=1| and a bridge port has |neigh_suppress| enabled. When the 
> bridge receives an ICMPv6 Neighbor Solicitation, it attempts to perform 
> a lookup in the neighbor table via |ipv6_stub->nd_tbl|. Because IPv6 was 
> disabled at boot, |nd_tbl| is NULL, leading to an immediate dereference 
> panic.
> 

This is a nice catch. The key here is that inet6_init() is exiting 
before ndisc_init() is called.

Hm I wonder if there are more parts of the kernel where this might be a 
problem. I noticed several uses of ipv6_stub->nd_tbl that relies on 
IS_ENABLED(CONFIG_IPV6) check..

I am writing a patch for this.

Thank you!
