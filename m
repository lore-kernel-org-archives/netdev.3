Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AE4A5EA6
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211207; cv=none; b=lR3Ve5cypgyAGlIXNAJ9ewcLvUMmDMrNO73kcqXkYr0gTRAbiGoA/4dOLlfuSO1uC1DpBJdvlx2h2mx60DSSNx2+b6RS3XcXDbHIh9/mHFJiNYoCnjyEjfGHimgUXW73y/WurTjrisTPeyxRA15goNKDvK8BdK9OuR25SNKUtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211207; c=relaxed/simple;
	bh=H8zWpkte+IOGXQWFkinQYrDB24Tm5Xwfoc8Gd9TV/vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwXdjnVZf5BFzm8tZ/nSfUjrIvkWnZ0R8hY9kAivSmwy7Lo+T1YN/DxSlsudFOKX7f2rURiACwFsfTXbb2OqAwYIAKjgosZFtF/5iw3VvwYQp1Ggt/MZG2NaBYU/nyE2MckC+QrXsnLskZGDKaFu70AgdnfbQObx+aLZFKI7uUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=IrAbfx/d; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="IrAbfx/d"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so1029236f8f.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211197; x=1791815997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgLhbPYJl1k11TkewywLYOwqHseFbWKlBdyOUhqVzJc=;
        b=IrAbfx/dCNxxGcsU1+soGxeskC+Z2UyBMRWMW01h58usy4nXZWrPwQNvs5Cwpu2YqG
         iQ+s8uQ1k6qheHIuyGwZI6PAbMpw3arGdwSv78/UeNOjyd8E0Jiw0H8XodMzS2GvZgRR
         HgGV9kwm58FlNd7OPksiymkdQFUOjp+4rX8Qw5lJ5qREsVp5/dZqkde3JbJToaCZ9Y2t
         /kjKJszrZu4DmFEzqMSZQmpf18QAbOlNVGeruVliiZxuz04CXIevQ3jRjrdg04R4zRSn
         ig16RgdyrjJaMn2UgOA3y51M11zBmdXNzkBVY9pYfUrJ7z6W0m6d/3CuxnDkn87Xwka4
         wq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211197; x=1791815997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wgLhbPYJl1k11TkewywLYOwqHseFbWKlBdyOUhqVzJc=;
        b=1D7ZR7LcULpUZBsU89CsNuY0Rt7+8ZTK3TEs1wbj1+Hr62FtgLImbKHIhjzoHORN/9
         xpZVB8cEmlUGjtqHTt/Lvh8xhZdu968Zmfvx3BPv58VO5pTMP19Dxmmk6xiIVAj4c2/V
         k9cvZMnBegxXpdnQo7xGhoGYAxhPpgNOrwKpr0lL2hNCL65ihD2nKqIx2M7Xfh5fixoI
         PdU+v0K10wHoTcLXYcpKVAuhMOEIhrqVygks609MIxKGMYUPFRBSOMXqgOOelg5aHrh+
         KsnHikQvv0y31gQ8iZF/50G2ngcoGkmc87LAhqaJcnjbx7DQnkkIvculREmbslhW2JWT
         pwWQ==
X-Gm-Message-State: AFq9FYIjtQshdy83RXbIUR0S6e8d9L9C3Sj9/m0MR+PsDTVFJITg35dm
	UZnGRiuHuuuRLI+dxWJ/NaBOVi7vvllWzPQtb9mAwu1WOBZk6vM4tFaUsdZsLxHQnpRNpbFFhsA
	58J+M
X-Gm-Gg: AYBFou3K+lFpIlxktE0+4AknvarlbHJ7eJFjqM8/Bc03zDFtg0A9eo4ygGHJx7RHcbc
	SVv145zsiQjCczxhwDPBKTS1LQN79d3CXJN542cKcuRk+stVBghvf75gB/PXbgiczIMF0BOMANe
	VZxUd9FncWdEYL23yLb0PFDQ+UYny4l4TH12Qh0l1VQD0kIUu0YPsfUAvntlRiofg6Tiiikz8xb
	xCRHDWdJp6cX/jDYldJsesASxPy1IUJIMoh0Sk23hK+sgWL8TZ5q/nMrREe49waJI9YkofGOGLi
	V+rLykh5hriAtaR+V6LCGexI17WCpBnvGqy2AJe+Qi+Dx4lEqrXfw5mW2UL8CR5oFlLSB149lcz
	FOzHO/Ss29pqnC0jfHToJ5yWWz8LutExa5AgCewF95eHZJZwVsmaPjDTn7HdcTJTSakFLMt0uV8
	U8i/cv1BNCHRxZ/xT6E0+OyI9BO6KacsOxZgpthQpfjBR1/Kr+2iv+/gzb66HGxc29P9pFB2lWA
	2G+WrkiVYeVWlu5It73
X-Received: by 2002:a5d:6f0a:0:b0:48c:4f83:f42f with SMTP id ffacd0b85a97d-48c4f83f5bbmr12807658f8f.8.1791211197624;
        Mon, 05 Oct 2026 07:39:57 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48c642b42d6sm2910942f8f.9.2026.10.05.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:57 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 3/6] net: bridge: vlan: share VLAN validation in br_should_learn
Date: Mon,  5 Oct 2026 17:39:34 +0300
Message-ID: <20261005143937.877466-4-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
References: <20261005143937.877466-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both the pvid and tagged paths now resolve a VLAN entry. Select the entry
first and share the state check and output assignment.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 0675f74cf1b9..dcf783e1a440 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -742,21 +742,16 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb,
 	if (!br_vlan_get_tag(skb, &vid) && skb->vlan_proto != br->vlan_proto)
 		vid = 0;
 
-	if (!vid) {
+	if (vid)
+		v = br_vlan_find(vg, vid);
+	else
 		v = rcu_dereference(vg->pvid);
-		if (!v || !br_vlan_state_allowed(br_vlan_get_state(v), true))
-			return false;
-		*vlan = v;
-		return true;
-	}
 
-	v = br_vlan_find(vg, vid);
-	if (v && br_vlan_state_allowed(br_vlan_get_state(v), true)) {
-		*vlan = v;
-		return true;
-	}
+	if (!v || !br_vlan_state_allowed(br_vlan_get_state(v), true))
+		return false;
 
-	return false;
+	*vlan = v;
+	return true;
 }
 
 static int br_vlan_add_existing(struct net_bridge *br,
-- 
2.47.3

