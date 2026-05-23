Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659A3195FA
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554207; cv=none; b=X9znBgb0lw6/ZZsBGyW1/859h7wOlivAfz5lGfBUHf0iH9Ie/fU0grUPEDSnhleXXVtqIPq0HyPdjsfUfmKX/EHX/0blWRRT1fszDm8L0ennHiEwrMCOcLewKqqUoh6UHvmX2cQ1o0B1/VrVGnFaPaH7rWsQg7la7O22Oz/2aVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554207; c=relaxed/simple;
	bh=uL/GSy/4G1kddyWzvQwCkODqz5Q0fmwGeI3mzKoC8qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQN14qQmlRcTLnok+brieNfia4Gy/+ZIsvKFpLFpxjIKgtVghZ+9TQ2kYklehV2jFjeMa06pcTf8AI8WpphoRrqk2ar76rREYODcAT7nN56co+W8Bg4gWuRIcdhs/vqFRB/pH71OTSpR9wZP9+wuxIKlnL1KO+gx/3fXa+U45DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2FsLWUtm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LI1OL268; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2FsLWUtm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LI1OL268; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2FsLWUtm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LI1OL268";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2FsLWUtm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LI1OL268"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B62F96772E;
	Sat, 23 May 2026 16:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779554204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYdi17A2OVq3cfx9eNeME4CnZMn3rzio6O6dOXtzgKE=;
	b=2FsLWUtmCt7++8iPHKt+P6CFjK3H4q1ehVZFQ00cbUelH78oOwmV9GcK5OEg0vzwLr6F/S
	8PHut5MT10v1BPcJqd0coO1IfuUpkMVAWi6HilVrtp5R0RaulqQrYnNpfsEmsuydVJg1SS
	e4IG86OGR0dDnHnEg+7rk764SvLooNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779554204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYdi17A2OVq3cfx9eNeME4CnZMn3rzio6O6dOXtzgKE=;
	b=LI1OL2687IfK86f2MfsjxvYPB3tKkPV8YtOKokPPll79O9YpTr+ML1cwkHodGoxcNdFN5j
	u6iSnLSbTcRI0CDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779554204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYdi17A2OVq3cfx9eNeME4CnZMn3rzio6O6dOXtzgKE=;
	b=2FsLWUtmCt7++8iPHKt+P6CFjK3H4q1ehVZFQ00cbUelH78oOwmV9GcK5OEg0vzwLr6F/S
	8PHut5MT10v1BPcJqd0coO1IfuUpkMVAWi6HilVrtp5R0RaulqQrYnNpfsEmsuydVJg1SS
	e4IG86OGR0dDnHnEg+7rk764SvLooNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779554204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYdi17A2OVq3cfx9eNeME4CnZMn3rzio6O6dOXtzgKE=;
	b=LI1OL2687IfK86f2MfsjxvYPB3tKkPV8YtOKokPPll79O9YpTr+ML1cwkHodGoxcNdFN5j
	u6iSnLSbTcRI0CDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E21C7593A8;
	Sat, 23 May 2026 16:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nSzIMZvXEWpOKQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 23 May 2026 16:36:43 +0000
Message-ID: <e29caf20-8652-4747-8cb4-636c63d0e4e1@suse.de>
Date: Sat, 23 May 2026 18:36:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] net: hsr: require valid EOT supervision TLV
To: luka.gejak@linux.dev, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Felix Maurer <fmaurer@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260523130420.62144-1-luka.gejak@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260523130420.62144-1-luka.gejak@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linux.dev:email,suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Flag: NO

On 5/23/26 3:04 PM, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
> 
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT with
> a length of zero.
> 
> Assisted-by: Gemini:Gemini-3.1-flash
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
