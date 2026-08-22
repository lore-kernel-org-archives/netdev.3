Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DB39060B
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439334; cv=none; b=thYHhOu+iBa2AKazXLi3stV4HsL+j7oyaPGoV8vhW8dkSleDwIO7PRyXskzKrl6vvztyUU2gC5EEt9CP5rd7LD4X5elatz2VZ5uA/ix4Efpq7w3JmsczuUt9xm8lb+l6j+dkVJEh9sxuEWjdrFOtVK1Q7j5Xcv4WGD0rEJckyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439334; c=relaxed/simple;
	bh=94/dOq2HF5q+77VuAmwKxT/b2pxikqzHYXjV2qYCkQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J54Py25wvY/yjTzlaXi/+X5aRbIV76E+iYu9VNaIbDNt+lIIPBHg29AA8HVVXKLqdpRqHZnIhvfmZkASQjk+R+eTrNXjjGdWFu+/HKlD+lrAanY11UZiooncglTbHnpCyvL/gqsdF7pWWXcFyjxKy1cgWAHh+UcU1YuHt+36238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/BqdxuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/BqdxuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3DE1F000E9;
	Sat, 22 Aug 2026 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787439331;
	bh=2Z5YoEZb+5pw2ySU42Srie5dHOJ9E3i6BMCjno0z9YU=;
	h=From:To:Cc:Subject:Date;
	b=X/BqdxuOf0ApQ6b7NUIjmeD8L+Sf+STw9WCFEudDFcfpHbq1PSWv4GtlAUD9xiHmv
	 8kBiQQZnKloVR/8M9XRVnDbJL1cpqa66HhPlH6CfNpIoXtzYbghj/qMV7AZgE/Houk
	 10cVBSWwSpTA53GEa0C+iDcYKgmHd8emVdr6vTB/qtzVdclwuuRydUF6bjCqIBU7iR
	 9FzzAuxVfbtJ3n6FCkXDjTICKYWhgTxlx5BpL65frtDprz8nfAuJzdUngPzh7xIM0W
	 Ta7VagoKYvG4f7ehAZZWwCE8t/zow0m9fUyN+U9ay+3HJ9mq5KPnhcBNW5F0wLkjQN
	 CWJCiN68//IEA==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: edumazet@google.com,
	cratiu@nvidia.com,
	borisp@nvidia.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 0/6] psp: use virt cookie as Rx steering hint
Date: Sat, 22 Aug 2026 15:55:18 -0700
Message-ID: <20260822225524.2328465-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This PoC series uses a field of the PSP header intended for tunnels
to auto-steer Rx traffic. Various attempts have been made at trying
to get Rx traffic to land close to the core where the application runs.
By default RSS picks the Rx queue based on the flow hash.
I'm not going to cover all previous solutions in detail but broadly
- we have RFS in SW which looks on which CPU Tx happens and backlogs
Rx packets there, it is quite efficient. aRFS is built on top
of RFS but tries to program flows into the NIC. Some NICs have
a "cache" and try to automatically remember the flow to queue
association.

All those solutions are entirely local to the receiver.
Ideally we would want the solution to look something like
TCP timestamp option - we send an opaque cookie to the peer,
and the peer echoes it back to us. Our NIC can steer based
on that echoed cookie.

This patch set implements exactly that using the optional PSP
Virtualization Cookie field. The PSP standard doesn't have much
to say about this field:

 Virtualization Cookie - 64b
 An optional field, present if and only if V is set.
 It may contain a Virtual Network Identifier (VNI) or other data,
 as defined by the implementation.

IOW it's a field in the header which can be used as VNI, so presumably
most PSP-capable NICs will be able to feed it into some TCAM lookup.
The main use of this field is when PSP is used for tunneling.
Nothing in the standard precludes it's use in transport mode.

This patchset splits this field as follows:

   63           48 47           32 31           16 15            0
  +---------------+---------------+---------------+---------------+
  |    reserved   |    req qid    |    reserved   |    dst qid    |
  +---------------+---------------+---------------+---------------+

"req" is the value we want sender to put in "dst" when they respond.

When the feature is enabled we expect the NIC to create low-priority
steering rules matching on "dst" (bottom 16b of the Virt Cookie).
The mapping is direct today so dst=2 means queue=2 within the receiving
interface (see doc in patch 1 for more info). Any explicit steering
rules (ethtool, TC etc) still take precedence over PSP steering,
we are only overriding the RSS queue assignment.

I'm sharing this as an RFC because I _think_ it's a good idea
(feedback most welcome). We need some vendor cooperation to get this
implemented - specifically IDK how to make mlx5 (the only PSP-capable
NIC I have access to) to do the steering :(

Jakub Kicinski (6):
  psp: steer Rx queues with the virtualization cookie
  netdevsim: support PSP VC based queue steering
  selftests: drv-net: psp: move the PSP test plumbing into psp_lib.py
  selftests: drv-net: psp_steer: test PSP VC based queue steering
  selftests: drv-net: psp_steer: test where PSP steering sits in the Rx
    pipeline
  selftests: drv-net: psp_steer: cover corner cases and races

 MAINTAINERS                                   |   1 +
 Documentation/netlink/specs/psp.yaml          |  42 ++
 Documentation/networking/psp.rst              |  75 +++
 tools/testing/selftests/drivers/net/Makefile  |   5 +
 include/net/psp/types.h                       |  93 +++-
 drivers/net/netdevsim/netdevsim.h             |   4 +-
 include/net/psp/functions.h                   |  54 +-
 include/uapi/linux/psp.h                      |  17 +
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   2 +-
 drivers/net/netdevsim/netdev.c                |   5 +-
 drivers/net/netdevsim/psp.c                   |  26 +-
 net/psp/psp-nl-gen.c                          |   5 +-
 net/psp/psp_main.c                            |  53 +-
 net/psp/psp_nl.c                              |  21 +-
 net/psp/psp_sock.c                            |  35 ++
 .../selftests/drivers/net/psp_responder.c     |  42 ++
 tools/testing/selftests/drivers/net/psp.py    | 287 +++--------
 .../testing/selftests/drivers/net/psp_lib.py  | 184 +++++++
 .../selftests/drivers/net/psp_steer.py        | 473 ++++++++++++++++++
 19 files changed, 1187 insertions(+), 237 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/psp_lib.py
 create mode 100644 tools/testing/selftests/drivers/net/psp_steer.py

-- 
2.55.0

