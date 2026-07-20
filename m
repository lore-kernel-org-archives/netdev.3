Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4D3DB647
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555935; cv=none; b=eFiZ8UsH/jauDt87pe8XGgzABiDzxlcqr+YfhmqyBHcxZcc6hmTY/r4UBSmOq9GImI4iEp0eH7rOIzIZZOTEqwyb6PNHVTBgzNAUQf/tJ1VFEo5dX8Wai7mKKiwixsDjRtBqAugOA1zLbNCAerA0AcIvnfyJovDBnaK5nkUaEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555935; c=relaxed/simple;
	bh=N6MPpxZRP1NGWFJq37/nDM+kNdRfWwpPOCZClpUNZLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnkQSCRLZZ2WOPHA9vJHbPBqC0wIHZze90OHg1F+3RsgdLC5JaRZP/Wl/TbavXMdC6HkzM9P/NkMlle2B4M4fJnL7z7xbBNNQ+B7BMxx7JuPyHP2GzY4a0GpHC4GWfHa4FwY0lIKi7VCkXTOsQIfv0+ghTA9+3pNR9F5tQFVk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ere3DvFm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ere3DvFm"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc73e322dbso119443495ad.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784555933; x=1785160733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B+N+tI3fTlFvgqkGyWfTCEbLLuo0kNzByKg6eMoo7gc=;
        b=Ere3DvFmnjg1uMwo7Ozu/SxQoYodLB5C1HSszcadT65ogcDlSLWami6uJo1mndkj84
         SQFjLmKYN9S6u67tvlF9Ocrbj0673oSvUX85sb/u2hyJyn6rj8ZKB00A+I0CVdjc3aMV
         uz9fv5cbGO9ti5qPQNlvCI7NLHlUDoI6qX4KcmsyZGBMg65t/c+QFJx+j/LB4OemrpT9
         PyshxKUjQtSYMe93MbxRsiUFB7F4fM6Lb+spCszzdqWBP9YPhjNBIks8LMRqFmmJZxXj
         wY+n23KgO1aA4Y3vjlEpkfV0FRtAdpOuiOCMai8hZtxhW2hQxqxUT/I/ywnQdGbbxJ5W
         zONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555933; x=1785160733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+N+tI3fTlFvgqkGyWfTCEbLLuo0kNzByKg6eMoo7gc=;
        b=m0ABdJVJ/JJy5RWCh/JNNOXhkJDbtaDDfqRSE/W2HyTeOic2iyi1CyYHjYd1Ka4+OE
         68mvETQ0scpogU3kBOFBL7jCXDcSbnTCSZUDnzNg4bvb0FCkFyW87tzM9wiZU9aYn5oF
         TafW/5XMHm0Lwdb0wtpynqkMDrB/gzz+aii48ncn9L3wEck1516KcZidzgFYuOyP2eFn
         U1zVg/xBYqCxfa7veDvdWCvdqg/fiDcM9GeqTttMyqelj5Mj46kB8v/N2cd9voIgsM/G
         OYqxKZzkXgwrlxeUjYmK+Y6SM3lp3KVG7pJfQYzfc8tPQEzZxB79zzRWx+BTF3jmWGOg
         Z3RA==
X-Forwarded-Encrypted: i=1; AHgh+Rqf5GqibgydjHZhWAjJAIKj75emPOfzjX1Lz0TYVIfwKhfHB4Xy7nRJUdG5gaZ+cfBmhzD9JnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytH7l06gGP9tDq6RuDpiNRC2+D1szMyQUYPfDAjbFJAQpr/FQq
	5Cmc1IFaiTb3zmc13CBcCTfOgGojcr8IVFzFJNoNllGyeo8kbyugi9g=
X-Gm-Gg: AR+sD12yD+kk0v9Hoit91Gq7mwP4hrhJvCXziE2/bTOdXwFtA3HVjOToyrgw08pqqA8
	6y6XAELn1GJY/AuWuW4bIssyCy0/Y4zbXjI8HEZ3wiy41YbaWEknvIKOf8oGE0XGriooL9LUf8k
	Fxin12g3ppPWqDlcKHjXZtA+xgHpijOfbuqIihgjJerCaUGbzWgE+3MwwEQo0VsyfjOvEW6bMji
	anynzgUqc66Bc5fwa0xwNO9MjoOqHRsDq6D2C7aoLqKnD1yasGcKwVXx0Ig42sxugZhBopFrl9+
	EAJr9DL5yWWHuiKN+ej0S0aJ5XHw+YgGr0rbLzNZYJrwYRt2tPSAQUCh6hcXqZZQBdi0vye67T3
	Fnp0aXYVtDqhxPHxo143vUIco72iRAnFcUalbPcRAoSr7wXWod0iC5QBkfUiRjyoAxlcSdZtKFw
	CLU0ZmxZitKRRFZ6JGLJ6W/QiGQwmoRF4oI9hsVTJAgKBG2S4HVjpmhuHZQg7o60zkVPAWYbfYO
	0kPA20rBm2Tv37crr02ROqikTeuH+boMpTE+aEt
X-Received: by 2002:a17:902:f542:b0:2cc:741a:ff33 with SMTP id d9443c01a7336-2cf34a39f67mr150605265ad.43.1784555933163;
        Mon, 20 Jul 2026 06:58:53 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee28sm57045415ad.11.2026.07.20.06.58.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 06:58:52 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] idpf: disable DIM work before freeing q_vectors
