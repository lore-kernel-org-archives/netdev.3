Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082EA2EEE69
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799777; cv=none; b=rwDtDB0girrHHIwjQk1lldZlgGWbb35b1zFsbVeBPdCp1Ad4VeMJpWZ3oWGZCwIqW5A5pVoknOo/yakH3MxUYAsGQwWOobM5vW81mF0KR0JVog6gSuXJXTOaBojwB0oktU9p/Xkmh2Iqub9n25R1zz4cAOhE3ZwHX/aMrCMsDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799777; c=relaxed/simple;
	bh=tvnMHlesLyOtTrGjgTDzjdXnIGm/espYxA+sySPsa6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzXC/QdX5UlsHs95pWto1T6LGnL1DvlHGGO97EUU+JjUw9Kkjw76V6tOM6trZNDNlVi8STmxiGtyKTYSlNbk0IMA6NM98umpv3tRZ0l2rom2jqnmLmCKZOFWszYvgMa03CFv6Y/Q5YD/o7gMLv2XsQIvHXTD/wDvW9r6VTzc8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uSe+ymCk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8uyAm3i2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uSe+ymCk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8uyAm3i2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uSe+ymCk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8uyAm3i2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uSe+ymCk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8uyAm3i2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3ADB26D48E;
	Thu, 18 Jun 2026 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3hrT1aSIdHt679m3FAUXu3Xru6kf+jVWva+BDW/N6w=;
	b=uSe+ymCkBJ09ttR0Yf8+z8nLnxoQQv7dixBI6C0eqMCQgpDJzaCSytyezMUBqM5maAxKTG
	C5vxh1HCjSorlIGkk4E/WEIBy6ODQDOGQ2HYIGsh2cCmvOPIjR3Ec3vMcgQ3zbooqRxIZl
	P6gOMdx3qJRfWiJTNd+bswM4jjTpf6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3hrT1aSIdHt679m3FAUXu3Xru6kf+jVWva+BDW/N6w=;
	b=8uyAm3i2mZuhGN0GLpq1E6ABKWno80f5K+K/Nqy6r6jdSUUd4YXjI1w9IucPRqmFT+tWjy
	8OfGdVrebfqfgTAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3hrT1aSIdHt679m3FAUXu3Xru6kf+jVWva+BDW/N6w=;
	b=uSe+ymCkBJ09ttR0Yf8+z8nLnxoQQv7dixBI6C0eqMCQgpDJzaCSytyezMUBqM5maAxKTG
	C5vxh1HCjSorlIGkk4E/WEIBy6ODQDOGQ2HYIGsh2cCmvOPIjR3Ec3vMcgQ3zbooqRxIZl
	P6gOMdx3qJRfWiJTNd+bswM4jjTpf6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3hrT1aSIdHt679m3FAUXu3Xru6kf+jVWva+BDW/N6w=;
	b=8uyAm3i2mZuhGN0GLpq1E6ABKWno80f5K+K/Nqy6r6jdSUUd4YXjI1w9IucPRqmFT+tWjy
	8OfGdVrebfqfgTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59216779A8;
	Thu, 18 Jun 2026 16:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SD/AElMbNGqCDgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 18 Jun 2026 16:22:43 +0000
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
Subject: [PATCH net 2/6] ipv6: fix error handling in ignore_routes_with_linkdown sysctl
Date: Thu, 18 Jun 2026 18:22:21 +0200
Message-ID: <20260618162225.4588-3-fmancera@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80

When writing to the ignore_routes_with_linkdown sysctl, if
proc_dointvec() fails to parse the input, it returns a negative error
code. The current implementation is overwriting that error for write
operations.

This results in a silent failure, it returns a successful write although
the configuration was not modified at all. When modifying the "all"
variant it can also modify the configuration of existing interfaces to
the wrong value.

Fix this by checking the return value of proc_dointvec() and returning
early on failure.

Fixes: 35103d11173b ("net: ipv6 sysctl option to ignore routes when nexthop link is down")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c901b444a995..70058d971205 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6671,6 +6671,8 @@ int addrconf_sysctl_ignore_routes_with_linkdown(const struct ctl_table *ctl,
 	lctl.data = &val;
 
 	ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
 
 	if (write)
 		ret = addrconf_fixup_linkdown(ctl, valp, val);
-- 
2.54.0

