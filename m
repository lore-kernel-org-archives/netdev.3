Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1BB3BF695
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786640; cv=none; b=boVEJbynCtK0jRxx15mS0hVyJWiG2BHeb4aqQ4QvTuY0IOeccDkDf+qpFnuP3OSl5hWMIy/Hzd+4YceFCiORtWSvnbvLD/e3BuDz6pH0k9meLWj1pcq7FoYqzjhq5BXhmbGvjMOyWCuGuS9oqowY1vvo1Q63ND6h5kgQD72vhz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786640; c=relaxed/simple;
	bh=X/1pjwpB60sNcmBCCby0YPwVX4KJqgJkG6sqsXTh78o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQqIprRjI0YBfXEFgjMMsirBq0ga5p3XwpZ2GcxY9eU1ZGfCjPKCYp0T9XjaKffSFdVOJRLRr6Gxaaf8DE2fS9chk61Fwh2pnR5FP+z+hIcbUeux/SCsdxKMgnOIcJeoe0+A68QK7Eh7Emfla0Im3Cc7BFot5wF4VQoKL4mfRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izXmNVB4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izXmNVB4"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4b62d118aso906577a12.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791786637; x=1792391437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WfFi2at/lgAH1/xbqXNWbCEaLwYnM/ZF1CQqtE9gXAU=;
        b=izXmNVB4swda6S6DRAdkghF4IEGnsN9/QHh4NbLsEhjivEGLUBh1z/Og90rc+FEzaW
         1IeEs4y6NqhxMSUKVpCr4EQlxKGjpzYCVrTWkBQyx0WC2bxXM9xfOxtDW58o6k3le7YV
         YnMXyQ8nW3anCwsfXWmr8opGRTHZDkWbW//oiKow40XhSy7jNweyKSEodV7GFXrvimRI
         8OgW+JF7MWNLqhll+fHioYCT+caZ49C1l6Gf8GkxuqI1VhoMSvdR1M7vGajuqKhc0IHH
         H3rVobS7Le6npbDeRgQej4mdwKaHzVNgpihgQ+PZuo22ddVuE1w589yrljpbGu1z4CLt
         TSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791786637; x=1792391437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WfFi2at/lgAH1/xbqXNWbCEaLwYnM/ZF1CQqtE9gXAU=;
        b=dY+EW/gjFnGqq7pfRruR8o6OAOTNcfAkafCrTBwMEtJQWMIgBvGKV+vC7qrJ1rGnrh
         k+3a5r05Epb8VEPjBxljlqw3Hke5GWx15PAH6jm6nzeMHUouzK673eFRDHBDklmYJQKR
         3U/jy40MC4Ofrze8gVTp1lCVAFUzbwaEo998Q2/oZTmbRny1t4uyggKni0fxeiupuith
         zHBxTuL9tY5bN4GaWFnWJM7dXvn+GF0ZANJZAUM+aFch7jZOJTPkKxkcyRbmm6qFqJbh
         bo+7SAnNUfSAWDbojzp4ia+BCNz6ddD8xQpYlW/Vtj181GlFy1teJN/l89ZIYkhqrLLo
         OP3w==
X-Gm-Message-State: AFq9FYJ3m/7GmVKz5B2Ku8HgF219xNXcE9oukzWXYz7xKGiiZFQMq14Q
	vBvbvnHu+pnKvqQJuXEOsjkO6APXUocdxBE8W2rv+6V9VBV1Z/NlsV4b
X-Gm-Gg: AYBFou2PiEWPu5FIgPySDYPFMqp1z4AF1F6kbKewFR1oEh0Fy9ne4QFaY3ykMcumCXG
	MHZLrAVAS0dvR3zfcG8zRZZdj9SFGHiCrL88OyYZp5Aiio9BJ3ySW100mx3W7GMML57lM5tZeRG
	BW+ek+kIo3E2l3Va6HueQemLwu9ch/6L0S1kMfH9UCTMk9JSmOAoDEVwQ9gBXDSz7OcIee1P0Mp
	ER+D7ZtnWrDXyXksDJVKKu2zXzOTl+K4+0HoC34Y77lhyZ0bEaF9nzMFE/47NRXFBfKDmsldIga
	Q9PfKd23pXM19DwmvSk0VlhRmSXleYmNjzCt/IHHS03+kFZAdo33ve02agCeQ+IHZspEucXzx4v
	RQkDW43SWL0pgqUz9qHc0yR4fP/rmWW8cNgjDCokc3l+49MjAcfbKOgggujaqy4s72xVe++8R+G
	1LxSw7+oEMTR8PnbMrenM2J3QPmQWUMkfqzuty7inR/Xbf4fUlMsXgea0o8934aZaCvsM9aAr6G
	73fxv8FRYi9bW3CdXq9Y7TAI+XzajPm0TFDVlulcqBWLtdlN4RIWHeEJRNDF5lu634Tu3Zf3TPG
	Qh+2w5yw1S2A7Q==
