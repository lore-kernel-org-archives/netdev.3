Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F604DDB58
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775552; cv=none; b=LyLf0XkIs5uclQ404hN/SbELEnweE4kQrZhuXAPzjRDurbFKai4jUangbZL+WN8YtjyfqrA1/LaKajAztolCMjq6kJAIiqPLafPyLC/Ktt8VhU4XPv5XnbdrjE4/tbmPKCm6jbBUWJ+h48yUUy9Gys3nDgvdnl0YR3VrxtGzN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775552; c=relaxed/simple;
	bh=A4FkOd1rsHBO9TbAATH42i8t6LdywS4oKcOnDIsJL6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHd0KRVZod9re2+T656vLVJZRDGPLYi4e4mksSyEEU4s7w/d5u6Lf3xVyK6DdcCkyE39c1XWbPxI8fDr74Ce+iW+Jr7b5Od5PaM94XXDzH14Qt1sAOlqXztJlDDGEzf8Uy35qa5oFQhbHVstmsk3jLv9VGmhzg6VFtREBt3xBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDFEAdnq; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDFEAdnq"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so33526235e9.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790775536; x=1791380336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vqNw45I5i0A+TvN7Yvp1p4lxx6mkgXUC3KRKlj0F9r4=;
        b=jDFEAdnqQQfoyp8qvfvoTdx4GHvMSrU14HM1MkbuVJocHbuNw/6oskblOn40/H/1tN
         yXvxfBFYrMTgLczVFwmzqr5s/FdqBZi/Eh4gIsfaVWLDts1IOvapNhTbXteMzZWhP+xp
         Po1N7NZoZlj6GM4LuFTYZdK6VT1fv40Kp25axbajQ7Z+f54HSO7mc6dvBc2Kh9+AkkEQ
         nP8YBvtaDd6NpTPAt/a2QCXpTZRd/k2WJmWWm8l72cXH2ahRciOAbx4TlEyIF5Qg3y2H
         2emYh4uQBU7X4YZj/hVVXpy32LjDypbtusFkpLkaETdTnJ4p8aWQC50SiGbUlf6gvi67
         aI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790775536; x=1791380336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vqNw45I5i0A+TvN7Yvp1p4lxx6mkgXUC3KRKlj0F9r4=;
        b=U9X3faiTvtAgKodxvssOxV64FK2/dYAI8KaBjRjKtiSySz0XGCuiVuVtjrH3P+13Re
         PkalXWB6Pk0VsdeJ6MKb5Naal6E5P+to16NcPPcmZLw6Lm7JdFH6Y6m7ZoQvKSzW1T1F
         yWrvK0etRBcbwf+zhkuLBdjmnBKIO16KqynrYW0Gecu8lnMMu4/ue0w2oW6GpU9XmsoL
         5Uszw7LgGavrcMg1LRv2y94Oi/dtg5sCcJ4aT1leN7SobLMPy2Icyl8ZiX64/nXq+wP+
         HUIk8MsxibL2BGPphjtypLwu9XwfhhukzNAr+k+qZn9EMIKi+wHSi63TTpB0bBD2w8lX
         9pTA==
X-Gm-Message-State: AFuF++nRMj0+142C6NXA2B+jTmdOPdgoBx9Eyi3lLuRWmTgUG1dZBXEE
	EhfxSkmPwuIYvVtw7CmTg16GpMAOtVvJUhzVmkdpxCPEtq+p8RSx3hjEdoUAqVik
X-Gm-Gg: AYBFou3ktvnBRMjh6aVCvFtSrqoA6eXrKV+VzqIxKPMFFyAuqaWUreSk28BfLSGj6Qz
	Mq4Aj29SYJHcwYw4lsdenHKKN2JwYXbPYVPFHxNNbjKTvcSDg/x/dqWYO5kszkOfsMAjsWK2fJc
	/qezYC6WOYBLBh1+3zlHB7KlAu/Kv3B9Gbyr1aXosoy5hCpNg8+ulXgpZj6Na/12ucMcaUK6ju5
	xfekddthxFB8jewAoBAiPNg/knFp7SB3t0M53FvX57p/OgHlyrHjLPS47a3n9d4DZFmF50ZRmND
	dIiRZe2xO6XolEdUjxDjUYQQ6uPoTzzN6cs+Ge6AwxzKhOAbHqoyN2fc138yG63klS00R0PpCAp
	iorCxP8tGtDV4nxuufgrCrJAsT+l7IYa8mYVTl+g1mVT9QXhNQ34OakqSirONpCt5lWb7rieeZE
	b8LLuv/QF4rhxvyFIrzPvEChUvdE/ai7pv5M+jrbRK0ScU37NL6x+jRtrjrmlXjXwicMydw+dmy
	JlA1+sD4cQU90Px9g2rXNYGtrW5dK4LgcueML1p
