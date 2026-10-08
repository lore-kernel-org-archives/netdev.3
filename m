Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFF381EA7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483044; cv=none; b=mNwYuo7tW/0wT2mHXp1svi2umMS9hqY9y3qkcw3Acu7LdG1at1ru/9TffYk9kL4FcjszcCCiEVWP3GvZCwoTvCwtEYWiRn6bt4oVPfu4nCaMXkPEr4jH32vrlJFdKZmKyPe/R4+V6+aKw9MKGqdW4fYp3O/DD/yjdvU03FUkI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483044; c=relaxed/simple;
	bh=6T6mmHnv7hYSALP/oKnLRb2Iv1oQZCIBWfY/um8auys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pDyIQqV3XTdSOpvkdnN+9S+7DVD0nohARlfxLKV9KVpUWEejkq7lWtfxLZXf2vG1B4GR/kqr/kAWLCRC4J2qcLMtgO0Vq4FfGSUj19APT0SAWLAT4ft4oJ5r5J+uCnWYfl/iWFFQlKGv4eiEph9ne5OlBgYICaHlbM3EvcTPOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5y3UrXr; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5y3UrXr"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-34ceab2900eso5834822eec.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791483042; x=1792087842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xD4nln5lOiYRoFakO+Qj2Z+jCtHD1Oml9vzGYNX1Nj4=;
        b=q5y3UrXrAs5B9+psUvEgjqx1oRaBxbbGi4ATLK2PS/1ryTBLQ6XNlwbMK6Xx+ge6eG
         iKNuf5Qn/ua2vHO/qseluhlTOKZeVCZdBRbAn4wREwao9Op/ct7JwvxnW7RmgYUv8sT5
         kXp8SleIJ75T45VqfzFN9fb3TYN2gm99xXBQZSx0XAIdExpSzwfm2iaaZ6/HaUNoHfNS
         BWTtfPlOFn7zIdOy8x+WhBJggC3+ko6NXwkgGInsGBXlDWWtutFpkyoNartwlY+WlOyF
         TbnJrR2//yjgEisI71H9TNDac0ippxtS0KWf4rGegcMDaOjt+0lthLljjx6xyMuGJZD4
         15sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483042; x=1792087842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xD4nln5lOiYRoFakO+Qj2Z+jCtHD1Oml9vzGYNX1Nj4=;
        b=zk2JVuVNYvv4xbEN9VMsTCMykeuBxGoKgHxBIgUZ+LrjLjPJd0QirDuYEOZJEOjP4P
         WQC8AmysS4z0jHtCE/MXTV5SkqWVQLo1FGMzCTkNTN49GJITlrkagx9BNUWlVz5PXonB
         sWTzjO+0L++v7Agqn7C1lQ885F/xnEXd7kZzMy5oiQya3QNSoVOPIHZMJsxe9Sktrnn7
         QcPQXpirgYUcmNC6T1pehx5UY14PUiDvUDjZadxdOpkWLNhry1W9rH+XvsR/gTAPFdNZ
         J8qRxDcWOQasPb7TOh0I+D+AI70szRxyAw0jwUSaEBRxOS0k/acc+oqSEBAVcdl4kuVP
         pv4w==
X-Forwarded-Encrypted: i=1; AKwUvBymkU3HZGeOQhKVGJk+i8iA+qjY3n31u09P7l/9uaIvXs0bOLeHPtiM5eZTCf8m4GtyOcwRfVk=@vger.kernel.org
X-Gm-Message-State: AFuF++k2U8jMCLgma4ZqVHyTXETpHcZhJrVgI02ElbqhrZSyh5zn+yn8
	ouAJS4iherX4h7bb1fcXTlspioeEjRM/n+/yWESmok67tDIAOtjAdQle
