Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708477;
	b=a1gYY/rrc4/vwJ0ZOqI/UumfH/CTn5H6Mje5E/2uEAduq4gyM5HGuokCkn+jEN32kh7O
	 CApvRu4QSTYX42KFipJmPNJLDLoCRM4qqoPzp8TTPejIY7Kk4BL6NLWQMDKPq4DeP65lZ
	 O/kVPzc4OxrkNiz8hII8UCE6OhOLO0YrrEBVssMsHNYrI7xTx0PgW7uO6OILb2yArAik4
	 9jmVbKodxDL5mG+PCuHCHieh/FYay1xSfVv3eR13VDtjLLDfom7OpJVuyj8J2eDS+OnHI
	 BoriiC18PhZ+WIXeRU4/0OmQbgbULo7cVM2UwZRv8hQ3r3ymTkBK8zpgFahIG0Vn/7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ftzGpP0ulPi0xGwIl3ZzcJGVoGV7Otzfx0qZQUNaagQ=;
	b=CnjK6+TOm+lwk7ZEML1VDonTv0tSR4fRP3hpLlcgzT+0OsTV6/YldPCsOftnZnZoTkd4
	 jp9e+w//n6fntUVm+ht109sZZv/0tQrbSQLd0Sa4J4ikkeT9+NqwO1hvCl7oyMm+5Jyen
	 J58i43HtyCeZZXa2YPY2HNylfYOGHIyC7s1CeFvfQgnl2PaR87/bX3j785CMXas42vjL+
	 TOmmoOU6qILzcTyvrM9Bpv5GOkwtn5U2FU8m6Jaumjr+Em3kunOVMOClMFVcAktOOk0qH
	 14NCKxE4Se7QvNOPnDCo7lJCukmxBK9k0QIcJZnLnQqycPJ1QNuu3qC4jfptpn/cbOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fvh2JQpB;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864FE606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 864FE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fvh2JQpB
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so34848025e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793708476; x=1794313276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftzGpP0ulPi0xGwIl3ZzcJGVoGV7Otzfx0qZQUNaagQ=;
        b=fvh2JQpBOu6cM29Ph7fUxFpEYbdaym81ejC6CL8VJiAP7BOyDllLvM8BGNfB44Hfx9
         Ozi4LlYF8HzffdDY8ExE4TxcuiTSfS+woc4hiVBfCp9+LnI4HjfhgrQ3aIqqaTspn6Oi
         In6aaRZG8QYujzoip+UPV5MJ1pSQ8dAKxjoNgE+G3aFeskF6jnD9WJI0mpMgRvFj/9D/
         ZlXMDuYgtMOVCcKICTfFYDprdp5J9/N8wJ+I9YOMZDJkvzEF/pKjgSy+p5hykfYcMGKI
         8VJQL8q3/BUTBpEeuGK49JPTRbUs6eIOrHEss+F+BtHJX0sCez5Q49zVvnB1fpwkWsnQ
         F4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793708476; x=1794313276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftzGpP0ulPi0xGwIl3ZzcJGVoGV7Otzfx0qZQUNaagQ=;
        b=RycrD0Cy5H/xKAwso4KxdtuXE+wf1pzsKDaPNd64XiJiKv4/Ne5OHAEuhTjr3fJ6Su
         ifX3p139v8+cXYfrB+qvD4Gf30eYWS644bmKpTJL82aFxXjjiU/hH2oDhtCsBe6sKHzk
         7IJQbtr7IRjmHh4b4cGu0eGliyFWUpl3y8g+s62ekTGip7ob3n2efiOBxRX8jtsPfxts
         7BypZlyv3j0OJsgJyvLBPaD39vR3BgxFBlGGwSr0z/Rq5vOX1b5Ykuu2wJ+97Sj6n+99
         BZ+5OAW5JCf+TFU3RYHXPkXURYd9ToaiFf1/+4/hYCkqnUq6/rnTGZr33UeXA60kTePO
         0fmA==
X-Forwarded-Encrypted: i=1; AKwUvBw+21itAndGwYzxUvT/5avYHe6GOuYCQdcMzLTppgnhxtmApTCeqgk+WBwLS4cSOT8RKuDe5+k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AnaGUy4WQGs1OaeLr3WemSNgY3XFTWwdbv7qhm5y8B90vP00J
	3Woy2Zr5xk4FDEQMWdfyNqvn1fKyaR4f/efY3KhzLotfhMorCimXKFuu
X-Gm-Gg: AYBFou0eNzZ1tDTJNtlBcGjB2bPa2CHyXVb7Hkdydq3QD3+9G5psdaOtoFyJxDVkmgp
	bpl2Kl8OFSAs9KkbacLvEkrxXYNnvUt/a9VkKJ4lVWdCunu3KVBeOvPZ/ZZjpBf2yHCkhWcdMht
	VHjSHPP6NtYx+P3tbpk80N+1ePIdirifRD94PcHx3jJh162guoPkQdI0RmaSAaI8aWGzzQi+OgE
	rPw61+M8cK5mLX7aBvKBvtlbyXq0Zi+mrdI292NkeLygitbc/hYMxoPBeo447zRlPnpqP96Mkl1
	eIRsP5ewAl4QMS0HCefC5adVK5uzu/HV/gLeTtKaQLtgGYgSq4WU1md17NtTLJBwRi4ds5TKK2q
	HD8ug7T2RmzD9bhfVBP5iZlx8maRWBSjw99TaI+swB0H53Oc8pFAERIkmug2Ezvxsj2Z4NGkxD+
	o7Ve9AZxi4wAggGTMbMNFF3uNyCZoerA990LpKc7hOJUVG1LGqnrCCHc8WcsdUEOd8L8ZGPY3kt
	VYyGHU4Zby7L2cp0SgeFC8SUYVzaOsQzwdpcXpYdymZaF5R9bey0Jf3XF9z1k7syTazPga83G5u
	MeCi8jHOuvKNNGkoZ/Aq7N7grSfj+kXU37fTf8G9YFvt3AEdFMpEr8QLKOIGbO/NYQVp4DPdavZ
	ztzjLXwii/4vpKkosDkqFvPcsFIpmHOuSo4caWyi7Ac73WXTI6W3Or8xlaR+qqLXfE2HPiM8pa9
	AxwhxoYB1YoJTkU5Sv2Ode2tQ=
