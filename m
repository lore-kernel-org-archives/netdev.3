Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D137207F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057340; cv=none; b=jUmrT7zbpRJSKvBr5JYZ1jZYHCuXTOLHUb8Vduj+94Jp7gEAanvEIwUb5sQEBESDAIY3UNt/BLmICoBR3BXDTPcba7sGIQvXcvyK7w6mTE9zpkYr/81WsR7hMa7uTwgmLR7ZwRSdD9CtoafICDzWfn+uSZGkmxLl3W328hQb3Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057340; c=relaxed/simple;
	bh=lcrM/F192xOmmrmnH9wKtyUw+fdKKwGyMMER8qkjXX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLOQe44NnYlAiNUSTxAhqmuOrS0BjBqxa1dG87re+zEAjO+tfnkqPzeJEWRC0LbkgIdHJTTjIL7Cb7qhE/E9hD9q7IC5PatVunFVl0lbH781UNUVfxwsISMdbNu6qow2Mdl4oSiRiEVukeu7TEHVe0EqIxr8ZVVyYNFVd3sq6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aciHwsgt; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aciHwsgt"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so20440535e9.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790057336; x=1790662136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQ0krCXCmx3kUIRd1eom25RTt+FjAbNHG4SjkRGS6J4=;
        b=aciHwsgtH/ySfoAf64W8biv7UA6zs+eMYVs/M2rmaa+jRkD3rdP1fojcZsauuv3dFt
         otc032aeVxRVxu4BbuHEhqtPsDUJcUYYQyNf2KxYmtfW/mVjQy0NOb6apeVbijUCw1/5
         o945aPr106Q0mRpAeG5JrQu1GsMbxBhonBPMgAS4iOLoVOl7FS3sT7D+/GEPxwjaHTmE
         PynjPlv8OyzH41prkw7u8DmqjcK7GsYlZJjaeOknyXVHsfYgqo+2A54O24bk93Mpr8Yn
         OCJCGG/hR6bD78Pd+EkbXf1JIDDLspLU3LlaCVq20EauEssUGgLed/SFNGCX/5SBJDMJ
         F/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057336; x=1790662136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQ0krCXCmx3kUIRd1eom25RTt+FjAbNHG4SjkRGS6J4=;
        b=C1Y6KDxIOIP6LNJk4YdShh6DrkktG75/h6vSF4dhgOdajUPMdS1WyvMHJW7vTqGE+M
         GwovMNjSFX7dEVakd/6Lu+IexMAeooBgLWocT57BDf1D8SPjHTSvid8rYFsXS2xfqdr3
         M4JxltCG8WnnLNEyxpKM61HgkFe8e8W5UIG9wXl1A5xRMmHlE14NRp5ppsZVdQVHI37C
         y2W3vX/GRHLx3XnNzX+AnWOsV5i01hi3eZ3jjZ+/nmbkTtb4oiTeMwHdBV82ZCt1F2Zu
         wO7Oy6CfSISpN8VEyGjVTySWkW8P6w5vZtOZk6dPXdelfYAYnHgyijt2XaepWrw9cA2Z
         WKQg==
X-Gm-Message-State: AFuF++nnrG/RSR1qLJBpL4p8b4dTIpI728NNwEdPatmvgl3iLJOUirbc
	PbJa6+ZRhKDNSXrIKVkNC28PP0g0FHo7HVlvAAR9Lz3Tq+d9/006zwxEvvKNmFxpIev1AOX4Y9x
	E6pqho8M2eqH2bN0/diwgVUYLnLWUeQG05aSjvDSoqjc2JLyMKW+TAmDAOsywyblNdAE=
X-Gm-Gg: AYBFou0dY0zUmpyzTXDBF5C7QM3aLspajNw90MiwdfE+jqY3dm0fwn2LaHAsNfKmY0s
	MP48JBTWB6xMMX8vjjHXpwoOVSnySU5RyrVHY2WBSgXWqaEjMZ2/Rw7+gooK2z8Hg/+v+IXsNkF
	N5QhfmrRI+rtE3jYTrsWyciNOdQHfbVArYqrNHpXyWEPsTd0by6B+LyPGuK6d43KgxViT2Pbydg
	+YA4+Cb6AvMkKcAlmdC5BjZQzvSn3hRw++GwKdG5q2WQ2jbTcjf/p5aZl/9at+tnGwQj75AXxp5
	45UgUb+ZAP1zKwXlDGHe8YYK+43vVC+vYH5uzBKdn6TzEpqik8TbfhnYgkXyVEHeZ5tJ/lyGpVv
	fv7G7ykxkWuk7s+abzxRQQvY99e3pKAR6v9xB0rn6p4yKI/1zBa7M9JBEfKEsLeRDAGhNsSCq5c
	jSnmbsy0ISItY2oi1vDBz6NmMXDDm9ervL2cpR9hEYUx4+decrT/yqjx4CjuvE4XpcPocKx01u2
	Eu735voAo8=
