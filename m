Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371955;
	b=WRZUpngh/zmdU6JY+vvf1PnFKcwI3+Nl8IP1mIpXDJ48Nwq59KtKvS3SdpMexacwHmRr
	 vRX4OiIeuL9WncXLA6ywo3GKxG5pfvyHY9tkS/Wn5F/gS8e9wx4AqFbHJ9b6GUufWawGr
	 psMryLiUm3KzimrCFWHCkun6ZGeHisqMxPKaDJjntEjmgVpCzVAIWMyXQLR4ACy7EvRmH
	 dnkjhOA5qZfja9LwTtjndCLDtpb7NWnVJHHG1RBtzRTbBnacnDaQjuNcu3KhAdURsVyRx
	 rTZIqoF3/SA+vwbrpPUU7I+B0kxuzo9DdbUHZpXOXB3I6LMqn7146y/SzNNlcvbBajQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WryfGeT+vcA0hEKns0lAxIOc3DwXOBIlLJSuHcQeNLY=;
	b=tF/nWF6kgufjSNvmI3KpUjd2sOyo0uQ4PplagdABtOyEv9GA/+P6akPGXmJI/OSbn6lQ
	 L7BpXlMMwoDM8V5S/rC2WfFJQKsAIykCOkPWA+ybf8bxUSlZurTBv2HDN2e46yt7uG2UZ
	 7bbO7TQZGtlmHSzkkQ/LO9bIQd5gCzm+q0FyXK011AzhFCTevWd1WJGkxrQTVRH4SBRgq
	 aZ87Bp8A96ww12ZjT49O9ewaZwUhXd2+MOHpCQAH8C5WrEaiK4N5nZyOHVQ/pnq3rxeib
	 wAK8x9Lr5SNLtboi9YuqmkHjw4vkl+cbO4VIoMCz/6yhMvAgBSE5Dnr1Lqkm9hVxwEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJ1Zy7hr;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48402606A321
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48402606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJ1Zy7hr
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1061187f8f.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793371952; x=1793976752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WryfGeT+vcA0hEKns0lAxIOc3DwXOBIlLJSuHcQeNLY=;
        b=DJ1Zy7hrePIrHOa9f3Fq8iYLUF3Fqht8+4qjw5mvNj2VWsuqmC24QmTaO1CNTffjlR
         geTlZkqqQhjaliRasXlK07WGKHsjFO90VXFnjDsdIx/7kigEoZcsROEC2NHL6BBsEJy1
         ZvdaYrIcwm0UECAHi/rREokTP/dFemT4pyy2IrqzvlDfu29TVlGgnY5l8b7ArO7kNW71
         mvAtRtENnkfpvyDWpO1BXxH6Y7PLGiYU49bznbfKLlWC9+wSIraOiRMC3T/Xx2UnYw/q
         B+6CPB2adIJCf/heTjdR5vmYjGWhqiHbkxUY4s54KTjb+rqEdSw0YyLlNJ9B04Xx9vWG
         0gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371952; x=1793976752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WryfGeT+vcA0hEKns0lAxIOc3DwXOBIlLJSuHcQeNLY=;
        b=mTcdeFTvRglBmJdb3DxXIOv/H7Tv00IHGMWQOw2QYqQMUCUiA8s04RslvvQfa7ynvB
         ls3YKv9cvrI2V94nfUy72cbn+xI3q5zJ71UihlYv5yhDHfRE29e+dK4Hwb3yiO5l38bg
         x9+Evell+LL/6vDJajAmVhtHrZGWgaaF4koHZ0lpI/1a1qqLs+bl46UDlDcHRbinAbtp
         gZd/25tF1OYEIAQDNVBlDKZi5PNI584Vuf31VDLzKWBSBK5SHPISMbt78qRjEdZf25Xb
         UQEg8k2/Ry0FXwc9HqHBtPBrTnsbQgCwBvc61wt1AvjCSc0dPS3blQfZ4QQW3ECLs6BL
         U+aA==
