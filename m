Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA439479B
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972356; cv=none; b=ExlZ/kgX9zpM0wxnmJOjKixxA0/EU8T9IAyGqPfcUUhvpRrWmVM7aTYICudtVCr5GrXRn3a8DTzDGgiuvusgYuXRqu7SM9W+XqNfj6Jaz5ztWfp1I63GKQFMtKFLVo4sux3xlYD2uuwwcDPmnM1Rlf5q5o52s9MXLN6CKJ7siwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972356; c=relaxed/simple;
	bh=9Aue9oYFiNb2KsKp2XnCcgWyVUEyGl/RQmEMHhL+atY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUEuwJzWrxVaKILaS26+DnEFSiEE+0KFIyyrI3COdFKGfu5lH7F6R+OGEhOphNZFrOpMhq31e0bXX0IM4h7BQ1cm/bm90TIcpPZeNOABcuY9VpdJxFZ+9Qt82Es8Kjq093q/mwlhoikeghzJV7mrdR6hC5wQZHsf15Q2Ne7v8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cbMgNJnh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kKAORHkv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cbMgNJnh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kKAORHkv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cbMgNJnh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kKAORHkv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cbMgNJnh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kKAORHkv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51DF0759C3;
	Sat, 20 Jun 2026 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=cbMgNJnhzrWwAS7hQAOw86Z/NbY1Q4Bm1GC7i8Oj/dRKUfLj1XzEUs988CP4oa0+iOQbYp
	26Zie9fzMp5xE9JU2RXZsmNEshK0Hhrr+ln2G53LEwNzBW+m8GuTXeQNuZ26vN4I1Ugyo9
	+x/+/+4TsfRpf97DxKl7nmxz85g+BBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=kKAORHkvw4qzE1tS+A3MWCuH6vpZo54Z1crxbWmnEcuqn743OX9H/8vOqqB1/i4KUr+8Le
	ZaZXuGgD9QKOjkCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cbMgNJnh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kKAORHkv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=cbMgNJnhzrWwAS7hQAOw86Z/NbY1Q4Bm1GC7i8Oj/dRKUfLj1XzEUs988CP4oa0+iOQbYp
	26Zie9fzMp5xE9JU2RXZsmNEshK0Hhrr+ln2G53LEwNzBW+m8GuTXeQNuZ26vN4I1Ugyo9
	+x/+/+4TsfRpf97DxKl7nmxz85g+BBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=kKAORHkvw4qzE1tS+A3MWCuH6vpZo54Z1crxbWmnEcuqn743OX9H/8vOqqB1/i4KUr+8Le
	ZaZXuGgD9QKOjkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90587779A8;
	Sat, 20 Jun 2026 16:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4EEiIHq9NmogRQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 20 Jun 2026 16:19:06 +0000
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
Subject: [PATCH net v2 1/7] ipv6: fix error handling in disable_ipv6 sysctl
Date: Sat, 20 Jun 2026 18:18:44 +0200
Message-ID: <20260620161850.7114-2-fmancera@suse.de>
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
X-Spam-Flag: NO
X-Rspamd-Action: no action
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 51DF0759C3
X-Spam-Score: -3.01

When writing to the disable_ipv6 sysctl, if proc_dointvec() fails to
parse the input, it returns a negative error code. The current
implementation is overwriting that error for write operations.

This results in a silent failure, it returns a successful write although
the configuration was not modified at all. When modifying the "all"
variant it can also modify the configuration of existing interfaces to
the wrong value.

Fix this by checking the return value of proc_dointvec() and returning
early on failure.

Fixes: 56d417b12e57 ("IPv6: Add 'autoconf' and 'disable_ipv6' module parameters")
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 1f21ccb55caa..c901b444a995 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6467,6 +6467,8 @@ static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
 	lctl.data = &val;
 
 	ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
 
 	if (write)
 		ret = addrconf_disable_ipv6(ctl, valp, val);
-- 
2.54.0

