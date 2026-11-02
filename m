Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793590072;
	b=4evydNRzY7lSaD7YlfTiK1OSENofEdjrPKJ4fQxflxb7DNefkcHgXxM3/KbeGproUhxf
	 inQOfW502f24YvAstmrWNxzqTm+vUaQpGYc5IlbsUNA0+K3wRUSMbtOEg0XGk7t3g/2u5
	 qU/yE9Dkawd9y6mYOZPWuS6igiRVPDra4YRrTAo4Z5OaRZ+OkpZ59vVp8Uf46baM7uzYh
	 EvgCwKX7NrOxch1SgZScxe0Gvx7jKktLbzc2y1NPZi5HfbZ6Rii/pSsEDE7UpR8T+UaX0
	 fvJLwhj0CTjG3T7Mm8kjv26vGst9k0gNfD41iV2WCt7PLjs8JD4dXIZ/NXQ47HOyUog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793590072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8Llr+o6Ts4ECL1b5wY6waQNbg14/hj40EOsrJUW7ozE=;
	b=rVjly6ydSDOwgQMGYNZFn/+TQZzdRynqkBfYo8OzHk85JNWpm13461qcDm5iQP8i+aqu
	 K3krIMotJ54TPJPtnepVUAJG2E91MKx/orNGTkA6UDUaqLboxlrtvzvvtSSZN1zk4JEHd
	 /h+MFqmrXuINfUhqBMRBRoVp+b51Pw4gTQIukx5w+AZCzqcTwo5ZHmhTlCPDT/4Mtdlul
	 x61gL4DQYlRU47N+E1hnUT4LQcS4D41dfp34aZ5e81hM1YSNhwnF0ZBcyQL8L7b5yxpXA
	 YnifrPatDkSvKqxmryg6PT5GkAfGFiz2pGCeXgJYeLtx1E+Aux5AXP5MDT1IoGc+17Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hp/763Rg";
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94972606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94972606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hp/763Rg
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c79f306e9so30407956d6.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 19:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793590070; x=1794194870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Llr+o6Ts4ECL1b5wY6waQNbg14/hj40EOsrJUW7ozE=;
        b=hp/763RgOF/wT8bcAevxBP9ug5KDLc0g3ts+YAgLMuoUBcWcc5nAXIQo4U4Vb7mGC2
         Ln752RcJgv7sD5UQo/lGCcJL3jjuwwf+KFd6KUHcVQ/Y8si0Ka81q6poUuW7yntj1ha4
         1AfQWopqakSkNwQLyqlz2ErNU5uJXPkv3Lhfd4B0wTZBojcylZAdOF+mzHrCtjDnKo3m
         2az3eDoEPMi1fbMFANKLZUk95uEpY9Qai/7YY27guSFumOv6PZGITCWsPRLsvBTkxDRP
         uYbup6LNU2kQHJDEyuaCsaQ2/gB15wkXVdqGwyuUSjqAQMEdHReq7WKg6fE8NzIbG4z4
         Dd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793590070; x=1794194870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Llr+o6Ts4ECL1b5wY6waQNbg14/hj40EOsrJUW7ozE=;
        b=p0GjK122dDJjl3vhqQHYL0ZblTSpBrBzlWgCW1yw/7fvXx3vtQmVANBXQhV4m4KLED
         SVFNdlsZUQ1ZQW862RFhc1mH6CefEagS1TEPg8Hg8NpU6504DzWqtmAGMxGZ2lVuVbqD
         kKd1T5jNj0ihbkf87htPryef/A0kYlKsY5Vwew4pI2m/X6qPAdT1BuIYILzrmzmNQZMo
         LFgXqyr35hvBF4hFUWzTLc8G7KEO/wts0yKdiYiaxhdDss/qnZ3ISb+sNif4DXYkRKCn
         y3YLY8e9O6m8O2mzDxhfNHTMV/1fW0OialzdlTlxD/RTniPIu5lBQ/30AkjVWhzw2mSH
         SVng==
X-Forwarded-Encrypted: i=1; AKwUvBz6OAV3cNRw2+NieK74+1kPVjw93D/8wKsu2pRk4fNbN3MC4RNFlxS0RjYZy2mZLyswV5uQC7U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zeEsYNJpB5UtChibwZ9QpVndENBqkM1sZ9ChWQ/CAI+mEgB7K
	9qBc1waVir+TOGFs2oUjC7Nv/yFf6EVrFC4pGxKOpP3DtOkDPRlWo+9c
