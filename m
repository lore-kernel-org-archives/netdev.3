Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710229;
	b=dGMPheXz/Uh177Z+EIs9NvS13FNY94jaXCiwhvk+XLfnH2+TPuDFBfUPFLBE8s8azh5i
	 Y63lqSGYiv/Z1bE532v0ib5aKSrKa+4QgXnj4uZqZG90DioGNjV3DL0Z8SyTurben1945
	 8/OnkEeNxE0CwN4t8YPYf15aYHd3QjQkBeFxMSzBhPxEj1xDiHRfTyRkPVwmlRuzD+aVC
	 75EMR7OWSBaRXC2DdDiQL+yQ2nFq4qKlOGp3iQ5nNjRPLKHpZJo03kPUwGqh8jq5GBbbn
	 gmAS34mGfM8Jqmw0ajloxIoRvdOOcZPfLi7t7yZ7FqxR1M392WbO8a1j6nRvnZshpvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fVruni02f1KhjN7plFvbiZ0eo1NN/cpMLIaSDj/3PxE=;
	b=ImrjknLkg9rViZUUITPGa7Ftw8RyEcDH5qysBJ9Cq2ivABNwZZVjkHIoL4F7hJQeRTcL
	 1uLu6ZOoFDkN19+kn60u5FjBw3tJr68HUCC32VHwXKYSNsEN9YubkhDifItbJ684FO2pD
	 S750fznGcL/H1XJeFqD7X1b5Vw7OLCxumc4dDfogjF3XSZGAzA44QMmq3rjSRi5FDzPCy
	 cWMJVg4dBXahoDw7DR/LcFa+MWwebOx0hC18mKpklI2Ha4wkyPaoD2l5OmSSQVVkmHqIr
	 12uFzRYzTcwg3pXzp4gA8kXmbFJ9td0IHmpRJq7lIVUydTE3qwzQsZsLiJJLYBakKow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YIj+MeUM;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D033606A328
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D033606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YIj+MeUM
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so35121525e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793710227; x=1794315027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fVruni02f1KhjN7plFvbiZ0eo1NN/cpMLIaSDj/3PxE=;
        b=YIj+MeUMjk8k95d/WDY+hsdQQifEB+sLygCr+j6LiaDauxHmYHCQsdoXMALt2Z3gYR
         gNUDDujfzjush7WcwUz61uuquLt6mDyhbuHyclPsoEZhsWXjBlHl4eZ1ZsvmW2fXVRM1
         omKLdy9WWdE9KnhD9Ql7fp2ON6SD+ybGzDEEgEcSNkJAFqLZLLCtHITt4uzR6NrJBlKo
         xnEjZ5DtQEp62zYokgQwYQSNvL7+6FaHoTPM4iUZUVpLSo+5zzy7JbcGpZvxL8gJoshb
         tVOXluusG5wtLRUsZEx1AC2y2dZwhbfwCa3UruDw75B64jpHHs4Ami76FJ3FGnUcTocv
         mgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710227; x=1794315027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fVruni02f1KhjN7plFvbiZ0eo1NN/cpMLIaSDj/3PxE=;
        b=lwkjwCDn3CZeLTchFhQRqDiou91C6mHsWO3rDaT7nrF5vjeAzoBvNoDyqX2fBdFa7T
         nxe2VLsN5fiWXo59h5ii+rlG5aCCjct0tdx4JIK11qSJDp7O49ogiV4q9Atg5Cjky58x
         KQ2V90X8XNuoUdO/A8JlQsTj9BS+G+Lbwhb0xiMMJurh5aWi9jQRrFCxtzDbc2m4YsRF
         /xyLVgaX+3tgAoiWJ9AE3ae/U39IRv3e/5sjjku5EdFDynTun6gc/VzRdyCRicLn53Vg
         2brmisaDa5HjLszVKbHeDgh6CTt5r0uljcLjHsfY4m5CLICMdZSiqhsV1QNDqWtUTcg8
         RYdQ==
X-Gm-Message-State: APuU4Z+3kFUxI/2T2x+W6Ri6PUHTV8sAwP02qHWA8ByLVzM2F3x4EJ6k
	pE5K1sjjob2sIIC6zrQLQJ1E37O0Td+OWhNt73SBujVwaBaeGLk8JtKfleo/pPwh