X-Forwarded-Encrypted: i=1; AKwUvBxNwXk30gTEP6TegtwlSYNQxUVs/rw64b+yJ6D2KB91uEDBYoSCdzgqdgK/ngdR928T113/bKc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCjq5mMYm9bOvFpE0lL6rMQeURm+qzFbaoJPt3+OLvxXLq31qM
	QMW53rxHpSSaIAqZN580Y3aJ5Z7zgIVjwrp4DYO7m0NPJpDdc0mxKKw=
X-Gm-Gg: AYBFou1SXPAfd7T7sIiSLgxVfoDkOxJYJmmVeinelb47gNJQ4HZQcF24pdwqAeosQch
	t4Jzu5AiXoNZu2XaK7CNJeBfPN/z6WCbsLXivImYKjueyH+7AyNWDRmsJacPH2ZpX/Hur7xDO8/
	ZHPgUyUckksfKqcTAL3wZaiaT74MXNGd2DHcDUVHqL/OzLRTXp4QUIL85OKI7KjxBVwk06hJbki
	Ilv2QRImbo2Js9bFto0BfIcBvuuBfZIPPsph141l8wRsBrtorG7mAJ5FH1fBhZ1IISojjW/XSqM
	BmoUORMXoMBw45TUAQMT0DZLT+VnbaPZW2gw7K5FCoWSTBTQxh7guRnAq5qBGwzsN3qluvPYzPu
	ctWomDQ/QhvDdgdRazFaF3toZJgllaB2ngT0OhooatqV+XVD7m9+HWXO3NPcJaXrt92Kqp/xVmU
	i//OIqP06D1QO5gIOYRmYP9B5/3UejlBJqmGTksJnabvKvFNSZp65dLNjFz04r4qxBS3ZcF6iGF
	k2ONRmdjDP7A6GKmWJ7yeExPx3cI8eoSdYK0tGocw3ddXwAv8qPYtjdXJ9fb9+NzU1hEdgCQQ==
X-Received: by 2002:a05:600d:1a:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4aa86e16223mr144024615e9.2.1793371951450;
        Fri, 30 Oct 2026 07:52:31 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78f95sm3304241f8f.28.2026.10.30.07.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:52:30 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 ipsec-next] xfrm: check state validity under lock in xfrm_state_find()
Date: Fri, 30 Oct 2026 14:52:29 +0000
Message-ID: <20261030145229.74412-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

The output-cache insertion path in xfrm_state_find() checks
x->km.state == XFRM_STATE_VALID before acquiring xfrm_state_lock,
then inserts the state into pol->state_cache_list under the lock.

While this insertion block is currently unreachable -- cached is set
unconditionally at the cached: label, making the !cached guard
always false -- the correct pattern is to perform the validity
check under the lock, matching the fix in commit ddd3d01329203
("xfrm: Fix xfrm state cache insertion race") which addressed the
same TOCTOU for the input cache path.

Move the XFRM_STATE_VALID check inside the critical section so the
pattern is correct when the cache insertion becomes reachable.

Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Reclassify as hardening: the insertion block is currently unreachable
  (cached is unconditionally true at the cached: label), as identified
  by sashiko AI review. Drop Fixes: and Cc: stable tags accordingly.
  Move from ipsec to ipsec-next tree since this is a cleanup.
- Reword commit message to describe the current state honestly and
  frame as a preventive correctness improvement.
 net/xfrm/xfrm_state.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e45aa1ed5b965..03baa50f0df7c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1632,10 +1632,11 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		*err = acquire_in_progress ? -EAGAIN : error;
 	}
 
-	if (x && x->km.state == XFRM_STATE_VALID && !cached &&
+	if (x && !cached &&
 	    (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
-		if (hlist_unhashed(&x->state_cache))
+		if (x->km.state == XFRM_STATE_VALID &&
+		    hlist_unhashed(&x->state_cache))
 			hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 	}
-- 
2.47.3

