Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E04C2F6565
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317396; cv=none; b=EKO8Qe2SuaAsjcb9QMt6EDkKPpNx30yXuSoAiJ/Dq8jMnoH/ePvGW8nBcHT71Fxq3eAjc4h/alni+e7PWYv9ERFlsvklrlO2YzFBNAHtuKuhSM2L+V3sOtoUXyyUDxU5dGu05+XNoQv6aLU7fkq1IICNbZtMCFWrqU2qM3hYQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317396; c=relaxed/simple;
	bh=53NTfvMC3doPOJjgloU2Tc4mwB+X7Dj+8zIOLtSD3xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PuIeQB8nj7qnHtUqRZl/oJsn0gzc48Xyr6M2XGUWL++qzXzSryKKkFv+Ueun62c6RWsIHl126Kir8Z+mMmPOmdR/ju1Ta3Wv5SAKTzO/86HdCh+z1GmGFhyQNGVl42p4ZgZMzAFeVyB7VNoiMv858vvTjDoPcxdJDX6k6CyvX48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHmkkxVE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHmkkxVE"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-930c0f9c1b1so63499885a.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 19:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788317394; x=1788922194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0nHL3Rub7HkNOebtTsag0uOrFQQ/OX5K14wVSBqNwk=;
        b=nHmkkxVErjpkZjttc8IElFFuImvFA1wCAJKlNcAwVVi4SQeA+a/R9LBJEOQx1Moaah
         VqdRreHP3Ua8AsXigcG2/+JH7SF0luKBak14eZqEQrkbf8hlGVYMeBc9ngwLCYv7jca5
         6hkdF4pFzZcssmvKE2Pd0zJru8nXbsLY3dIgnGVGP7dPN5Oq5BAx2DlYE3IpwYyYZS00
         r2rtAamt6WEkIhV3qgzX0O/ZqbyywePmIVBtjHAMfj8J6HF/RaItTgTFBa/iGKPyLQ5L
         ZcWCp0Td9yQNMFZtyaMTYnafkgR/ToCAEiuyizskHkJQIvkxx0mBZpnCs+iDWK1UEYQy
         giyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788317394; x=1788922194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0nHL3Rub7HkNOebtTsag0uOrFQQ/OX5K14wVSBqNwk=;
        b=TK2ifDZYmgldEC3s5HNpJfSl//xId6kn88IoadqKl7DCXvs7wvbsAnAFqrN1VhPdWs
         TL2nxVPtPtKVs8zeSGVrNBHDp+r6Di9HjBCHMenDBBY0toidsXLoj1BsgG+BTy+KL282
         fkx8jiVqA4anygar/953L3fDTopY0wnrUI/EnUq9/xehKlUcXRbab3fcxn0fTGsWAMka
         7B95UAzEV2DgVO9gZ0iO7GUTZZ49SAffCXKHAFe146WfN55Cp+yI35Ep1vmXzYBCCi41
         hBQOFdRieU0ERUUzUaDPKQYu3RnCOXL3sPQdB+Qat/9rK8dNWWiFXLHBdSYe02w/2dLg
         VLQA==
X-Forwarded-Encrypted: i=1; AHgh+RoGmpbJYb+YGcUM76m0yif7CBSquFNootEJ+QUn/cTrs/YRUJPfH5N5S7FALBVdLCb4xqlEbj8=@vger.kernel.org
X-Gm-Message-State: AFuF++lHLjgu1xveguCYKUFHToEIXnH1p/l9f16rkoQRxkKc5ZVZEVV+
	Af6iEyHYpltwoIkyOm5AOIRD7+sT7vROb8d40CW7J8GHOcv4w006/ACn
X-Gm-Gg: AR+sD138RNOWb9CjcIhzVqwFBo6uCemae0g5rrbGSusDiIpAoU8BImQrIbHgu+YUFUZ
	7J8z08Twu8ScBHdfSBVrIUCbOEyL2DkKYD+rkEd1ncba2eKzoJBm1yV0dcky7Fae9ssN53Y5vBI
	3wVUfROM6fU7WepcNGRfc0A396OIkkMnNnVVhB5WtcVo86gXaHwOIOVdnAT6r7Q3NY4BhnQYkqF
	DHgBD1ow0rQrs9vfQZ+svwya7s6GH76pCTCLCOaZb00HJSg7ySQJ+9lrRiAKCu5w2MQp6rBElHH
	pLHA7B/ZR3mK/mhXc5Q8MTZMJrLoEz+xui3uxzFAz2KfRbLb0VjoCbs9YGao2lfSHEZdHpyL4Pl
	u5LnvqJz3DA4kdsJLFLXuLijQM0abjUz3S+UAjtgR/Fyxc+hDMufiF8fK4W3pUMuoa8hrDEFnud
	q4B7qGcr8+wSaxzPM6nQHAZwP8OdqOs8fhLeulQGkK89EBE1oupL15cQG8Tdo7K1JFzwaFuHVfD
	BaRoiD7bFLyAB76a4Qe3KmwnXe9
