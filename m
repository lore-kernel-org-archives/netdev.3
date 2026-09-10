Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3317489FAD
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048966; cv=none; b=BCahgCMLfuVQpgmPvH1YANg9CIXElwj5vDrH9/Ah890fm73bRo7eDqtC2vBy68/vtN1UMwtBy+8xjFJDcspP1+vT2A4yVqum7bheZUFV54L5ijPARjDnkXp3vOlfx9pgRGn80AQn808fhBST3RQMyFNt4iKZFiRtFoyzMkqmfO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048966; c=relaxed/simple;
	bh=AoTffK0RVfMhEWJqOE4dbqbkq21vbNmGEqhBV8DDP2A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EYJnL4jcySrmBvR6PbbdAVGnB4Nn5ZSCvg87vVIT82lyn+5cTzbndKOe6XET2S34Y/dqo8Qa4dQ1UQawmVUMDuuFAm1/CCf0IusUiC1tFhO0Pemp1N0PtM3E4mi3tCi3ZWRbOIBOc8hwFS6m0Qc41OiB0mlzZfgOBYa2pLJefS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JodYtPE6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JodYtPE6"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c294bdd76cdso131940266b.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048963; x=1789653763; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZzCWTwY8rHBsIIFWY/SX91KgLEXQq69JPWWLlcB9jtc=;
        b=JodYtPE6cIaALgHwud+t5DvyT3NAPGrDDZk4ZdbqB6XW9Yx85ncn9KZJceo6UQ49FD
         mcEqQiVzUGCp0ZgIH8QxpOvkhHYBB4Txk/oflF5kZniicWp4ZESilHtkNQ+a1hRqPIlO
         9Dxz3autJ++4rWPqgprMYI7EXrB3ql2DX0mmKLS4Gq8y5aLucBx9eHYTxnCEwMdNBf18
         hIS2NVPyz1wPXFPfHaBqQ9/2gTodJxynD8knrvo6zimE9+JtzUooB0XnR05a5E1G4S68
         FseZwaV1amNlqi4Oh+Q0UMyZfMK1axM07OQyN1apEKITf8tCHi91UM5UkzKA151VO+X2
         r8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048963; x=1789653763;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZzCWTwY8rHBsIIFWY/SX91KgLEXQq69JPWWLlcB9jtc=;
        b=TKktrnXt9UvjNobaDa6a3ISDFp/FS5/USnaNnuZ8PdMCTAwXy4v0jC2NsFfdoY8dK6
         gme9dxgT07v9awd8AFm5LxUAzzvl5lQJoVR+G83WUPdzs9Uf/8yQ80X8cx6K6+4elFLi
         RrrGfuoK0z7nb5MXxfWFwyVzfZ24zdti0Z/hQDweQIjC1sVLeZrvq5AmaRxd4gZDRag3
         m7RKH2p4U1bThxpRzPZiD7eIvCHxR55YUMIrtiyhuagiS7BAcYWzvaYgEsTKmWmQY82R
         p7lA2V4CVe0dVIzx/+EwJtudbe9ByaIlKqCITGThVMRIx957vrq/QXVec29oFc8b1Oqo
         oKAQ==
X-Gm-Message-State: AFuF++lqk4QJCtwgSya1ao5cVzC7/RoRTWeBdBC6lUxxTvWq0q26abR3
	Q2Ec6mKDWGJ2B11gpaut4h+OfDJSiSPhG0z31NLF/uR1/7Q5+IMddu7p4/QeZpXTUxk=