Date: Mon, 20 Jul 2026 22:58:46 +0900
Message-ID: <20260720135846.76229-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf never drains the Tx/Rx DIM works before freeing the memory they
live in.  tx_dim and rx_dim are embedded in struct idpf_q_vector, they
are queued from the NAPI poll via net_dim(), and idpf_vport_intr_rel()
ends with kfree(rsrc->q_vectors).  Nothing in the driver cancels them.

idpf_tx_dim_work() and idpf_rx_dim_work() then run on freed memory:
idpf_vport_intr_write_itr() writes the ITR register through
q_vector->intr_reg.tx_itr / rx_itr, void __iomem pointers loaded out of
the freed q_vector.  No configuration is needed to get there --
IDPF_ITR_IS_DYNAMIC() is defined as (itr_mode) and idpf_vport_alloc()
initialises both modes to IDPF_ITR_DYNAMIC.

Draining after idpf_vport_intr_napi_dis_all() is not enough on its own.
idpf_net_dim() is called from inside the
"if (napi_complete_done(napi, work_done))" branch of the poll, and
napi_complete_done() has already cleared NAPIF_STATE_SCHED by then.
napi_disable_locked() waits only while (val & (NAPIF_STATE_SCHED |
NAPIF_STATE_NPSVC)), so napi_disable() can return while the poll tail is
still queueing the work, and a plain cancel_work_sync() would be
re-armed behind the drain.

Use disable_work_sync(): schedule_work() on a work with a non-zero
disable count is dropped by clear_pending_if_disabled() before
__queue_work() is reached.

Move idpf_init_dim() to idpf_vport_intr_alloc() so the works are
initialised on every path that can reach the drain -- the three
"goto intr_deinit" sites between idpf_vport_intr_init() and
idpf_vport_intr_ena() get there without the enable side having run.
Nothing re-enables them: rsrc->q_vectors is freed on every exit from
idpf_vport_open() and on every idpf_vport_stop(), so the count dies with
the object.

It is a race, not a deterministic failure -- net_dim() only schedules
once DIM_NEVENTS events have accumulated and the profile index changes.
A KASAN ifup/ifdown loop under load is the way to see it.

Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.9
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Found by static analysis; not tested on hardware.  Testing by someone at
Intel with an idpf device would be very welcome.

disable_work_sync() landed in v6.10, which is newer than the commits
this fixes, hence the annotation on the stable tag.  A backport to older
trees needs the work held down another way rather than a cherry-pick;
happy to send one if the bot reports a failure.

libwx does the same thing in the same order -- napi_disable() then
disable_work_sync() on the dim works -- in wx_napi_disable_all().

Based on v7.2-rc2.

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 7f9056404f64..cd98674fb648 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4148,6 +4148,26 @@ static void idpf_vport_intr_ena_irq_all(struct idpf_vport *vport,
 	writel(rsrc->noirq_dyn_ctl_ena, rsrc->noirq_dyn_ctl);
 }

+/**
+ * idpf_vport_intr_dis_dim_all - Disable DIM work for all q_vectors
+ * @rsrc: pointer to queue and vector resources
+ *
+ * The DIM works are embedded in the q_vector array that
+ * idpf_vport_intr_rel() frees, and the poll arms them after
+ * napi_complete_done() has already cleared NAPI_STATE_SCHED.  Disable
+ * rather than just cancel, so that a poll tail still running past
+ * napi_disable() cannot queue them again behind the drain.
+ */
+static void idpf_vport_intr_dis_dim_all(struct idpf_q_vec_rsrc *rsrc)
+{
+	for (u16 v_idx = 0; v_idx < rsrc->num_q_vectors; v_idx++) {
+		struct idpf_q_vector *q_vector = &rsrc->q_vectors[v_idx];
+
+		disable_work_sync(&q_vector->tx_dim.work);
+		disable_work_sync(&q_vector->rx_dim.work);
+	}
+}
+
 /**
  * idpf_vport_intr_deinit - Release all vector associations for the vport
  * @vport: main vport structure
@@ -4158,6 +4178,7 @@ void idpf_vport_intr_deinit(struct idpf_vport *vport,
 {
 	idpf_vport_intr_dis_irq_all(rsrc);
 	idpf_vport_intr_napi_dis_all(rsrc);
+	idpf_vport_intr_dis_dim_all(rsrc);
 	idpf_vport_intr_napi_del_all(rsrc);
 	idpf_vport_intr_rel_irq(vport, rsrc);
 }
@@ -4238,7 +4259,6 @@ static void idpf_vport_intr_napi_ena_all(struct idpf_q_vec_rsrc *rsrc)
 	for (u16 q_idx = 0; q_idx < rsrc->num_q_vectors; q_idx++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[q_idx];

-		idpf_init_dim(q_vector);
 		napi_enable(&q_vector->napi);
 	}
 }
@@ -4581,6 +4601,8 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport,
 		q_coal = &user_config->q_coalesce[v_idx];
 		q_vector->vport = vport;

+		idpf_init_dim(q_vector);
+
 		q_vector->tx_itr_value = q_coal->tx_coalesce_usecs;
 		q_vector->tx_intr_mode = q_coal->tx_intr_mode;
 		q_vector->tx_itr_idx = VIRTCHNL2_ITR_IDX_1;
--
2.43.0
