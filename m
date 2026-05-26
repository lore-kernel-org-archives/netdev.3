Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838E36D9FE
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809757; cv=none; b=RrWe6Eg+VFRyHDMpjrKoBveAkxuIopCsp/ZiSHVKemJRpbH27o+ltHvKBbMMRPr1bEUd7clAS2whjVsLFbIvsoeybFaT8KwEf1avwD2OpR/YHOffr4uXSfe8k7/PwQdfF32NXEg6kypQ75LNPvhUAQ50VVfu99moTw1sP74g/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809757; c=relaxed/simple;
	bh=KDX4HNkml7IV8aU7lMSze1ajfU/82Eaq8IQYthiIen4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj5yB+jeFcICIZd1+H1jxJZ8tiAiFkbxGMmZOcQw8hIpsVxrddCDguY/iroyf4T+OUsMncIz1Gb/xoxcygv4ar4QiUsOT0R+HQgWP+eXIDJOdDjMnrnyLFubVK0JfdkycgFfKMxzjI0TqoRrrJSJNRSWKCiicjOqFtvFz73ZAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WftkscJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WftkscJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0BF1F00ACF;
	Tue, 26 May 2026 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809753;
	bh=RaDp/RUL2fBgbi6ns2algeqHkIpvo99pX47peb3GWGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WftkscJmREEeKkEuS6cGZ+JSJxCg9mBW5LW/Bq62x7ZXldE8IwId5aR6jdmgSDmUz
	 /fLbrA0YOdi+Uo9qDX028TPODAh21DV7Ihh4TZ05gaj1jESuFtSaZbvuo+LqRRWll1
	 9qkhAw0JA/skTKfA/pikAp3cCW581TStc6OOHWeBw1QO6IHAzojZv8F+1EZVEbXkG/
	 h3V/o86W0SIgM/zn4EAjTSnHilnrLn1NjmRK/VUJ4U1ZT7EA/OWlrVVV1qQRLHceFc
	 zAUmPwLX1DpQY7lLdX06aa4AaiX724R2zTcXxdTfGDzx8nIkRLhW5Riuha1pnmdxT0
	 wAiQdT+I/oRGw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	kees@kernel.org
Subject: [PATCH net 06/10] ethtool: tsinfo: fix uninitialized stats on the by-PHC path
Date: Tue, 26 May 2026 08:35:29 -0700
Message-ID: <20260526153533.2779187-7-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tsinfo_prepare_data() has two code paths: a "by-PHC" path for
user-specified hardware timestamping providers, and the old path.
Commit 89e281ebff72 ("ethtool: init tsinfo stats if requested") added
ethtool_stats_init() to mark stat slots as ETHTOOL_STAT_NOT_SET before
the driver callback populates them, but placed the call inside the
old-path block.

When commit b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to
support several hwtstamp by net topology") added the by-PHC early
return, it landed above the stats initialization. On that path
the stats array retains the zero-fill from ethnl_init_reply_data()'s
zalloc. This leads to the reply including a stats nest with four
zero-valued attributes that should have been absent.

Reject GET requests for stats with HWTSTAMP_PROVIDER or dump.

Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: kory.maincent@bootlin.com
CC: kees@kernel.org
---
 net/ethtool/tsinfo.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index a865f0fdd26b..f54fe6b662b2 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -83,6 +83,11 @@ tsinfo_parse_request(struct ethnl_req_info *req_base,
 	if (!tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER])
 		return 0;
 
+	if (req_base->flags & ETHTOOL_FLAG_STATS) {
+		NL_SET_ERR_MSG(extack, "can't query statistics for a provider");
+		return -EOPNOTSUPP;
+	}
+
 	return ts_parse_hwtst_provider(tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER],
 				       &req->hwprov_desc, extack, &mod);
 }
@@ -523,6 +528,12 @@ int ethnl_tsinfo_start(struct netlink_callback *cb)
 	if (ret < 0)
 		goto free_reply_data;
 
+	if (req_info->base.flags & ETHTOOL_FLAG_STATS) {
+		NL_SET_ERR_MSG(cb->extack, "stats not supported in dump");
+		ret = -EOPNOTSUPP;
+		goto err_dev_put;
+	}
+
 	ctx->req_info = req_info;
 	ctx->reply_data = reply_data;
 	ctx->pos_ifindex = 0;
@@ -532,6 +543,8 @@ int ethnl_tsinfo_start(struct netlink_callback *cb)
 
 	return 0;
 
+err_dev_put:
+	ethnl_parse_header_dev_put(&req_info->base);
 free_reply_data:
 	kfree(reply_data);
 free_req_info:
-- 
2.54.0