X-Gm-Gg: AYBFou2LvEbQNfs7x8nhbDSBh0Wh3ik1lEF+n/RNZZ8Glc9YE93NGMNNdukMC+6GPcZ
	jMoHOl+8GBBGzbulsDm4XsXwoV/jFhhmOJj6Y1vMnnU5tWtGRC2FjZ+FFNcrhjRIeEjQsBQJCWU
	XUSTNEwYUW09Gki/wf71cgj4j5/kHk+xFUxTFXVZESRiKEcomTBKm5KDCIr4V5Dt6tvAqyXxWei
	DlJch5tu+Lqz1usNtOuAPDyAXipF9pB2r5ycaM2zw70475wVnMGHcICnil5t9FymT2lHAU+wlFI
	qZ0bRG4YVbO8hP25resJfKmJmPFS5vLl4KSjnuGGocrwKLPHmDFgU6ApFpVoQpnbsV0TDibURhs
	fVY2dabRMO3gkfAw9p+2tezrOrU4bX2qY8vMXpndIjIcJBxj624THvBCJ5rC3C7lsJJP+tN+hP6
	6E/qP9cwVA/HlBu0AHLro4Eh546Cylk97nBmpQ5557aVR8rhGmYQJZ7K53/zU61dwiUp4Ox5utZ
	r05qg3D3ouK8uaLnyiTWCC2NuZiql6/5MerrwyRXSEDyguZ
X-Received: by 2002:a17:907:940b:b0:c26:1691:b366 with SMTP id a640c23a62f3a-c261691b9d4mr1613152666b.31.1789048962854;
        Thu, 10 Sep 2026 07:02:42 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5b371esm924512366b.54.2026.09.10.07.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:42 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next v2 00/14] skb extension for BPF metadata
Date: Thu, 10 Sep 2026 16:02:35 +0200
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHu4omoC/4WOQQ6CMBREr2K69htapa2uvIdhAe2vVKGQthAM4
 e5CXRrjcjIzb2YmAb3FQC67mXgcbbCdWwXb74iqS3dHsHrVhGWMZ5wdoeoNtBhLsC5YjRCeFeA
 UwRhG1ZlKlMqQtd17NHZK5BtxGMGtKVJ8nDBUD1RxA2/Z2obY+Vc6MdLUSHuCnn7ujRQyyKWgK
 hOl1JpfVdMN2jSlx4Pq2o2bIPIfRHCBWkvOeP4FKZZleQOPpjdbJAEAAA==
X-Change-ID: 20260623-bpf-meta-inside-skb-ext-ff21c918e8cf
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
X-Mailer: b4 0.16.0

This is the second spin of the per-packet metadata for BPF. See the RFC
cover letter for the full overview and motivation [1].

Since v1 the focus has been on getting skb scrubbing and extension sharing
right, driven by Sashiko's review:

1) skb scrubbing now simply deactivates all the extensions but the BPF
metadata. Made possible due to recent change in skb_ext_del semantics [2]
that already landed in net-next. Thanks to Florian and Paolo for guidance
on this.

2) Clones made by bpf_clone_redirect() share the extension block. A write
through a previously acquired writable dynptr would land in the shared
block and become visible to the clone, so v2 makes such writes fail until
the program re-acquires the dynptr with BPF_SKB_EXT_F_CREATE, which COWs
the block into a private writable copy.

3) Re-acquiring the extension with BPF_SKB_EXT_F_CREATE can COW and free
the old block, so a dynptr slice taken before that re-acquire would be left
pointing into freed memory. bpf_dynptr_from_skb_ext() is therefore marked
packet-changing, making the verifier invalidate such slices and forcing the
program to re-take them after the re-acquire.

4) Tracing and LSM programs can run on a shared skb concurrently on another
CPU, so creating the extension there would mutate skb->extensions without
synchronization. v2 rejects BPF_SKB_EXT_F_CREATE in these program types at
load time; read-only access remains available.

Regarding performance compared to consume_skb+kfree_skb tracepoints, I have
not yet re-run the experiment measuring the overhead when attaching
metadata to 5% instead of 1% of skbs in flight; happy to do so if it is a
blocker.

That said, as things stand we have already established in v1 [3] that for
our existing use case - attaching metadata to <1% of skbs - the
tracepoint-based approach is prohibitively expensive (+5% of CPU time), as
Jesper noted.

The skb-extension-based solution, in contrast, shows comparable-or-lower
overhead, making it a viable drop-in replacement that enables new use cases
for us and potentially offers a performance win.

Thanks,
-jkbs

[1] https://patch.msgid.link/20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com
[2] https://lore.kernel.org/all/20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com/
[3] https://patch.msgid.link/20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Rework skb_ext_scrub() to simply delete all extensions but bpf_skb_ext
  now that the delete operation is idempotent. (Florian, sashiko)
