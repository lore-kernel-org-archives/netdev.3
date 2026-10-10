Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB624BA1E8
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660443; cv=none; b=fkuJx8JIKp5pM/JDgoBcYQbuuCZOAV9W/Vbxt+DX5oaeiYW51L+yXruA1a4ewSzzTlCGvVs4fPpky1fKhu+E5O/YEQuTMAQEBNyDoCEogkM9jg3U/N7dOU0qaW/cCUGVMCSX4QMREuc4gDRBi1wYd1w5DQZh8uk/8CMacfTMMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660443; c=relaxed/simple;
	bh=T21C/au/tuvTBrwLBzOHO/ngCMEJ9LQB0PnJ+o7cO48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKWW+11KlOUcXVNCEwnjZ4x45Mhum7kSOE9BLeUdrX5odKxIVIRLP+QYEJm8+RU5IPpQgwKcsme0pcyncQ4wIkAJvd3WhAzAKOxOEnMYZF9sZbLArIeQqUxUlalR2owKOwxcDW6wZ+oTxdI3tWUPYz6MM9X6tJ8dOhKHUjwrANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=DZc/VWcB; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="DZc/VWcB"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35115b52125so989543eec.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791660439; x=1792265239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ONbofROHEB35NS/5T323EfaoteCEiGhp0xJlYSlbpeU=;
        b=DZc/VWcBXE/7zuz3dO+iCewTqlpfi0WBfQAFI2PiG6fItnsv75UeMsyLLMlaDmzEhZ
         XEqEpqI27NLTELb7V1KXdgn8EPLyyVGjEy2XHo3541/gTgnFgwPS2isAhKfvu6jKgMo1
         ZgethWu+fgpuXo1+Y6YaWonGEWQE6eoKzO/fYpRSqSdxFbv+Z/z8GB6ICw919zdG6DI7
         LW5uHkRLyB97cfQpYo94Vwm2kbqYAgANHtSANEBOPq9VkKWZckewucgp3UuX7hyYZisS
         LfVsLuRkPwNXx/YwuwbQbSKqJ6NbPmNCLXFu7NRgAf3wdGKau4vbEPmp4ICWsj/HnOHt
         Dh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791660439; x=1792265239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ONbofROHEB35NS/5T323EfaoteCEiGhp0xJlYSlbpeU=;
        b=qjwYs8EvXHawX8Dt/+K2W+3cPxVQum3bLZb6+wGtWKvifrf+/ud5dO2EZyY9LnjyCM
         /VDq6lS1VZfCVP7fI5Mq9TUKBrobkBReTBxs5WurqGlxly7zX1RbXEiyGOqDhGY6FM8p
         DDWZc0spS9bmYHvfvT3yOIKVIu5hTyyad7n/+/f8elHWs5daqZ3VRoFwwItAw68UgX8E
         Z5Zlch6rwnpn3oMywbIJxsEJvwQHgwKln5dGRArABTCcElDxfLs0e3mFQeKR09fQzXry
         Z47hwbPepoR4WsjpRX+m/XDNKkuWJwobPlCWZIyIs7iZgbt1ohihK9bT41VvpHLZj6Qq
         oROQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgiQgAh09px/Wzm1La1dnKqBdlRje6DD23FI0QbxoedqWl3MkMuC984qCfMLDayeloRHtEVvM=@vger.kernel.org
X-Gm-Message-State: AFq9FYILRiSyC2VkWOe4+gfpCk0O0ev2rqWBuYqHD3XoaFl0EBBXwBWj
	hq0N4aF9yxLjsKxm60J7p8s5b2uniKPCAc4e3LbpMb2pAbR/AvZJ4TWx2lD6O61IwR0=
X-Gm-Gg: AYBFou0YNpleW2fz3YXFzdPJcCmoljlFLnGBOehWzJnjc6ZUHc5wWNoywfMBfWtYjhr
	1QGLcue8UCKZJK+iU5D72nIeTimDnLR8FH9wyTnbnAW0usukMg0NRca0+FaCRQy24cn8EMfjcZ0
	XGBlIyiTbHYMryE4780VLC4Qv2RHYvCPPhAA7dRRRUHsjCumEByen0PCnxmE0ktLAptKVq5Qwjv
	dTO12OdNHLBBIUqSBO5dbVeeeS1yBKZPxZti2ibk1HKSkF6LsOp/Kky83hftmdv0tqwFvqWGRLl
	Mr6p4E9HhN/Zv3ET06sxJPa8X8x0CQZV1tWigkKAS0PvRgzA6xu0z2mOrIbYrJ0Ax/o1ftdAVbm
	UHIx2jsErW8rmVMjjZmE1SvYrqTf48VBdYGxxFMEtqrM/sbzqQx+WepmHraRUcjX2aJFirWtQtg
	CYYWgBT5cp2BnwkqXH2Cc9287E4YwgBbHvF4AB1v5VuifcN4r70Lwx4WoXR+zuOsqVkBc5P4seU
	9C01IZLX95ezEnk8CyGJtJlBRnx4xhJ
X-Received: by 2002:a05:7300:8410:b0:353:599f:d63a with SMTP id 5a478bee46e88-3537e0202abmr7181873eec.17.1791660438526;
        Sat, 10 Oct 2026 12:27:18 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:9657:9541:a576:7d2f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm18641806eec.10.2026.10.10.12.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 12:27:18 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v2 2/2] eth: fbnic: return the page reference taken for a dropped Rx fragment
Date: Sun, 11 Oct 2026 04:26:50 +0900
Message-ID: <57e762aa85874571b506e5b5a55004029b4b2a5d.1791659860.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic_add_rx_frag() takes a page reference through
fbnic_page_pool_get_data(), which decrements the buffer's pagecnt_bias,
before handing the page to xdp_buff_add_frag().  xdp_buff_add_frag()
fails when the buffer already holds MAX_SKB_FRAGS fragments, and on that
path the reference is lost: add_frag_failed is set and the frame is
dropped, but the bias is not restored and fbnic_put_pkt_buff() only
returns the fragments that were actually attached.

The page is then never returned to the page pool.  A device that keeps
sending payload completions for one packet past MAX_SKB_FRAGS leaks a
page for every completion beyond the limit.

Restore pagecnt_bias on the failure path, the exact inverse of the get,
so fbnic_page_pool_drain() reclaims the page.

Fixes: 61f9a066c309 ("eth: fbnic: Use shinfo to track frags state on Rx")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index b4ca9f7e8bb2e..ba663fe7598f1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1076,6 +1076,8 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 
 	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
 	if (unlikely(!added)) {
+		/* Give back the reference fbnic_page_pool_get_data() took */
+		qt->sub1.rx_buf[pg_idx].pagecnt_bias++;
 		pkt->add_frag_failed = true;
 		netdev_err_once(nv->napi.dev,
 				"Failed to add fragment to xdp_buff\n");
-- 
2.43.0

