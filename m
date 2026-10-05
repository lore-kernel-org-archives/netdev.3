Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741AF30675F
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231265; cv=none; b=gMBgk9h7R3IztM30YnNIfcMxNF9inR90bWd3WutOj7wiXWZDjeB5WN5dCDKlZeVNpg5FDSLu0AnpIOWznb/1FsbLbyHxb7lthX8G4cZyiyDfk6LWxjxSt9PqFwZsIVJXo/Ck4KcOXI/zQDe3sut/uML54U2jy0ZvWU3QlXSLRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231265; c=relaxed/simple;
	bh=VJtZChjk1YzuZkS3wi8cphgv6wsquzVP5wCjRV9LqzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a44JozISivqycbdYey9VYTx6sVX5yqLRG1Sje2rWVLW2ipmMGfOshhV3rp8Bp1zqLgyTbFhczLvGJVeccyPe8aF7T0JY2lzepgHgskkc3dhrdX+kynCRitjFxmmmB6GnFaCrrP+0lYRpTYYJPEiQ/PVmtP2ORYjXbpxIWDy0Qn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi9Tn4SN; arc=none smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi9Tn4SN"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a6124046f0so22572701fa.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231261; x=1791836061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pikQ4+zyEB4/ceyMLU0ilImsRw9sRxceQzVMlJ5+60c=;
        b=Yi9Tn4SNntOnBkpuHQBBrjCpPkYIvdZ4JSD2NJz4uvmcmB8pHNRyOGMsrViTPiFVFE
         +mxgG+v54WTJUVgOBmk24377zxS/tZywzQZvkD/lySRPEqEX0zmF3F/k7RcvLD6RVxlJ
         CDAeG+QpMgoDg86ny1p3lvbvbYIeHN8UJVNbDNQBPxWlmdEsTopj+pxqq58PBj4U2/UW
         FLqr5mosDoHP2QME4CAuFGXskVrLq3O6RJsa9uyahAvhpSefwTD4lgvlXAVtKdyM0vws
         /igv/DjlGuVKyhjkz8nxJQ/zeo5z3A5efjJNgwKMX4Pm0nDYjzIm5VPmRBIba14IKBm0
         WBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231261; x=1791836061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pikQ4+zyEB4/ceyMLU0ilImsRw9sRxceQzVMlJ5+60c=;
        b=yOt3tF2JD6/47UBNsqnH4+5vmvK7ADM8HimTBCSw9kOZ36PvSNlEIGB0I5VbOXj45W
         PLRcUep8E3L1RY2e8WtTCLBoFH69XH6eDPYas/ocxRmFDqrO7QLa3eGZdwbIKm9PX3m2
         uaqjO8ij/VFZi899DtHfjuCA/36mcxatoDcrn9qew2orChrB9U5xS4nLJbD3i1NITU04
         pG3+w7OgS2kV0ZZEAan5Q95y2W3zAFIXRxtONXscn/XuUgrSYm6+vQYx2IdkyT6PoEPX
         afiiHVTpqQH7XKKNleWwtpI/Y8uZQcXD9GDeY3C70rYadyUjEu5Cp+BQk0uIHCc3rF2v
         XZsw==
X-Gm-Message-State: AFq9FYIJVcwp2SRFMZ8BBPPuy8pbihHzf7lpZk4IddFv3DiiWugbPv6B
	8kCwoeg1b5r3xbmPOW6dL4mBIAJj1mmMnTkczM9ecQXP+mzTSVTdtKWoavcMAyGd
