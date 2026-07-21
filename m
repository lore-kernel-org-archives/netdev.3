Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BD3BFAEF
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645243; cv=none; b=PHGGbuy3l87lXiOYQhUTjey7ubSWQ0/cK6RKyzbwNFEOdz9yUn3wk1xXLs2xtFUA+hA0YrT2BM8pjJQsAwc6UN/4h0eRX0qMpq6zy+qvL7YlyY0JtRU/aCCDezYH68JMNLbnxurKMXo0igwuhNLFkVol/eQVLIWKP+PfHj0sLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645243; c=relaxed/simple;
	bh=/Epk9BBqldD+SJsRVTdvixrJGn/Ccz4eynQRMRGA87U=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UHj5zZrbSDnCzRA30rdmye4XGDYu+cqAW1cjYa2qCCOIuZlo5fDqZljwkv9ZWZLD44r9FT5AgUkInVF7YkegHfuOw1nsHTUyXGNOemAMCelPYqSygIeTU/W30bA/2asZZ79AF7J9+nvWsAboIhxw+qxmc2GRoNFCbvnQTVxmzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P8FRlMlD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UrXAtgZV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PbLahHS+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Pta8MOd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P8FRlMlD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UrXAtgZV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PbLahHS+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Pta8MOd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2CB87A589;
	Tue, 21 Jul 2026 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784645240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJXNLBrjGs3w38rvWKID3ZJzYdlQSoHtFbkc9JdtFMI=;
	b=P8FRlMlDac5iN22KQqA/gavT+JbhpBqhQRp/fiNb921FHISnzkc7ocyWMA82Xgfq90Gvt3
	9ePDs3LjNaISHrzN5oOzauKviKgpmImMcgVmITSBUfvP/CUG/Yb5ILSc94I+Gp3oQCGYay
	VuJOSZ6ec1zYhTGxp0bM7HhB9hxsKCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784645240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJXNLBrjGs3w38rvWKID3ZJzYdlQSoHtFbkc9JdtFMI=;
	b=UrXAtgZVmS9EpvpRitLYluILvnZsfeD8WQdwKi08F8EwWf+bVbstDxlPEZpGGJByCJJS0I
	LXe7gyuO/E1CSvCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PbLahHS+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2Pta8MOd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784645239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJXNLBrjGs3w38rvWKID3ZJzYdlQSoHtFbkc9JdtFMI=;
	b=PbLahHS+JIO8FFxa55ftRMTbrK2zhuzVmvk2UH67pEtKqxkcvAv4TbTUAmSWPw5reD0tY4
	EvHbED2SgCee7lqkkmO+VB9ZQKYZHJz2NGZrnAIG6HPJf1ZySKRnrLX6WNJ1KVa++pT4aJ
	YXQ2nnEHK3l8kbsag/P9Zrq5p8MSOdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784645239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJXNLBrjGs3w38rvWKID3ZJzYdlQSoHtFbkc9JdtFMI=;
	b=2Pta8MOdCouLA0Pp3RERt7gVtSf83LKuwPyE1sdqbU3dckLmpZLUD9cjGoEotS8j8PMIIb
	MBOik6gSdB2p+hAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BB28779AA;
	Tue, 21 Jul 2026 14:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +0XiB3eGX2pEWgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 21 Jul 2026 14:47:19 +0000
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
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Wayen Yan <win847@gmail.com>, netdev@vger.kernel.org, 
 lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, 
 edumazet@google.com, andrew+netdev@lunn.ch, 
 angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <178464510579.7763.6518393222506443032.b4-review@b4>
References: <178358611790.128118.11036367713019213946@gmail.com>
 <178464510579.7763.6518393222506443032.b4-review@b4>
Date: Tue, 21 Jul 2026 16:47:13 +0200
Message-Id: <178464523384.7942.1381538265158230893.b4-reply@b4>
X-Mailer: b4 0.16-dev
X-Spam-Flag: NO
X-Rspamd-Action: no action
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D2CB87A589
X-Spam-Score: -2.51

On 2026-07-21 16:45 +0200, Fernando Fernandez Mancera wrote:
> On Thu, 09 Jul 2026 16:32:30 +0800, Wayen Yan <win847@gmail.com> wrote:
> > ip6_datagram_send_ctl() parses both SOL_IPV6 and SOL_SOCKET control
> > messages. For SOL_SOCKET messages it passes ipc6->sockc to
> > __sock_cmsg_send(), which updates fields such as tsflags with
> > read-modify-write operations.
> > 
> > The IPV6_2292PKTOPTIONS and flowlabel option paths only set ipc6.opt
> > before calling ip6_datagram_send_ctl(). If a SOL_SOCKET control message
> > such as SO_TIMESTAMPING_* or SCM_TS_OPT_ID is present, this can read
> > uninitialized sockc state.
> > 
> > Initialize the ipcm6_cookie with ipcm6_init_sk(), as the normal IPv6
> > sendmsg paths do, before overriding ->opt with the temporary option
> > buffer.
> > 
> > Signed-off-by: Wayen Yan <win847@gmail.com>
> >
> 
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> Thanks!

Now that I think about it, shouldn't this go to net tree with a proper
fixes tag?