X-Received: by 2002:a05:620a:4454:b0:930:f337:ebeb with SMTP id af79cd13be357-93960cdf971mr203979685a.12.1788317393986;
        Tue, 01 Sep 2026 19:49:53 -0700 (PDT)
Received: from elster-wsl2.hq.laserthermal.com ([2606:8e80:692f:3310:f12b:2639:daa3:59d6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f1539f0sm95716785a.10.2026.09.01.19.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 19:49:53 -0700 (PDT)
From: Taylor Bates <tmbates12@gmail.com>
To: idosch@nvidia.com,
	petrm@nvidia.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amcohen@nvidia.com,
	netdev@vger.kernel.org,
	Taylor Bates <tmbates12@gmail.com>
Subject: [PATCH net] mlxsw: spectrum_ptp: Fix napi_gro_receive() call from GC workqueue context
Date: Tue,  1 Sep 2026 22:49:46 -0400
Message-ID: <20260902024949.2273997-1-tmbates12@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mlxsw_sp1_ptp_ht_gc_collect() is run from the PTP
garbage-collection workqueue, rather than the NAPI poll context. For any
unmatched PTP entries carrying an SKB, it calls
mlxsw_sp1_ptp_unmatched_finish() -> mlxsw_sp1_ptp_packet_finish(). For
ingress packets, this calls mlxsw_sp_rx_listener_no_mark_func(). The end
of that function is the following:

    skb->protocol = eth_type_trans(skb, skb->dev);
    napi_gro_receive(mlxsw_skb_cb(skb)->rx_md_info.napi, skb);

The napi pointer is one that was placed in the SKB control block when the
trapped packet was received in the NAPI context. Later, when the GC reaps
the unmatched entry (up to MLXSW_SP1_PTP_HT_GC_TIMEOUT later), the call to
napi_gro_receive() mutates the NAPI instance's GRO list, which is unsafe
if the poll is running concurrently on another CPU.

In mlxsw_sp1_ptp_ht_gc_collect(), local_bh_disable() is called to prevent
softirq processing, but this only applies to the local CPU. Additionally,
its comment is stale. It states that mlxsw_sp1_ptp_unmatched_finish()
invokes netif_receive_skb(). This has not been accurate since the
referenced commit; this patch makes that comment accurate again.
mlxsw_pci_napi_devs_init() calls netif_threaded_enable() on the NAPI RX
net_device without any conditions. The NAPI instance's poll, which may be
running concurrent to the GC, is running as an independently-scheduled
kthread which may be on a different CPU. The call to local_bh_disable()
does not guard against this.

If a tx-timestamp timeout produces an unmatched entry (which can be easily
reproduced by running ptp4l and waiting for a port to reach the
UNCALIBRATED/SLAVE state) while the owning NAPI thread is in the middle of
a poll on another CPU, both sides mutate the GRO list concurrently, as
shown below:

  [39.846] port 1 (swp1): MASTER to UNCALIBRATED on RS_SLAVE
  list_add corruption. next->prev should be prev (ffff8d620faf4138), but was ffff8d624150f700. (next=ffff8d620faf4138).
  kernel BUG at lib/list_debug.c:29!
  Oops: invalid opcode: 0000 [#1] SMP PTI
  CPU: 1 UID: 0 PID: 539 Comm: napi/mlxsw_rx-0 Not tainted 6.18.48 #1-NixOS PREEMPT(lazy)
  Hardware name: Mellanox Technologies Ltd. MSN2410/VMOD0001, BIOS 4.6.5 09/13/2018
  RIP: 0010:__list_add_valid_or_report+0x79/0xb0
  RSP: 0018:ffffcdf8c0f27c08 EFLAGS: 00010246
  RAX: 0000000000000075 RBX: ffff8d624150fd00 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8d6315d1e540
  RBP: ffff8d620faf4070 R08: 0000000000000000 R09: 00000000ffffdfff
  R10: ffffffffa5c60fe0 R11: ffffcdf8c0f27ab8 R12: 0000000000000003
  R13: 000000000000003d R14: 00000000000001bc R15: 0000000000000001
  FS:  0000000000000000(0000) GS:ffff8d636f63f000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000562689a60c24 CR3: 000000015f224004 CR4: 00000000001726f0
  Call Trace:
  <TASK>
  gro_receive_skb+0xee/0x230
  mlxsw_sp1_ptp_got_packet+0x61/0x140 [mlxsw_spectrum]
  mlxsw_core_skb_receive+0xdf/0x1b0 [mlxsw_core]
  mlxsw_pci_napi_poll_cq_rx+0x780/0x9d0 [mlxsw_pci]
  __napi_poll+0x31/0x1e0
  napi_threaded_poll_loop+0x16b/0x1c0
  napi_threaded_poll+0x71/0xa0
  kthread+0xfb/0x260
  ret_from_fork+0x22d/0x260
  ret_from_fork_asm+0x1a/0x30
  </TASK>
  Kernel panic - not syncing: Fatal exception in interrupt

The machinery that leads to this kernel panic has not been changed between
6.18.48 and mainline.

This patch adds an ingress-delivery helper for the PTP packet_finish()
path that calls netif_receive_skb() instead of napi_gro_receive().
netif_receive_skb(), unlike napi_gro_receive(), can be called from outside
of the NAPI instance's poll context, which can occur at the call site for
this path. RX stats accounting and the skb->dev assignment are still
preserved; the only change is the delivery call itself.

This removes GRO batching for any PTP event traffic received by the mlxsw
trap, but given the relatively low volume of traffic characteristic of the
protocol, and impact limited to only Spectrum-1 ASICs, this is an
acceptable solution.

Fixes: 1ba06ca96ca2 ("mlxsw: Switch to napi_gro_receive()")
Signed-off-by: Taylor Bates <tmbates12@gmail.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_ptp.c    | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index 9939749c47bc..9c5862f4e16a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -572,6 +572,38 @@ mlxsw_sp1_ptp_unmatched_remove(struct mlxsw_sp *mlxsw_sp,
 			       mlxsw_sp1_ptp_unmatched_ht_params);
 }
 
+/* mlxsw_sp1_ptp_packet_finish() is reached both from the NAPI poll context
+ * (mlxsw_sp1_ptp_got_packet(), mlxsw_sp1_ptp_got_piece() and
+ * mlxsw_sp1_packet_timestamp()) and from process context, by way of the GC
+ * workqueue (mlxsw_sp1_ptp_ht_gc_collect() ->
+ * mlxsw_sp1_ptp_unmatched_finish()).
+ *
+ * mlxsw_sp_rx_listener_no_mark_func() ends in napi_gro_receive(), using the
+ * NAPI pointer that was placed in the SKB control block when the trapped
+ * packet was received in the NAPI context. That pointer may only be used
+ * from its own poll context, which this call site cannot guarantee.
+ *
+ * netif_receive_skb(), unlike napi_gro_receive(), can be called from outside
+ * of the NAPI instance's poll context. RX stats accounting and the skb->dev
+ * assignment are still preserved; the only change is the delivery call.
+ */
+static void mlxsw_sp1_ptp_rx_finish(struct mlxsw_sp_port *mlxsw_sp_port,
+				    struct sk_buff *skb)
+{
+	struct mlxsw_sp_port_pcpu_stats *pcpu_stats;
+
+	skb->dev = mlxsw_sp_port->dev;
+
+	pcpu_stats = this_cpu_ptr(mlxsw_sp_port->pcpu_stats);
+	u64_stats_update_begin(&pcpu_stats->syncp);
+	pcpu_stats->rx_packets++;
+	pcpu_stats->rx_bytes += skb->len;
+	u64_stats_update_end(&pcpu_stats->syncp);
+
+	skb->protocol = eth_type_trans(skb, skb->dev);
+	netif_receive_skb(skb);
+}
+
 /* This function is called in the following scenarios:
  *
  * 1) When a packet is matched with its timestamp.
@@ -600,7 +632,7 @@ static void mlxsw_sp1_ptp_packet_finish(struct mlxsw_sp *mlxsw_sp,
 	if (ingress) {
 		if (hwtstamps)
 			*skb_hwtstamps(skb) = *hwtstamps;
-		mlxsw_sp_rx_listener_no_mark_func(skb, local_port, mlxsw_sp);
+		mlxsw_sp1_ptp_rx_finish(mlxsw_sp_port, skb);
 	} else {
 		/* skb_tstamp_tx() allows hwtstamps to be NULL. */
 		skb_tstamp_tx(skb, hwtstamps);
-- 
2.54.0

