Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B2377A9F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827790; cv=none; b=dp1xWdETSXuvBG25EzBoZgT2OfaMgBHoihR47iKKYlr0T6UFWl1YQhQ0tzHLLaaChGPEcNbyc/44t56u4P6swI3isS57Mll0Wr4c4HwoSHw7Y5ScwwJozNSEDlyGaHMI9rlKeQkxankR4xWVHrWyoSrapThH7t4QvPLdzla2vrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827790; c=relaxed/simple;
	bh=eIN2VI1+dOxY/AvX/B21/ab+8tpl3GaoNi5PwPC2mII=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=afH70DlJ2k/rb5SeAeUoiNg3li6RtghGj/0BV1HrFCw2t8VdyU14kaAxscLWBAfqRdNlI7pwL0YcIb9Ou7dOe1FSSnwXMG8Be6Sl48CZIB8HrznL8eF7+yPoxiPE4ZkgkW+XlkTdr5AUt8hmUT658DFhpNqw9tsvOsfRS7zpdKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=rCpb9Tph; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="rCpb9Tph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=gh3pqark3rcv5lqt3bz5wyuwwu.protonmail2; t=1790827778;
	x=1791086978; bh=ERqDzcymGJXI6u/SZz6Hyk2IgmEXqPAEJAvYFm6EvX0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rCpb9TphcaOYGg9g2WPc8t1xuUZK6feiykj8psNtfpDeDcrqCfPX7lxsp04ou+ci6
	 QaxjfOHc4wcTcVFo5yvssVUQbg+GGZz2Pz8ON6RryENdgOJL0NkmJ1FEZJRCVCXpWs
	 YvFw0+RmM6n64BdJkp9JN1w9Me1bXcZCJM0GIgrSSj9UNl7pz0F3Ju04mtLZBSvw+C
	 NjpPrYuIcVbnBDkyztyIrXs0lWhnJzEEFQnzYIJnhQO3CVbO8C8ewyc6XtWO4NhbV5
	 ytp3SCjaPw8wg7INzJvHHJddC1XdNKEkjS1bC2tcPlSq7DK4SwjjUytpEVrIe1v/2H
	 tt3fEA+Z93kPg==
Date: Thu, 01 Oct 2026 04:09:34 +0000
To: "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>
From: quantumvoid <quantumvoid0@proton.me>
Cc: "Jason@zx2c4.com" <Jason@zx2c4.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH] wireguard: allowedips: prevent stack overflow without DEBUG
Message-ID: <TaZxFNfdnpo-3szeC-LoWZBxj-6XGhXkdEqnQi6yyaOHXp8cw4Xtksw07sYrIpludwvJQrukFoCGw3r9rXDcInkdB5QD2EswKPNsXMU3qMQ=@proton.me>
Feedback-ID: 175132216:user:proton
X-Pm-Message-ID: cc0681d692d98fbcf4d094f51eb55190625dd138
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

push_rcu() only bounds-checked the traversal stack when
DEBUG is defined. In production the check is compiled out,
leaving an unchecked stack[129] write.

Always check len >=3D MAX_ALLOWEDIPS_DEPTH and only gate the
WARN splat on DEBUG.

Signed-off-by: quantumvoid0 <quantumvoid0@proton.me>
---
 drivers/net/wireguard/allowedips.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/all=
owedips.c
index 5ece9ac..dc383f5 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -42,8 +42,10 @@ static void push_rcu(struct allowedips_node **stack,
 =09=09     struct allowedips_node __rcu *p, unsigned int *len)
 {
 =09if (rcu_access_pointer(p)) {
-=09=09if (WARN_ON(IS_ENABLED(DEBUG) && *len >=3D MAX_ALLOWEDIPS_DEPTH))
+=09=09if (unlikely(*len >=3D MAX_ALLOWEDIPS_DEPTH)) {
+=09=09=09WARN_ON(IS_ENABLED(DEBUG));
 =09=09=09return;
+=09=09}
 =09=09stack[(*len)++] =3D rcu_dereference_raw(p);
 =09}
 }
--
2.55.0
