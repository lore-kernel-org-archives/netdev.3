Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984181;
	b=gzpBT5nQgFetGv90nXTAHXKWnZyPk6VeLt9p+kIBgSWWRiXFgoGWEQFrgwGTrF/Cm9SW
	 HAfgwh6eUZUtTAP1LyFbb/5+xjjA9nq9pgG0eLQJVZ/Ujh9jpDKotDc1Y4lAt03QS6Lzj
	 J7OVXe9WxyFs0IdVosjUdGECnyT8k8oVfy3tp5APeRsFqn+uq8zs1zAnnxBhlnryaX+sD
	 N/ByAvlx8dkK5G6kO1Ry7zOWW0AVeI1CO9JnhhQ4BfCSmYbH8ZYcEJRsKj/nPyPHxT9mM
	 vhF80q1HZdiL8t47/4saZSqA7IL3mla6+CBvduNGEmgYUTi1xeJiemwqGt0J56bekWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cTXVJUOKRughwuSMYrqOOlwP+3rFl6wn/3gsJxxcBAs=;
	b=4TxgiIdhnbwpX/Lu6i+KCIseJ+vf4rAsL2ZwAgwvpRzm3BUE43swOGLyc5OL/eK1Cx5k
	 dXffY1jViYHz2cthRMePkcbPIjsPhuJIJhQEkcx8rHt00IlEy8+87BddXW0GT5wFJKwTg
	 /QwXHJV2O+MZMJFwzUkUwCW9DNGM/VAytpVGMuxQaK2nftYFWr3P4f4fvzDEH1pPUatSz
	 Y1EgUqbsJH0CiW/G//M8+gSfgmLZH2vfmU80LD3+V/gTqCu0JL83ypUDTyyvLimO2cZ13
	 4xhbo80XbX4iyX8x9MsJ/eVUEyySjuuwbhkUXeMivveST5oSB6wP/G7hDQXRYghm1Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a9vwO6vH;
	arc=none smtp.remote-ip=74.125.231.137
Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB370606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB370606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a9vwO6vH
Received: by mail-oo2-f9.google.com with SMTP id 006d021491bc7-6de19ccd89bso366866eaf.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 20:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984180; x=1793588980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cTXVJUOKRughwuSMYrqOOlwP+3rFl6wn/3gsJxxcBAs=;
        b=a9vwO6vHViR2IX71zNqDPxMmiKNbdhMXQsJDsyOC6Dc3KyPpmggtN6/HcRB5LPL0KS
         KrflVexMxIHJZLnl58zHgz5pcVGamHHVCcmTuNfYJgqysLIwKYAbIlCHDPvYlmaHkkDe
         gCXTvxAwVxiCPNHi858NcbI0SrwXK8X7W79fsLHMkjnAcMP0QkL/YwdM1x9VR0nBOPSO
         hdUomy6/i/ehZc7jXvjfYuNb4u0GtYx2YhFtPJtKIh5DDPKY1p1AiDmzMJCs87hiSaUj
         lQz17fXmF0n1CqTa5jVcRQwpY5LnyBYEzZJ43foTCPO5bC7XApYEuTkLfamggna2TUgB
         c7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984180; x=1793588980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTXVJUOKRughwuSMYrqOOlwP+3rFl6wn/3gsJxxcBAs=;
        b=bnKSgU06V7jAETMBAvg28xHlaU/oky+cHwEFp170lY06QlOYevWUu+Z2k7Ap2mbhcV
         fxcOKSlLVjv6cxGs0PCmLeWfm7Cpq7RDbI1AurpR1anJgVvu/aMBK90UTb4wnI220vBL
         BE5MugIdiYTpuo/Cq9bO2m8JGQQNFF3Xe2Pi2WYeEkSwDI1koYGpHZuuIWX0lxmvzATL
         +J3kbCW0NuueGqxk8f0gOT1HKm/Ai8nwXy/MXyU7HxIQJI69wNu/U3PAoNNYVQvzr9t8
         zwAy6zhC6/exsk4QYucqAH3x0YXMXLmtpf5fP4f/OOCnbBiVUc/TJi2I/V0CMFAWAPWu
         XhuQ==
X-Gm-Message-State: AFq9FYJqd61SxmF6qlgxAn+5vuDmn3P3ODH8XnkbVsCghEZrEKWlPTSQ
	q/JGiRqPFmO5RnPZ3vfnD8s/Ax27PnldaN4osaMr8n2lPyBcscXFasEh
