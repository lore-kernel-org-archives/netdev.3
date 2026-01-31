Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD7339863
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877088; cv=none; b=B2JLx7veXwwaBUSqZmghvw7MuH01pyTXQiJme9AfrPpNE5mmZ6bmIg3vMjF7/r+/EvsqPlZZJuC/6MD62obAxcCSKNnsjDcZn+ZVflmTpWMM94ka4afxynzBxGXuJ70OUp6mpFOyrswho9Rc28cuDdqvOje2YAfZhPeNX1k5irw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877088; c=relaxed/simple;
	bh=a43fa1uhTuI/L1xsrsBol3ivi+tKmgeZlqR+qM4Maf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDlkzWpRxv8oe1JYJ5nC3Qtft9v/+K3gXFzeYbQDVVotUJC2zuw/yRS5t8Dgzt/vlfREiRydbh9dBfjB8ULIsn1BLzlwlgZVya6WsuPUbbTqALtZnI42Pgfw1ePaETpRKxbKsJvnVBzjaj9RknXlJ6TBsvJhBIrGiepPRV0ptmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=R0gNYgPw; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="R0gNYgPw"
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60VGVPea039683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Feb 2026 01:31:25 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=XkB0UJdSADANAbmF+JgfoF3mhihZYqHI6IAIOSB6NXo=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769877085; v=1;
        b=R0gNYgPwNDX86udfeD4kz63cQh1NW/Bf0EwiikmwKatkqDpH0mWANdGGduDG4I3h
         RskNGMdY3m6EvldWEiTDjOMJAkq1zNpkPB+obVQIYn8cMkXjw8fws3F7JuoKJyWb
         G1mvULGGIg0iGbfJuXKeP/2XviLmlwGcYUeCIsOcpMygsQrDundLGcQ5WzO/M0dF
         FKy7y4cQEylE5Mmi0FqXlZ0g+u815aYW9hMJ36WKriHEZktqmhH4JVFyqUUcA6rA
         +CQQLiL5KqzPVVJgUrbDKF2OgKQWH9rawpf6/Hw2BJPuIwZV7qlqihLS7RAK3lG/
         LNkYIYscEgo66BtahAj8rA==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vitaly Lifshits <vitaly.lifshits@intel.com>,
        Simon Horman <horms@kernel.org>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v2 iwl-next 3/3] igc: allow configuring RSS key via ethtool set_rxfh
Date: Sat, 31 Jan 2026 16:29:38 +0000
Message-ID: <20260131163037.88108-4-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131163037.88108-1-kohei@enjuk.jp>
References: <20260131163037.88108-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change igc_ethtool_set_rxfh() to accept and save a userspace-provided
RSS key. When a key is provided, store it in the adapter and write the
RSSRK registers accordingly.

This can be tested using `ethtool -X <dev> hkey <key>`.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 30 +++++++++++---------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 661b044073ca..eb5b146f6f10 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1539,24 +1539,28 @@ static int igc_ethtool_set_rxfh(struct net_device *netdev,
 	int i;
 
 	/* We do not allow change in unsupported parameters */
-	if (rxfh->key ||
-	    (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	     rxfh->hfunc != ETH_RSS_HASH_TOP))
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-	if (!rxfh->indir)
-		return 0;
 
-	num_queues = adapter->rss_queues;
+	if (rxfh->indir) {
+		num_queues = adapter->rss_queues;
 
-	/* Verify user input. */
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		if (rxfh->indir[i] >= num_queues)
-			return -EINVAL;
+		/* Verify user input. */
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			if (rxfh->indir[i] >= num_queues)
+				return -EINVAL;
 
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		adapter->rss_indir_tbl[i] = rxfh->indir[i];
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			adapter->rss_indir_tbl[i] = rxfh->indir[i];
 
-	igc_write_rss_indir_tbl(adapter);
+		igc_write_rss_indir_tbl(adapter);
+	}
+
+	if (rxfh->key) {
+		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
+		igc_write_rss_key(adapter);
+	}
 
 	return 0;
 }
-- 
2.51.0

