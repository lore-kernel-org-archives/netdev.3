Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21186390998
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133783; cv=none; b=JYC8hjuCdfPdqTvTVLmXOhrJUntHEBIO6eRMrNJMraWlDpak00FHZ2zt2YfR990kkB8DAcjF5LjH97tSYd9RcT1/+fPw9YHlX1KjoP89JNfOqIcicgG5jiFSZ3FxZdVqxeOyfufdzJSu812BvIogbwFqDggZeTjkLMnsQ3re460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133783; c=relaxed/simple;
	bh=tFRJSct/pYypj6OvOz88waY2/GRnWUaSP9gqSDW9880=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3l91Z0jRHgR5Z8w7LlwA6hVwNyX4nb2gfBLUoxGEGmnRn0qdRcjy1bZRGZXII9WzS6TVqWD1VAcCeEHXeDFUoaltkWcBCW7Yaf6YQJOly+DiCfkOslSC7p/RbKd6VD/4trPa6W35P1yBw4vS3nhUdM/B6Oa6a1gepLtlaOnijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zDu26Tlp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hufZaM2H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zDu26Tlp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hufZaM2H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zDu26Tlp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hufZaM2H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zDu26Tlp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hufZaM2H"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3C6C7081F;
	Mon, 22 Jun 2026 13:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=zDu26Tlp9Stymlh4txFDYNZS7ByGIp2qd43qGjJYMtJTAinEUF1e2KtuxR/w7dVMuAWPc8
	9oOXUKjsnoMuqQHe+H/aFUXPtYY+yv5KLKVibxIo3v8306jMLNquyNFJRHkRbPHPslHScb
	8Hx22Hw+HufEwTjENNDtr46PTiFlg3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=hufZaM2Hp1dBsSwgGXxquNqBHym5tEN0u3uqkkfFSJeYLlofTv3UgU4pUm1aj7S/6OUgJr
	DIlyZiB5X20JtEBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=zDu26Tlp9Stymlh4txFDYNZS7ByGIp2qd43qGjJYMtJTAinEUF1e2KtuxR/w7dVMuAWPc8
	9oOXUKjsnoMuqQHe+H/aFUXPtYY+yv5KLKVibxIo3v8306jMLNquyNFJRHkRbPHPslHScb
	8Hx22Hw+HufEwTjENNDtr46PTiFlg3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=hufZaM2Hp1dBsSwgGXxquNqBHym5tEN0u3uqkkfFSJeYLlofTv3UgU4pUm1aj7S/6OUgJr
	DIlyZiB5X20JtEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16746779A8;
	Mon, 22 Jun 2026 13:09:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MOFfAgE0OWqdEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 22 Jun 2026 13:09:21 +0000
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
Subject: [PATCH net v3 4/6] ipv6: fix error handling in disable_policy sysctl
Date: Mon, 22 Jun 2026 15:08:55 +0200
Message-ID: <20260622130857.5115-5-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260622130857.5115-1-fmancera@suse.de>
References: <20260622130857.5115-1-fmancera@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
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

