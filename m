Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514C3B14B8;
	Fri, 25 Sep 2026 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372958; cv=none; b=jLysEHvq37l4mx3Dnr90Nc8m/J65DmGl4CG2QVAmGIxq+siWgzBTwl57EbnScPgZDrsrSsxZJS0nHUz6zMO6RfYjAfk5JDv7MWx/0HH6lf3Opff3RuB64xVkr71g3MgHFWfu0SL8aWNjbM3LqF5GWo0xmINRLer6W6lUge2qr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372958; c=relaxed/simple;
	bh=Oss6sJnm+GnNUEzBjUYZVc/PWbkclfAXIwZsSIvHFH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUEQz23svxy6etaBKVmOcRGMQaNSWFAazqD9iT4wm/kmfGeAkWpgfWNfpehAaV4i7uHRSflDkrkaRbadeJredNhB0mdKR/DbFSZcnUcr3L0RCpdhxm08WNmqvn+xUltVGvd32+weqC7vO/Yzysh7TfcH7uxrkO9rO4QPEaHJ534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ox0ksbgj; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ox0ksbgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1790372389;
	bh=Oss6sJnm+GnNUEzBjUYZVc/PWbkclfAXIwZsSIvHFH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ox0ksbgjFRUMw00psOf4grGCirRRaz92ty/MercBZTWUzpUGRdxA3BfP3Abb47n6W
	 xI1+11QuzNM018ZKOWxbu3wRwRHhkcBS65lMvWOQWciG84DiowHdV16eO9IvD5NFpJ
	 hTfO+MYr20v7qvtDbNlbHAehDxCQBI0u3/d5KY72lfolwkqqiocDuYi+CfQ7LSYvWo
	 zu676PuJ/PxVM/daXewz35hQF6Efenm4Y+DxSyYfBIyL2GHEWZ8IryrbLxxWOs63Yc
	 UVFGeZ4sT5h/6ceattRI6qs5zz+w2NRzqg/XVe2o10+UQjsc1rYAQzncjxFAGDELEy
	 rmJytcs2WuGUA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0CE2D600FC;
	Fri, 25 Sep 2026 21:39:48 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 0B82E2019EA; Fri, 25 Sep 2026 21:39:21 +0000 (UTC)
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
	Sashiko <sashiko-bot@kernel.org>,
	Heng Guo <heng.guo@windriver.com>
Subject: [PATCH net-next v2 2/9] netlink: specs: rt-link: re-align ifla-inet6-stats
Date: Fri, 25 Sep 2026 21:39:05 +0000
Message-ID: <20260925213918.204767-3-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925213918.204767-1-ast@fiberby.net>
References: <20260925213918.204767-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

YNL enum ifla-inet6-stats got misaligned with C, as two commits
reordered the enum.

In commit b4a11b2033b7 ("net: fix IPSTATS_MIB_OUTPKGS increment in
OutForwDatagrams."), IPSTATS_MIB_OUTPKTS was renamed to _OUTREQUESTS
and a new _OUTPKTS was as the last entry.

In commit 652e2c777862 ("net: reorganize IP MIB values (II)"), the
IPSTATS_MIB_* enum was reorganized for data locality.

Neither of these commits updated the YNL spec.

This changed uAPI, as IPSTATS_MIB_* is used as indicies in an u64 array,
exported as IFLA_INET6_STATS by inet6_fill_ifla6_stats_attrs().

This patch updates ifla-inet6-stats to reflect both of these commits.
Next time we want to reorganize these counters we should properly apply
mapping as to maintain the current order on the netlink side.

While touching these entries, also remove the dash from ect{0,1}-pkts,
so that they align with the C naming.

This pre-existing issue was identified by Sashiko during review of
commit 2b0aecb7b2b1 ("netlink: specs: rt-link: add accept-ra-min-lft").

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260831093458.472180-1-ast%40fiberby.net
CC: Heng Guo <heng.guo@windriver.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.

 Documentation/netlink/specs/rt-link.yaml | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 8d63933f9910..3560053cea7a 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -532,11 +532,21 @@ definitions:
       -
         name: indelivers
       -
-        name: outforwdatagrams
+        name: noectpkts
+      -
+        name: ect1pkts
+      -
+        name: ect0pkts
+      -
+        name: cepkts
+      -
+        name: outrequests
       -
         name: outpkts
       -
         name: outoctets
+      -
+        name: outforwdatagrams
       -
         name: inhdrerrors
       -
@@ -587,14 +597,6 @@ definitions:
         name: outbcastoctets
       -
         name: csumerrors
-      -
-        name: noectpkts
-      -
-        name: ect1-pkts
-      -
-        name: ect0-pkts
-      -
-        name: cepkts
       -
         name: reasm-overlaps
   - name: br-boolopt-multi
-- 
2.55.0

