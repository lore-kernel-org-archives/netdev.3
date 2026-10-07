Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0544C4FF
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379840; cv=none; b=ggNWaWqHaYqjvTEM4WkvpHw4u7L2btEKtDMxPEpk/YG6g8iy0Qo21rEGBAb+4GKSb9FewEWo9B2mQXvy9hm1mv64jPisYhQFbju1AcitK0WELMVbpPKYivjmc9GqxvccfJrLsKstx6EQa2YnH6UckjczNa/NGlK0kvmsQ72Jjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379840; c=relaxed/simple;
	bh=DNujO+s/4oUYQtk/x33NTycnd/C5CiEkkHon67/9YDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P0vDDOiG/fjzXbNeI3aiPBrnDcKvr4w0VjgeTQYvgCkn+VJWVRoc+IAtphv9tLcQRNL59DFAfVfCNKUrnxuuEdWlLIIut6UV6UdFd0r30nkgllqHIargypyZt0uEL12HfuFSRjaLChC5CCCOq1lNqNDhqH/2q+1iX/MZQDMhEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZowMYgSE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZowMYgSE"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso1273511f8f.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791379821; x=1791984621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fvt8xB7JGat4M1zYcEgruvQVOA1rcBfHjyL4Um00UNc=;
        b=ZowMYgSE7rwsJPRikgzuoesdGY17ABgu2ICOnAynJq4wwEeypYHPLYBi501XnMicOU
         EQ30dPzztg/BicYBj8FjIr530kktALYQz2/S3JDO/9UulbJdduSGxxfJSNgIWum8wyDy
         cW/bUdxz2UQw59hso4vv0sYltCk+H36Gj9R8heq+ylHsU/D08JctEijSr7e+yFkl5wnb
         y/K1LEqx7dVsBmYaJR3pE9EUWPHtcinIo2/v7JfFeDTdbFyKBCVnQU1UY++A5DYWKgEm
         YpEGRgk2xLQxdgtvWcWjN3G5N8TuouqaNDOq4dxadJUcjE7m+f0nWCEjCimsjI/85RvQ
         MUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379821; x=1791984621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvt8xB7JGat4M1zYcEgruvQVOA1rcBfHjyL4Um00UNc=;
        b=2M5dZ/L3sfxFvmGJmhkTGkbJTlE3UKuhTKYxUlo5F27iZ2PSKaLLJT8csOXwLoYP+8
         VuL1eyZcj4P/VbMdoh96Smq99fQgmlyrUtftyndnEvnd8BJbPjIOmz8F0k/bwuotbHTA
         +02zQywCpgatqXSGjRkTELCoPl9kXgZLPz67bz9F/kYEZUNL6XgoGGof6/l61NIVUxjM
         cFPmqHkAsZm36e4WRi50BxJqB/KQ4r8ZCKgnTtzP2SQ74U/7KyuoZQe5o8symXH2LJff
         kIlzSe2pm08fnri8zSULb5A8V0s7rDl+23i7qEyCda+M+KfSDM4PNowOhVz12pgnewgy
         H84A==
X-Gm-Message-State: AFuF++lv6zsC0uXfB5uB0BV7jIdSv2tbWXii25BRAjS0zYWVuFwzvyJG
	3rRGTsI5NteFYRjXqNdyeHOeATlkQ3ExuyRZJHw1B/r+zcktZM08nbmKgbX190gcmvHkTX4NEj6
	U4xzExRiTDrVsADd4zGIVcd0x/MVJnOMut6wR2Io1qEAp/KEklDWbS1c925JLpADU
X-Gm-Gg: AYBFou0c8lUMmEIcKh3fN9FUNbf4rSt4sQX3G/4XJQxLH8h9SIvSxD0pGCyJpCFoBG5
	0VbBdFU6OoNOQNJ+d5nXqMkAFIvIiOkRHkHERFI74Nso0D1qxi6VCCQRYl9e0ULSxvqi6Zp3ZGR
	Icn6lF2HH82tjk3m0gVYKw0hXuXZUqr2CJ/OPM8btfged4dLuhplYydbuxTyjIcZSAlKvWT3g/I
	AKe4PAiGCbAcUo0GoEc2EjDIgst1gNWUhDSGOPzUcVhH4DqfglLskp95UXAYkzkl3ldbkvLwSQQ
	0qNOWul7JDgULhjHR7iBceX6l15SEbcFZyd9GeU6jRMHIxYJ+Ymyyg4vtJDyi2J/8z9zHq2HCXS
	t5nVCKhCxYNGcSz5CD73opjODESVPqnxJkMJR5ANPapnhvZ7Z5zIm3u99TQiHRs2IRb8HyVqUmY
	hi8kTTQclrOQCeyVK7neNEpYLK4Ljkv31k99aX6rnpx5S3ZXMSvXc9f/ymMwwgZisTJ1TXHNjk7
	FlbrOlt7dE=