X-Received: by 2002:a05:600d:1a:b0:49e:6778:c2bd with SMTP id 5b1f17b1804b1-49fc5a10c99mr156745135e9.6.1790057335740;
        Mon, 21 Sep 2026 23:08:55 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad6306esm25814125e9.15.2026.09.21.23.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:08:55 -0700 (PDT)
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
Subject: [PATCH net-next 0/5] pull request: ovpn 2026-09-22
Date: Tue, 22 Sep 2026 08:08:46 +0200
Message-ID: <20260922060852.2266148-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

Here is a small batch of ovpn changes for net-next, collected over the
past weeks. Most of it went through sashiko pre-review on openvpn-devel.

The bulk is cleanup: an unused work field goes away from struct
ovpn_socket, the redundant peer NULL checks in the crypto completion
helpers are dropped, and the documented return value of
ovpn_bind_from_sockaddr() is corrected.

On top of that, PEER_DEL_NTF now carries a peer snapshot in the same
format returned by PEER_GET. Userspace needs the final counters of a
disconnecting peer and so far had to issue a PEER_GET for every
notification; when many peers drop at once those extra transactions
overlap with notification processing on the same socket and can surface
transient netlink errors (peers disappear in the meantime). Carrying
the counters in the notification removes that round trip and errors.

Finally, the selftests enable TCP_NODELAY on ovpn-cli's TCP sockets, to
match what userspace does by default. Since TCP does not preserve record
boundaries, the capture-based peer ID check is restricted to UDP.

Note that the fixes I sent for net on Sep 21st ("pull request: fixes for
ovpn 2026-09-21") touch four of the same files, but the two series do
not conflict: I verified that they merge cleanly in either order and
that the resulting tree is identical both ways. The two pull requests
can therefore be merged in any order.

Please pull or let me know of any issue!

Thanks a lot,
	Antonio

The following changes since commit 114bd09838ac6954baaf110aebc4d5503057f88a:

  net: hip04: use 16-bit byte order for HI13X1 TX fields (2026-09-21 17:30:19 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git ovpn-net-next-20260922

for you to fetch changes up to bdeec4b3a279a6ace7a0ad506b04df266d9bd43d:

  ovpn: send peer object along with PEER_DEL_NTF (2026-09-22 02:37:40 +0200)

----------------------------------------------------------------
Included changes:
* include the peer object in the PEER_DEL notification
* enable TCP_NODELAY on TCP sockets in selftests
* drop redundant peer NULL checks in the crypto post functions
* remove the unused work field from struct ovpn_socket
* fix the documented return value of ovpn_bind_from_sockaddr()

----------------------------------------------------------------
Karl Mehltretter (1):
      ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc

Marco Baffo (2):
      ovpn: remove redundant peer NULL checks in crypto post functions
      selftests: ovpn: enable TCP_NODELAY on TCP sockets

Ralf Lici (2):
      ovpn: remove unused work field from struct ovpn_socket
      ovpn: send peer object along with PEER_DEL_NTF

 drivers/net/ovpn/bind.c                            |  2 +-
 drivers/net/ovpn/io.c                              |  6 +--
 drivers/net/ovpn/netlink.c                         | 60 +++++++++++++---------
 drivers/net/ovpn/socket.h                          |  2 -
 tools/testing/selftests/net/ovpn/common.sh         | 59 +++++++++++++++------
 .../selftests/net/ovpn/json/peer0-float.json       | 12 ++---
 .../selftests/net/ovpn/json/peer0-symm-float.json  | 10 +++-
 .../selftests/net/ovpn/json/peer0-symm.json        |  7 ++-
 tools/testing/selftests/net/ovpn/json/peer0.json   | 12 ++---
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
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 22 ++++++++
 tools/testing/selftests/net/ovpn/test.sh           | 54 +++++++++----------
 23 files changed, 171 insertions(+), 99 deletions(-)
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm.json
