Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB92C3266;
	Tue,  6 Oct 2026 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270322; cv=none; b=AGvU6W4nEiSzeyIF8HLZJxQEw7KpUI9WF6s0CzN6Jnq0xHt7iPgC/sN3rv9LveIDO1cZUgTSvSb9P/qgG5PmFWsbDpn8U25JBLXatSUVZVnVssHXLT34k+u+xTCquQhdiWlLIUsaexidh/DTV0vEB2WwmmAwxwYOZnQELta3/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270322; c=relaxed/simple;
	bh=iB6d803D3tj03cVduT2Q4AAp5XwjLEA1P9egchava9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/aiN7g+XoXyT7F9fMcYqWtuZ4swEiY/kEOsm5ka+iWLXQ4oUq5Ymr8o/Lpa7JpfW8Eg3guwQw376jQuWQJUfDHOxP0HqJSqOL5tBa6f7wgHFoooelJdI2WIe5+x0wZ11llq1U2ArxwmlAn5SGYMSvphjBNpYG9nXSqyNh6j8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DCaihVDW; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DCaihVDW"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1A03B20842;
	Tue,  6 Oct 2026 09:05:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BMvyweVHLvi2; Tue,  6 Oct 2026 09:05:18 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8E1FD20841;
	Tue,  6 Oct 2026 09:05:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8E1FD20841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791270318;
	bh=9cq2AT9epqHwK1pGaBW2YwHDD4wbMgFKZEKw3UgB3z4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=DCaihVDWwWIL/JOeM6reAvzAo54dhGKg/dVvkzmRoR9L4X8WEcaCDtyAr3DaRB4pB
	 VSLWsexCxb7MM7N3QMU+/LOF45vc+0O4OH50r0y4w605QakRl/8AjCEpGhibDRSNlb
	 g/GMCKk1JYkdfS9AmcmwYs6nNF/Yb4V19HbxLf4jnCih9SyMS81dWUw8LAAD2CPrFp
	 GioOdMP0hBd5E3sjdDuS/NjDerxSwFjbQN+sZqJ9q8xZPe2/WRNu3QhEaFgbT2aHmQ
	 2yht5vRTVAS1t7V/ZIzLDcJFqM4gwqdNIShhHz2W36p7Gq3hkApMOI/8GNxgVgPTf1
	 Zi0d6Z7Fet+6w==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 09:05:17 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>, Paul Chaignon
	<paul.chaignon@gmail.com>, Louis DeLosSantos <louis.delos.devel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable+noautosel@kernel.org>
Subject: [PATCH ipsec v4 3/9] xfrm: policy: reject mark with bits outside its mask on add
Date: Tue, 6 Oct 2026 09:04:36 +0200
Message-ID: <migrate-state-fixes-v4-3-d5054459fc78@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
References: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

Same issue as states: an invalid mark/mask is silently truncated on
insert, so GETPOLICY and DELPOLICY can no longer find the policy by
id. Reject it instead.

Fixes: 0b91fda3a1f0 ("xfrm: Sanitize marks before insert")
Cc: <stable+noautosel@kernel.org> # avoid breaking existing userspace ABI
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v3->v4: added this patch
---
 net/xfrm/xfrm_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 6b53373168b0..c1571c7a2315 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2307,6 +2307,9 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 	err = verify_sec_ctx_len(attrs, extack);
+	if (err)
+		return err;
+	err = verify_mark(attrs, extack);
 	if (err)
 		return err;
 

-- 
2.47.3

