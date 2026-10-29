Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273145;
	b=FxxpQNtdyIXXI/grHq5NMrAJ+BOho0Pq2leKBreCePwnYqbbsdjBXT2jYDhTNslQTkgW
	 Z+BCSd31FZZbDvgAwMv02r1FBD6Omp0Hlyvfr0/orZZlRCUIsHiehSsLIP0BPRF0wZwXI
	 TtCgXQUGE0saiAiFo1K0dj3gmFtMe5rTyG9QoSpIGXQBWNf9/E0SDLlpFFmwtEKWH3XJN
	 abW2AXDWJwXHCwmk0KkmbYQ7O7E183aRqutgCqYvwmttvluHlwIfloyrE2WIT6w0RMvDf
	 oqDHNal799M05EVjfUzcvGIQK/ZizZQoAhHVxklUmuwrwB1BDeEOR+q1ndmK/tKBS4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273145;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rlc0Qn2G92bUMErWlek3q+ofs6Y3b5n85QGfapsmbas=;
	b=gEM/7T+syM5NuHyerp3TafbEjQdguOO8wFDrqsconxDP2dQTxqFpXabZPYdYa7heMu4N
	 uy4s05poHP9t54o/PjFdnZMRMo692PncCPEDsu9Fa6CLv3YyjjdM0hTNGLCH16hmZPBR2
	 8bUAr4mFDab9CPaANNGW67P1LzKzhdbkAA4qadl/lS8OpbZ/e9enoEAD6sLAeSlbJyBdR
	 2VbaRhaDu3d/YFKS1DJCrXLHUR1BUxmtnETg/i61zBZSiRVaYw7GSlNIZ8f365lEwbdTf
	 ViAxnoqXm/DLKYDmO0v3Ty3lnHrn7SznjZzx0xlDLtRJ7ODd4n2YlU3TpGyr2tR6Fpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=gFGWSDAX;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D680606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D680606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=gFGWSDAX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793273133;
	bh=Rlc0Qn2G92bUMErWlek3q+ofs6Y3b5n85QGfapsmbas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gFGWSDAXvJ4tjqIlmmVdf760KxLz/GtKNNMQAKoyKNSbZ78cAh6p5yxPIzSNZm0zu
	 lVSzxBJYymWiskHR/k8XFPCj/A8oEWQdH5vK58oObo8u37OSxd8P7aIOmrpZ7wCx25
	 WRnCXEdrI7Zbkc3+Ys6erWzUv1TQWcfv24SnWkIA=
Received: from localhost.localdomain ([240e:3bb:302c:4eb1:9b:594b:9d4d:93e4])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 65DA727C; Thu, 29 Oct 2026 19:25:29 +0800
X-QQ-mid: xmsmtpt1793273129tpbznleuz
Message-ID: <tencent_E2490A092089691125F9F5922DA065778607@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5jDGd+ZCD7FauTXrgkOrDgmjTFeeCJ7T0FnCojKvVqs9C/0nE/8
	 pmB8swD6jKwKyFecidfwdfypwNR9mPPs2UD+ABoqCbxcIkyAxCNLgL971pAQ3ZVIxgOaL2ey6FvG
	 3tVUt+n1TFQQYLq0IZPLL27rnnow09UQ7BWFCpK30XsRB1Mfeo44l6Stc/2cRvY+kK1qlEAR7LB7
	 wEtyyLo3RfaXA/JVLt06qWGeTd1ATGcT2gzIhXTnY+SkrTjWo8y39XbOr2rXVQU/5S71i1rCM11+
	 Ou/fRtKdx5b6YBt4tWXxHnyU7b4Tfwp74Z5dM2Riiuhp3Oyqhbo2ykJCcFTWkXIZR2smeA3VJtix
	 Xm9v6PFHlB9x6iJI/nvsgnsx7IyaLGtSRH0ieGZYG30LIJU8xO2WLFVo9HdSHRkH80ockzUTf8OF
	 xY9fr1ALVVIq+uez3efEUVk5yA69r3AHJ2Q7XIWux3DqyLxWDcxQ7WIAzr+M2REL4Th3vLiuPP0T
	 qPdD3Ha1V+9ocZl61VyfiASBPM+buww127vwF22UBtzQp4F0s7Y+yoqnIoBioN7P8WMQoOzpkHQr
	 ce1BoP6zYkhJOsijQb1wFtpXYWsc4JL06KMufgLkg4GBEVEZd4wkzgFMdDZanb/dbcqSlplUyHrM
	 gnrEXGtOsnBdsO9aLBB40njkhU1hOf7ChkTR5vo9qL1C6Au7kJ98Sv3kgebYX43nGUTlDP9ObVtG
	 DpLi0u35q3kVD5f9ux6PCoT5ZQGtD9cF+oWC1KwgmhgyNpep//0EOgOebZJJ0NYg8NtT564sFnM1
	 yyL1WFehjHUkr/t0BweR83y5xKCbrBlhL4Sb0inm3UOuXDrnxh3jwbgxCct0ar4i7eFJ+zAtQnHG
	 An54wkDMFkIAaKOluARRJki23qXacTxIzfXCBRA5OR7JAWQwa1EIxn96OOJ51mzSCrtuLna59lSs
	 H2DvM5SmWXznAJ6NiBjOudWFQd0Tezx5TSQB+gvsy0FWert3wJ8KaKmaXOGhHQtInNI0CApXOsVv
	 2mTnrQ6R8/b17MzCPkxeCcjY2EvbRlHLFybCzXlHNUdiLBbwLUcG7im336kpo=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 0/2] net: dsa: mxl862xx: bound FDB dump walk and validate BRIDGE_ALLOC ids
