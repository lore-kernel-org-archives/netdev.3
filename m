Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D794F3910
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893563; cv=none; b=Wp8H9EAnxtEe+Qr+/qJ92JAhR3h07pPMHPXSG61C1XNmkc8jKIbe491N/5A+gnVdhXi4J4DHweF3HHbhvbYhguBEl1stjdJ+NcCBvCgOeUH3vhn8d0JnDy/+d24QMBL2siv11oM3e54mZGyuUetNdrF9m/GLQIDw7gpJvkg4m74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893563; c=relaxed/simple;
	bh=QxHkTP25+L2fO5UNrDtGTFm/tPjmWozXAW1CkIuOXLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4HdL5I7JCKclcXwuad7oGt02qvLxvXEAsSQg61AbUGNip2NyfGxY9ueeXfLujuAJ3DDSAo1v8g6J8T+Bh4xFUr+Jli5ah0nyZnPhFA+qNkuakMQB8wpqk25ntajhbYHGLoabWaxmY4Qpqdgh3+ElukRZDABjAzOeHFRQ761vPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNskFiKT; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNskFiKT"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so351962eec.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 05:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791893561; x=1792498361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ETrKISw+8AK0KtLxNpxC+VOrt9aLiNM1tKj5N66RmxM=;
        b=tNskFiKTHv/0LF3Xuu6AQTm0fbM6xm5/GRzE++kG6RHKMBbSYDli5L45jrCOSX7sir
         2Unx+gWxx9kndwoiMtvxq3fnXjCSQ+5t2YZqDcMVHS7Kk+vXopM2ub2fcvZfA6WXcB98
         CecP3Gi1lGozUxdVIAbx+FZ/7prPf1j0RZvFf7p28SQRG54C4v7CKRfnw7LbSf81LK2w
         qbDKuTFHTsKyTLkZhxSh7JQt55WGjpXUPFVzgP8ZYDFKATQJdPmYEyedISbfY0CHotOd
         /FR/emqMI9f5ReQJoiQItxh120ktm922P8qfn53qHatpZ117V8UcNgAdg8NmBQXgQmQb
         bcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893561; x=1792498361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ETrKISw+8AK0KtLxNpxC+VOrt9aLiNM1tKj5N66RmxM=;
        b=AcHOGTYpkAcS9QSCcBrAwPy9kdMPiQgKF4n1c512fttDdnc2VQmO1zHJ9yhtw7pJbZ
         kj3eKGekjpLOofh3QmTwOgZe4CmZs236xmabeCRQcVWWihVnA00CFUixl8ABBOkjoBTn
         NkXxslxTt/dyf3bkc0P5LcovBXNFx2Y6rAUZ0/u+j9p9Av/o9+I/0w9hngPjEF7o/h7P
         vcSR5+31xuCEHgySHenIQ6AiUh4HyxZC28KGRjUxpeZPrMGmlCBY2dcEPAOsLFFlzA0r
         fVkSRVOEXD/xU+tKMCLVGoy0J69fjpbqz/uI14043Ypcj4gpDdxYknCdxDvs/+JCrNCz
         KMcQ==
X-Gm-Message-State: AFq9FYIYBp/StI3OD6p9sQZp5M39JhdiAWP/DAZT2qZKCJBJ70+4b6OB
	xnS1SQCfXjb3XBFq13vu88KZEKihLHbEbLS5ncdMVv/4uwqyTFRwfl/D
X-Gm-Gg: AYBFou1fPu/zfIAKRxITeUEkqYkQ+ZaDJ4T7Gr/gf6ZmhIfw3+UtQfFE57k9X4O2fXi
	69OqFcBKAqeJM4+7W2KbpHWj7Hyls4lxIzJWr6c7PYew4JlDVtkMG011BHIPrpketgincsOOD+K
	Dnu8+tCwIQhdvXJVBuuBAtpNbldwYtlBA76IFpDEtSccLceiukWad48CnXaTf8QtNcWaZ+QJDnF
	ScAQloaU9fnLvFvKgBoG/QpBgLNlFr2RjgWE5/dZ92DC640zYzwUjLqge+OHBWCOWgcJXVPG3nB
	Zy3krrc+1D92snnoXy5PawmYNlyjMxB3t9a8qCA4oTKsGdWAabd6r60EHaZXrMJbl33YkeAc6G8
	OBCxwHPihlNpJ2wsac10BDdF6OOQEsQ5cRcPrH4DKQH4njV5SViT+TVw1YNj226wsGM4TkH6H4l
	7WOdlsY39EmckAlRSXbKYl8Q1KhpxMMeaddouPOoMtId3GtrOZiNTL/fN4el4eJo9Ag1SwUNT9V
	r8QHNvZU8q+aGUVpJvQ3njeToSvs98PGz2dxE+JpSTcfSxA3pwseNwMJtshxKGOFHzlJXhGcnc6
	NA==
X-Received: by 2002:a05:7300:e9c5:10b0:359:f28:412d with SMTP id 5a478bee46e88-3590f28533cmr13587521eec.36.1791893561153;
        Tue, 13 Oct 2026 05:12:41 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (34.224.142.34.bc.googleusercontent.com. [34.142.224.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca7133asm52304765eec.14.2026.10.13.05.12.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 05:12:40 -0700 (PDT)
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
	alan.brady@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v5 1/3] idpf: ignore Tx timestamp replies once removal has started
Date: Tue, 13 Oct 2026 20:12:22 +0800
Message-ID: <20261013121224.84482-2-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013121224.84482-1-luckilystar08@gmail.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
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

The last patch of this series sets IDPF_REMOVE_IN_PROG on shutdown too,
which would otherwise expose shutdown to the same window.

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

