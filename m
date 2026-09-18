Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17C439913
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725584; cv=none; b=TNYVG2vUunj6neM7a9EtjoNx/HtOIyr5Ag6/txOelfoTA3CWjBhTZV8r8Wq5peXCndLgbmsDMf+qKTvMxn0jzyDx5cpj6Gkzmzu9J4Jo0lFdRvpKXME3se9n67PwNiJDeQB7cNiawoKxC0oAKN3z+F9RYYMdT6Uv2FXcG8joyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725584; c=relaxed/simple;
	bh=Ub5n60r5j3pkWXxQqVxfOxFizGkkEudyJe4nXJVkmRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYkzVfBMKKhxucVF1MJJnn4XnO4s8zNsZWF9o76McT8fYBl7vcm8m8F1JxICWgZVxSvg59QhKviUa81tfpdUeOG6370u4hBPI8hVklwdZsmHLbCDQVQylbJzggqnwDVomUBVYfagqXoV/xR5JTqv7W0phnSyMGwk6QKfbQVxMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6rKK/Au; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6rKK/Au"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa4c24cso80889066b.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789725581; x=1790330381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZK2mEgoWupjXTRgi+Pjb5v5mVGfqqkUvX0U/KZzDAMc=;
        b=Y6rKK/AuvGacfrnFzzxzRkGcbS7cwlRhXixj2UEoAiwqRZwZXEhQowsrMwOo1I1Bjl
         gps19h0zRcZRy2KOBqVToVmU7lu1NtKYxClftF2UM/EFMOGFnUrLOq0ga+IgxyGlzLwe
         4ihOfICqjPVV0StqGfueqKkcqgSbL+IjhFEKGneOqpxyTS+MgUO1EKmHMzxHX8Sxxngk
         gcyc3yQ9UHIJkfEKwx8URoVG3fHJ2dwDWLN7GgCtCXF06QWtuovOfxcE2t1tjPsfUA0t
         KI4YFwKky161e9KDjB1JxEiNNNFBzdw5CcDZwjFeuW8shO4tu4W8nUvObpwBvydKBmkV
         clxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789725581; x=1790330381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZK2mEgoWupjXTRgi+Pjb5v5mVGfqqkUvX0U/KZzDAMc=;
        b=w+tOg6JGFPNu9cIvAJFtPOX0P43qI4+eSCe3WUgEhG+KIFj8w/JohBX88NOcI9WqE4
         jTr5Nc06BEYNKFlov4pKue8sF10/MPifO5BslOjxgCIlK1LVbha310Mrr8KGDzk+SCAI
         UbUpqzlfCD4Zgt2BaJ2ghiX4Z3erbNNomdnX80LQHUqHmU4SJ7aO+raK/TcwX82a8+Ju
         4rCdZ6QI92Bjbip1zspy0N0Ng4qTSmctmbVIDNGPnLEGwUtRHsYl6NLNrKnE2Y+FJs5R
         cAV3i4wFgEkcHETy1llD/kKSkVyR4u9rz59S1z+5ocsduUeAxxQt2Wsx2L9WbXaAAYQJ
         s48g==
X-Forwarded-Encrypted: i=1; AKwUvBwMdwE1c7MOsAnvJ+5m9quFsmMosmEIJ7vlaDKwh0tpgetpjewcuz1EHF2SIYMIgF5vHnCGNJA=@vger.kernel.org
X-Gm-Message-State: AFuF++njDEiRJ2aE7birX0Gbe+GH1VwfmqEAMqlxz/w9I3x4SNf754Cx
	r9dltLcxed+pTrcaX9a5/PZx4aAA4gWjIjz01iszh8joowP1Kv0Rf9zV