X-Received: by 2002:a17:90b:5346:b0:3ab:235b:185b with SMTP id 98e67ed59e1d1-3ab3a77980emr6448875a91.31.1791786637261;
        Sun, 11 Oct 2026 23:30:37 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab371c32cesm14452767a91.16.2026.10.11.23.30.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 23:30:36 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	decot@google.com,
	milena.olech@intel.com,
	joshua.a.hay@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v4 0/2] idpf: destroy the vports on shutdown
Date: Mon, 12 Oct 2026 14:30:25 +0800
Message-ID: <20261012063027.27750-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tian Xun Ng <tianxun.ng@bytedance.com>

On shutdown idpf shuts its virtchnl transaction manager down before the
vports are torn down, so the device is never told that they are gone.
Patch 2 keeps the mailbox up for that teardown, as remove already does,
with a short timeout so that an unresponsive control plane cannot hold
up a reboot for long. Doing so would expose shutdown to an existing
remove-path race between the async PTP Tx timestamp callback and
idpf_ptp_release(), which patch 1 closes first.

An LLM coding assistant helped analyse the problem and draft the changes
and their messages. Both patches carry an Assisted-by tag.

Changes in v4:
- New patch 1, closing the Tx timestamp callback race that Sashiko
  pointed out on v3. It already affects remove; with patch 2 it would
  also reach shutdown.
- Patch 2: the Tx queue SW marker wait follows the same bail-out as the
  mailbox transactions, so a control plane that acks DISABLE_QUEUES but
  posts no markers costs one marker timeout instead of one per queue
  (Emil).
- Patch 2: the statistics task stops sending once IDPF_REMOVE_IN_PROG is
  set (Emil).
- Patch 2: the shutdown comment now says that a transaction already in
  flight keeps its own timeout; bounding that would need support in
  libie.
- Not changed: if one teardown reply or Tx queue marker takes longer
  than 500 ms, the rest of the teardown is skipped. On the tested PFs
  the queue-related messages took at most 240 ms, and the slowest,
  DEALLOC_VECTORS (about 300 ms), is sent last, after DESTROY_VPORT.
  With the driver made to treat the first Tx queue marker as missing, so
  that UNMAP_QUEUE_VECTOR, DESTROY_VPORT and DEALLOC_VECTORS were
  skipped, 3 of 3 warm reboots were still clean on these devices. A
  function reset as a fallback was patch 2 of v1; in our tests a
  function reset on shutdown did not stop the faults, so it was dropped.
  I can add one for when the timeout fires if that is preferred.

Testing, besides what patch 2 describes: W=1 builds of idpf and libie
with allmodconfig and allyesconfig showed no new warnings after either
patch. On one server, modprobe -r idpf and a reload completed without
warnings or IOMMU faults. These devices do not support PTP, so the path
that patch 1 changes was not exercised on hardware.

Changes in v3:
- No new flags: adapter->vc_xn_timeout_ms (60 s from probe) is lowered
  to 500 ms on shutdown, and idpf_send_mb_msg() fails the rest at once
  after a shortened transaction times out (Emil).
- IDPF_REMOVE_IN_PROG is set before the service and event tasks are
  cancelled (Emil); the comment and message no longer state that a reset
  does not clear the vports (Emil).

v3: https://lore.kernel.org/all/20261009032706.94324-1-luckilystar08@gmail.com/
v2: https://lore.kernel.org/all/20261007055741.30629-1-luckilystar08@gmail.com/
v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/

Tian Xun Ng (2):
  idpf: don't use the Tx timestamp trackers once removal has started
  idpf: keep the mailbox up while tearing down vports on shutdown

 drivers/net/ethernet/intel/idpf/idpf.h        |  3 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 11 +++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 68 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  3 +-
 6 files changed, 80 insertions(+), 9 deletions(-)

-- 
2.50.1 (Apple Git-155)

