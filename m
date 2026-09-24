Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103135C6A4
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257666; cv=none; b=AsL8zG5SJZiCy8ukw71JEtPrdFrjZ5cVUC1JentDztUwx6Ur7icX32O9vLzK7wKt8KgFN1AoxF0QBaAqpde4cCdLF4tEdemjKb1xhtSMMTZpSN/JmtnoGRPKyEMACvqJApfXRnf9zQLWZ/QD2uh808Y8WsS8lbuvHVxhwaRYTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257666; c=relaxed/simple;
	bh=7srIVCcyzfJlNEjLamVaN3gaCo55/Zv9Ou8WVB7j6bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DcR4vjNNQCQ1W+crcr9yV9m6v5uxtKcvYygjSQFpkhtw0ZMqJf3Nn5YrCZ3GI+b+lNBscxiYyzWvXNQhEuhuEq0+yiPVASPERgV0WxPGrKk1CQBf8Fj3tiW0x8LqFGUR715tmqUoKedh8Z6fSvp3YncgTIyQ3CcpcAWjnDLm5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjQQzawk; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjQQzawk"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a082c014aso192576985a.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790257664; x=1790862464; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFdKyaeaKmqIhmbpxSD6/2P1HoxAzOxSPYTDMFNxWss=;
        b=TjQQzawkGHa+DWj2WVb+dRqsGyOC+A8zkUWKyfjXFu/Tw9q69UsrkCRUt0LSAKrMVZ
         r1XEMrEhxFVWDMK/vj3BthmRilawqokYpPtkxy9OODqSJnlXo2s3HZYlj3alBUzM5rFk
         fBEdMMmUaVA8Ntbu63HZ08btDMifKFbDWNqDOsBI8jE6ps7qvvu/TOUGTSUpV51wHLZm
         d22bawXj9NT26Dpa9GaCmJ+OChywHDSh8KLcHAffAQmMv7ANhAyT8V7g9G4OH2e/+Ggz
         1CzbGSKjasSjGqw5Yj4kViVpeatmqdkMRYNVdki3cwsCffJG6zV0XUI172plq0l8l/Q3
         Hg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257664; x=1790862464;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kFdKyaeaKmqIhmbpxSD6/2P1HoxAzOxSPYTDMFNxWss=;
        b=CE6pxj77QCIsLZZepny5SCfrfBhiYThU3oz3qmCxtwTHaNQTTQhYVaqGwXijfG9rHH
         s5wBgLDmvP8dyyiMxsQEoUYkv/7wh93iVPZmU+wVtPCZi6zgNMYXEwnWwkpNSGtPP4+6
         23d3BQi/OZswKmQYuqJh5bFT59eUQRsUBQ0BYrbXf3l+QiuijWD1nu+NdTm32Qq14f1F
         KP2Aq/TJC2bCiKw2EjTjsq9NEhux53VFnR3FRTpGZkqulDJp2wMNC7Z1yOeVM1RuTIUw
         R/rOsV5of1BYFF3MGBHkVxYdA3AAv3syv2aKPyx1JII9No6XaS83iL25PiVMRHfEcXa2
         LZ9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwPo5Yf7gnMUf0BEFyR3Rg9ZIM6RxG6BaOHdAj4qlcBvlyg6D3gBYE+zI1vWcE4xXdiRLdOpKk=@vger.kernel.org
X-Gm-Message-State: AFuF++kheRhTSlVMeEbSQTNru7MY8peP9zn1DjbVIlwtJv6pE4EbBP7e
	FsWEnvyYsh7b81TGk7HpMdsRqF4ORlaqPnZxgV64sMt5zuCSgbQyIMXhv4ghOdHbDm8t9MGtg53
	BzlugpAXO7WkLrA==
X-Received: from qkkb17.prod.google.com ([2002:a05:620a:1191:b0:93c:3e09:58a3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a13:b0:93a:14f3:8de3 with SMTP id af79cd13be357-93c3667af3bmr275494785a.14.1790257663354;
 Thu, 24 Sep 2026 06:47:43 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:47:28 +0000
In-Reply-To: <20260924134729.2047213-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924134729.2047213-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924134729.2047213-9-edumazet@google.com>
Subject: [PATCH v2 net-next 8/9] libceph: use sk_clear_nospace()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helpers instead of open coding the SOCK_NOSPACE
manipulation, so that TCP can later maintain a cheaper private
copy of this bit.

No functional change intended.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ceph/messenger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 212e7797f9e48edde4a4536bba6f1ff293628b5b..cc7db8c61db37a998b698566caa7c936fa83fe4a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -375,7 +375,7 @@ static void ceph_sock_write_space(struct sock *sk)
 	if (ceph_con_flag_test(con, CEPH_CON_F_WRITE_PENDING)) {
 		if (sk_stream_is_writeable(sk)) {
 			dout("%s %p queueing write work\n", __func__, con);
-			clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+			sk_clear_nospace(sk);
 			queue_con(con);
 		}
 	} else {
-- 
2.56.0.rc1.310.g51773c2048-goog

