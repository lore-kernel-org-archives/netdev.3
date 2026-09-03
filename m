Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A84AD7F3
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451638; cv=none; b=o9fbGZV/RfrR0QxAyTUwd22Yol8ZS8OU8fz7XgRDBS7aHvZlXTMe8+G/UO8pFO7MVW3LSPsEKwK5iDmF69a9DhXZ+nFRyjX9PCsOBWi0DwMSH0mQKyGF3N9e3vaZnXhS5bs8wgRYUfmkm/7sNA9maRHeQmRnwBMFVfTGKssTpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451638; c=relaxed/simple;
	bh=4nfVwGbxhCKSpPCmUf2T+tRIUDg90eQLoFxKdHwqJyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aikau0nakPAGjty1wrUmfawy6/3JVVb5knCEOE3i7A3iYeJu13bf0+fEsT9RN+tgoTzlL56z0p3w8rEzDcrWUTyjHBkAztDQD7JfNtq89Lb6kiCy9C6MxtPg4kyiyJrzPM5gBsasY4WwrtlUqXRP+uU37Y3VzB6/06IjogBrM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyqA4QAY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyqA4QAY"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso3099191a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451636; x=1789056436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G6hrH/lA3aA7eJREheWu7J/A2b4LUsrs+Hdunm8t3Ac=;
        b=KyqA4QAY2rKUszlkyZi4ovuEXZjYUFB/yr3ZWJTstgICFJb2MhlsxkORXh877+MXHk
         m5wrdHoAB5eXp65Q/JUQ3owvBRc1oWx5Dh5SCmJgW8BzLp1inhX5e/5FRh+G3xDCYb8S
         wkSldCSKMQGMPYNbAhTNYsymnYRfC8nUF9rMFZCEknjdNU0BfjCb6TOlcVaMmGZmXkn9
         792k4RfIphUM/figciL6bjxV+fAthZrq5mFVWLV3Oa9+1eJnkejjZ0vaOqvlDfzwXQFe
         ozllDBU5svGEOHLyFDc4KRPDLwkzUedyY1q8SXV68rqt/07b/IjiGo3sjkszWmXWVI5e
         dKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451636; x=1789056436;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G6hrH/lA3aA7eJREheWu7J/A2b4LUsrs+Hdunm8t3Ac=;
        b=XIlcAOPnr0abHZ/8ggEZcTPzxKF7KCnTvt4hNzPrjeBsBMiqkSQktCpYx4yIOMZtEt
         mmxGockBrBqIZS9AWxEMxElxiBjb9oYOC5ZF5ayzPKrUvrnWXbvfTORA3XT0uMQZGJRL
         iqqZ3AGxs10mX8hxmnmXhXpm6Y1MJfhsWjm8cWSL9VxJygRprPv9uyQfOQ1DEh4SUyEY
         HtBb3ZVTiiW5DhV7s0g5F/TJUL0/XGPEmaq4lIkrstV4ZGFiSg53bkmiNhEVfAxXsWew
         n9R3xUGNsSTLKG3iSqlKwz4MbNIoXpYXbRhJPJwVDsQADTcsLmn3jaa1tllO723KmGoL
         dmtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzg3iiA34Hx1TFYXNbSJzC/3/O1/13VyQ1lrXdSBAeF04YvUhYS8ak0u5+dZ3NcxBG+NOxoqiY=@vger.kernel.org
X-Gm-Message-State: AFuF++lxkTRQc00rjvqYRN6sSnV+B8KtOSNQ6okHKO3vgf+P2tUC0yVd
	Aii9zaMaFENC2wIQIc4arq4r/4yz1kv2SlRFVvWcd0ZYIj0meSygkQdI
X-Gm-Gg: AYBFou3V56fby/8PAihsNv4CQ2EKWAFVzkBEPxqxJwGussLiE9XSpyIVoGh5Dnv3vda
	hhM1ebKSQ1PxJKvCzsZTzEYuPPPxpq7dJpbf81uUBqxfValzzgbhZoTTXWHFujq/HwCKiaYRo3L
	9tLIUGq0umDJRaTnvbmTay6uAoEgvHUuMgxpJfrVV8rKk+mbPmR2SxkkL74kYCzFcjng+b806Ox
	3a+L135A4YRmsVqScWCE7fej28jCqyEIgWqJ62M+Fwp6+Q1g/Ay5AMCNwKZw4MqB00JlyvfprXo
	H7xZWAU9lZziuZ0SA/Oay1ccVTylmLcmMFgFM2VC1vNuB9f11krNMd8UJD3hU8Q71Pfg9oZaSBM
	1w3/dkT6YrgRRyEHrBqhAqLRK+ftcgqPgDspkXe8Hwg9TLdBx4Bp4ww3djqbrZKNeoVxuyaoDXs
	PurCDJUQtH4Bobbi60rddb18nVM6x/0anFIfHhtK7rhqxDg7l9e7owB8bQ+B9QcGltTw==
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39aee04acdamr22881454a91.14.1788451636126;
        Thu, 03 Sep 2026 09:07:16 -0700 (PDT)
Received: from mhkubun.mshome.net ([50.34.2.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccc72fsm3702020a91.2.2026.09.03.09.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:07:15 -0700 (PDT)
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
Subject: [PATCH 0/2] hv_netvsc: Fix leaking of send/receive buffers after GPADL teardown error
Date: Thu,  3 Sep 2026 09:06:49 -0700
Message-Id: <20260903160651.1637-1-mhklinux@outlook.com>
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
vfree() or kfree() does nothing. Patch 1 introduces a new
vmbus_leak_buffer() function that causes vmbus_free_buffer() to
properly leak the buffers. Then Patch 2 uses this function in
the netvsc driver.

Michael Kelley (2):
  Drivers: hv: Add vmbus_leak_buffer()
  hv_netvsc: Leak send/recv buffers if GPADL teardown fails

 drivers/hv/channel.c        | 26 ++++++++++++++++++++++++++
 drivers/net/hyperv/netvsc.c |  6 ++++++
 include/linux/hyperv.h      |  4 ++++
 3 files changed, 36 insertions(+)

-- 
2.25.1

