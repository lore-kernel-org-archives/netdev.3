Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AE1E98EF
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877075; cv=none; b=aAn31KN7e9LzDOq8tK1yzeJTy+/3I4/pH7qY5DXHjmnucNGqnYRf6T1eLP5AMe+aZXWCxam0qOIvaF7oWF7bdVEANjicxCmo7W+0c/sIdhj/ek7xldgj53pQbdC+1iySwQxQS7hn3RHjKnaSeCKq3c+SsJgES/g639UhUOIucMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877075; c=relaxed/simple;
	bh=6jn30E8Tno20cIo9DWoCXmN53tPWQD+UmHIEU8Fs7WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEiQlPsI53WDJb6pemplWrKxDNbFp/ZzjoHt2tivD/34+N9gaC/Do74uiY467cgvCHoExENyID1SrY5J5ZI99a5llmWMA0BmH7Fa4dRvfwDHBMhTjzugXgHLsrsEIzHC0njwyeybf2QtsE2ElfZlqPHDDi5rf38zCiLDIJZ3z8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Vbze38Tg; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Vbze38Tg"
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60VGV9GY039498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Feb 2026 01:31:10 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=FZErLBRF0I98rij84pRgNIEgwO/sWc9BcJpuexvaePw=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769877070; v=1;
        b=Vbze38TgoAQe5w5cw4czspmc+AAdg/VbTnkrzKBm/r+p0HYQOM4wmEynGctzSU3M
         l9u7KJhcD2fMF3IFvCwbtri6gyu457xSVPZ0A6o57oeY1goNRI97hfy44Lc0F8ht
         RYZt36l+PpFLBUTUqPEo3/f+a3szzUH36x+sryt+ehspLfGRrwkjxZFW9EO9xWVI
         GOtEU2c+hMJ1WdMHZYVNfzZlZiDdO9JaBpyzSNZ64X1glI9HbTJfHP/zYahb1y/z
         1+6nVi6qVDVvDtaFMasVEo6nPYrsdH2HhfS2XoNjBbD6wF9v0Lm9Kczi/0ElSdw2
         cWRIji9A8/gjPqgSTmi7rA==
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
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>,
        Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH v2 iwl-next 2/3] igc: expose RSS key via ethtool get_rxfh
Date: Sat, 31 Jan 2026 16:29:37 +0000
Message-ID: <20260131163037.88108-3-kohei@enjuk.jp>
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

Implement igc_ethtool_get_rxfh_key_size() and extend
igc_ethtool_get_rxfh() to return the RSS key to userspace.

This can be tested using `ethtool -x <dev>`.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 1b4075e7e8e6..661b044073ca 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1502,6 +1502,11 @@ void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
 	}
 }
 
+static u32 igc_ethtool_get_rxfh_key_size(struct net_device *netdev)
+{
+	return IGC_RSS_KEY_SIZE;
+}
+
 static u32 igc_ethtool_get_rxfh_indir_size(struct net_device *netdev)
 {
 	return IGC_RETA_SIZE;
@@ -1514,10 +1519,13 @@ static int igc_ethtool_get_rxfh(struct net_device *netdev,
 	int i;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
-	if (!rxfh->indir)
-		return 0;
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		rxfh->indir[i] = adapter->rss_indir_tbl[i];
+
+	if (rxfh->indir)
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			rxfh->indir[i] = adapter->rss_indir_tbl[i];
+
+	if (rxfh->key)
+		memcpy(rxfh->key, adapter->rss_key, sizeof(adapter->rss_key));
 
 	return 0;
 }
@@ -2195,6 +2203,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.get_rxnfc		= igc_ethtool_get_rxnfc,
 	.set_rxnfc		= igc_ethtool_set_rxnfc,
 	.get_rx_ring_count	= igc_ethtool_get_rx_ring_count,
+	.get_rxfh_key_size	= igc_ethtool_get_rxfh_key_size,
 	.get_rxfh_indir_size	= igc_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= igc_ethtool_get_rxfh,
 	.set_rxfh		= igc_ethtool_set_rxfh,
-- 
2.51.0

