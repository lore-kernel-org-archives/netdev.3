Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA5437DEBF
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197679; cv=none; b=kZlMrvbkqm0LLRyoiXtbTd3T3O6+L5Fiv0KA61ue2TJhnHKK7MPw7mbBmGEil2vnjkiV+1SUH4Zd+Ba8tpQ4hajA1j+45yh1MRtzWFsjkB6Y2hrOL74oLXGfuhwxGSSfIiBQZecJk36JuiDuw+4Uqh8vBEckzqkcE/Zbo+5Bgn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197679; c=relaxed/simple;
	bh=mRyxy9kulrKLCctPR5R5jqjv4937c3fvzBlt5PNvMX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBh6/+DRov87qSv5rltG0S9ittv1/+jcFq5pjEFWyitzX+JWeBzBe7GX14WKBnTuvlddOTJ00BlVb3jBCgDb3qUfEvh17bwLr3W4buoltDp1A6P+ixY+Ycc4kkA9I8+hLZUpw3JtVR7iIgEBdQZmw0XJ3N4NfdFFtw/8mpZ9GUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=GF551xw1; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="GF551xw1"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86b90133ae8so788638b3a.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790197672; x=1790802472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2njhcgWsNI00xUbpMQlMbxUVBLgveQaLtiK1YPtxLMM=;
        b=GF551xw1Dr/rtgUJXu3UinEZYF4GzyVB7Cxg706GL75LEpXkuBFs1IUaslkT3RfqLV
         6mA3I+6vlCvNqMYvSv9xrmPhBr+EwwziFwz11bg0QOHhgzUiX5O2H41XVQCRfPfmgbFy
         KojIfPMLRFyvq99vhNMikysb2/41hP9KDNOwl3LmzsoI4uXw47bkMFB2o5CU63FJAQHV
         J+19dlOYWMG0tlLxMN2fy/nmeSNk/ZmZEL8OMclnu9HyWtzpk3xsrD2n47D57n0miSqb
         F1EIqt8pzVMFQe4btXnC2AcWb+RlEORzl7pwnjEd1jm6NF8JUoR3MIOWLV9ADZs2LmR9
         pGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197672; x=1790802472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2njhcgWsNI00xUbpMQlMbxUVBLgveQaLtiK1YPtxLMM=;
        b=VWGBBFUvnf8wOPwsC/gm0qpV1mvxugMo+xziKfwtloYoO3Rl7wo+xHY9SxnqEVxz/T
         fh65V619w3axNTMqmVSc/RgzGF38z+sxzWJdvRdKN+kdrD5LaM46AtkiiQKNd4dYr5xB
         LNt+FoDWYGakDihqdcQYXfwDFHYGT4wYdmRdvhMA4EDiv+Iei6zCcWfYlOiXWCW0yoo9
         XIGvgGZiaETepenGFUOOAUK40TMIPAAoKExHFR2KcjFwrsDVLsW7rbn/8huRnZdFICoJ
         DO/tBLgZk48O9yWNLWK7j0WwsFym2+CSDdBtBXeVnp1DJwcTdqidlAOu6a1sOUTszEMD
         zWmA==
X-Gm-Message-State: AFuF++kagrqUxtOHx3Jfab5yj+5RZQ1f9KUU/51fUWIhrjqT3d+gXYkJ
	GRVngxQWF5SIOxSOmqKRFfsGw3ECg3cLa2beRpo3rZAmrjx6b7y1CMf7F2pbanOhAbmDSeBN7K8
	p3BFa
