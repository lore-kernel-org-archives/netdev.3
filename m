Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784101;
	b=4qGqAgVi3nGrt/9Zre0kg+e5i00R+aMavMuK6Yx5Yc0CfceKLf6anG0/H1Ae4zSYZI4+
	 xC1A6E7BDK+UpzrpWS0gvwXT1Ux5GsFWstMnyKlE+61U1Ul70sZ7V2IBgOTCCdQLPxWim
	 XX7iBKBjYhAWfn9M5IcoLs2vEpo0urSssfoHtF99D6Vm7NVN/IvUWkyOFm3EqjH+VDQGl
	 Lb0ivwffqpNkmUP3kFsJgkZKhf1wqoi/g0smuhvsxaQ0+OtYgAH8A2ippvx6af2975Sb/
	 1K2ym+eSM26Z2Iw8UucWNFpEbpuJqzeV5AQpA6IXk3JRBfhLp3v92G5hHgyG9ugDu8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T/AZ7gxbICQBy82Z/aLCx5YwZpMWKUdrGG/VPdsaF5s=;
	b=EJM+3yKHizoGxMg2s10B905RGo+CZsKnZcyNqSIj4m3G5ety1DZEwAPIhMB36Rw0DAn8
	 oR/ocxeAUXVZr/XmEbe2spD0EtVa2q2VEXVcVGdO2bvjPDDbaMuJH9DKa6wBpvDOBJuF+
	 BPgTLN7jRNm7aIJpPimXqNqSMxGnIYTjIc7BIYhrr0btEeCn05xDxqqePep0oNON8zDbu
	 6VhmlOSZxIQbbRPY86cCHA7fxMl3JLDmh+nkJqUby6wagmDUQkhybxYjy9IopYEV8i+BG
	 sFFSpN7GQds9DyDyhrSSFStzs5rzf1ey5xKWOT/7BEhFIoXyAq3QT3aKevwm7ab9AQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fepx8XML;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AB606A338
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 943AB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fepx8XML
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36d6e342f98so42396eec.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793784100; x=1794388900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/AZ7gxbICQBy82Z/aLCx5YwZpMWKUdrGG/VPdsaF5s=;
        b=fepx8XML0SaNsiRjtVLibg48wRMIKJRsiEbBjwoiF6B+n02lviTdyXjVzdjKAFFxnL
         ugx5Z6VpS1a+gvrMAhACIzMWHxyvLJgu0T691Qe2Bnb4At4Lu9zi+OFE11ZwcSoqUqYT
         cFMnGPzGCZ81NlyJPB0I6epjB/OdrESX0sXRKqkn3S2TG/M4adKeyGyB47/iFpbXstuq
         mBB64flN6PblrdxokA2fZZDA50SqbC+h/TDhXwihDJVFjY7MFdu8esde8RZn5eQT8V1a
         bjs7GAbh9kfU63MogdJzShsGCLDdv/TU09o/DK2M2XQh1+kx9osqM4tUZBD+bL/rGvBE
         R2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793784100; x=1794388900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T/AZ7gxbICQBy82Z/aLCx5YwZpMWKUdrGG/VPdsaF5s=;
        b=VdRPKgGPhYB4rL39f0XdHJJ90WQdVOHJ6v8XzBynAg674A+tTpJ/In/8zHHk13mLdG
         FEiKmmtYYld9SwJ4K4aB17tAaXFlh58WdaL+ANepQxoTOA/FgquOEP3q7/CvXlxZpJcS
         fjIAJTY7TajaoBVfLLQYGbXntjAiCgqL66URpTYqJQ+qJ2oJ+OGeAkksOe3QOOvw/uc4
         lc5pLwAuxpaPY0HVSWvCZMsDT1Ju6VZ5I57q89ZWAinndKXVGwudqgbpB2stESu18cMW
         Ja8hPmZepiDaoi3rtQEOz6Q1AFzAgfQRiDUZqZlfGnftuYV7EyJ6gOY9Ee39i9AtLwEY
         6VJg==
X-Gm-Message-State: APuU4Z/kETcSSedatwi2YaMR5Je1KFfhqUozgp796uusmYzxYTReQEFE
	nlj3aSBgeOVQ5aLstoj515n9GQPO1bk6Zp55st6Dp+gjJRDrpgsxIivgZV4gVQ==
X-Gm-Gg: AYBFou14Gtw0iVdtJRbviuQNSs2+JgKDwPqN2lCs+xFYJpCRYYJ5WOYY6g1vvDtNeov
	nqMpCe3V+mIMkf/X8JXuzUb7P/sP83AfARoN5TWp9zM1N1egR2kY2rxR+q2sWCmdl3MJdmJi2At
	4z7HYMX0y0lyb081ZvVD19Bw5XzS2G4A9Ajg0+LCer6AXvocx75oB6RQzkSKTvU3BXmLpCSDaSA
	eOjAxNlEVXxw1n0RdNc7WKbfwwyefLxE59rOPlNEoStHZBk/Y+upVHeR1hfaV4iY1ID8EYCCxni
	6bqdSWNKEQEahHMnzspUg7fgOH3w9hVTNV3vNNFew+3ZJn2beWd40xy5aAGLqN5+pOCR6b+02PJ
	PVnBBTbmyfNj9wIC3QfOE92w9jQruNifJKW7y7aH7IOa1pRsxF5NXg/uCWm0sw9ksSwCv8cFFXe
	K/yHzTSVYscKv5Y8LyDXNIUwVLgfgYQaqN1JwdcYFvxzSJJaF1N7MKxuBdhqkOJOcAf/AAzpNw0
	4CgTZTFkNUEGbFY4AYwP+4ROpu6CalbivTzC2Bvy8SEWvkTxcgl+NdI0uKjGiii1pjCZAwxQnRo
	QjWOvIA6afCNBgkX8C4ypZYszYINc1F0nEniiVnmUv79sf5rT5FzFMbD2D7FTwRiG0WG+lLfBF5
	yJ8J+eloB+RGUTEIYq5r336fHMiggxXndt1OHJj2gYvLsTCtAe/9MZEsCi9OLxEzPc7TFqc1ZaA
	==
X-Received: by 2002:a05:7022:b059:20b0:1ad:3402:733f with SMTP id a92af1059eb24-1ad3420f9a1mr22983816c88.44.1793784099122;
        Wed, 04 Nov 2026 01:21:39 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b87c4asm6058628c88.3.2026.11.04.01.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:21:38 -0800 (PST)
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
Subject: [PATCH net v5 1/2] genetlink: Reject joining multicast groups no family owns
Date: Wed,  4 Nov 2026 09:21:24 +0000
Message-Id: <20261104092125.211537-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104092125.211537-1-anilkaushikwireless@gmail.com>
References: <20261104092125.211537-1-anilkaushikwireless@gmail.com>
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

bind() takes a mask of groups, and most IDs in it can have no owner. Such
a mask used to work, so keep it working: netlink_bind() skips an ID when
the bind callback returns -ENOENT, and joins the others. Only genl_bind()
returns -ENOENT. A skipped ID is not joined, so it is no longer in the
groups that getsockname() reports. setsockopt() returns the error, as it
asks for one group.

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
 net/netlink/af_netlink.c | 6 ++++++
 net/netlink/genetlink.c  | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index fec2879c497d..94c1390e8dc5 100644
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

