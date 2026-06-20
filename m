Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7A2264D3
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972361; cv=none; b=IWnsePhBpSdTBqTY+3Lj8Lr5RBnZMKyxbYhicNjJkvI+MIMgmTnXjNMxA3vk8+jLTJct0osadg3l6A9elnJITs8EFq+gYYBhbZJnUb/nCp5AkEHW5dSODpWvZeCuBUxGrbw8MNxRMVvrjL0Va8K0bjJmbomeLSQCChQKZZqp70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972361; c=relaxed/simple;
	bh=LR3fETsSIgVGFzJgv75lOCDr06gJAXwO1ewMU9kPMfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTEQ7f2W3JYtcZ72uijLOGlnyMJbuFtTAymD9wfLYsh0THhZ2WgLc4N7OhM/uks1R5GwWTWRfMssGBeS3ZqxUSADOs/Pax43dDEye9p71TQfxPPaBThZzKZr8MIwRSxjTa6JT7TaBJGu6/EVD9yq93PMGiGclS+qjiaOCU+UqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o4vH0Acr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TBV81LwS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o4vH0Acr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TBV81LwS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o4vH0Acr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TBV81LwS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o4vH0Acr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TBV81LwS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D11C75AA5;
	Sat, 20 Jun 2026 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOnqu0Zt6XD1xHin9VkqTwnNE52uLBnZJOSyuvuR1E=;
	b=o4vH0AcrFJfoIKYL0IL5z+HAT2hCQR3FrlEFCQ81wR+V+P2oIJc4+ffv9rsR6aQh62SfYy
	R+NYXyLFw1UNsg3y9Fw1QzCBZaLh69UzcPkc/MLowI40aocQ+ezB2+0qxaDqxjwWXW42Ml
	xY2u+piDLKofgFyTaHrnZtm7NVXi6AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOnqu0Zt6XD1xHin9VkqTwnNE52uLBnZJOSyuvuR1E=;
	b=TBV81LwSaYJ2l48LWPnQz7iXnaa0jyDKuNqNokPMlF1vYuAusfFtP9LYFkeKzBCrOA+IXb
	LQ2aTrvVejj9G5AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o4vH0Acr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TBV81LwS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOnqu0Zt6XD1xHin9VkqTwnNE52uLBnZJOSyuvuR1E=;
	b=o4vH0AcrFJfoIKYL0IL5z+HAT2hCQR3FrlEFCQ81wR+V+P2oIJc4+ffv9rsR6aQh62SfYy
	R+NYXyLFw1UNsg3y9Fw1QzCBZaLh69UzcPkc/MLowI40aocQ+ezB2+0qxaDqxjwWXW42Ml
	xY2u+piDLKofgFyTaHrnZtm7NVXi6AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOnqu0Zt6XD1xHin9VkqTwnNE52uLBnZJOSyuvuR1E=;
	b=TBV81LwSaYJ2l48LWPnQz7iXnaa0jyDKuNqNokPMlF1vYuAusfFtP9LYFkeKzBCrOA+IXb
	LQ2aTrvVejj9G5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D07A779A8;
	Sat, 20 Jun 2026 16:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oD3CD3y9NmogRQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 20 Jun 2026 16:19:08 +0000
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
Subject: [PATCH net v2 2/7] ipv6: fix error handling in ignore_routes_with_linkdown sysctl
Date: Sat, 20 Jun 2026 18:18:45 +0200
Message-ID: <20260620161850.7114-3-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620161850.7114-1-fmancera@suse.de>
References: <20260620161850.7114-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0D11C75AA5
X-Spam-Flag: NO
X-Spam-Score: -3.01
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLb3xxm68jmrjpif7i5fm8f49r)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

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
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
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

