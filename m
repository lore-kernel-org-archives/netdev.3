Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43774378823
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786658; cv=none; b=LpNv/SiokbkAEo4soj0CC9yriUDbOJJbbUaoT9BndUi/iTCbPAdQsj/Axbe//xOAEIKMvqgoMqnhOi18BK9pQwX8W78erE6XADCWVu77eY405e1xrdPkfGmtI8Pw8UM+86aFvNdVkGmCEu+CLEHPHHq6Hax93OUKJKRX+++S/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786658; c=relaxed/simple;
	bh=kqGYYmpnV7KlZAFQSkzh/nxBloiBLrcHvcWft9zEJB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q19OjPDS7gSh7H+SEzbg8l1LqhOZYc987VXpJkKwdF6szTQ78jnX71qDs8BcGNhSUnXa1hmacLjNKiqBdA4cWm0cli7cvM5GbgBzaVL+aPEax2ggytygqRtfKYITklPg4W+QVIlOrIDTYko4IYPtFNfyJcLTOYt7SoPB9QSGR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiAnYWeu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiAnYWeu"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a7fecf8440so679146a91.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791786655; x=1792391455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=seozyzMPcRgvoknCy8U1DFhAaYhZLfvbDoE5+Gd/ZQc=;
        b=CiAnYWeuIz9YYTYmIx1sNeaosY/lFvJhdIRJP54oTkpMzLGqVV126bh7ynNXg9+8Dl
         HjVWUVV2EJlQXbXz8RRExQ1RLt88SnzAUGccuKnRVJZtVkQJSUXiFLxBJLyD44L1NyFx
         KZYuBTxi5hj5RZkftWAZAFa5CuJH+r10I7URTi7EId9dYsO8cgskWso+WmUTpkQfjyQr
         U37EZ1d28yza7iFjp/HUm2f5KYaaX0761nkQH/H7nJRXauqezEiN1gNN7+bhnlfvDi2h
         P3uhb2hyp/oZWhlfpHGeDmZodiVa1KEv23QKpdrzo2GAAzL2ZhVgvo45iV30NrQdXZLs
         GuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791786655; x=1792391455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=seozyzMPcRgvoknCy8U1DFhAaYhZLfvbDoE5+Gd/ZQc=;
        b=LeXCoqM6AZOyQ6DZw6HDacGsCU8r4ahzju6P9xl7BdyUIeLIakzhLJGkzFKX0TaUbg
         +SfpFfGbQOBYuRPXGRt1KqjYBSon3P7u/3MNdzsfA+HsnaIwuLTNOhloEjMDnI+LjxvI
         4WKOgCdakqXQIuQpIi4jWtIiJfkpyp+9Y8zUYTrzbhLTs8xju8mk3dsuTJy3pUjTcK0O
         ghrtOHCpRRodyDKfjPHMRowQdrdYGHswivoeVgUp6BjO7zB1rs9swcpwyJ+5n58I1RpY
         V5sHg03y6BUbJviMivYtl7OsLYtGDhtnlvNILCatVpGWou1mMQvEDgRxOV3mVI261Ica
         scMg==
X-Gm-Message-State: AFq9FYJxHvmmK+NJh0LCdqMUKoe/XSPYyfLshK0FZ1AnoKyKJASWOjBj
	PCEVaimQ02gzEaAfm9YSgkAaWrgTrt4SJvtx/UO0RLw2QgBAd6nEiolV
X-Gm-Gg: AYBFou0GKnrMKd/pvZnLEik8JvXYiuJ8bJvmzND/qyfOxe8HjPr4wOH9qPQ1oms4/kt
	FHQkyBxfXPBRgEOzPHKdPU2ykgpasQe3mO+sJVKL+CW26jKbw4KKkS+k6uN79yj7Ey0W3Y+YyFz
	3TtfFSvcg+HnRQez6uvdKL0AvDRLl22ExD/KeOz8CtDfBl7p5sPCCv4c+sqfjTGpLEJmkS4rfT0
	kRA9qx9xVegE6RQOEFVd2EVG8nfja+zcO78Dv1fdMH/HBq7mOO8pJIRBKw5EGjoDyZRz0TwS9k2
	WMIMbab/PShoNI8DcodjCIj2UNQHO5k91/e7AOXKiDa+zGWn0SkIE78Z3jHMOES8uNOvi6MXNKF
	QIm4CiLj2DIATstKlw4x8mU8zQWUXo9V5UNytEDLteIG3eaKjsPnu8eQk1nvN9+4qwIpAmZh10v
	HT2zUC53zSKY4tHgLqGY3JVXKs7yqrj7F4dXpRzugI1kygR2TxhVWDNOESQlUSvnaAyBGEsHFcS
	O5QNgE+331l3d4P69IpzwIkv1vzQ32P/7O7twcU60ytkJ/jCiGkLmbXZ3AKY90j5TnT0j6ezoFo
	WLk=
X-Received: by 2002:a17:90b:3b84:b0:3aa:f4af:1e16 with SMTP id 98e67ed59e1d1-3ab3a4871e5mr6638806a91.7.1791786655244;
        Sun, 11 Oct 2026 23:30:55 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab371c32cesm14452767a91.16.2026.10.11.23.30.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 23:30:54 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	decot@google.com,
	milena.olech@intel.com,
	joshua.a.hay@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v4 1/2] idpf: don't use the Tx timestamp trackers once removal has started
Date: Mon, 12 Oct 2026 14:30:26 +0800
Message-ID: <20261012063027.27750-2-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012063027.27750-1-luckilystar08@gmail.com>
References: <20261012063027.27750-1-luckilystar08@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tian Xun Ng <tianxun.ng@bytedance.com>

On remove, idpf_vc_core_deinit() keeps the virtchnl transaction manager
up until the vports have been torn down, so mbx_task keeps processing
replies while idpf_ptp_release() frees the Tx timestamp trackers. An
async VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP reply handled in that window
reaches idpf_ptp_get_tx_tstamp_async_handler(), which reads
vport->tx_tstamp_caps and takes its lock after
idpf_ptp_release_vport_tstamp() may already have freed it.

Once IDPF_REMOVE_IN_PROG is set, wait for a mailbox task that may be
running a callback before releasing anything, and make the Tx timestamp
callback return when the bit is set. Matched replies to synchronous
transactions are not affected, so the vport teardown still receives
them; mbx_task is requeued straight away for that.

The next patch sets IDPF_REMOVE_IN_PROG on shutdown too, which would
otherwise expose shutdown to the same window.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c     | 12 +++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706..d0db60647 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3204,8 +3204,18 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	/* Avoid transaction timeouts when called during reset */
 	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
-	if (!remove_in_prog)
+	if (!remove_in_prog) {
 		libie_ctlq_xn_shutdown(adapter->xnm);
+	} else {
+		/* The transaction manager stays up for the teardown below, so
+		 * async replies can still arrive. Wait for a mailbox task that
+		 * may be running an async callback; callbacks that run later
+		 * see IDPF_REMOVE_IN_PROG and leave the state released below
+		 * alone.
+		 */
+		cancel_delayed_work_sync(&adapter->mbx_task);
+		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
+	}
 
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 14dba40a9..1422b30d0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -550,7 +550,8 @@ idpf_ptp_get_tx_tstamp_async_handler(void *ctx, struct kvec *mem, int status)
 	u16 num_latches;
 	u32 vport_id;
 
-	if (status)
+	/* The Tx timestamp trackers are released on remove and shutdown */
+	if (status || test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
 		return;
 
 	recv_tx_tstamp_msg = mem->iov_base;
-- 
2.50.1 (Apple Git-155)

