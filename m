Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02423A5421;
	Tue,  6 Oct 2026 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270409; cv=none; b=VSRWXfQR3s7pq1W2Yg8yM7RlwiS94vegKZGPRC+JwyAlMUHWRo1QG23zcC1G62UdQ8yZq0t615BxON8ydwgB+DOz0xNEOLph+sexXJ0ENM2ts034Yp/e7DmhpbrOVfCY59Ksh1AOFm0cquont1y+Z/USwr03U8eqVDm6CnA8/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270409; c=relaxed/simple;
	bh=i7cCphistmESTBYJYAwL/9Ci++Tyx5jxFUdl6X4gVFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHqe1g/BnGEe/Y4N3iudQvpeFNXp2dDvHcidaYQrJaObxnFlw9FpVNenHaOggIBw8Uu2CBCjH99koQkxJRQD7VBFw2V+b8A3OiY98cTcvs5pVD7TlBQdYHDThDtjzJYGIrlfvHbWQXfzKtGrHZj+7O8+Sd05VrkrN5NWc4ABouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=xygIYykX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="xygIYykX"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6500020704;
	Tue,  6 Oct 2026 09:06:46 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ZVQDZ7IJvvs; Tue,  6 Oct 2026 09:06:45 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C1BBE206D2;
	Tue,  6 Oct 2026 09:06:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C1BBE206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791270405;
	bh=uedCclccNIiXPhNdgryI1OTyG2Jkkaf9ISHIPonBYR4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=xygIYykXh45GNvpD2kIP2i70AY7ItPenHUr6W5h2kFwdJRB6NG4LNk0WJod2hIxgI
	 CtYxpbj9RPN+3gR6ra6JMmL9AI9rnWiubtuYzdS31FybvjDk9NTv2RgimkbD/AsiSf
	 I9OJMzVsTtDDxXOXMFx51DhXWELvuopQYTc7bJVnMqpeM7tzHj69zCsmj5JcVJh1Uz
	 iEOuc8GWFdfjIHikTHJUsi9/ti79NzjL9WChZmIJ8zR8IrdRTnD50kmlrexbSoavmK
	 hb5thJKa1teXc7nu7Zs/t6dwyYUk0Oe+KkqP+DwEaq9Io8VmBAq/rI4XSSEp2eUjCe
	 uqRK678cHrcmg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 09:06:43 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>, Paul Chaignon
	<paul.chaignon@gmail.com>, Louis DeLosSantos <louis.delos.devel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec v4 9/9] docs: xfrm: include mark in XFRM_MSG_MIGRATE_STATE EEXIST tuple
Date: Tue, 6 Oct 2026 09:06:33 +0200
Message-ID: <migrate-state-fixes-v4-9-d5054459fc78@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
References: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

Document mark as part of the EEXIST tuple and update the SA lookup
description to match.

Fixes: c13c0cc6f52e ("xfrm: add documentation for XFRM_MSG_MIGRATE_STATE")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 .../networking/xfrm/xfrm_migrate_state.rst         | 25 +++++++++++++++-------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/xfrm/xfrm_migrate_state.rst b/Documentation/networking/xfrm/xfrm_migrate_state.rst
index 9d53cb22b007..ca2c9e5aaf33 100644
--- a/Documentation/networking/xfrm/xfrm_migrate_state.rst
+++ b/Documentation/networking/xfrm/xfrm_migrate_state.rst
@@ -27,15 +27,20 @@ SA Identification
 =================
 
 The struct is defined in ``include/uapi/linux/xfrm.h``. The SA is looked
-up using ``xfrm_state_lookup()`` with ``id.spi``,
-``id.daddr``, ``id.proto``, ``id.family``, and
-``old_mark.v & old_mark.m`` as the mark key::
+up using ``xfrm_state_lookup_exact()`` with ``id.spi``, ``id.daddr``,
+``id.proto``, ``id.family``, and an exact match against ``old_mark.v``
+and ``old_mark.m``. Unlike the data path, which uses a masked
+comparison, this requires the SA's mark and mask to equal ``old_mark``
+exactly, so a broad-mask SA is never matched when a more specific one
+was intended. If no such SA exists, ``-ESRCH`` is returned.
+
+The layout is::
 
     struct xfrm_user_migrate_state {
         struct xfrm_usersa_id  id;       /* spi, daddr, proto, family */
         xfrm_address_t         new_daddr;
         xfrm_address_t         new_saddr;
-        struct xfrm_mark       old_mark; /* SA lookup: key = v & m */
+        struct xfrm_mark       old_mark; /* SA lookup key (exact v/m match) */
         struct xfrm_selector   new_sel;  /* new selector (see Flags) */
         __u32                  new_reqid;
         __u32                  flags;    /* XFRM_MIGRATE_STATE_* */
@@ -72,8 +77,8 @@ inherits the value from the existing SA (omit-to-inherit).
      - Description
    * - ``XFRMA_MARK``
      - Mark on the migrated SA (``struct xfrm_mark``). Absent inherits
-       ``old_mark``. To use no mark on the new SA, send ``XFRMA_MARK``
-       with ``{0, 0}``.
+       the mark of the existing SA. To use no mark on the new SA, send
+       ``XFRMA_MARK`` with ``{0, 0}``.
    * - ``XFRMA_ENCAP``
      - UDP encapsulation template; only ``UDP_ENCAP_ESPINUDP`` is supported.
        Set ``encap_type=0`` to remove encap.
@@ -259,8 +264,12 @@ Attributes in the notification
 Error Handling
 ==============
 
-If the target SA tuple (new daddr, SPI, proto, new family) is already
-occupied, the operation returns ``-EEXIST`` before the migration begins.
+If the target SA tuple (new daddr, SPI, proto, new family, mark) is
+already occupied, the operation returns ``-EEXIST`` before the migration
+begins. "Occupied" includes wildcard shadowing: an existing SA with a
+broader mask (e.g. mark 0/0) claims every mark value, so it blocks
+migrating to any more specific mark at the same tuple, not just an
+exact mark/mask duplicate.
 The old SA remains intact and the operation is safe to retry after
 resolving the conflict.
 

-- 
2.47.3

