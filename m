Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD52EF653;
	Tue,  6 Oct 2026 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270282; cv=none; b=DMe5NbZkFkZJxRQoBmEhugOhOr095ANa7a8MfksP9xtrnw3zo7y1JDn5CUOnJ6lp8QxQUycVzWvs0tJnRogxA/koe00nlkTwg4O6HUU2nkF8oo2mUtviKUs+SDOg01zcd1754cxX6MmuLaYXyYRuDa8IRFKoXlMsAzDUhzJDcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270282; c=relaxed/simple;
	bh=gS5j/TZ6Vj88SAfRmPzcUqPHiOltknzfAZ8nr4U4HN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7ri7zpVbw8B3bbH4nSaZQxuKbeprBbr9ptQnlkM6REa+Lq8+GkHpVFs0W5cRYzE507j6DO5RVvu7MlffpbAqet+b80ADmA/D6XDSdCE5HxGmkPUPXqstpQ4O6l/aky7c0WnGR7u+53ROx4K/glIfQwK1aoq5gpQ+Mp4SF18OWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=h6jgK0DI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="h6jgK0DI"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CBD482083F;
	Tue,  6 Oct 2026 09:04:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dWUx0ufHGtU5; Tue,  6 Oct 2026 09:04:37 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 456AF2083B;
	Tue,  6 Oct 2026 09:04:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 456AF2083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791270277;
	bh=o9IPAcQ1v6LRdaOkMQoNKl4jZsJxwoH/eVJUJo2uarA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=h6jgK0DIiHnaeZxaeEJnsKYAeaAeKrx8P4eKjcUOR0cgQ0ZPz1bs5XEY/HoY3uc7X
	 XXSmsv6zyuPbyk70VyaHJhIWGT3/awQCUtklKaV2na9jh0rbiEBw+tm2F1YZUqF6Cn
	 r1Jvhomaf2BZ8YTEeezxZR2Qc+tyE9/JGZYprqNutPTNt77jEIS290x9505S509c6q
	 NVywYiIf94i/5ovyf8egdE0kYCYHZ+n31YemxgbiXlyFF+WHP7c8ugl7W7ZON62AFf
	 wcUk7dLb3dK29U7d44HSUIWz0PTPX24onvbE6ZYq4JxRq7l/C7tEeu4eEW9JIZC6BB
	 rwN+TKPCrpCJA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 09:04:36 +0200
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
Subject: [PATCH ipsec v4 2/9] xfrm: state: reject mark with bits outside its mask on ALLOCSPI
Date: Tue, 6 Oct 2026 09:04:27 +0200
Message-ID: <migrate-state-fixes-v4-2-d5054459fc78@secunet.com>
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

__find_acq_core() stores the larval ACQUIRE mark raw, bypassing the
insert sanitize, so an invalid mark/mask can never match any later
masked lookup. Reject it at ALLOCSPI time instead.

Fixes: bd55775c8dd6 ("xfrm: SA lookups signature with mark")
Cc: <stable+noautosel@kernel.org> # avoid breaking existing userspace ABI
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v3->v4: added this patch
---
 net/xfrm/xfrm_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 0723d791b8b7..6b53373168b0 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1916,6 +1916,9 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	x = NULL;
 
+	err = verify_mark(attrs, extack);
+	if (err)
+		goto out_noput;
 	mark = xfrm_mark_get(attrs, &m);
 
 	if (attrs[XFRMA_IF_ID])

-- 
2.47.3

