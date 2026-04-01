Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480483D4126
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037135; cv=none; b=l8tqpOsZ7NPU3cJEqrI+XmnavG/yGD1sTo840KRgBaGtheVRpQepdNDeyJDrfWV/YFGAdBIyh9Cg/iSLHeh+FKha54sGRdiDp7KvUuEbb1H3SPyqwcjQrZ01jw0ClNk2ft98XAWTLijSbUccUc38kRT7JAtaxPLLRAlrIDl2AXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037135; c=relaxed/simple;
	bh=9qovDB0guUZdmhPbyZjL5wA5K6/kxfkUgaq70GkbiTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXrFHY5vu4ncb+QJJIYujlhB/jdGzqXeQgiDEzju6VSkU0pAblfwSZKqQc3ByN8syvfRv7auxvklYXqGM6yQfDHFolz/IZ51DBAkfOa2dO1GF7eEiQCMUcKbufKSTt4DxLSgPaMKc2FRHEFU+wdXsZ6NJlzvYk1qWwdZk0DvPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IzuM8+ZT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4VtS8baL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fDlDED2+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UknohPCx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IzuM8+ZT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4VtS8baL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fDlDED2+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UknohPCx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 251805BD79;
	Wed,  1 Apr 2026 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775037129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GFLnsCtNPXBf1I3T7S02bJakOZhy/ZgQ3XTutmlfgc=;
	b=IzuM8+ZTdbzukug+FwHjwsOICm62WjvKMaoQhN/4IuCWL/0G6pXj2GHQPnIljDzN6LgFNh
	gJRvDszUqUvUH1T3SYSbCLgssepPUI2L8n70ZjuqIISqJup7n0d77wgfgE/lJZhoZ1rBFE
	hJtGfleZWjKDkVVtowh9WAlnW5BQarw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775037129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GFLnsCtNPXBf1I3T7S02bJakOZhy/ZgQ3XTutmlfgc=;
	b=4VtS8baLHPDAEfrZ6pRnJx8XNKwvhiVkAFpgxuN9FE9SgdQ31iQQ+XgCjhrCSrggxYFFI6
	/mHXEJdO9f51W1AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fDlDED2+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UknohPCx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775037128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GFLnsCtNPXBf1I3T7S02bJakOZhy/ZgQ3XTutmlfgc=;
	b=fDlDED2+80Ty0Fwvn4i3wYwm1KtO6SxdZ16GgIso+cr5zfChNJpYC8gBBYthhbwtQb1Zsf
	95uL8sf59PMjxrqC5V4cSn2SOk3C6QM7g50aeReTN33LMWn4QvbOoQVFjZtCSg30WSSGi3
	gHDb/16/V6HaLbPjSnIgIc9655hRzNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775037128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GFLnsCtNPXBf1I3T7S02bJakOZhy/ZgQ3XTutmlfgc=;
	b=UknohPCxXHkrznxxTVg2cAbvVgwqE4+UpwIJy8YlzLkiVaq+b+m6unjhqUaMRsn2cxL1Nf
	toBJmJwaClnXIZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 986844A0B0;
	Wed,  1 Apr 2026 09:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dC/1IcfqzGmjXwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 09:52:07 +0000
Message-ID: <4549f521-6395-4c26-921e-eaead7248a36@suse.de>
Date: Wed, 1 Apr 2026 11:52:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision
 TLV
To: luka.gejak@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
References: <20260401092324.52266-1-luka.gejak@linux.dev>
 <20260401092324.52266-2-luka.gejak@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260401092324.52266-2-luka.gejak@linux.dev>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 251805BD79
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 4/1/26 11:23 AM, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
> 
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> with a length of zero.
> 
> Reviewed-by: Felix Maurer <fmaurer@redhat.com>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---

Hi,

This has not been reviewed by Felix. Felix provided his Reviewed-by tag 
for the v1 which was completely different than this.

Revisions of this patch:

v3: https://lore.kernel.org/all/20260329112313.17164-4-luka.gejak@linux.dev/

v2: https://lore.kernel.org/all/20260326154715.38405-4-luka.gejak@linux.dev/

v1: 
https://lore.kernel.org/all/20260324143503.187642-4-luka.gejak@linux.dev/

Are these contributions LLM/AI generated? I believe so based on the 
email history.

AI generated review on rtl8723bs: 
https://lore.kernel.org/all/B2394A3C-25FD-4CEA-8557-3E68F1F60357@linux.dev/

Another AI generated review on rtl8723bs: 
https://lore.kernel.org/all/3831D599-655E-40B2-9E5D-9DF956013088@linux.dev/

Likely an AI generated review on a 1 year old HSR patch: 
https://lore.kernel.org/all/DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev/

If these are indeed, AI generated contributions or reviews they should 
be disclosed beforehand. Also there is the Assisted-by: tag. Also note 
that developer must take full responsibility for the contribution which 
means understanding it completely.

https://docs.kernel.org/process/coding-assistants.html#signed-off-by-and-developer-certificate-of-origin

Thanks,
Fernando.
