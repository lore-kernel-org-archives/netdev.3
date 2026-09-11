Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E84A6CD5;
	Fri, 11 Sep 2026 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162970; cv=none; b=LNPQ5+vYuJfRXvrYC6zdS8KvUikvSjvn3XPm3M1BjQD4QgmXBYrIZBcoHBOqtA7f8+SF+ZSH8R56ZVoHdfkBsTZMlcT6gsGvj4ZjJJWamzKKQkUN1mvg14N+M1mHwl/VzN+YE+F2xN5gUVlmRLElPp6lwYSS8nuGNWCliYHURzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162970; c=relaxed/simple;
	bh=UkM6a/g/vE5U3lfqfpRcHikiXCdUByb3lfDU0NU2V1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJ/45fYR+wVRceg4eKq3auDy5H1auCpo2tVzBuJHnbulCvxTb54DP5pjewDxY+m+XogQa5eNTeXVsAn/IsN7Q+YjP/KJRjYW31as2t3rQHQjMs22NVEgFyoW2t1vylJm5agHBMr/DENaqnmL7fZFMM9tIkkUyKUqTe/L8BglXhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ex5l86kT; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ex5l86kT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162963;
	bh=UkM6a/g/vE5U3lfqfpRcHikiXCdUByb3lfDU0NU2V1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ex5l86kTe+S8Fip8dQcY46Nlx9dCpMVinTNgu/IwUAsMS8KoP2QmjvD3dU3YP0WDm
	 vQYdFGgO7sKlAgzuPejYBQQ4T5uYUZ7aYlsVZbwGRXDyibhw/AiL1tcLoSTifmOLOS
	 6Xxr7K8GqVtTR1xLP2Ad8vwBCEyFXkWXp/jWe9ThUb/Ynx53+Mz5pib3LXa1Uojjqb
	 yLyRBSlyN+rz5M1bFIsustEkDoiBbAd1VM5ihWdNIeTiMjPD/ul6/oBqtvHO9McOJ9
	 N0uFiEbfuTptsLu1LFoV+Xs2NvtsKcHcZWcr1ckWf25TgKK5zLe/5Q3EVf1YjPdUHr
	 //4bI3/5ZHkpQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 72F7F6010D;
	Fri, 11 Sep 2026 21:42:43 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 74931201C97; Fri, 11 Sep 2026 21:41:55 +0000 (UTC)
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
Subject: [PATCH net-next 02/10] netlink: specs: rt-link: re-align ifla-inet6-stats
Date: Fri, 11 Sep 2026 21:41:28 +0000
Message-ID: <20260911214148.1184806-3-ast@fiberby.net>
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
CC: Heng Guo <heng.guo@windriver.com>
---
 Documentation/netlink/specs/rt-link.yaml | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 6d5f50c8362c..52cac8bba0c9 100644
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

