Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602483;
	b=zQLCU4Gw/TzpaF2BjlOGoIXeNc4VBPn5DpY0l1cVJc7rZ8SejmwV9Y6n1Rzlozp5beln
	 Kl9hRWrlFR2i8/cIEZ39hE6sndL2jb8WkiQnPyoJcy3cwTqr6nUD1mA+aqbJCPLIfpmmA
	 GCZByFqosrYIgHGtdILKik4BKTqBxyVeLnteVvBDakuS5yyfQJyZIFNK/LSmzP5mYyXHg
	 P4S64b09XNq9iIyE39LJH+1unWg/iv+YjR6coxoOWP1Dhz3/UNWkjrmRdN7TsreTqtVSQ
	 8uq5iz+Pj306HBuVCm3BrsfnV0uodd6/06udY/pRXv+RURIhHI5nua/VDp5yq1Zs4Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b8AMUdU+UfP5dby39zviD2zPjp7BkaDWKMe/Dlb5Gvw=;
	b=05K/lhCmUTp+k2sQZnDXNlD1JWGST4Iq2icWorEOfwGs/05DUiIOMVFMr0ZkW1YeTdDi
	 V4Hstc5iYvfmqO9agsxzZ0JpICYYxpXblGy8oFKBRarDkV/yRUnr0KDZ1tL1lV94jko0C
	 EnpmjK/9pyytaBbh/NQ5GANQKJS9rDZo4BmcayLIy9CC0fDJUCyEdtAGqEY5YjxPRpwhb
	 fFquUhxLR64gWb1qvUmTfb0h5/3u03c2nUX4GLyrZC8M6PDwcWg9/oVjZBeS5iBahVAH6
	 W0J6HYwF1rjCZ0XyagXSRe7h/moH0E778aTm50fsI37tH+iDBCiMzugQFWlagwGLeqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZvlppJm7;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65633606A330
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65633606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZvlppJm7
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1873240a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794602482; x=1795207282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8AMUdU+UfP5dby39zviD2zPjp7BkaDWKMe/Dlb5Gvw=;
        b=ZvlppJm7pMOVtYVzsPFZAjb9LY3gzjPpqoxNTbiiKJEvc+PCXjkujcsIcrdPjM94je
         AxXV6386MoPmjjYAka0rh7ob7QEcdRf3K7xDDRJqe9T5hwBj9RxstYEg/HYinL2O9xCv
         xH8xv1GruM9VKrgIPo4gpct594euhGO5vDohWsRYdxdzNPwp38CVJ0gbpnPGu0i1Ihbx
         8V0o59cLQFEj0K1oJokCd2+eN/jVi2BJjJXeBJ8hqwz4qdVEBPfxrxE42lS5jE17dZ71
         6PorQY6xQSU79ARuKakAO7RC4jUzHb9zL2ssjSbAOBxwCpZKR9D6pz3yMcRhB982129D
         r08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602482; x=1795207282;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b8AMUdU+UfP5dby39zviD2zPjp7BkaDWKMe/Dlb5Gvw=;
        b=f107qbu4BbCqaRX6JhtVjTCBhPMBIVGLOOPwOPBLMCwyVHR3mBsuSc+llZ6bGcYnQl
         nigjobpK4kULRbEY2dgFGgtSIMihuh7U8xM/RfoIhL5VEVhRuw+rJkfvFQGUhd73IQy4
         o0Sbg5s5avVa4vhAW6IDnu1W6Lme7c3EeRTf3cLE+FgDIylYpdy0Yu/bTRVmVh3NrwPu
         aJcALHZ75lrCIvHMYQQ8KQlrvoP8L4pQQwweWgXHfGlATOFKTpFjRPr21RQvyybSrqNB
         FNPQDVEzsuRJCtWHJoLs4Vgrfe/6NcewJwKBASw2NC/yD0lQaWBM1E2lDgll039q5dmb
         WNUA==
X-Gm-Message-State: APuU4Z9qO6ZKcYpI90x0cQNS4oVXUDs1mwsUEuGUhbVIwrvYXt/ImrvJ
	DK2Y12pf+uCz6vKnpwF19VGp4xtr5qpLgNNIdiJ2KP/Jq9yUWzKRDgLCK2eiaw==
