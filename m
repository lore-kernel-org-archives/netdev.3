Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519E4963A0
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645117; cv=none; b=fwriO8yfqLHP6t7WvOPEC0cAkQP09eS9WHmwGtT6G9f38HnM8UtF+Pf9vfCBziCJ18UPZH6rPpgih8D2cLcKQmNJD9rAy1Er8S5F2dCB/NUDzkHrn1X7BJwIxIouUM/78nFZyJ76IvGUFrBsL3hbXfXgngA3P+8svyTlBRd9MtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645117; c=relaxed/simple;
	bh=/LXzN+ULfkmRRjgnufZ3q48Bs5dEPC99K53qAqS+XGw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UVSXwuPZkdie43Ug5klXlez5jXIww+EffzcM5/2+592qoUwYITwTdXGM6xaj5ZqovB7xhF1Ov1Mw6wWZHaIxYmrpOH1xjLu1UnCXjWqpDkW9I2vFbs5YRwuR1recK9fhW1IcX7iI06SMj7LE3Ci/nzF9/AlbACGYKUFalgH1MPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c9Jw0g0T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sIj9WOHc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c9Jw0g0T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sIj9WOHc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c9Jw0g0T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sIj9WOHc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c9Jw0g0T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sIj9WOHc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40F4E3E1D;
	Tue, 21 Jul 2026 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784645113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeaBZAZ3XwgmgcJDisBPYHpbOCqquZSuzqf7qxis4Kw=;
	b=c9Jw0g0TZkfySuKCj2U33TM8FXBGScBtw1xoGpqFShIO/BuyZvcO6H0pIdXY8/ELe2WJJ+
	N3Bigi5I4UuJv056XH9Ef3ndC+AwqUqWdT8FTRthveJnguRiMDhPwrQpkXrcW3GdU6DfIe
	Epinx83cIHoFrrZv81pklPAS02bX5Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784645113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeaBZAZ3XwgmgcJDisBPYHpbOCqquZSuzqf7qxis4Kw=;
	b=sIj9WOHchd19KoKMkMTtq+/JFOFyBQ6lZ6priggYD0P+KENK9n2CanudG5+gM+OArynhSi
	/Gaw7jN0vX4qC0Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c9Jw0g0T;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sIj9WOHc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784645113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeaBZAZ3XwgmgcJDisBPYHpbOCqquZSuzqf7qxis4Kw=;
	b=c9Jw0g0TZkfySuKCj2U33TM8FXBGScBtw1xoGpqFShIO/BuyZvcO6H0pIdXY8/ELe2WJJ+
	N3Bigi5I4UuJv056XH9Ef3ndC+AwqUqWdT8FTRthveJnguRiMDhPwrQpkXrcW3GdU6DfIe
	Epinx83cIHoFrrZv81pklPAS02bX5Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784645113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeaBZAZ3XwgmgcJDisBPYHpbOCqquZSuzqf7qxis4Kw=;
	b=sIj9WOHchd19KoKMkMTtq+/JFOFyBQ6lZ6priggYD0P+KENK9n2CanudG5+gM+OArynhSi
	/Gaw7jN0vX4qC0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94BC2779AA;
	Tue, 21 Jul 2026 14:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FIt+IfiFX2oXWAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 21 Jul 2026 14:45:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] ipv6: initialize ipcm6_cookie before parsing
 control messages
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org, 
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, 
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <178358611790.128118.11036367713019213946@gmail.com>
References: <178358611790.128118.11036367713019213946@gmail.com>
Date: Tue, 21 Jul 2026 16:45:05 +0200
Message-Id: <178464510579.7763.6518393222506443032.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 40F4E3E1D
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, 09 Jul 2026 16:32:30 +0800, Wayen Yan <win847@gmail.com> wrote:
> ip6_datagram_send_ctl() parses both SOL_IPV6 and SOL_SOCKET control
> messages. For SOL_SOCKET messages it passes ipc6->sockc to
> __sock_cmsg_send(), which updates fields such as tsflags with
> read-modify-write operations.
> 
> The IPV6_2292PKTOPTIONS and flowlabel option paths only set ipc6.opt
> before calling ip6_datagram_send_ctl(). If a SOL_SOCKET control message
> such as SO_TIMESTAMPING_* or SCM_TS_OPT_ID is present, this can read
> uninitialized sockc state.
> 
> Initialize the ipcm6_cookie with ipcm6_init_sk(), as the normal IPv6
> sendmsg paths do, before overriding ->opt with the temporary option
> buffer.
> 
> Signed-off-by: Wayen Yan <win847@gmail.com>
>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