X-Gm-Gg: AYBFou1L5h4dURBpyWgT5FeWJ6fD8Cqisvk8e0KWKab9dgXyBsB4YoX2aD8lDPkiO+o
	F+hjJXm/QUFZc1qyAQI1SiKxjjy7k31qmp50Wy8zucGHBHBXrE7P2u3vhpu+WgFniN3/RA9aVF+
	D3k8ynSzw4cgpzXrryD9SZe1Eth2RCciTcNa0OqdJKwLoWTZWLkmF334i/FwyHvcG0butKrYdkQ
	fczBG5R6lVSrK2t+97D5O53zsrFCyQD1NX5Omhzh+GpFd8vMXvNDf4lNNQMhD3/ycycjOc+nKvN
	sKvWOmJKJBaapjmQGdIxFxVsAt77MdH55FI9MNASMr0GOS41/SuI9ZrPc43QjNVoYy/n8fsPbTn
	CIdwjZyYtFgX7qi7NTuY97jDc6ES43/NpWEGbeMA67EktfMnxFsXBDVxIoHCgaBSoDkO0pSbPiw
	Qv05JC7ZQ6GUVTCc3KQtX6Xmn0Q8mfM+u8R/mcW7MQrcWVKlNoPUhWMVtCtc0naw1dYee+39vN9
	bIhTm6Wd4Zrxui+383In+8NAjmmhswtQBceXOY0nvqy3gTaKOD297syDRPjYkhLLnI73c7u7aXz
	GuGFkwbSAXmo14XfVnZji3UNOK3eoRlRrY9NF6RLaQ==
X-Received: by 2002:a05:6820:440c:b0:6cd:3fdc:a936 with SMTP id 006d021491bc7-70ba0f81592mr2345843eaf.83.1792984179731;
        Sun, 25 Oct 2026 20:09:39 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.40])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9e04aa58sm6421308eaf.7.2026.10.25.20.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:09:38 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Kees Cook <kees@kernel.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	Breno Leitao <leitao@debian.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH net v4] netlink: fix out-of-bounds bitmap access clearing stale mc groups
Date: Mon, 26 Oct 2026 11:09:28 +0800
Message-ID: <20261026030928.719276-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

netlink_realloc_groups() sizes nlk->groups to the number of groups
that exist at bind/ADD_MEMBERSHIP time.  When more multicast groups
are registered later (e.g. a new genl family), existing sockets keep
their smaller bitmap.

When clearing a multicast group of a departing family,
__netlink_clear_multicast_users() runs netlink_update_socket_mc() on
each socket on mc_list, which does test_bit()/__assign_bit() on
group - 1 with no regard to nlk->ngroups.  Skip sockets whose bitmap
predates the group: such a socket can never have joined it.

The overflow windows differ per architecture, both needing privileged
module (un)loading.  On 32-bit kernels the ~54 dynamically allocated
genl groups already exceed the initial 32-bit bitmap, so the table
can grow there directly.  On 64-bit kernels the same in-tree set fits
the initial 64-bit bitmap only while allocation stays contiguous:
genl_allocate_reserve_groups() takes the first free contiguous range
and unregister does not compact, so an unload/reload sequence can
fragment the ~59 free IDs until no fitting range remains, forcing
the table past 64 bits and reaching the same stale-bitmap overflow on
the next family teardown.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: 84659eb529b3 ("[NETLIKN]: Allow removing multicast groups.")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v4: Skip stale-bitmap sockets in __netlink_clear_multicast_users()
    itself instead of guarding inside netlink_update_socket_mc(), so
    the guard cannot silently swallow a future
    netlink_update_socket_mc(..., 1) caller (suggested by Eric
    Dumazet).

v3: Correct the reachability again (sashiko review): 64-bit is also
    reachable - group IDs are allocated in contiguous ranges without
    compaction, so fragmentation from an unload/reload sequence can
    force the table past the initial 64-bit bitmap too.

v2: Correct the Fixes tag (the clear path was added by 84659eb529b3,
    not by the dynamic bitmap commit), drop Cc: stable and describe
    the actual reachability (32-bit kernels with in-tree families)
    instead of implying generic heap corruption.

 net/netlink/af_netlink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9fdf964224ab4..ee0a6df6eb5d6 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2156,8 +2156,12 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
 	struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
 	struct hlist_node *tmp;
 
-	sk_for_each_bound_safe(sk, tmp, &tbl->mc_list)
+	sk_for_each_bound_safe(sk, tmp, &tbl->mc_list) {
+		/* bitmap predates the group, can't be a member */
+		if (group - 1 >= nlk_sk(sk)->ngroups)
+			continue;
 		netlink_update_socket_mc(nlk_sk(sk), group, 0);
+	}
 }
 
 struct nlmsghdr *
-- 
2.43.7
