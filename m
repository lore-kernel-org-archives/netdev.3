Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CC3812D2
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338882; cv=none; b=SKAbeXXS/LnD53/8tKBp6jxqVWE81AyACZ/mXC2DERan3CS0MmxzoFC5/DsIBtxZTOU6Ht4ZTcmSfpCNlYGnB3rVvbbIvaXk0T85TTMM5IBLH2bqmlZnKob6OkTzrpocv74u/6DSOY/ZMqFyXOVz4sBTJ0HL5U+lHLFyN37n1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338882; c=relaxed/simple;
	bh=t9FQ3A9mEseT+Duvi8HZlUp3GSfuowElm+hKDRi+cGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIbMLTxRfvIkDqxpE4yN7OB6avrUtrpx4Jo1+3et2WcWsJAUXs3PmAtMXEh0X2WiILgbI5Se0cJXgDF/pFRr+JnO+A1srWozZ0jdm1rJ9jHsKAiMxUX2Y9Fu/pcyp4cGPKHCZgqMly9kzavum7xoi5cyksDrB6GXfe9/QmEkJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S1083bGK; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S1083bGK"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1171070a91.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338880; x=1786943680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UCf2bXdgmutT/THMTQgCZs8y1c1rlzeGzPri2rqohXs=;
        b=PEYCzph7mQtLm5lCTjBbbcAL8fp5IYyoAxQaKzwM2HIIqwXfHpsjS+XoUw+4ydiBl2
         QR2sDZr4HVSGJhm7EgNfuvBv5ciUGI2J2jLzdX6HaOFMBXecMDrFDO1t1L+lxTq60BR0
         4gf/mXVgt6FlicjHxuO+1VWMQQRq8VpdBCAQojLmMgTUTfbTCBALO3lRK1pYJNKY9ygd
         VL8XrCzRTffzSPO8jSmZGZBlGTD1vo1buhc30D49IJbVzInPvOOzZza1VsPV1qH27ddn
         0drVoK6i/MnGU9WSY8iJlc6rqecRwZXUFUNMsrpq9wDTw8AJjGkcR3IHNJN5eXpZR/as
         +B1A==
X-Gm-Message-State: AOJu0YxATHezLJ01dTn6a8t2b1H8AJo5+T5N18O6WaoJA+ZB7ChoESEg
	Co16xqQfZkcz5bFmbh1u+cfmxlzH1hS6F8ToQbMthDSxNokCvcnpN5YIp6lwTB9l+tcySdkpsMY
	gjT40S5wfkMcaqSxiseBmrmg9XTCvZjCK90IUpmW6a0FqlTRoIBMH+20QaZ7o84rdgCF5nj+HMr
	NFnHI+x8vGM4kX1FZ9ejXlFSBGCxCBP8Y+W8+EEnE+3KPv2hJeYVQgH7U46jDYwzz/2x0JMlpjS
	PPGGPqHwdE=
X-Gm-Gg: AR+sD12Umejy6Hhl3j1E2o0O8dWfeC6bTOarCXCI+dO8MVUsonb97sAnhxpCzs14AgQ
	dpY3Mp/qx7yD+2eFS/uFeiL3nj9O7HdiTMiR3og+vohShg4cz9rMK9aYPwU9lHyKBwmmpP+HPNW
	K2rCQ300CiAgFxtDHXzO0G2pFvBu7E/27yEhXVVkaIzlj3yZD4c8jUcpEESlBynK516rCl9pEZs
	8BtvLaiTmQ1rvzeaQ+Ti/ZrB5YZW5FHMp+WHpitwivKrf5YIbbd3jao6XM8/23KBNLc1QTJzSD9
	r80pPorvdlA2XmCB3FKyNZwH+3DCnYy9zBy/Wh5d23XlHN0uVHp6Ud/v826Cofzv9d6p/jXTbmb
	DzW4X7NNGPq6sVT68b1u+0/J1aVxsGgofMZXJO4GWnqRbCEyyWKcMt+hw5OnFRgHKsRqZgzOs0f
	KYLA6+/MO76MMXFttqJcbq/UQ/9uPBpdwqcOA=
X-Received: by 2002:a17:90b:3a84:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-392845e20bdmr6846889a91.2.1786338880051;
        Sun, 09 Aug 2026 22:14:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-392825d6e6bsm3954759a91.10.2026.08.09.22.14.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:14:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5283fa0656dso49045011cf.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338879; x=1786943679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UCf2bXdgmutT/THMTQgCZs8y1c1rlzeGzPri2rqohXs=;
        b=S1083bGKXKUb+3ZdG3JaNxfBmuVWLLPrrd/CijNwJ8nXfaXAbbbuo5nz0CV0WlYHyK
         +CTGxiME58g1HB8CNZgJ2pYqAm4mczB/axMnnfHoMtURZkM5QIGwAaLEvq3XipF/xAIS
         0xVk7q0tFmU6ImdwLjjqTXn4ICyP5BQZjMwYo=
X-Received: by 2002:a05:622a:1ba7:b0:516:d83d:b28 with SMTP id d75a77b69052e-52d237e90abmr157431141cf.17.1786338878746;
        Sun, 09 Aug 2026 22:14:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1ba7:b0:516:d83d:b28 with SMTP id d75a77b69052e-52d237e90abmr157430931cf.17.1786338878318;
        Sun, 09 Aug 2026 22:14:38 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:14:37 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v6 00/15] bnxt_en: Add kTLS TX offload support
