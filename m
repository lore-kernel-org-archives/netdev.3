Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0E30FC27
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304266; cv=none; b=Bcq/GYNV7sRflY1fhpj13s7hJ8cyMFaYhoA6MDMX9eoNaQBFAfSFYjtQ/wvDlGSwzRZsj6rtvNrhiMzKgnz7sz39unflWpYBCvbsNDaooDX/J7eztUIMNd7ZqsldoKojAMRPues+5hXsrjZkCk/3cKtq32KyfEQ6VAOC5/ytUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304266; c=relaxed/simple;
	bh=gq6gPWjlXWTpgggTh6qVeJbK3k0jEZ8oMXcfLm9kaw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNV22b788uZn+vsTCX9hl2Zbmync2qxd2JNbJuv+KpxAKKED8tEVpPgAQ1gUTmJYvvy4ujCJAe7s/mBMCfG/3qWq+CW/IBQa176ipX/cXNHKtka5t0yT7JzD4zNzkt/LxaoJGTMIvtVKiBq2e/pR7vlSg66kpduBUKb5Z/PP5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=cKKRTsEq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="cKKRTsEq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so618764a91.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792304263; x=1792909063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+EaD3mjRasIGte4hZqwmjWl11AAvJaiM9yV5LHuDVgM=;
        b=cKKRTsEquZfffDlvCgPEg0fI/Oi2qvO96KYrcmenTBWoPIwJFbvIg1MuQQW9DRu70n
         jWfOJTCXvSR96YJEfDDCpYOvhppfsvR+0bLrEPjfZr07EmOA4USAvoKOkSOXlslcxWg3
         xapLYW8YEOBprVMyo+sZDichcQFa+gKUV0eBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304263; x=1792909063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+EaD3mjRasIGte4hZqwmjWl11AAvJaiM9yV5LHuDVgM=;
        b=R1JWSNT/dIekS0hVdTcqMfzqPgD8LuJU+a2b5Pe75NMhAPc6kOSGqx/0W9Dnp7LlLq
         vV7QiT1OLKjowg9OPW8YEz+H1JLxgIxQAdDA1xGJnZjex5ktPlUR5SYBn8zPsHKBeQKx
         VmpGt4KN8FvLTJzjnPi+Lveix5hHKbccOUtJQIstWzs0T/hBGaWtsI6EciXb4cRLD3zV
         8nNlVWN1fH7fjvlI7kFDSow21111drxMo8cJjWqZx4q9IqLC01B9B8Ie5aigO+8xfO7u
         RYDuQ/JciBcAj3G+Xjqs09xYiMhH2VSjHBbG+vVUgk4fY449inebRy/NeT50A5E0DaiD
         QPyw==
X-Forwarded-Encrypted: i=1; AKwUvByucywffik5IcRjIFGLLQE1RONnXHascfapyloQaJV2j2mO9tssmfDFT9ubtzudId0dsgTOGZw=@vger.kernel.org
X-Gm-Message-State: AFq9FYItF4CsNh2jR92A7g0VE2W1t2uAmuNmd9dsP85+vrw2lLYaqqPO
	TYxTB+hExqARtyUrXgHIiZZpRSXUxhf9TC2tP1hB3BT9qyz8IQLLPHiR/FMjyx6lqWzQsp+u5sD
	WBFa1
X-Gm-Gg: AYBFou022CYW+QQ92PJdDObBwyBfLWqDuhETMKPVp9N5nYRjtBNt997+uepyj7HiWPZ
	CQlVbU/sqKXhmXOY8Igu1kgZ0dGmHkgSiE5SH2Jtg7D9OBIREBl3LUMfVS30IRq0Ac94zs4BrW6
	/Y5WTJnauPqKvMz35QFfMew3b7JdohdS0nQCBb2XvlhJFZ8FvSL960HfT4R4aNs8Oy4deJwxPun
	/Tov0wCGNGRFfb30bS2H2haah//b2qL8SYKWu0pUGMrjLrUXoPRUD6cMx+140R90zt7MxQdkaoj
	1sh9qycduq2n0ze6zDTUDELncC49/mE8HMgPSBh8y5ySrUCXoipUDpMAtH7OSovmEMpBqcF8XaV
	eFbwLGpcKjK5gRKUvwvov7etOjOUmlhp/WG6TbFrYu7kaqyeNmcBzn7JS1N7FWp8BpgDfXowJLI
	I9uUtQFMOXne7IG8+Q2EU+2u1xpiGj93acjy8hzLsbNLYyU/IE2dFTDLNPwVC8EUAZrEpiC/PqH
	hGLfKopO81eKHxzHacacyLnRgSY1KetDi0Ramzd0RBpo7Lgm4QMmXc=
X-Received: by 2002:a17:90b:50:b0:3ab:31e6:12fc with SMTP id 98e67ed59e1d1-3aced867f5fmr3988514a91.0.1792304263243;
        Sat, 17 Oct 2026 23:17:43 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ecd32sm11025963a91.3.2026.10.17.23.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:17:42 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>
Subject: [PATCH net v2 0/2] net: usb: lan78xx: do not use uninitialized data after short reads
Date: Sun, 18 Oct 2026 14:17:32 +0800
Message-ID: <20261018061734.19488-1-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan78xx_read_reg() and lan78xx_read_stats() accept a control transfer
that returns fewer bytes than requested and then use the uninitialized
rest of their kmalloc()ed buffers. A device that sends short replies can
get stale heap contents used as the MAC address of the interface, and makes
ethtool -S report them to unprivileged users, including kernel text and
direct map pointers.

Patch 2 makes both helpers fail on short reads. Patch 1 comes first so
that a failing statistics read does not report uninitialized stack data
instead.

The bugs need a malicious or emulated USB device, which
Documentation/process/threat-model.rst treats as a regular bug rather
than a vulnerability, so they are posted publicly.

Testing: the series builds without warnings (W=1) on net and passes
checkpatch --strict. It applies unchanged to v6.12.105, where it was
tested with a LAN7800 emulated by raw-gadget + dummy_hcd, booted with
init_on_alloc=0:

- Zero-length statistics replies. Before: 40 to 88 of the 235 ethtool -S
  counters are non-zero, including usb_api_blocking_completion() and
  direct map pointers. After: every read fails with -EIO and all
  counters stay zero.

- 100 byte statistics replies. Before: 110 of the 235 counters are
  non-zero. With patch 1 only: 29 are, so the stale tail of the buffer
  still gets through. With both patches: the read fails with -EIO and
  all counters stay zero.

- Zero-length RX_ADDRL/RX_ADDRH replies. Before: the MAC address
  differs on every probe, is programmed into the MAC filter and is
  used as the address of the interface. After: the
  probe fails with -EIO.

Both bugs were found, and the patches written, with LLM assistance,
hence the Assisted-by tags.

Changes in v2 (review by Sashiko):
- 2/2: the commit message now says that with patch 1 only a partial
  statistics reply (1 to 187 bytes) still leaks, and that patch 2 depends on
  patch 1; the MAC address paragraph no longer claims a write-back to
  RX_ADDRL/RX_ADDRH, which happens only for an invalid address. The cover
  letter gains a partial-reply test. No code change.

Wei Jie Law (2):
  net: usb: lan78xx: do not update statistics after a failed read
  net: usb: lan78xx: reject short register and statistics reads

 drivers/net/usb/lan78xx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)


base-commit: 7ec48f396a1d89532c0537bc38b408b8c31ee37f
-- 
2.43.0