X-Gm-Gg: AYBFou207W1Eujk9Pbu5XYHcq10c3NlNJiH6hOlGQ598A/1SmzltwGA3hnCV+QdVpW+
	SAxV+nF+Zh9wxFUIxrnYVWWc13VtY92FinwNiBySvv+W7NDZVHyJqqgu0hh2Fl72zM/7KWKpjzK
	aSfJf+v5hUdC1vp1Tf2n8vb/LU13YlBtqYIJJTg6O+GrDvCS0mGBrSmajPHp7glszyAGkd9YtEV
	yWKaj3Wo37PQV+7fTCV/8jyCxjcXSUKn0XPh0Ycfx26A0/8LsGe3iE8BQUlHa4OcKchNrW3pLiC
	zBEEprtaZjiLopbJ8VCUMNPcxHdGuajwTqmwJ+o65eXx6BH/L+3U/zU/TcDAt6gp3aNV98QT32e
	OxTxMAbPLAp91yovvp+Mr0Bm3wAVlV+Kv7Z/L2YdZUAI+cTti89DVTNOjF4BmhCDyMA3y6T2d92
	AYDtrfBv3dmsPuAaOHOy5EiQ3SfDRootU7IqIlMSXPBqwq/qqQ18JA53d8FzYzPnIBdg2SFvXPB
	vg+Hbgm0M19c24UKv7gM4QwJiHEs43cOm8XTLrk1IuLrunMpET5JV6o1cPYsjNMO7gcOVbJjreC
	6nJg15m2YAIpn9oZrrwep5t8LVYFzGab/1Z8TkJJv2YBnEYS+GFn
X-Received: by 2002:a05:6214:4518:b0:914:45c3:7920 with SMTP id 6a1803df08f44-91ca4b1cb1amr156083956d6.31.1793590070385;
        Sun, 01 Nov 2026 19:27:50 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca804eee2sm80737396d6.27.2026.11.01.19.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 19:27:49 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH iwl-net v2] iavf: reset the VF instead of freeing rings when queue disable fails
Date: Sun,  1 Nov 2026 22:27:43 -0500
Message-ID: <20261102032744.304907-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

iavf_close() leaves the Tx/Rx rings in place because the hardware can
still DMA into them, and iavf_virtchnl_completion() frees them once the
PF has answered VIRTCHNL_OP_DISABLE_QUEUES. It does so whatever the PF
answered: for a non-zero v_retval the error is only logged and the
DISABLE_QUEUES case runs anyway.

The PF can fail the request while queues are still running. ice and
i40e give up before the Rx queues when a Tx queue cannot be stopped,
and ice also fails when an Rx queue does not stop in time. The rings
and Rx buffers are then freed while the queues still point at them, and
received packets and descriptor write-backs land in freed memory.

Keep the rings when the PF reports an error and request a VF reset
instead. The reset makes the PF stop all queues of the VF, and
iavf_reset_step() frees the rings once it has completed. Until then
iavf_close() may warn that the resources are not yet released, and
iavf_open() returns -EBUSY.

During removal no reset is scheduled, and iavf_remove() would wait for
the state to leave __IAVF_DOWN_PENDING forever. As it resets the VF
itself before it frees the rings, complete the transition to
__IAVF_DOWN in that case. If the reset never completes,
iavf_disable_vf() now frees the kept rings as it does for a running VF,
instead of leaving them with page pools that point to the q_vectors it
frees.

Fixes: e284fc88dfb6 ("i40evf: delay releasing rings")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
v2:
- Let iavf_remove() go on when the failure arrives during removal, where
  no reset can be scheduled (sashiko).
- Free the kept rings in iavf_disable_vf() when the reset never
  completes (sashiko).
- Rebased on v7.4-rc1.

v1: https://lore.kernel.org/r/20261022192753.69765-2-oss.patchbox@gmail.com

This was found by code inspection as part of ongoing, not yet
published research. It has not been reproduced, as that needs a PF
that fails VIRTCHNL_OP_DISABLE_QUEUES.
Compile-tested only (x86_64 defconfig with IAVF, I40E and ICE, W=1).

 drivers/net/ethernet/intel/iavf/iavf_main.c    |  7 +++++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c    | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2f8a80a11336..70ee5ae14a64 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3064,9 +3064,12 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 		iavf_napi_disable_all(adapter);
 		iavf_irq_disable(adapter);
 		iavf_free_traffic_irqs(adapter);
-		iavf_free_all_tx_resources(adapter);
-		iavf_free_all_rx_resources(adapter);
 	}
+	/* Also release rings that iavf_close() left in place because the
+	 * PF failed to disable the queues.
+	 */
+	iavf_free_all_tx_resources(adapter);
+	iavf_free_all_rx_resources(adapter);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index e6b7e8f82c7c..28818319a6df 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2718,8 +2718,22 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
-		iavf_free_all_tx_resources(adapter);
-		iavf_free_all_rx_resources(adapter);
+		/* If the PF could not stop the queues, the hardware may still
+		 * access the rings and Rx buffers. Keep them and request a VF
+		 * reset; the reset path releases them after the PF has reset
+		 * the VF. During removal no reset is scheduled, but
+		 * iavf_remove() resets the VF itself before it releases the
+		 * rings, so let it stop waiting for the queues to go down.
+		 */
+		if (v_retval) {
+			iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+			if (!test_bit(__IAVF_IN_REMOVE_TASK,
+				      &adapter->crit_section))
+				break;
+		} else {
+			iavf_free_all_tx_resources(adapter);
+			iavf_free_all_rx_resources(adapter);
+		}
 		if (adapter->state == __IAVF_DOWN_PENDING) {
 			iavf_change_state(adapter, __IAVF_DOWN);
 			wake_up(&adapter->down_waitqueue);
-- 
2.43.0

