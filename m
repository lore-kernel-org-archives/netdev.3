Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0E4377ED4
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812306; cv=none; b=XBtutvUcBAd1EO/1Lxn+DB7+yUHWsf1GBILwF8NpayXwN0Ron3tRhpSYCNLWGyPpD2vl5yeEy6plIq+sM2ln8wznjbwaXu6jLCG2cpiVw/PKEHWCvN6S9208DSPnTrdMf7sRbYgzIxJ4j99wsXoksY89slazniUsPnN26HrEpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812306; c=relaxed/simple;
	bh=FPLPofI2QFzLL0p6D+Nm9zg6m6zRkz72ef/jl5xabRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PT1myW9ykQLj7nKZXzLmOoDP8fd+pU3vAiOhvn2GqrrqW5POk2muHc/9burjvvlqcv7AKY6bRxMtMWvbROsGv0Axq3n3eim+yE4wZfP2RbHQx7AhAFe1FXlcRDw/VkR/K3igOSoCGY6kOMxChSkyxvllPJjWjsW6CEfh/I64W6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bFAXQZNd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bFAXQZNd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso13667885e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791812302; x=1792417102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ScMCsM4pCo+ij3K/Wfdga2QbxFpFa8vxcDwTQ/NUfeU=;
        b=bFAXQZNdjVmeNYeYq9GmczOk2AQWWRL86h4JOHvw4D/fou6CMj+4iCztGBqvk/S84Q
         iMFAvVQW9SjOKnrgB5oq6S+FqsUhGaWaZUFHm1l2WJGJ6FCgrsiq9HM4fU5RD9UUSRhD
         JINA3WQ/ryn5sEGq+XJcxJ/D0PP3UD5NhVuUJG2JvxIooE3BijKGVLPE7HUuYjHsB+uj
         RRmu5w0w6+nPoQ2ygWYyal+d53N2tA01TAXyVv6Bre3TbdmRVWRT/p0CfyDsdT2anANu
         8Rmu5dyH8oa3HcKvunl0dYkxyRVdltrTbv02h5N1fK4UDFqPW1nPnGnBAEuuM1XWs3HJ
         Lggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812302; x=1792417102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ScMCsM4pCo+ij3K/Wfdga2QbxFpFa8vxcDwTQ/NUfeU=;
        b=YsnlaCO8AsrZpjUXadLgQD/vAZUPOeaLq+GVdiEcW1ERwaf0dVW45p9Iz0jW678kW7
         E2x3YYVVE21uE5vR/aAEXpK1ysLvcocbHlty7ix9EAs1wpqYl8xHbvehcFSoCeT1eR1p
         4xONkexWs2WQJTp6VXGLty3cAgUvoB0fuY7sC78sU3uhXx0ETtRNTbumxbGCSL7LbOdU
         +DAO1X5V0umtwoUbc+2Sq/fvI5H6wqjg0vepPmkBaIlAYU8/eRvWYqgRDQNu3e5KeZOA
         u7+OFaHPfN2rnQ/aIc+NUy8+WRXvEeIkW/mf93m4BUxz4dZK+Q++l0rbLx1Ec+9Q3Nmj
         Lt2g==
X-Gm-Message-State: AFq9FYKuVjp5x0pthM8oQtpoxBo1hs/CZL+9cSYIo6D/YlxqsHK9EzRo
	+Hznv4gjWlHbbliX9wcC8bD5VbO+l6tEDjrVIgv1idAzQ8fFpeaNPA/qa6KzM8CYZaiA9so2jQM
	eMEopdLvLv+Xwm7tqiLcrVnR8FGrwzn4JA6wq1Fl2SIZFrVkoZ/mOGKMY8gSd0SQbTbw=
X-Gm-Gg: AYBFou3lu2CqzqTW26U8TNcvy4Pm2fDH1BIyR7zzxFJDtwhGBMfTtTL1qr5XVPsJK3R
	8opgiZEG4aCNaWRqXvF8dyIjziEH1gU6J5tqaDXle6mUcrmbIl6MlKDoFQro35gs/0G9NICAFVi
	VR/ENgUbQXNRk0fBp8m/Sc6vAPBsOMSo7zG4zhJw1FX1BHko8G/zTUfS4tnDmV9qwfSxXwDOrcD
	f9dsdxn+egK2ZJLfGWiOOdKz6FJXzxtgwgIMbxiZaeHbSfxkaJTaEBF1JEcJRbm9MCN2RSEIH4B
	DKsKWW6OmDoSfYEfebLc/PdFLTEoq5UvQGqeB/z2k99hMlbuQf1SaUF3KHIUFdl+Zx0tgoYvAuZ
	c439TVKAynLd2uOlKzZg3wpOpv24WZmWrgY7i2z6mUVLtiElPyYSkGM710Wa2mp2IwoJtBmRLOz
	HYSsJU9+xo+YLv8B87AmwttbDVeybazJCO4hHgxsC3vxW/jrBeeD9ipLn7KPnI6I93vgVF/T5AJ
	0EU8exlf7jci6OSnP4P2w==
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a18e4aa206mr194508495e9.27.1791812302391;
        Mon, 12 Oct 2026 06:38:22 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:2e28:6511:e6d6:deef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm418114735e9.9.2026.10.12.06.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:38:21 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 0/6] pull request: ovpn 2026-10-12