X-Gm-Gg: AYBFou1sF1SR1Z/drRZPmAJdwHl/h9wJnmoeg9Bx9mQCKcpRW2KioI8z645G8qp6Nxx
	IozCep7CEd36F4WABb84UCreHLA3+Bc2fld9VBtowvCOFbNqE+5+90cjJneJFxKAO+QFeEQk8qf
	5XbR/1KRrYVlMlqYgXwE4mCYKOIHquuPTTZ5t6rnPLVbkAMoapoxq7u8f7y14Maks8ygZj1QFh1
	XI9t9NswROYrcujowN16+K42DP9wUjY2c5qVrDQvbEFHfBwL1ZfPYqgC2UROGLZdp4xmFC9rAiF
	x6ojCU405vxNdbSIQMwjXsM+dswI1k2Uha2mp9AHkJgn41XcKAvQP2LW2aY29k+MsWh465qsL0t
	HAAxyRCaKSSj+SjCZANnywk3lx1Xw+4LMw1OoDaCobKAnfP+Lq2wFVJZJ8GDWxXBfAlTUmh0WJN
	QghKpGyCCWGz1ZFm77/kUQc3GuzjPbHOIB+8h3ngzjKocsjWSXZbWfvyGBZdsP8UT5
X-Received: by 2002:a05:6a00:114c:b0:87a:346f:d060 with SMTP id d2e1a72fcca58-87e9ca1c0a8mr291890b3a.55.1790197672313;
        Wed, 23 Sep 2026 14:07:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1b0b55a3sm1867668b3a.3.2026.09.23.14.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:07:51 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net v3 0/3] bnxt_en: Make RING FREE more robust
Date: Wed, 23 Sep 2026 14:07:39 -0700
Message-ID: <20260923210744.3406861-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This is a follow up to the previous RFC (linked below), updated based on
feedback from Michael.

On two production systems, I saw the following dmesg pattern:

  NETDEV WATCHDOG: transmit queue 0 timed out 6073 ms
  Resp cmpl intr err msg: 0x51                  x20
  hwrm_ring_free type 1 failed                  x12
  hwrm_ring_free type 2 failed                  x8
  AMD-Vi: IO_PAGE_FAULT  x3

This suggests that, for some currently unknown reason, TX completions stall
and the netdev watchdog fires. The driver asks FW to free the rings, this
times out, but the driver ignores the possible failure and frees ring memory.
Since the FW didn't respond to the ring free command, it is possible that the
FW is still DMAing to the memory which was freed.

This series tries to prevent this by:

 - Returning and checking ring free command return values
 - Examining the FW response if the ring free command times out. It is
   possible that, for some reason, the FW did complete the ring free but was
   unable to respond with an IRQ. This seems unlikely given what appears to be
   a use after free in dmesg, but worth logging just in case.
 - Lastly, stop DMA before the driver frees ring memory, which should prevent
   any possible use after free.

Sending this as an RFC so that the Broadcom folks have some time to take a
look and test as needed.

Thanks,
Joe

v3:
  - No changes to patch 1
  - Patch 2: Don't poll for the valid bit as Michael suggested.
  - Patch 3: bnxt_hwrm_ring_free now returns -EIO instead of stopping the
    device, so the remaining resources can be freed and the remaining commands
    can be sent before stopping the device, as Michael suggested. Note the
    switch to using pci_clear_master in this patch instead of
    pci_disable_device. This was done so that the normal shutdown paths can
    call pci_disable_device without generating a warning.

v2: https://lore.kernel.org/netdev/20260922182405.1290749-1-joe@dama.to/
  - No changes to patch 1
  - Patch 2 from v1 dropped
  - Patch 2 in the v2 now checks the response and logs state before giving up
  - Patch 3 in the v2 disables the device to stop DMA before freeing ring
    memory

RFCv1: https://lore.kernel.org/netdev/20260917233218.1160001-1-joe@dama.to/

Joe Damato (3):
  bnxt_en: return the RING_FREE status to callers
  bnxt_en: check HWRM response if completion never arrives
  bnxt_en: stop DMA before releasing rings the firmware did not free

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 96 ++++++++++++-------
 .../net/ethernet/broadcom/bnxt/bnxt_hwrm.c    | 33 ++++++-
 2 files changed, 91 insertions(+), 38 deletions(-)


base-commit: 17741334d00bf5ebd37f8c1c36bc9c146a351deb
-- 
2.53.0-Meta