Date: Thu, 29 Oct 2026 19:25:26 +0800
X-OQ-MSGID: <20261029112528.56652-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <tencent_6030CC520C02054D1B2925AEEF6FA92DC30A@qq.com>
References: <tencent_6030CC520C02054D1B2925AEEF6FA92DC30A@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

Hello,

v3 of the two mxl862xx robustness fixes, rebased onto the current
net tree as requested.

The v2 series did not apply because it still carried full copies of
mxl862xx-api.h and mxl862xx.h (the driver pre-dating the upstream
restructure into mxl862xx-host.c / mxl862xx-phylink.c). Both fixes
are now re-ported onto the restructured driver; no driver files are
created or renamed by this series anymore, the two patches only
touch drivers/net/dsa/mxl862xx/mxl862xx.c.

The bugs themselves are unchanged in the restructured code:
mxl862xx_port_fdb_dump() still walks the MAC table in a while(true)
loop whose only exit is the device-controlled "last" flag, and
mxl862xx_allocate_bridge() still returns the firmware-supplied
bridge id without validating it.

v1: https://lore.kernel.org/netdev/tencent_5A7AEC56CDB23A83120519D0C074B592C706@qq.com/
v2: https://lore.kernel.org/netdev/tencent_6030CC520C02054D1B2925AEEF6FA92DC30A@qq.com/

Changes since v2:
- rebase onto net (fa503935c2d6): re-ported the FDB dump read limit
  to the restructured mxl862xx_port_fdb_dump() (the while(true) +
  "last" exit is unchanged, the limit check and its comment moved
  verbatim); re-ported the BRIDGE_ALLOC validation to the
  restructured mxl862xx_allocate_bridge() (unchanged logic)
- dropped the mxl862xx-api.h / mxl862xx.h file creations that v2
  carried: both files exist upstream since the restructure, so the
  series is now two pure fixes to drivers/net/dsa/mxl862xx/mxl862xx.c

Changes since v1:
- the walk limit is now checked after the "last" test: the walk
  needs one read more than the number of entries it reports, so
  checking before it rejected a correctly ended walk of a full table
- macro name, error message and comments say "conservative read
  limit" instead of "table capacity", which the exact value is not
- the "growing kernel memory without bound" wording is gone:
  entries whose port id does not match never reach the callback,
  which is exactly why the walk needs its own bound (the netlink
  dump skb never fills)
- BRIDGE_ALLOC validation now also rejects 0xffff (INVALID_HANDLE is
  documented but never defined; the MaxLinear GSW API uses 0xffff)
  and ids already in use, closing the duplicate-FID collapse
- Fixes: tags added (both issues come from the bridge offloading
  commit), self Reported-by trailers dropped

Base-commit: fa503935c2d6603856dafff0a0852631ab6e9503

Cc: Daniel Golle <daniel@makrotopia.org> (driver author)
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org

Zhang Hewei (2):
  net: dsa: mxl862xx: bound FDB dump walk with a read limit
  net: dsa: mxl862xx: validate the bridge id returned by BRIDGE_ALLOC

 drivers/net/dsa/mxl862xx/mxl862xx.c | 59 ++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 3 deletions(-)

-- 
2.39.5 (Apple Git-154)

