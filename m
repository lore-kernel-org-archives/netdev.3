Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B044F566
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127752; cv=none; b=fF9ybKg/LlsVBQgA9BEVimxHRj+3ZVTNAh9w26mnMXWf2wgSb5SV1Iyjc4BIKTMKirLhcPBBglXLjM9Y3pzmT3pHEOAJPeathiaZv/sZrhr0L4Xj9TbrmNc7Zj39jH5OwEbZnHaZeTVB3ebmr3/NQ5WZHg0LLacHiluy+8XW4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127752; c=relaxed/simple;
	bh=8uJjw3Z2XoTgeVUknKr8jXBNygiBE0TzH48ibqct/uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDJBzd+K2q26UoLDAiMDsU1er2gOfKZupYBarViMYk/hK8MCmK0qRpuCgOBVchtIMB/k3wHHPm1iKBpbdzjkSne9lx4SsJSkb/Y0RblL7S+775ZJuM6Q87ZZqaQsMD1T8iFa+GBb9nzVzOwyRWyiBYYZJnQ/wTcjI0luA0Aya74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qR3NuaIt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR3NuaIt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so7052285e9.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791127746; x=1791732546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjuVkIYnaqcKfLZ8gNPpy7PzsEJhC75OnnV9vKlbU3I=;
        b=qR3NuaIt1+lu1m7M84k4mWci8f3O9vVd0PchUuN+Jpmcyi2/F90UKt0leBIG3HKR3Z
         86PaFzX8JNzEhaPn8utmhET8mlh6LFPGKWJCCUUDq13OMObSXMWOwgheYFKhwioqUJPv
         vZ2Wa0HHc2UsyCFzeFTgYHBEyxMkUiRKISl+KBihi/DkBeui7td3nhgb8i2OqHCy6Ily
         ncwn5Vxb2s1cuF3gd8md0SLlyGs5TIDR+WI9IcwpxO7B4bXerCsq0x4i8plHUlAhKxTo
         WyWC+9su4IZyc69BtT2Vm7hbYs/XWLiTs70xdCVRRWo0BDhQvE0KhA+RRzpsP4U1t7eQ
         l7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127746; x=1791732546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CjuVkIYnaqcKfLZ8gNPpy7PzsEJhC75OnnV9vKlbU3I=;
        b=UYS6MNrJrTAJRPlmWHQD5xvVpG/J4adaaqHREyc6HoA+uPAELEQ97Tg4OPKZoQMPvk
         W7DPJmX3nmuclU6BE6tSJlcG/ekS65rbN7wuhFmI9JEFKXXs2QTMOgeAs1hSvTAYLwdi
         1gzDQYIhoNIHjeu6550PsV+NeLRTWnt9OcwAVAAQgy15m6eNkD23jcDrGeg2V96q9wtk
         UJxYKNQHoth0Cqu4Mep0D+a34ULNubCpX70VTUH8s2V7XWrVEO/wYByEYKVZqq+7vdv+
         zrzTF0N+b68puZprAfMZLowKINbWTmwiH86l7RgtEr4/5YWnPkLzcZNpKqaFIEvRHDpL
         dZJg==
X-Gm-Message-State: AFuF++mmxmOVuDDbh+9V5znd4UWq5eIor1XrvPCsm5hCWgFlT+1GK6Qi
	iSgNJEdIq97dt/CS/768YOC19i4wT89UiO9NzGrVwgpaWZWIqnLZ1e34
X-Gm-Gg: AYBFou3UNejDyeKLwvL6SZ/tJjbajaMFie/YqnDxCyoWZ3N6asA36OrYRN64qg+RN8D
	Bez6QQsFN10DRtTAyvTL+M8Vmvgoe5ArnXjCYaOCVOX9gzwalWPH/uoKWCRHxDcVBTz9RzKWB/j
	xfTDQuhHjc9JHj92WfnxOwKmCcCKAkcyTSY9GWdl0UOeU/GEfd66kpiEFE1pjNvfgxbC6a6HNRE
	g3VqquxmZu4cUsDSSpG3CHnM8lhax3U1KtRdb5HRAAzFGjQioyk7sNcL6AVGVMJA+q+ei+mgdNX
	cBYw/90YM5nDP9AFf58WczCM8N6wCbS9WRT/EjhPqNbZ9VmsNknJpdH9uC9dnlD4aISwGTiNVqx
	0Cy6OGy2NbMSpfzdOwVYQ4iOIsA5oomXGt3HXG+bYo/u78V1lHBo3nyGD9+XWbI+qEA0spdINdX
	+jWrmL+H0zVGpcVb9eYvhVq+nPHqVHbwh07JlxjjLSs9bvfSY01gzwwhkPwsz3ZZHNq9i5v5ru/
	saKYjdT+W2b89uXF+0qenz3GPNQ5J7NWZCQProXggRbSRfIAmbZsXzUV0n0k3QHRj+YSCRubVq3
	WyhwVllnvg==