X-Received: by 2002:a05:600c:3145:b0:49f:bd3c:bc1a with SMTP id 5b1f17b1804b1-4a01b00d9bamr25280835e9.21.1790775535365;
        Wed, 30 Sep 2026 06:38:55 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029d61e4sm3504730f8f.15.2026.09.30.06.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:38:54 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	jacob.e.keller@intel.com,
	joe@dama.to,
	suraj.gupta2@amd.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net v2] net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
Date: Wed, 30 Sep 2026 16:38:51 +0300
Message-ID: <20260930133851.663023-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_dma_bd_release() walks the RX ring to unmap and free every
receive buffer before releasing it, but frees the TX descriptor ring
with dma_free_coherent() alone.  Any descriptor that
axienet_free_tx_chain() had not yet reclaimed still holds its skb and
its streaming DMA mapping, and both are lost.

axienet_stop() disables TX NAPI and stops the DMA engine before calling
it, so nothing reclaims those descriptors afterwards.  Bringing the
interface down while frames are in flight therefore leaks up to
lp->tx_bd_num skbs and mappings each time.

Walk the TX ring the way axienet_dma_err_handler() already does: unmap
every descriptor whose cntrl is still set - axienet_free_tx_chain()
clears it on reclaim - and free any skb still attached, as a drop since
it was never transmitted.  This relies on axienet_stop() having stopped
the DMA engine first, as the RX walk in the same function already does.

tx_bd_v is NULL when axienet_dma_bd_init() did not get as far as
allocating it: axienet_open() does not check the result of the reset
that runs it.  dma_free_coherent() accepts that, so skip the walk then
too, and drop the comment claiming the ring is always allocated.  On
the axienet_dma_bd_init() error path the TX ring has just been
allocated zeroed, so the walk does nothing.

This was reported by the Sashiko AI review bot.

Tested on an AXI Ethernet MAC behind a PCIe endpoint: traffic passes,
and after each of ten down/up cycles and five module reloads, all made
with traffic running and each running axienet_dma_bd_release(), traffic
resumes and nothing is logged.  The leak itself was not measured.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

Notes:
    Changes in v2:
    - Skip the TX walk when tx_bd_v is NULL, which axienet_open() allows
      when the reset fails; v1 would have dereferenced it where the old
      dma_free_coherent() did not (Sashiko).  Drop the comment that claimed
      the ring is always allocated.
    - Free the skbs with dev_kfree_skb_any(), so they count as drops as in
      axienet_dma_err_handler(), rather than as consumed (Sashiko).
    - Say that the walk relies on axienet_stop() stopping the DMA engine
      first, rather than stating it as a guarantee (Sashiko).
    - Kept Jacob's Reviewed-by, as the changes are small; please say if
      that is not OK.
    - The hardware test is v1's.  The changes do not touch the path it
      exercised other than how the freed skbs are accounted.
    - v1: https://lore.kernel.org/netdev/20260927081034.350422-1-maimon.sagi@gmail.com/

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1722b7038f34..8bf27e20e103 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -186,7 +186,28 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 	int i;
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	/* If we end up here, tx_bd_v must have been DMA allocated. */
+	/* tx_bd_v is NULL if axienet_dma_bd_init() did not get as far as
+	 * allocating it; dma_free_coherent() below accepts that.
+	 */
+	for (i = 0; lp->tx_bd_v && i < lp->tx_bd_num; i++) {
+		struct axidma_bd *cur_p = &lp->tx_bd_v[i];
+
+		/* axienet_free_tx_chain() clears cntrl when it reclaims a
+		 * descriptor, so a non-zero value means the mapping is live.
+		 */
+		if (cur_p->cntrl) {
+			dma_addr_t addr = desc_get_phys_addr(lp, cur_p);
+
+			dma_unmap_single(lp->dev, addr,
+					 (cur_p->cntrl &
+					  XAXIDMA_BD_CTRL_LENGTH_MASK),
+					 DMA_TO_DEVICE);
+		}
+		/* never transmitted, so account it as a drop */
+		if (cur_p->skb)
+			dev_kfree_skb_any(cur_p->skb);
+	}
+
 	dma_free_coherent(lp->dev,
 			  sizeof(*lp->tx_bd_v) * lp->tx_bd_num,
 			  lp->tx_bd_v,

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.47.0

