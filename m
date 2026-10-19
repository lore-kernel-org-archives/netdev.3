Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454853DAABF
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407169; cv=none; b=umbnMYVILh+JfcdV0OBrErbzRwrDKLBc7TObO/zF+I/RemWZEbmMLR54ITcusBjs195V1ue6oKCSbyFs8qoAxwS1ismrgcAacCVLTB3n1bHVHYnvhLZy8D4XLTLsPbiTnituaCVHW6fw6anWELUBz+zx2Z4hHpqrUUjNYWm+M3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407169; c=relaxed/simple;
	bh=pm2OcIWKS0Mrluk+xgY9BFIgHrq3LpZhYd+9i9aERN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4HeD37pv2oxuzEhY1M3VyzqusfcL5YS/iDEUJKF+rM2MPO/4UB6eVzRvuWsujzckyKoE94Av4fxuykNQPsLbkEP94ou1A/RoxgQKnM51It30iQIs5fUMDxQI+wekOYi3ZthbGirfUCjPOLzXNTnAAnRy6zqWl/KrH/Y6OHgI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=flfPEtlO; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="flfPEtlO"
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B4C263F2D7
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792407154;
	bh=1oLogmVGlJ6B8L+VB4rQSHuGOeONrwssRUu0KT4NlTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=flfPEtlOpqeAEx1FPUBhErVNqoil4hRtlbVj/6sSWzfDI6WujJCcwfMw+T0EH+e2k
	 sDczt0fMMdrl7rmB2O3pFPyFWaImbcoiSxdtUNh10nJQ0Za0M/xLuW6D/Gw57+jJ9C
	 dzCpXdl/GyOq/tji6ftO3TkMYt8Pd29M5BhVJwRrWhVieFj8mA/YfaErO+2+LsuICt
	 11YeA19NPXV3f4jaF5pXczxOWxKun6+sTgi8TE6g1xZbtAhTSFJoDqGWnD94gXNQz0
	 7LbIGgGYEaKG0hJkbSh+KUs46Hv7DNs966Ils69/PelaGSr5BTNs4ds5qYCs3IiTAL
	 HVOhRrfAB2/oeBZZoBhZ7shXPFmPtscM1WuaeW2GG64FDGm4wvF55Rj3U3YulxoxGx
	 lxoELZijC882/A/Hf2cWzI8fbfOJDJAnPlBfPn3nOTVCXm4uqwHtqVVgDoFydE56AC
	 hm6qZvrl8UDpQKRNNhK1PP6eRGSXkhEOBsgcOZkZ93DE/pWmbX4kxtjc+VPOIL6hFW
	 8qp61wy3551iUPa/7o/0Md/k0Lwazi3yrLZTRxBjl6eU2yRFE8ZVpz3EMFvKAf9RRN
	 jYEkcysFByAGfOV8n8atMPFtUsT3NyU33gBsBEq5qu/xceJu6XA+cO1eohFB8tUKSP
	 epYIDkDYLeGYKm6J4Efr+GaQ=
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e1ad3cb66so149094f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407154; x=1793011954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1oLogmVGlJ6B8L+VB4rQSHuGOeONrwssRUu0KT4NlTo=;
        b=aV6g0qeFDVLeYxSZvODxnRo3K31bUOSzWRWyHDrqAu/0RXaCTZw60viBSWwioLcjOT
         6/8+q2b3SfT+V5nW/bYng9aYyoo54pKn6BVAg9aQfG74/pot2RxNwaIcjafsChkLTImD
         Jme3T0Nnjj5lZhKB8OLITo2FfDM6b1JchQAYCmGGbnlTfh/jK4FdFPc6+gXVxGuYDZ9g
         zAElSNE3E3JGuOZ5f3u+eMikGw4XHqoy14/pgQTBTq6EVmXSsmRN0MhVeM2Nu35oBOI4
         /sGFXvRjVQQ5v4wluUHu/1xMhakJlHVOnfyOTf71EdvY9Gq6/k1Es9AAvzwSr2xwMQ2i
         HLDg==
