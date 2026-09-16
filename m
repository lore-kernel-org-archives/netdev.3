Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB04B1CF1
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587483; cv=none; b=rPNraRQynRfcsT7aEQJG/17p9vloCCsdBlmTx9T8P5W54LneOu1lzWX/v1o/ussErQdzWVAiaP9t0Pye+uAiFDsXesIn0LwpV1PsmOhUTp4U0dRuNDx1/mBfOsRK8D4giIpkWoF4Ghe2yjcQHLdcBrOaYv2O/ERib7sI5/HkEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587483; c=relaxed/simple;
	bh=xIwpfm8VTXjD9mxcmYetWibD+Vq3tfuKIISgNvzmQgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTu5JLwmHl471IMP34sznCK4BmE2DJybGWkqAp3PIj1JYdO2S5LISf9mXO7g+kLUJ+5cfYsjowoG0i9rnLUVdin3ipRS6dHMedGwNjcX8omoAZIeUzrC0op4oIloZCHHUqxSyqyzbyWnvj6r3TDvWH5YQ/YM5jfgNJswcru/kRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XynCRzPV; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XynCRzPV"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so60627f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789587455; x=1790192255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D0n830f4yHIFKvE0dFIrH59B5oDR//G+OUOkS5B34Js=;
        b=XynCRzPV+8dtH6L7M1hJY9WIjiRzRCtf860/mPjpA/8c6b+2VqFR5CUtUi78ND617b
         yWetjAcAxmWwy774tiV2IaHg9W0mcXGKZyJ7J2QmSCt/OoUpierJ+DJ9hih1qBTbMZPu
         ibR5AGPwZJnk0DclwSfhrihIog6pyunAP7eQYt91gxxgxlUtwOtLAPMhXRmqFw47MR69
         oIbT7o0VXXOT8Ifq8V5BZjzpEglWsZ3ahgyp2gvg1y2zCxzzpAAEyGLY/1Wvm6WiJvcA
         aeH4xEXpzDOa7YwG+jBjDEJpbWUTRwrDMSiJnipB+AZvN9T4JSijnpFVaPk66r/UTwIq
         /ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789587455; x=1790192255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0n830f4yHIFKvE0dFIrH59B5oDR//G+OUOkS5B34Js=;
        b=WheAxTgciuZ1yuP4JVL83xnn2Xon1i4WhQQWXsite+yw//SEFKjJFZPytHjphnFAdJ
         6hW83PeMUQCxyQG732+DfUfaDK40xRad4682xcGHIJ9zz+PQZ0HdcaEClKuuUyJ8qvb/
         1mROmPx+7orHZiywqDcQkhza4+k0AvpUUNAlT1Bl5aHPGWHXsAts6/C9fQ+row1Uuiy9
         Mxcr5egVBwkLzVvOwgYj1B6FgBrkKDA8MVGUOBpPKX1TF8mZkdxXytjdCwdVX0hXb5jV
         3WooVDpI0txXxGOh+tubwDe90SqYPr4ylpQ5837wj8GQN/1pD5fVCt7CqqmAc1xIYDtO
         2WBA==
X-Gm-Message-State: AFuF++le8Sr3NdAOSU65NoLL2PMRA3q1/NACYM4N4+wV0V8Z9IU2sojA
	ZjpJMWNlG1muTooFv5CnD9s5USClch1fxtzhMwZ1I/o/vtxevR3msoNCFOtlLpvwh7Y=
X-Gm-Gg: AYBFou1VQNwvIvw5ArpWIroKyrmvMHODexgaEjq9SFRTk2odGQ8KDhSN7tTPf2zSJKz
	Q3vo6Ei4QbzFuj02q4+gYvFXA10c4qGwq2H0lC/PgL7AJLY39uX+i8GT/cTYXtvQSZK2BZA9FKX
	Ylu/AJohmIx2gBgBgmgPEZazGTyO+xirdFrGCkDNDtUOvshA/kOVC9aAG5kVecHofGfx/5FifMb
	CKeCf8yq1yoc6nEfTT047z5Hq3ILQw2t+UM7ed7bxMt3zQ+oowtkR8xHJ4pImtNBwhvwrpdhqvb
	f2k8YC/7X3P3St+SEOu7MaBBPsuM76lZLOAeW7/V9EEwb1G26XG2b5VoAT3KhVT+s1plMnNXiV1
	uMFARhXtpj46aDuVH5Ceo708Y9bojwhyZ5fP/PRFT+fpXe2xnmfEg1axtJTkrF0eYW7bfyODVHD
	RAwk4FKDVMqbtJty/Kek2ONHeNek2isO1c87BBWvyjT3BaRBwIOUo7ByoKj/E82Z0=
X-Received: by 2002:a05:600c:8b78:b0:49c:e42b:a4ac with SMTP id 5b1f17b1804b1-49eafe94883mr47066805e9.11.1789587455337;
        Wed, 16 Sep 2026 12:37:35 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23ac75sm12936105e9.13.2026.09.16.12.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:37:34 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	roopa@nvidia.com,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net-next v2 0/5] vxlan: vnifilter: bound one request and account per-VNI memory
Date: Wed, 16 Sep 2026 22:34:44 +0300
Message-ID: <20260916193449.2552039-1-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VNI filter interface accepts a START/END range with no bound on
either endpoint and no bound on the total a single message may ask for,
and the memory it allocates per VNI is not charged to the caller's
cgroup.

Patches 1 and 2 bound the request. The first range-validates both
endpoints against the 24-bit VNI space, which also removes a loop whose
counter is signed while the bound it is compared against is not. The
second caps the total number of VNIs one message may span at 4096,
summed across every VXLAN_VNIFILTER_ENTRY rather than per entry, since
a message may carry any number of entries. Neither bounds how many VNIs
a device may hold.

Patch 3 makes netdev_alloc_pcpu_stats() use GFP_KERNEL_ACCOUNT, as
suggested on v1; it affects 34 call sites in 25 files, all of which
already handle a NULL return. Patch 4 accounts the VNI node itself.
Patch 5 adds selftests for the new limits.

v2:
 - target net-next, drop the Fixes tags, and post as a new thread, per
   review of v1
 - split the range validation out of the cap into its own patch
 - cap the per-message total instead of the per-entry span
 - account in netdev_alloc_pcpu_stats() rather than at the call site
 - trim the changelogs

v1: https://lore.kernel.org/netdev/20260909092645.3105263-1-alishmery18@gmail.com/

Ali Firas (5):
  vxlan: vnifilter: reject VNIs outside the 24-bit space
  vxlan: vnifilter: bound the number of VNIs one request may touch
  net: account per-CPU netdev stats to memcg
  vxlan: vnifilter: account the VNI node to memcg
  selftests: net: test the vxlan vnifilter VNI limit

 drivers/net/vxlan/vxlan_vnifilter.c           | 103 ++++++++++++++++--
 include/linux/netdevice.h                     |   2 +-
 .../selftests/net/test_vxlan_vnifiltering.sh  |  34 ++++++
 3 files changed, 126 insertions(+), 13 deletions(-)

-- 
2.53.0

