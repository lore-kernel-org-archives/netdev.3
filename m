Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624C176FB1
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972353; cv=none; b=TnYd3Nf1aBEzgjD8eZSbXc+CaOvNj2p2ePgd153U0aHm30/bew+c6yDXLCD42XxejhnGHhlkL/7nxoAoV35so4F3zgA0LcgXe7kXmXobAzz/rYTbPlOn0WmvCZkO8DqcedGQ3Jiv6FNKnV3dysM4bETBPoKXnjyjViBDRym7N7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972353; c=relaxed/simple;
	bh=7/hratlCedENOGrHjN+Y2MAP5Z/7y4Pkz2mBjKvMTxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p26BqMPfOkg89S5fKluDt/KFgU6hxTdRuQOH00z/IE4tdU1NnkwqryCFpRNGvVX5ivMmunhDEZ0gudvT8OJYp5KXNFNp9ByCIySBggIP/n64yZi5pF2ZW8j9xi6ag1NkP/WpbFhvHtnz8OqAxkTFHcOQTga07cLcaiHGJkSI4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eNaGTRNH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/gjc3pDs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eNaGTRNH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/gjc3pDs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eNaGTRNH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gjc3pDs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eNaGTRNH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gjc3pDs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D00F6B6F7;
	Sat, 20 Jun 2026 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fVspOvob7bdad1/J/QAJRiGRGfH2ZEI+uk6WhaCcnZQ=;
	b=eNaGTRNH1KNl/xS4MCkaUk0YB3vuPVofyEKcuNc/urN21j6/dnMALIKGtmA7ste060FfJw
	AGGWjwvwLYQyE+bzLzpaJawActqv2NPxuH4vws2gQA8yUaHayP9azjn0doVpgI2fQHcNXa
	fZyGAYYcjLTNYRmhoz5bWAAS3VTuHXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fVspOvob7bdad1/J/QAJRiGRGfH2ZEI+uk6WhaCcnZQ=;
	b=/gjc3pDs8uJGtEGSvQnu/gjXB+ecefK1pGlBhq3mvQs7RpUeAqWVU+s6+lPL4aw2LxEJX9
	lZnRXVBtHMeC8JCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eNaGTRNH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/gjc3pDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fVspOvob7bdad1/J/QAJRiGRGfH2ZEI+uk6WhaCcnZQ=;
	b=eNaGTRNH1KNl/xS4MCkaUk0YB3vuPVofyEKcuNc/urN21j6/dnMALIKGtmA7ste060FfJw
	AGGWjwvwLYQyE+bzLzpaJawActqv2NPxuH4vws2gQA8yUaHayP9azjn0doVpgI2fQHcNXa
	fZyGAYYcjLTNYRmhoz5bWAAS3VTuHXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fVspOvob7bdad1/J/QAJRiGRGfH2ZEI+uk6WhaCcnZQ=;
	b=/gjc3pDs8uJGtEGSvQnu/gjXB+ecefK1pGlBhq3mvQs7RpUeAqWVU+s6+lPL4aw2LxEJX9
	lZnRXVBtHMeC8JCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75436779A8;
	Sat, 20 Jun 2026 16:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JDoiGXi9NmogRQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 20 Jun 2026 16:19:04 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	stephen@networkplumber.org,
	brian.haley@hp.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net v2 0/7] ipv6: fix sysctl error handling and missing notifications
Date: Sat, 20 Jun 2026 18:18:43 +0200
Message-ID: <20260620161850.7114-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3D00F6B6F7
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

While working on a different IPv6 patch series I have spotted multiple
minor bugs around sysctl error handling and notifications. In general,
they are not serious issues.

In addition, there is one more issue in forwarding sysctl as it does not
check for CAP_NET_ADMIN for the namespace. I am keeping that patch out
of this series and I am aiming it at the net-next tree once it re-opens.

Changes:
  v2: Patch 3: fix return code of addrconf_fixup_forwarding()
      Patch 5: acquire lock before calling proc_dointvec()
      Patch 7: new on this revision of the series

Fernando Fernandez Mancera (7):
  ipv6: fix error handling in disable_ipv6 sysctl
  ipv6: fix error handling in ignore_routes_with_linkdown sysctl
  ipv6: fix error handling in forwarding sysctl
  ipv6: fix error handling in disable_policy sysctl
  ipv6: reset value and position for proxy_ndp sysctl restart
  ipv6: fix missing notification for ignore_routes_with_linkdown
  ipv6: reset position for force_forwarding sysctl restart

 net/ipv6/addrconf.c | 48 +++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

-- 
2.54.0

