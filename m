Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BF33C1AD
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715251; cv=none; b=mZNsucNgKD+5MOYuujRcjnxNKTRaUkfHRx7dFkWQhZ2g9c2XctwM263hZ+eJ//ewfB01w8SzZBeEGnnJ/kF0LGVyhDqL89DrNEwjcZHC/fLneVeicrS2lKpwQlTHjXZpNLhBUQ81GZqvS+uqoXj6gvvPL7wn7Za7CyUTQE0hF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715251; c=relaxed/simple;
	bh=sxMWATEvnbB7jLS/SFn3S0v1rf0g4hafF1IHz2TthoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5HN5qJVbcHq8ih4zD9+x+IpNUKuRR56Tu+NX8lJtE2R1H57LTKAb1zpl41K+kDtADkvntZgdMu1zujibMRwfgvSmT7xDqfet1mYkGoYmelJnkSabSE4TtZ+YmgRSeS0Gew7egOIDUupRMt4XEm7yrEUEFt/eYGgy2MTVGuLK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=ex2zPieX; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YU6UEEzz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="ex2zPieX";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YU6UEEzz"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=ex2zPieXZxgxYl0dBvduviRkf+Inv0YUM5z5Mb52lEa3/Pb2Pcvhgzl+GDGU7ybOUVA00VTvPCinxqL358xAWRyChbA9riNnKMnS+KLk2vpaiGpSUOK0RtlK4MFPPvFuKhhm/NqgxhZCeGrfPUWvbkgLw1En8RDuFZMoThz/mzchJR4ZVJxojDQroRBsLBLenwWIItRH9Vi4TD0/bq6+T2k/9Z0NR0uDy/CXqK/EBpO2pmnh4QnwLkpkXfNFbHpHM/zxjHWIGLW5E8KyXBJkiq5X5uq1NqC+dz8a92aV9I4bsiwnoPsjtRfRaI5aIkesyUrALUqiR/VLsMFvwsgNxA==; s=purelymail3; d=tinyisr.com; v=1; bh=sxMWATEvnbB7jLS/SFn3S0v1rf0g4hafF1IHz2TthoA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=YU6UEEzz767pPP++E+g/skd5g6dpRvk0iOauhyYPxVmuVHxl0+1V4dMf1xheXp7rb1B4cE8RS2OkUclNXOJ99FOn5q66P+dxLe3t9F/51xTofVLyTnNuRP3MGbq14DGuhlIWGBl7gucsfncAKUaydyCMITIfhd0GMDl/GN/RAqsZ9NqKXgoPocFiyrpfk0/LOGlsZdd4h4iWg3DtKTJR5BfIcIhuTGkB1hdOhdp/EBjDFyzOk0uPMpmRcYnAs2ds0oYa1elwzeAmLsKxoZg1otkHM9tkPaS1sq/KhrZUL5ZJEeBxU17+KyVivdSbGm4Rkp67VPWAEbF1oyrpSkb8UQ==; s=purelymail3; d=purelymail.com; v=1; bh=sxMWATEvnbB7jLS/SFn3S0v1rf0g4hafF1IHz2TthoA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1438868657;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 06 Sep 2026 17:20:44 +0000 (UTC)
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
Subject: [PATCH net-next v1 3/6] net: dsa: tag: mt7628: add bridge support
Date: Sun,  6 Sep 2026 20:16:22 +0300
Message-ID: <20260906171625.533915-4-joey@tinyisr.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906171625.533915-1-joey@tinyisr.com>
References: <20260906171625.533915-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Egress packets need to be transmitted on the same VLAN that a port is
in. Transmit on tag_8021q_bridge_vid if the port is in a bridge.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 net/dsa/tag_mt7628.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/dsa/tag_mt7628.c b/net/dsa/tag_mt7628.c
index 80b50ff08e53..fab9d4f04b7a 100644
--- a/net/dsa/tag_mt7628.c
+++ b/net/dsa/tag_mt7628.c
@@ -20,8 +20,8 @@
  * append a tag_8021q standalone VLAN tag for each port. That means we can
  * safely strip the outer VLAN tag after parsing it.
  *
- * A VLAN tag is constructed on egress to target the standalone VLAN and
- * destination port.
+ * A VLAN tag is constructed on egress to target the standalone or bridge
+ * VLAN and destination port.
  */
=20
 #define MT7628_TAG_NAME "mt7628"
@@ -38,7 +38,9 @@ static struct sk_buff *mt7628_tag_xmit(struct sk_buff *sk=
b,
 =09__be16 *tag;
=20
 =09dp =3D dsa_user_to_port(dev);
-=09xmit_vlan =3D dsa_tag_8021q_standalone_vid(dp);
+=09xmit_vlan =3D skb->offload_fwd_mark ?
+=09    dsa_tag_8021q_bridge_vid(dsa_port_bridge_num_get(dp)) :
+=09    dsa_tag_8021q_standalone_vid(dp);
=20
 =09skb_push(skb, MT7628_TAG_LEN);
 =09dsa_alloc_etype_header(skb, MT7628_TAG_LEN);
--=20
2.55.0

