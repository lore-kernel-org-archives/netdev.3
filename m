Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252656;
	b=U7W5dgWPqfiN3eVuI23BtEYeD9ZIH8/QewVGFlwyIjLtHvjY5QhxFyqhhEr/aFfrhKgz
	 7jpgPxKWhvvpMKzBWrH6/gsPYgwv1JePNkYlgUB2HRdVihbOtpCsy3tq+NtqlBXg8A/C7
	 YSG+5cSZIW/8TfN5FvNQz+PqgRdf/6sECW9/TGIdmxe8C0zuHVTo36kSnB52N8JjwwUaa
	 GAGd47xgEBHV9bq8L5SjusbJ03LLFSXBSV1cJUc4rWBQzmYr6OKPdDL3oEnIjF/Hg0FMz
	 s7FVGM7q6C0FPuSbgCsn82PTSJzOfoXTy18jHIftllRj+kck7MZ9GKJT3dbZKdItBmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252656;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ranNDqu1jcIEKyFvltf4hiPjDAwwm9bemK7JvP2PCE4=;
	b=blf5/shNOMYmuresTuqSoHLoL5idK/cMhneTPMFfHxNMpW4b/4YqnV17EEp7LIoszaRo
	 npstvrFq6pZ7A7gESZRZ/j66tWrKEO5t1/AW2WryZkbUtNYKVNkao6fWOugCPvbNBQnqZ
	 dHhKC1UHUGooFa9aUuTItCclkqK31LX98b4/r1+Ag7BXUs3ugi48HXJ4+9h2E6ybu2KvP
	 Mijl1X56+oZqrVBkvkJNBZkzaVqXed5R1UziDsfcJ8LZh7tVJVwg0mJgP67KIfdKSlrKa
	 d5H0tSNvMDlRqyZKmYJoK0NWhijQlHIEmM3srutW0dbCFYi1lL2pHhwR7ol1VHP3S4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g8UzfRSp;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371E1606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 371E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g8UzfRSp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794252656; x=1825788656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+aXvu31OB8bnYTJyafeTi4ySIacwsMFHltqkCHypacU=;
  b=g8UzfRSpUTlCertM9/CAgyrZSPLr7Yz7G5M5o4SIay+hLgjCMuowEio0
   o5mJJryN4ubLXBPJxMwkbh1VRMyIiIB3UYZ3fVsuN+msYAx+jxKuteAq7
   wn9tTZGN8mPZyARpPHN9LfzQA+cqrYZCujapbxJJTnEckWoVbcgtmQho7
   +mSIaHdoQEwaDK6QAsGcel5JZQMZ7tIsV7k1AcHLq1r5zQp5YxZfh46cU
   3cAf5PsPbpY4ElE4nYLnvUHXS/RU+H9mmSQBnCOzNnaYxamMOwjplwl0J
   rmsOb6zvYB/f21jjYYkvy7+0tlt+WJErYypDeN33IisSc5j6ZETkXeHGQ
   Q==;
X-CSE-ConnectionGUID: FXqQNfMLRXSvhFhA6GKNDA==
X-CSE-MsgGUID: kO0jw9szSKqW/Jo7oavmfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3021031"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3021031"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:30:55 -0800
X-CSE-ConnectionGUID: wW89ke+DTJm48rQ3hNns3g==
X-CSE-MsgGUID: 5qqX1bzwRmiICh/jv6vLBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9807937"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 09 Nov 2026 11:30:54 -0800
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
Subject: [PATCH v2 net-next 0/4] selftests: move the AF_XDP test suite from bpf to net
Date: Mon,  9 Nov 2026 20:30:44 +0100
Message-Id: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
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

v1:
https://lore.kernel.org/netdev/20261105134117.977655-1-maciej.fijalkowski@intel.com/
v1->v2:

* Patch 4: add xdp_hw_metadata to TEST_GEN_FILES via COND_GEN_FILES,
  as net/lib/Makefile does for xskxceiver, so that net/Makefile passes
  NIPA's check_selftest.
* Add Stanislav's tag.


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
 tools/testing/selftests/net/Makefile          |  22 +++
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
 28 files changed, 309 insertions(+), 294 deletions(-)
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


base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.43.0

