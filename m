Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254943;
	b=5NneuQcPcsPlCso3u4D4BzZ1FoiNdO1vZsg3/FNI4g6lIxRkeFGJ+ckzkiYJAzHwjz9X
	 BAty2sM+9dTAfCHREYE5FwlAll5odNe8H9v5y9BJES21YKqPuS+8nuAAa3srEPRJyBmLA
	 YPduIfZ1s/yKSvd1SmvRWRO2zVukxXbGn3BzdF/OFtBk6TrKr3mpJ0k1ckUeEXcBoZz17
	 LB2Am2Hy5Aohq+MqmOK0i5ZvBf50xfB/JARuQq/7nX51oCykv54QV3t0hPcq8Zr0Sg6tX
	 0NG91soIOEaSpwt/xXuMpqvccybf1T6AzNhOWR6e5CRn4JiY1FmnXFD03QZYmUFCQlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hbo7nQaUa/EkkUfMTIBslWqezjGArgpu55P/FDSfP00=;
	b=SlVn+RA4tEEP6AcmssI8zhuyVPAfaJ05m4S1sAyCbu3Jlz4kEoVTfZ4tH4u2SobwoEFK
	 UzATqDgMw8xvNxVQVM2bTuC82FQ5FBKkDzjNyhJbuPcLpBeW6IRX3U8W2SrE3dbhQOHHi
	 uDZBEa5Rg1Jws5Adnsz63h5RPGtzRFVYtM++X6vUT4pkskR0P7DBh2cfkJyBTrlNsrblP
	 oEQzjzsy6S1LoW4YKffppynBfRZbrwcGu2ireCJQVTGXpD7R3WZQpfKjz+JIgv7BDhDhp
	 kzI925IWvUKxGdB4Txk774bPfzFyGxXpdKEAfCP6yl+qo8EjVVLuaBdKgr8K3konlhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=czW06I39;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40453606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40453606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=czW06I39
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33fb4680717so561711eec.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793254942; x=1793859742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hbo7nQaUa/EkkUfMTIBslWqezjGArgpu55P/FDSfP00=;
        b=czW06I39WAaqRuUvXHBaDZL79RltalM9VPne66lA88RZcj4wz9qay+eXxG2bV4U9mf
         teWcrAk62lbFCH7KXzgikY8jcFx86EYSmprQa6qR8nFzPp7glA/nNS70Z7T74i52Kw5D
         +cpE4qPgXg0VOLxX3KLMrOIqoJLYqZEVdYU965A6PkTa4p9O9MgJ5a/fZWGlG446Iw6Z
         PvRzDrgpJD4hx44HEXUggRzYNk8BVaqrr0bDCPNaPByYAvAvcrk5rXK5GCSU1y+vh2o7
         G76IQvg3vu3LTCxdYFBcXqllljOXtL7P8406NMQvvD+BDWd3Nf3t90ERIsxYzs8+fsYq
         paTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254942; x=1793859742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbo7nQaUa/EkkUfMTIBslWqezjGArgpu55P/FDSfP00=;
        b=yZmz3qlvUSvaox9mIbX3QyqoQDJYY56dEo0A45DM+Ltjzt708NaL7UQZ90e6FMTMWG
         O4Gq4mW1TZHY0vOnvv/sHPuP+DD7FEqldI5LBVx8qga0hKBKrRZVx0tjKBe34NM9eOas
         glGwu3az8K1PVQM9IO5JNd7qsOsYdrGBtygXCapja8E3hDb048rfuCT/r2EiNrUVdYFg
         09btIecW5yxWygzPhsV4xZsx4N7jH5vWgmpFoTirRUCpVF7/+csy2r2lJINPBuH+YN3/
         0JAV7HpGAcHfwyUXl9ZfybqqPCK4GMZYGl/TWXVc9HaVtB8At02xj6SxkG0k2BeCI4N7
         ioKw==
X-Gm-Message-State: AFq9FYLkKDfl6Ndvo8iziXGn2OsWW+WM8jniYM497tQKlIhu3jidXnnZ
	TDQql0fsCg0icq2eFrCF3rKhnm4qS9w58XIbmlCu9ioeXqH4x0gp5pgdx+SMnA==
X-Gm-Gg: AYBFou0KQ5aeY+ZGhuw5EFl2GJjZK7snL2cxA+szFXbBvL8R7djEoUNnU9WiaXHLIxH
	o2W9wsFbWWrl8shFyR0Yb2+2pfla3em4H1ln5s6SBlbjSXikW6sikRLLb79QtxcH9kZNhOBixNa
	C81wIjRpCfs/AJtfYeDgqFcC1pW/qhLHFZ+NYJ/TLsiYaU+/mrkw6slXGsGEaOj4prGYi4pWEYa
	7KcwHUlT7WmNkV/3Uj8kTMrJ3qtSGa2NAg18aoOpOzJ4Bzml562942njz6VpScSmxbaLtOO5gzg
	GOIgRV3QU6SaLJUei+gfnZqOqxkEbxyNYCnzBhxLm6OG0pBh521Im2QlGkfl01PsIfaC6Swg002
	a5TZurIIXkBDc2DWAgZFBg2r7Dnz5FE/V9xL3C8L5OgQH66yIfhtbIcnsc6EwppdQ7LS3cvsN1U
	1F6kdn7J1sqj1IU1y3mH+JHWgjP6/zA8R5Cts+dQofB6xrePzZVTVoQuqVjzjSCXLtC3bduBpbY
	vDAupDYjD9q5aXmxGnvuZfrQGRj2fDmaaRtGl40I4CmSQ0ijvC5pVnkZGTQMCudLyVTRPYsOrVS
	gnl6QZVzyzQt4JDR/iUGv+jzUMM5XFN0hZuw9VdXNgDR8hmmL6JsfM8YYodVm43LZTlIZ3e+DlR
	0sK02+73hfYqFARNvg1g02oNrlSuLfLycNPH6xIslwgEd4VvEUqjWV9a8i1i86vL8GaFmYOBbxg
	==
X-Received: by 2002:a05:693c:864c:20b0:36a:1819:4d0c with SMTP id 5a478bee46e88-36a2046c99amr7459938eec.41.1793254942061;
        Wed, 28 Oct 2026 23:22:22 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239a56e9sm13608255eec.27.2026.10.28.23.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:22:21 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net] genetlink: Reject joining multicast groups no family owns
Date: Thu, 29 Oct 2026 06:22:14 +0000
Message-Id: <20261029062214.3407223-1-anilkaushikwireless@gmail.com>
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
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    The gtp patch: https://lore.kernel.org/netdev/20261027130623.3136658-1-anilkaushikwireless@gmail.com/

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

