Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A1481AAE
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184825; cv=none; b=rm7o4kRF69OsVlmGYu4DKe66oUmyQb31u3n5dR7zHzibZ0q5I6yOifwV7JiA4goJvtBQ1aInKvpRfGKqRQPOKUT5/6JjryTHQiaP5kwFISB1gWxk4wsJT3CAfe7x3sjNBvy2etv4tMUvpneOr/6cuktYQXOMeJCMbsp1uGlsg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184825; c=relaxed/simple;
	bh=QG3kb6VqoaL4V0wY24CVJ4KY5flUNi1pwVOmYx94ApY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKzr8YXcpUiAeLRncBrE5894K/SpfZMe6YVqBXDjP0bYR+edZJCU5Vz75mPvI14jQ7hqSTMhOv0oM5JWXB3gj7NzqJ5CML8LPwRXgrwUeuP8njYawF9ekuwkYsRN4ENTD2I5PHKuIUu55pso0yrrpkDH7H3RusecCSUscmUgGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=ng19PBSD; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="ng19PBSD"
Received: from kero.packetmixer.de (p200300c5970eeDD85F51F1FAA919d7A5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 4C879FA154;
	Mon, 31 Aug 2026 15:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4h/XBmpl/DRMN8KGH3elG43Lip1BkfAzHomEY8fyjs=;
	b=ng19PBSDh/kairXFd7AKm2VCPdy7tlFaffRlNlvJuWu9U8JX5MphM6mRwa3XM7c4e03TTi
	/nm/jql227P6HKV1QDlcH2kFCNMnphEW+f2kJeM11kBzRhTPBgecKoNZoVXwWr05dtNmUW
	ZjQi6FNHGzJEkHvLyO1DSvXO8zlpeoMO+Gt1HwZw8TQI+VW+6jHbOiZjxhmWaeFv0t087N
	dftfSbeKNXqcFtYVB5Wg1WDdIxCCcCbQBgtpQwhZfDjrhkhPqvEl0TtNynC4sNQV9HNLcf
	JyGTUbrNc+zJa5DP+w+7v/ABY6Exbd61NZBw7otZtOlm7aT2NJPPPHDYUlfUmA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 03/15] batman-adv: bat_v: fix bonding candidate selection
Date: Mon, 31 Aug 2026 15:51:05 +0200
Message-ID: <20260831135117.574836-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_v_neigh_is_sob() implements the metric (throughput) similarity check
as:

  neigh2 (the reference) has a better throughput than 3/4 of the neigh1
  (candidate) throughput

But this results in a selection of bonding candidates in
batadv_find_router() which have a really low throughput. But the goal must
be to select candidates which have a good throughput.

The neigh1/neigh2 operands must be swapped in the comparison to use the
reference as such and select only neighbor+interface combinations with good
throughput.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 0c27447cf6889..2d3045733db1d 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -519,8 +519,8 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
  * @neigh2: second neighbour to compare
  * @if_outgoing2: outgoing interface to use for @neigh2
  *
- * Return: true if the throughput of @neigh2 is at least 3/4 of the
- *  @neigh1 throughput
+ * Return: true if the throughput of @neigh1 is at least 3/4 of the
+ *  @neigh2 throughput
  */
 static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 				  struct batadv_hard_iface *if_outgoing1,
@@ -540,10 +540,10 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 	if (!ifinfo2)
 		goto err_ifinfo2;
 
-	threshold = ifinfo1->bat_v.throughput / 4;
-	threshold = ifinfo1->bat_v.throughput - threshold;
+	threshold = ifinfo2->bat_v.throughput / 4;
+	threshold = ifinfo2->bat_v.throughput - threshold;
 
-	ret = ifinfo2->bat_v.throughput > threshold;
+	ret = ifinfo1->bat_v.throughput > threshold;
 
 	batadv_neigh_ifinfo_put(ifinfo2);
 err_ifinfo2:
-- 
2.47.3