X-Gm-Gg: AYBFou3qKG84eP2LJpnjBIVglTbRmKvH0YJ87nltC2K5CVWEkn7/o5MIQiZH4A6/6Jk
	MHQ5r4pmSNkdAkqSiOKOwAHBKXK8s4/VNq7wdEF3zpQIZ2ufVSPAHouHrdKpCcGFfYp9IcuFZJi
	06eDMDP9pCtQIKquDfDkOaCjS4DFzm0Bb+NnedqKqEx9HkGraZdJYaSys2niyohiRYW+rOyBS9g
	WRD66y8ixIYYxh/ksw/HE+OIO/k/RNHX7tXDGxIU9oRFBRWlhlPc8PwYBAc3sKASCzLmdS9YyyD
	QbNt+PwDIKamKUy1UswHc8BRNuJVXS68JZDtaocfFIgLnJep5RnSZis1/y7XY2WhMEG99WyEsag
	BQTHRDchTasCNVg+hdowFBS4jL9yv744JY4Wu1TUSaspo1b1BvdjeCnrWo6D8cAvShTvCZomboc
	U0lqNpMw7zSfjaQ++5dPKxi1uqCQ6AFv3Zf6hXWkwiSVN4hfkgT8AA/RZKbKthVieUn6hyfDX4s
	Y1oukCUUChb2w2LSvMblHAQIff9uJ4hvq8CKytm4wAyhEWEFiGwJxQM
X-Received: by 2002:a17:907:3f1f:b0:c26:2ff1:cac2 with SMTP id a640c23a62f3a-c2a15cdc167mr226091966b.31.1789725580553;
        Fri, 18 Sep 2026 02:59:40 -0700 (PDT)
Received: from BERSOARE-M-K4D5.cisco.com ([2603:5004:20a0:100a:561b:120d:754d:a140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bbc6a99sm38313166b.59.2026.09.18.02.59.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 02:59:39 -0700 (PDT)
From: Bernardo Soares <bsoares.it@gmail.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	Vlad Buslov <vladbu@nvidia.com>,
	Bernardo Soares <bsoares.it@gmail.com>
Subject: [PATCH net v4 0/2] net/mlx5: Bridge, fix remaining switchdev ownership gaps on merged eswitch
Date: Fri, 18 Sep 2026 10:59:29 +0100
Message-ID: <20260918095931.29792-1-bsoares.it@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4 of "net/mlx5: Bridge, don't fail switchdev events of sibling
eswitch ports" (5f324c5d1b12), addressing reviewer feedback on v3:

 - The v3 commit message for patch 1 wrongly attributed the recursive
   lower-device walk fix to LAG bond enslavement order. As pointed
   out in review, mlx5_esw_bridge_lag_rep_get() already filters on
   mlx5_esw_bridge_dev_same_esw() per candidate and cannot select a
   sibling's rep. The actual bug is in the generic recursive walk
   used when attribute changes are emitted against the bridge master
   netdevice directly (a bridge with representors of more than one
   eswitch instance enslaved, no LAG involved): the walk returns as
   soon as any lower device yields a rep, and the underlying base
   case only checks same-HW, not ownership. Commit message rewritten
   to describe this correctly; no functional change from v3.
 - The v3 commit message for patch 2 claimed a "replayed/duplicate"
   NETDEV_CHANGEUPPER unlink as one of the reachable cases. As
   pointed out in review, netdevice notifiers are not replayed, so
   there is no such duplicate delivery. The actual (and only)
   reachable case is a sibling instance whose bridge offload notifier
   registers after a peer port was already enslaved, so it misses
   the link event and never tracks the port, then genuinely receives
   the later unlink event. Commit message rewritten accordingly; no
   functional change from v3.

Tested Patch 1 on a ConnectX-7 NIC (MT2910) on my single NIC system.
Patch 2 requires a multiple eswitch instance setup, so I wasn't able
to exercise its code paths.

Note: v1/v2 were sent From/Signed-off-by bersoare@isovalent.com; v3
and v4 are sent from my personal address (bsoares.it@gmail.com)
instead, for unrelated mail delivery reasons. Same author, same
person.

Bernardo Soares (2):
  net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
  net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer
    ports

 .../mellanox/mlx5/core/en/rep/bridge.c        | 45 +++++++++++++++----
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 15 +++++--
 .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  2 +
 3 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.43.0

