Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350F39524D;
	Thu, 10 Sep 2026 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078790; cv=none; b=XrNX78Icx56531G6ouBAV8zuLEzzCNAb7dP3HpIMUqc5wRZ2Xn9Mnl+WI3DPTsJpRtYqInwnufPVK+aLrkJccs5oAuB/MIAXifKwiL7QxLRNxIAr/eOMgy42ydLaCFUruwJSGFgWf6HRgEx79inO3csZTaevBjkvEBsEJXlx4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078790; c=relaxed/simple;
	bh=Dozir/3IJu939c5SnxFwdH9rgQY6CoLTFGtt7NTbXkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmztnMayCHCwzAzj56/m3vah9wcRAyXfjkY1P62vRvc/LnQY0elkVYPfXALDW6CeBfVNrauskwHOeNCVcjm5hPsE2S9+MWrQ5uju8ZqqjUY7YH8/KLtD3XSjKEDGAgzXLBP7Pr8fusBfdx+djCm7udFJaJI5IFRKoSoujO9e+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=v6E2o2FD; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="v6E2o2FD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789078777;
	bh=Dozir/3IJu939c5SnxFwdH9rgQY6CoLTFGtt7NTbXkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v6E2o2FDGphZDQuycyiDhKYZ3u2j9teQLWeRgm7LE6YyVPL3xwD4wSIkejNWxC6WZ
	 AZCLXL385YZHSSMhyfC69zQ7DphO8Nmmxn4Q8ZsgyKNFmLk9aLN4RiDUOSLdmVseZk
	 P66MrVsoB9FEO8DGHBIyvjG4J/++YjlQpM8awoMNkapvy/IoONkO4ok5H9BeotsBqv
	 JCfic86K0sFUw3s+J5bT+qgzPoNtdkTVSCvcgNK4FcO3v+aQd5Gw51YG5zHNQZKvu+
	 3Xn97SKHCsPZbP+UCzTdMn9pTWHRnshn74R9eABovcSp3poAas8KSUYsg7rOb54Ysk
	 dgh9KjTY3/K+A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3CEB260104;
	Thu, 10 Sep 2026 22:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BBC632023F3; Thu, 10 Sep 2026 22:17:37 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"Matthieu Baerts (Netdev Foundation)" <matttbe@kernel.org>,
	"Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Heng Guo <heng.guo@windriver.com>,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [RFC PATCH net-next 6/8] netlink: specs: rt-link: re-align ifla-inet6-stats
Date: Thu, 10 Sep 2026 22:17:26 +0000
Message-ID: <20260910221733.1021864-7-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910221733.1021864-1-ast@fiberby.net>
References: <20260910221733.1021864-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

YNL enum ifla-inet6-stats got mis-aligned with C, as two commits
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

This pre-existing issue was identified by Sashiko during review of
commit 2b0aecb7b2b1 ("netlink: specs: rt-link: add accept-ra-min-lft").

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260831093458.472180-1-ast%40fiberby.net
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/rt-link.yaml | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index aee516e87b89..c84bbd58cfcb 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -541,11 +541,21 @@ definitions:
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
@@ -596,14 +606,6 @@ definitions:
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

