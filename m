Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC8542EFC
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080056; cv=none; b=KgffCCkSrKazaUC1VeLj2D57uT9zK9ydUp2rGR/E/dAfVnQgFttQ0/IX+NCTPivnUd10cyTP11sNCFxVyqiqa/Iy4Gdwi+VzoZZgy6nR7CF+m92/I5S6nPlc5q04kXyN8p64WNusRh/mKQjH0QLWnHHOqbdaeheoS3E8NfQsszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080056; c=relaxed/simple;
	bh=N0sKQuAdI4a3cSy7d/mQeIi/CXx1oNfcccUUdWDfbRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZzYFTyXuc7oyi2I0oranEOpERr0s3jdzCYOHoVXGO4xfiUrQiOdzkhj3T45Cdg4jABPrHCx95ysJ5+Tl8TNkZRu1zcf+1xhgGynfaUc6Eu9JX//zawZdiSN+Yjn1u3T1H9IkQp2B0UYYrCkjOMw/n9BSD1KvRyN06QZNxtEgTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQHN7kPi; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQHN7kPi"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530f65ddee1so91589241cf.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790080053; x=1790684853; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9JdDVMocj3DbSLc0qggvhWFgk9QEF6z19Hx0Q+qQLw=;
        b=vQHN7kPikrNUieslXD1WrHmEEGoTvDD/+npzn0H63j9OIjRLZU3SgDpAWYzKdi0P/L
         Ir/gbJ83iWyVPe8CZpIOUMfpR57WW60JCHpokkcPo0IzydUVESbWwJSQ7SSywNgRWmHb
         J8PzI2iV7X+VTzcg3mhTC+iL8y6x4AiU1gVXhCRhNHSI0lk5HoKMFUcnt/h2qQXe9t75
         fW89aCz2Az2+y/G7Jlyq9jlPf2rQJY+7dyEBaZica/0WsEXyixkNdMsPQEUJgrq1M7/H
         x00iJcwYZ1uCQEcVNVeLR7wC3MOATjCqAr0F9+RUmapYNWH2F78DaFqh9y5KDtKtTB7F
         8+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080053; x=1790684853;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9JdDVMocj3DbSLc0qggvhWFgk9QEF6z19Hx0Q+qQLw=;
        b=Oz9N0WzHfxbn/1GVr49sDcKQKOYBLHiEs/kf2JUlFfdFXXoseq5FZc6Na8pdweHqWJ
         Xn4/ONl8TtUWDsmWLqlwzj5YPbrWC6vyC6M4klb5CaTZfxqWQuaGS4yNS8JDZ7CI8Odc
         lM6vJXvc5xfEf6XKihhJN8tyCgvs2fngNP8Bna+ho8mOcrK4DAPuVerYd14OKAMLiO8w
         OQTUY9Mha30+nrVukooGbGesbQeU0DPpOesUFfYMPBLMif0py7naX24iWGLnVccyvBp1
         YetnZdgPvOMytUMk+7bioVTpaoSzT+ezZQDcLa5xsnm6GSupHTSZs6KGWlyR3v1+RP1I
         HCpg==
X-Forwarded-Encrypted: i=1; AKwUvBzWHQd5jNkmSlzKgFVNMNW+47t1y3dDQlhkhoLOKSDQkmFQC5aT6Zg9/8HnRGpwcCfFbbfqL5o=@vger.kernel.org
X-Gm-Message-State: AFuF++lYUcH0Nd6jACN/Tv9Ts7v0XI5ScwQBvH+Asm21NCSYc/pnqGQS
	MOLK35d5bQHItZapFN2/O98hJ/cDGq9mjduwu5Djy65IUCRDihPNft++suFTakfb2I73KCy0XgW
	1tW4sp+mAQWLgzg==
X-Received: from qtbbp13.prod.google.com ([2002:a05:622a:1b8d:b0:532:90a3:6e67])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f14:0:b0:531:2394:966b with SMTP id d75a77b69052e-532d8d69dedmr54432431cf.28.1790080053201;
 Tue, 22 Sep 2026 05:27:33 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:27:18 +0000
In-Reply-To: <20260922122721.3568295-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922122721.3568295-8-edumazet@google.com>
Subject: [PATCH net-next 7/9] nvme-tcp: use sk_clear_nospace()
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

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/nvme/host/tcp.c   | 2 +-
 drivers/nvme/target/tcp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 921934028e0b22c2e4c9fd60d09ed8e50051262d..b853ca2d598fa4cb8ea9cb66513f1e1070cd1fb4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1133,7 +1133,7 @@ static void nvme_tcp_write_space(struct sock *sk)
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(queue && sk_stream_is_writeable(sk))) {
-		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_clear_nospace(sk);
 		/* Ensure pending TLS partial records are retried */
 		if (nvme_tcp_queue_tls(queue))
 			queue->write_space(sk);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e598101752620448423925d2385b606e0b4346e8..c38ea3501ea5def168b6f180b56734b99d21bdea 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1686,7 +1686,7 @@ static void nvmet_tcp_write_space(struct sock *sk)
 	}
 
 	if (sk_stream_is_writeable(sk)) {
-		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_clear_nospace(sk);
 		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 	}
 out:
-- 
2.55.0.1082.g2b9226bbc0-goog

