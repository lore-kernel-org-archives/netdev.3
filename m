Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1035BDC2
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036575; cv=none; b=MOin43KWMnmfSvPqI+1w9qtNbIa3GSSu+tW9UMxPhRADEaU3ZRRVdW4EStMSk6BwZaG+eZVK423Pht8R5tRfouUajR5mneWQFRX+mxj9PDF6VO3IBsxkCL7zKc9H3t26x3bkPMs8TOPZ67TSSkN3QSDHpT0KI6/wKq6ZI/WFAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036575; c=relaxed/simple;
	bh=1XZ7TNWfgxPyHv3AyteAH4oittq3DzFQwUq/QtfpCP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQvK5Qwa4AHncqiGcn3x/IB1MVbfoXg/rmtfgrx69cTzIm8cRhXZ5EyUTffLStRb6tQxvHUnAkXOUxnzujVVwNk93gqZc/qawE/F1XD5TsLt3VGndsXOXt8rkds9SaTudQ+9oLerHt0F2BsLH3ErvEHEa5+Jk912Copo0OAHNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEDRruvp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEDRruvp"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a16629a040so7541315e9.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791036571; x=1791641371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oUswOxapHow0y3byrU/sf0EaKU74JMXEcnoMlCfceto=;
        b=kEDRruvp7vLoG4+NDDl8Nb3gOSNj7Bemy8+9rXKyBwh3XjrajR0aAFGdxO64tzgXJ8
         YsCz4Y4Z3ceKbxS/WHU93mI0fcQTX3YujeWxOJ+GYD4DASann1VHX4ZfbWTg1FPAaHdS
         YbOsyJn4co20tK04HHn+5TJW3vUWSS9nqYxcEruD+j3tFfv6IOs6DuU2bm1qLOD38nkG
         L0OzXRw/KlzwwfTl9qzaMiIRHHwSJnh74xsq4hUexN40omxtIyJholpgGvAnFLzXa5Qy
         fDOA1kstYZUqi7oqtVkZO9fYzr8tXEn3j8jRZ1AyDwbxDVzC0UjOG9UcuRlGhoG5KpbH
         kyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791036571; x=1791641371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUswOxapHow0y3byrU/sf0EaKU74JMXEcnoMlCfceto=;
        b=T6dW8xN9cHT1LzZOI1JEwC/ZiRBsPsVGSy4Qqt52xete1cEJ6ClPsaVzsXmrb530mc
         BpURtqTtrLvcDwV9Eiq+ASscPTY+DQD4q+yo7BLh1kOCTcmf65iz2lFUhI7j4pFDLGCI
         GKQw2snCppnHGHUbQIfvW9J4uS6Pu/7vf3RWZ2nnkQ+mpS8xPHvjZLwF2TeNlzOdn2FN
         MEW2DhjUgoL+lZSch4pmY8aA99GbZkYXar/lpJFxv1kHlQwe+K57QYxtZa9OgoZjRwLt
         zj4UksAaS7vZ0urJUDVLR7WRX/4u/3Y4ofvmnaSDrBqWIQBgJTZ10E1jBY4/RZ1YWuYn
         QFRQ==
X-Gm-Message-State: AFuF++mgMeBjuxLshDOAiiBJJJ5ApdBoHMWpT3Lw5rrg99pzzmcCbjWn
	x3ioNjAVInhdf6vx9AeU7+oywjnJ8Mh/jfcttITn4HTHIkUtx3MfmOcSEyKwdfmH
