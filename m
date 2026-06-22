Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1236EA8B
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133759; cv=none; b=gmDwkDejBbRYlI4hlEyBDKp7/XnQdfQB7a0IBCjsnxF2WE/YzWhxxiBd6q0O2U3mW79RnuyH9kL7AEvo8UsSIbmJ2VqDUzJwedt5tdQ72CZaJMm/UhABnXNA7aOX4jlcQedCf6AlNayUtiEF7AhrNixBfnxq//sZ1xLyX79380Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133759; c=relaxed/simple;
	bh=WG1/jTwGeKBXQjTtpyNkHPh6aDkXwA4dE7aHCHg4nak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OiJ8Gd9LIJwbnp5I3d5G8zzblug1RUOMyyaENYAusSu5gJ+lXQh6AiuZhU2T7R7044lcTawXVIFh9F1+//tZugyjoKy3cJo3dad+Zvp1aIt/tYqpAlZPw2S8NMYhdztQXSpktIWVZGG2gfpHXiC35vfbvGkcBPf2/3RpZOhl3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1c9+iaLQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ayCMR/lb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1c9+iaLQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ayCMR/lb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1c9+iaLQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ayCMR/lb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1c9+iaLQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ayCMR/lb"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31AD47081B;
	Mon, 22 Jun 2026 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5dJMNIwUvQPou0AYiyabhsqR290bf2J6JlHu0AZZZVo=;
	b=1c9+iaLQXqhhj0/2XSMYdNS3+1sXWe/QZgluwN+2rDQ21VPmzlqMPtRD8orqHKdNfey9dl
	iJvS5mtufyXtUL7rFpF6wA6oye6RNguEZ1QV24aIhB7mW+fc/eEzCyK5/xiNS95kRGzPJt
	8Ui4L06PmEG/aE26x4VO/sgvmn1Fzh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5dJMNIwUvQPou0AYiyabhsqR290bf2J6JlHu0AZZZVo=;
	b=ayCMR/lbNy5ZDQ8//jhG7AWA5wXDzqoHm72OWZxGtiqf7Z1/FrYLQVfF+0eHbYosEIFMZi
	th35REdpYp1EyxDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1c9+iaLQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ayCMR/lb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5dJMNIwUvQPou0AYiyabhsqR290bf2J6JlHu0AZZZVo=;
	b=1c9+iaLQXqhhj0/2XSMYdNS3+1sXWe/QZgluwN+2rDQ21VPmzlqMPtRD8orqHKdNfey9dl
	iJvS5mtufyXtUL7rFpF6wA6oye6RNguEZ1QV24aIhB7mW+fc/eEzCyK5/xiNS95kRGzPJt
	8Ui4L06PmEG/aE26x4VO/sgvmn1Fzh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5dJMNIwUvQPou0AYiyabhsqR290bf2J6JlHu0AZZZVo=;
	b=ayCMR/lbNy5ZDQ8//jhG7AWA5wXDzqoHm72OWZxGtiqf7Z1/FrYLQVfF+0eHbYosEIFMZi
	th35REdpYp1EyxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78218779A8;
	Mon, 22 Jun 2026 13:09:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1jkvGvszOWqdEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 22 Jun 2026 13:09:15 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	stephen@networkplumber.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net v3 0/6] ipv6: fix error handling in disable_ipv6 sysctl
Date: Mon, 22 Jun 2026 15:08:51 +0200
Message-ID: <20260622130857.5115-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 31AD47081B
X-Spam-Score: -3.01

While working on a different IPv6 patch series I have spotted multiple
minor bugs around sysctl error handling and notifications. In general,
they are not serious issues.

In addition, there is one more issue in forwarding sysctl as it does not
check for CAP_NET_ADMIN for the namespace. I am keeping that patch out
of this series and I am aiming it at the net-next tree once it re-opens.

During v3, Ido's pointed out that it is unnecessary to reset the
position pointer when the return value is negative as at
new_sync_write() the ppos is only advanced when ret return value is
positive. That means we can get rid of that operation in ipv4/ipv6
sysctls. That is going to be sent to net-next too.

Changes:
  v3: Patch 7: dropped from the series based on Ido's feedback

  v2: https://lore.kernel.org/netdev/20260620161850.7114-1-fmancera@suse.de/
      Patch 3: fix return code of addrconf_fixup_forwarding()
      Patch 5: acquire lock before calling proc_dointvec()
      Patch 7: new on this revision of the series

Fernando Fernandez Mancera (6):
  ipv6: fix error handling in disable_ipv6 sysctl
  ipv6: fix error handling in ignore_routes_with_linkdown sysctl
  ipv6: fix error handling in forwarding sysctl
  ipv6: fix error handling in disable_policy sysctl
  ipv6: fix state corruption during proxy_ndp sysctl restart
  ipv6: fix missing notification for ignore_routes_with_linkdown

 net/ipv6/addrconf.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

-- 
2.54.0