X-Gm-Gg: AYBFou2vpvEARpV0+YnKtWZaDzPWg2gzaQhLkamk3wGDBB7v29ap2xJKhWqMC8HkmOI
	72rZZI7xTRyPTxTpbARJG8xkM9Oh3BsehJI54sHWr8ypZbtsx7gOjNvH4jFmoTLyuhqGza3MWrs
	2Dzi7J+3tSKXHnNdhvXEr1fcrzfx6gEPCmLjQ0ObgKT1oZnH49pvp48FZCV9aNxFZyA2dHKG+f5
	HO/TYdTVbQz88NpdHJbfWt+zYbgZ78zLOqihNhrhAuw3wuYhMUxwB9r/sWOHgBLw7imGep/k9pM
	GY+rRXmGzQmSsobtsx2McA0DDZ8Qav1VHAV0RWc/Cj0H3Jegsiz2dtG2L7ZKXrvS59GFx0lXw+o
	AoYkni9DIu+7y3zmSqFoY/tfmL94viikVhu4/1YRoe/VhbkQEITaUStxc0CUfMrgT+2mz8XGNjI
	eUIoo2fgmOpT72P6CKKKloezQcWrj/RueLpwiTCteR+Dq6eK3SIIbbTogpcxSgcJesOt2Q5wCtA
	X61asPDPe1+TR/1a/F1HDXHXPAXnwwnXvk+ca/TiJJbIdDUFqOq
X-Received: by 2002:a2e:be9b:0:b0:3a9:82f2:2a4a with SMTP id 38308e7fff4ca-3a982f22cedmr15653411fa.20.1791231261231;
        Mon, 05 Oct 2026 13:14:21 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e303889sm43114681fa.20.2026.10.05.13.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:14:20 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] vxlan: generalize and refine drop reasons
Date: Mon,  5 Oct 2026 23:14:13 +0300
Message-ID: <20261005201417.906344-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series makes two vxlan drop reasons generic, so that other tunnels
can report the same conditions with them, and makes the reasons vxlan
reports for two other failures more precise.

Patch 1 renames VXLAN_INVALID_HDR and VXLAN_VNI_NOT_FOUND to
TUNNEL_INVALID_HDR and TUNNEL_NOT_FOUND. Their values stay the same;
the names vxlan drops are reported with change.

Patch 2 makes __iptunnel_pull_header() and iptunnel_pull_header() return
a drop reason. Until now they returned -ENOMEM for any failure, so a
packet too short to pull looked like an allocation failure. The three
callers in ip_gre and ip6_gre that tested the result with "< 0" test for
a non-zero value instead. Patch 3 has vxlan report the reason these
functions now return: PKT_TOO_SMALL instead of NOMEM for an inner frame
shorter than an Ethernet header.

Patch 4 has vxlan report a route that goes out of the vxlan device
itself as RECURSION_LIMIT instead of IP_OUTNOROUTES, and adds this case
to the description of RECURSION_LIMIT.

These were patches 1-3 and 14 of v5 of "tunnels: add core and gre drop
reasons", split out as Ido suggested. The conversion of ip_tunnel,
ip6_tunnel and GRE, the rest of that series, will follow once these
are in.

Changes since v5 of "tunnels: add core and gre drop reasons":
- split out of that series (Ido)
- the messages of patches 1, 2 and 4 no longer refer to the rest of it
- the message of patch 2 says that vxlan keeps reporting NOMEM until
  patch 3
- patch 4 adds the tunnel case to the description of RECURSION_LIMIT,
  which v5 did in its patch 9

- v5: https://lore.kernel.org/netdev/20260930183910.3151873-1-littlesmilingcloud@gmail.com/

Anton Danilov (4):
  vxlan: rename the drop reasons for use by other tunnels
  ip_tunnel: make __iptunnel_pull_header() return a drop reason
  vxlan: report the drop reason of __iptunnel_pull_header()
  vxlan: report a circular route as SKB_DROP_REASON_RECURSION_LIMIT

 drivers/net/vxlan/vxlan_core.c | 26 ++++++++++++++++----------
 include/net/dropreason-core.h  | 25 ++++++++++++++++---------
 include/net/ip_tunnels.h       | 10 ++++++----
 net/ipv4/ip_gre.c              |  4 ++--
 net/ipv4/ip_tunnel_core.c      | 22 +++++++++++++++-------
 net/ipv6/ip6_gre.c             |  2 +-
 6 files changed, 56 insertions(+), 33 deletions(-)

-- 
2.47.3

