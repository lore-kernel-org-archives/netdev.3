Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D54E9C38
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675548; cv=none; b=YliijrfkShyCfp0hzR2zQX5lTFEA9yKDiuygBMpPrkGC6/q1Q6zLfwyiANnJxxW3A6TE21XyrqIxKJnsNnEXSyt+zifr6v50nRmij8ank4FZ2LpAYujckpoDrAhxO1oFDPsH2mcJqd+3fqhNeNTvb1ELOpQUQDIvHzYKzDGmPuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675548; c=relaxed/simple;
	bh=TfV+HzMprhU6jbU1gfZFGIyIbcZzWDRJ1Tg3asNbQ4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVPhf8SPwVTTJTAoLasaH/4Pqfwl1+h9INvlrvRoduv/TBJbwH5hp69JzA6yLYVQ1RQRbP+ejvB+2w2BRwafNgzYK4AhhUDSo7QxpyceAux9g9jIUAF6VUVAT5AnAgl/UH4ggimTKabP69B/WBE8FKk2Ukl7UmL/MM7PEWuhsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whp1GkD5; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whp1GkD5"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-804e42309a5so500864a34.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675545; x=1790280345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LeldsrpJvM3CO1gHOjVnfm+w/hXn4RvNV1+Jm/71EHo=;
        b=Whp1GkD55v1SecmjapKPehb65JbhFgZad4jZFP2Jmiv3XvQK0aNoUYQTCMJ2L4aIdI
         PEfS1KfoeHtUm23Ir99vEVsZoBDQeYhwcTCfSvxGbXqkFJq0y61WCUT7X0/1UJa1LA9e
         iXSXHu/PEKyE10/BphOxoUCX0Z+cpUcNSj3v4TuVtkbMHTH7jiNHOI4CXPsWxRSzSyUs
         hdTMim0lo9Luj94ZMOBAjfjfOtJKpY450v1T0hEIhe29m6QzsZFWXaapOL3yirYZhppx
         uqNqdh633CsH2HQ6W14A9YU4PWfv7lCx7JlA1yWuwe0FbH43MoyYM/ww9MhZgABMsXXi
         jRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675545; x=1790280345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LeldsrpJvM3CO1gHOjVnfm+w/hXn4RvNV1+Jm/71EHo=;
        b=MieAB5Z/ALCB9L8m4aDf/WW8DDBEZTesMQ+jH+xGe5DLhpmqohFH2EnvmnfjZSSiDj
         8muxvKoUWV1cL92o9CupHJEa/LZZtokDVBMfvU+nggs/DmVMHiHXeCp6lM2ERAOSYyIS
         tCB7f5HczeUB58Owq4maLGiwu1zm7flqYVVJvymYVDgO8TzGkObNFJjcZDqE91Rpbp33
         wtXUu14sJ3ubjD8OvMWesiJ7AvbgxAmg0Q6Z08oNrzm5y84/NwXWU6oymz1aGjxxASEk
         TthtV8EQO1JmKPE6BDQewWw+FdKEu9BvhyYgvRwhthLvm/1tW9aLhaYX9TZY8BkNJAot
         tLbQ==
X-Gm-Message-State: AFuF++mjTymZvZlrROT3b5duAUMmhbMMUAqJAtCVfD6mEihAjXlROs2S
	UFaA77q5IIqWt1JktJ3wYsvlDX1GOmVQP7Ieq5ILwnWYzOuo2j4uyeGr
X-Gm-Gg: AYBFou1xOPg6P1ldX7au9BY0nd6g4an2la7zdJueLyYWES1M2gg2X1LU8WuKip/F3Dy
	B+lNu3qCGx3SKlTfrwiWhwvvg4VtYrvefC/ybi1/AaeBfloLIt1Fu/p+RiLdKdEgMFCIqCs97ug
	BVNyW4ycqIi+sEevZLrDEG68bNqkVzK19eMy64D2jPvEA1k1apV8DXi4zgD//7oFOvdurbVB7lW
	0oMio2PNJ4CIvrzraWQlzBSySZSdZ9/uCTKmbMMan0DzXrduiSGTEk/m65QOAl6QmmTeQwnMdzL
	IeFwjheMJ97aeduNhNU4lG/h3haH6UfjfdW9Vgi2fL2RazWI4FSAuled0oZzqEDuKi+KZEMowZJ
	7NDNjYRIAYSG8lLOTy1m9M8V8OH5eHkVhLNlCIchW5qXIzj+5eti9BGaA1QYVQBeeEO+5zFDeNf
	km6y86JSsk1Y9yh/WfH8NjgmLaPc7vfA016NdlmRMQBPO7TCfaXjdSxwllCcUTBA==
X-Received: by 2002:a05:6830:412a:b0:801:6bec:ff18 with SMTP id 46e09a7af769-80ddfd6c36fmr282158a34.2.1789675544456;
        Thu, 17 Sep 2026 13:05:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c477cc3d3sm3957790a34.27.2026.09.17.13.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:05:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 00/15] bpf: A common way to attach struct_ops to a cgroup
Date: Thu, 17 Sep 2026 13:05:26 -0700
Message-ID: <20260917200542.3689605-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I am continuing Martin's work to support attaching struct_ops to cgroup.

At LSF/MM/BPF 2025, Martin presented [1] the need for a new interface
to extend tcp_sock operations instead of adding more BPF_SOCK_OPS_*CB
enum values. The need for predictable ordering when attaching struct_ops
to a cgroup was also briefly discussed.

