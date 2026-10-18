Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A726B742
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289328; cv=none; b=GoHzN6qJMCpDmOu0UhizZdQ9IGINesqSl8UdJeQdTs4I0oOWCfATXHDo0Ul6hM0R0QPXRfekTRC9ZEn6v+Op68Kix5Bfi/DEV7ouj3gQpzIZgb3QUxRjCQGQWsr1VKMM9VpXc1cPN/HPfExKnjE31rRLD5aE2fAu30yIBwGa+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289328; c=relaxed/simple;
	bh=ow69sVINNaVvr2Z0q+1YVQzqsCXceAWHPGehvygUFA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6CsCFHLNly8Xfe18LrjMUx5AhCkTFXpVoEpQIpSJjpzVKo7VScLkw76biQD0cDgfjAfsB0wlJGqEn9yAlE/SSPvAIj18YQcgr4V7o7EOgxzFRq8orsg1DvhSAinHVi++l/09S+OhWqI/7xxN2TANJEdSOHsUukXGW9PpOPdtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPlWBOVk; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPlWBOVk"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53391022dc0so12471421cf.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 19:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289326; x=1792894126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RaGAAGiU7kTJl217HSqn7DxbRR+6QeuVGQHPa0XU5iw=;
        b=mPlWBOVkqSoa40MfIhSXJRka9r5QpJvEQmzcBu2AoExSX0cGEbXGeGmYxDv/zFZYZ9
         0U+IQidBjkH4nt2igg+bZt0MSOnKYocUpLsUmQDJdH6z1ewtuVUaeFzoHHnjSLea6zEx
         7U6C/nRvb/6NZk4qc+LC+sHcfVrCwN26o+1lnXrXhpHuAqXg0lmeUdT82mb8uHpS4n7x
         LJsTE6r4uesd5RPCFrA4A8n0VdQg4Ww1ItWiCMFgPL3ytmQtRVnZqN0vjoX8ZT5+R5cN
         AJPtnNtK15OsRAUDFWlnugLaI9xR57hBUB0Z+ryV7eFWasHlrie1sKmEEFGPGB+victL
         FvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289326; x=1792894126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RaGAAGiU7kTJl217HSqn7DxbRR+6QeuVGQHPa0XU5iw=;
        b=EdlaeJ/YPHijw4gN2RCCDGzWs8nBlzA7uOfA3NACP1LxK5LAr1G+5zQfWJ/MXmhG9G
         lnSGq4k3zAgLcAe3b1Z69kSDWUtrUvthE9aj9/m7XLY+RiMuFTeLHoViwOkGhiUkU2ha
         C8gKPtYl7hPGq00ZMsVv4AbJRr7GXYYf5TskRbvg+w6TUk6z2Px+YexaZWY84jUgXTak
         uK43oBtXGn9wKl7XCKGvLGlWgTFcQZFcRSJMNK/w8WKJVnqVzpDMK7NiFMH+T1YKcL7s
         /D2SVQ/XXboKr9Jmvoc8QHaMCLkFh4wJ9np8rqliSL1cupkCuamxFohwnyAbhBIXLiBd
         OLbw==
X-Gm-Message-State: AFq9FYKqahiqMghm1JgH+JxOTqQE59Hw0wsAKR9MKmhG8rrYAV3g0TwX
	2d6fAbH1pxTPJAmK3/+krywPlmobQ70LXhAk1XtUU0eCc/nllQvxWTL29J5AtDg=
X-Gm-Gg: AYBFou10lLgK5H3xWiP6oVG8LYNYLjdPg/HfsEucJkPYyo9fbJKZ4xVuFrXDtorKDCg
	H64HEBnhjdTqpd+UmodMbW59dY5t1KB9jJmjzoPrGcMyI7fb/f2kCmu+O1/OjST4qESfD3N8jpB
	cZUxeT62WkcRBENNBCBu3WKIaqkiS4DEY10cIo2Cpg+Di6FkYcNCmvVmB8AN/k2LlacmEL5MY1A
	/ljHS9jvFYiPzMXjFTrWqoIMT3mu//45uHUdwnIZRnPvRII+fsnPzgF7gbxJ9koSwdAqAdPP463
	e1XGw+D0NSGob2x9XwDIa1kLhcwED0DBZMfbWUMzzHvnvqgcXeP5t2S8wqzg+dfuX5Z/qoxlFSW
	xN6vObzxQwJSpcg313Y6E9JFOdAAUv8qKz+P8WRbxz1CS6rfHECssWvO8QXXaEbXJMA7nye49jo
	NS1ykxrkDyb25K8j70OWHegnRTc20AFhb7Qu+oFY20hG6mpqPq+NAS7W/a0va58n3xw11kER+Wy
	ubE82pGQ4clC/MNshjplC0mMLfdyYNOWcxZOmwkmoBNV/BYJHBcGyA0C+BNricNV7G+0E1JRrKR
	sCFeOKZaXjsU9hLBimn74sUAE9MC
X-Received: by 2002:a05:622a:48b:b0:536:575b:8dd6 with SMTP id d75a77b69052e-536575bbc1dmr35825921cf.0.1792289325861;
        Sat, 17 Oct 2026 19:08:45 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa68f8esm61731291cf.29.2026.10.17.19.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:08:44 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ae878000@gmail.com,
	daniel.machon@microchip.com
Subject: [PATCH net v3 0/2] net: nixge: fix tasklet and DMA teardown
Date: Sat, 17 Oct 2026 22:08:38 -0400
Message-ID: <20261018020840.3851552-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the IRQ/tasklet ordering fix and the DMA shutdown fix from
v2, as requested by Daniel Machon.

Patch 1 releases both IRQ handlers before draining dma_err_tasklet.
Patch 2 masks channel interrupts after recovery has stopped and waits
for DMA reset completion before releasing the buffers. On reset timeout,
it retains those buffers and prevents a later open from replacing them.

Changes in v3:
- Split the IRQ/tasklet ordering fix and DMA shutdown fix into two patches.
- Give each fix its own subject and commit message.
- Order the nixge_stop() local declarations longest to shortest (RXT).

Changes in v2:
- Wait for DMA reset completion; retain buffers and reject reopen on timeout.

v2: https://lore.kernel.org/netdev/20261004042702.1130389-1-mhun512@gmail.com/
Review: https://lore.kernel.org/netdev/20261007104833.4ukkys7rnmv7ki5i@DEN-DL-M70577.microsemi.net/

Based on net commit 6dc989ea46b96ce170840174b4a38c4a387fb005.
Found by code inspection. No hardware testing.


Myeonghun Pak (2):
  net: nixge: free IRQs before killing the DMA error tasklet
  net: nixge: wait for DMA reset before releasing buffers

 drivers/net/ethernet/ni/nixge.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.53.0

