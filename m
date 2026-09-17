Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E6361940
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685120; cv=none; b=qLYuwl3s6c0IzRYMEORdl+LqZyY1iO3/BrzNYyanNL7Efq2EtfzEFQFGKh3C8Y/epDaHwvhfteJf53I0uGFRrFuqX6pKkR1jhdlRZJgQFvAbfM+x9fDOLnMahSM5EUi19NfKD9DU5Qqx+9INCkIWS8k4MLcPwoeEeJYx8peOVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685120; c=relaxed/simple;
	bh=I8RWe4q5MO9zPETh9+2kBCF6oXc9g9yJMLj7u3wvRVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InLAK/mBCAthqL5nXLuu9alaBqqGEwUQ99H9kiAjdPq3qLdrtKwOmkHjJqlfT+cjw0Rp/UxROjgfz6MobsdVzzRjSihjnFHuRZ8SGYONS9eYV4Kj6aArtswaTQHjRhW0Z5fY/DygdnZEB+Pim3PISWL9goX2FhFQazaCwyByQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bnUL9Kes; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bnUL9Kes"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a9baso157204fac.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685117; x=1790289917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqxfWzZFAI1DRpQFPS4qFP89LRNCmhZAUy7Ea6RPwb8=;
        b=bnUL9KesMMTuzkEBDvIzlpw56y6HX8RNYdAuNXzp+uo3ph1rLn5HBSXuC6ZAotIDmz
         gYmRSjzOrX/WJ0EA9ioOL3nQURX0/6uH0xsXT6nVhwOTD3Qj1vuK+vkIcrVjUIeCB9sC
         QT81T9Pfrqh8AsYpunNyR/qg+1hbtireDJUji6eluRhZNBlwxua7vXY1fGn/bmFRrAre
         gb5gqwK5oyhLCxVy0FbyGhqBANunDNpwNQLqNVkNqSK/PztUDgrGWmUKn0RDLtwF/e69
         dBePtbBqEi8PQqV5NVobsGoTk8TM8PcOVTukzW1Vfi/n1W9oA9Glmt2XrrzXj7QlUbOp
         rmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685117; x=1790289917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LqxfWzZFAI1DRpQFPS4qFP89LRNCmhZAUy7Ea6RPwb8=;
        b=1ixL+C6sf6FMTejI+PZccpdLvV3h/oQ0Z5ZQQJID50xm/v2UDoXQJNiSF2NQF4HCfJ
         QyToF7HHxCioZfHt/uCAtTKXbYVRns8tvHXOeZIOixFHpeTmqizfGZh7Kh4b5/NKFr/8
         QpCzSwSPaXRS2kTP0RMt7Mgb2gZKEh+Beqdw68vyBpe7idtW1LoV7kpZWOETBtI+FRQC
         DKya7QDfO3YFEPDazV1FnTxq22D0tK1+v7t5d11+L9amedrs4DFKLXjHS3SIevyOY2fX
         uBkOP/OBqPbUA+dlljxg5flKn/CuW4cj8DSC7Hi8GUsu3QuUJZn/hjD0C+1djdrS+Y4k
         KIUA==
X-Gm-Message-State: AFuF++lOfR42JgP4bhtq+WahhAew4tN3A2p9ITIlNn/MXCsVB0nB6CbG
	pgDcVLQeTDjeeYOwKprVaUbT4by1yiWxPYjgvls8l5w74PXuo/Nkff+HUri+2APm0f/Yv2cP2ez
	3g7Vm8HZxBG5j0WN0ikMcvzlC3Yr0Hu0haLBhpEUNLJKhBRnd+DCilmI1n55Cu7Ydy63QVu7CD/
	t5hlwkits1EoigMjwFTNi6RShU+EE3/Hwii4FjVJmMT5PJgME=
X-Gm-Gg: AYBFou37hGiBeuS3YVoRXH3kknblma+HZEhx1ikg1n/JPABd5QBz77fcCiIT5PuZS7f
	uD9HJ63kYEf2sUp6VUpirXutT84nXKs5nYa/UPuW14Mopz/z26B0j7sXf7RehhBhudIq/xhKgt6
	fMyOfYOTPqayrmY00DQ56s5H3ho2OduX9Qlvz78Sb+GP3LKm5Sghd0qIDADaSWCFSuZOg5bK4Vs
	e/T02yh9IFEt4OxMoEGDoEwsG4cyR64FPqgxPgrBFoVBsir8ucJIiI1Uk4+vL/RAmcwzinmQ+su
	DpewZ2m8pwBh889yQ9L98LQ4jXf1yQTageqBO1qcnGlFN4y+vdo20z5gDGtLwKSPvqgBwUDddZK
	OZaLxES5m7r8iOla77OUANghjzR3srPTxetBebHrtAemZMTv+wN1HqkCyRuRlgmmzcRMrTKnyX/
	RVF+PTXE6z8Zd9/hXFAKV1W+Vkzu5q665zpXv3dlRRKMSPN3R9NrGps1UKJvPHnLfFI3Zbhzo22
	+Vi8UZvKeMDfIYPBeDA80js+lRkjhXf0LOC0XHiOBj/sw9ce9bOnYEouzaZLq4wpzCfs8cD+wla
	/SglprnzsUZrnT6HR32PoZCu0x+zRjbJZW70bG8awFRmAU62270BlbHN0HIxiHi8tV4l5ipAWeG
	fyQxUGUNoeMXmha4F8Q==
X-Received: by 2002:a05:6870:207:b0:475:e235:8f9 with SMTP id 586e51a60fabf-486e7208581mr576573fac.23.1789685116488;
        Thu, 17 Sep 2026 15:45:16 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:15 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net-next v17 07/15] net: sched: re-validate parked decrypted skbs on requeue
Date: Thu, 17 Sep 2026 16:35:18 -0600
Message-ID: <20260917224355.2288021-8-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917224355.2288021-1-rjethwani@purestorage.com>
References: <20260917224355.2288021-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A still-cleartext skb of a crypto-offloaded socket was validated against
that socket's offload state (sk->sk_validate_xmit_skb) at the time it was
enqueued. That state can change while the skb is parked on the qdisc,
e.g. a TLS key update or offload teardown, so re-validate it on
requeue, letting the current callback decide how it reaches the wire
instead of emitting now-unencrypted plaintext.

This is a prerequisite for TLS 1.3 device-offload KeyUpdate support,
which swaps the offload state of a live connection.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/sched/sch_generic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0..fc8ef0d13f5e 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -285,6 +285,15 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 		*validate = false;
 		if (xfrm_offload(skb))
 			*validate = true;
+		/* A still-cleartext skb of a crypto-offloaded socket was validated
+		 * against that socket's offload state at the time. That state
+		 * (sk->sk_validate_xmit_skb) can change while the skb is parked here
+		 * e.g. a TLS key update or offload teardown, so re-validate it,
+		 * letting the current callback decide how it reaches the wire instead
+		 * of emitting now-unencrypted plaintext.
+		 */
+		if (skb_is_decrypted(skb))
+			*validate = true;
 		/* check the reason of requeuing without tx lock first */
 		txq = skb_get_tx_queue(txq->dev, skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
-- 
2.50.1

