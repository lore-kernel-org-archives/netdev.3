Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99027E056
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319938; cv=none; b=MDw6Rx1c9tKDmfpmnkPHHpNk2Ix8ylpK6uUqSlkgzuqpehvKUriEQwVxw/K10SbTq038XQ93jL2br2AWBGo+NmwQ+VAbTpMIqXz49xm+eXTg3IH0cGTz0GDYkqMvm4mkgZoMYLTMtRJE7Zx3TQdypH5zhAlOvP+edBnfjypTtwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319938; c=relaxed/simple;
	bh=cTG1MkkEa1UmMD3b3V7nSJQmtEuG5OyaUFrER1qv434=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJLx5PL7MPQphuV9+AmtuslM6IGQvHIzzqeNe2RAEAkKffh27neQLwqgrrMob/ZJnTjxSf6hkQRvjbo/xbThXfov9u36TNBkVYS1KYUD0AsQwcVxgyoNdbs+IIBFEjPcs8GEFekAfQmeBVyp8flYCS/+XjyIOih8ckHS21QeFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFdUqikj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFdUqikj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EC1C19425;
	Mon, 27 Apr 2026 19:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319938;
	bh=cTG1MkkEa1UmMD3b3V7nSJQmtEuG5OyaUFrER1qv434=;
	h=From:To:Cc:Subject:Date:From;
	b=PFdUqikjGc5s401DjahP/TTj9mEEx6514f5HGBUDYD5DL5fdSOP/t5Bp4OC3ERcGC
	 6uZK+bWYr5EaGOkC13wbhu8dNSRTFKkCjDjbiJwzKVoHHHUyGQufdfVkBT5TXNNXLb
	 iqkAyFV5OwTOgEE0+InRoEVkOP2igjlwa9K2jwLJjHsPh+LZr6imxMa0LRP5HEBgwx
	 VGofXUso1aCRlbIm2ZJWQoX2cuzAbuNZv/na7Pfyy/3TLnJUld6QTH8TpQ93I2Ocg+
	 9UFV6/TdPf5ST2cCkDO+TReFzrdldE85cV+K/HNah/r6HTAy8IkDS40Is6s8SJMFf4
	 rMSN3F+36c9Pg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com,
	donald.hunter@gmail.com
Subject: [PATCH net] net: psp: require admin permission for dev-set and key-rotate
Date: Mon, 27 Apr 2026 12:58:56 -0700
Message-ID: <20260427195856.401223-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dev-set and key-rotate netlink operations modify shared device
state (PSP version configuration and cryptographic key material,
respectively) but do not require CAP_NET_ADMIN. The only access
control is psp_dev_check_access() which merely verifies netns
membership.

Fixes: 00c94ca2b99e ("psp: base PSP device support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: daniel.zahka@gmail.com
CC: willemdebruijn.kernel@gmail.com
CC: donald.hunter@gmail.com
---
 Documentation/netlink/specs/psp.yaml | 2 ++
 net/psp/psp-nl-gen.c                 | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 100c36cda8e5..bfcd6e4ecb85 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -188,6 +188,7 @@ name: psp
       name: dev-set
       doc: Set the configuration of a PSP device.
       attribute-set: dev
+      flags: [admin-perm]
       do:
         request:
           attributes:
@@ -207,6 +208,7 @@ name: psp
       name: key-rotate
       doc: Rotate the device key.
       attribute-set: dev
+      flags: [admin-perm]
       do:
         request:
           attributes:
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 22a48d0fa378..953309952cef 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -76,7 +76,7 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.post_doit	= psp_device_unlock,
 		.policy		= psp_dev_set_nl_policy,
 		.maxattr	= PSP_A_DEV_PSP_VERSIONS_ENA,
-		.flags		= GENL_CMD_CAP_DO,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= PSP_CMD_KEY_ROTATE,
@@ -85,7 +85,7 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.post_doit	= psp_device_unlock,
 		.policy		= psp_key_rotate_nl_policy,
 		.maxattr	= PSP_A_DEV_ID,
-		.flags		= GENL_CMD_CAP_DO,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= PSP_CMD_RX_ASSOC,
-- 
2.53.0

