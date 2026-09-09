Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345C1D531
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929708; cv=none; b=W5puqaGaxvwtpc9Vs+4zoBVGCwH694vsuyk55wz2iFFl0b4hxlm9yp/kX9n7mXnq0YGXBwms78fccJ4Qfs/yiyzgGyTswHV7F0vLlusWACSyoHZ3b2xPvqGr4MTZzR86RKPFGHM2tnFylewWtvGx6mDPGEAC1RSivh+WwmDE/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929708; c=relaxed/simple;
	bh=K63hzdR42RVsXbKrMuxzuWUlhwFldARLSy/yOzMk5vI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGdN0QimYsLzIcIyKD/VpS2uSrTdJAZoQmwggUjmc+y9QY3xTEOvj2yL+qIqPXoGQlk7SPu0TOTe2picY/DOkMDsQGbkv9lJGDElCxz7yRgIwOVQtn0wvIgE4jO8FYXIgtIUnX3VYp7JsR241fcYXZ4fyyMESL9JWoqU7pbINqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEa+DBxk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEa+DBxk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d5cad1a6baso50864075ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788929706; x=1789534506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RtXPc9l4G9cuCIzezvpEqoPo81//PhfiTYKMse4zr28=;
        b=gEa+DBxkhxwW76KtpO4EgJM1ipk0uh4XGAaYpFg7HFiL3GUp7nuU/XjyXUX3kD8j/Q
         KTL0ireLUSGjYHRMpIqxwzDXRSE7WICV9EMppdk+3iwaxxs54wSZSZeGyNnhUubhAIlc
         dcEtiOhaAgKXXkF+z9NpaZAUWjIoAKH0qv6FSDXk21ZSGSRSLmWQGWR1tuZfB9pe9ukf
         QU4Z7HDWmlgYGpHtHdW9JZ7HWHDY+uuoRIXgIYzyI+dVndWndGyvDcljDaVgAFOpifKv
         mRVHmEhNkRrX8LvqNFWhS3CyHiz1LBKAtji6HENhulwRjT05coCMpUtKRC5Sy+YZfAwR
         mBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788929706; x=1789534506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RtXPc9l4G9cuCIzezvpEqoPo81//PhfiTYKMse4zr28=;
        b=STNRMiO6//N6wLSyPkpIXAyIGQNZ/pYbWua8KxiU5aFhARJ3z8kJyiRXx//cabPVqe
         WuqwOK9aoKeXv+5d5Ng73LwNKsSQ1rgus3pobt3bmGREwttsQhwqREZnbDBpiL24wYsA
         mB+zo2ctvH4RliZe6PqFVdmGrLzG+wRAwNtCceWf37yyLqBfF56CIHCI+k3JaphIp3rP
         Ko9Pk5iXeCJB2QUqSv3/+uGt36D72wy3/InnRGbVs5rDqIMHXrrFrslFuIjzp3lPqoua
         TPAivc4hSyO4mxi1BepBxmU7XH0OUyBBYCBHfe6+PSu4z15WD2w5YpKTwQgaeZ+oxQ7c
         IcHg==
X-Gm-Message-State: AFuF++m7bRDk/Q8akL/95SQj2f8q7cjlT5jA4XhLdAzSHQzMV9pKeMT6
	Yq3JXXeaJ5fQLkTK5qBsSfNT5vxsSJP77IXQfy71N9PyMSvQcLa3jifV
X-Gm-Gg: AYBFou2OzcW/YurUIY7wGMuxVYS0W732r7DnY+XS3QDfEjwQeG6fq6OQFM4GSTBCrUX
	7XlFUBhqmX5vNHEXayHo3dhLLUsRkjV2p18OPjouCy0JVGnVCQHpd3VR3OCVXROMEfVnjB9+P7L
	x68c/HpO7rbViXnk4m/EGXyZpTQW5jD86eJljdJBKX++nwE4nn7tpGVzjOsXcheiHNlaUjCJ0ke
	IAuk/tzTUCv4otyKBkaXDn8KqXbpwpvmI6XlKTNQUR3B/mkYA+x2BQXn0/zwJTb7SNGQmUvgchX
	hr1NQ6jPIyxDk+DSYfSrc9/LyoBvAyJ+Tfj2k0p/gCu/liiWCxlqvgt23e8ZNsCt9ohJK6Oi3Yn
	xFeNZ8/WgRvYI2syIW0JdBlilsWFzG/2/tnqCw3eLvLZ+SEkhajqhIcwp9up4zz6rBhKWVCrKI8
	EuQspkOVrCWzTa1acFitryksqoCboQ9Z1Z6UbN7pYXy+XxZ1sAgLpbjchNiFFh0GXnJvL6P2qLI
	oir+G6Bfo7qbSusA+ZfJ0TyGd83ykvgfEvDda+PyGsu85M2/SqG/UOEI69gxHrRIVkRPRjnFmjy
	0dnGQZgjLjYyEh4=
X-Received: by 2002:a17:902:f68b:b0:2cc:864b:539 with SMTP id d9443c01a7336-2db12495a80mr474088295ad.6.1788929706292;
        Tue, 08 Sep 2026 21:55:06 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1499e876sm66688505ad.56.2026.09.08.21.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 21:55:05 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v6 0/3] net: xilinx: axienet: Fix IRQ error handling
Date: Wed,  9 Sep 2026 11:54:47 +0700
Message-ID: <20260909045450.16176-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series fixes IRQ error handling in the Xilinx AXI Ethernet driver

Handle errors from optional IRQ lookup and preserve the original error
codes instead of returning -ENOMEM.

The changes were found by manual code inspection and compile-tested
only.

Link v1 : 
https://lore.kernel.org/all/20260811034715.6034-1-phucduc.bui@gmail.com/
Link v2 : 
https://lore.kernel.org/all/20260813042012.17631-1-phucduc.bui@gmail.com/
Link v3 :
https://lore.kernel.org/all/20260817105241.63345-1-phucduc.bui@gmail.com/
Link v4 :
https://lore.kernel.org/all/20260821123249.41527-1-phucduc.bui@gmail.com/
Link v5 :
https://lore.kernel.org/all/20260903073252.339250-1-phucduc.bui@gmail.com/

Changes in v2 : 
 - Split one patch from v1 into two patches.
Changes in v3 :
 - Move the lp->eth_irq check below instead of handling it immediately 
   after platform_get_irq_optional()
 - Add error handling for platform_get_irq()
Changes in v4 : 
 - Add Reviewed-by tags
 - Add error handling for irq_of_parse_and_map()
Changes in v5 : 
 - Change the error code returned when irq_of_parse_and_map() fails 
   from -ENOMEM to -EINVAL.
Changes in v6 : 
 - Add Simon's Reviewed-by: tag.
 - Drop the Fixes: tag as this patch is intended for net-next.

Best regards,
Phuc


bui duc phuc (3):
  net: xilinx: axienet: Propagate errors from optional IRQ lookup
  net: xilinx: axienet: Handle optional IRQ return value correctly
  net: xilinx: axienet: Fix IRQ error handling

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.43.0

