Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142F542EF5
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080055; cv=none; b=Y417TP86wrAzHqAU+JroqYbKsDpzNdCe9k8aGx81Sn4ElkgPJoM+NFOzMd3QUlSpJmY2gGq3Q35jhsf3Fsv6PUK5yx15vwaEi1n3yErmeSih6WNCVReWzhqbu3V4qRGtjOmn4c2YvB3Pow5XJgtPtjhWI8wegG4FU554KaRn5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080055; c=relaxed/simple;
	bh=jr/KtEW7KYC2+rTOfwcmiOtH2k955nYomJuav4LNBgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TSL4Bfg4y6CgE3LIvkUne185RpC1UQRVW20NVGlW521Y5yzuNSuna8RvXU0eJys3T/hIl+++XFjSjAsi3awlSGHVT2Tj7F3+3v6QaJ50Q2wwASW2UTv48+8qXFNZl0IIP4tw14fqXsdOxfC0l9sGbhrRvDWtNYCFM2scwuNSvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wc0wfCqE; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wc0wfCqE"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91235881828so53825696d6.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790080052; x=1790684852; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGpC0ihvYOFiNrz/4mz9X4NMWcl4EBxu84iLMwlMRbM=;
        b=wc0wfCqE1AfW10+7PPXY+tgRGjDKnJ3ggsyfHGlNNI1BTVH2u6usCfzvy3ecP5D4Ux
         3pSgDXF0nay4isybVoKQ+++aKjyDpggyEOrcxt6XIi1Bh8sTRgP4khmoZN3W9vpui+QR
         jsNufTmdRQNw8t+fBaWJSL0fI8RZj/7JQopQdj15Gsj8yhFwzjE1aQPcMyKI4rizDHJo
         2n+6HKGtliDEgcEzy6GeeRJ02N0jOvbyMK3suLQQGbCbXLOewTpW8p39VNlWbzIP+era
         S08j6GJxqx2jaUQuRy6D7a4QXjV3YVTKB6Ag7I/+MvG1zrgqCZgk3dbSiZXya0T9sGOr
         M88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080052; x=1790684852;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGpC0ihvYOFiNrz/4mz9X4NMWcl4EBxu84iLMwlMRbM=;
        b=SeaWMawScSVeUGzbcDQbkQ0OYJTHNkdh/AbuBQgunDeRdukEJ95lLsuMX/09YDVPQC
         gNEL761F6IdRt3CVfUobJqZa7VQlelJzN4VssBS4WWCIydem1eF2Ah5suBDkZjYK3lpd
         JXwHOGD4dPfisSGNfjSc/hlZP054aGvCHNE1BiSH+KnJvyc/lnFWUDPwC0s9Zh3KuRzF
         F5rAoMNrobm9mqS9l2Tjt+KDlI1aHLQZa3zy16VKcLPsT5orkQl54jfO8J8hXCaFPjNL
         zpW5CPXZOUwhmagpUdAdxsHe3fGr+CWAVp2ZA1pc9q7qmFcPkkaf0Lr/cx+z1zau3a54
         UGpw==
X-Forwarded-Encrypted: i=1; AKwUvByegIEU/mBe9ZiQLrozX/pNMSNNl9rylraeFc0lHu0iWj4VH12EUUoIhOR2Isa5QUDUVJcHdZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++lJkwuyj+6eIlfkJvyVsowyv03ysrCXo08aTRpDev6uPisgWaAS
	Rdzx/2MT9XH7BDo24e3sPmbgDJuezkE7Lb1rTGy08ZaZ+1erouil40cFvg3DfpjaC8elJ62LqlJ
	qvI24UmD9V2BSbQ==
X-Received: from qvsq2.prod.google.com ([2002:ad4:4342:0:b0:913:f6d7:de38])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:488d:b0:912:517b:20ea with SMTP id 6a1803df08f44-913fc967483mr55180856d6.50.1790080051479;
 Tue, 22 Sep 2026 05:27:31 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:27:17 +0000
In-Reply-To: <20260922122721.3568295-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922122721.3568295-7-edumazet@google.com>
Subject: [PATCH net-next 6/9] drbd: use sk_set_nospace()
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
 drivers/block/drbd/drbd_worker.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 0697f99fed18d7e70f00b7c559a131517ee8aa42..8e50131b5a5692a8dfb99eafe706602153be94b7 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -635,8 +635,7 @@ static int make_resync_request(struct drbd_peer_device *const peer_device, int c
 			int sndbuf = sk->sk_sndbuf;
 			if (queued > sndbuf / 2) {
 				requeue = 1;
-				if (sk->sk_socket)
-					set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+				sk_set_nospace(sk);
 			}
 		} else
 			requeue = 1;
-- 
2.55.0.1082.g2b9226bbc0-goog

