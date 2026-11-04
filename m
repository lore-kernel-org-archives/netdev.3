Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784095;
	b=wcLh/HdiUdHtNTRJF4MqaTHkPaItU4H6OwsGYyRjzj6Plm2JgYp1Q1T4bU/mKfgV4yl9
	 XZzVHhTerOBOu7VnEHowQ+4GcwyuOfeZBEbFQP1ho82Pim86dUpirlQlT85ddZ1F5HDUm
	 zPQAdPlN0NxNJ43Qlxo7QtWvRZWGakN16f0SwAZdI3dp5byTWgM9bpbFc6Fbe4hB2c9ka
	 ibZEdg5itF2CFH+LEZLCSjNXsk7Q3Ofbh8axorg8kL+pw9IUia4tmUOTHzVpEEPgbBM2F
	 5O/UlJVju0ozGRqJx9aX63ocAEzyq6PXrlqCPcLuJQUML+BLTds4V1SM5DbhWaeaadg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BnaqbrZYBPVpjbjm6kaz+k24LiVJFPqV80JgE+r/5Z4=;
	b=xRd4XRZOW14EgbLRSUzMc78sdckxE5RD5/WCxJBBll62EkhkkS7RDSezO06iQbLQJi0E
	 f4jAbX1FILekBhURjSjZoe6BACh7v3XBjta2eoHmuhBPZZS12Pmj4kmJgp71O6hUwOZo8
	 Uzjr8x5Vy0U4vfL/fCFtSTYgZssij5Xr+BfpM3Kto/CgINJOVyGGqkGEyTZR6PU4TkoQK
	 6jP5MV7rIRhpfurDp4bstZCmufcEkqZTtGgTsfabcYG1BctaavaCt0/FdAdfQEPic9aJp
	 nGXwflGJeq0PvQdw+HE8nOPaKEynXRQDy+FadXjWgegnCCnGunhVW9S6rsvuXWipv+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqtaw1X7;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8838606A33B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8838606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqtaw1X7
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15943c9c005so1356708c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793784094; x=1794388894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BnaqbrZYBPVpjbjm6kaz+k24LiVJFPqV80JgE+r/5Z4=;
        b=pqtaw1X7H5Oql/mVKQz2c7B0POyLbeIwXZcI80h2TL4p7O4wp4xn6pZ3g8H6ubOVgp
         ghvqhAzAPkrGdKBLiako1QXMB8yuumv2pqIQ8QXRgfeCzFeifPDCGgdiEhaEJdtJVkal
         PKpwo6js8ngZZa5AafIiXnwgsjBSDFr4+hEvM3HyrG6pUAHkLCeslIyrkYiRvoLXbKKN
         4lgR9O875zYcyLyNubWOWOPW16PXdVAk64KpjkjQA+RWFSdIOBP8J5GImbGS7l3L7yCL
         14a2yk2MUYU7hFYK3EnC3rtv7EqLrcqS6hia0VbpyFNSARzMFzO/goWpedfKoMRwW96g
         /cKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793784094; x=1794388894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BnaqbrZYBPVpjbjm6kaz+k24LiVJFPqV80JgE+r/5Z4=;
        b=zOcTZwpmBnVstBVygtY3mttOuEyKg7OUn4r+bU3O7ixvC0Uuu+ETSLk363HAIxeuLv
         94FmEGkZAk0BVrdYDbUTnyhGfS5zmtmUClnbjetnjd9+cPmGGD0yVKXL3JgY+YAWimao
         wkIxukP4cYpRPy9YGjYZbZefSpyiJhPrhdOfGomk96coeum7OuF63zh1Bc8iQztESAnU
         2kNDqxgFoPIcgqrrd85ADLXBgFiTx2wSeAjjVGpUpra9FGiiiynGo8VlwC8X0oLfWrLs
         ZC5hp9G8aAxPOJCAF0d9VmeEPR6oTegnHeKI7dp2VOzv4o64FHHr3DE5dO7ENHb+gQRI
         cUJQ==
