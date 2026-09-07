Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F53F12CB
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817757; cv=none; b=orDOXtc7crH55xsUfaerT6IJr6FNrov8065lJWSoj4pLk7Ai7prYjQPpvxBboEVYzM+JKLiIDAqBX96zRfZoyExhNl8dEvPWJ6VNRhThYnH2Xdlrfv96IKHXZMwnKfcWf6+61YKTYbO9zf/SB8T44Rxp/PUb4rgM2pCMyYLRRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817757; c=relaxed/simple;
	bh=JN9gYzc/v/Oe/UOKehftiWvZL+ZAgaoWW6grkyFf2ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O3odi2hWlEQpDYOHyCw7T/s7pwVwIaL7Uc8LDtQavDGIGf2KiggRwTuVZJPpJWVRkg9os971NL5aqBqQGTlPnmTNIw0C/0A4qtav6E/jGkYdVhbUaxbN3V8I2yzWVYP33xFBvBj9/c1jp0WJgmDE4eohmaYzFonDNhOxt/SFlbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXWoK9Rm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXWoK9Rm"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d7200b2e15so40864725ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788817755; x=1789422555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNYNu5VSIpA36rEiicg4wvTgWjE3wXILpPlxCk80WHA=;
        b=VXWoK9RmcDjojjpBfflvnIijSSG+V0X7hKg1y1/L8cw3ZZlytzEedpDnmPlwutW8Sv
         ifUuWJ1Sz+X6+XpWOSk4Hos1PTPbwOzbiF9SrLehJVoh1Q03jCuDa7nRKBejLCk3zZhy
         yNB1LglPuKPJMjfMcSv46KNeNpTsGxkyZf4erfnTA9ICsdwcbvBxEEsswGC8W/GE9vDz
         ihzJc8C1oeClqXIIrR+xi7IuVqPJRTaY17ELB9TU75OwxzEnU2Lb21PJ6mLgL3MlU2bb
         3EZJMylhRZFFi8DPXYlH40zjx3xj663VBO1XZcua28tWpc7rrnHazSnRH8tI4wqfG7uP
         ueyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817755; x=1789422555;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aNYNu5VSIpA36rEiicg4wvTgWjE3wXILpPlxCk80WHA=;
        b=GEdqUwRV/WHG5RZjNV3KuFEVZhR1WabxJMJ52sE92jcSlkiL/XhiKyQR9YOGmP3Dio
         GHcWqwz9PCKAIKnFUo+U9IGNufuumOl4ZyBYTmtcU0l837cGKLVAL6QVs80H5g+VbTYB
         PRto22ctSmTL9B732IxQvv1amcaDKMMw3nmT21iMnJYHQRoz3rx9j8tdn05Cw9teavzp
         09VQhnyEhfpA13Ov7naJtBSXziYhaOnzPhfk+V29g2IIC82Jj1urQo1VUWnO9XGjLHBa
         1Nx0vU9NdB4s8mJx9nfCv5YOMI+wbYWhkDDeHNVB+8+Z2fEQqJ5VuCSWuKuzI9JNKP5+
         2yAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeBydNNZryGw1rzJ1pDTQogs2xlFlg14uhFdfVu4i7555kFiUo0c/sxFu3KL9qQ3Bq8X2L7UM=@vger.kernel.org
X-Gm-Message-State: AFuF++n45DhYfYOx0g7opNYJD37hVoy7DHrgeLfDQCjmCPgnj+On2Cph
	jorVhF+NuIdBg4TtmcqJeYwX9RjegSyzx70c4jRPF/LqU5Dgwnv8m1Rc
X-Gm-Gg: AYBFou0qRJs8tZ0ZWSxkt0HBki2tgrWI/EMc+4mdWqHHv6bWdADau7tcRSj3VCsLVRQ
	6iwBeAjsXibTDXk3W2LYrZUYcLTfjHQ6pYWYjCy1X+BefQ1eG4H/2z7e+nuILqIJzX0fxfbsEjS
	YhLBCjGOAWM/TfJhwcU9dSq4lZD0Nz0n3xHZD2U+Lnabl09FiTnS0HRHoPo/OE9sMJqEP5m0eSG
	XBD1a/J5v7NQrgz1LAlXoIepx0735BhpfPhJQFMWg44NY4raIz2khAk0sEhncItDAyxPZxvtuGS
	fZGg7Ktm5bF/NMPD+Ts8as2m6+sVB/1iZGIe1nVzJNVTF3/f3MZUSJYpIyLIdfht803YoTmY2Fu
	8r2T0rJeEZDpjNcyovE8x4lVBmegiRoJ+qb7zQVPhxUerXt9hbcFgL5Y5TPZXqAGHNDdSK5bz5f
	pxBpfJuLRNQc/WEiuDrvTWX/Kg3dNwBpT7QmeyGaLYvixl+dOrH3S1+/Ra9JJ+/6i6gowCbVsNh
	j+kgmcYVHGPXHZgz7H+Xc1qsGCchni1tK8WpCkaKOY=
X-Received: by 2002:a17:903:2b06:b0:2db:3729:22de with SMTP id d9443c01a7336-2db372924demr194357385ad.0.1788817755085;
        Mon, 07 Sep 2026 14:49:15 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14841eaasm48794155ad.8.2026.09.07.14.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:49:14 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/3] hv_netvsc: Fix leaking of send/receive buffers after GPADL teardown error
Date: Mon,  7 Sep 2026 14:48:59 -0700
Message-Id: <20260907214902.9046-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a Hyper-V netvsc device is shutdown, the GPADLs for the device's
large send and receive buffers are torn down. If the teardown fails,
Hyper-V retain access to the buffers and may continue to read or write
them. Consequently the buffers should be leaked after such an error.

Leaking the buffers used to work correctly, but was broken by a
commit applied in the 4.16 kernel. This patch series restores the
correct leaking behavior.

Because the large buffers are allocated with wrapper functions
that allow allocations larger than MAX_ORDER_NR_PAGES, leaking the
memory is not as simple as setting the memory pointer to NULL so
vfree() or kfree() does nothing. A new function is introduced
to specify that the large buffers should be leaked.

Patch 1: Fix a bug vmbus_teardown_gpadl() where an error status is lost.

Patch 2: Introduce vmbus_leak_buffer() that causes vmbus_free_buffer()
to leak the buffers.

Patch 3: Use vmbus_leak_buffer() in the netvsc driver.

Tested by hacking in code to return errors from vmbus_post_msg()
and set_memory_encrypted() as called in vmbus_teardown_gpadl().
Then did unbind/rebind cycles on hv_netvsc and hv_balloon devices
in a normal VM and in an SEV-SNP CoCo VM. Verified that the expected
errors are generated in dmesg and that memory and vmalloc/vmap
resources are freed or leaked as expected.

Changes in v2:
* Add a new patch as Patch 1 to correct error return from
  vmbus_teardown_gpadl()
* Patch 3: Tweak the commit message
* Patch 3: Remove now superfluous return statements

Michael Kelley (3):
  Drivers: hv: vmbus: Fix error paths in vmbus_teardown_gpadl()
  Drivers: hv: Add vmbus_leak_buffer()
  hv_netvsc: Leak send/recv buffers if GPADL teardown fails

 drivers/hv/channel.c        | 36 +++++++++++++++++++++++++++++++-----
 drivers/net/hyperv/netvsc.c |  8 ++++++--
 include/linux/hyperv.h      |  4 ++++
 3 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.25.1

