Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6F4AF140;
	Thu, 10 Sep 2026 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051872; cv=none; b=FrRShi+wAW4K2nPEe0Ilx8vQezEfoFOHPsEMJLp1Bsc/3E88HJ6LSgv0iJTE4NalSUesEgeqW3N1Nc13Ztd9nzDTaeCHh5QW2sN7sZMY+vxl3zFnVB8+s5jcfsnUHV5o8CoXu91b4kjM25YKdq5nX9DKiV+P/3WAEzh5ELSW620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051872; c=relaxed/simple;
	bh=DQ5nlfRqZE3FbyWMbdQHOrtC/do0Cfp582XSybzZF9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMGBPof4AWszuYf24ryduMo0uw57Yj/dHE4RXQ90cx3d+Nk9BSE/q/Ij3UIofwpi/kK2uvjWYRHQBB5n8Xqqr0tAyIwlGERLuqBiZtBN0JkhvrT+ow/O9+uvi5YTSeTvIU9X1vQlxd9sQfd4drN5Ahhg7LkPoi7IFid39vO4RLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Na6oLjYF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zgire3b+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M9pjZfeb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dmEzafzg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Na6oLjYF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zgire3b+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M9pjZfeb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dmEzafzg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38A6D219A3;
	Thu, 10 Sep 2026 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789051864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJiXd6b/wgtCwPyZJ4rZMSFxf8RnvD5CBeyG3dsbPU=;
	b=Na6oLjYFv2B0oEW3kwD1JJdPYhhG2x6ah9s6ZgTtkCNtl9/84E7ktObRm/JFAGHtgdvE33
	oIjePLhFTeiyMzLJH0ML2gG44HYDPgm7H1DnAyZ8BOzPNMvpYZ92eVFQTc9d7hvhqjejgs
	pvk3o0PZBLiD8t5LrFGO57Flu1O872c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789051864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJiXd6b/wgtCwPyZJ4rZMSFxf8RnvD5CBeyG3dsbPU=;
	b=zgire3b+Zfmx2YuSn622mMSktSW0IfUJUB6Lm/XfdVTekQs+qjIWD1gyzetY+j3BBXZxdP
	D5kteYVmlp2gflCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789051860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJiXd6b/wgtCwPyZJ4rZMSFxf8RnvD5CBeyG3dsbPU=;
	b=M9pjZfebxoojXGt2LXOcmS5whB0voRCuxTDeF3MwsXx0KoJPO7s+pml12tDuVY/Y/MCsT+
	CG7i1ZoVKWAwMys5KvvMr6SSjPrfjVN+0vadmRxUHmcM/mdwAzEyBT/l0l75BFljln28t9
	wNGYXij3YT55z+GVOxk21SrhAcs8acY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789051860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJiXd6b/wgtCwPyZJ4rZMSFxf8RnvD5CBeyG3dsbPU=;
	b=dmEzafzgf2mGOyfE/O/IhBzXKgU/YGiQlDUGs0JMN9rlVIK7B1AcQI+CZdxumoRjr3v9M+
	PlF7moDVoAy2HCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 698DB13180;
	Thu, 10 Sep 2026 14:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wEv2FtPDomogZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 10 Sep 2026 14:50:59 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/13 net-next] net: ipv4: make CONFIG_IPV4 boolean
Date: Thu, 10 Sep 2026 16:48:38 +0200
Message-ID: <20260910144914.8025-14-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910144914.8025-1-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLrr9ek4ud4f4qwi71m7motjzt)];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Change CONFIG_IPV4 from hidden 'def_bool y' into an exposed boolean.
This allows users to explicitly disable IPv4 via Kconfig to build
IPv6-only. The default is kept at 'INET' to prevent breaking existing
configurations.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/Kconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 51bf05d9770c..c7d36cfa4a1d 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -3,7 +3,15 @@
 # IP configuration
 #
 config IPV4
-	def_bool y
+	bool "The IPv4 protocol" if IPV6
+	default INET
+	help
+	  Support for IP version 4 (IPv4).
+
+	  Disabling this option compiles the kernel networking stack without
+	  IPv4 support, resulting in a IPv6-only system.
+
+	  If unsure, say Y.
 
 config IP_MULTICAST
 	bool "IP: multicasting"
-- 
2.55.0