X-Gm-Message-State: APuU4Z/nH7ijPFSBrJk64jXfT4AmPKytsqR3CSAfMuGQ69Zj/WQDOu9e
	F1HnvAPmBVrw+y2hMKkajSAWtSBId4p5hJbIHW7CJPxYQE26bd9WjQ7Mt65IbA==
X-Gm-Gg: AYBFou1DNA4VAgiwa1aSaGR/0q1fT+jlMC/wJYzPNhaKEqRY+d84RaEvGuppVK3qd5T
	U8haqKNNYRvsNjJKMISxFntJrJzEFJ1gjsVadY3LgVlBq7zqV/XizFtzpCJzPRbriWGthT5Hxg0
	sbtk5ENKyKq0upXY3klPMV117qhKKcALGlsGKkFvDOwLf9p09iGYhxbeccRFuwcDtyDqBaIXl4K
	+A1Q76+Js70rt1gzmb3GJEbi4daevTJBkgd/DOZ71pJxDVkJddF+79ymrh5FOowsvMJHu9w6F6m
	HOY9mAeI/XameYS4GhEMX35zC2ebHKRQisDrsuDGJmtxBL1vixSxIHjA7xOrOSDBcWKIbBrztUo
	/39U6x/WThbp7TIsqgU78OdlNFiwjAHajL10m62UMKZ0xX+IBMRN2pFqjFcLAHrTtsCErD2KsWi
	jlUyWfQQApR3dJcieY6ivcIMaB6gV//RAuSI2h+ot57NtonxJ7SbbDyvMZfzxBAp5OaSdpzTgFz
	7gkdiQ/3N1uPyDmJXtBslDU0l0tnJ7PHb/cXaQK3EjptTy7cBs8oEob9L9g1EvLZ6mR/NJQc6xu
	5byTGqHQ8WUNtHjnymH1HrjbRZ+RXKIntVtCkZmg3CpMnsXnxEIDvoyUPz76mzHfvcNdRPUrCkZ
	qMmJljb8CnYvac/ydT+scJcdpZzWVXLf4pAgHZGn8c2WcM3r5kH0TiT4Q7dnADv1YzDl/tJw+RQ
	==
X-Received: by 2002:a05:7022:1181:b0:154:e9d2:d741 with SMTP id a92af1059eb24-1ac5bbb4870mr20798515c88.8.1793784093531;
        Wed, 04 Nov 2026 01:21:33 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b87c4asm6058628c88.3.2026.11.04.01.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:21:32 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <martineau@kernel.org>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net v5 0/2] genetlink: fix joining multicast groups no family owns
Date: Wed,  4 Nov 2026 09:21:23 +0000
Message-Id: <20261104092125.211537-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

genl_bind() checks the GENL_MCAST_CAP_* flags of a group, but the
membership bit is set later, after the lock is dropped. A socket can end
up a member of a group whose flags were never checked for it: when it
joins a group ID that no family owns, or when the family of the group is
unregistered between the check and the point where the bit is set.

Patch 1 rejects joins to group IDs that no family owns: setsockopt()
returns -ENOENT, and a bind() mask skips them and joins the other groups.
Patch 2 counts,
per group, how many times its members were cleared, which genetlink does
when a family is unregistered. If the count changed after the check, the
group is checked again against its current owner, after the bind
callback is undone if that owner is the one it reached. The core cannot
always tell, see patch 2.

Tested as an unprivileged user, with an msleep() added after the bind
callback in netlink_setsockopt() and netlink_bind(), and a test family
that registers again with GENL_MCAST_CAP_NET_ADMIN:

                                         patch 1 only   v5
  setsockopt:
  unregister in the window,
  register later                         member         not member
  unregister and register in the window  member         not member
  another family unregistered
  (must still join)                      member         member
  bind():
  unregister and register in the window  member         not member