X-Gm-Gg: AYBFou3hLL/cSUcJtqk5HAGuHphRHVymeOf7Sk7NlKXs0Aw6Phf15Lz/DJiKXcn2OpG
	tFYfv/xOL5U5mdhAnaEtUx2CKbDcGIw/H5DSugQ6ghvh9XjgOXz4LT54Yl34ywNjdrhxLK0M9Nj
	eHLLhU8V4rOp6hU8sFa4ZrAmTA0iKNdvh3cmrMs05DTkB7mx2fNAPHTC9zvjcqzOU3o6g8x7bKz
	HRzkaiadx90Tvvh+aPlOFj6q/ht5WXEZyUgwEtuzfZFXgf+a4E/HbXkXRwjD7qewTtPIUrncuCO
	3h4WBCoVZk1uyhNKGc4+H9wmQ96jLGv5H4jovhPFbNf/usp9+O3rj3WdGDPnndpJzYD2soFiF5G
	MXdVrFkgk1MlBPjLUwDROg9oLGfCPhdp1Vwtci8puo9yMu9SVIBS7HARvZREZI/gIn6VYhtVS/3
	jOSEGbwcKIApAIxCAyJBo3TYcGlBCs9d3StoMNkZX3se8NOw+LR7udmOoRIPadpIVfzZv2C8yQ9
	iX6VdYB0ZtS8EIJBLmd8TvbnqILlgqDaZjHAhkE82XpmNe1fEDBP3TPenqYJ1UaVinr7YaoWBNR
	/I/KOtVaMK3nMW6mTnR9WHwjtPZUw8zCQ7tdUNINiqbL0y+t0B0gIVt4W16Li2NKXXVoKVLnk8W
	fzeASpJOQo+bvFdFMNLOyVoWajMVTpMMUqMnjKRcC53ZhtQ==
X-Received: by 2002:a17:90b:54cc:b0:3ae:a4fe:7ad4 with SMTP id 98e67ed59e1d1-3b1b0816e18mr3544629a91.2.1794602481736;
        Fri, 13 Nov 2026 12:41:21 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d04336sm11333020a91.7.2026.11.13.12.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:41:21 -0800 (PST)
Subject: [net PATCH 0/6] fbnic: Follow-up fixes for the Tx idle check,
 HW stats and FW mailbox allocations    
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Fri, 13 Nov 2026 12:41:19 -0800
Message-ID: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Follow-up fixes for fbnic on top of the series that was just applied
to net, plus two fixes for FW mailbox allocations under memory pressure.

Patch 1 makes the Tx idle check wait for in-flight PTP timestamps. The
QM idle registers do not cover the TMI completion path, so they can
report idle while a timestamp completion is still outstanding.

Patches 2-4 fix the HW stats: patch 2 stops a failed register read, as
every read is during DPC recovery, from being folded into the totals;
patch 3 puts all of the stats under the stats lock, as the MAC stats
getters no longer run under RTNL; patch 4 captures the baselines before
the stats can be read, at probe and on resume, where they are now
rebased as MMIO access returns.

Patches 5 and 6 address heartbeat failures seen on production hosts
during host memory stalls: the heartbeat and ownership requests are
stamped after their message is allocated, and FW completions, which
carry the whole coredump, are allocated with kvzalloc and the dump size
is bounded.

Patches 1, 3 and 4 were found by code review, the PTP completion
behaviour confirmed against the RTL; patches 2 and 3 were confirmed by
hardware testing with forced AER/DPC recovery, and patches 5 and 6
address failures seen on production hosts. Tested on QEMU with the fbnic
device model, and on a Yosemite V4 host with forced AER/DPC recovery
while reading the stats.

---

Alexander Duyck (6):
      fbnic: Wait for in-flight PTP timestamps before treating Tx as idle
      fbnic: Do not accumulate HW stats from failed register reads
      fbnic: Cover all of the HW stats with the stats lock
      fbnic: Initialize and reset the HW stats before they can be read
      fbnic: Stamp heartbeat and ownership requests after allocating them
      fbnic: Allocate FW completions with kvzalloc


 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  3 +-
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  3 -
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |  5 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  8 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 19 +++--
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  5 ++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 32 ++++----
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  8 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   | 16 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 73 +++++++++++++++----
 11 files changed, 131 insertions(+), 42 deletions(-)

--

