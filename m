Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476535;
	b=zelqQKTvkJ6hofIK4YGXQUka/tHOCRgSjM+XgQuvpyiQkPyPqFlmVid11Ll2PyAIcnXl
	 X7+j56hM+otaHRNy2YGZ1UqNxnZCDwNVJQTXDzk2UGelUHjNYiagtPL6ypLkHd2ueQklY
	 4CRR5GGLWwYszvt7INvWTDHQ7Cy1hfAFaydikbeIW5tS5gU61UtufTd5M517Ya0bZghWV
	 91eDnjfYOOuWFFW/rchEpWf1PZa+EZqyVeEVmQgpHXPYsjeGty4aa30sra4CBcIjdtfUj
	 PZS4wlVlYSvk5kzj4Mufe+/vQHXVXbn5gHUgTspROHxUyk79Jj6LIcJbgm7s0U+Vfvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=M5z4Z218iwFLIiE49jl2bv9SF37cp7wRUYRt0lwEz+g=;
	b=pPCyGlIHvBcdkMgNH/KR33cmWRIQapfL0w2WtuyuVeGxAQ4i8M153XhHVf04iwmNfapR
	 SAI7PpeCwBgFVBjdWwRsT1V2+E1Y8ciCYPeg96jH5/7kViZbx6g43r8v9v8X4z/POt8KI
	 I/I1pPdvOO2EweoWXUaanQI1JjHTS5r0kGm2vC1EBVJRrSTjLLRdsveTKQOknz/ep5Mpv
	 AbTKYL/Zz3Sgemum6VDfCzLV5wVlcZs7rifOBKKXZMJ6hUEhXdYgK+6p8PO9bF5q+zCWK
	 vwGAdT7NLAAuvlLsYPo1Y+HFXEs3iTvwD7sAjmoZVCjSHewwv7Xcyl9Y2r2u6V782Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oghy3hZM;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D45606A330
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D45606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oghy3hZM
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3720addb068so7255757eec.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794476534; x=1795081334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M5z4Z218iwFLIiE49jl2bv9SF37cp7wRUYRt0lwEz+g=;
        b=Oghy3hZMUYng4sAKtcoxnPw6uGHj+5sCsfYUVf23LwU+ATEnKNflnRzEzIb67/xawB
         tNco7RrfZzCS/s+2YDJ+nguv5RXPGLznG5Vw8B1HcZYHurdd3n44EcP7zvp8H8ez8uXy
         1TjeMT5PT+koVkp+clFHn+eKrqXXRsrzqIJcvZB9mnAduvT3DZTN/nSR7FoJDjgDdvhg
         i+PgyNIfLepNKm/wjuDniyaNJJ/zIaupctIRDTpCuKqLixyR3nzzuP0MQR4RTORtkFwq
         HY18eFm6NjdVvfTBqadsTHC0VQNZNW9EN+u3T3JifzTv+MejzEhp4+DRhUgp5a1QDwV6
         VU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476534; x=1795081334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M5z4Z218iwFLIiE49jl2bv9SF37cp7wRUYRt0lwEz+g=;
        b=tRoXK4yD8cNsWHKlDdByF4M3eBj+3zFds1ofApuKbdwXJr62Cyd5e5L6SXRZM0ucMP
         U9GAOQ4Nb9JpW8zLVBBEjso6ZwpvhhzoXv6uKr+n6y0eylJBgmFmOJmy6r90tC9opzJL
         B1pSSKJGiJ50cV9jJjnnkwECo98PIcx1YcTUAn2rkDmI2Yln2h8679ApTVWT16ufc33Y
         LPV+m43ZgTrNqWpe6JyI/SpHePrPTAWxF3Shx7+8OT96hSscvZxz0XrEJbMaTQ8aUOGO
         XNvoIyb6zETF73kYRq80rf+Gm5WMmYWmm3khEOEts0HX/JQRKuyW2sgyVR3mx+00+HC2
         Ws+g==
X-Gm-Message-State: APuU4Z9EnWwdjXXLfi4CxzNwMlj2J7zCovr/DSwPVQpFW6cHaTPc1iTx
	pnW840Mf4nrgY2+xxYTjyzXDcFX+FsdzqVb8UnaYBZS6sQEWJMMtGRwuSADPXg==
X-Gm-Gg: AYBFou0U1XBagkEPXJpGt51kzGccWKHtCrzxqIPxXGACATRIG3jTgsEH6oi3qz44If0
	45DZEF6QNwDj0Ver38Pk4/FlnL7wBqrhn6ke2STBf8rutX+GVm4FWS1RikiqHQfFcYXu/1w9rhL
	26hpMhMCajsj3l8GK+7HaE+YvZuJ0AnUbeJLNcWU0Ky7kKwmqWmep35OxiuseBfH5OgbHCuz8aO
	VFWUHwixd2hPDUGjtMcc5oWx+EeMGl+I8bh9OTJRlXVp9gzw19gZF2wpGcdbqcUJYuMvp/JD6Ho
	NgtAqOg11WeXco7rlcE719mHYBIxnzssZXGQ0Ssl9xbpd0EcPLPpAGHm2aaQSaX3pdpjrKoPEbF
	ZROs8v557jTvnB01DTXhcqbIPXV1u73eRdbHKqQnWRYFec/IWekcD/hTg7GrG9ifAFLh8HEDwN3
	X9fdEfyJXXId/JkZ0D4kN4sT/Cf2Y9bxxp0UkvgqPVu78zTY1i9SmIthfL0tO9Fue2AwU+zT8J3
	2SHVU4K8Tsg/clpkEa85sGWJz94FAblZHAX5nhYVthG6v04OPyK+7uAvcz/WMmNa6pZLInyYJnP
	KKhibRUYMUDJc3SEIg6eoGS4rF3imY/CiVrPHvwDLFKfixy+xXaUbUmM+zUKXAhFp3doqDqpUoo
	qMPIdu7qPoGinmNvuGhyiJWnZw+ts/KWA7ynUpynm0WdFw/0fmbElZmi7tkOfLbBAaQTV6Kr3+5
	c=