With the msleep() before the bind callback instead, and a test family
that registers again without the flag, the family is bound once, and not
twice as with v3:

                                         v3             v5
  binds while a member, setsockopt/bind  2              1
  binds once the socket is closed        1              0

The test family counts its bind and unbind callbacks: they stay
balanced in all these cases. If the family is replaced just after the
bind callback returned, and before the second read, with an msleep()
there, it gets one unbind too many. The socket is still rejected or
checked against the new family. Normal joins and rtnetlink bind() show
no change.

The test from v1 (join all free IDs, then load gtp and drop_monitor)
gives the same result as before.

bind() with a mask, as an unprivileged user and as root:

                                         v4             v5
  an owned group and free IDs            -ENOENT        ok, owned group
  all IDs, as root                       -ENOENT        ok, owned groups
  only free IDs                          -ENOENT        ok, no group
  a group the user may not join          -ENOENT        -EPERM, no group

With a test module that releases its kernel socket while a socket joins,
v4 gets a NULL pointer dereference in netlink_setsockopt(), and v5 returns
-ENOENT, with one unbind for the one bind. I did not test this with a real
nfnetlink rollback.

I used an LLM to help write and review the code, the tests and the
commit messages of this series. I checked and tested every change
myself.

Changes in v5:
- Patch 1: a bind() mask skips the IDs no family owns, instead of failing
  as a whole, so that such a mask keeps working (Jacob Keller, netdev
  Sashiko). This changes the patch, so I dropped the Reviewed-by tags.
- Patch 2: return -ENOENT if the last kernel socket of the table was
  released and the counts are gone, which was a NULL pointer dereference,
  and call ->netlink_unbind() if ->netlink_bind() already ran (Sashiko).
- Not changed, from the netdev Sashiko review of v4: the counts of a table
  whose group count is reduced, and NETLINK_USERSOCK having no counts.
  Nothing in the tree reduces the group count, or uses the helpers with
  those counts on NETLINK_USERSOCK.

Changes in v4:
- Patch 2: read the count after ->netlink_bind() too, and call
  ->netlink_unbind() before checking again if the count had already
  changed: ->netlink_bind() can have reached the new owner, which was
  then bound twice (netdev Sashiko). The commit message says what the
  core still cannot tell.
- Patch 1: no change. It does not close the window on its own, patch 2
  does, and it keeps its tags (netdev Sashiko asked about the order).
- The deadlock netdev Sashiko found on the insert failure path of
  netlink_bind() exists without this series, it has its own patch:
  https://lore.kernel.org/netdev/20261102120929.4077030-1-anilkaushikwireless@gmail.com/

Changes in v3:
- Patch 2: check the group again in af_netlink.c instead of clearing
  the members when a family registers. This also covers the case where
  the family is unregistered and another one registers, both in the
  window, does not walk the sockets on every registration, and does not
  touch the members of a group another family still owns (Sashiko).
- Fixes: tag of both patches: the race exists since genl_bind() first
  checked a capability, in 4d54cc32112d (Sashiko).

Changes in v2:
- New patch 2 (Sashiko).
- Patch 1: no change, added Reviewed-by tags.

v4: https://lore.kernel.org/netdev/20261102155819.4100930-1-anilkaushikwireless@gmail.com/
v3: https://lore.kernel.org/netdev/20261101101347.3910654-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/netdev/20261031054632.3697295-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/netdev/20261029062214.3407223-1-anilkaushikwireless@gmail.com/

Anil Kaushik (2):
  genetlink: Reject joining multicast groups no family owns
  netlink: Check a group again if it was released while joining it

 net/netlink/af_netlink.c | 116 ++++++++++++++++++++++++++++++++++++++-
 net/netlink/af_netlink.h |   1 +
 net/netlink/genetlink.c  |   3 +-
 3 files changed, 118 insertions(+), 2 deletions(-)

-- 
2.25.1

