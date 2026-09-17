Received: from mail-oa2-f27.google.com (mail-oa2-f27.google.com [74.125.231.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988474A483C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685094; cv=none; b=JL9araPA7Jl179uxhPAkq8ziubjfQh5UXJgFOpL17CtzPNChi3TvDlDhco8mAeth4MqvB3/TkicG9vZKVLpZhSAPahEhOWrmkavu5/yVM93LI9p3JBwOy1j/7R5fNOKDHHuQeCD4U3ZeO+phi4nfd8sLMTe2H6s7+GWOwii6hCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685094; c=relaxed/simple;
	bh=lg80XsveI+b0werII9zNMwf8lTKT3Dan9hwjbu6R0m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMBd2fvVfM8fudHtyBhh4As8cQLwpYyFa2Gmn112GUT2BVPbmCWFre8Co+fBi+oaQkeDtxKUiMLhdaR8FjxVx+jF/yscF7HDA52YArA+YK1eVw1+XWGhjcUAwXC267Hs+/+GplqhCOVGu52vQVKpbjUA/eScgkwIbuiX8CmHv98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GFycucjN; arc=none smtp.client-ip=74.125.231.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GFycucjN"
Received: by mail-oa2-f27.google.com with SMTP id 586e51a60fabf-466ccdd77e3so107834fac.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685090; x=1790289890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PtleBh9YPOE+9ANKYZDjPF2NPxsbQHvGvr7Qw3x24r8=;
        b=GFycucjNbLYo8KZz+o7eiN3am73KzIBWQ51ougntnpxwQzrqVoffAlaF2wCJBSPqiq
         kbci97T+rWJj99/sfWQSrgxt8/TFWRUl6aFsNd1nnGCfIZg4+Hcy7zl6zoqRQmj+cyZ9
         gWJ3pwUlNn6k2j6iaHL29XeuCoqIUrKiAth3fSyK6GTHQpCzbe7S0FcVddTwYEOg9Cjl
         1LBuu9CPA7rX5yJLXLsRE3B/4x5AAM1DqIEN7Opcli4X1KdEFeNIMKIu6cEb8Ps+0iOY
         dzOYfZLOM/ByYoY2HhvobDjavNUszMLIuB2joCl0Ys/tzh5o9+6th2tagJPgwqAHO/G1
         2/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685090; x=1790289890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PtleBh9YPOE+9ANKYZDjPF2NPxsbQHvGvr7Qw3x24r8=;
        b=Z2l2nWXWmL6wo2nMmGTtbIrNvzRvLCDIHKnPuw6ddAQQTonbo+YS9p+ANjfVjwkwtV
         NqFNgoElhBO+ej0c3CTpDhPq9/WHsSihsyKyOW2pvwb7qIytgwtQ/QMGKO0eJC+LHOuz
         kurlEHcpJRYbKsz1q0NBHQFBuUKpHFHm9RTA9F3P6dTB4ddDqgz3c5UjVk7ux0+YLh6E
         5A3DggUHkcesaorqH5F0pEPQLE7Loc8JMD7fkSP/b015+C7H0Yyt+1YfZ/7p/5eqaJQD
         lpcx1LaA8LVZ0dLlUA++UnLbBo+v+hEQdIoA7hF4Bh34xdVZMb31nRw8LL1mSLTb7RPr
         RYpw==
X-Gm-Message-State: AFuF++l8csh4hz4Apctm8s68sLL8WBXpZ5+eUsQGAI2MDA+ZVn9XOdqH
	othUGz7zVXjLkbUDuuaJR2JFyYcwc7yrAXl2IW2R4Q2XUPkR+4lJ39xQevgSYVfhcgzpM8l7O98
	WiAcPNSbg9tofm0ptYfAXQDjVXSrivfjVtTUbP56YhWMCb8BDAwJeFrkrkb5CPorzdJxuT8WDjC
	Y8fCjcFNuSZ1ODhbacnKnIvcW6PSxPFoEIz9/8tT5bE/NjhZk=
X-Gm-Gg: AYBFou26Iya0tm6e448IcixpEu0qkmTM+z2YocywB4VMYUkHSw2o3OQ8M0fbfZDufim
	qAEiTkibZroR/m4MA/ZKBdjO89AYgDPMRoNSou2crQ6mTWo3OwrdVoGZdS+ZDy7dNSDPY3UOeIC
	IWYOC3x8DTMt8196sUNKOp42NvHWvR5cIfbFv5ic8UC7G14A+VQd1eC4ZLX3i8+2ehYLya2mliJ
	e9UMKTyRyBflDuozNyLM/Lm4SBjoM5X/0Uyex9FmD0DuM8D8wbZevgemwCfeApytFW7xwyJS0i2
	VEdCk0S8SXan/oalD7AvQ8eSoszV/F+xoyAFvpvlM+9LEzNhXYjGS8doPdThg2r4EjlgpfAKq2l
	tRPQ9CwK5MFIRsZS9TxkbO3MQWb7UJxCC2RD6d4BbQ9xml964l8Qqg1lwSaoPjoDdcbDVFAKQzC
	K7gBy5oRjBF7LWfwW94bcsEtfyO0v7nKnEB/+SIkZu2ve2pBwhWHpb2cy6IRq4g1V7zcWHv7F1T
	fI2UxeG+zAxFSxZuynN4jtizP3KwENOF7Sp7eOMczKemwqIoAtbM36UW6tFJ1h2ei6N/2T9IaC1
	N3sr9WrWRIDQn6AA8oSuncyyTOMS4hqwxVfNJ5xeRAX9pns23U1F5Bh6PxUBHi8hSyryb7Utr54
	9I0bekIv6we7z5zKdzg==
X-Received: by 2002:a05:6870:15d0:b0:486:a82a:a345 with SMTP id 586e51a60fabf-486e6eee643mr589805fac.25.1789685090120;
        Thu, 17 Sep 2026 15:44:50 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:44:49 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net-next v17 00/15] tls: Add TLS 1.3 hardware offload support
Date: Thu, 17 Sep 2026 16:35:11 -0600
Message-ID: <20260917224355.2288021-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

  This series adds TLS 1.3 hardware offload support including KeyUpdate
  (rekey) and a selftest for validation.

Changes in v17:
  - Addressed review comments

Rishikesh Jethwani (15):
  net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
  net/mlx5e: add TLS 1.3 hardware offload support
  tls: reject rekey attempts on an existing HW-offloaded connection
  tls: add TLS 1.3 hardware offload support
  tls: split tls_set_sw_offload into init and finalize stages
  tls: prep helpers and refactors for HW offload KeyUpdate
  net: sched: re-validate parked decrypted skbs on requeue
  tcp: fence collapse against rtx-queue tail when write queue is empty
  net: skbuff: add skb->decrypt_failed bit
  net/mlx5e: flag TLS RX records that failed device decryption
  tls: device: add TX KeyUpdate support
  tls: device: add RX KeyUpdate support
  tls: device: add tracepoints for the KeyUpdate path
  selftests: net: add TLS hardware offload test
  tls: document TLS 1.3 hardware offload rekey handling

 Documentation/networking/tls-offload.rst      |  175 ++-
 Documentation/networking/tls.rst              |   17 +
 MAINTAINERS                                   |    2 +
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |    3 +
 .../mellanox/mlx5/core/en_accel/ktls.h        |    8 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |   13 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |   14 +-
 .../net/ethernet/netronome/nfp/crypto/tls.c   |    3 +
 include/linux/skbuff.h                        |    6 +
 include/net/tcp.h                             |    9 +
 include/net/tls.h                             |  149 +-
 include/uapi/linux/snmp.h                     |    6 +
 net/sched/sch_generic.c                       |    9 +
 net/tls/tls.h                                 |   32 +-
 net/tls/tls_device.c                          | 1381 +++++++++++++++--
 net/tls/tls_device_fallback.c                 |  186 ++-
 net/tls/tls_main.c                            |   87 +-
 net/tls/tls_proc.c                            |    6 +
 net/tls/tls_sw.c                              |  191 ++-
 net/tls/trace.h                               |  118 ++
 .../selftests/drivers/net/hw/.gitignore       |    1 +
 .../testing/selftests/drivers/net/hw/Makefile |    2 +
 tools/testing/selftests/drivers/net/hw/config |    2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 1132 ++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          |  446 ++++++
 25 files changed, 3735 insertions(+), 263 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.50.1