- Fail writes through a dynptr while the extension block is shared with
  clones: bpf_dynptr_write() now returns -EBUSY and bpf_dynptr_slice_rdwr()
  returns NULL; re-acquiring the dynptr with BPF_SKB_EXT_F_CREATE COWs the
  block and restores write access. (sashiko)
- Mark bpf_dynptr_from_skb_ext() as packet-changing so the verifier
  invalidates slices from an earlier dynptr when a re-open with F_CREATE
  can COW the block and leave them dangling (use-after-free). (sashiko)
- Reject bpf_dynptr_from_skb_ext(BPF_SKB_EXT_F_CREATE) in tracing and LSM
  programs, which can run on a shared skb concurrently on another CPU;
  require a constant flags argument without F_CREATE at load time, keeping
  read-only access. (sashiko)
- selftests: Add verifier negative tests for the new tracing/LSM
  restrictions (F_CREATE and non-constant flags rejected). (sashiko)
- selftests: Add clone_redirect coverage into the cloned-skbs test
  (clone_redir_ext_write_after / clone_redir_ext_slice_write_after),
  queueing the clone on a netem-delayed loopback; enable
  CONFIG_NET_SCH_NETEM.
- selftests: Fix if_nametoindex() assertions to use ASSERT_GT(..., 0) so a
  lookup failure is not silently accepted as ifindex 0. (sashiko)
- selftests: Use int (not __be16) for get_socket_local_port() so a negative
  error is not truncated and masked. (sashiko)
- selftests: Validate send()/recv() return values and switch the sk_skb
  stream test to recv_timeout() to avoid a hang when the data path
  regresses. (Jack Wang, sashiko)
- selftests: Split the LWT test cleanup so bpf_tc_hook_destroy() does not
  delete the base-namespace clsact qdisc on the error path. (sashiko)
- selftests: Unify multi-line function comments to the "/*" on its own line
  style. (sashiko)
- Link to v1: https://patch.msgid.link/20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com

Changes in v1:
- Don't scrub BPF skb extension. Remove F_NO_SCRUB flag. (Stan)
- Allow calling bpf_dynptr_from_skb_ext from NETFILTER, LWT_*, SK_SKB progs.
- Reorg tests into smaller commits. Add missing coverage.
- Link to RFC: https://patch.msgid.link/20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com

---
Jakub Sitnicki (14):
      bpf: Introduce per-packet metadata storage for BPF programs
      bpf: Allow access to bpf_sock_ops_kern->skb
      bpf: Make BPF skb extension survive packet scrubbing
      selftests/bpf: Add tests for bpf_dynptr_from_skb_ext
      selftests/bpf: Test skb_ext on cloned skbs
      selftests/bpf: Test skb_ext survival across veth and GRE
      selftests/bpf: Test skb_ext read from cgroup_skb and sk_filter hooks
      selftests/bpf: Test skb_ext read from sock_ops and LSM hooks
      selftests/bpf: Test skb_ext read from kfree_skb tracepoint
      selftests/bpf: Test skb_ext read from netfilter hook
      selftests/bpf: Test skb_ext from LWT in, out, and xmit hooks
      selftests/bpf: Test skb_ext read from seg6local End.BPF hook
      selftests/bpf: Test skb_ext read from sk_skb stream verdict hook
      selftests/bpf: Use non-trivial test payload in xdp_context tests

 include/linux/bpf.h                                |   10 +
 include/linux/filter.h                             |   27 +
 include/linux/skbuff.h                             |   13 +
 include/uapi/linux/bpf.h                           |    5 +
 kernel/bpf/helpers.c                               |   21 +-
 kernel/bpf/log.c                                   |    2 +
 kernel/bpf/verifier.c                              |   25 +-
 net/Kconfig                                        |   20 +
 net/core/filter.c                                  |  149 +++
 net/core/skbuff.c                                  |   27 +-
 net/ipv4/udp.c                                     |    6 +-
 tools/testing/selftests/bpf/config                 |    2 +
 .../selftests/bpf/prog_tests/socket_helpers.h      |    1 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    2 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 1117 +++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  569 +++++++++-
 .../testing/selftests/bpf/progs/verifier_skb_ext.c |  122 +++
 17 files changed, 2094 insertions(+), 24 deletions(-)

