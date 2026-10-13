Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB004F4D06
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893557; cv=none; b=VOEzjIvI3XTl6TqePYW3SdkODVoqEmiMwpeuHS8WVvwQAMu3zKe1e33/QksHbQwUw2ZlvxB0H5YffOt+j0ZBfnzQB4fDBuIA7w5tTY8IliBMU6qinYzUQ6aStevq05T5Oxj9feF49tyFudu/54dIZ5mVl5+CgfRH19zjE0U1m9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893557; c=relaxed/simple;
	bh=DEmjfxg+EpIw5LxrI8Uicxfki+jkxwRYELT6w0zDIYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9WfPqSNzoV9A9f4uNfLMep/9zLlKWmO/qZWLeT0jd44mqP339al4j9DOPF3MJF8Tec8DhhAUoxMYSfIQw3pJkYRjr3zZmr1uulzEwxzTKQM+fobsHAmF+kBYKtTfcWkgLjKsMvtDcMA0BRFlbsA5+5TX3E+fxgDOi6stnG/Ayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEchVTZ2; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEchVTZ2"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535a54bed9so3985719eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791893555; x=1792498355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ZQESZ4ejOVf3RnoP7b09ULWLMWyLE2vdzE7Bkq650o=;
        b=FEchVTZ21hmtAIHQtzX2l+TSGmw8rwvt7hYHWg2Zw6kgDvI5rcO6piSiPstoxICiXd
         HUbussNV/vAKyB2qQJKUBSBLNDRZAbvZ0UbbH/V9HkqkIBQUgKVgMV2zO0ZZC4+L8RwP
         hO9kNWMFWJk9h0jjMAHMepBnv8DCQgq3rNmPCCWBxaFt9yDk/y0+zGG6P1PGjT1EfsTE
         mcT3rmvDOmW1kBIiQ3SVUR5y8ku+W+0zNOpAEVGKF3DdTK9Xt2ti4ZSDLs/RRVNzuUDG
         rIDNmE3DwZDqKJhwXnoVLG0gB/Y/DEw88mnaozuXLJb4q0yjTTGkSZfsDQUVZ3tblv4k
         KwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893555; x=1792498355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ZQESZ4ejOVf3RnoP7b09ULWLMWyLE2vdzE7Bkq650o=;
        b=efFk6s1ncIOjW89zRh1moCMEaqGpdaeZz1CWJrVzRSe4PXJH784qLR1vBjJiUMitf/
         hYQgBqWS3Lu+5zlGH8ikaEt40ooCMlO3QFPu/YPAHPDXvbrStvkxpd50oeoJnNc0U3+O
         +/76qqPSkubKfe9SW8TeriYx93v9/AcHP9/IOxoX+RuD1o6Dj7eC+l7Z9b2JVtVMSUhQ
         sBv79Fvkuy2DOx1BTm0jmS7N/CNIqDtKombXy/LN3wNGRu//wJ0I/Bai3yLJXtVjlVOc
         aE9DCwJXqm6r89ywaJhnwnlxf5DV9InnEjIIIB7ZsxQVQDQS3hDtkOUJQrWQjhWJkn0Q
         9Rww==
X-Gm-Message-State: AFq9FYLFJZuodOkZQuFw5MW+yAHL3EiE9JvunLSbzNUOPr+ktLAg0UqI
	pgxVgvsocHC4dlFm7ikgyRZ6tJnHugo7YgNfAIBOMN+W2dogzebPwIEh
X-Gm-Gg: AYBFou0D4+OxgfGxkGS5STNxTwtKQLyGy61csSG0gI8t5fFtBDtaIMshWe4F4aoABxK
	mMcxcN7gud1gh9uWl+pOyfyTJ/X5XR26Vk/x3gaSbc8HC6gCQ5yFIJHwAuLITjMGueMZ/r2DOVG
	5/ui2mCT7JdniRD74On81emNFp+EUPMr1cpGPgyf+VX86qDt/dyJrZML7EUB7X1SpUGtr8d9TqQ
	+CbSl4NCE4Ij0f6r3cMHf4mIOfbfFXp62/vrTdQ5alWGldpo+Jwl2rSXfrcc/VtoApMfGCs236D
	aEzsHt3vwxSNaNiTOd6W3FWbAwx6XGaTqwvZrW2XiM3H453VMUG6+hafK8ZY5g2UvW9xW6dRYwT
	Nj4LobRkX/wt2uOv/D9nJQyPZ37qrd4nIQluzl9H+dgz8UbliccDxmHMbbIFsYmmXVHcxnVHkQ8
	ORHW/j/FFBmLTFDAVtlnKlcLTCOYWM6Y27DqPGB3oibCa73woQNdDkAjisAyYvR6h8lrPzvFSv7
	vZyWgpgFuzp8FybOi8h74u13d/NoRm3Crq7JR/DzT3zaO3FzjSJJATEY/MrQsX3o1q0E/Eawfry
	ZQ==
