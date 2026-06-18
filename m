Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E92E091E
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799764; cv=none; b=V9ma9hFTKCEvF578ShUoI6qDbxcisXgoUsKY4/N6QY2FhFoigIXeC7Fr6TxZz7eBHu4Nn2R5ltqrxLZZpf/lvb/A5Nm/NpbyJgDr11IKKz2tCj6Znk8PCMPYij8ILYuBrJfSr7+8DQrL3eV3+C86esfjMuJwwovqoJMUnGH2+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799764; c=relaxed/simple;
	bh=DeZY7vy0HPv+7TCzuVbQuh8QCWvkxjZ/A7rt97OaWa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwH+EIu44YXa77kewhMVjPTPVjghx32AbPSbcFmUBJYq5G5JZDfUnEbbKta4viuxQYZgziEOOzEuoaX291G/zWm6+rLq6LB9jtJtH2ydozvzf5lcHQyLp0xuHl/ILHWO+ELPcgEcxRTlxKEVyOwEm0XJwacDsKtCAMNo8ScHVJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hWeIyDmh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8x/SzGu6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AjeSmqS7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F6hU66nN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hWeIyDmh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8x/SzGu6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AjeSmqS7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F6hU66nN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5B9E6D3B1;
	Thu, 18 Jun 2026 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N583wkjT9FfAHpnTaqecd0J7emPmTiOyMIfo3A6eenc=;
	b=hWeIyDmhEra0LYF1jGA4xAnwelv+BLtbz1Gbcdlo47zPA+NYhrzk31qejKyVo9V3weiFPp
	oQ3pTElXWgrP/JaEeLC29Tfqi5kA63RLxCuVAxYAo041E4axUDO90CoM0HmUXmeUFi3Uy3
	0DwjflXT0MxwaztgEuOcEWJRJ0AmJDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N583wkjT9FfAHpnTaqecd0J7emPmTiOyMIfo3A6eenc=;
	b=8x/SzGu6Vgm23b82G11Q6UwDefvyS6v2xJstPJQ3G2aRGwzzo1ncOnja4gMLrwQGUawq6s
	r6985oJLO46W6mBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AjeSmqS7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F6hU66nN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N583wkjT9FfAHpnTaqecd0J7emPmTiOyMIfo3A6eenc=;
	b=AjeSmqS7Gy67NjrKgJ4joRncz7GhGh36pFPwSwChdsTo4e6J3DfagAVmTnnwwbZGqxnWZq
	vJS2EejMhAXJEa7vppgEm9qRi/upuHf2JrL6ah1HpsbRwws/7x9XnhXIZDvkQMW6CvLAsv
	j8gj5e51lFxu2VabUTCSQrq3a1MHasw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N583wkjT9FfAHpnTaqecd0J7emPmTiOyMIfo3A6eenc=;
	b=F6hU66nNn1k3pYoreMi3BslQVf8AXlrhN81BQFlKAovd5tx7atQ7nFlbTquWWkqHCIevUA
	3GH9DNfmfrejsMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5984779A8;
	Thu, 18 Jun 2026 16:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Hq4MEsbNGqCDgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 18 Jun 2026 16:22:35 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	shemminger@vyatta.com,
	dforster@brocade.com,
	gospo@cumulusnetworks.com,
	ddutt@cumulusnetworks.com,
	brian.haley@hp.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net 0/6] ipv6: fix sysctl error handling and missing notifications
Date: Thu, 18 Jun 2026 18:22:19 +0200
Message-ID: <20260618162225.4588-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C5B9E6D3B1
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
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

While working on a different IPv6 patch series I have spotted multiple
minor bugs around sysctl error handling and notifications. In general,
they are not serious issues.

In addition, there is one more issue in forwarding sysctl as it does not
check for CAP_NET_ADMIN for the namespace. I am keeping that patch out
of this series and I am aiming it at the net-next tree once it re-opens.

Fernando Fernandez Mancera (6):
  ipv6: fix error handling in disable_ipv6 sysctl
  ipv6: fix error handling in ignore_routes_with_linkdown sysctl
  ipv6: fix error handling in forwarding sysctl
  ipv6: fix error handling in disable_policy sysctl
  ipv6: reset value and position for proxy_ndp sysctl restart
  ipv6: fix missing notification for ignore_routes_with_linkdown

 net/ipv6/addrconf.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

-- 
2.54.0

