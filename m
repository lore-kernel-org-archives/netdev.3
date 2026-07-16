Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561B423EA3
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208206; cv=none; b=urHkq+r7qO1AmoEQl4wcsR405K5d2X/rnRwDcSDbff33uBlZna61bpCcDm7ZSHKeoMSK7Y2LbsxA/hy4QSX5QyGShdp92+Txvb4TgzIqHaiViRKe/huhq90M0S3UFaxXLsKdgBhIW3Ij3wH/jboSS+MBfV3qQl7PpeFHmtOKDYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208206; c=relaxed/simple;
	bh=VH7ls6oS3JXo8rVW0MfQ99q9DKuXUysicTSoN/sq33g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5onHe+ELS1EVP2D0f6mCU//lVsBYsRihI9swgfQEFFD4TYUCiZTJZ3XfIOa4joNDiP8JIsp4GndTZsEtQtLL4uL5zBjIwrFXONuFJxqj2ppWtW6I1filH3HRdAwal7ry92jo0ogbkD6bC4hAJcuOrpZIwlDu0EOupq6z8I0LAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=w4Wah1Hw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="w4Wah1Hw"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so5857200f8f.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784208199; x=1784812999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D6Q0MKGqIF4orx9zGR7eUo6VhJ11Sr2evJgGoyQOE4c=;
        b=w4Wah1HwFUJorSFXv3gg4YZgAdiNC9roLfvlgy4YTTqOH41y/hQ4XEL819J8MUWew6
         /sc5kQWFhjiam0dK7CXBZ/pe7iBes5+nbIxw3iAPP9fGbXfmxZ/+7H/fWkeyY5wUlphM
         fh9TQz0cv+hvWepCwM+2Xn9f12GaVZLI9VgQDcsF+m++o7bknWdGfKKPcztMwHf2tLg/
         Zh2B1d2ThM/aHk6KQDM7ozY9WWGaUNPaNaPRuOFujd1B579X3Z2m2ridqIEgFFHJ2zlr
         eX2c8z+IdhAp8RnaHai7vfX+qGd2lkTWiLjZXtQn2X971CDPywXrhTmQfmGZ3pJKYhAw
         AUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208199; x=1784812999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6Q0MKGqIF4orx9zGR7eUo6VhJ11Sr2evJgGoyQOE4c=;
        b=P/gsBwZNJyQb7nlwd7Crs3YzPxffqAcXKDk51RWXx+GCOyYHmmefMmqYvrfUhfR7WS
         hmnc682qm1RFI+/mD/10uggmYAKmgnfJZPYlEHU4NJ5EhsIWGbqMXkpPpL0HAtDGguDE
         w2VKcCQ0a6hsD1onA5+ys0WVzq4vy6hq4RETPw/wD3v8nttjheX+ATzJHNkDHswsEgYS
         T58k7tqtrMBwAEHpWl10mUY7FujgeCrv5CwIP9Pfq7ZGodqPqdZAGmlf0gq7xqqgn5+M
         Vak2tEDDX8cRmiRCkUWWrZuRlHKdQxZ3fHI1Bfb4Rmel3Cv5tl6hwGyUVjpCZkM2N0q5
         qIxw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1tsYuun5MB2K3sfqQtAb4VxAazD73uPEu4dU8ywwDxPcFdEdoG68giL1HzRwsm4AQMRfSzLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygMjHScMHGND+WFr3sjBKQawJHoPmPvz3z6ZMyZBFIddnkUvQ/
	edpmKJ8mfJudrJAfwkEOZLVD+YfQ2JGLAjXGyx+RriAULzOLdj1BYvzVl68jdcGEAhk=
X-Gm-Gg: AfdE7cnmBy+CTSJpuda1yQc7qEWePdDwZJRhw+4vhGYWT4TOWN4xbVLNIZrgCJmAD4O
	RZjuQlPUBqvzMkiEy4PZv4ufBz9aAudAmPVUJ9ugR5YWPYwnbjSSoZ3h01rYz+zHkGtMVtSv/BA
	tSoFYNzgh1ubPqSPIIPEp5uVBVpaxEiC5VOQelTc53f37odg54HxgBgriO4VZvDNeR1oOKYN7fc
	d2oSOdSh1k9giAHGNrTl2dBZTlYSMTBtFf9pmionCtAB8GRV6+El+q9/bnF4pffDiN5J3YQCBMu
	Wp2DQwOOT1+hO5KcCIcGXoZK5wkOFFmYz9WNggq0ZigaVTZFGB6rMRGA/WD53gtWETnzVhcM84C
	2h2F9E6s8DGUCIBskB+2iimXAYX3VhxEbn4QDY4pxmLzA8KfwGSgi9jusiPjToqEFZsl3b+3bfv
	CiNeSO1ZpCBR6MIRzy+Jfh8g==