X-Gm-Gg: AYBFou3JfSFiECnYEzsbEWU4U7fnWSARExVDxQtiuHSeCK/rgq+b3WkRGaqqQmn54mu
	cz6os/S3ZlEs9lFo58ftbc5IdjnDr9MbmTQOR+G7T1/5c/qaFUtPhMHpr3fgEvQ3mWFaLzl4AeC
	e+RBI9BjCvKDDjaRNKddWJ0PLVwfx/Se8/z14PkAm3r6qiLz+PUYoDUPqAUgiEBQTyrGBORWpUE
	ESBXQX0zHQPooeDBjlE8Sfc9+d2VTTRCTxlWBqF4/VMp70ATtbppO1hRoF1ydYg+xxKy8JjERzP
	k8kVw1T5ciG/qcmhDfOI3hdzE91pX4B4qeLSN0sTPCiKQCAB+o4Z99owcZkWJ26EmClhMVGYf+l
	xd8pMk4xwC/G5rVjyQcTTympPX9AshF2vjQdXwGx5o/T3euq/VIn7dr6xDovrI9xf8SDt0P73XF
	Q309BSxyU8mYBEvbPg1kgWmPzBa3/HOCMjK7FtTO2ubxlwRHADOrCzNGIaNPt0gA+EVpQ2YwrCw
	Mel8+sBRDrCAgV6UrP6HY4HGoIPtWkDnDaYAghAIjXACwKU0fOF6IWU80i8HB/O9LhhS2KTSVfy
	Wozf6JfLIsTNpr2PkBRzvOX71QMa9o14zOuKsCTuhAQzDA25NTG8Zw==
X-Received: by 2002:a05:7300:3a91:b0:351:657e:a426 with SMTP id 5a478bee46e88-3535ecc1121mr225278eec.0.1791483041903;
        Thu, 08 Oct 2026 11:10:41 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537b479e76sm162161eec.26.2026.10.08.11.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:10:41 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v2 0/3] gtp: ynl spec for the GTP netlink family, a reply-command fix, and a selftest
Date: Thu,  8 Oct 2026 18:10:28 +0000
Message-Id: <20261008181031.4129029-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This respins the RFC "netlink: specs: add genetlink-legacy spec for GTP"
(netdev, 2026-10-01) as a patch, and adds a driver fix the spec exposed
plus a selftest that uses it.

While writing a ynl-based selftest for the existing gtp family I found
that the GET and dump replies put the genl family id in the command
field instead of a GTP_CMD_* value. libgtpnl ignores the command so it
never mattered, but ynl rejects the reply as an unknown command and
drops it. Patch 1 fixes the driver; patches 2 and 3 then describe and
test the family.

The turnaround on the respin was slower than I would have liked: most
of the time went into pinning down the reply-command bug in patch 1
once the selftest surfaced it.

Patch 1 sets a valid command (GTP_CMD_GETPDP) in the get and dump
replies.

Patch 2 adds a genetlink-legacy ynl spec for the gtp family
(NEWPDP/DELPDP/GETPDP/ECHOREQ). Description only, no uapi change.

Patch 3 adds a selftest built on the spec: it creates a gtp device, adds
a PDP context with newpdp, checks getpdp lists it and delpdp removes it.
It skips when the kernel or iproute2 lack GTP support.

The 5G PDU Session Container / QFI work that first motivated the spec is
not part of this series; I have no mainline userspace consumer for it (my
5G user plane uses an OVS datapath, not the kernel gtp driver), so per the
discussion with Harald Welte it is parked.

Anil Kaushik (3):
  gtp: set a valid genl command in PDP context get and dump replies
  netlink: specs: add genetlink-legacy spec for GTP
  selftests: net: add a test for the gtp netlink family

 Documentation/netlink/specs/gtp.yaml          | 170 ++++++++++++++++++
 MAINTAINERS                                   |   2 +
 drivers/net/gtp.c                             |   4 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/gtp.py            |  77 ++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   8 +-
 7 files changed, 262 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/netlink/specs/gtp.yaml
 create mode 100644 tools/testing/selftests/net/gtp.py

-- 
2.25.1