X-Received: by 2002:a05:693c:42d1:b0:36e:c9e5:33aa with SMTP id 5a478bee46e88-376854ba4b9mr5548647eec.13.1794476533548;
        Thu, 12 Nov 2026 01:42:13 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm26300020eec.7.2026.11.12.01.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:42:12 -0800 (PST)
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
Subject: [PATCH net v6] genetlink: Reject joining multicast groups no family owns
Date: Thu, 12 Nov 2026 09:42:05 +0000
Message-Id: <20261112094205.1120090-1-anilkaushikwireless@gmail.com>
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

genl_bind() checks the GENL_MCAST_CAP_* flags of a group only when a
family owns it. For a group ID that no family owns, it returns 0, so any
user can join it.

A family registered later can get that ID, and the socket stays a member:
nothing checks it again. An unprivileged user can join the free IDs, load
a family module with CTRL_CMD_GETFAMILY, which calls request_module(),
and then receive the notifications of a group with
GENL_MCAST_CAP_NET_ADMIN or GENL_MCAST_CAP_SYS_ADMIN. For example the
drop_monitor "events" group always gets ID 1, and is free until the
drop_monitor module is loaded.

Fix by returning -ENOENT from genl_bind() when no family owns the group.
There are no group flags to check before the family registers, so this
applies to privileged callers too: a program that joins a fixed ID such
as NET_DM_GRP_ALERT before the family is loaded no longer gets its
messages. I don't know of a program that does this. One that resolves
the family first still joins.

bind() takes a mask of groups, and most IDs in it can have no owner. Such
a mask used to work, so keep it working: netlink_bind() skips an ID when
the bind callback returns -ENOENT, and joins the others. Only genl_bind()
returns -ENOENT. A skipped ID is not joined, so it is no longer in the
groups that getsockname() and NETLINK_LIST_MEMBERSHIPS report.
setsockopt() returns the error, as it asks for one group.

This does not cover a family that is unregistered between the check and
the point where the membership bit is set.

Found by the Sashiko review of the gtp multicast group fix. Tested as an
unprivileged user who joins all free IDs, then loads gtp and
drop_monitor:

Before:
  joins: ok=62 EPERM=2
  gtp/gtp (ID 15): member
  NET_DM/events (ID 1): member

After:
  joins: ok=19 ENOENT=43 EPERM=2
  gtp/gtp (ID 15): not member
  NET_DM/events (ID 1): not member
  bind(), an owned group and free IDs: ok, member of the owned group only

genl_bind() was added, with its first capability check, in the commit
in the Fixes tag.

Link: https://lore.kernel.org/netdev/179324692107.3134.14443689892607921337@kernel.org/
Fixes: 4d54cc32112d ("mptcp: avoid lock_fast usage in accept path")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
v6:
- Drop patch 2 of v5, as Jakub found it too ugly. A family unregistered
  between the check and setting the membership bit is not covered.
- Say that early joins to fixed IDs stop working, also for privileged
  callers, and that NETLINK_LIST_MEMBERSHIPS changes.
- Document the -ENOENT meaning on the bind member.
- Rebase on net/main.

v5: https://lore.kernel.org/netdev/20261104092125.211537-1-anilkaushikwireless@gmail.com/

I used an LLM to help write and review the code, the tests and the
commit message of this patch. I checked and tested every change myself.

 include/linux/netlink.h  | 3 +++
 net/netlink/af_netlink.c | 6 ++++++
 net/netlink/genetlink.c  | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 882e9c1b6c1d..b4eb873850e7 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -48,6 +48,9 @@ struct netlink_kernel_cfg {
 	unsigned int	groups;
 	unsigned int	flags;
 	void		(*input)(struct sk_buff *skb);
+	/* -ENOENT means no one owns the group: bind() skips it and joins the
+	 * others, setsockopt() returns the error.
+	 */
 	int		(*bind)(struct net *net, int group);
 	void		(*unbind)(struct net *net, int group);
 	void            (*release) (struct sock *sk, unsigned long *groups);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 69bb951b5fb8..ee573ba6396d 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1033,6 +1033,12 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
 			err = nlk->netlink_bind(net, group + 1);
 			if (!err)
 				continue;
+			/* no one owns this group, still join the others */
+			if (err == -ENOENT) {
+				__clear_bit(group, &groups);
+				err = 0;
+				continue;
+			}
 			netlink_undo_bind(group, groups, sk);
 			return err;
 		}
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 5cc1037d4917..f038f04ef4ea 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1825,7 +1825,7 @@ static int genl_bind(struct net *net, int group)
 {
 	const struct genl_family *family;
 	unsigned int id;
-	int ret = 0;
+	int ret = -ENOENT;
 
 	down_read(&cb_lock);
 
@@ -1841,6 +1841,7 @@ static int genl_bind(struct net *net, int group)
 			continue;
 
 		grp = &family->mcgrps[i];
+		ret = 0;
 		if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
 		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
 			ret = -EPERM;
-- 
2.25.1

