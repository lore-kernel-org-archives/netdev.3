Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE678C9C
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770987; cv=none; b=Vtn2td5bE1zgYVOkPxYb24kO80yjQ3NzwZf44Dgsb3zzX08MF8alTEypVn1KzBbbt+lqbeREXk/8liVddbEPi5MIZx6DEeyWVWHB/cCkgn6kmgxmp6oveUcMe7j1nOFfFsjxtNNT6EteSV0f1uJtU9QXrXpJfburWdUFlWaTZ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770987; c=relaxed/simple;
	bh=4hrz0/APa3JBtVoKpaRyKHP4waUwTsL85ZWg+fWw8Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPPXgK8igXkGNpZQihUbKxwmpbwH6oS6iC+JCQM/2B1WvRu1DzpYSqKqfFeKrf99pItAALkyPmpLvNC3dzn7dhSWEjDfkI//aObjrSr8M0RfCyEOEeIpCC8qvkiCsfLUg/2GKVT8WzIi6DDmlsCaNoLrG4R59wXswNq9iC4UILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZGd5peLd; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZGd5peLd"
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 52D483F830
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1785770975;
	bh=1wA9zD8wavSvGOW0aSs81qe/j2d+7UbxR14kkq6ItL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ZGd5peLdWm0e9u16tXHtV8FtoeAAYqEvWzGCQ9ghITeJ777HLBTb7/j4KJqkiNZND
	 zAiqad6FVW5ERulAFxx59/F72nMp5MC6oKRmuUD+Qc+5AdDm8m9lz1ZyOJuvn011uv
	 +JabZH9qi38Y5DdgK4xWrbamSipv8vNLuADrzL6BERnTZOT0pGiYHAy31wgo20LYHm
	 AxaEjlaA1chHP2z4kU7d9pErJCEC9XSMfATB3G0l/KnhjcB7r7sXJcyYkWG9eYBEFH
	 xZnd5LnV/fNPBw6Yny9bcvlcVlVmZKs5wQvrEr/+YR+PCAG6P4ciH0JlKoo45Mv9uQ
	 K5vSUcndaz3yU8Ewoe75G+9cm4bKcaU1eq/WCqWLZGkyMnOGJ7Uw+6lcEUClYOE3o+
	 3Z/k3oj/iC7tnOceilYRQucmt8wwzAIhlTkvRyMbA3D3CZMTfjzBwMX6R5Ww9qhFix
	 NiIchs7pKGIbGZ/BSa1OuQcrvgg4fen5v6OKQERr55WkXjA7vcLIyCpvTDjzT3s97y
	 RbZnGTNqF1imWbSc+DX5Knjf6IDvhN7V9SbdQPd+bXbafvJJH6gqyol5Zs8hdGVquI
	 WL/hqJrSd66WqyrVDJCSMgtZ5TaD39iSnEzHwnkiNjuOADWd4uzMDHBhAiekFGMXi+
	 FVTnzINLqqKiSagrd1hk3BKk=
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c07f25de2so26027271cf.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785770974; x=1786375774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1wA9zD8wavSvGOW0aSs81qe/j2d+7UbxR14kkq6ItL8=;
        b=pjPsOQEvLiDibZhF6r4a2p/aJyZRZ/xyosD2WksxlWQfJfNrEze5EtX5c5WIqJwem8
         hsIKXSqIRqLLHWccmFzMq7mjjQMpfEXHzxvm/1OJHvzGvb8ZfDSdbumsG8IoHTT30j7U
         I8CBl60c6Ax/RmNh/aBmuPqv5jJVUDqV3QzImagKv/5FsYZiAsrQ6h9fjvmr27wqzI08
         2+hA7Ar+ZhkamN2kRF4n7lweGM5hRASnjc7hE6i2jZRm3X6/oZ9dlmVXzXkLUGm7BDaa
         S5WjrrKwa9zs84zOhTAABeW3jfaqavJrn7cUavtJmamf9B68mt9jQHH2feYaFIH7pG/o
         5/CA==
X-Forwarded-Encrypted: i=1; AHgh+RpGjzGFGoLkrrVRgXPwKIZO6W/segQ+U39GfJOMHQZ5wUuiAu/wzAjbO1s+VfxV264ihhLjw04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jIUYqCDbRwK/bEKKWRmzig86xeLMGu5tk/3OIQA3dAuLVMJi
	Y2StnxIhftnk93vIjjeZoL7levHLkoqXbVx9HsNpQiilksOOjIGHXyda7DRcR1aLiUU/A5M6zwv
	AJKTHK273o3krLGld4uxZNufOUj05wYgKrjGmyZG4fFq7L3uC/4AKlrIn96ehHdZg3hS3L2wlnw
	==
