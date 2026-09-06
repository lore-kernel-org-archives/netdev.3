Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFED3BADBD
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715247; cv=none; b=jka09Q3FHCo9BeAGJhPcDzQn4RtJtwsQXl/mLSrau+kN0dr5cqzuMKbqkt/NhFyniLu6eAsqUSkpisckWxjmh6GL2JTs6QM43C7wMwQUciLKhXFNfB2ZUVEOr7mybk4AlG8cF6zHNWNitvwIcux7l5gO0jI29M0/yjbUVyi3ziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715247; c=relaxed/simple;
	bh=cnwDFkTViudPqqhFMv0hg3bRkdM0VccIQXyrvLrWK/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n7ZDQMquTfsgRlRihWr+YniwSgqCoYlCCSBawydKg8dIV2J93ikOZ3qhgaJAILDm9bDH5rGXXcmQ5/HdO8ECJTw3OimCwb5+ynh81RTqSbI5YUrKGiJdTk5HSqQqmr3RLOxbdbdAdFZsUOP8KuP6Fcafu//Ywd058ZkM133VIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=JFNxJIvs; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=SOQfzDMd; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="JFNxJIvs";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="SOQfzDMd"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=JFNxJIvsy4e27skaNrTzvov8XniLZG7v+U3Tb25X5b4YtX8HvUvMs6q7aO7tKzQspxlbJAdY/rQtihu68sGoWYJrMxp1qYid0SGJPLWXkvarFEgPPCRcA06/PDz698/IyBns+YO/J0cNi0lTpirMhOAp3Niwkt5YZAEcSRBE8fF7RlQ+MBac0YCudE70U2I8gzj4KxxvwDR7qjVvj6bWnvFFQM1rLda8sAjyOMJfjMYK/cJM40yCwv0Kz36XNNmYxMatAad1mn7vtSTGYG3wmpkl4ngxKntvF708fIzCidwcRKUPSvpKTclQZilA3TdoWL7RpPOPQsJAHGsSyUoS0w==; s=purelymail3; d=tinyisr.com; v=1; bh=cnwDFkTViudPqqhFMv0hg3bRkdM0VccIQXyrvLrWK/U=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=SOQfzDMd0OxP0qVidu9AMf3BxKt+gJwf2rkc66hY6kk6nLYvf32e0RXVBvuk6q6N8g2NI9l9rzk7dS8tHtSNWiLhXbfoQj68PTqTiXapgpBVV9H/wJOciYqKZKgL/1DHRnEz1yqjo+Q48+IXCYO0d/7WvTIzg4reOhZU9fuOX67f/bbvVBqBO5T1UcbTPc24uXqd4XBIuCs09Rhc/uB4e6GZPsu9XtmDeW1Xuq7XTTeWCkZfvXC3neNml+0VXmrOo437nHuJITaMs2lMJselvpWXFoao0OcMTDQbfXsvOsRLbJFN8L3aXMNOEyECHJyw/SDMGbpi63TDqbIHm7S5aA==; s=purelymail3; d=purelymail.com; v=1; bh=cnwDFkTViudPqqhFMv0hg3bRkdM0VccIQXyrvLrWK/U=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1438868657;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 06 Sep 2026 17:20:37 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v1 0/6] net: dsa: mt7628: add VLAN filtering support
Date: Sun,  6 Sep 2026 20:16:19 +0300
Message-ID: <20260906171625.533915-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Add bridge offload and VLAN filtering support to the MT7628 switch.

The MT7628 switch uses VLAN membership as its forwarding mechanism. This
series uses tag_8021q VLANs to emulate VLAN-unaware bridge forwarding,
while using the bridge's VLAN configuration directly when VLAN filtering
is enabled. A major limitation is that VIDs cannot be reused between
separate bridges, as this would allow cross-bridge forwarding. tag_8021q
VIDs are also reserved for the same reason.

The switch driver adds 6x "reserved" VLAN slots for use by tag_8021q
that are only programmed on VLAN-unaware ports, together with double
tagging, while the remaining slots are only programmed for VLAN-aware
ports.

The tagger is updated to preserve the existing VLAN tags on transmit and
receive.

Thanks,
Joris

Joris Vaisvila (6):
  net: dsa: mt7628: rework vlan block allocator
  net: dsa: mt7628: add port bridge offload support
  net: dsa: tag: mt7628: add bridge support
  net: dsa: mt7628: add VLAN filtering support
  net: dsa: tag: mt7628: add VLAN awareness support
  MAINTAINERS: add myself as MT7628 embedded switch maintainer

 MAINTAINERS              |   9 ++
 drivers/net/dsa/mt7628.c | 305 ++++++++++++++++++++++++++++++++-------
 net/dsa/tag_mt7628.c     |  66 +++++++--
 3 files changed, 313 insertions(+), 67 deletions(-)

--=20
2.55.0