X-Received: by 2002:a05:600c:a00a:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4ac19802310mr295970745e9.35.1793708475722;
        Tue, 03 Nov 2026 04:21:15 -0800 (PST)
Received: from uk-shared-4.. ([62.89.143.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm105111815e9.14.2026.11.03.04.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:21:14 -0800 (PST)
From: Peter Morrow <pdmorrow@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Morrow <pdmorrow@gmail.com>
Subject: [PATCH net-next] net/mlx4: drop the unused is_supported callback
Date: Tue,  3 Nov 2026 12:21:08 +0000
Message-ID: <20261103122109.1798144-1-pdmorrow@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 557d80138618 ("net/mlx4: always create the eth and ib
auxiliary devices"), both is_supported callbacks return true, so the
checks in add_drivers() and delete_drivers() no longer decide
anything. Drop the callbacks and keep the aux device table as an array
of suffixes.

Tested with this change applied to 6.12.113 on an Azure VM with two
ConnectX-3 VFs: both auxiliary devices are created at boot, and
removing mlx4_ib, mlx4_en and mlx4_core deletes them cleanly.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Peter Morrow <pdmorrow@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx4/intf.c | 44 ++++-------------------
 1 file changed, 6 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index 31860b4ab..1e136203b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/intf.c
+++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
@@ -41,23 +41,7 @@
 static DEFINE_MUTEX(intf_mutex);
 static DEFINE_IDA(mlx4_adev_ida);
 
-static bool is_eth_supported(struct mlx4_dev *dev)
-{
-	return true;
-}
-
-static bool is_ib_supported(struct mlx4_dev *dev)
-{
-	return true;
-}
-
-static const struct mlx4_adev_device {
-	const char *suffix;
-	bool (*is_supported)(struct mlx4_dev *dev);
-} mlx4_adev_devices[] = {
-	{ "eth", is_eth_supported },
-	{ "ib", is_ib_supported },
-};
+static const char *const mlx4_adev_devices[] = { "eth", "ib" };
 
 int mlx4_adev_init(struct mlx4_dev *dev)
 {
@@ -98,8 +82,8 @@ static void adev_release(struct device *dev)
 
 static struct mlx4_adev *add_adev(struct mlx4_dev *dev, int idx)
 {
+	const char *suffix = mlx4_adev_devices[idx];
 	struct mlx4_priv *priv = mlx4_priv(dev);
-	const char *suffix = mlx4_adev_devices[idx].suffix;
 	struct auxiliary_device *adev;
 	struct mlx4_adev *madev;
 	int ret;
@@ -211,7 +195,7 @@ int mlx4_do_bond(struct mlx4_dev *dev, bool enable)
 		priv->adev[i] = add_adev(dev, i);
 		if (IS_ERR(priv->adev[i])) {
 			mlx4_warn(dev, "Device[%d] (%s) failed to load\n", i,
-				  mlx4_adev_devices[i].suffix);
+				  mlx4_adev_devices[i]);
 			priv->adev[i] = NULL;
 			continue;
 		}
@@ -258,21 +242,13 @@ static int add_drivers(struct mlx4_dev *dev)
 	int i, ret = 0;
 
 	for (i = 0; i < ARRAY_SIZE(mlx4_adev_devices); i++) {
-		bool is_supported = false;
-
 		if (priv->adev[i])
 			continue;
 
-		if (mlx4_adev_devices[i].is_supported)
-			is_supported = mlx4_adev_devices[i].is_supported(dev);
-
-		if (!is_supported)
-			continue;
-
 		priv->adev[i] = add_adev(dev, i);
 		if (IS_ERR(priv->adev[i])) {
 			mlx4_warn(dev, "Device[%d] (%s) failed to load\n", i,
-				  mlx4_adev_devices[i].suffix);
+				  mlx4_adev_devices[i]);
 			/* We continue to rescan drivers and leave to the caller
 			 * to make decision if to release everything or
 			 * continue. */
@@ -286,23 +262,15 @@ static int add_drivers(struct mlx4_dev *dev)
 static void delete_drivers(struct mlx4_dev *dev)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
-	bool delete_all;
 	int i;
 
-	delete_all = !(dev->persist->interface_state & MLX4_INTERFACE_STATE_UP);
+	if (dev->persist->interface_state & MLX4_INTERFACE_STATE_UP)
+		return;
 
 	for (i = ARRAY_SIZE(mlx4_adev_devices) - 1; i >= 0; i--) {
-		bool is_supported = false;
-
 		if (!priv->adev[i])
 			continue;
 
-		if (mlx4_adev_devices[i].is_supported && !delete_all)
-			is_supported = mlx4_adev_devices[i].is_supported(dev);
-
-		if (is_supported)
-			continue;
-
 		del_adev(&priv->adev[i]->adev);
 		priv->adev[i] = NULL;
 	}
-- 
2.47.3

