Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989334756CB
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859151; cv=none; b=HZIR2brZ2K53q1aN88sFeX+OMWNBekFNMi783n4tgiWu6vH5FwGvSY+6vPA8B7EOwkJNt+gs2heUD6bqFQgCA+N/9Sj/FZWzib29jVCK1bvoyH9pr6V/A1MLgul5Z0dPeX8KuCdwPULD2iXu+vdOmYQg8ITL6cJMIPX1OptWkAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859151; c=relaxed/simple;
	bh=SmQoF98UqUkTUelc3nldQ/X+CIADCPYpyJdtgYO9Y84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCMOAtEDBrH8IJLVGr5T1q4La5XaspeH+iRWc/M7FjZee7BCULNHLuyUowXXrxybKbdwYQ6dUGvloQJDyqTPAI9uTUloPIpqmnQ73YZKc7i0Oep25f1G8e3QFANCiGTnsAQzqYvdvJ7orQBcJ+vVQfuqfjjXVCjV0RYuuZaJtQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Efpg4r30; arc=none smtp.client-ip=74.125.231.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Efpg4r30"
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-5187c752f46so776052b6e.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791859149; x=1792463949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRbyHHTAjoD6f4mmeHhhXYD+L3yk83DPnnEpnKG2NnI=;
        b=Efpg4r30wRrMRuRrE+RQlOf1MEuCdRwFe4MGxOfOW9prTEMqOmVlu9jL/qxmT9Ta3L
         XMX8lqmvdrM6FiOuhhcG3wpxyHO8ZB+W1fwP8gAz6KKIDD3zCM1a+EorrIp8JlFkymFs
         Nvj7rYA0GhOalTWuRFtAAdRSGkgh26cgOV4RiNufZmngF17izFyjlQ26MTgqH0RhMFx2
         qEev/ttkswOHb7D79sFEnhGMZxzhKPdTexmHRswrW82Ba49CvWm0STFjX8UxH4GJGEXO
         2JN7EBODl92Y5VbANCM0q0okbsMVSbYCPk9jPmG1xtwCVOzq7FGc00EPeXA7N1BDe/n6
         YhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791859149; x=1792463949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LRbyHHTAjoD6f4mmeHhhXYD+L3yk83DPnnEpnKG2NnI=;
        b=a10OqGj/mJJl4Yn776ilWelE12/4saUWcvusaRrmB1HCtAa6qUxB6DTTbjygY8PK6f
         q+cI7sfgz3OjstDWSAWZtpWOlObEbH4NCLSEGuJqQ8A88CA/b2Ow5Z7cB3VE7qTSXUwj
         94g5y0ZAbwD/mawJWKNaZXlWfgHeK11hHUee04KyNJzxpzsvl+peBLlrT/oZbl/OTxzi
         9ONsUHOB7ggPKWtKpsavOmkcAqadSxLRg/ZyD6g2UYzkAWc268fSZYD+kBEuWrZUAI03
         8ezPyJpIqQJaQFEqb5Q7kWMaSGPiAJIM7+2a/X7ucAudHEHVtr/dmNUdk9/wqTb3+kb0
         t5qw==
X-Gm-Message-State: AFq9FYKONcqtTxL2kPwgUmji961pOF0Zj82tSWXNk6CwJPesobYmUZQ4
	Is+MWid6r95rzPsx+aOKkVKflc3euXKve25I/i/Chflz9xrOvaZ6FDPX
X-Gm-Gg: AYBFou1clB50RmosrinR3VbNvg3Su0dUnR+8HNJB+c/idqHAjzjCM4WRi5EqjwGb/GX
	ooaXlnf52D1PJboG2UpNJ0AL6Ra53TU2vodgTO98e8EyOi9x/R78lmyEFDfjdLBDWgjZ3aqy3du
	v/V11Yw5uDg0ntdf2l9POS8qK1UK2IWDvCdn9OYNYjHet2bdt135buRR68w5mdqdDMuaBl3npdE
	xRS6SQEOafqa8yqg37t6gCrCTYdGfy6jSt6pQc9T3mr6aZDvvDsT78LvaUh3yV+4Sh/QhV163nI
	2AaSSkEn7JhH6WIMM1ptuvemZ562ZoV9O+mrTmtL0ld3qSPdqx5536AILeTQ1CdGdSG0xS0fRON
	5jMV6WTIqKT1C9+5jhvMh7QnvsgSYEx/ncttZQNZO4iPh2XJeRXD/WXUKZ0oCm7XPp5ofcImU/6
	jy8XbcLK1E/tQeyK5BeXZ33xLhPwYB2qYdsftMjrTFFdiGi8Tx+F6YRMNrRNr5L1qMjCJv97hXE
	I/CgGiZw+qlzwHlbyAbF+n20XuDMrY/pORkhg==
X-Received: by 2002:a05:6808:c3c2:b0:4ea:1854:b949 with SMTP id 5614622812f47-50c50f297f1mr10349705b6e.33.1791859149449;
        Mon, 12 Oct 2026 19:39:09 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1674ddf8sm12798195b6e.4.2026.10.12.19.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:39:08 -0700 (PDT)
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
Subject: [PATCH net v2] netlink: fix out-of-bounds bitmap access clearing stale mc groups
Date: Tue, 13 Oct 2026 10:38:59 +0800
Message-ID: <20261013023859.3075601-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <CAL4WiipgL26xjM+0+wT-NUVx9ppjQEJj+oShdew-mbzrRVU=dA@mail.gmail.com>
References: <CAL4WiipgL26xjM+0+wT-NUVx9ppjQEJj+oShdew-mbzrRVU=dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netlink_realloc_groups() sizes nlk->groups to the number of groups
that exist at bind/ADD_MEMBERSHIP time.  When more multicast groups
are registered later (e.g. a new genl family), existing sockets keep
their smaller bitmap.

When clearing a multicast group of a departing family,
__netlink_clear_multicast_users() runs netlink_update_socket_mc() on
each socket on mc_list, which does test_bit()/__assign_bit() on
group - 1 with no regard to nlk->ngroups.  Skip groups that lie
beyond the socket's bitmap: such a socket could never have joined
them.  This is the same guard do_one_broadcast() already applies.

With in-tree families the overflow is only reachable on 32-bit
kernels: the ~54 dynamically allocated genl groups fit the initial
64-bit bitmap on 64-bit kernels but exceed the 32-bit one, so the
table can grow there, and a later module unload then touches bits
past the bitmap of stale sockets.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: 84659eb529b3 ("[NETLIKN]: Allow removing multicast groups.")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v2: Correct the Fixes tag (the clear path was added by 84659eb529b3,
    not by the dynamic bitmap commit), drop Cc: stable and describe
    the actual reachability (32-bit kernels with in-tree families)
    instead of implying generic heap corruption.

 net/netlink/af_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9fdf964224ab4..8cc655aa927f1 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1657,6 +1657,12 @@ static void netlink_update_socket_mc(struct netlink_sock *nlk,
 {
 	int old, new = !!is_new, subscriptions;
 
+	/* A socket whose bitmap predates this group can never be a member;
+	 * don't touch bits beyond its allocation.
+	 */
+	if (group - 1 >= nlk->ngroups)
+		return;
+
 	old = test_bit(group - 1, nlk->groups);
 	subscriptions = nlk->subscriptions - old + new;
 	__assign_bit(group - 1, nlk->groups, new);
-- 
2.43.7