X-Received: by 2002:a05:600d:82e6:b0:4a1:6c48:c789 with SMTP id 5b1f17b1804b1-4a16c48c849mr62190295e9.2.1791127745884;
        Sun, 04 Oct 2026 08:29:05 -0700 (PDT)
Received: from citron.bnl.ovh ([2001:861:44c1:870::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1698f7910sm83819735e9.3.2026.10.04.08.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 08:29:05 -0700 (PDT)
From: Benoit DE RANCOURT <b2rancourt@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	linux-kernel@vger.kernel.org,
	Benoit DE RANCOURT <b2rancourt@gmail.com>
Subject: [PATCH iwl-net 2/2] igc: Flush pending Tx descriptors before returning NETDEV_TX_BUSY
Date: Sun,  4 Oct 2026 17:28:40 +0200
Message-ID: <20261004152840.61222-3-b2rancourt@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004152840.61222-1-b2rancourt@gmail.com>
References: <20261004152840.61222-1-b2rancourt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the stack sends a burst with xmit_more set, igc_tx_map() defers
the tail register write until the last skb of the burst or until the
queue is stopped. If igc_xmit_frame_ring() then refuses an skb with
NETDEV_TX_BUSY, it returns without flushing any pending tail write.
Descriptors of packets already accepted in the burst can therefore
remain unexposed to the hardware.

The queue is stopped at that point and igc_clean_tx_irq() only wakes
it once TX_WAKE_THRESHOLD descriptors are free. The hardware can only
complete what the tail exposes, so if the unsignalled descriptors keep
the free count below the threshold, the queue is never woken and the
Tx watchdog resets the adapter.

On an I226-V running 7.2.8, in all 25 Tx timeout episodes of the test
described in the previous patch, the stalled queue had pending
descriptors after a NETDEV_TX_BUSY return: the probes inferred at
least 214 of the 256 ring descriptors beyond the last tail write. For
that queue, the register dump showed TDH = TDT = the next_to_clean
value recorded by the probe: the hardware had completed everything it
had been given. For example, with queue 2 stopped, next_to_clean = 190
and next_to_use = 167:

  igc 0000:08:00.0 terra: NETDEV WATCHDOG: CPU: 1: transmit queue 2 timed out 5353 ms
  igc 0000:08:00.0 terra: TDH[0-3]        00000099 00000091 000000be 000000f5
  igc 0000:08:00.0 terra: TDT[0-3]        00000099 00000091 000000be 000000f5

Write the tail before returning NETDEV_TX_BUSY. The refused skb is
left untouched; only descriptors of already accepted packets are
exposed to the hardware. Those packets have already been accounted to
BQL, so flushing their descriptors lets completion processing
progress; the refused skb is neither mapped nor accounted here.

The previous patch makes this path rare again for common skbs, but it
remains reachable, for instance when the linear part or a fragment of
an skb exceeds IGC_MAX_DATA_PER_TXD.

With this change alone (without the previous patch), three runs of the
same test on 7.2.8 still produced 10751 NETDEV_TX_BUSY returns, but no
Tx timeout, against 25 on the unpatched kernel.

Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
Cc: stable@vger.kernel.org
Assisted-by: LLM bpftrace
Signed-off-by: Benoit DE RANCOURT <b2rancourt@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b94a08791102..16f2ca32f5f1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1621,7 +1621,11 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 						&skb_shinfo(skb)->frags[f]));
 
 	if (igc_maybe_stop_tx(tx_ring, count + 5)) {
-		/* this is a hard error */
+		/* This is a hard error. Write the tail for packets deferred
+		 * by xmit_more before returning busy, otherwise the stopped
+		 * queue may never get enough completions to be woken.
+		 */
+		igc_flush_tx_descriptors(tx_ring);
 		return NETDEV_TX_BUSY;
 	}
 
-- 
2.55.0