Date: Mon, 12 Oct 2026 15:37:57 +0200
Message-ID: <20261012133809.2477063-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

Here is v4 of the ovpn batch for net-next.

It is all cleanup and selftest work this time: no functional change to
the driver. The selftests get TCP_NODELAY on ovpn-cli's TCP sockets and
proper synchronization against the server-side key setup. Ralf is added
to MAINTAINERS as ovpn reviewer.

Changes since v3:
* dropped "ovpn: send peer object along with PEER_DEL_NTF" (6/7 in v3).
  Sashiko pointed out that the peers multicast group carries no
  capability flag, so any process able to open a generic netlink socket
  can bind to it and would receive the full peer object. Putting that
  object on the group needs the matching policy change to go with it,
  and that deserves its own discussion, so both will be sent as a
  separate series.
* 4/6: ovpn-cli still sets TCP_NODELAY by default, matching what openvpn
  does since 2.7.6, but it can now be turned off with
  OVPN_TCP_NODELAY=0. The new test-tcp-nagle.sh runs the TCP suite that
  way, so peers running 2.7.0 to 2.7.5 do not lose coverage. Commit
  message reworded to say which userspace version this mirrors.
* 5/6: the background subshell that installs the server-side keys now
  writes to a log of its own, dumped when the wait fails or times out.
  It inherited a temporary file that ovpn_cmd_run() had already removed,
  so a failed new_key produced no output and only showed up later as a
  ping failure.

Patches 1 to 3 are unchanged from v3.

Please pull or let me know of any issue!

Thanks a lot,
	Antonio

Antonio Quartulli (2):
  selftests: ovpn: wait for the TCP server key setup before traffic
  MAINTAINERS: ovpn: add Ralf Lici as reviewer

Karl Mehltretter (1):
  ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc

Marco Baffo (2):
  ovpn: remove redundant peer NULL checks in crypto post functions
  selftests: ovpn: enable TCP_NODELAY on TCP sockets

Ralf Lici (1):
  ovpn: remove unused work field from struct ovpn_socket

 MAINTAINERS                                   |  1 +
 drivers/net/ovpn/bind.c                       |  2 +-
 drivers/net/ovpn/io.c                         |  6 +-
 drivers/net/ovpn/socket.h                     |  2 -
 tools/testing/selftests/net/ovpn/Makefile     |  1 +
 tools/testing/selftests/net/ovpn/common.sh    | 81 +++++++++++++++----
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 39 +++++++++
 .../selftests/net/ovpn/test-close-socket.sh   |  2 +
 .../selftests/net/ovpn/test-tcp-nagle.sh      | 12 +++
 tools/testing/selftests/net/ovpn/test.sh      | 56 ++++++-------
 10 files changed, 153 insertions(+), 49 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-tcp-nagle.sh

-- 
2.55.0

The following changes since commit d8674294aefef02266c4d47ad10131f1bffbe534:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-10-08 22:21:56 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-next-20261012

for you to fetch changes up to b2ed202907d654337d72825d743a833009010740:

  MAINTAINERS: ovpn: add Ralf Lici as reviewer (2026-10-12 15:16:49 +0200)

----------------------------------------------------------------
Included changes:
* add Ralf Lici as ovpn reviewer
* wait for the server-side key setup before generating TCP traffic in
  selftests
* enable TCP_NODELAY on TCP sockets in selftests
* drop redundant peer NULL checks in the crypto post functions
* remove the unused work field from struct ovpn_socket
* fix the documented return value of ovpn_bind_from_sockaddr()

----------------------------------------------------------------
Antonio Quartulli (2):
      selftests: ovpn: wait for the TCP server key setup before traffic
      MAINTAINERS: ovpn: add Ralf Lici as reviewer

Karl Mehltretter (1):
      ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc

Marco Baffo (2):
      ovpn: remove redundant peer NULL checks in crypto post functions
      selftests: ovpn: enable TCP_NODELAY on TCP sockets

Ralf Lici (1):
      ovpn: remove unused work field from struct ovpn_socket

 MAINTAINERS                                        |  1 +
 drivers/net/ovpn/bind.c                            |  2 +-
 drivers/net/ovpn/io.c                              |  6 +-
 drivers/net/ovpn/socket.h                          |  2 -
 tools/testing/selftests/net/ovpn/Makefile          |  1 +
 tools/testing/selftests/net/ovpn/common.sh         | 81 ++++++++++++++++++----
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 39 +++++++++++
 .../selftests/net/ovpn/test-close-socket.sh        |  2 +
 tools/testing/selftests/net/ovpn/test-tcp-nagle.sh | 12 ++++
 tools/testing/selftests/net/ovpn/test.sh           | 56 +++++++--------
 10 files changed, 153 insertions(+), 49 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-tcp-nagle.sh