X-Received: by 2002:a05:7301:5005:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-3537e0be018mr17583399eec.22.1791893554886;
        Tue, 13 Oct 2026 05:12:34 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (34.224.142.34.bc.googleusercontent.com. [34.142.224.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca7133asm52304765eec.14.2026.10.13.05.12.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 05:12:34 -0700 (PDT)
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
	alan.brady@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v5 0/3] idpf: destroy the vports on shutdown
Date: Tue, 13 Oct 2026 20:12:21 +0800
Message-ID: <20261013121224.84482-1-luckilystar08@gmail.com>
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
Patch 3 keeps the mailbox up for that teardown, as remove already does,
with a short timeout so that an unresponsive control plane cannot hold
up a reboot for long. Patches 1 and 2 first close two existing races in
which the mailbox task uses state that the teardown has released: the
async PTP Tx timestamp reply, which patch 3 would otherwise make
reachable on shutdown, and link change events, which can already arrive
in that window on both remove and shutdown.

An LLM coding assistant helped analyse the problem and draft the changes
and their messages. Each patch carries an Assisted-by tag.

Changes in v5:
- New patch 2: idpf_handle_event_link() returns once IDPF_REMOVE_IN_PROG
  is set, so that a link event cannot use a vport, or its netdev, that
  idpf_deinit_task() has released (Sashiko on v4). The window predates
  this series: mbx_task keeps running until idpf_vc_core_deinit()
  cancels it after the vports are gone, with or without the requeue in
  patch 1, whose drain makes the check race-free. The same window on a
  hard reset is not changed.
- Patch 1 is retitled to the mailbox reply it guards. The Tx timestamp
  state cached for the transmit and Tx completion paths is freed by
  idpf_ptp_release() before NAPI is disabled; that older lifetime issue
  is not touched here.
- Patch 3: a missing Tx queue marker no longer stops the mailbox
  messages that follow. The remaining queues of that vport skip their
  marker wait, and UNMAP_QUEUE_VECTOR, DESTROY_VPORT and DEALLOC_VECTORS
  are still sent with the 500 ms cap. This departs from the helper
  suggested on v3, which also failed the later messages: the device has
  just answered DISABLE_QUEUES, so its mailbox works. With the first
  marker treated as missing, all six transactions completed and 3 of 3
  warm reboots were clean.
- Patch 3: the kdoc and the message now say that only a synchronous
  transaction that times out fails the later ones at once, and that a
  reset already running in the event task keeps its own timeouts.
  IDPF_REMOVE_IN_PROG is documented as covering shutdown.

Testing of v5, besides what patch 3 describes: W=1 builds of idpf and
libie with allmodconfig and allyesconfig showed no new warnings after
each patch. On one server, modprobe -r idpf and a reload completed
without warnings or IOMMU faults. No link event arrived during a
teardown in these tests, so the path patch 2 changes was not exercised;
these devices do not support PTP, so neither was the one patch 1
changes.

Changes in v4 (patch numbers as in v4):
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

Changes in v3:
- No new flags: adapter->vc_xn_timeout_ms (60 s from probe) is lowered
  to 500 ms on shutdown, and idpf_send_mb_msg() fails the rest at once
  after a shortened transaction times out (Emil).
- IDPF_REMOVE_IN_PROG is set before the service and event tasks are
  cancelled (Emil); the comment and message no longer state that a reset
  does not clear the vports (Emil).

v4: https://lore.kernel.org/all/20261012063027.27750-1-luckilystar08@gmail.com/
v3: https://lore.kernel.org/all/20261009032706.94324-1-luckilystar08@gmail.com/
v2: https://lore.kernel.org/all/20261007055741.30629-1-luckilystar08@gmail.com/
v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/

Tian Xun Ng (3):
  idpf: ignore Tx timestamp replies once removal has started
  idpf: ignore link events once removal has started
  idpf: keep the mailbox up while tearing down vports on shutdown

 drivers/net/ethernet/intel/idpf/idpf.h        |  5 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 ++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 11 +++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 49 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  3 +-
 6 files changed, 64 insertions(+), 8 deletions(-)

-- 
2.50.1 (Apple Git-155)

