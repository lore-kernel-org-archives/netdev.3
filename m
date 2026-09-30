Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011E4E4C41;
	Wed, 30 Sep 2026 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776515; cv=none; b=QtixsE060kZPqcSUu0wIS0x9uAtTe2PNyxeUoCu2olUORofQd4frvbSjqufUqQGHgr+p1AMMbtKTElM1hcQAPdbR5SGH0dbio9TlBtlvsv5XZknpFYoadonuMa6+0B9qaoSsFlEywtsVlyLunLpvxzlJJrikd2fCB7GZ7KF5qc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776515; c=relaxed/simple;
	bh=wzzdE8B/7kFDE9nUu6NDUEGidOqeqgIi5+ZBPKZcdC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHMrMoeNsdHAhXBBETUzwIbcIf/xOlM45CND9IeUyQjLvtiiXHBboYP40PgVsLSY/rVHiR0tsYIKHEAHqT8qi4OD9lGBITtWCzDUnZcr8YuOJ2JpyE8Uj0TG/XevlI+zqo0zgpgaYCBFUN9eA4/fZ1CW9TDH1C4yKYfc9cBS6ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 204CC21E24;
	Wed, 30 Sep 2026 13:54:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A4C913ABC;
	Wed, 30 Sep 2026 13:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJXpHGIUvWqUTwAAD6G6ig:T17
	(envelope-from <fmancera@suse.de>); Wed, 30 Sep 2026 13:54:53 +0000
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
Subject: [PATCH 16/16 net-next v3] ipv4: make CONFIG_IPV4 boolean
Date: Wed, 30 Sep 2026 15:52:59 +0200
Message-ID: <20260930135334.4739-17-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260930135334.4739-1-fmancera@suse.de>
References: <20260930135334.4739-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 204CC21E24
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Change CONFIG_IPV4 from hidden 'def_bool y' into an exposed boolean.
This allows users to explicitly disable IPv4 via Kconfig to build
IPv6-only. The default is kept at 'INET' to prevent breaking existing
configurations.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Sashiko: the point of this is to provide a minimal build. There plenty
of features that do not work without IPv4 for now. Follow-up patches
will be sent to fix that in the future.
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

