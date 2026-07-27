Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29E376A1B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143942; cv=none; b=YS8C/iY5a6tmSPUMAugRMpCNQ0kCeYdoD9AEhoPvSB5Q0qvAXboGa8eODVUmYJpAf53oVb6xOF4LpzhY2k7DsN7n6l7MJoLTrUl+qcd/bAw47OTz9Twgjmeq6RvInBKtbcoy66M/v2+WtwrK9Jz42hCxK74o8rEzwe+20RqRBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143942; c=relaxed/simple;
	bh=iPYel44ErbBjmn6HcoGfuewgP4QQ0cMfiV1Umwuk+SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cR+XZsNL9gur4Q5ALecTxGePbErFRbXuHxzekis3eZ9LSd8R6/I4E1ISF5NuAWA5FoT8pX1R0iNFe54OqlqjMXgvEmS/W1pe/jq/K4SZTDKGFYVBt4w5sOgBD44TvFfpdpEJDe9cXnUv3nstmunVdw0GhcOBQkPoEetmF2eeYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tdyJghN2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0IUK6E23; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bu72FXzy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hkI57OkK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tdyJghN2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0IUK6E23";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bu72FXzy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hkI57OkK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C27EA4871;
	Mon, 27 Jul 2026 09:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785143934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWUmcUTRoo0ioGN7WVjDdo0SX4Qa4VD4zF+Ku/lVDT8=;
	b=tdyJghN2N65PrKpGKHAsoV3sxyl4v9FgPfKo0OkP08TUoQHL4o/dmeAYmLmBLGEDRuv1F0
	TJrWpDUJ2CjS+HdWnUdYDblSX82fPqC5Bq1PJXjKaU/IC5tuH9lRlkvhnKFheIfGS1gEGe
	iLKD8k75a4uKFrLxk3Uha7SjknAK0i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785143934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWUmcUTRoo0ioGN7WVjDdo0SX4Qa4VD4zF+Ku/lVDT8=;
	b=0IUK6E23l38hRctbWz2/Q6z5uENtuvqEwVF23DDDbeGosL6sN+WYjKxeD3OMdDbZBKSLHt
	yKm04bBXZ9GJ3uBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785143930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWUmcUTRoo0ioGN7WVjDdo0SX4Qa4VD4zF+Ku/lVDT8=;
	b=bu72FXzyCAZu+3FCacomUbtudWF9tlhgv8FDkMPL3beiuLrYJnsaUFO0jMJ659E8BObSxd
	Dep3BhbPavz8Bw2gszx+pbrv9t9wH8Tf5yeZAxX/AJOsFkdZGYK8ANz1sDnqwltuwDMjmH
	7ROKDm82bbRRZUdDAGIzomf5sJ+xXog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785143930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWUmcUTRoo0ioGN7WVjDdo0SX4Qa4VD4zF+Ku/lVDT8=;
	b=hkI57OkKBYE28D1k+B52GHVjgJ4Tk0s085XAP9pdpTX55QugEdgR6F0jvNT6z1+tkFZaI+
	BgMaF+k2J6dIoCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EE1F779C1;
	Mon, 27 Jul 2026 09:18:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8IyUDHoiZ2oVFAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 27 Jul 2026 09:18:50 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net-next v2] ipv6: remove unnecessary reset of position pointer
Date: Mon, 27 Jul 2026 11:18:34 +0200
Message-ID: <20260727091834.6645-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260727091834.6645-1-fmancera@suse.de>
References: <20260727091834.6645-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.971];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,nvidia.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

The position pointer is only advanced if the return value of the proc
handler is positive at new_sync_write(). Therefore no need to manually
reset it when doing error handling.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: The checkpatch warnings here are false positive, lctl cannot be
const in this context
---
 net/ipv6/addrconf.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f1fe9ede1edb..f6fa2715b450 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6363,10 +6363,9 @@ static void ipv6_ifa_notify(int event, struct inet6_ifaddr *ifp)
 static int addrconf_sysctl_forward(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct ctl_table lctl;
 	int *valp = ctl->data;
 	int val = *valp;
-	loff_t pos = *ppos;
-	struct ctl_table lctl;
 	int ret;
 
 	/*
@@ -6382,8 +6381,6 @@ static int addrconf_sysctl_forward(const struct ctl_table *ctl, int write,
 
 	if (write)
 		ret = addrconf_fixup_forwarding(ctl, valp, val);
-	if (ret)
-		*ppos = pos;
 	return ret;
 }
 
@@ -6462,10 +6459,9 @@ static int addrconf_disable_ipv6(const struct ctl_table *table, int *p, int newf
 static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct ctl_table lctl;
 	int *valp = ctl->data;
 	int val = *valp;
-	loff_t pos = *ppos;
-	struct ctl_table lctl;
 	int ret;
 
 	/*
@@ -6481,8 +6477,6 @@ static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
 
 	if (write)
 		ret = addrconf_disable_ipv6(ctl, valp, val);
-	if (ret)
-		*ppos = pos;
 	return ret;
 }
 
@@ -6667,10 +6661,9 @@ int addrconf_sysctl_ignore_routes_with_linkdown(const struct ctl_table *ctl,
 						size_t *lenp,
 						loff_t *ppos)
 {
+	struct ctl_table lctl;
 	int *valp = ctl->data;
 	int val = *valp;
-	loff_t pos = *ppos;
-	struct ctl_table lctl;
 	int ret;
 
 	/* ctl->data points to idev->cnf.ignore_routes_when_linkdown
@@ -6685,8 +6678,6 @@ int addrconf_sysctl_ignore_routes_with_linkdown(const struct ctl_table *ctl,
 
 	if (write)
 		ret = addrconf_fixup_linkdown(ctl, valp, val);
-	if (ret)
-		*ppos = pos;
 	return ret;
 }
 
@@ -6767,10 +6758,9 @@ int addrconf_disable_policy(const struct ctl_table *ctl, int *valp, int val)
 static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct ctl_table lctl;
 	int *valp = ctl->data;
 	int val = *valp;
-	loff_t pos = *ppos;
-	struct ctl_table lctl;
 	int ret;
 
 	lctl = *ctl;
@@ -6782,9 +6772,6 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
 	if (write && (*valp != val))
 		ret = addrconf_disable_policy(ctl, valp, val);
 
-	if (ret)
-		*ppos = pos;
-
 	return ret;
 }
 
@@ -6816,7 +6803,6 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
 	int *valp = ctl->data;
 	int new_val = *valp;
 	int old_val = *valp;
-	loff_t pos = *ppos;
 	int ret;
 
 	tmp_ctl.extra1 = SYSCTL_ZERO;
@@ -6852,8 +6838,6 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
 		rtnl_net_unlock(net);
 	}
 
-	if (ret)
-		*ppos = pos;
 	return ret;
 }
 
-- 
2.55.0

