Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07464C8C7D;
	Fri, 11 Sep 2026 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162976; cv=none; b=JQzI/N83F/nrorUp7UKCNGk8uBy8yNNiCvW+w9RfghIXZaaAM6F7hm4qVYOx1Lo66n0+GJ7euXF0DjaXcSMdBKNH3h5KJx2BcLHwFwLxtnCi7mO4isCLEsL3T2Q3pyQviDI9Go/6G2CyvrvlrcuLbmpEPXsG/HnHSCWQ4HKOxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162976; c=relaxed/simple;
	bh=tgWspVzs5g1SOEs8onwpypsv7ivUGenqmQaWv6Gx4YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjl1GVWr0oHefUqcDJQ+JHKFtYV+lyQCD+ZFopeKL/yQVOmjDoqye0yhUqFo/ukVyrGnKNhD4Q2pFSNiwKXMRoLQ8ZA+HFlA7gq90e4VV4FhQapYzf7/0LM32ddrxk43HHNJx9dNZnpQnJSw/zF40WCvEzoahzp8VuRqM7fON+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=pGEMq8py; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="pGEMq8py"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162973;
	bh=tgWspVzs5g1SOEs8onwpypsv7ivUGenqmQaWv6Gx4YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGEMq8pyMrN8ynbk6b4fGjI1mX31Imq1+rh9U2/1yUZW3oIhU5ziU6eRdV7dXKmPo
	 EtpDSXFV0ZToAf0ml5kb4xDxrKlW4nXRQGbj23RApJlGpxBQZKTSgiFjplFp3BTpbV
	 4+YmuBwOgqzp/g0Eh3bJXEsHrX+Gm2JVJUpp+WQlNhLya2zxsqMxX0EPW+lsZSN9g9
	 f2a1HcKjJ/EwULs2O8/4pOVeEp+IaU6geRlJh7mfQLIqftUMJeLqf2rdUqrSoESSao
	 lyEAwZ6QzlJPeRffiQILYt72zyh00kdDuiib0/tGC3y7qDRYGss9PlS0TyiJa2xLeo
	 VUIzCnvARKaBw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EE1B460112;
	Fri, 11 Sep 2026 21:42:43 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id B584F2023F3; Fri, 11 Sep 2026 21:42:20 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Subject: [PATCH net-next 08/10] netlink: specs: nl80211: fix naming of enum members
Date: Fri, 11 Sep 2026 21:41:34 +0000
Message-ID: <20260911214148.1184806-9-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911214148.1184806-1-ast@fiberby.net>
References: <20260911214148.1184806-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the correct naming for enum members:

- In feature-flags, it's NL80211_FEATURE_ND_RANDOM_MAC_ADDR,
  so "nd-random-mac-addr", not "no-random-mac-addr".

- In commands, it's NL80211_CMD_UNEXPECTED_4ADDR_FRAME,
  so "unexpected-4addr-frame", not "unexpected-4-addr-frame".

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
CC: Joe Damato <joe@dama.to>
CC: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
CC: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
 Documentation/netlink/specs/nl80211.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index d9fdd66b497e..efc783fb8fdf 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -97,7 +97,7 @@ definitions:
       - unexpected-frame
       - probe-client
       - register-beacons
-      - unexpected-4-addr-frame
+      - unexpected-4addr-frame
       - set-noack-map
       - ch-switch-notify
       - start-p2p-device
@@ -202,7 +202,7 @@ definitions:
       - tdls-channel-switch
       - scan-random-mac-addr
       - sched-scan-random-mac-addr
-      - no-random-mac-addr
+      - nd-random-mac-addr
   -
     name: channel-type
     type: enum
-- 
2.55.0

