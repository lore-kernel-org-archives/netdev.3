Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C0400DE9
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525033; cv=none; b=cB+rC00UJxryQvYQRcWaPO+LDL0UcxvPJHF9k7qX4xq2RaWHhmXSUP97X3JfpYatl7qsMTXX/B9kQaEszCbU/tW3hqWhfKVcxC73FhDAB8qcMruwr3rXf+VMBxVALqHddz4XXk/YwbOJtOQvXvhfKQet7TzLXHHEMzF788hJlYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525033; c=relaxed/simple;
	bh=/JuIvx+tU7hhn6KXlfLR28p6omlLuZ1IyLkJUo4LXeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLc70wGMV2JqmxENviAs5deH7OQU1ezIKAX3sh+0IU7fep8gimxOm1JyltFuGMAG4k7ycdT/kZDOq2CG56JVbvmCgBGZGyfwi2z/Ygwtetr5rtOTCA70H5vhwGNkpZw+xaVd4jxbDn4BsP7/70AejE9ssWwTI/lXSq938e0jaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fJOdr83I; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fJOdr83I"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2caed617615so18084175ad.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525031; x=1786129831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GL6buwBZNnyLxQePV4hsxUNJ44APFO6juYdEzZIg3wA=;
        b=GY8Nc7xg5eBMUXbnRYrKsnElhSqIXCqfN4nM9QKzuUgZE2L/KlI4OUsz8IsRPuNGaE
         r65no4aysPmT8++34PFl9rAXmn/jW/ObbLUS+o7hk3dy38bLrrH6MoUgKuicIXw7iBXj
         s5RYVNwAuPq7K/fuG0WL0AMXdBZlJ0L/TRHkjSohf0wVfFZEKtM2Hpi9sa9mWW8WD4l2
         CIpjNkCO8KTksM/x1YGFIE6ArKaOWeQ1YaCaRg8mdvEdalWNs9X2MqOCYZ2RXLCjuTtd
         dJPXqlEB0dYzPEDCf0vRUFNlnr5s4UrviCqh/P+k9XzvwsaZzd5GxRxsFPC/Dfu6co4x
         A9WQ==
X-Gm-Message-State: AOJu0Yz6Bhvx/YAkDUsNd34l2DWPES2JtiULYCTtI4oOjzVoG6XNaGld
	2lRDzrO8PmypZjJ17P1b9+mt+AmO3OKfatQlPzV4UjW0rxzAPG/TgQbzPQ8ImB7r8yqGgiI8JC/
	ziI8KPdjn+EOc/sFPAMDXIb4SXNaJkdhxUTqzW6steAzZAGIzpTkZw7U2v23jdQ6qgBT4Z9KDBr
	4vpuRQ+nRihPLQkGgHNTVV9ymz/QaXgdX9dp5jqAvokmFcVOdpsQJp4BfYfWU4VL1YUYQrWhD5V
	4qczzuJJ6k=
X-Gm-Gg: AR+sD11/rMmrZue+1EP9OThS0LnuZxExQlBLNObWVduN5ZmHf8j/KwCQf4bXertRUt4
	8EI4kZ2U98kKBRl1cGnG0I0WjPag045HYSWldRRWkyGQK7zCvodTlxYnX4h+ixulImhvFx6ehDw
	1Y76WH+3orKx40HtrAHOGQJzwGn2WrMg6atnEOQBPhDzB67Ru0Qg374vcNINn7hVocFTDRYygFD
	wTsuGTtZEPbrb9Hfs9ag69l+eA7TCDh+6jgZhZb+oOvpLd/yo2wqZc+wUKg4UCnQHbCbF646Jk2
	O+M/U50s6uPmnNiZcGxhizjGXFnwhN4mVDnh/pr3MrT2lrqNdAix9/h9zm+rYx/nwYN9kPoSy+6
	dzFIMiLKK72eSQldPDsF083JBuPTzYZOhqJgCW2pUE27gLn5437qKKpK4Qcgi1ZlsnonXQnTDjn
	f3hWQQb41YAXCYMC6mSU51RhFK4x4z92lV+80=
X-Received: by 2002:a17:903:388b:b0:2cc:89ce:2ef8 with SMTP id d9443c01a7336-2d0524375cbmr10268195ad.40.1785525031047;
        Fri, 31 Jul 2026 12:10:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d04ae8040fsm1771875ad.14.2026.07.31.12.10.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 12:10:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb711c88f2eso688725a12.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785525029; x=1786129829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GL6buwBZNnyLxQePV4hsxUNJ44APFO6juYdEzZIg3wA=;
        b=fJOdr83IXAgXgsP8beZH31nMcsdIi9sV35tvKsQ86X1EwOIIcn+Bz8lT7bGGU3TD8u
         yfHfVCWoLa387w8pSbaM8t8/7XhKwgDPvNFmVW/akq+dWLD0rmyP8A6yz/7esYdsys5X
         ndmtd9FOLJQsCb/bu+vKOvWg+ryvRg3uqYA8o=
X-Received: by 2002:a05:6a20:d491:b0:3c3:ad17:edf7 with SMTP id adf61e73a8af0-3c92a90990bmr856780637.63.1785525029154;
        Fri, 31 Jul 2026 12:10:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:d491:b0:3c3:ad17:edf7 with SMTP id adf61e73a8af0-3c92a90990bmr856756637.63.1785525028708;
        Fri, 31 Jul 2026 12:10:28 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm8667714eec.10.2026.07.31.12.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:10:27 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com
Subject: [PATCH net 0/5] bnxt_en: Bug fixes
Date: Fri, 31 Jul 2026 12:09:32 -0700
Message-ID: <20260731190937.807270-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series include 3 bug fixes:

1. queue start bug fix on the VNIC's default ring.  2 refactoring
patches preceed the actual bug fix.
2. Bug fix for TPA data corruption seen on some ARM systems.
3. PTP PPS setting bug fix.

Keegan Freyhof (1):
  bnxt_en: Fix PTP PPS setting bug

Michael Chan (1):
  bnxt_en: Disable EOP for TPA on all chips to prevent data corruption

Shravya KN (3):
  bnxt_en: Move RSS table fill outside __bnxt_hwrm_vnic_set_rss()
  bnxt_en: Determine and store default RX ring in vnic structure
  bnxt_en: Refresh VNIC default ring on queue restart if needed

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 61 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  7 ++-
 3 files changed, 46 insertions(+), 23 deletions(-)

-- 
2.51.0

