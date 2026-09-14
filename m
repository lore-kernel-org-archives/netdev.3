Received: from nabal.armitage.org.uk (unknown [92.27.6.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2C385516
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.27.6.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412561; cv=none; b=uNm6ikJu1QjRNfI5hv8FGD9nDlKTT4QSG0Ej1p85EaIllRdcoT0/0tgZx2FkeL7HpJDHo5MOqpnk2LILqWOUDC0pKuC3ZYjQo4+xxx5zfjPIT6DavtWtoKpFZ7yDv4H3kO7BgAyg/Md8cNtJK54SmvrV0e2OQq2G6R5xRuIoMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412561; c=relaxed/simple;
	bh=IN3ITq2rxHineyxJ5JFeV+QWw0jp5wltmfwi+5htYiA=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=LtW9GbwqGRwinNLSUyaezD2zhM8YjTiZufLqMGrzNtPlEet1qLsDIKyRZ4a/z/mWO/6UWYZ57YzKktCf6LSBU1pjlW8H7Fmq1SfDrhvcABxDnuT/5ZkB7KWPfZtsVanv+X7G3o+snLXNi8uENOj6nY/M+qNQRR3L5kHluIqLGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk; spf=pass smtp.mailfrom=armitage.org.uk; dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b=vQPhz1RV; arc=none smtp.client-ip=92.27.6.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b="vQPhz1RV"
Received: from localhost (nabal.armitage.org.uk [127.0.0.1])
	by nabal.armitage.org.uk (Postfix) with ESMTP id AE4D02E5E36;
	Mon, 14 Sep 2026 20:02:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=armitage.org.uk;
	 h=mime-version:user-agent:content-transfer-encoding
	:content-type:content-type:date:date:from:from:subject:subject
	:message-id:received; s=20200110; t=1789412528; x=1790276529;
	 bh=IN3ITq2rxHineyxJ5JFeV+QWw0jp5wltmfwi+5htYiA=; b=vQPhz1RVL2FK
	8K/sczzpFoiJgUHUhVktFf4jJwY462kn9iuSvWLZPeEs0seCFMMi5lcyuRYhhfhi
	kGku9h2zRF0Lh8gR/w9l1OOklOVE9kf+p3sr+VGzBM4h2JZebx1qOSOMeVPfe0Da
	s1Dr1CBe0r7oUVuD3Qt9jMsLORPpEWs=
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from zarepheth.armitage.org.uk (zarepheth.armitage.org.uk [IPv6:2001:470:69dd:35::124])
	by nabal.armitage.org.uk (Postfix) with ESMTPSA id 9F54B2E5B06;
	Mon, 14 Sep 2026 20:02:07 +0100 (BST)
Message-ID: <24158a1c7c9d7fc28d42a0be53f3b9d1919caa1b.camel@armitage.org.uk>
Subject: [PATCH v2] net: parsing IFLA_INET_CONF broken since 7.1 if
 NLA_F_NESTED not set
From: Quentin Armitage <quentin@armitage.org.uk>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
Date: Mon, 14 Sep 2026 20:02:07 +0100
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Commit fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly") cha=
nged
inet_validate_link_af() to call nla_parse_nested() rather than
nla_for_each_nested() for IFLA_INET_CONF. A side effect of this change is t=
hat
the code now checks that NLA_F_NESTED is set for IFLA_INET_CONF, and reject=
s the
message if it is not, whereas previously there was no check for NLA_F_NESTE=
D
being set.

The consequence of this is that code which worked prior to Linux 7.1, albei=
t
erroneously not setting NLA_F_NESTED now fails.

In order to maintain backward compatibility, rather than calling
nla_parse_nested(), nla_parse() is called.

From 498a8cffcdbbc3265d2a4747ba5ded6f562af3a7 Mon Sep 17 00:00:00 2001
From: Quentin Armitage <quentin@armitage.org.uk>
Date: Mon, 14 Sep 2026 18:19:53 +0100
Subject: [PATCH v2] net: allow IFLA_INET_CONF messages when NLA_F_NESTED un=
set

Commit fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly")
added validation of IFLA_INET_CONF attributes, and in the process
changed the call of nla_for_each_nested() to nla_parse_nested(). A
side effect of this change is that the IFLA_INET_CONF option is now
tested for NLA_F_NESTED being set, and fails if it is not. Prior to the
commit there was no check of NLA_F_NESTED.

Change nla_parse_nested() to nla_parse(). This restores the previous
functionality of not checking NLA_F_NESTED, thereby allowing code that
(incorrectly) doesn't set NLA_F_NESTED to continue to work.

Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
---
 net/ipv4/devinet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a90be57c63be..5b6b11c943e4 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2117,9 +2117,10 @@ static int inet_validate_link_af(const struct net_de=
vice
*dev,
 		return err;
=20
 	if (tb[IFLA_INET_CONF]) {
-		err =3D nla_parse_nested(nested_tb, IPV4_DEVCONF_MAX,
-				       tb[IFLA_INET_CONF], inet_devconf_policy,
-				       extack);
+		err =3D nla_parse(nested_tb, IPV4_DEVCONF_MAX,
+				nla_data(tb[IFLA_INET_CONF]),
+				nla_len(tb[IFLA_INET_CONF]),
+				inet_devconf_policy, extack);
=20
 		if (err < 0)
 			return err;
--=20
2.55.0

