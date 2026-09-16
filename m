Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26323AE197
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789527149; cv=none; b=cxrd2VcFCUYm11/jw2qY0YOPQrimA965mZvCK4oK3oByN6gNMqelAaXegUjc50rmDnMCmbELcHsNbygwsvdwIIhpjFbmrNrL46Qa3vBC2RWZOSXLuNBkT+wE1yI6y+bmF8aLoVJz5NZzzIEVsDSosbeFlrOSR4KbZVn0ReOvXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789527149; c=relaxed/simple;
	bh=tX9M+W6f3YXesN8e9sqc2endp/ilgoluGKgnYvWZ2YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNJBw7d8imjjvm2iHZX8lH60bBgxBAlgPAqt2LNfehq6BnnbiKErZSe+tW2RzWgu6KaS4uImOhzIqxbiNTqFobXEXLuMvdxyoRu1ilfC+kNmvfqJzvEd30Q0lFXP1fHnaIlsTwQzWn7iefOySi7cqtYYWxHukjeATeg0LvU5tBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUY8FHpt; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUY8FHpt"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8674704dab1so544490b3a.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789527147; x=1790131947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4i5M/+Fcpjtf5aQ6npx1txWnbcVS6QYJviLzGTvfRwQ=;
        b=rUY8FHptKrMiwUG9/g2dcbDsRs5GN1MoJKfwS+ruKhBxsaplrnQUPoCL1VtRxbNJrk
         +axtsUUEMS+O01Oc3S1t5c2S4RoqEdV8QG++LdyCZUJtBBFUSCu1OK1TtTkvF7JxCRum
         VvJB4EeHxd0eJDKwLCBVmAsQb/H7alYhXyr4gQHjETbGTt30CLe41E6c63VzpDfolKWS
         3Eo4Oa6Uqc5tdR6uTpnImwCV5+9aVO+3ZzCIYHgNrTo4dUmgeuXKPM4hlUreThujHzhG
         Bqae+uC+FhITtVyndrG+FcixTDTi/B4YkK+VvwhKBk9oIbfyvETlSJwKDVpQjSPKCdb6
         CUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789527147; x=1790131947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4i5M/+Fcpjtf5aQ6npx1txWnbcVS6QYJviLzGTvfRwQ=;
        b=syqy49MfIr8abiSTVOMTGXjqo+I/uGXmhcMbp0uPk1oqdImZhzl9sOaWi278poq8Yy
         0WhsdjBz+VdxgExITsmux1M06qH3DUaejpXuW+epKcqHP9j+Xapc1y5zufJE6IoUgpFS
         UPv+MKgxV481YnytV75aFxFO3TsqKhXhamJeE/yPcGh/xFBDdnajc7ctBbXZda6/I/vH
         60lb8nbrAd1BDWhSQtjaJD+g201iRojTxjspb4ulSTFa9zJLrJPlumj9Pdf8pO5FxXry
         nOOWoLubDcR0D34Im10V194LiyPBUgRDDnORNRAMx/6lGifzsS3tvQug9V1ajF0l8x8o
         xwFg==
X-Forwarded-Encrypted: i=1; AKwUvBwkK0Xfzyd5UZ1iWEtPfSvhgrbqPX24APsYk6ImI+h6uVdyuRQGaE7ksTP90HV5MqcgtUw4ctM=@vger.kernel.org
X-Gm-Message-State: AFuF++k6Imok+QTQje0eWBTAHMZcPWTCpgr8QnU89ZHMwV0aZW3Upovy
	rsDLtwzU5mIrG3UTRaqJLbvujFZ8TssVfxKCzFd1xVv3NiJLeSR9U6hZ
X-Gm-Gg: AYBFou0VFlpziJ8/1flNds9j2ROgz0IRHpddUOgAAwZz8ZtRQXRn288mvVrVGENp++t
	ZMAZ5okvVHuXLA6qgU+1UU8MhLxC1zA3cYK18v7Uw01LJTKMpTbn65E3zL1waOATQ/iuSE+irQz
	Met18DoFy6feTLnv9vSXE/q3Of6xMLVeH/t9pEhUI9yVJGB+fToeQOQMMWL0jgM94sMUuMMTk7Q
	wGLmh40ONtbuG05Zb98IFGljb3AnmFb6s+FUxlBU+Il3xoF8nJDOMIK53OTklEGA021K3fW2mMu
	cXydqbs+ii/mqXXA8+STYDB8scXesBr9xFDm6twNc7Bzu+HLNm18E3do8ba5ukYb8k4hSF4+rSp
	x/6rKPGSzvoPoqS0g60EN0xp1e5kNCYI4wrVuPsQHahTGnkM6WuXQdG4almosXSzLg03ybOVU/2
	8868Hyx6iPDts+3J/1lyKBmyPLch9HrCYmEknlfbK2K5nEx+qApAKvgg==
X-Received: by 2002:a05:6a00:4613:b0:851:c2a6:172f with SMTP id d2e1a72fcca58-8723b87eadfmr1399876b3a.7.1789527146998;
        Tue, 15 Sep 2026 19:52:26 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8720172b126sm414532b3a.38.2026.09.15.19.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:52:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	Arjun Vynipadath <arjun@chelsio.com>,
	Casey Leedom <leedom@chelsio.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cxgb4: fix FW SGE queue cleanup on remove
Date: Wed, 16 Sep 2026 10:52:15 +0800
Message-ID: <20260916025215.2780658-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_one() allocates the FW SGE queues with setup_fw_sge_queues()
before registering the network devices.

The probe failure path releases these queues with
t4_free_sge_resources(). However, the normal removal path only calls
t4_free_sge_resources() through cxgb_down() when
CXGB4_FULL_INIT_DONE is set.

If the device is successfully probed and removed before it is fully
initialized, such as when none of its network interfaces has been
opened, CXGB4_FULL_INIT_DONE remains clear and the FW SGE queues are
left allocated.

Release any remaining FW SGE queues when removing an adapter which has
not completed full initialization.

This issue was found by manual code inspection.

Fixes: 843bd7db79c8 ("cxgb4: Setup FW queues before registering netdev")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 1ced6df6eac8..146419c66348 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -7116,6 +7116,9 @@ static void remove_one(struct pci_dev *pdev)
 
 		if (adapter->flags & CXGB4_FULL_INIT_DONE)
 			cxgb_down(adapter);
+		else if (adapter->sge.fw_evtq.desc ||
+			 adapter->sge.intrq.desc)
+			t4_free_sge_resources(adapter);
 
 		if (adapter->flags & CXGB4_USING_MSIX)
 			free_msix_info(adapter);
-- 
2.43.0

