Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886280;
	b=PEa1JLZU2GyMUeW2TsS10rBuH2pYskkI+EABZAAsXandHid5rGYqe04fkUClECraf8As
	 tu4HaRgAcUa4u1DfJ6QWifLCEJBAVVjsBe/5n+8lnCNblVS0cli1mwG4Fj/QphvyV305H
	 1XZQb2zUiyvUHwhARO7oMx+OFCUQbsN/5E70NyW9Uy6bpT0BR//d7L1Pqq0DTmOZcY8vJ
	 +kIeBt65d18qLvLrSNkV369M0p0iGnjENlIfbIqyCk2xlAFHI1yEJcA2tl8oy4eHKRlhI
	 I+g/ev25B5/4FgJm6PTh+nXjlGq1GVo4ecRTPlrMMl3FfrzQ0Flka6CaGE81G6mKYlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886280;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fabbkMtAVFs8yu+FgpK9KWzRZnuxf/X9UOh57x+1j1w=;
	b=E0ErelTXyaYE9/jjDm/l1JMYIcFvqsQgrlqgZSfOtVVZRVCHS6uKnc4UeFRccseRTsHz
	 /8/dUmTjeLsuZAo12lISAgKM0syY8t1oMkxEzN7ngW4LQ5SXY68N2uDjfDPqgM1037j/N
	 yUSKQcoiwh0sSYlkAjoHQSaDNrvATvHtCyuXwX4gOQ1f77Kt4uw/pSoPnnnhRgBVpbgcn
	 FSS80hiLy73M2gOOLcA7vWc1QZL88hZQGO4dcJQyjY0auYkzb4jEdvHgMxrpvg+8dGDC8
	 o4sAUiZu+eo/cZ7TSk8sZIcbMYALBtL2wnm1VpEI6G2/LFXF9RpdPAMSAVg2l/Pkz6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="T6/1chZh";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AEA606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4AEA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T6/1chZh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793886279; x=1825422279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g6l2n6W6izsEP4F9pOqEQJFMAWY67KI5J4fmzJNHkAE=;
  b=T6/1chZhpJJGtT4uN2bZcWIsL6PI/UqMUWlUT4MuBliE4Cz6+9vrATID
   jZON5n6C8kF6HeXJ/SKvTweoCzcUnOtqlOcI0JFEtd/W1bhkwY6aAfhvT
   c93g9ihBEJiFt6mq+DoqBPKCosl1Y3mjDZb3O+9cwe8aoCCc2UNKEwo1/
   lSP5VQheZEN6h0HoBMHa9gqoFIcIc02RZagdg/CL9f2yOjHvT3BzqAVXW
   ke0/Smx6j/mSZTyT2Ds9g040HVp6sA3OKIOCMIXgB8alNJUeZAkW3xYNg
   2/u922NVfsamOkmXf1RCBE7zLevjIt3fbXXevtSQTTxWX0Iqk3tfqgp3x
   w==;
X-CSE-ConnectionGUID: dNWzPhz1TpKhqHl8htB2cA==
X-CSE-MsgGUID: 3uJovxDLRj+KsedqsKGTqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2710190"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2710190"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 05:41:22 -0800
X-CSE-ConnectionGUID: 44EHyFAbRIyvsz8ac8I++Q==
X-CSE-MsgGUID: WmbVB8nbSU+f0g0S74taSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6874336"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 05 Nov 2026 05:41:20 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next 0/4] selftests: move the AF_XDP test suite from bpf to net
Date: Thu,  5 Nov 2026 14:41:13 +0100
Message-Id: <20261105134117.977655-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

As the maintainers asked, this series is the first step of moving the
AF_XDP selftests from selftests/bpf to selftests/net: the code moves and
builds from its new location, without changing what the tests do. The
rework [0] posted as "selftests: net: migrate AF_XDP test suite over to
net" (v4) will follow on top of this move.

Patch 1 drops the test_progs wrapper of the AF_XDP tests, patch 2 adds a
generic BPF skeleton rule to net/bpf.mk, patch 3 moves xskxceiver, its
library and test_xsk.sh to selftests/net, and patch 4 (new, not covered
at [0]) moves xdp_hw_metadata, which is built from the same library.