X-Received: by 2002:a05:600c:154c:b0:4a1:6282:1cf3 with SMTP id 5b1f17b1804b1-4a18043b284mr40569725e9.9.1791379821198;
        Wed, 07 Oct 2026 06:30:21 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7fc5:5cc8:bac1:5ef3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm150356145e9.3.2026.10.07.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:30:20 -0700 (PDT)
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
Subject: [PATCH net-next 0/7] pull request: ovpn 2026-10-07
Date: Wed,  7 Oct 2026 15:30:09 +0200
Message-ID: <20261007133018.1451958-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

Here is v3 of the ovpn batch for net-next, rebased on current net-next.

It is mostly cleanup. The one functional change is that PEER_DEL_NTF now
carries the same peer object returned by PEER_GET: a disconnecting
peer's final counters were not reachable before, because
ovpn_peer_remove() unlinks the peer before emitting the notification.
The selftests get TCP_NODELAY on ovpn-cli's TCP sockets and proper
synchronization against the server-side key setup. Ralf is added to
MAINTAINERS as ovpn reviewer.

Changes since v2:
* 5/7: the wait on the server-side key setup was unbounded, and the
  subshell only reported the status of the last new_key. Bound the wait
  and report a failure from any peer.
* 6/7: the notification filter used to drop every message carrying a
  remote-ipv6, which also dropped the IPv6 float events. Those are not
  deterministic and are not in the fixtures, so letting them through
  made the notification check fail at random. Drop them again, this time
  only for peer-float-ntf.

Both were reported by sashiko on v2. The second one was making roughly
15% of the selftest runs fail, so it is worth having before this lands.
With it, 33 consecutive script runs are clean.

Please pull or let me know of any issue!

Thanks a lot,
	Antonio

The following changes since commit 6e23f90f2b8c3ea3bf904f86f3ed06bf2844b4bc:

  Merge branch 'net-consolidate-devmem-net_iov-freelist-and-dma-handling' (2026-09-29 15:41:35 +0200)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-next-20261007

for you to fetch changes up to e724d2ebb9519ce89ceadcd136ca6f2b9e404a32:

  MAINTAINERS: ovpn: add Ralf Lici as reviewer (2026-10-06 02:24:31 +0200)

----------------------------------------------------------------
Included changes:
* add Ralf Lici as ovpn reviewer
* include the peer object in the PEER_DEL notification
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

Ralf Lici (2):
      ovpn: remove unused work field from struct ovpn_socket
      ovpn: send peer object along with PEER_DEL_NTF

 MAINTAINERS                                        |   1 +
 drivers/net/ovpn/bind.c                            |   2 +-
 drivers/net/ovpn/io.c                              |   6 +-
 drivers/net/ovpn/netlink.c                         |  60 +++++++-----
 drivers/net/ovpn/socket.h                          |   2 -
 tools/testing/selftests/net/ovpn/common.sh         | 108 +++++++++++++++++----
 .../selftests/net/ovpn/json/peer0-float.json       |  12 +--
 .../selftests/net/ovpn/json/peer0-symm-float.json  |  10 +-
 .../selftests/net/ovpn/json/peer0-symm.json        |   7 +-
 tools/testing/selftests/net/ovpn/json/peer0.json   |  12 +--
 .../selftests/net/ovpn/json/peer1-symm.json        |   2 +-
 tools/testing/selftests/net/ovpn/json/peer1.json   |   2 +-
 .../selftests/net/ovpn/json/peer2-symm.json        |   2 +-
 tools/testing/selftests/net/ovpn/json/peer2.json   |   2 +-
 .../selftests/net/ovpn/json/peer3-symm.json        |   2 +-
 tools/testing/selftests/net/ovpn/json/peer3.json   |   2 +-
 .../selftests/net/ovpn/json/peer4-symm.json        |   2 +-
 tools/testing/selftests/net/ovpn/json/peer4.json   |   2 +-
 .../selftests/net/ovpn/json/peer5-symm.json        |   2 +-
 tools/testing/selftests/net/ovpn/json/peer5.json   |   2 +-
 .../selftests/net/ovpn/json/peer6-symm.json        |   2 +-
 tools/testing/selftests/net/ovpn/json/peer6.json   |   2 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |  23 +++++
 .../selftests/net/ovpn/test-close-socket.sh        |   2 +
 tools/testing/selftests/net/ovpn/test.sh           |  56 +++++------
 25 files changed, 225 insertions(+), 100 deletions(-)
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm.json
