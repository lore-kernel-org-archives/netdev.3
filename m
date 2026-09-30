Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6603F5BE4
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807151; cv=none; b=TYjUMkMc4ixLq+6+FlntWHphsTCwH7uYL74Kw0+ZcTyoO7OBUBBCb8ncMO7KtibnA/+A505MUH8x92GH3jiprCWC8h91TA3hcfvnKQLroMWY0hR6Cqx/3tm6cxIi4zVdzapVGjSh+FMWNfM+o4RImR6k5OzEZxN75OD9fMsFu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807151; c=relaxed/simple;
	bh=VU7m8GYnZ10miuX5BmeuKnC9I3tw6ckgMbkRq9mC6vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJTmpG5vRmx5YisdZyLMKZQ4Os0dAtzgDt8/JNloJgqMCk96Ui9Xx2lDerJpfdKP+FKOxjB3O+ekhyyARHkW3HBQaRHD6eYa+gnQaEY5r1c+SiNz9MBjRARoLazdWEzvYvUmASgbQIeSgAG+9iC570cG0mATETmKSDG1N1PS4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SpXtY+jk; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SpXtY+jk"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so37607105e9.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790807147; x=1791411947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EB2d1nuWm+QTGla6T2zQWX0k93c8cXCwr+XI5V2gkfk=;
        b=SpXtY+jkG6Wn11ClRQ0v5WtJjChUEjuaAmAcQRlWGatY6cu/bWKM563LXejLuHfMO1
         Pd+8GUuNZDKQhfiIaz6QsidgGvv2tMr05jZVe2NejYQk7hwaDky9lb22H4ZoqS2dQG5X
         NtNfypDAuLRh9AZUrSKMGNNcgwOBJSBS1NUlHdp7SQdU487s5WN1Hmo96uckF1wUIPsu
         IlcN8wh6rgMdKQRM8mYAJjtPsrn+udlsTN9LWyFLC0P2+ox6EJ0yOagNWJrjvEQo+ESM
         tt4TvdtQeqiwMKKi2YhOxOyh/X+9WlhgH/JJysyDPRJu34cwhtSVWfrHC9iM3XNuiQr2
         8kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807147; x=1791411947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EB2d1nuWm+QTGla6T2zQWX0k93c8cXCwr+XI5V2gkfk=;
        b=LA74Zziw6sm/3UDEQxa8EJgR2gPHoF7z2Mpfo7wMsTrtzLaKm2Wx/P4NkujkQNdoao
         /rwQxwv+UCRJabfWCj8yWGlJ2MvOaJ9iHJsK8hAwaJyCpD0oISiE4u2U20quEKoY8FAl
         Df5EPqRmvpCaOAf9QxAXxl+UTQt/SE02z0yJDgRm7ch7HDTV64Owc9ywMg66vo5xaUHu
         iTk6TzJNp3V3KD05y0g6b02UWBH1u40jS+0voOLr2NfSm5XB0x2AcF0hWoYDVS7Jv5YT
         7VM/d2GhEIyieqG+QahzHJMzUop+gAjAteg6X+I/YoBkVaE4NHW/DJmJXlIM5mHfU5sI
         ENcg==
X-Gm-Message-State: AFuF++kBDecL73giqDDjjZNw/qW9T6NJB2/9TBAmuDv6PV0aIt4F6bDU
	cIgnB4H6g5YK4Zqn1SdJyKjlxJYcpex1Zv7uUCX1SSQpv+hkBGH+WX5vKkjrRvlrSkC3OCix1lw
	cCKCc1IDlx9k7PIOUjVXBEyozLGz4e7QAzSuxortQaVSN3X5JjcosfUZrI9hG3SqyDm8=
X-Gm-Gg: AYBFou3dkelrmAoFQJ+6exWq8VocDZdqhZiI1ZaDZwFoN+8rIx893meV42I1OQ6zq3J
	g2bGCCQIMZ2VDoeum8qphutpkaSgrIi3IVqgTeDVzTKBm8TvLb9z9iXKgMk+qMwsBXAZE44n80m
	UJF1iiYzQRgaywbPaWHTqY8IY0vkYdpLVc7GTqYT9DJYaxQg/50YhDI5ke3a5AjK5kZrch4zfny
	LRBbUGQlvBG478oopg7dMkXIwRgPrZ0r3bMFBMNYdaWLhVNkebrCIwxS5elPPVxoOG+Rn/6uagK
	iIhu2syafwetl4y1qHLo7O3X9i6zV28MoMRz3QZ1MchoqrH7a8RnwKBcIa9cS0Ti0VCsu5OGv2h
	lySOHhI9iSTvDTo6Rq9hgOjTnhgnROiZ1k30EC7wp67FVcYPsyiPKhxH0880iJ/Yp3XSupDZmfc
	y44TnKuuHITG00rXKazMzKx+MpXd4yPD0nUo9Ykp7P2/U4DkFZ2zT9jFtdjCP7+C1UPuWLeeXxF
	Ri768jhgpal