The xdp_metadata test stays in test_progs: it covers BPF core
behaviour, and moving it would mean rewriting it for the kselftest
harness. It keeps using xsk.c from net/lib/xsk.

xskxceiver and xdp_hw_metadata are the first users of bpftool at build
time in selftests/net. NIPA has bpftool, but 0-day and KernelCI build
net without it, so both tools are skipped with a warning when bpftool
is missing or does not run.

test_xsk.sh is installed but not run by run_tests, so NIPA does not pick
it up: it runs every case, including flaky ones, and some cases leak
page_pool pages after skb_pp_cow_data() in generic XDP mode on
veth-based runs. Until a later step makes the suite fit for NIPA, no CI
runs the AF_XDP tests. test_xsk.sh is being removed by [0] but it is
kept here as there is no other feasible way to run the test suite (if
needed) until we come up with an upstreamable Python runner.

Thanks,
Maciej

[0]: https://lore.kernel.org/bpf/20261016174338.787135-1-maciej.fijalkowski@intel.com/

Maciej Fijalkowski (4):
  selftests/bpf: drop the test_progs AF_XDP wrapper
  selftests: net: add a generic rule for BPF skeletons
  selftests: xsk: move the AF_XDP test suite to selftests/net
  selftests: net: move xdp_hw_metadata from selftests/bpf

 Documentation/networking/af_xdp.rst           |   6 +-
 Documentation/networking/xsk-tx-metadata.rst  |   2 +-
 MAINTAINERS                                   |   4 +-
 tools/testing/selftests/bpf/.gitignore        |   2 -
 tools/testing/selftests/bpf/Makefile          |  29 +--
 .../testing/selftests/bpf/Makefile.buildvars  |   6 +-
 tools/testing/selftests/bpf/network_helpers.c |  48 -----
 tools/testing/selftests/bpf/network_helpers.h |   2 -
 tools/testing/selftests/bpf/prog_tests/xsk.c  | 170 ------------------
 tools/testing/selftests/net/.gitignore        |   2 +
 tools/testing/selftests/net/Makefile          |  20 +++
 tools/testing/selftests/net/bpf.mk            |  13 +-
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/lib/.gitignore    |   2 +
 tools/testing/selftests/net/lib/Makefile      |  25 +++
 .../prog_tests => net/lib/xsk}/test_xsk.c     |   2 +-
 .../prog_tests => net/lib/xsk}/test_xsk.h     |   5 +-
 .../selftests/{bpf => net/lib/xsk}/xsk.c      |  49 ++++-
 .../selftests/{bpf => net/lib/xsk}/xsk.h      |   4 +
 .../{bpf => net/lib/xsk}/xsk_xdp_common.h     |   0
 .../lib/xsk/xsk_xdp_progs.bpf.c}              |   2 +-
 .../{bpf => net/lib/xsk}/xskxceiver.c         |  17 +-
 .../{bpf => net/lib/xsk}/xskxceiver.h         |   0
 .../selftests/{bpf => net}/test_xsk.sh        |   5 +
 .../xdp_hw_metadata.bpf.c}                    |  35 +++-
 .../selftests/{bpf => net}/xdp_hw_metadata.c  |  81 ++++++++-
 tools/testing/selftests/net/xdp_metadata.h    |  67 +++++++
 .../selftests/{bpf => net}/xsk_prereqs.sh     |   2 +-
 28 files changed, 307 insertions(+), 294 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/xsk.c
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.c (99%)
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.h (99%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.c (95%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.h (97%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk_xdp_common.h (100%)
 rename tools/testing/selftests/{bpf/progs/xsk_xdp_progs.c => net/lib/xsk/xsk_xdp_progs.bpf.c} (98%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.c (96%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.h (100%)
 rename tools/testing/selftests/{bpf => net}/test_xsk.sh (98%)
 rename tools/testing/selftests/{bpf/progs/xdp_hw_metadata.c => net/xdp_hw_metadata.bpf.c} (75%)
 rename tools/testing/selftests/{bpf => net}/xdp_hw_metadata.c (92%)
 create mode 100644 tools/testing/selftests/net/xdp_metadata.h
 rename tools/testing/selftests/{bpf => net}/xsk_prereqs.sh (98%)


base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.43.0