Date: Sun,  9 Aug 2026 22:13:43 -0700
Message-ID: <20260810051358.1244418-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patchset adds kTLS offload support for TX direction.  A number
of new files are added:

bnxt_mpc.[ch] handle midpath channels (MPCs) used to offload kTLS
connections to the chip's crypto blocks without going through FW.

bnxt_crypto.[ch] handle the crypto interface and resources.

bnxt_ktls.[ch] handle kTLS offload.

A new CONFIG_BNXT_TLS is added to enable all of the above.  The first 6
patches add the MPC logic including resource accounting and reservations.
The next 5 patches add the crypto logic to handle the crypto resources
and to send/receive control data using the MPCs.  The last 4 patches
add kTLS offload for the TX direction.

There will be a follow-on patchset to make the TX offload more complete
and to add the RX direction offload.

v6:
Fix more Sashiko reported issues:

Patch #1:
Make sure mpc capability is only updated during reset or ifdown/up.

Patch #10:
Handle both long and short MPC completions.
Leave one empty slot in the MPC ring just like TX ring.
Use memory barrier when updating tx_cons for MPC ring.

Patch #11:
Disable NAPI during MPC ring restart.
Add bnxt_free_mpc_entries() called during shutdown like other rings.
Simplify bnxt_xmit_crypto_cmd() error path.

Patch #13:
Goto kick_pending if kTLS transmit failed to flush the DB.
Handle the case of BPF truncating the TX packet.

Patch #14:
Clear is_push and inline_data_bds during TX ring free.

v5:
https://lore.kernel.org/netdev/20260710042400.3996847-1-michael.chan@broadcom.com/

Fix most valid Sashiko reported issues or add comments to clarify:

Patch #2:
Clarify in the commit log that kTLS, MPC rings are only supported on
P5_PLUS chips in response to some Sashiko comments.

Patch #3:
Improve the ethtool -L MPC calculation to use the actual MPC rings
during ring check.

Add a comment in the code to explain the bnxt_trim_mpc_ring() call.

Patch #5:
Check for P5_PLUS before allocating mpc_info to more clearly document that
MPC rings are only supported on P5_PLUS chips.

Patch #8:
Pre-existing Sashiko issue not addressed.

Patch #9:
More clearly document and explain that bnxt_clear_crypto() has no
concurrent readers/writers.

Add comment to explain that the bnxt_free_one_ctx() caller is reponsible
to check the epoch value when needed.

Patch #10:
Add description in commit log that crypto engines use short completions
only.

Already explained that only P5_PLUS supports MPC.

Patch #11:
Defer the MPC ring reset to bnxt_sp_task() just like other resets to
avoid any possibility od deadlock.

Add more comments to explain the MPC ring disable, stop, start.

Patch #12:
The bnxt_drv_busy() is the existing driver scheme to wait for activities
to stop during shutdown.

Patch #13:
The kTLS software counters match the other driver software counters
using plain u64.  We can add u64_stats_sync for 32-bit systems but it
makes more sense to add it to all the existing counters as well.

Use BNXT_NO_FW_ACCESS() to fix possible massive AER timeout.

Patch #15:
Use bool instead of bit fields to keep track of kTLS states (requested by
Paolo).

v4:
https://lore.kernel.org/netdev/20260629184921.3496727-1-michael.chan@broadcom.com/

Fix kerneldoc prototype warning and uninitialized variable warnings reported
by Jakub.

Fix most valid Sashiko reported issues.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-1-michael.chan@broadcom.com/

Fix most AI reported issues from Jakub.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-1-michael.chan@broadcom.com/

Fix unused variable compile warnings in patch 10 and 12 by reorganizing
the patches (reported by Jakub)

Fix some error recovery issues in patch 12

v1:
https://lore.kernel.org/netdev/20260504235836.3019499-1-michael.chan@broadcom.com/

Michael Chan (15):
  bnxt_en: Add Midpath channel information
  bnxt_en: Account for the MPC TX and CP rings
  bnxt_en: Set default MPC ring count
  bnxt_en: Rename xdp_tx_lock to tx_lock
  bnxt_en: Allocate and free MPC software structures
  bnxt_en: Allocate and free MPC channels from firmware
  bnxt_en: Allocate crypto structure and backing store
  bnxt_en: Reserve crypto RX and TX key contexts on a PF
  bnxt_en: Add infrastructure for crypto key context IDs
  bnxt_en: Add MPC transmit and completion functions
  bnxt_en: Add crypto MPC transmit/completion infrastructure
  bnxt_en: Support kTLS TX offload by implementing .tls_dev_add/del()
  bnxt_en: Implement kTLS TX normal path
  bnxt_en: Add support for inline transmit BDs
  bnxt_en: Add kTLS retransmission support

 drivers/net/ethernet/broadcom/Kconfig         |   9 +
 drivers/net/ethernet/broadcom/bnxt/Makefile   |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 303 +++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  96 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 618 ++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 230 +++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  61 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 578 +++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    | 174 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 795 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 232 +++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   8 +-
 include/linux/bnxt/hsi.h                      |  37 +
 15 files changed, 3083 insertions(+), 67 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h

-- 
2.51.0

