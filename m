Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5347F779
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058961; cv=none; b=DeIQxJnfY/1IxjtDuSEHvugoPae1LlLWgw1vnyCvNkmGnd1J9cyWYuTA7uCFrLZev8i3mBC6kit6ZJ/kLrxOgDsfX6W91j6CSOchnmLEvqsf4bNNTOzAKD3hGJhNih+ccMD62qjeCc0quk+xAz98oBjTn157bHNb9IyjWvvV/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058961; c=relaxed/simple;
	bh=Lsuyvz0i8teSK+SU9jAmLPa3srAaxxa4/0EzJ7Ft1iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBgQ0ym2/Yu+hrPIeizj1YwDgTY4JNSgHGSkqpwXK886NrP+OnJhWTQ0SqFgG5149PjuZAAkZd3fDIHpphyz2mcaEhDfw13S8OsicMhxTetndWQ5ElcN2g8NtD4xCE5HbBCxQnf64TK+Rl7iH/Xt23Ygyt9Xgs4dA+cUrtwVgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfWwTt1D; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfWwTt1D"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-664db84f074so3856355d50.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 16:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786058959; x=1786663759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fsRb4NZXZerz1/aQRrjBTBFx3aPjqVLYX2/AtW7Pc8c=;
        b=ZfWwTt1DbZz5YcdvYg/sB9uQwXIsu9fSSXByEGhpxdLc/lBlC7ECxvjMQnUqCuLU/T
         R1BuyUdxkKl7j5L+XAKb1UYXmSuIO5VKGuXUT1C+gEdMXzYA5Zp5N23fE0egdVjVine3
         S8/O+M/H8Gwk8w9Ikpb41RXL2viYlfK7fKFSWWIWM9hWn/ahysQXEwbwPKccLZFNGl31
         FhBcQPszNkk66Akzl8g8asRwYaSJ79cJlaWRRJZYiRC7IKwE1OVGpt8L6L7cveHT22cg
         GR0ygJ9tOFcCDswYSLOcsiSqqJM7m8NvEWtqK+g0K+s4t0m6tJLgEflIEINvR6mE58JL
         rhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786058959; x=1786663759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsRb4NZXZerz1/aQRrjBTBFx3aPjqVLYX2/AtW7Pc8c=;
        b=LO/HImbxt7ZFwDK80p3CLr0WmIHYwPeQJyG9hyssuPYTPGkv376c6+QdubMSWOEQ2P
         7sYvr5mwWVSvVzvK12Pa8kSB33ycunKUsuO/ro0g9vLPunG+uaHeekJz+bf9uaEPAjCP
         sLAtMWP+VzcySwKjxXReedNq5HxtXKkeStcEnupQo2MJyDk3gODrpDuaQ0ROuKyqMrGE
         BheVe4EmgMOmof2OM2j9pM9jPlcuxUOi2Ym2qOUsbzoqFR+w+83hdTMSmfHmJfBkS4c8
         XxD++fWc3Nb5k2W2YRFrPIUNfYKYLw8ofKROBn+btzbhWXtk8Wvn6JlW811h/HLBU+ol
         dK+g==
X-Gm-Message-State: AOJu0YyTztULZeHBP9x7s0Xwl1WqF+J6p1uiTsZAiAG+fIUuyo+XrT0T
	V99nn54EPPqSwke/N5QU+kvhkdDfsgYe+ZmhGWfR87ykemETAFvyYCnR2jcGhw==
X-Gm-Gg: AR+sD13DlsPTQ5O1JPyCzDTz82UwIxyzIk13teSrlgxd6q+OKZFhAJClo+7zdxkvHdt
	ex9H0s8FZAvm8TQ/+ULJdenqOypZOMF68V1WmAzo2HQM0WrQAIvxEvICFsLvO+wu55s8mF/8V7K
	lERQ7cdKbWD9o2uvANPU0V7hXjvG1cwlZtFBZz0L47Ic2FEWQ8rxZSn64Vn0EDMDq7mZq7Z++jS
	GAVy2Cf+yXn2GwXsBFS1LWj0dhtPMwi/35WdE6H9lhJtLpG7yO/PEHJGBvdE87AsqumBlM4UsCM
	1uIiX6OaUNhmsElJwRL2xfgnMb/N+oit/fgds/cEQPF7/ErheTVvcRny2LpLLzPBHvJWYMWzYPG
	PMU5+bemywaXM9Kyqtjv5nKUsfx6rgfmeBVdahW3IITR4gVzT45PqApLk6OUQkwV17GFwFCvgPb
	xa0buxB+mVuFZiy7Biw46mDv8GtGWC7Y/qujVhVajm5+zM8pWjdukiJx+bCE0XDv24YahUYWHUh
	qqgx01cUcVOFWn+HfJNJzYJw7BcUtYY3y7buhlj7ASpwvhjzxe+jYG/rbQWSISpquyV5g==
X-Received: by 2002:a05:690e:43da:b0:665:a0c:6595 with SMTP id 956f58d0204a3-6699abb1fd7mr9337721d50.54.1786058959039;
        Thu, 06 Aug 2026 16:29:19 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:29:18 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	przemyslaw.kitszel@intel.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 0/6] hardware pacing offload
Date: Thu,  6 Aug 2026 19:25:57 -0400
Message-ID: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Enable safe hardware pacing offload on a first device (idpf), plus support.

- Add rtnetlink support for admin control over the device feature
- Add device support to the idpf driver

Besides the main feature, also

- Small optimization to FQ offload: avoid unnecessary ktime_.._get().
- Expand so_txtime drv-net test with hw offload testcases.
- Expand pktgen with txtime feature.

Details and detailed changelog in the individual patches.

High level changes:
  v3 -> v4
    - Replace ethtool API with rtnetlink
    - Drop/defer pktgen patch: not essential

NOTE: the idpf patch will have a minor merge conflict with commit
"idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc"
(https://lore.kernel.org/netdev/20260803210707.1912217-1-willemdebruijn.kernel@gmail.com/).
I expect that this series will need another revision, at which point
that fix will have made its way to net-next. There is also a fix to
so_txtime.py outstanding, but that is structured so that these do not
conflict.

v3: https://lore.kernel.org/netdev/20260726202902.760552-1-willemdebruijn.kernel@gmail.com/
v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (6):
  net: rtnetlink: add pacing_offload_horizon attribute to net_device
  net_sched: sch_fq: clear past skb->tstamp if offloading pacing
  idpf: support pacing offload
  selftests: drv-net: refactor so_txtime errqueue handling
  selftests: drv-net: in so_txtime tell apart sw from hw pacing
  selftests: drv-net: extend so_txtime with hw offload

 Documentation/netlink/specs/rt-link.yaml      |   6 +
 .../networking/net_cachelines/net_device.rst  |   3 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |   1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   3 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  70 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  56 ++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  10 ++
 include/linux/netdevice.h                     |   4 +-
 include/linux/skbuff.h                        |  17 +-
 include/uapi/linux/if_link.h                  |   1 +
 net/core/rtnetlink.c                          |  21 +++
 net/sched/sch_fq.c                            |  19 ++-
 .../testing/selftests/drivers/net/so_txtime.c | 157 +++++++++++++-----
 .../selftests/drivers/net/so_txtime.py        |  75 ++++++++-
 15 files changed, 385 insertions(+), 60 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