X-Forwarded-Encrypted: i=1; AKwUvByOp0jzc57TyiA0ZeKLM3Cxw4OXVMs+msM7vNqlPfG2krTpLiWAf/7bsbTQjMERJNOb7QQEj/c=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+9xsAEyRIDcPdOIBTHqlJKZ0HU1C/foKgswlePkjYa7gH5W+j
	FgRDMNsvyjC3nnHmFQ/TWz8Ok26VcmOHwWncGoDjNjIrA4ZGQYtaKbfP+HcL+SCzjPXWgKO1bM6
	Q7+67Nyuu5SOIiwPC+RkZTx4viyW3ZbQ3rnvbIBQdlEoE3TOv7G4sAgL3W60NhYXNkwty4pBOFg
	==
X-Gm-Gg: AYBFou1fgCfVUO5gksylHXgDenPaY3AqvUZxOMkSX0SN5wgjhHFFkww981/YgnvV0t7
	elCQmtdPb6VKy9XhE4iD5HHycqkf+MrxwIZLhD3EFd0gxmzm9+bP9DAAbICxRaQQVTsrBSXlX35
	O/KaELoDw7yG4k4bgzmWkIfsaETgVWtTyvScT/h1CTCluevpSQg/M53ylvfRZOR3+jGCnoVF7mz
	vrCPQlvNwH0lX6nMVTrQXnZO1GWDW+FufqdzDFp3hNnGVXsrsy6t1RHOScYA3/MEdOLYUv2t1HE
	7hPp5Ncg5uxnGke8XkDyP6r7Xwav+6v7cZMtomjzzmrgGL6SGcMoi/tsb9G0EnncpeUi3zaTuu9
	P7cx7tlVXBuBwXi3rppIOBlfvyC7PNgtekM8sWEzK7vwctJNAfsLoSppcXX518nu92ftho0QgXN
	Prqdn6ENj36jZedWvNNvNCn5Itx3bZGtowo1MaXF9f7c27pS5vrFQ26yntb2ui5MnW1ubhHXW7A
	s6xurDU0Bhndp7jgx+miup+psoLjbD3IT6DNrFr
X-Received: by 2002:a5d:61ca:0:b0:48b:10af:f85c with SMTP id ffacd0b85a97d-48e07fcda0dmr8499727f8f.37.1792407154202;
        Mon, 19 Oct 2026 03:52:34 -0700 (PDT)
X-Received: by 2002:a5d:61ca:0:b0:48b:10af:f85c with SMTP id ffacd0b85a97d-48e07fcda0dmr8499702f8f.37.1792407153808;
        Mon, 19 Oct 2026 03:52:33 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:52:33 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dan Nowlin <dan.nowlin@intel.com>,
	Brett Creeley <brett.creeley@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH 0/5] ice: fix reset and suspend paths
Date: Mon, 19 Oct 2026 18:51:50 +0800
Message-ID: <20261019105155.3793063-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fixes address failures seen while validating reset
recovery and suspend/resume on a system with two E830 PFs and
two E810 PFs, with KASAN enabled.  With several PFs probing,
downloading DDP packages and rebuilding after resets at the
same time, the logs filled up with:

    ice 0000:38:00.0: Control Send Queue Writeback timeout.
    ice 0000:38:00.0: Failed to get VLAN mode, status -5
    ice 0000:38:00.0: Pkg download failed: err -5 off 267124737 inf 96
    ice 0000:38:00.0: package load failed, -12
    ice 0000:38:00.0: probe with driver ice failed with error -5
    ice 0000:c8:00.1: clear PF configuration failed -5
    ice 0000:c8:00.0: Rebuild failed, unload and reload driver

Patch 2 has no Fixes tag on purpose; it is a prerequisite for
patch 3, so stable backports of patch 3 must include patch 2.

Aaron Ma (5):
  ice: check the full PF reset polling limit
  ice: retain the adapter throughout hardware initialization and
    teardown
  ice: scope global configuration lock to the adapter
  ice: clear DVM boost table before scanning package hints
  ice: quiesce PTP periodic work before system suspend

 drivers/net/ethernet/intel/ice/ice_adapter.c |  2 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++
 drivers/net/ethernet/intel/ice/ice_common.c  | 65 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_common.h  |  3 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c     |  8 +--
 drivers/net/ethernet/intel/ice/ice_main.c    | 37 ++++++-----
 6 files changed, 80 insertions(+), 41 deletions(-)

-- 
2.53.0