At LSF/MM/BPF 2026, additional use cases were raised, in particular
OOM and memcg use cases that also need to attach struct_ops to a
cgroup.

BPF already has a common bpf_link-based API for attaching different
BPF program types to a cgroup. It provides common attach, detach,
update, ordering, and query semantics across those program types.

This series extends the same model to struct_ops. Conceptually,
struct_ops is a group of BPF programs, so using similar
attachment/detachment/update/query APIs and ordering semantics for
cgroup attachment keeps the interface consistent with existing cgroup
BPF links.

This series uses a new struct bpf_tcp_ops as the first user. The
struct_ops mirrors the TCP-related sockops hooks except
BPF_SOCK_OPS_NEEDS_ECN and BPF_SOCK_OPS_BASE_RTT, which are
intentionally left out.

The selftests cover attach, query, update, ordering, before/after
placement, retval chaining, the header option hooks, and inheritance
across a multi-level cgroup hierarchy.

The map_free_pre_rcu addition in patch 2 is not very ideal; it will
need some thought too.

[1] page 13: https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view?usp=sharing


Changelog

v3 -> v4
  - Rebase onto the latest bpf-next
  - Add Reviewed-by tags from Emil
  - Fix minor styling issues
  - Patch 9: Consolidate per-attach-type struct_ops metadata, document
    the RCU lifetime, simplify map-link auto-detach, factor out the
    struct_ops list-entry check, and validate that detached links exist
  - Patch 12: Keep the legacy WRITE_HDR_OPT callback gated by its
    opt-in flag, initialize bpf_opt_len for tcp_current_mss(), use
    ARG_MEM_SIZE for header-option buffers, and clean up comments

v2 -> v3
  - Patch 3: Remove redundant bpf_struct_ops_kdata_map_id (Sashiko)
  - Patch 11: Reject sleepable programs (Sashiko)
  - Patch 12: Silence warning when casting ctx to arg pointer
  - Patch 13: Fix incorrect libbpf API addition (Andrii)
  - Patch 14: Fix selftest cgroup cleanup (Sashiko)
  - Patch 15: Use network_helpers.c

RFC v1 -> v2
  - Fix UAF of cfi_stubs
  - Fix retval: use bpf_tramp_run_ctx instead of bpf_cg_run_ctx and
    expose bpf_get_retval() to bpf_tcp_ops
  - Add selftests
    - struct_ops cgroup attachment
      - Test bpf_get_retval()
      - Test before/after order
      - Test cgroup hierarchy and inheritance
    - Test TCP header option hooks and helpers
  - Move bpf_tcp_ops out of legacy BPF_SOCK_OPS_TEST_FLAG guard
  - Complete bpf_tcp_ops (make it comparable to legacy sockops tcp)

---

Amery Hung (4):
  bpf: Allow all struct_ops to use bpf_dynptr_from_skb()
  bpf: tcp: Support selected sock_ops callbacks as struct_ops
  bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops
  selftests/bpf: Add test for bpf_tcp_ops header option hooks

Martin KaFai Lau (11):
  bpf: Remove __rcu tagging in st_link->map
  bpf: Make struct_ops tasks_rcu grace period optional
  bpf: Add bpf_struct_ops accessor helpers
  bpf: Remove unnecessary prog_list_prog() check
  bpf: Replace prog_list_prog() check with direct pl->prog and pl->link
    check
  bpf: Add prog_list_init_item(), prog_list_replace_item(), and
    prog_list_id()
  bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
  bpf: Add a few bpf_cgroup_array_* helper functions
  bpf: Add infrastructure to support attaching struct_ops to cgroups
  libbpf: Support attaching struct_ops to a cgroup
  selftests/bpf: Test attaching struct_ops to a cgroup

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/linux/bpf-cgroup.h                    |  28 +
 include/linux/bpf.h                           |  55 +-
 include/linux/filter.h                        |   5 +
 include/net/tcp.h                             | 156 ++++-
 include/uapi/linux/bpf.h                      |  39 +-
 kernel/bpf/bpf_struct_ops.c                   | 142 +++--
 kernel/bpf/btf.c                              |  31 +-
 kernel/bpf/cgroup.c                           | 484 ++++++++++++++-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/syscall.c                          |   4 +
 net/core/filter.c                             |  33 +-
 net/ipv4/Makefile                             |   1 +
 net/ipv4/af_inet.c                            |   1 +
 net/ipv4/bpf_tcp_ca.c                         |  16 +
 net/ipv4/bpf_tcp_ops.c                        | 326 ++++++++++
 net/ipv4/tcp.c                                |   1 +
 net/ipv4/tcp_input.c                          |  17 +
 net/ipv4/tcp_output.c                         |  98 ++-
 net/ipv4/tcp_timer.c                          |   1 +
 net/sched/bpf_qdisc.c                         |   2 -
 tools/include/uapi/linux/bpf.h                |  39 +-
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/bpf.h                           |   3 +-
 tools/lib/bpf/libbpf.c                        |  64 ++
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ops.c    | 560 ++++++++++++++++++
 .../bpf/prog_tests/bpf_tcp_ops_hdr.c          |  77 +++
 .../testing/selftests/bpf/progs/bpf_tcp_ops.c | 141 +++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     |  86 +++
 31 files changed, 2280 insertions(+), 142 deletions(-)
 create mode 100644 net/ipv4/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

-- 
2.52.0
