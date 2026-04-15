Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F87260D
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776221597; cv=none; b=s1LbVz1P9BIYvqNxXq/XsYehPw0KIy9bj4Bz2EM7gwxNYxxsad11gveZNYkySaY7TT9gTqKeIDGTvzLN+zhReBN9/qDlHQQtr3OIIDprmvdK7GDIKMn7j/ngPfH6vHbfy0VYSOeGPcYL/qjwEs+yj3FBkUeyt4LSVVLn9jwgags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776221597; c=relaxed/simple;
	bh=haA4kYFbvqtiqFuCHUW5iCmkV1x3Oma+LWqgQLmvkUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mdfo3rOW+uWxBRPvQOuTAKlqIvBkYRPH2YJCvk6/Ra1g0/fglo/12BoGS6rd70XP9ZWPFziAN7WXq1W+J+icrw4B1r+UudUR5hq0HtcBf5U3QCrU0qOHN/XJBZbi/HGlu2GNi+kn2krlJl7ajbmRVBYnlz4hzcjFdt5v+mRrMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=tBTq3uwi; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="tBTq3uwi"
Received: from ms-a2 (92.192.13.160.dy.iij4u.or.jp [160.13.192.92])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63F2qSsp035194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 Apr 2026 11:52:28 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=3+5pFTC9L4TcAgd/RnB8ZvQWCS/U/+fZRKbBPq/6RR8=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776221548; v=1;
        b=tBTq3uwiwD5z03dO8vqZL864WNI/kPy8x1eH0MmgDZvWKMwbMaoArTJhH5akHj6G
         h9MxXMI8bXFLK0LoRSQ2y2SG1CSrfoDeWBKqQ5/VuRdyxDXoAqOKWOb8u/UkoASl
         5egcH5Wzpcth3LEeVwSQNetM7QoUip/zexFeGD6UuyDEiae69wzl0FB6op7GRmnV
         zZIKS0lYc4SNbXwOhcpBqYw6rMH57ISlnWrH7YjWkSMeBtVs1xanAcKBGzdAUo5/
         W0LEIhjWVXIbd80x8mC1UGUPZITzlv9kxqVCvwqWv4DASI9i5VWMtO2J4t7wIgx5
         AKIyR5dHuxP2fz++0I7h7g==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>,
        stable@vger.kernel.org
Subject: [PATCH iwl-net v2] igc: fix potential skb leak in igc_fpe_xmit_smd_frame()
Date: Wed, 15 Apr 2026 02:52:18 +0000
Message-ID: <20260415025226.114115-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When igc_fpe_init_tx_descriptor() fails, no one takes care of an
allocated skb, leaking it. [1]
Use dev_kfree_skb_any() on failure.

Tested on an I226 adapter with the following command, while injecting
faults in igc_fpe_init_tx_descriptor() to trigger the error path.
 # ethtool --set-mm $DEV verify-enabled on tx-enabled on pmac-enabled on

[1]
unreferenced object 0xffff888113c6cdc0 (size 224):
...
  backtrace (crc be3d3fda):
    kmem_cache_alloc_node_noprof+0x3b1/0x410
    __alloc_skb+0xde/0x830
    igc_fpe_xmit_smd_frame.isra.0+0xad/0x1b0
    igc_fpe_send_mpacket+0x37/0x90
    ethtool_mmsv_verify_timer+0x15e/0x300

Cc: stable@vger.kernel.org
Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
Changes:
  v2:
    - change to idiomatic style with goto (Simon)
    - add Cc to stable (Alex)
    - add reprodunction steps (Alex)
  v1: https://lore.kernel.org/all/20260329145122.126040-1-kohei@enjuk.jp/
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 8a110145bfee..02dd9f0290a3 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -109,10 +109,16 @@ static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter,
 	__netif_tx_lock(nq, cpu);
 
 	err = igc_fpe_init_tx_descriptor(ring, skb, type);
-	igc_flush_tx_descriptors(ring);
+	if (err)
+		goto err_free_skb_any;
 
+	igc_flush_tx_descriptors(ring);
 	__netif_tx_unlock(nq);
+	return 0;
 
+err_free_skb_any:
+	__netif_tx_unlock(nq);
+	dev_kfree_skb_any(skb);
 	return err;
 }
 
-- 
2.51.0