X-Gm-Gg: AR+sD12zefT6lda1DPNSpXMez45y1y2j1cHM6bhERzZW5dZAQEE0bgFXNHVIJy6fhYq
	lQSktvRs4HivZZU4TbEwhgfxjOsDvFL5bnR/pdQdn/FM5DQFJEPFBirrV4NNRZg5Gn5ovQx4pkB
	FxvC0xjkxVdYlR1f3e4mp5wBKBKTktZNky0GDGWGF//PJTkOMmf0ZrcGxh2g+bpSOBXv1prO0W5
	GMU6FfmjGVdqZpgjDoTlTD1rCwVC0RV5BJrUCt3B2JIMa6wyeuZ2on28TSlxNaZeqaT3Cq3lodb
	pv3DMHyjZ0PMmp8NC0oznNHPmZ4y2ov+RVhfl02IfRoGWtGuICgL7Timkh7WjFZdi6pkbvbWW8l
	SU+ir1zRe
X-Received: by 2002:ac8:5941:0:b0:516:d812:c35e with SMTP id d75a77b69052e-52b56752f32mr189669161cf.21.1785770974166;
        Mon, 03 Aug 2026 08:29:34 -0700 (PDT)
X-Received: by 2002:ac8:5941:0:b0:516:d812:c35e with SMTP id d75a77b69052e-52b56752f32mr189668341cf.21.1785770973581;
        Mon, 03 Aug 2026 08:29:33 -0700 (PDT)
Received: from atlas ([142.112.164.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e7ee283sm63597211cf.6.2026.08.03.08.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:29:33 -0700 (PDT)
From: Bryan Fraschetti <bryan.fraschetti@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alice Michael <alice.michael@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: Bryan Fraschetti <bryan.fraschetti@canonical.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl] ice: Restore Ordered MMIO Writes for Tx Doorbells
Date: Mon,  3 Aug 2026 11:28:52 -0400
Message-ID: <20260803152854.305298-1-bryan.fraschetti@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DQL accounting state which tracks the number of bytes queued for the
NIC to transmit, namely dql->num_queued, is updated by the ICE driver
when it invokes __netdev_tx_sent_queue(). Subsequently the driver
updates the hardware queue tail allowing the NIC to begin processing the
work queue. The queue accounting update should be ordered before the NIC
begins transmitting descriptors.

The transmit path currently updates the hardware doorbell using
writel_relaxed(), which (on arm64) does not provide the same ordering
guarantees between writes to normal memory and writes to MMIO registers
that writel() does. This introduces a potential race where the NIC
begins transmitting descriptors before the dql->num_queued update is
globally visible. If the NIC finishes before the update is observed by
dql_completed(), it detects an invalid state where more bytes have been
completed than have been queued. When this happens the following BUG_ON
is triggered.

  BUG_ON(count > num_queued - dql->num_completed);

This has been observed and manifests as the following crash (note that
the trace has been trimmed) in an environment with sustained network
load that uses an Intel Corporation Ethernet Controller E810-XXV for SFP
(rev 02) on an arm64 machine. Replacing writel_relaxed() with writel()
in a test kernel eliminated the crash in the user's workload, which
previously reproduced the issue reliably.

  kernel BUG at lib/dynamic_queue_limits.c:99

Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
pc : dql_completed+0x268/0x2a0
lr : ice_clean_tx_irq+0x1d4/0x620 [ice]
Call trace:
dql_completed+0x268/0x2a0 (P)
ice_napi_poll+0x94/0x520 [ice]
__napi_poll+0x48/0x3f0
net_rx_action+0x194/0x420

This restores the behaviour prior to commit ccde82e90946 ("ice: add E830
Earliest TxTime First Offload support"), which changed the notification
mechanism from writel() to writel_relaxed().

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2161572
Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Bryan Fraschetti <bryan.fraschetti@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index c04c5856dad6..4e26ace793ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1561,10 +1561,10 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 			}
 		}
 		tstamp_ring->next_to_use = j;
-		writel_relaxed(j, tstamp_ring->tail);
+		writel(j, tstamp_ring->tail);
 	} else {
 ring_kick:
-		writel_relaxed(i, tx_ring->tail);
+		writel(i, tx_ring->tail);
 	}
 	return;
 
-- 
2.53.0

