Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C41D54FA
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860706; cv=none; b=l86o9CpgLGTlH12RrVBBpPuhBpVB9Owfsbck4Y8bz1c/+/cEsw0mCNrT/1EmEU8MD7Sgc/0AzTgCnBBLkX/cqXiQtRmlTslxOFT0dNbnRs5mPmPLi+Sx3U5dAPbfFallum45h9KsmyEcl0Hcn91f23yVVe+554y9MD++JpqtBaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860706; c=relaxed/simple;
	bh=IttrSLTEnForiVMueAZRFYUuEuajxYVz00JQ6J8Lgmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJhDE8IZmBFICyEEKk5/NhmLEPDhq3yWvqvDyINKNP/9Mn3qqDtZQVxsGNJkP8PU6sySIIJdx0G/D6Rc169dX9sxzLHeBwskELsmcxhNu0XVwSHqtFSNvhJGFR/xSwdZcmSNXuU1qUJw/lHhj11SBfl7W5nTtdSikHx2FdIPjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pSek7Csy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZpB6NE7P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pSek7Csy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZpB6NE7P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pSek7Csy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZpB6NE7P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pSek7Csy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZpB6NE7P"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 543183ED34;
	Mon, 23 Feb 2026 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771860703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O4DCiC1wrroA+cOGEhHkFXQh+ZENjK9/egFLAmUcb1E=;
	b=pSek7CsymXLlkuv2EkvccFxZwaR8fAOpZ8NbRf2tQUa1YGOKzf5zq2zLmGyhN3lRAiYAm4
	2xrfg4dSLLO/Or0XotAZbhu06+f3UZRE39erOZouj9mJ41c2POQDwYHH+sM0cxdwD4a/7x
	AsNxxcdtnJ3OKWud/XBQqGLNeMP4+6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771860703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O4DCiC1wrroA+cOGEhHkFXQh+ZENjK9/egFLAmUcb1E=;
	b=ZpB6NE7PffO0M0SCDv/nuDEYU/RNO3tn+9EcCkZeFElotsdjc2O2XKdiGjngiFbxGNvmq6
	62HiwYtQGZGu+lDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771860703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O4DCiC1wrroA+cOGEhHkFXQh+ZENjK9/egFLAmUcb1E=;
	b=pSek7CsymXLlkuv2EkvccFxZwaR8fAOpZ8NbRf2tQUa1YGOKzf5zq2zLmGyhN3lRAiYAm4
	2xrfg4dSLLO/Or0XotAZbhu06+f3UZRE39erOZouj9mJ41c2POQDwYHH+sM0cxdwD4a/7x
	AsNxxcdtnJ3OKWud/XBQqGLNeMP4+6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771860703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O4DCiC1wrroA+cOGEhHkFXQh+ZENjK9/egFLAmUcb1E=;
	b=ZpB6NE7PffO0M0SCDv/nuDEYU/RNO3tn+9EcCkZeFElotsdjc2O2XKdiGjngiFbxGNvmq6
	62HiwYtQGZGu+lDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B5D53EA68;
	Mon, 23 Feb 2026 15:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MtOjIt5ynGkINgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 23 Feb 2026 15:31:42 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tgraf@infradead.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 net-next] ipv4: validate IPV4_DEVCONF attributes properly
Date: Mon, 23 Feb 2026 16:30:44 +0100
Message-ID: <20260223153045.32044-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.962];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

As the IPV4_DEVCONF netlink attributes are not being validated, it is
possible to use netlink to set read-only values like mc_forwarding. In
addition, valid ranges are not being validated neither but that is less
relevant as they aren't in sysctl.

To avoid similar situations in the future, define a NLA policy for
IPV4_DEVCONF attributes which are nested in IFLA_INET_CONF.

Please note that MEDIUM_ID is defined as NLA_U32 too because currently
its usage through netlink is broken for its valid value -1. Modifying
the type to NLA_S32 would break existing users of set/get netlink
operation.

Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/devinet.c | 81 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 942a887bf089..590c68e979f5 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2063,12 +2063,76 @@ static const struct nla_policy inet_af_policy[IFLA_INET_MAX+1] = {
 	[IFLA_INET_CONF]	= { .type = NLA_NESTED },
 };
 
+static const struct nla_policy inet_devconf_policy[IPV4_DEVCONF_MAX + 1] = {
+	[IPV4_DEVCONF_FORWARDING]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_MC_FORWARDING]			  = { .type = NLA_REJECT },
+	[IPV4_DEVCONF_PROXY_ARP]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ACCEPT_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_SECURE_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_SEND_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_SHARED_MEDIA]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_RP_FILTER]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 2),
+	[IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE]		  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_BOOTP_RELAY]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_LOG_MARTIANS]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_TAG]				  = { .type = NLA_U32 },
+	[IPV4_DEVCONF_ARPFILTER]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_MEDIUM_ID]			  = { .type = NLA_U32 },
+	[IPV4_DEVCONF_NOXFRM]				  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_NOPOLICY]				  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_FORCE_IGMP_VERSION]		  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 3),
+	[IPV4_DEVCONF_ARP_ANNOUNCE]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 2),
+	[IPV4_DEVCONF_ARP_IGNORE]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 8),
+	[IPV4_DEVCONF_PROMOTE_SECONDARIES]		  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ARP_ACCEPT]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ARP_NOTIFY]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ACCEPT_LOCAL]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_SRC_VMARK]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_PROXY_ARP_PVLAN]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ROUTE_LOCALNET]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL] = { .type = NLA_U32 },
+	[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL] = { .type = NLA_U32 },
+	[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN]	  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST]	  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_DROP_GRATUITOUS_ARP]		  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_BC_FORWARDING]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ARP_EVICT_NOCARRIER]		  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+};
+
 static int inet_validate_link_af(const struct net_device *dev,
 				 const struct nlattr *nla,
 				 struct netlink_ext_ack *extack)
 {
-	struct nlattr *a, *tb[IFLA_INET_MAX+1];
-	int err, rem;
+	struct nlattr *tb[IFLA_INET_MAX + 1], *nested_tb[IPV4_DEVCONF_MAX + 1];
+	int err;
 
 	if (dev && !__in_dev_get_rtnl(dev))
 		return -EAFNOSUPPORT;
@@ -2079,15 +2143,12 @@ static int inet_validate_link_af(const struct net_device *dev,
 		return err;
 
 	if (tb[IFLA_INET_CONF]) {
-		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
-			int cfgid = nla_type(a);
+		err = nla_parse_nested(nested_tb, IPV4_DEVCONF_MAX,
+				       tb[IFLA_INET_CONF], inet_devconf_policy,
+				       extack);
 
-			if (nla_len(a) < 4)
-				return -EINVAL;
-
-			if (cfgid <= 0 || cfgid > IPV4_DEVCONF_MAX)
-				return -EINVAL;
-		}
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
-- 
2.53.0

