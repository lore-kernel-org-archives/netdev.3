Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DAB212D86
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972360; cv=none; b=HYIbHiNX8X3u55b2dsPi4dsUXTx/0AgJqdSWArWzGgkoQgp11H5AoI6P19eR6ZXFtde4CO9hTMBzMJH+BSgwTEauU+LFw2Qjl366MpVhokxrsBk10uia6aMeLKMoROTMGW9afQohUcwqiLjNJtdYG9l4BcGd/DmO8usZPkOAdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972360; c=relaxed/simple;
	bh=tFRJSct/pYypj6OvOz88waY2/GRnWUaSP9gqSDW9880=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKj21JaaluqrjsA/hKy+qx8IxZjWyBWqpibHiir4WeH983KdGp1F8BPzcL6uBLC0mWgfIdO0aZ8jookMAIA8BzeroMFszPIDdxCLTpBe3SM12ycJbJ/YHtp+2bmiTPB5zGu45S3a1I7yYKAQ8stQLh8xbsuro90TExgS9pL+SrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zcuq2nhT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BzAC+Rh7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zcuq2nhT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BzAC+Rh7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zcuq2nhT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BzAC+Rh7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zcuq2nhT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BzAC+Rh7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF1CA6C3A1;
	Sat, 20 Jun 2026 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=Zcuq2nhTPvPOysFl8tyhhDcf6X/0mTerUhQi2ZqNTj2gOUJnGIRaofUoQy7s1kdLip7pHF
	uNPTLS3uOXSepUR1MAdOSimfq7qwAthot1a4I8LZB9EUB+hUp7pzV8OV9UhpLR8pmVo7EE
	uWNMupVszqoCH1awjwpq/tC4OTUbw4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=BzAC+Rh7M4CN6/WlNB1bxzMDo8OM6OUbtyTtdx6+Aa4OreDo1FjB0B5fQ8LiboYRGUHQBr
	NMFi2/ixHEUdHDCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=Zcuq2nhTPvPOysFl8tyhhDcf6X/0mTerUhQi2ZqNTj2gOUJnGIRaofUoQy7s1kdLip7pHF
	uNPTLS3uOXSepUR1MAdOSimfq7qwAthot1a4I8LZB9EUB+hUp7pzV8OV9UhpLR8pmVo7EE
	uWNMupVszqoCH1awjwpq/tC4OTUbw4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=BzAC+Rh7M4CN6/WlNB1bxzMDo8OM6OUbtyTtdx6+Aa4OreDo1FjB0B5fQ8LiboYRGUHQBr
	NMFi2/ixHEUdHDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED8D4779A8;
	Sat, 20 Jun 2026 16:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sIz1Nn69NmogRQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 20 Jun 2026 16:19:10 +0000
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
Subject: [PATCH net v2 4/7] ipv6: fix error handling in disable_policy sysctl
Date: Sat, 20 Jun 2026 18:18:47 +0200
Message-ID: <20260620161850.7114-5-fmancera@suse.de>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

When writing to the disable_policy sysctl, if proc_dointvec() fails to
parse the input, it returns a negative error code. The current
implementation is resetting the position argument even if an error
occurred during proc_dointvec() and not only during sysctl restart.

Fix this by checking the return value of proc_dointvec() and returning
early on failure.

Fixes: df789fe75206 ("ipv6: Provide ipv6 version of "disable_policy" sysctl")
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d23a89b07eed..5d96cbf76134 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6769,6 +6769,8 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
 	lctl = *ctl;
 	lctl.data = &val;
 	ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
 
 	if (write && (*valp != val))
 		ret = addrconf_disable_policy(ctl, valp, val);
-- 
2.54.0