X-Gm-Gg: AYBFou1Tf2EUvF4gMER1pc8rdYxm8aSrlh6OvT04WSKHvrAKllS3pyi+OugL3k7qGXl
	YOt5oCwv8wX6zYSovEep79gqCCERYmGVBGv1N8qrvql7saazHvUI/TnZIBqNtbjjvwvBCfIo6Pj
	xHfDZfPtt4N6QUQlF67oL6/E1gpM3DyFuekYnXtG8eMtkKti9QZNB5kbhXnDUJy0JVDiUYQUF4A
	gVUo/pKl8HDqWlEbduhSPMMMsbzcygCR3MXDcg8/SHSo/zXpB6udrUwSCIHtyedru4M25r9cMOI
	/Ql3KI/8sFvlZm8QG+TvBJ+pHLJTtsGxfiqaNfQFZL0seU0E1KLsT2E9k99pTtvQ5Sw0bm7Xs02
	oPmSgMNNs3lSlLp6tAdOEZklRhYqP0cGFxCaOgm3Xicg5SGhdDifxXCqmhi+1VoSfa/bwr3W+86
	V3KhB7aiFdOIEpcO/0GW/XCrothZKoDkm4vvEQDmF3v3poPuFaX2BlTm0pgE2wt3/0qBy7UqQjJ
	TkgtpPcVjGmUfr3WwQgNq1EY55mzufrxSN7kzY7FWOho6Q+BTkouFfLEQc1OWBW3JsMUCGQLbeP
	a+zZAo1Kl5v4LeEIH7oiiR5m08V9BQLGcN+lw/jRqeX6zPSjbOOXhJtEK5/Ld5SIbdU+e8I5oDT
	/jw==
X-Received: by 2002:a05:600c:4708:b0:4a0:dca:b78 with SMTP id 5b1f17b1804b1-4a1680f4165mr40509335e9.27.1791036570603;
        Sat, 03 Oct 2026 07:09:30 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bfafasm184098025e9.8.2026.10.03.07.09.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 07:09:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Keerthy <j-keerthy@ti.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 0/2] net: cpsw: fix failed-probe cleanup
Date: Sat,  3 Oct 2026 16:09:13 +0200
Message-Id: <cover.1791035789.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy CPSW driver registers its netdevs before requesting IRQs. A late
IRQ request failure leaves two lifetime problems in the probe error path:

  1. In dual-EMAC mode, the secondary netdev remains registered when devres
     calls free_netdev().
  2. A registered interface can queue rx_mode_work that survives the devm
     allocation holding its netdev and private data.

Patch 1 tracks successful secondary registration and unregisters the netdev
on the late error path. Patch 2 drains both interfaces' work after
unregistering them, as cpsw_remove() already does.

Runtime validation used a KASAN-enabled ARM kernel and a local QEMU
Arm virt CPSW probe stub. It provides one or two fixed-link ports. Its
device tree assigns the same non-shareable SPI to RX and TX. The TX request
therefore returns -EBUSY after registration. Test instrumentation opens the
relevant netdev and holds its real rx_mode_work until after the forced
failure.

Each result was reproduced twice:

  - Single EMAC, original cleanup: KASAN slab-use-after-free.
  - Single EMAC, work-cancel fix: clean poweroff.
  - Dual EMAC, original cleanup: free_netdev() reg_state BUG.
  - Dual EMAC, patch 1 only: KASAN slab-use-after-free in eth1's work.
  - Dual EMAC, both patches: clean poweroff.

Build testing used this series on the net tree at
6dc989ea46b96ce170840174b4a38c4a387fb005:

  make ARCH=arm LLVM=1 W=1 -j12 vmlinux modules

Clang/LLD 21.1.8 completed both ARM builds and all enabled modules with
configs derived from allyesconfig and allmodconfig. CONFIG_WERROR and
resource-heavy debug options (KASAN, UBSAN, KFENCE, KCOV/GCOV, KUnit,
kallsyms, KGDB/kmemleak, tracing, lock debugging, and allocation profiling)
were disabled. cpsw.c produced no warning. The literal allyesconfig build
first stopped on warnings in untouched files promoted by CONFIG_WERROR;
with WERROR disabled, its instrumented link exceeded the test host's memory.

Testing on real CPSW hardware would be welcome.

Karl Mehltretter (2):
  net: cpsw: unregister secondary netdev on probe failure
  net: cpsw: cancel RX mode work on probe failure

 drivers/net/ethernet/ti/cpsw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)


base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.53.0
