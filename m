Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615A306B3D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872758; cv=none; b=hY4+9oMUYKD9ye3VzWkfjGPs4lOM5QQuW9O0LiHt7sDzmjIsFvnDt5YXnsRbG4YSw64tM2SlPdpawEpgRWTqq/Lf9A+IcX2w50fM7U/DKiFtyNf0EsQJzsa/Lbh9E+Z0GTSH0MhJOYNZfkcG3ow9b5IUlNWLK47jkKj1Xh/ZylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872758; c=relaxed/simple;
	bh=yZ8pEMlr5+04Lc9s90jqT1IHCRskmHMu2STBpntj3h4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sjqyFEkEI1AOTJBqyuUdIMm3f47alZa0oO4GbGw2js82dUyQYtz0rHoTcdVnqkfynPAu9kr+E0b7djXtlJ/tltEn7zGONFu9jZMI/qOMJ0jzSKyvC1MKGAEV3snudseYWAG/DMwscULMnBTHMyahtcXNNAkZ9Qkpi3JU5ROOCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFpk/kQ/; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFpk/kQ/"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-821e712bc18so354621a34.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872756; x=1791477556; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R9zEVIQS5OKiabn9ip0ahxN59LSxsnePjNAS4ga7NA8=;
        b=qFpk/kQ/hCHYaFB3qmi3YHnRbGHyiRG//+JE4twTURphR82+crRZomlTf1Ri6h4b/W
         liIPON3O2+5p/IefJ+TWPQKcOIJqbv3pupEv/46m7eWIfzbbt/bF3K+aM2vEWzvug7OB
         cH4RA4f7n3ClCsu+GGey6fvaGcLrxwP/QvM0z5/skgkXiwsdIiCmbZ2tLX5WxqmIQDbL
         F67CYx4IOpeS/52TewEk1HRd3WZ70Y44TiJF3znA9FJvq3jSCSxbKtmMmNeJweXr42FN
         6Fgjwkbqtr2Lt15DSpmbF46DzgGf4KwF2o+dvAXs/ASf4xSYZI8wiR3JKCXJMzrnI024
         HQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872756; x=1791477556;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R9zEVIQS5OKiabn9ip0ahxN59LSxsnePjNAS4ga7NA8=;
        b=UNiBg5BMyY2wGFzwmuzgJkoBvH4+bRRom9IWmEoyDg93cpSv5gDO7VPMGHAcmu1Hcr
         it+lEKoAXPbgRrqUiz0g7C+1s62BRxD9fJ4eUxIxSGntIHdGRSRrZEwUOZKog6hUK0B5
         FC5CeUKLi8fGD3vqiOpqPbT5AcQoESbc8oivARkW2Hd471VnLbthUIcRo9H2jU/S4p/T
         F1JqpuJaK4t/KXclZnexbq1HAFesnHe65qh08jiVf1UoVtu+qVvlV7tTt+0hrj4y4OA5
         nHyaMc/cYCwKecDcixZhCsyjKUpOE7b5SZjzUz6Zses+6WTR1VzJM745yfUE06D0EYLW
         LV4g==
X-Gm-Message-State: AFuF++kh+wltevvo8Nxb3AVA7YEJrQbi5dOfbDjyOWeL+L+5mcsL5+jw
	OKDOqn5ezfLUd1s+kh/FhldsWXVc4g1l8VD/N2TTViXqFcbUJOjKrkkU
X-Gm-Gg: AYBFou3btyCqkpwzx29N+qI7XFZYMN7bZDpEr1a9E2iPH01F7rosvzZdpJSovG+H8YC
	Hjv0odexX/gNwwuW5L9HMvVAvZU7I8Nr0NyGWgNENA2gYruVD4Z3lLDevs3zrjNV4MCNDrbNq4l
	4zPODoR8lvHqnog+iDWjFsxy4afYanDCNbR9ArcxSuTdyUvRZTw8rq2NkbNac20KyAQNE2S8P3E
	kuhMY+01s5JwuaBfDuYwjMf7q1xyCchNMblIlWBZuBKaiBVf0V6XQGKphwKLSduiL7guA3+xdn1
	KsBUooPNXnS18illKDt2PGrCsBnQzZ/smkUJ0z4dI3ndVjJUCK/bkHWkHXkHbSOdBRXz+EzbPrV
	pV/O08Z7f6HCBRejze1J8d7M4DdA68MhyQyQnv3mXPqbIEZEDGvYAAWXYlooMVFLfQEEmHEPFKM
	jlRviawueNO4ByvfGQkYtfMcEMYxs6/E555dmRMLEFM0kd8Uf3LNlwFNfs23+iL2T9A66Y
X-Received: by 2002:a05:6830:730d:b0:806:e047:cd6e with SMTP id 46e09a7af769-82283f5febdmr204700a34.8.1790872756122;
        Thu, 01 Oct 2026 09:39:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-822793967f7sm287919a34.8.2026.10.01.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:39:15 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next 0/4] mpnic: add NAPI buffer depletion check
Date: Thu, 01 Oct 2026 09:38:57 -0700
Message-Id: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKGMvmoC/x3MMQqAMAxA0atIZgMailivIg5SUw1olFalIN7d4
 viG/x+IHIQjdMUDgW+JsmtGXRbgllFnRpmygSpqKksWV9Er4XaoODTUWtsaqr13kIsjsJf033p
 QPlE5nTC87wcZXNEYZwAAAA==
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

This series provides a buffer depletion check to unwedge Rx processing
when page pool allocations have failed. Patch 4 has a more detailed
description of the events that lead to the wedge, but the high level
idea is that when page pool allocations fail, the buffer descriptor ring
can run low, and when that happens the device will drop Rx packets and
not raise interrupts, which causes the NAPI event loop not to be
scheduled, so new buffers are not posted.

There are three setup patches for the depletion check:

Patch 1: convert writes to BDQ ring head and tail to WRITE_ONCE(), so
the depletion check, which is not synchronized with the NAPI event loop,
can READ_ONCE() those same fields.

Patch 2: introduce the driver level service task that runs once per
second while the netif is running.

Patch 3: set the minimum Rx buffers needed per packet based on page size
and max MTU.

With those in place, we have everything we need to watch the buffer ring
head and tail positions from the service task, compare posted buffers to
programmed Rx drop thresholds, and then force mpnic_poll() to run if
needed.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Daniel Zahka (4):
      eth: mpnic: use WRITE_ONCE() for BDQ head and tail updates
      eth: mpnic: add a service task
      eth: mpnic: set Rx buffer minimums using page size and mtu
      eth: mpnic: add a NAPI depletion check

 drivers/net/ethernet/meta/mpnic/mpnic.h        |  3 +++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c   | 13 ++++++---
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |  3 +++
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c    | 21 +++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 37 +++++++++++++++++++++++---
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  7 +++++
 6 files changed, 77 insertions(+), 7 deletions(-)
---
base-commit: eb0c18404c8943356f4aa164e5db9067b79ea93c
change-id: 20260929-linux-mpnic-428998421ffc

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

