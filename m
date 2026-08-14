Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FDF3D47A5
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673650; cv=none; b=s7Lv4p/9stnyegVgU4xz9ii1JjrGMvFc6N119xsTH7WS/f/Y0pS9pEgA8hZzAlqy4PMKEGkew/HFRAB5TcZ4uoUQCka7Y7FvVkJ5/NiDorbCuvDRbE1CFscJJh2hJL2V95Am8CzSYOY4VCsJJTCjOWiVRh33907Po0oTHzzOfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673650; c=relaxed/simple;
	bh=QpYUCLZj1yfN3gVx4tQscwbqaJGdHlE7TtXcacBdEao=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C5+eRO9tgHHCEnCuIStzvLTu/x3ym3sPfGz8xbXOj1zKPCsDh+/g5u1nVNeMzpmLtVAOGsA3FSgVwnDFYxCOIJP1N9cEa5d7fQ9LZ3Gp0pLjgsn5snNymf70AfVBA+D6dbp0ZivptWmw+tmbsicP5dO+ORn58iKucWyr3X9RVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CsTV+bXf; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CsTV+bXf"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8487eb67173so708057b3a.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673648; x=1787278448; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W0Oe/LvifeLBGooF3p0AWcsDdEJir2qt3r/dB6w0lF4=;
        b=CsTV+bXfDBUhGIptasP/+61KIFA/mInVApSF2tyXdlWAgZXc9sc8gs+PsbffJQ/3HG
         xI3Lo3nzD7rLLe4vRHTdvx9hWl+b3Hh/CqjH1IEj/vKvnOQQQ3HFdje9lHk8yPfxm17Z
         nVP3/r3NglcjKO4M2Z6UfB4Rhzr9ftEqkl+TPZjaQw44BVCelkk995+vgdZt3hrbMCEY
         hGC9N7c7wNRriystU/zHe/fTVLs7euWI1vO2MZeMuXlun+0QwYhijt/m0ucW1yPH74jK
         6SowOW2sZw6o0vWNCENj5U73BMuMdmJZ4SwYAIeI5w+OLxEWoWPqvemNhMBjXMKq/Lyd
         rQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673648; x=1787278448;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0Oe/LvifeLBGooF3p0AWcsDdEJir2qt3r/dB6w0lF4=;
        b=FPwKleqQs1uqMORdfaCsn4O6MGXVwa0Rhk+6O/S24wteEefdGFRsa4UPeuuzJ3hSbb
         dAl/ruoEWqfnfUVCE2VPqM0t/XJx8at8k14Oan2HUzBgS2uLFgLZNFoAyPtFnu8chzJU
         o4gh6ti4uPaY09sSDKWbMgYWv9hvHwMhHT1ZJwpA/G0m43IJgPyhay/f1BKWogUdlaVO
         j/8ez1sMVBuUGazsJQQSuHT3G8coS6BYN+LiiHUEsOM0dR0EQdLJl/86O/nxbflzsOhX
         861kpCNI2PSIVmjafO8b1pbNG15KfmFmlMVG19zeQQPwQF0ICGNAL5Vpzzzx9x2LVp+d
         3DRA==
X-Gm-Message-State: AOJu0Yx75aoSn1Nq7glU2JWivGHVIby3dumueXVnCSzAhv3qR94y/+I3
	OW/d/biFicTO5/KbJJa8GkNl1fyTCzKjWpgDB1NX7f/+sUFC408On3PHVntV8qU6jr6daHQA0w4
	UoWtjpPxm+Aersub0kGlGgxmRoNN4TX/vi9js9ZraW8B9ThwcisfSI27Ox8WtSFzY8KC6evaHuw
	5WlwmPOY0nfjAASbHfShrdSoQOA/1KXeDRiywP8zNuyXfgh3vcMYCn64GEdI3uxo4=
