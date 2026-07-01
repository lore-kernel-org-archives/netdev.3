Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497647276A
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905313; cv=none; b=CTT9W6MGAeCqpVA1Z3l7szqwLT/+1Spl/yu0B36L0VJzyW3zwAA5/giuBxr7q6FYjiwXtFqYT0YV0G1e+yaA2XM8epP2RTAI8ROzikXcg9V+DHKJNpSgRem2i7UUezBtjNvUBdafwoHvpoZZ5wRy5e6B6IdC8jNIqlgDwGM/ofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905313; c=relaxed/simple;
	bh=ROdAMjb3eA4W23vGlRJRTF5lyshTQSGeez9dWAooIcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Emcxl+Y25iYyuDA2W7j9Rdhf0XhGkTh/85pPQpIYwthe6K7u50soDg6CgHEBhkk5zQSXLbj8w8QgcKAZgPuVg2qMjiJ5HJePifnk7ceKFYNFWp/uaHty5fPstwVHes+GkinsOeWnKQIQYGGbI7OpcUx09JnA/Rped0LIl2eW4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdqk4XXE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdqk4XXE"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so189322a12.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782905312; x=1783510112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWi/fVkUZ7mIoJEg9OEnvhoOeXrktxNnqMlaoxF8830=;
        b=bdqk4XXEQpnggU4LIOCaTkYWqq91Wk2OBLUKUXp6KUsOHJl/pkkNzcbWVnLj7zifUl
         RINqUJIPckbAAXwHwAIf45fcQ/NG6/Y0JcfD4pUC6gp9aW1wTfUPUWN7jMBBfTRaJNeK
         E6avQ6IPe2X/Ojn+GJ/SdpSS0s0MneB8WvNEHJPeC3SuohDraFWpoz8CM8ANDWPMDZob
         xQ5cRoa12tw2DtKnISYcrDVAQzQxA+cejRUlRJp0lx36DMYuS1UcLGcniFsVepyHwQfr
         q8SELx7X3peIOJB3YfOKFuIMPhUuRUTlKLyf5W+9DaSEfQiyf84xhpqhGGgBoODic+02
         2xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782905312; x=1783510112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWi/fVkUZ7mIoJEg9OEnvhoOeXrktxNnqMlaoxF8830=;
        b=f/GD7nJdC5iBgHI4m6uPA2crRuv6yCPHaGT92gSwreT0nF5OYObYaGVYrAUGvTn0ZD
         55zV5UkUnFY1xFsc/oDNRWK18BR2Ytk3p2t+XFw/TDZzfaeQqcJ+eh8MMBb4i48bkLI7
         dm07Nu8uhA6JNOn8NhGwj00UX1Jtbm2RV6XQ/KZT/JOPmzS5fRuWpAqyLYcTV3qPAIWI
         pB3f4DH4l76L8JxpjHHILo5xEe2XVxMjhuKA72MrKtW1JuDQ5u9BHADTjLBayC+sfRZm
         i7kAxeEOl0gUMup+VipGmUQ9tK1rp9Twe7pc8MJyljFlN59svIIHJun/agO3Ob+jhXn/
         uuYA==
X-Forwarded-Encrypted: i=1; AFNElJ8iOpQ4qbWNRPsnWCOykSqPpt7+bA99h+tBgaxzOBohIj0INvSszU3dvlwMv9dW/sv4M3bn0yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBu+AyU+N3Wu8x1V3Q8E0DFCNuUPO+AjVTrf3KyueKImc9Xt9
	qKdR5muQye064p4jL5PXquNRJzP4jxhQHJxNb/gckbL9d7aTeu/YpA23
X-Gm-Gg: AfdE7cm00gvndT9iQdv6nsdIH46sG71N0wIxRrO9Njq6t3f5NopnawGBj5/FTthN5eE
	yAv2HSjPAqTf1JVKA91lKZ5WBveBbtWXdN8U8yc9xnGxF//y6vtbMOE9ll4WubaCQ3WIJNAadRf
	LKzKt2p9UKMjAcahhMI68W7ZoaEhEKSLGCs4U7g7Kg1UsyUpj+Q8fRl/qQnrvM2rjj3xsqy18Ok
	eSjdjrxGK+uTCXJJSgkMAaEoTC+zt2yyr1lSTPKbwucHBxtMe9ZA2I22tcdRAH5ZzCnL2cqvzYE
	38qhGILdbSsQZoDK5V6kMq+uZor4W/HwVg6Ik47OfAAx2gQ+iuuwy4AMlOsaLw3IByoNHw17RCQ
	061ImllKSR2IU/wFu18/w/ZyuWhAN9LLipbk15lP6wf//8z4LOZqk75b8wdEUaK0rU4/GYnQiK0
	KEpc/qDDupbC45FdtLzT6tTU90sJW/IMJK4u2D8Q==
X-Received: by 2002:a05:6a21:a97:b0:3bb:2883:a723 with SMTP id adf61e73a8af0-3bfed3e8a2emr1323024637.35.1782905311729;
        Wed, 01 Jul 2026 04:28:31 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbff28998sm2934290a12.22.2026.07.01.04.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:28:30 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] octeon_ep, octeon_ep_vf: fix skb frags overflow in the RX path
Date: Wed,  1 Jul 2026 19:28:23 +0800
Message-Id: <20260701112825.1653044-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PF (octeon_ep) and VF (octeon_ep_vf) RX paths add one skb fragment per
buffer_size chunk of a multi-buffer packet. Neither bounds the count
against MAX_SKB_FRAGS. The packet length comes from the device. A long packet
yields about 18 fragments. The default MAX_SKB_FRAGS is 17, so the last
skb_add_rx_frag() overflows frags[]. Both patches drop such a packet,
matching the recent fixes in atlantic and t7xx.

Patch 1 fixes the PF, patch 2 the VF.

This was posted as an inquiry on 2026-06-23 with no reply:
https://lore.kernel.org/r/178219996724.2539184.5129396914438743404@maoyixie.com

Maoyi Xie (2):
  octeon_ep: fix skb frags overflow in the RX path
  octeon_ep_vf: fix skb frags overflow in the RX path

 .../net/ethernet/marvell/octeon_ep/octep_rx.c   |  6 ++++++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.c | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.34.1

