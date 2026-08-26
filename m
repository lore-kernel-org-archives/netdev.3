Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A902C17A3
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757354; cv=none; b=Q21+HdMxUkt0SgT879xzjV4qzAdOHrG7fOSnB9B6SgrgcPyLDJ48JKMFKyLI3Xa3pv/eVaafQDEdchHrkpXm85VL364KuULBV5u/K3Dr19sdcXFkFj8Hli/qqxQh6debspQG0fEFyMh190y9aEAlrsiSQmJb2O+32/Fe3aUAvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757354; c=relaxed/simple;
	bh=bAuBeeb68Py8UGRJAItmIrBFGrQoRBO6aHLkKHMvBDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9LGrSE1AgJimfi1e6/aLcF1vOHgitYRJ9tU0gFj3+5E6JjV/cQvFwDsS/8mW4XSYPRf9QaI0D5AjdVNHpcqxtON8flCxhUxRs3jL9Bld/XgBmEiIUF3uwoEX2N2u/XGGWR7cksnuqnyEk+lC21Q1QVDZyBuI9AXBeMauoNNY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=EmTn0K7L; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="EmTn0K7L"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1385618a91.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1787757351; x=1788362151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UXbEbgExHY/t7d7GNe8mdR88tmMCAvM05gHfcSb0VPo=;
        b=EmTn0K7L1UMPlKyGy4wV7/d3AJSBVvviTcEWv1likUTJUaLeboOE4fJndxZcTxe5aF
         2rMEgzVw1n+lCepccfCWnlsxtzMx4TPLqXX4fdBT+/V4lVs//Hq0JXDpb2LW4OYk9/cp
         lrmteIhq776OH7tzrdxAfau1Rvfq323b/C4Kt08BDiMG+Y6Hp+hq3oDCJCmwxRBqdusF
         9lPjtJVDXhgKtNeU6w07VSiAzewjnPGdm7kOhFq6QrIGvchcv6UlFOzSNmAvYoetbaZ9
         /fobAZuODcLi0QoOHBwKoDK6SsvOJi/4led6BsaG2tOp28cRsxHniC/QR3UxeOcVUyhq
         D9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787757351; x=1788362151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UXbEbgExHY/t7d7GNe8mdR88tmMCAvM05gHfcSb0VPo=;
        b=ifM9FnXWc4UhbCv2QwnYadAKm82HstMly2RiPU3HOjlxrIYdFLg75FgaxDzqOp1N8R
         asD51BTzdrWQWNK0yPfilgCjYlhG0BKsBZpko21lagcyGbGup57ngp6QP1I3XyzBva1z
         vM6Pwjs32WISS4N2KmF3EZq6LoQTfkmqLZQKhzpOAA4+iHMpvk4DVWINFC9bKFl+pDBi
         nqkNYiUg3EMypsfWKmZrKsMfBBe0omgr1fVl+g+N2dKYxatUgzesyiXmehDoZzbG428G
         6dfEdAktJx0d7Y0JYk/x1tBsYHza88ZQGb2XDZbANgJ6jVMdWgS8IP+RVkXPkbOAFK1e
         UGyA==
X-Forwarded-Encrypted: i=1; AHgh+RrxglA7lKf36k9tX4kZJdK+8WGM6PBzw23AqfGqr/scWq7gRZlTW/f/u56WppvMITaBDLDUy80=@vger.kernel.org
X-Gm-Message-State: AFuF++lp2dXTxFBOWOzwGOV5DJEGtUD7Gfl0zB9P/zOQvP/JV04Hj2LC
	BaJD0cO6F6lKTC69hBCSZ/wvTTOCBaUyj7tITbWk3HH8Au3oqDTP1uVoAz7dlSBR0AQ=
X-Gm-Gg: AR+sD12Cs/yQjFtRPo9CnQ4MeclW6R6tqxC0kBZuhaOmKqIZqJBqqLvQgK8NhfADQgj
	9F0w66FHH0kxr2oG3miXMFYj7LWGsg96EnyhKsvNEq3oR3l1/0GVe6U7YBHqjFJsIZS6CDtGxEe
	giTPjs1v1t0DCYPUIFUHR71B90+PsAd0qvYRBND7ung55BLmFg8uHm1yIo61tdAX1oYlyggjX/1
	3cCSZWmLtk5bGH46dab3Wd2jVK+yE/JXNEhebo1gFhzRBkH2NSr9KkgtPr6ZjLB4u8lrbM6a5Z2
	C6xdxQV38ezfaMPQ30Fe4Z38jY9yq1Wen0C0dt5SstnGaD3LTJ17souAuyGTB+/A8Ygr1WlArhj
	zU3PizYaB1EAxeoNkSvJAJ5+kxcXITCTVzBiBlwcheqGJ2toEpQqIpXuMMm+7NyANAfMd5RnvwG
	9+up6MOAMB8uvqfYTII13N7zfhuKV0sHkZ1UFZ9bG8amp+mo2R34cJB+c9vAz+bvJeXn1fOdbqu
	Zve88ILK0wAwokl7zJ6EkpU1c+HNjwIhHrwTw==
