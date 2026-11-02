Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635114;
	b=MCne/kc9UbnP9P0RApxobAyHThg0UUK9ejeH++PTD0dULQW3DJHUW+5Ad+IPFK4eTjjN
	 vOujQEJa0EuM1hdMgDpvgy23LfZPVkS8b8u/0qbHtc7eAMWFzZFOlmHB7lGOdEzSmb+eu
	 a9U9S57sLTDuNqinTkyPOYH0ZGdGbidNAk0toA0jUPUigvpm7u76W2PrHLDOJ73fxOlZt
	 wTMmneotaDAsHI8ZM5eaX2cexnCpePAwJz2ACZfagvsuTs4UYGC047xplQ4PnXNjm7K22
	 uEmbQheelkmrhVxtPVuuxF34TtfhuWpIm0TxaX9mU4b4N6gGk+hnQvR65MkUYx777JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G2n2IA1tkyXWwdIf7yrDgeiQ3S2zukN2iU0KIGIZH14=;
	b=zwm5XlENPKnzwfMR8VUZaqT73g9FQBxqFjJwAs+9Cgkjds7SX6FozJGdwu4zrxElXNQg
	 ZzyqhNUgaFgBH9z258JDod12vK1I3aPMsrThKcQ9EjbHR5vhnRp1WGbwd9v5/i1Rh9SXi
	 zBx7IWiiAHGx+DbAaKhffSmJmgyG+K1TMZaOzQ/wsFo6YsCj+UNuaGF3BTAjYL++fMZ6q
	 5DCamJgwzj+DtrTpAExNFF/0Ld0FqCsjQ+EwoqVZsCHYxWuEmcO6abiZPn5KK6OaSJ4jk
	 are45CvItaS5T/geSEhGSkYNII4s2x3vU/H6YSQIfa+f4AmgF1z/HlLf4c0xSwfXZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rdPD9jxN;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E66075291
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E3E66075291
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rdPD9jxN
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so4173594c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635112; x=1794239912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2n2IA1tkyXWwdIf7yrDgeiQ3S2zukN2iU0KIGIZH14=;
        b=rdPD9jxNu2N0T82Gl8J9nQQENd2ctR/x2bznXjsaNlXdCoTB2VVbzD6fhENpJRTqjz
         Hrqx0ihQ68D3VV86eP3lxNWCwqVGV/ILZLlziSG2ZYqzD/ZIZ2Otn0WTHso9Lq5oNOPA
         /jYvfnpsuhmvPg4ShkLyVw6ONsePyC0c3esWahteZplp3wGNQVLJEhy9AazQaeDW/hye
         lLbV3r+LTwbG0r0bMKB48tFr9NDfIVKs0aEgRhmrUjyaxk1c6C5wWx228///+U87wSck
         IOcKb39BkdtCacBHrgfsMndpKTQyoQWVimUmKrYhUmG++Ss17RktEf0ls0JBsS1ji8x6
         3enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635112; x=1794239912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2n2IA1tkyXWwdIf7yrDgeiQ3S2zukN2iU0KIGIZH14=;
        b=nk83EdjFV3z6q4bwu+jnugHAzWYNcZXY7R9GVHL9HUZpj6Q6y9qIQ1mHNKkgBVh0X9
         KLK36FOp+jgQ3biQlgwds1yb7EiFK6IegaTpkg/ql3If6kupzCQmOfivkiEkjLRQLvND
         BnYjdn1wPmaqyMr92gBsw6ZFEr6LKzoBTnkp1a3TS8BQKoVBsVpr4vRIEcES7RxWiCoa
         bikiFy8YHOdUhdWsuFRbiIY+waGQ7RmkSVb3R8YP9o1xDeCDereRTcpsK6MoIBuJcKE/
         R+nME9g9hwcMxMv4kJLk7PkoHMwE6qBmNI9GGnxx8SsfzBmwmhgPm3YnQTS1E+IHXEY5
         sOxA==
X-Gm-Message-State: AFq9FYLUhwgYPCkLubcj7iXGwlu5oeXMs/DnnQ8CkEcFYYSDAlRzpFJz
	L8TzkJnlf4Ae0qPkiS8gBbI5fo/P7L6TtA0DbPrbcaizElBiCW3VGJQChBVheA==
X-Gm-Gg: AYBFou17w/lh5ND2QTBBU/u770ODwGM+iy84zQA4FNHid0dNDu45BxeGRsXQU5vUJxB
	nFthmj5EsIrfuG30Nvw8i9ovVBIk8Rjd4P4RheZJrP4JuiZEizCqQDBAA/ZcnFaz7ya3M8GYqxW
	ZZrPapVFs+2UlGFc/Z8q/o4OwzH3jmHZRMFQq1wY2kSyLodNuFpFmuxRcHFweYGJemftWHghw59
	VRNUa1DNHWZA5vQJVJUz2tLgnBlYIh7Tls6Bh4u0KjCKcyd46vf3wHlyHK0xqoFvY+llMrQlrDT
	ZAlLtZZDeU3TDanYvjCq2TnGikV3Lju92g9zDpwVp8dcXUrGdYPNmLwwmJWJTMHALBs5yM6bluE
	iFJSGZt+ywD2jFAwQpys+I4hnimSesrU94To4Sm45MsPHklsJerzpxqPwvC4fRLSoJsOiWCN6eb
	0vdkimHyNs7ibNxgEhLGqOPq8eyN+BMWqaMn2Fabwq5GzXQKgkLE2cVfyRDF7tZ0PmoGzYXSSz/
	cUgHsV+4bTuw1VMza58RHUChuhmSnkLKU4Oe4bubEM8ox4Pg+jPWky0/93G89PEfN4FfDbq/mjj
	n5d1raYi/5yI/ojsSEjx6RYndP7ssCNbvIpsfiIqXZF7CMTQt3BZrRw9nwHgON+ncmygpR8U1Qe
	P/3VY3oLJiK+aXA0772ConFsXH5qJ55qcifuRJMyhTda5b4OVK8OLU6FvgEL9FYJSta8Rm/5I1A
	==
X-Received: by 2002:a05:7022:ea86:b0:17a:e684:b497 with SMTP id a92af1059eb24-1ac55968bc5mr16638846c88.5.1793635111891;
        Mon, 02 Nov 2026 07:58:31 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm35115869c88.12.2026.11.02.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:58:30 -0800 (PST)
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
Subject: [PATCH net v4 1/2] genetlink: Reject joining multicast groups no family owns
Date: Mon,  2 Nov 2026 15:58:18 +0000
Message-Id: <20261102155819.4100930-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261102155819.4100930-1-anilkaushikwireless@gmail.com>
References: <20261102155819.4100930-1-anilkaushikwireless@gmail.com>
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
Nothing is ever sent to such a group, so joining it has no use.

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

genl_bind() was added, with its first capability check, in the commit
in the Fixes tag.

Link: https://lore.kernel.org/netdev/179324692107.3134.14443689892607921337@kernel.org/
Fixes: 4d54cc32112d ("mptcp: avoid lock_fast usage in accept path")
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 net/netlink/genetlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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

