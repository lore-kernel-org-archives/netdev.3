Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793425605;
	b=KJzn5Gdod7q4xt0F4ApiRldP764KIuAJ+YAas/tLAZ7PU09HkVPnutB6vsXHaTzKFKAO
	 v8tjQzOWmR/2RD/aciYXHu8N4Mt6mf9yc8eqIF27gpvz0wqQRhpnj+ILENARpvK3V2eDb
	 HTblkOuQ0gQRH8uH6J5B/BYtLQPwhADKKeaCc0FfQuivybXgMtyrcpLa980cLW56zdphC
	 usfhj3NapEB7PGvI4hxgrYDg1Qwt2Ik+VybqGQ9jldL5JIhvKFz1yRKhXtx25mVE18Pwo
	 L90W/xAaEfU5MzNgijk4Y1O7Zi5ehcXniUyynmDzydWobtlx8OavR0goYYHNlVUFsdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793425605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LjZWE7cPzqPANeXKx2eAoJh/8Vehaw21VR2TNABJYHw=;
	b=ZR+gyHNrXZDT1zn8+RJfGQuF5qxJCZHw4W8L4nUz3pzh2Oar1vKFX0zbxyWwjzRRDL7D
	 ie+zKDkQANaTYfqpF7KMnZNk7/knOf7klRSwwtK52nFMujbWMTKb4J2xbE0excCOtpGlD
	 cvuTmECThk8EOV3jxls+jSHlS3XiRO6oakEzofcj7P9zgVT470PJEOO/UML/efIYnR9Wt
	 iqvHJZCIV1gMh4lvkktz7RdF4CTtnOwVt2dDCc5AdX+/+fkD3s+nKI/Acm29ckh0DUYMJ
	 A7NJJlUfHnHK36ZR5N57RuNNKYLgB/0pd42M0srQU3Q08W1ASHC2MjABJRV9Tdz1Z8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLzH1RsH;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048B606A31D
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 05:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B048B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLzH1RsH
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so2426618eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793425604; x=1794030404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LjZWE7cPzqPANeXKx2eAoJh/8Vehaw21VR2TNABJYHw=;
        b=JLzH1RsHDyrTpVcZFailTP5nj9hFV8aGheePuCk4Cmr6l0H2VeIdo7DhZ37o8d+FJc
         1c6NO519zIXYMyV1z2Evt9ezMzyrd9Bk4zOkqFgpEOTvl9Etc3qtmIDn2ijcx2PkMk+I
         2gwREocv/ey3grgxLp5eVr3OtJW7+4zEcTocj9BCWDn0gx3cxPM+Q+aMDL2AiCRjIVjB
         JfO3ujUjtmSN4yxyGru8mXvkTLOEN7rOSmZp9hq1QJEHRv466f2gGdUQSPk/po++2eQ3
         cVB37oQSEMBJ4mhITFUOqTJzOPdbO+unaIi7+AH6ry77Qnv4NE8hHe7lcP8YoqGR7Iv0
         l3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793425604; x=1794030404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LjZWE7cPzqPANeXKx2eAoJh/8Vehaw21VR2TNABJYHw=;
        b=xFt/tAfG9k1AMrVtP1KOOfH0Cfvo+yYOtPd+Luw8oFZEO2Wbz/fdQyQ+SvMSWQtip8
         jRayikbj3JoD6DEW6F05m/NPXup3Amvfua7WJWPyOyTYC9ev2KFd1CMXwmqz8cImAcEB
         BfoMnsObNtRpS1Fn/i/gYAGtCdgjG1j0pd7JXi1nP2k/1iLeu6jzqwDeqRkCXbTQ/AzP
         D/zYCTAhmSfDYMA9oA06wKDmQ3UpSsLPaL3Eh5qkOSD4iOzuYYmgQn5H9+j07NcKMtqo
         H6YHitgSZ2Ok3MlaUG0JlOa2Pxq5ZCDqbMZ4BZVYlFAACO29QE2AFD4Vbiy2CXC/wSnx
         xrIA==
X-Gm-Message-State: AFq9FYIYxgEpkLTcWNQBWHVVhv0tT/+nA1ddCExlN9n+mPV+jQ2hyxq0
	LILR6Ws70MhQN/4jegJxwEEsWivvo67n+GQC2Lsui5w17BcAF+gY/VEbNkHe7w==
X-Gm-Gg: AYBFou39VFJHH5RcwGdz8PH79StO+WL7AvsgHurUAn5d6SNVM1WZBmA5+mwdjaKeWsR
	Hksjh+AQBigoGqbbsRUW6PjiYWMBSYKgnND2Gje20o3O+EbFmG57Aaq8VHdyODbait0KFO68BCz
	9s1DFSJESyuDrAYJgbz/nxEx2/i1m+EKdDDsPcOCoptXLj7X24P1L0tjFc6243k86JGrN2Ey60f
	BlCkfFgBKdupggbE1SH84WA8KNLHOQTKL8f4QCrGgw6WeNNmTdxg146LNbA60yisCjJAjRvlQNu
	DqFHKj2+07Tb9T2tbjLOQod1W7DcSf91JVBIgpJpa9LZm+i99Ve8GFznmx/zDdEFGps0ooLWo3P
	W4DrsOmBAvriwPzzbI8Ajh5TDo3GN7qM/OkNds6VZ/ADYwPqGQXYXClSb+45n4EVL5dHFH8TOrk
	gUD6qofOPIrMHsZT0IqgLH4eddLHezeQYVtrRprGeRCZFHyhby8qIFYk0ctRCw+v/4DxEXC3CkS
	RZaCtwtAmgva7+dwye/+BvCa1LYJPxmDRkqFOkC9N3SaIR7uOYjNwd84/+uZT0Qd9iZg55Ihiml
	+ctipVRk9gMkDceI/F1P/dgJ7w978LesKZXz4ag8xD+oGGG7lzJ/+Tj952fFwQBOv5xR0AEwtIe
	xF7gi4GfNcIxRmM0fFOsXc/RIJvq0ksPb5xBKol3MMKtLEEgoLSRZaOYsyoP1Nm0JM3ZebSXFSo
	9ozF1drz2AWO+Mv/EvuaM=
X-Received: by 2002:a05:7300:cf92:b0:35d:ea6f:b85e with SMTP id 5a478bee46e88-36a42225501mr6499164eec.1.1793425603691;
        Fri, 30 Oct 2026 22:46:43 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429018casm11668877eec.14.2026.10.30.22.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 22:46:43 -0700 (PDT)
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
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] genetlink: Reject joining multicast groups no family owns
Date: Sat, 31 Oct 2026 05:46:31 +0000
Message-Id: <20261031054632.3697295-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261031054632.3697295-1-anilkaushikwireless@gmail.com>
References: <20261031054632.3697295-1-anilkaushikwireless@gmail.com>
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

Link: https://lore.kernel.org/netdev/179324692107.3134.14443689892607921337@kernel.org/
Fixes: e03781879a0d ("drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group")
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

