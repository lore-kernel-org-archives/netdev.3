Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD83C81B8
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763322; cv=none; b=DTcoZg+glTdHuCpp5I011Mz8TKpSujdMjuDy7puzxHD34MN2nWDeknziwKEIAOFvQVNiRT56wf6fMbJP+C+Q8t7v3ngRmxqO9x7lhCbLGkrYHzJole7QZLghMOGleKzZLe3/1bhJgm5St4Y0f42hHUbasmygicYSWU27TZ+hB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763322; c=relaxed/simple;
	bh=ihCU/vsa6m8v3EMLeCYC9k22YD8EZr2zOYD4yZ9efFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ou4n/JuRABaKsLi82uz33KQgjXsLxcuhpr86lxu0roqZRAXPVS7AAl09QWPJ0JK98j8O0goL49kDPmXolKDSCVdOH8YGlcTNls1Zf9sqSXsoH7IIfA/prxLKICQTsIj7ckK72hj8/fhfSzElteO0RrB1DgvMa0EUGCod8nkOx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hgl2V5cx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zmHkHPmQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hgl2V5cx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zmHkHPmQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hgl2V5cx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zmHkHPmQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hgl2V5cx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zmHkHPmQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5795B5CDDE;
	Thu, 14 May 2026 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778763316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8QRaqEvtY1jqyXUTsU34hHy1dv02gsn/Zk+isg7g6Y=;
	b=Hgl2V5cxHpPjPXAJe2Wox0Vk2Dqb/CXw28zxOb66jb80CdOENLttwLD0jAmLzeaoO9aR0x
	4TarPJ2LbtVXD6lKTZEfS6kC/QkrUJoRibJxJi4htFuNSUN8PR+2mLfW0lWdULfJSL/xUC
	TF+G+9b+rdN2GHMM9MNzEhAHmihx7xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778763316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8QRaqEvtY1jqyXUTsU34hHy1dv02gsn/Zk+isg7g6Y=;
	b=zmHkHPmQ6JKjjC0srSYAZ4Nw5hPSknrWmtZhhYLu0nGds1zlM1rhZWY/VlosYJQTRS7ApR
	2D1jK9QUNYims5Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Hgl2V5cx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zmHkHPmQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778763316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8QRaqEvtY1jqyXUTsU34hHy1dv02gsn/Zk+isg7g6Y=;
	b=Hgl2V5cxHpPjPXAJe2Wox0Vk2Dqb/CXw28zxOb66jb80CdOENLttwLD0jAmLzeaoO9aR0x
	4TarPJ2LbtVXD6lKTZEfS6kC/QkrUJoRibJxJi4htFuNSUN8PR+2mLfW0lWdULfJSL/xUC
	TF+G+9b+rdN2GHMM9MNzEhAHmihx7xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778763316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8QRaqEvtY1jqyXUTsU34hHy1dv02gsn/Zk+isg7g6Y=;
	b=zmHkHPmQ6JKjjC0srSYAZ4Nw5hPSknrWmtZhhYLu0nGds1zlM1rhZWY/VlosYJQTRS7ApR
	2D1jK9QUNYims5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2C4C593A9;
	Thu, 14 May 2026 12:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W2xXNDPGBWqATwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 14 May 2026 12:55:15 +0000
Message-ID: <6755adfa-9a28-46cd-84f1-747082d0f71f@suse.de>
Date: Thu, 14 May 2026 14:55:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] net: hsr: require valid EOT supervision
 TLV
To: luka.gejak@linux.dev, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, fmaurer@redhat.com
References: <20260513182657.20346-1-luka.gejak@linux.dev>
 <20260513182657.20346-2-luka.gejak@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260513182657.20346-2-luka.gejak@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5795B5CDDE
X-Spam-Level: 

On 5/13/26 8:26 PM, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
> 
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> with a length of zero, and properly linearizing the TLV header before
> access.
> 
> Assisted-by: Gemini:Gemini-3.1-flash
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