X-Received: from pfbdu12.prod.google.com ([2002:a05:6a00:2b4c:b0:84e:46e0:6349])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:368f:b0:845:e97d:447e with SMTP id d2e1a72fcca58-84fde32499fmr2662134b3a.26.1786673647787;
 Thu, 13 Aug 2026 19:14:07 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:13:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-1-hramamurthy@google.com>
Subject: [PATCH net-next v4 00/15] gve: AdminQ mode related refactors
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com, debarghyak@google.com, 
	kees@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series is preparing the driver for the addition of a new control
plane mode(MailboxQ) by commonizing and reusing as much code as possible.
MailboxQ is a new control plane infrastructure which uses mailbox queues.
This is a new control plane to communicate with the device when the driver
is running on bare-metal instances as well as newer versions of the device.

This series contains 2 main changes to the gve driver's existing control
plane(AdminQ):
1) refactor some initialization/teardown path methods to make it work for
   both control planes.
2) add gve_ctrl_ops structure to the driver for various control plane
   operations

The refactors are mainly around the init, reset and recover paths so that
functionalities could be moved into the control ops like 'set_num_queues',
'set_num_ntfy_blks' etc.

This patch series only sets the control ops for AdminQ mode. This is
intended as a preparation for adding MailboxQ mode in upcoming series
which will add the new control plane infrastructure and then introduce
the corresponding control ops for MailboxQ mode.

The entire list of future patches can be found here for reference:
https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/

Changes in v4:
- Reduce code churn by placing new functions directly in gve_adminq.c, introducing final tab spacing
  and using local variable (Przemek Kitszel)
- Fix kdoc formatting and drop spurious management interrupt(patch 9)
- Propagate release_db_resources naming change (patch 12)
- Remove double logging in destroy queues path (patch 14)
- v3: https://lore.kernel.org/netdev/20260803184630.3813311-1-hramamurthy@google.com/

Changes in v3:
- Fix driver compatibility verification in the reset and recovery paths (patches 2, 8).
- Mark gve_adminq_get_device_properties() with __maybe_unused ahead of its usage (patch 7).
- Refine error handling and resource cleanup in reset, probe, and queue creation paths (patches 8, 9, 11, 14).
- Keep IRQ doorbell allocation/release in control plane resource helpers (patch 12).
- Minor fixes: fix TOCTOU issue for link speed, correct kdoc comments, and remove redundant teardown calls (patches 4, 11, 15). 
- v2: https://lore.kernel.org/netdev/20260602235900.3050782-1-hramamurthy@google.com/

Changes in v2:
- Rebased against latest net-next to resolve apply failure for patch 5
- Fixed a few typos in commit messages of patch 9 and 14
- Fixed a kdoc warning in patch 9
- v1: https://lore.kernel.org/netdev/20260601175437.3767283-1-hramamurthy@google.com/
Harshitha Ramamurthy (9):
  gve: don't pass in unused parameter to gve_adminq_free
  gve: refactor initialization with helper functions
  gve: add a few helper functions to set device properties
  gve: add struct gve_device_info to hold device properties
  gve: introduce control plane operations structure
  gve: introduce ctrl ops to set vectors and Qs
  gve: introduce gve_adminq_get_device_properties()
  gve: refactor gve_init_priv for reset path
  gve: add ctrl ops to for queue operations

Joshua Washington (6):
  gve: simplify reset logic
  gve: add gve_ctrl_ops for gve initialization/teardown sequences
  gve: split up notify block allocation and setup paths
  gve: introduce new methods to handle IRQ doorbells
  gve: setup and teardown management interrupts
  gve: add link status/speed ctrl ops

 drivers/net/ethernet/google/gve/gve.h         |  89 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 437 ++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |  25 +-
 drivers/net/ethernet/google/gve/gve_dqo.h     |   2 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
 .../net/ethernet/google/gve/gve_flow_rule.c   |  15 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 940 +++++++++---------
 7 files changed, 957 insertions(+), 556 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

