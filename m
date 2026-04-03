Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D2F1F7569
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220008; cv=none; b=fcdeue1KzVYdaoC6qjrh4xIJwRUjnTRttZlh7B8ilbsWzjAFb1g8WDr0V+gRJ1PClBKdKMNIleHSi3wruyHh5lOm823Br36OTwlju3/OVPQg7qhAIA3Qlvd33BS29UjN8hIMyD9F1IHjzktm7XXG8QY9NtazzgLpcE0leiu69vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220008; c=relaxed/simple;
	bh=/jtO4z12FS8AsW3xNtoM8KOQWRJS6+aqWycqqNLrfk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6uLw+u9d4Isbed9xeo6HdAQ2bphvCoU9xKaRsKwSwhMngBegeYzUqZr+9samJ/aUrxv3EB+dDuXlSgM1gGi8HU7yg0c6y6oMlKZMfRfcQIHpEPlq/Hxe419kjBwu3kbBPpz5Jo1Tk8mqo7indJK4VfJimtyI6NWGoWVxFFMLVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jFLC3bG/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p8v2G3xl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PmRGLZbR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IR6vwyzM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jFLC3bG/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p8v2G3xl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PmRGLZbR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IR6vwyzM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D55354D2C3;
	Fri,  3 Apr 2026 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775220005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GR01uTgTC3FgLsUO0NKXWfNMhvNXhGCaofVuk7I9/Kw=;
	b=jFLC3bG/GLNzYROq4EaQceqKM2ZJfOu7PBErmcy3ZOk5A3w+GIsCp72G/TTr2Oqy0zQxer
	5NdI2o4LCemDnn20YiTGuF/8ZHDV9jQyQWWk3PdLlSn/Nm6KmOEbzlI/uHGJnT9p6tM2gO
	xbhfG8G/z8OVwcTCAzIEUg2IME2dO2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775220005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GR01uTgTC3FgLsUO0NKXWfNMhvNXhGCaofVuk7I9/Kw=;
	b=p8v2G3xl9KGDQZK/9hwBvtRAH95so699j3JTfplTnr5SE6DAlWsq7TJ2FzF8F3iLrjB9JA
	GwphTMqGetExF9AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775220004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GR01uTgTC3FgLsUO0NKXWfNMhvNXhGCaofVuk7I9/Kw=;
	b=PmRGLZbRmBwiepSDJNTBH2Oq4uqpmfDYvXiWfEW3bfc5/mvQCrXOzKKGMqusM/0h+DuGra
	ts7Ce+ptkKrK90g4lB71ue2q/SBAg5pnOJT+ZRbDrgIC+V/tL8fijByD1EiWwNJuaghAW6
	k16Uxd3w0v+b+OVz2t6XFOlmo9k0p7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775220004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GR01uTgTC3FgLsUO0NKXWfNMhvNXhGCaofVuk7I9/Kw=;
	b=IR6vwyzMDPW1Rac/ENvYt5fUi5oTrR61wDvOpMfjFPypvDHJJA3AYmnDX5p0LGSqLeCBen
	kScWZczir8ZOrwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 093984A0A6;
	Fri,  3 Apr 2026 12:40:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GQhnOiO1z2nFdgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 03 Apr 2026 12:40:03 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: acsjakub@amazon.de,
	liuhangbin@gmail.com,
	kees@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	fmaurer@redhat.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next] net: hsr: emit notification for PRP slave2 changed hw addr on port deletion
Date: Fri,  3 Apr 2026 14:39:29 +0200
Message-ID: <20260403123928.4249-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amazon.de,gmail.com,kernel.org,redhat.com,google.com,davemloft.net,suse.de,linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO

On PRP protocol, when deleting the port the MAC address change
notification was missing. In addition to that, make sure to only perform
the MAC address change on slave2 deletion and PRP protocol as the
operation isn't necessary for HSR nor slave1.

Note that the eth_hw_addr_set() is correct on PRP context as the slaves
are either in promiscuous mode or forward offload enabled.

Fixes: b65999e7238e ("net: hsr: sync hw addr of slave2 according to slave1 hw addr on PRP")
Reported-by: Luka Gejak <luka.gejak@linux.dev>
Closes: https://lore.kernel.org/netdev/DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: routed through net-next tree as the next net tree as rc6 batch is
already out and I do not think this is worth to be included in a last
call batch. Anyway, if maintainer thinks it is, feel free to apply it to
net tree.
---
 net/hsr/hsr_slave.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 44f83c8c56a7..d9af9e65f72f 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -243,7 +243,11 @@ void hsr_del_port(struct hsr_port *port)
 		if (!port->hsr->fwd_offloaded)
 			dev_set_promiscuity(port->dev, -1);
 		netdev_upper_dev_unlink(port->dev, master->dev);
-		eth_hw_addr_set(port->dev, port->original_macaddress);
+		if (hsr->prot_version == PRP_V1 &&
+		    port->type == HSR_PT_SLAVE_B) {
+			eth_hw_addr_set(port->dev, port->original_macaddress);
+			call_netdevice_notifiers(NETDEV_CHANGEADDR, port->dev);
+		}
 	}
 
 	kfree_rcu(port, rcu);
-- 
2.53.0

