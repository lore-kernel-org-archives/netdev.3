Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FA4F93A9;
	Mon, 28 Sep 2026 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623962; cv=none; b=h39yt8UlvyTvMTSdxofkivoMXMXLN9X+FF/0kAJe1cYu4I3OFFV64cmZLq0kasocGd/9kOO7BAb3MZq42bmVkaB3fEgJ6fySgKDCTflwfk2G78bnI6ugTGtWBLZivFr+KkSBefSiHAooJXVS5rxNM6s1o/8cTrW3u7L7/N8CPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623962; c=relaxed/simple;
	bh=DQ5nlfRqZE3FbyWMbdQHOrtC/do0Cfp582XSybzZF9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itMkOf243Z3/ZO2fcu+5fku28scOhzBRGlg/kbLqV+Bq8JRIIgJ3jQjpE85+V9bfG++Xk5azRONW6YG55fDgz85lSHN3M5KaqKt0xcPVzXouukBANe9rvx6RaJGEJfoJEM1TRAI57gpPxjFb57gTbtfpk7B+eN0kXPAiB1bk5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sZ6iXgk6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ISVq6SNM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CBtTsSTm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dy6NrCRx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sZ6iXgk6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ISVq6SNM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CBtTsSTm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dy6NrCRx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5DA421B07;
	Mon, 28 Sep 2026 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790623954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJiXd6b/wgtCwPyZJ4rZMSFxf8RnvD5CBeyG3dsbPU=;
	b=sZ6iXgk6CnC0OVVZZWZOKl3tuRczsNoH7qkovzMUn7FbeaepvS/BgroFPW23DDnU68cfFO
	ohLIhSCgAE02wnt15V9PZm79XLupd/btt807frPCKxpaUHdZzxdQq7ryv5ioMB4Voi9ElH
	KU43swDqqkmsQUVLiEyK+mbCxoCnplk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790623954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJiXd6b/wgtCwPyZJ4rZMSFxf8RnvD5CBeyG3dsbPU=;
	b=ISVq6SNM8BcKRGhGzDGIdF+4Hn3GuYIZ2o96Vbzu8SBJx4XvUh4db8/IreGAeV/9t1BrxU
	DfFPlYYMwkHokiAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790623950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJiXd6b/wgtCwPyZJ4rZMSFxf8RnvD5CBeyG3dsbPU=;
	b=CBtTsSTmp7aPLfbC1rUZq5Me6G5fQvdVPRh49M0mpG2J/BtSLNoEnIcGoSZfViTy49cuW4
	cnNT7g/EOG+GvVDbDJY8nS0E05Kr80DnqFZko7Xgyg6K6sOyMg2hR178VlklW4bT22hYw7
	2jBjt69uRfGb9gOc3/SZkTwwf+Ex5Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790623950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJiXd6b/wgtCwPyZJ4rZMSFxf8RnvD5CBeyG3dsbPU=;
	b=Dy6NrCRxhKnOgjSPUroEZ21lSnlG6Rk3ryS2z/EO4IJpvrUo4Rb/vhVdJ5AR4fURjfYvJj
	8n4/ARH7Vv6gOnBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D39D3133F1;
	Mon, 28 Sep 2026 19:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4RBiFn3AumpWOAAAD6G6ig:T17
	(envelope-from <fmancera@suse.de>); Mon, 28 Sep 2026 19:32:29 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Eric Dumazet <edumazet@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/16 net-next v2] ipv4: make CONFIG_IPV4 boolean
Date: Mon, 28 Sep 2026 21:30:12 +0200
Message-ID: <20260928193046.6698-17-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928193046.6698-1-fmancera@suse.de>
References: <20260928193046.6698-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLrr9ek4ud4f4qwi71m7motjzt)];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

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

