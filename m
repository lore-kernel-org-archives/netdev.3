Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21F389102
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114788; cv=none; b=YxjVb3a31LFISHNCtLfY9OEHZSFGdA0HNVvReyRKS+m8IkeOyJYjU9J/zIle9WvVnFHGnnGTvuxfrxSdN9SZkK23x6iK1dQBweQAGC/QFYwEX7T46ej9ojdwcJuyJNy2VNITqTSW8QYzbvkGw7rArmTKHSxF0uckJjQTAfT+HXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114788; c=relaxed/simple;
	bh=EzzNJROCVpXXtgj1qqAdUzjKzDi3tyrjV5f5Kb53Knk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nk64/nu3wSoK4if1kblLcFs29Bmgz7DzmJR8W0+YE42xSMqJSGvxSxt/EgyqIMwOxPPAR+MA5YSMvmDzoPel4FxKchrNQVtjbJnewMokq6m1D05da0gsy6/ovR1LmXHxDQEaz7PR3HsZAJ+8+ZumRvhQ2YkBG45cgfkwXbnkWqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hoqfv21U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GD0qN7Fx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hoqfv21U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GD0qN7Fx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hoqfv21U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GD0qN7Fx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hoqfv21U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GD0qN7Fx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C10DA5BD36;
	Thu,  2 Apr 2026 07:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775114785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5ZVrcfyKGLY6sqPCsrPpAw1NcYSEOMbqKtcTCumZApM=;
	b=Hoqfv21URcIi6s/Tv2jy+naFZbwyFoA3GqWI1mCgEzSFTAfq4/jgCCE23nRAKtklB41LWC
	vdv6bBumTAzW3dSujOQuhglDQr3DZowq6mRPCKF2uLR9iF/98HG3rAs/qWWd3PSdVVtFoY
	V+3rQR1srxArF430G/l3X8Ww3PRJWuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775114785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5ZVrcfyKGLY6sqPCsrPpAw1NcYSEOMbqKtcTCumZApM=;
	b=GD0qN7Fx65GX90kf9TSNqyt5pqIbxogVX4zY4BgwTEci13VpaRFNVq4UoP/tZUcfb9qaeg
	Ef6mVEakG0fO6uDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775114785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5ZVrcfyKGLY6sqPCsrPpAw1NcYSEOMbqKtcTCumZApM=;
	b=Hoqfv21URcIi6s/Tv2jy+naFZbwyFoA3GqWI1mCgEzSFTAfq4/jgCCE23nRAKtklB41LWC
	vdv6bBumTAzW3dSujOQuhglDQr3DZowq6mRPCKF2uLR9iF/98HG3rAs/qWWd3PSdVVtFoY
	V+3rQR1srxArF430G/l3X8Ww3PRJWuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775114785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5ZVrcfyKGLY6sqPCsrPpAw1NcYSEOMbqKtcTCumZApM=;
	b=GD0qN7Fx65GX90kf9TSNqyt5pqIbxogVX4zY4BgwTEci13VpaRFNVq4UoP/tZUcfb9qaeg
	Ef6mVEakG0fO6uDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F2814A0B0;
	Thu,  2 Apr 2026 07:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qROtBCEazmn5agAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 02 Apr 2026 07:26:25 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	petrm@nvidia.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kees@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 net v3] ipv4: nexthop: avoid duplicate NHA_HW_STATS_ENABLE on nexthop group dump
Date: Thu,  2 Apr 2026 09:26:12 +0200
Message-ID: <20260402072613.25262-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Currently NHA_HW_STATS_ENABLE is included twice everytime a dump of
nexthop group is performed with NHA_OP_FLAG_DUMP_STATS. As all the stats
querying were moved to nla_put_nh_group_stats(), leave only that
instance of the attribute querying.

Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
v2: patch added
v3: no changes
---
 net/ipv4/nexthop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index c942f1282236..a0c694583299 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -902,8 +902,7 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 		goto nla_put_failure;
 
 	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
-	    (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats) ||
-	     nla_put_nh_group_stats(skb, nh, op_flags)))
+	    nla_put_nh_group_stats(skb, nh, op_flags))
 		goto nla_put_failure;
 
 	return 0;
-- 
2.53.0