X-Received: by 2002:a05:600c:4f8e:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-4a01b00541bmr44345295e9.19.1790807147363;
        Wed, 30 Sep 2026 15:25:47 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5892:feba:7b41:58fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979c05sm24433095e9.3.2026.09.30.15.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:25:46 -0700 (PDT)
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
Subject: [PATCH net-next 0/7] pull request: ovpn 2026-09-30
Date: Thu,  1 Oct 2026 00:25:34 +0200
Message-ID: <20260930222542.3839327-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

Here is v2 of the ovpn batch for net-next I sent on Sep 22nd, rebased on
current net-next.

It is mostly cleanup. The one functional change is that PEER_DEL_NTF now
carries the same peer object returned by PEER_GET: a disconnecting
peer's final counters were not reachable before, because
ovpn_peer_remove() unlinks the peer before emitting the notification.

The selftests get TCP_NODELAY on ovpn-cli's TCP sockets and proper
synchronization against the server-side key setup.

Most notably, Ralf is added to MAINTAINERS as ovpn reviewer.

Changes since v1:
* rebased on current net-next
* added the MAINTAINERS and TCP selftest synchronization patches
* selftests: include <netinet/tcp.h> explicitly for TCP_NODELAY
* 6/7: reworded the commit message, the PEER_GET workflow it described
  cannot work

Please pull or let me know of any issue!

Thanks a lot,
	Antonio

The following changes since commit 6e23f90f2b8c3ea3bf904f86f3ed06bf2844b4bc:

  Merge branch 'net-consolidate-devmem-net_iov-freelist-and-dma-handling' (2026-09-29 15:41:35 +0200)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-next-20260930

for you to fetch changes up to 1bff3c5c1ca993f00c4459d7daede7959bc2fb40:

  MAINTAINERS: ovpn: add Ralf Lici as reviewer (2026-09-30 15:56:50 +0200)

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

 MAINTAINERS                                        |  1 +
 drivers/net/ovpn/bind.c                            |  2 +-
 drivers/net/ovpn/io.c                              |  6 +-
 drivers/net/ovpn/netlink.c                         | 60 +++++++++++-------
 drivers/net/ovpn/socket.h                          |  2 -
 tools/testing/selftests/net/ovpn/common.sh         | 72 +++++++++++++++++-----
 .../selftests/net/ovpn/json/peer0-float.json       | 12 ++--
 .../selftests/net/ovpn/json/peer0-symm-float.json  | 10 ++-
 .../selftests/net/ovpn/json/peer0-symm.json        |  7 ++-
 tools/testing/selftests/net/ovpn/json/peer0.json   | 12 ++--
 .../selftests/net/ovpn/json/peer1-symm.json        |  2 +-
 tools/testing/selftests/net/ovpn/json/peer1.json   |  2 +-
 .../selftests/net/ovpn/json/peer2-symm.json        |  2 +-
 tools/testing/selftests/net/ovpn/json/peer2.json   |  2 +-
 .../selftests/net/ovpn/json/peer3-symm.json        |  2 +-
 tools/testing/selftests/net/ovpn/json/peer3.json   |  2 +-
 .../selftests/net/ovpn/json/peer4-symm.json        |  2 +-
 tools/testing/selftests/net/ovpn/json/peer4.json   |  2 +-
 .../selftests/net/ovpn/json/peer5-symm.json        |  2 +-
 tools/testing/selftests/net/ovpn/json/peer5.json   |  2 +-
 .../selftests/net/ovpn/json/peer6-symm.json        |  2 +-
 tools/testing/selftests/net/ovpn/json/peer6.json   |  2 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 23 +++++++
 .../selftests/net/ovpn/test-close-socket.sh        |  2 +
 tools/testing/selftests/net/ovpn/test.sh           | 56 +++++++++--------
 25 files changed, 190 insertions(+), 99 deletions(-)
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm.json
