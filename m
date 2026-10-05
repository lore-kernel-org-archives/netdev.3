Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4A4AD4B2
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211204; cv=none; b=YkWHyYC7/HmJ3wN5P4Rg3o8crrMi6pMq1mOs6Xad3BLM4ftgcNNUaupXmFB+jomnS88TmuHyBDwiuBjmdkU/atI2T7X5+0msdWxZ6Jt1ZnPZGJzXVvcetS0j5DpFjc0DTfcOEV8c10+05J261pdrckzgItbhlkEM/zWyR8m7uCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211204; c=relaxed/simple;
	bh=7prVsLcxC5euibeO10biFrGSkYTV8r8zEoYUDnCIDAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXE6xcNuIoWlO1zwXyM4ou+E0+P1pv9Rr+Zm3KzyzZPdr4oMHc3WIPaX5nZXvz3Fd03X80ycWt6kiY++2trn4zpmbaZqbNwLH9ByULqq6KnLgxXWW3pdneZQ3GuMNcbWhHGs1lyCwXyIDm5Hy3znvPAbL1T64rieCBbOtexLQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bGNXo/hu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bGNXo/hu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49ff680331aso18656475e9.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211196; x=1791815996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9j6IEIFgBzPxK946Me+Dgw49Jbt2Vury8puH8M1Nww=;
        b=bGNXo/huoVP2DdsDrkBJbXt+ri6+WtkbojVPtBR6QZStHYd2ZLzfzIgH7zy77oBbB3
         T05M6VoMFydJbfKUPqMcnr8LLc9S6qiS7JNS/Sbb7lDzFRt1zKzpqXPHvss0CHa+Wi1S
         WtazEH2Q/5xu3seCpxmUVACXm8M8md45Glpw+RzZrNg+vEvN8DmBtO+FK9iMWLtLtUtP
         HVHpBzocGqMbumoRE1E9Dde2hKKp5gyIlJi+jTs3LjxNHCFsv8MDlduFRk4i736erTQI
         1b9HkdAD6ftzXT3COlBU4aE/b4ASpg5kxjl2VhP1RqCbjU0Z5ZW3zPEudOwgdL0jS4lV
         gehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211196; x=1791815996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9j6IEIFgBzPxK946Me+Dgw49Jbt2Vury8puH8M1Nww=;
        b=P87vRv5H2B7czAU7kiro8kw74nIYk1lYcuD8Mawz9FyGY+MbpPrJOI1ny3di31USQ+
         7xAsiOq2NE1L6bA362wuYB7rr1Vtf95+3CESSwYR5m3fu9kTATMSDxpXovsrEdN4V5w/
         zklFZbvgjkLAlvlFIGOgku8rymvkyqVAKOn5M/pKsE9Cloy055GQdU7qVAm0JFKKPoXO
         rd/mFtILYK/rGMfx1FlbddYVm6/ekxB6WEkLBLuYcboEgTTrtdnMrBmMOzw9FRCbMfH4
         KZ06cXluFLG9JcAcWdNYZwvtie6JFFKil1ar9OAjWgZXssGCxOlKTchnGmt1sXHpoL3U
         miOQ==
X-Gm-Message-State: AFuF++mTlXT/t2mx8EyGX/lg9+z1Foy2MLKdrAb8YgmQX/4jdmrthbTj
	pc8r4WVyCeVQUTRCmyrxmeF+SiPnlpQ4SOLpEGTZnVLMa0wudlPu4e2gGyzTR22NP8nJOMSgbXB
	2cYdD
X-Gm-Gg: AYBFou0f6F/fGX3Fn8D3d57Sp1gRVLuHa+a1p5/CHD+jgNka5SwHOTK/4GmzbdTmHNl
	IHog4Lz4Nk9FdKhSsY9r2mz6rBMdpfa1sO8mCsO85yJ9xbC18aIFSX8lxg3weHKmakLKLx5EBy5
	I1kQp76TBbNgBC3N56L8/AOK5Csq9oBIQAeN3laj8ZoMAuIUI/cTX0XJ984re3/sCRvj7CoMwEE
	5d+vN6PqD0SJ5gGK+E8go0tCc7bikSnunE6N3enNh3pMnuivvbP1+t7J5P/MG4cR2Yn0yqCW6hh
	2Q9IEigngPSJpBj25Zv0CUr3D5rbd0D/sJlP64icGwi2D+5wdmpvDAMmyu8JiA1s/uGgemHloyy
	5gWo262sCoz8HEk3Vx1Y2kVxjvgqc9Ejw8ObXsN20YJQDDn+qr1Xs6a7HSW1DOnpEPFqNK+CRPa
	nTHINtR9elNQsx+LeVKkSnK7LZeAVPNc4jXH9C8ozwWUsp+hl6RPDFOar1fwMYl7mDDY7JBYY2c
	CENacq5MWOtZ7u3kBku
X-Received: by 2002:a05:600c:c4aa:b0:4a0:5b:7bc0 with SMTP id 5b1f17b1804b1-4a1680f7780mr137106015e9.21.1791211196470;
        Mon, 05 Oct 2026 07:39:56 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a03ff56136sm135003335e9.3.2026.10.05.07.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:55 -0700 (PDT)
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
Subject: [PATCH net-next 2/6] net: bridge: fdb: update the comment for br_fdb_cleanup_by_dst
Date: Mon,  5 Oct 2026 17:39:33 +0300
Message-ID: <20261005143937.877466-3-razor@blackwall.org>
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

Update the comment for br_fdb_cleanup_by_dst to better reflect what it is
doing after the recent changes.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 730b178cf6c4..ce09e3fbc58b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -868,9 +868,11 @@ int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	return 0;
 }
 
-/* Clean up all entries referring to a specific destination.
- * if do_all is set also flush static entries
- * if vid is set delete all entries that match the vlan_id
+/* Clean up entries referring to cleanup_dst's port.
+ * If do_all is set ignore vid and entry flags. Otherwise vid selects
+ * the VLAN (0 means all), keeping static and non-offloaded ext learned entries.
+ * For a port-VLAN dst, vid must match its VLAN ID. Always clean up its local
+ * entry unless user-added and fall back to the port dst for retained entries.
  */
 void br_fdb_cleanup_by_dst(struct net_bridge *br,
 			   struct net_bridge_dst cleanup_dst, u16 vid,
-- 
2.47.3

