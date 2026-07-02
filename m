Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F63C457F
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032117; cv=none; b=ji7A/y4Yq0UqQSGnNOAPLk5mkeGOSVsXx+Xw5Qwn540v1Qj2gyVNv8UrvTFSk+2Y9xNGRtCmPKM3lMlzxCzmHgJ6p4iD4f4SF95G0igx/3+xCsSVId3yKl7wVD2gO8o5Tiuw0mrcUtR2VaFg2HwK/X8PPhb3ojYtQbIycZE38B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032117; c=relaxed/simple;
	bh=HrDtplRMa9V8eMXomYI+fBuxfuy0EazJVlaS3xycGuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQtfasgqqyc2QIGS7rUYqZeF9tAPLB/H6adDCFAIR10cpaadsiAzQGpgIsdST7f/jYNz7/W9De3zduRUTxJNytEvic534h05CwXELwUGo0b1qM9+IbG7YmO7s+zvPue5S+JMRSzO1pmK9p3ZxTxSIl829JRhrHCUchfPmLsPAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAPnXvh6; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAPnXvh6"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2c980dac2b2so8314985ad.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783032112; x=1783636912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QILYk3lKizbi5zWvXR64kuMnop1KjYg5qUDCPNRdT0M=;
        b=AAPnXvh6ZEHm/0AIsZD3/wTtCrcyPMm2YUCP5it4qZHkBwbtWJNKB68MwkdCFWPyQl
         YTkOVLyW5OKlxm5ZMO6oozAOheQJG7y4Fc+4u0MozdMBMmNJkU84FDauy3rAcQgavRhT
         5FTRNlwAFNwcJJUSOVHu/RDIH0zBEHwbaBlv6QfkAKFQOzUP+WeWYqD0HBiO+bW6UI8j
         iAHr51NbTY+Co+U8jZlPVuVhX1pF80x7U5awEDNO6Dyw8QiEOvIw8XixpFFIpvW2RFyv
         7UTjX6Ec8LNsppM/WKWUHTVsfU0N9H7Qqh5dhPsPTDfmsk62vjO4NjjXfRQ1p+R0S8Tx
         O6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032112; x=1783636912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QILYk3lKizbi5zWvXR64kuMnop1KjYg5qUDCPNRdT0M=;
        b=JZxPtRjcGby1p+Dg0/onJAxZ0rLlAsZl7TWKl0wKflJtrtURkw+ZK0RzFJSYItvyrV
         oRV3J6LSpNkC/5h8FWYva/9ZdKmGyDa95NcTavqKZ72HAPMrlNoUmbr4Yc1ynel4ug9S
         eDds1zqv/rkvzKHVsAf5+32GeRYOYc5Lok9pceoBx9Jlo7hapJMQ3NyjYgMTmCXDHzkE
         k/sZQ5f674bpBcpHtZnUEeihUiLKV1fZ8q+vA3Z5oZdaXY0YqTCaGc/dRdWUjHgvAQJP
         0mw6STl65Url+d1T/kgnIL69cHA1DVikl1sSmVuw98rQ+VK90lef5ICBM2A9qZQCldkN
         yO0Q==
X-Gm-Message-State: AOJu0Yy/YjciE0hjCF70A+8lPswvRPyJarltMKjoRhGRdyFiyq+W+a6Y
	sJMAj99U2+kjXbpoukzj0VzXjSDuCH2BwpNAsiiexNRUwrFsMmXYiIq07W69AzxU
X-Gm-Gg: AfdE7ckSf8Ly4WhnpBKj5eMaxZjFgaCO19Cc5pOcBPfQ/okcQCrgzgpR/EWvdZI8ExQ
	6cCnzHNpKZC/E/TwmgB9zP2RSrsZ3PeUnQsjc7TTZbfb9eUbA5Vx1rrY8KV94Azuf/npm13Cgtn
	RNLdrKkCX+Al9PMxRmc3Y/gl4wjVAJthaMKqFNJBnPb/cnKhT2jnOli88CL7cAyWti1WQFOHla5
	6c8U89UR9YrDdaGAzPF4oqtsJ1XBRlAO+p6CCwiU0MbOJSqCIEvQlv67fnRNw/BwsztQyonub0w
	D5stWoLzFYlMD7qLDi5OgrKhnKFDDAN5MC5lnRRXpDDMlbwtZlt+PAnRkMi1ELuPkc50/YzgTdo
	68HCi2Y28mUxDXBW7lXNVpbyw+ab08KCH/dBznizU0TsIszTnIZAEGHtCgvVKYFKAqhXPnW6fM5
	pipZXG
X-Received: by 2002:a17:903:46cd:b0:2c9:97a8:8c17 with SMTP id d9443c01a7336-2ca7e8c6253mr87482765ad.42.1783032111663;
        Thu, 02 Jul 2026 15:41:51 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad1bb05e0sm2006225ad.54.2026.07.02.15.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:41:51 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 0/6] net: hold instance lock around NETDEV_DOWN and NETDEV_GOING_DOWN
Date: Thu,  2 Jul 2026 15:41:44 -0700
Message-ID: <20260702224150.3730033-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETDEV_UP and NETDEV_REGISTER already run under the per-device
instance lock. The teardown side does not. Make it symmetric so
ops-locked drivers can rely on the lock being held in both
directions.

v2:
- reword NETDEV_UNREGISTER unlocked rationale (Jakub)

Stanislav Fomichev (6):
  net: hold instance lock around NETDEV_DOWN/GOING_DOWN
  net: dsa: hold instance lock on close-on-shutdown paths
  net: mtk_eth_soc: hold instance lock around DMA-device-swap close
  net: rtnetlink: take instance lock inside rtnl_configure_link
  net: require instance lock for NETDEV_DOWN/GOING_DOWN notifiers
  net: document NETDEV_UNREGISTER unlocked rationale

 Documentation/networking/netdevices.rst     |  7 +++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |  5 +++++
 net/core/dev.c                              |  5 +++++
 net/core/lock_debug.c                       |  4 ++--
 net/core/rtnetlink.c                        | 17 ++++++++++-------
 net/dsa/dsa.c                               | 20 +++++++++++++++++---
 net/dsa/user.c                              | 19 +++++++++++++++++--
 7 files changed, 63 insertions(+), 14 deletions(-)

-- 
2.53.0-Meta