X-Received: by 2002:a17:90b:3b4b:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-3966d8b6295mr16465687a91.14.1787757350757;
        Wed, 26 Aug 2026 08:15:50 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm4831991a91.13.2026.08.26.08.15.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 08:15:50 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Baul Lee <baul.lee@xbow.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com
Subject: [PATCH net] vxlan: mdb: Fix use-after-free in vxlan_mdb_remote_src_del()
Date: Thu, 27 Aug 2026 00:15:42 +0900
Message-ID: <20260826151542.68815-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_mdb_is_valid_source(), which validates MDBE_ATTR_SOURCE and every
MDBE_ATTR_SRC_LIST member, accepts the all-zeros address.

A source list is only accepted on a (*, G) entry, whose source is the
all-zeros address, and for each member of the list an (S, G) entry is
derived from it by substituting the source. Entries are keyed by a plain
memcmp() of struct vxlan_mdb_entry_key, so if MDBE_ATTR_SOURCE is present
and holds the all-zeros address and the source list holds it as well, the
derived (S, G) key is byte-identical to the (*, G) key and resolves to the
same entry. Omitting MDBE_ATTR_SOURCE is not equivalent, as the key is
then left with a zero address family.

vxlan_mdb_remote_src_del() removes the forwarding entry of a source before
freeing the source entry:

	vxlan_mdb_remote_src_fwd_del(vxlan, group, remote, &ent->addr);
	vxlan_mdb_remote_src_entry_del(ent);

With the keys aliased, the first call deletes the remote of the entry that
owns 'ent' instead of a separate (S, G) entry, and frees 'ent'. The second
call then runs on the freed entry, and its hlist_del() reads ->pprev and
->next out of it and writes through them.

Adding the (*, G) entry with NLM_F_REPLACE and no source list marks the
all-zeros source for deletion and reaches this from the sweep at the end
of vxlan_mdb_remote_srcs_replace().

  BUG: KASAN: slab-use-after-free in __vxlan_mdb_add+0x1cd/0xd70
  Read of size 8 at addr ffff888102852500 by task poc/84
   __vxlan_mdb_add+0x1cd/0xd70
   vxlan_mdb_add+0xc0/0x140
   rtnl_mdb_add+0x157/0x2a0
   rtnetlink_rcv_msg+0x207/0x5a0
  Allocated by task 84:
   __kmalloc_cache_noprof+0x153/0x360
   vxlan_mdb_remote_srcs_add+0x2eb/0x440
   __vxlan_mdb_add+0x803/0xd70
  Freed by task 84:
   kfree+0x14c/0x3b0
   vxlan_mdb_remote_del+0x129/0x1a0
   __vxlan_mdb_del+0x4f/0xe0
   vxlan_mdb_remote_src_fwd_del.isra.0+0x162/0x1b0
   __vxlan_mdb_add+0x1c5/0xd70

The MDB operations are netns-scoped, so an unprivileged user can perform
them in a new user and network namespace.

Reject the all-zeros address in vxlan_mdb_is_valid_source(), which covers
both call sites. A (*, G) entry is expressed by omitting the source, so
nothing legitimate is refused.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/net/vxlan/vxlan_mdb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index d71e1925ecfd..7986c5b5dc67 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -354,6 +354,10 @@ static bool vxlan_mdb_is_valid_source(const struct nlattr *attr, __be16 proto,
 			NL_SET_ERR_MSG_MOD(extack, "IPv4 multicast source address is not allowed");
 			return false;
 		}
+		if (nla_get_in_addr(attr) == htonl(INADDR_ANY)) {
+			NL_SET_ERR_MSG_MOD(extack, "IPv4 all-zeros source address is not allowed");
+			return false;
+		}
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6): {
@@ -368,6 +372,10 @@ static bool vxlan_mdb_is_valid_source(const struct nlattr *attr, __be16 proto,
 			NL_SET_ERR_MSG_MOD(extack, "IPv6 multicast source address is not allowed");
 			return false;
 		}
+		if (ipv6_addr_any(&src)) {
+			NL_SET_ERR_MSG_MOD(extack, "IPv6 all-zeros source address is not allowed");
+			return false;
+		}
 		break;
 	}
 #endif