X-Gm-Gg: AYBFou3C2U5ypVWNPi8bWKyxEKP18BbYqz5EPIkuIh6yrjf7CdmY3bQpvS+n72yafq/
	+ME91W+VrhvllKBGLBOt3Pufl1SVNGDbGlZO5DcGKZXWRNG8nqykqsvTPbX5lh6nBL3QEhD2sIl
	auXd2LOqQxj9sQ8I5u1gYi+yvS9IGwjJIKDYqpIgU6Jft9WATAH5aUqPX8hMjS8LYwVeVB5Il+A
	dGVRKb5HkvA21Tkh/DmtuER+IN3tZQVERWWiTmjWOkNzZA00UydR1omQ17pMDXjZPJ2SeurUS9Q
	W4gvorPBg3pDA8A9n87AhfTpU7LKKabsJCvGwtuXXxg8lu9Urr96YAs0GCjRiJ/C7Jwf/e9MCnG
	5rd0FXqh4Yroxl4nW5t7AIryTvZOp9+TRrO+Mo1lXmuHYRmq6HWtW1n4EvK+v4a0WFV82ZCbgLB
	b7GRji+VxYTRoATTJblipxh4HY4q9bChxWNRM8RmjIAN0eOibtAjtkm0Z687FZ/8aX7AiyGbrvk
	xzzcFc0nuw2qYDI6C9z/xH7sjxvgELos7kjk5VPPjaBMLBIolMrAZnoc9lEWlNYxE1X4AXn6L+V
	Mv09okht7VEDOakP2f8xqwbiv3eJaWZ6cUJLBIUzX6kR1o5ixQJx78b/zE4zWa1mzhE5osppwPS
	XGGwUUIcwDclFnjWa/xTsFeSyG0/sI+PO8S6xvoqy10KIy7lWZP5/guDqA1kIWg==
X-Received: by 2002:a05:600c:628d:b0:4a1:e01e:1927 with SMTP id 5b1f17b1804b1-4ac17d16a1bmr294497215e9.5.1793710227348;
        Tue, 03 Nov 2026 04:50:27 -0800 (PST)
Received: from localhost.localdomain ([2a00:102a:403b:96a2:e8a9:f4a7:ed37:36a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm61406425e9.0.2026.11.03.04.50.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 04:50:25 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	w@1wt.eu,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/5] net: mvneta: fix the TX queue arbitration and the mqprio offload
Date: Tue,  3 Nov 2026 13:50:16 +0100
Message-ID: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The NETA TX arbiter is left at its reset default, which serves the TX
queues in fixed priority. Under load a busy queue starves the others.
OpenWrt has worked around this since 2017 by sending all TX traffic
of its 32-bit boards through queue 0 [1].

Patch 3 serves the queues in weighted round robin. While working on it,
four older bugs in the mqprio offload showed up. Turning the shaper off
leaves the per-queue rate limits in place (patch 1). Deleting the qdisc
never reaches the driver (patch 2). A failed setup is not undone
(patch 4). Opening the interface or changing its MTU sets every rate
limit to 10.23 Mbit/s (patch 5).

The series was tested on a Turris Omnia (Armada 385). The other NETA
variants were not tested, but the driver already programs registers of
the same block (MVNETA_TX_MTU and the token sizes) on all of them.
Suspend and resume were not tested.

With patch 2, replacing an offloaded mqprio qdisc with another mqprio
under a new handle loses the new configuration. The new qdisc is set up
before the old one is torn down, and the driver now acts on that
teardown. Software mqprio loses the configuration in the same way.

Changes in v2:
- Add patches 4 and 5. They fix the pre-existing issues that the
  Sashiko review pointed out.
- Patch 1: say that deleting the qdisc reaches the new code only with
  patch 2. When MVNETA_REFILL_NUM_CLK_REG was never programmed, the
  full rate refill keeps the refill period that the queues have after
  mvneta_txq_hw_init() and only raises the tokens, so it is not slower
  than before.
- Patch 2: describe the replace case. The v1 cover letter called it an
  existing limitation, but before this patch the driver kept the new
  configuration.
- Patch 3: add a missing blank line in the commit message.
- No code change in patches 1 to 3. Rebased on current net/main.
- v1: https://lore.kernel.org/netdev/20261102112816.12322-1-pepe.schlehofer@gmail.com/

[1] https://github.com/openwrt/openwrt/blob/a5e96c837ead549820867bb83c1ad471e39f5ace/target/linux/mvebu/patches-6.18/700-mvneta-tx-queue-workaround.patch

Josef Schlehofer (5):
  net: mvneta: lift the per-queue TX rate limits
  net: mvneta: fix the removal of the mqprio offload
  net: mvneta: serve the TX queues in weighted round robin
  net: mvneta: unwind a failed mqprio setup
  net: mvneta: keep the TX rate limits across open and MTU change

 drivers/net/ethernet/marvell/mvneta.c | 91 +++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 11 deletions(-)


base-commit: f56daaadfecae1f760d0fb34385b256d3af68970
-- 
2.54.0 (Apple Git-157)

