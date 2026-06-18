Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBBF280A56
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799783; cv=none; b=Mk9HT02i63WNHHYB0dKJ9z30VSREQ62oNn7siWOQmNkijQ3yElbhA7S4CfWv9yPDucv6XyK3SXx8eTuPmwgcpa5W1ydqG8xpVxEpfRrjGI0+e9RJV8WyD/uLyfH5QBAULW531X9NnZGvAWNc7l01TG43s24EoOXW+7z53CWaz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799783; c=relaxed/simple;
	bh=tFvk8eBbLVSqOyX4dbJvqf/5brvgED4h1odvpyC5BYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/9fQYjgZn3hO7a4n11avF/msVMoeRIuMZH/GD8ny0lHGJmI/JKP9K82iqMpqS/WdqsVddRN9aLlG/lcQrr363mVVbPuZB8TiPMwldvVyX4kh5LlHkQRabvEg6KiSbFgBcbef+zayJ5tt9hxG81ariKwW98hWvjkKhkdV63hsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gKe0kovR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uyQFjjSZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bHaI6bh3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wE7zceH+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gKe0kovR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uyQFjjSZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bHaI6bh3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wE7zceH+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C5C16D48D;
	Thu, 18 Jun 2026 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+padrrOldrz3DuHu69Wsmo6J0sfc1htq4IcgT77yH8=;
	b=gKe0kovRdEK2hiq9aTxeAyXbsoMpFygKI6PHReUWfy2hpxh4t3VPVUQacoYmdnquauTyLU
	PlfWZul66ufwXzQXq58esj4CDANtNwCiTm/PriLN9e0UsCcCrPSLOiRLHu0EL7Xo8A6A1j
	1GG+v2RPXuRaA/j5r6ixhxEEjPtqEk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+padrrOldrz3DuHu69Wsmo6J0sfc1htq4IcgT77yH8=;
	b=uyQFjjSZqJmzOA52sPHSoiozZ5zOPDrO84zHbovo2vXnwTuMtgl74XiEXp7UUu240+Ty6H
	xlSUhHqnyf8DwbBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+padrrOldrz3DuHu69Wsmo6J0sfc1htq4IcgT77yH8=;
	b=bHaI6bh30/EUpsDv5YHdn/4NtwPtI3ingFPMKnzNpRbxBr3qha4obKCFqNMJj1Q2WZgPus
	v2UIh3vd42/3ohlrEGOJNudJnnGIIpsvzVa5fqoOaxcMNCkAfVTE6pKG+1bML4pSsmJbik
	2Iwv4mG+qG7SOzpsk4+ex6DZCIgJal0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+padrrOldrz3DuHu69Wsmo6J0sfc1htq4IcgT77yH8=;
	b=wE7zceH+mkufXCe115qqORY5rKbuu6egsxQ+y5ibpITUmpLtvQFZHZgvFzrN1K+FIA42Py
	Dq2Pd+JhnS9Ng6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D8D4779A8;
	Thu, 18 Jun 2026 16:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cEIxCFUbNGqCDgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 18 Jun 2026 16:22:45 +0000
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
Subject: [PATCH net 3/6] ipv6: fix error handling in forwarding sysctl
Date: Thu, 18 Jun 2026 18:22:22 +0200
Message-ID: <20260618162225.4588-4-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260618162225.4588-1-fmancera@suse.de>
References: <20260618162225.4588-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	R_RATELIMIT(0.00)[to_ip_from(RLwhz7wtk6en1e6cs856tq4oxd)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

When writing to the forwarding sysctl, if proc_dointvec() fails to parse
the input, it returns a negative error code. The current implementation
is overwriting that error for write operations.

This results in a silent failure, it returns a successful write although
the configuration was not modified at all. When modifying the "all"
variant it can also modify the configuration of existing interfaces to
the wrong value.

Fix this by checking the return value of proc_dointvec() and returning
early on failure.

Fixes: b325fddb7f86 ("ipv6: Fix sysctl unregistration deadlock")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 70058d971205..0b128b6cff60 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6370,6 +6370,8 @@ static int addrconf_sysctl_forward(const struct ctl_table *ctl, int write,
 	lctl.data = &val;
 
 	ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
 
 	if (write)
 		ret = addrconf_fixup_forwarding(ctl, valp, val);
-- 
2.54.0

