Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793528041;
	b=G4gmSdmH7yG02J7exsNHE8ujlHXAk6wGupjE2joFPgz5WiiSvVpBHE6N0boINRUjavWT
	 qWsiBm2+34kuY1/nfkfADj/yuJ4JYCKICqYltLUa9vcuj+2owBI93uZcOBJLcHh65DUy0
	 fpUmIRREv1LEWXWuyh29WOWFUpX6Y7oFvXhJezdRKkNmBUWBZb7Yn7HZc1AnAH/SwoAtE
	 72cZ5sTIj3CSbGa/sh6OjojsA7w2XsA6HUhP+N1pw17UyhJWrDeRzKCrduvuPPrOzDcad
	 s99qTS3kKAwmOSIfAf/aLXg61AYYNRbW9KORbufxS1zE8GXGy06uewFRQ1pT/sKAPZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G2n2IA1tkyXWwdIf7yrDgeiQ3S2zukN2iU0KIGIZH14=;
	b=SruJMnrD+stVIanczP2B28z9Q5BeA4ZG2K6ifWciAxTeSvup0hZmJmAvXH8BXSwRpb2L
	 x6ZCMS+CcsZk+SziqE1THEw9nq4XQuxjmKxNjIaOsXb4MbKyDGReANfbU2Hl4Vcotzp/K
	 /WdeCP49UJS2JVYxi1E5c31NXsgMF3zoYbm79dSkCsgQOI4r/q4IHF5Ah5oVjRGEe43Qo
	 ZOns5iqgsrh/6KVIgFzuz5s6J0X6Goh7Iyz8brSpRvBJb5YuEzvxmhxl+ZHxqoO08mr6J
	 Ds9C3cMMFp0bCtWaG8slSDKr5KU2ZcL4VocROK8+Mp93zhDo2FaX+j1bz1BofKKT7Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0PDUrKIc;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E0606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 10:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E8E0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0PDUrKIc
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a18fc7a38so2891584eec.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793528040; x=1794132840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2n2IA1tkyXWwdIf7yrDgeiQ3S2zukN2iU0KIGIZH14=;
        b=0PDUrKIcb8W8AKbJw8jtrP1Xjmj39IVI+/5ert6Q/WSsxJytM95JznSJy52DcdIVqB
         4Oa3ovjCq8ktKSBc0UeSqhck6YJsGADgPNKkIjAVDjBAOkOatz3Wi10nu9pqp3ps1Io9
         3vG6XRaBGAI6dRVRsXgozUBdu01uNHVbJ2oLrA/Ar3pC47iBgiIbsmqi0lgW7o3orX+w
         G1FLanwQYAN/Qv9AVwPvayytH0lWVh7USuv5ABfpNlMiPbHyJ7NaTv9dLM2vXh6/uMBo
         GdYJSGkHHZ9yViaDLwKepg5txqi07s7FgFIO/eDuaYQaFJ2VY3iHo5OdwYQ+V+kxJnnH
         KSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793528040; x=1794132840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2n2IA1tkyXWwdIf7yrDgeiQ3S2zukN2iU0KIGIZH14=;
        b=XYanwMpyR3LWEytr25umnUbefvwU7CUaXmyKqmHYAx71/pI413Ushxg1ENZMA/a0YM
         ugkIx225SgM0zBPaPhiziK8lphYiH13Gm2KXTyCq3UgHV5LMHiKAjXiBG9zMQhy4ri60
         OewZivyy+kLa0TqMO9EiWIg5ztaaLTPkGlFl0T75ZLgCpIYQVH6mHyw81VU92TMk970Y
         N5wo1lpg5myWht6vd6KU3JdjsflR6cQd+MbHu1UA8T4taIVpT52EJwFHI6hHDj2+dAjf
         8V5F/m8QEysl29Uyz4fp2hJP5GnZceWSnBMy4p4QXkvYCa9MP5dextGNin0krZMVqeMt
         Hp/g==
X-Gm-Message-State: APuU4Z9HA2KBmIYJl95D2lkk7QKz0Aw8Z7jmViLeWK3FaH0r6CexNSgd
	yKI7pjJl40MROjI0Pvb8qKDVDNino4oBETrYjQ8pF8D2l0JnfiUTVJo8jo6kTA==
X-Gm-Gg: AYBFou1qc8s4/pQ9Ufvx9KDvbGMXBmmzTPGG8QJ0BVUqKJDt5HZwcXYBiwn96gUfys2
	loleu9XsuMqzKYxgSZsDyqCEjyenhfscAPbN8TJ/SWKk9Dh4PH4mvsFb6oRrdVGFhr207Xtq0SV
	VGLT5USYVi2yiuFP4/TkzLBbJhS5XqBt7MFoPwU+QqJpqd+k6EWHzBe5V4oKRxhEfnnTC+YzoeP
	z0QowFQC33pgiNPmI8KSskvzuz6c+VKXSI21BN7TxgZh8Ad/bfAzQSDjGCqMx/G4YIGNlMyBRl1
	kv3MbTzVUHqJkDg1g73d7KawqeQUhe/bV/zonPmbfdNrqFRC2sos8a4YOUx22/yis0Sni5bJA6a
	GWz+7KclTDhUry7NDRATQ+II7o8tdK97TEtixSIQJqc7P3phN3f7em/hlePQDl60EHnpJeGIacG
	S47LPOGX4Ec+DirbX9dgP+7MJiRmi+2cSRpLD/vwY/Qg1SpBxqN/xlqz0l6ksP8vFjAQqKoZVNj
	g6AOkFHHa6mgwNolDhMxLNh18OR9KDk76ybuxCs8F6eODW/GQ4HXeiwyfAsQJM3YBAJ01ODPk1G
	WEoCXcJb0TvSM2hu5oaxhcWFODhYBlJPcSQRKglLCqbxpFAUXg3sHRYQcK5bKWtJL2lYExuGexg
	RnxitD7uDdz4BRw6W+ujOtm3oP+kZXaCrtrN9xyPq57Gt6WeMP4fFTC/bYO5pcFTP1TIYnWgW+g
	==
X-Received: by 2002:a05:693c:6092:b0:361:7ab9:479d with SMTP id 5a478bee46e88-36a423ee70bmr13091324eec.27.1793528040052;
        Sun, 01 Nov 2026 02:14:00 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42662f23sm29799664eec.2.2026.11.01.02.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:13:59 -0800 (PST)
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
Subject: [PATCH net v3 1/2] genetlink: Reject joining multicast groups no family owns
Date: Sun,  1 Nov 2026 10:13:46 +0000
Message-Id: <20261101101347.3910654-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261101101347.3910654-1-anilkaushikwireless@gmail.com>
References: <20261101101347.3910654-1-anilkaushikwireless@gmail.com>
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

