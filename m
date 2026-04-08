Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0F233149
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642379; cv=none; b=b7KpmzzOJcoYlDtkZlp0TTBJuV1lqEZjLmHPXd7cEAjw+AMl4niRuYNNRCmmsX5W+xM+DGRx2+3KLdTj7sggKvNWoSWbLf/jk88UbWKaxFdALQRTGvFg0OXSVsr9UknrqqFP+CAV2KoRLkE4MIP1PP3GtXFswewVVi10hh+iSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642379; c=relaxed/simple;
	bh=2uak8dpO0m6K1gym7vC9uPJrYDMB1eT7r3dGEWQlRcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vD/b4nEsR5mCrjnZa0P5Lw6ZhfPyZA8ZUfIKQp5r59TvDWZxpRnm/3WTKWeVV5GxRLh99Ul3eiX6Wxcy+NnxMfaqsdD86ePJZu+c7vFEpVbzB5mkaEZTBghnMMX623XdlH9KsFPx6fkQdJAEoj55lTrbFAN803rwy4mm1wel1y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nRlfTEBB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nRlfTEBB"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7AC56207C6;
	Wed,  8 Apr 2026 11:59:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymguo1uEIldB; Wed,  8 Apr 2026 11:59:29 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C75FD20660;
	Wed,  8 Apr 2026 11:59:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C75FD20660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775642369;
	bh=/iUxxM8YhehbLU1z91gQi75+VTKsxpVJQKgjBCQl1kE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=nRlfTEBBlzOnKmh0yM1NIp3FOY2MiGbSjCzx4lPE4qmOVBj/I02v62TWgMbj1XVvO
	 CgC75oyHg9o+rzBJBK9zmKysbNU/S6bJhlrjOMyGBYHp0DS5F5qZVRwTimBWILf47L
	 BF9aM8JTsGZ6aYS1dJWu7JCJnKEx6UOEHNpGv1wy70T7C5OVGL/Eal6QLMhFTH7u+f
	 MRkGeEZBc8RFzLksXn9IlRJ8183G7q1N9inpKyLsEv1cgHveoE0gpB5bbGx9UiVqTc
	 k2rg94t2kJdReCg8fXri8jAikeqjFw8LVFYJ6xxRsNUsUHtKY0AdPrhSZudF0BNWwL
	 hAEnnAxyh08Ag==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:59:29 +0200
Received: (nullmailer pid 257136 invoked by uid 1000);
	Wed, 08 Apr 2026 09:59:28 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 7/8] xfrm_user: fix info leak in build_report()
Date: Wed, 8 Apr 2026 11:59:03 +0200
Message-ID: <20260408095925.253681-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408095925.253681-1-steffen.klassert@secunet.com>
References: <20260408095925.253681-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

struct xfrm_user_report is a __u8 proto field followed by a struct
xfrm_selector which means there is three "empty" bytes of padding, but
the padding is never zeroed before copying to userspace.  Fix that up by
zeroing the structure before setting individual member variables.

Cc: stable <stable@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index baa43c325da2..d56450f61669 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -4125,6 +4125,7 @@ static int build_report(struct sk_buff *skb, u8 proto,
 		return -EMSGSIZE;
 
 	ur = nlmsg_data(nlh);
+	memset(ur, 0, sizeof(*ur));
 	ur->proto = proto;
 	memcpy(&ur->sel, sel, sizeof(ur->sel));
 
-- 
2.43.0