X-Received: by 2002:a05:6000:4b06:b0:460:2eee:4e21 with SMTP id ffacd0b85a97d-47f4fcd5592mr9318323f8f.17.1784208199021;
        Thu, 16 Jul 2026 06:23:19 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a9cesm24674591f8f.14.2026.07.16.06.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:23:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v3 00/14] RDMA: Make device names unique per net namespace
Date: Thu, 16 Jul 2026 15:23:01 +0200
Message-ID: <20260716132316.1495242-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

RDMA device names are unique system-wide today:
__ib_device_get_by_name() checks a requested name against every
registered device regardless of the network namespace it lives in.
A device in one network namespace therefore cannot use a name already
taken in another, even in exclusive netns mode (netns_mode=0) where
the two are otherwise isolated. Net devices have no such restriction -
their names only need to be unique within a network namespace.

This series makes RDMA device names unique per network namespace,
matching net device semantics, and adapts the users that assumed
system-wide unique names.

Scoping reuses the existing rdma_dev_access_netns() predicate, so
behavior only changes in exclusive mode:
  - shared mode (default): names stay unique system-wide, no change;
  - exclusive mode: names only need to be unique within a namespace;
  - CONFIG_NET_NS=n: everything is init_net, names stay system-wide
    unique.

There are two users that cannot be made per-namespace and are
documented as known limitations instead of changed:
  - the rdma_cm configfs tree: configfs has no network namespace
    support, so it cannot represent two same-named devices;
  - SELinux ibendport labelling: endports are labelled by (device
    name, port) from a global policy; distinguishing same-named
    devices would need net namespace support in the SELinux policy
    language and tooling.

Tested with the new rxe_netns_names kselftest added in the last patch.

Jiri Pirko (14):
  RDMA/core: Pass the net namespace to the device name lookups
  RDMA/core: Handle device name conflicts when changing net namespace
  RDMA/core: Support renaming a device when changing its net namespace
  RDMA/nldev: Report net namespace move errors through extack
  RDMA/nldev: Allow setting the device name while changing net namespace
  net/smc: Look up the pnetid ib device within the net namespace
  RDMA/srp: Make the SRP sysfs class net namespace aware
  RDMA/cgroup: Disambiguate devices across net namespaces
  RDMA/cma: Document that CM configfs cannot be net namespace scoped
  RDMA/core: Document the SELinux ibendport net namespace limitation
  RDMA/core: Make device names unique per net namespace
  RDMA/rxe: Allow queue VMAs to outlive ucontexts
  RDMA/rxe: Implement disassociate_ucontext callback
  RDMA/selftests: Add rxe_netns_names test

 Documentation/ABI/testing/configfs-rdma_cm    |   4 +
 Documentation/admin-guide/cgroup-v1/rdma.rst  |   8 +
 Documentation/admin-guide/cgroup-v2.rst       |  15 +-
 drivers/infiniband/core/cgroup.c              |   1 +
 drivers/infiniband/core/cma_configfs.c        |   4 +
 drivers/infiniband/core/core_priv.h           |   3 +-
 drivers/infiniband/core/device.c              | 245 +++++++++++--
 drivers/infiniband/core/nldev.c               |  26 +-
 drivers/infiniband/core/security.c            |   6 +
 drivers/infiniband/sw/rxe/rxe_mmap.c          |  35 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +
 drivers/infiniband/ulp/srp/ib_srp.c           |  16 +-
 include/linux/cgroup_rdma.h                   |   1 +
 include/uapi/rdma/rdma_netlink.h              |   5 +-
 kernel/cgroup/rdma.c                          |  71 +++-
 net/smc/smc_pnet.c                            |  20 +-
 tools/testing/selftests/rdma/Makefile         |   3 +-
 tools/testing/selftests/rdma/config           |   2 +
 .../testing/selftests/rdma/rxe_netns_names.sh | 334 ++++++++++++++++++
 19 files changed, 705 insertions(+), 99 deletions(-)
 create mode 100755 tools/testing/selftests/rdma/rxe_netns_names.sh

-- 
2.54.0

