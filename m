Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495340963A
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959241; cv=none; b=QU06rnaS2UHa8NGbfWJR6/oRSUmwbmMzbkWkv5obAmy6ZhaUb3udBrfLLcMsvn2wrnAbP8n70sMswPpg84qy9YfdFChU6pWbZUbjCp0g73mJM1UA0Zho36/csgt5tTHtePyiOiXCqq6wFGeTobQJtnQIj1/SRjpVXIi09P+lbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959241; c=relaxed/simple;
	bh=f+qohAJuN1F6Q1Y0tiY5g2sfEJf7RRk9kbfAPocR7c8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QWF4aoXjrP8g+OweTY1aA2ihcVKznlHI1wveAgPuWY6yKffZmIXmFZ8xdy4J7ZtjHqSaUq72HfeUYBfh+6+t2fEtADqGQ4ahPvLf4whJrDf60pOGZbboYNUqPk33Fp80HZ7IMSAn50S66MsXXfqZWIdj0BoCqzTrnz7MozJ99X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mINMR+5P; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mINMR+5P"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso4733505e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959236; x=1792564036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WrZ4/u4jJEQM0ZlZpxNQ2Z1WiaeNhYEi18x7PW/q/M=;
        b=mINMR+5PXWd43jUHM9EHjImQt/B6OVF2YoYXSwNTes307c2+t9+qN5I/9U4hx5l5UP
         sh5GYLsCuhwnJzQzRf5T38jihxTgh/AOZY+c2IK9Wyq6+oASoNXH6sucSdr/d5rkQ3IN
         aaQmjzJHZNB/GKnwKKR5CymeFs+8LowxixRLXr73UvRliZZPWiZRKxAZX8VEXHQrysPp
         rqBBmJCbsjecn01wC8VyEdzysL7wzIQFq7MWpsu86hLGZAd9Wo8G96/P7PAlEK98dtYH
         FPILoK1lEhEBhyNl/c2x2/Vcmh57jwVqEpYx+5QCvDbuNGiMyQNEoKBArEdLsrjJOS/A
         xrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959236; x=1792564036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WrZ4/u4jJEQM0ZlZpxNQ2Z1WiaeNhYEi18x7PW/q/M=;
        b=07etouifjDts+3Jk+b7cvOx3HDdjIyRFjV5Nws3he/a6fIkUi5n7N5WvbQzD2mD7Qf
         2hmu5kcsqXqUvd4e8V0EQmW9DbRWa/B1KnP8vJPPY/nHcHujdtqKmlvojd0jSvRp6iYn
         3OhNeBGlc7L06MpnBxlcAEJ+lDGm7Q6Ltb1BGtqYrSHZ1zJU2hXBp+pAQSX5IHXYwrcr
         UmI4kAu57UI7+82ki6QThiCqyjvOZWOKl5GabCW3UtjuJNUX0Wdo0CmozNJtNjoUwHVe
         TbSKSX5sorQFiV+x4Lag9vZAfY2Y+ymxmhNBXsGbWklPa5wQg3eOGLYIAwtPbnerXi4c
         zlzg==
X-Forwarded-Encrypted: i=1; AKwUvBzE+kwt9+P96ctPJDzqKLY+7CWMaD2wSeK1z0ZT6NevHj0H4JYQTT0X6pGh2UpmW/B+4NiROUM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/Z5OhtU3km0imKJURq6qDkLv/NRrtyh8u2rCj22ACyLvo4w8A
	hcgI3op/ld4Pe/+ZvYBrcV7M0xlz+oy0h3HIoh97lSMtYWFEO8zYklqb
