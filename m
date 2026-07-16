Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A537E304
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234252; cv=none; b=qfaZzDjEUy1/AUTDzFXdv1j0fO5kXl+CusU5bOFndeEUGQb0xosNLvym1PZ48ySjGEULtjsOXzJC4Bg79alt4bkwSDjXJtYhY/IoHVTyTZQMtfBedQr43Qy94lI5nyqIBAa4JSve0khTaQ4opMVjvT2UeZsA/wvsK0ObZmv633w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234252; c=relaxed/simple;
	bh=Q4SZOiHpwhwVV7RihD7wsx5sqjdHkUx68aR58QA0Ht8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYK7JC4TwhSN98tuMZjGFv6l+Td4E02byRQfAojEwbCqVuobHp3j3+YwC5he54U6JzoM5B9IBN8effIEQVZgqwkKg8hDACk86FQHP8NCUke+hOOS6QURailtU+oGolHXJXQhHHRv5w+BE44nofJkWeBvN33aLueO2OABOB4sVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i3IFLRCP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RAici/RK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i3IFLRCP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RAici/RK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i3IFLRCP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RAici/RK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i3IFLRCP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RAici/RK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60A4A3E41;
	Thu, 16 Jul 2026 20:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784234247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xISB75wvr7o0m/Jy3hLkIkWnreltUCNLswFNrQ8+E/Q=;
	b=i3IFLRCPcMW42DwNda0a5dx4M3T+kNh12y6RQRjpeSN6VTGbqZQJm+LCDc/4unqP7m8uOM
	bkfMkpcc5I3OsrfF1gmQfy8MUdu5mfkQTRXo6uzMUzEl15cvt2cEjDg8y7TU+FTvpb2xXJ
	wRD32tlkw0J9xMc66Sp84kW/Bgi76hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784234247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xISB75wvr7o0m/Jy3hLkIkWnreltUCNLswFNrQ8+E/Q=;
	b=RAici/RKrwVtNRNBc+qlnsAqd6rvaGHLhxAVVrHMRWXWeTdfBgEKYn+Chreicn6z4NTCbn
	dkoxmnXfzoX+dsDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i3IFLRCP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="RAici/RK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784234247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xISB75wvr7o0m/Jy3hLkIkWnreltUCNLswFNrQ8+E/Q=;
	b=i3IFLRCPcMW42DwNda0a5dx4M3T+kNh12y6RQRjpeSN6VTGbqZQJm+LCDc/4unqP7m8uOM
	bkfMkpcc5I3OsrfF1gmQfy8MUdu5mfkQTRXo6uzMUzEl15cvt2cEjDg8y7TU+FTvpb2xXJ
	wRD32tlkw0J9xMc66Sp84kW/Bgi76hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784234247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xISB75wvr7o0m/Jy3hLkIkWnreltUCNLswFNrQ8+E/Q=;
	b=RAici/RKrwVtNRNBc+qlnsAqd6rvaGHLhxAVVrHMRWXWeTdfBgEKYn+Chreicn6z4NTCbn
	dkoxmnXfzoX+dsDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7D20779AD;
	Thu, 16 Jul 2026 20:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m3zhKQZBWWrmJQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 16 Jul 2026 20:37:26 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 0/3 net-next] Misc. minor improvements on IPv4/IPv6 sysctl handling
Date: Thu, 16 Jul 2026 22:37:10 +0200
Message-ID: <20260716203713.17392-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 60A4A3E41
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Minor improvements for sysctl proc handlers of IPv4 and IPv6, they were
found while working on [1] and [2].

[1] https://lore.kernel.org/netdev/20260712013941.4570-1-fmancera@suse.de/

[2] https://lore.kernel.org/netdev/20260622130857.5115-1-fmancera@suse.de/

Fernando Fernandez Mancera (3):
  ipv4: remove unnecessary reset of position pointer
  ipv6: remove unnecessary reset of position pointer
  ipv6: add CAP_NET_ADMIN check for forwarding and force_forwarding
    sysctl

 net/ipv4/devinet.c  |  4 +---
 net/ipv6/addrconf.c | 31 +++++++++++--------------------
 2 files changed, 12 insertions(+), 23 deletions(-)

-- 
2.55.0