X-Gm-Gg: AYBFou1of4JPCSjzsqOKr8vCfbkHbwlfW0DIk5Ft1piMQVzzxiA57Cl0oWIWxEBQdSf
	vw/K0QpiHaA+e6t9IIseho1T3hzvzhUTi8WI4UkotxIz/zxyuuCTJDxGZmZDb26zp9LlmgJTSvf
	uRGvAfWEhsKwDeSqVQnbPkZgHQa9y8g19IkufILnrAWvYWFllWXVijoMSdTMuyUM3fSgycJfcvl
	dasN4gu9PPUKPhJ9hf+3zwex6I1qQy3e+l/sf/3dtvhBDsbW5n80z/mp9h2dcaYGSwMM1VuXLaB
	bDo4qPh4LoZsfeDUZ0OhANVbSiQqr3o8AYuM3A0YoY9d1WuIsembqt6pS7V5UdB9GhsS45xbtsz
	jFenEmQ3xvb2IdP2GxwmwBfkWj7HC1fzt1c2hYpvLYw3mtY5cONuYHti1F/yN+0IMocntN0yxjo
	4DoTZ8MnTfruEtwcCFK6WKMvldNVt3C7P0ZS3Ixmd79rWUiQPOahSi/WuNT3yljgWxeaATy0hwg
	bxuUzSlK2t/Cztb9oUJYy7+JZWI7pvAB/1cnz6O2WIgroi53QciVrmVSmgwLO221KkCcLZ8BlO/
	vBRtCPL1r0IJQ6yllsX0wGqFv1W0P0NfSfYiJlVKDFMewBlMMvnWuGaLFP9IpbW/HGuhT8kywp0
	A8ixkOrEtaUY3
X-Received: by 2002:a05:600c:19ca:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-4a18e4487b5mr298737055e9.1.1791959235651;
        Tue, 13 Oct 2026 23:27:15 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aed1-da01-ddff-863b-8308-ab16.310.pool.telefonica.de. [2a02:3100:aed1:da01:ddff:863b:8308:ab16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm528846745e9.4.2026.10.13.23.27.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 23:27:15 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: stmmac: fix DMA allocation and IRQ failure cleanup
Date: Wed, 14 Oct 2026 08:26:58 +0200
Message-Id: <cover.1791958735.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A DMA error-path review for the BeagleV Ahead found three bugs in the
common STMMAC code. Partial allocation can call buffer cleanup without
the metadata it indexes. A later TX allocation failure leaks the RX
resources allocated first. IRQ registration failure can release
descriptors and packet buffers while DMA remains active.

Patches 1 and 2 fix allocation cleanup. Patch 3 fixes the IRQ failure
unwind independently.

Testing:

- BeagleV Ahead, TH1520 DWMAC 3.70a: guarded baseline/fixed boots for RX
  and TX allocation failures and normal-open IRQ failure. Baseline runs
  reached the guarded unsafe boundaries. Fixed runs cleared the tracked
  resources and stopped DMA before cleanup.
- A matched follow-up applied the same RTL8211F-VD resume repair to all
  baseline and fixed kernels. At both 100 and 1000 Mbit/s, each variant
  passed eight close/open cycles (32 total), delay-register checks,
  pings and bidirectional 1 MiB SHA-256 transfers with no RX CRC or
  DMA-API errors.
- Native-XDP IRQ failure was exercised on the same board. The baseline
  reached IRQ unwind with DMA active and required a test-only rescue;
  the fixed kernel stopped DMA before unwind. Both reached descriptor
  cleanup with DMA inactive and no DMA-API errors.
- The physical native-XDP pair used CONFIG_BPF_JIT=n in both variants
  to bypass an independent RISC-V execmem Oops after the STMMAC unwind.
  The default configuration's XDP-open path remains covered by the QEMU
  fault-injection matrix.
- The exact combined code passed 24 of 24 checked 64 MiB transfers on
  fresh BeagleV Ahead boots with no DMA-API errors.
- QEMU orangepi-pc/dwmac-sun8i: 36 of 36 cold boots passed across the
  allocation and IRQ matrices, including XDP-open IRQ failure.
- The exact combined code cross-built the STMMAC objects and BeagleV
  Ahead DTB with a RISC-V defconfig and DWMAC_THEAD enabled.

The guards and fault-injection hooks are test-only and are not in this
series. The RTL8211F-VD repair is being submitted separately.

Based on 24a19b953e2a (Linux 7.3-rc7).

Karl Mehltretter (3):
  net: stmmac: handle partially allocated DMA queues
  net: stmmac: free RX resources when TX allocation fails
  net: stmmac: stop DMA when IRQ registration fails

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.39.5 (Apple Git-154)

