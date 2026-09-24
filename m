Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9433F8C1
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257663; cv=none; b=ESNGxNzGlCnyFgR9P/pDUJAaDzydIn0AzvFE3i2tJnqZTLdgodu3CBMp9MNAjeQwNLbY0VZNe1K7o2aXYLb3Y97Eyt0vg9d//3d0CKk0iTA07Xe+topI4ThfZWvYmbEiNFKnemZT1PBpA86rm5vRqtAQd3kAgtV7SjEGp7C2dFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257663; c=relaxed/simple;
	bh=wC+BZt6iP1Yr0ISz21R25p09cVbhkxQM9pYB2HqMhxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tzZ5s5FKiEtCyIQLYAa/NJBNtNSyBNK6oqnaH+/65HOnf19MLvI7XchvKnEu4Mupk1bzqFtsm1k7csxmU5Sals+Aa89FoDHWXpeRUIeMJ86nFFPvUA5JjUfEDQ99QkpfSqGRDTdXbtJNfiIr0xClSgTMPlKqLlHftBqPmG65IO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2T8VMo0; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2T8VMo0"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9394ad7f64aso286736185a.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790257661; x=1790862461; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/64GuBUrc83+sAJAX9RpVRuIv37I834lR5L5AyP+l90=;
        b=f2T8VMo0b3WMSrC/TTJuhJXCRL2byZhcrxafYyzTFFoEFEfA5NALL+I1USeNq2ZQub
         FGIxUwi6L/vXqFKhiINi/wqUbVzagiFoOTorcSmeTBjDTKvHX4ICNmD+7w4FaSfFFsWy
         tS05PbdDHJXLv4cBZAi16bf8IsCBJ4rl2D/qX/SUTjtlv2m9yYHYCLC2Ol8FasEiqUOz
         Behzy8aGXXrdEUMPxn5lPjwsYFaLZUmWO3VFzJfMlu26ZJTUAcIDg0waWOE4ARNIjK36
         o/vwv5HgwnBoTE9Sg6wWKS2UaqSQ4OT3s9mRu7bZkYK8p38d3YdmBodOTwgNKv4WX/Rj
         2ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257661; x=1790862461;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/64GuBUrc83+sAJAX9RpVRuIv37I834lR5L5AyP+l90=;
        b=g5YRufh9nkuYs+BhHf2dTFMbr5CNCjWKmlXlUQ5PFlJeV6OpXm0o7Tn9BdpNH1x8ra
         TlvVhAgE6+39tQ5TzciIEiCmseinnRiasHLoJu4YURer66HB9aDNrBc05g9Q9owAoGE1
         TyydQFIYhAVN+Iz876O6a4VxgEwyt4Yza7QxzY+hNqiFcA7Z9Wl7QsfrMzo7LLHpSQmd
         zGE4Bv3iDXC+Osd4Yg8kn777DXQuQ6u2QUnbH9vxgIem1fejayoXkXdOcwMhSQk82K2W
         0SPoXLwe5iOjCMELAG1HQHIqbP3Gqfn/+h1wSZ/DFQy9UyOVqgiAO65OtFqloDtghck0
         +ucw==
X-Forwarded-Encrypted: i=1; AKwUvBxvieKQLCXnYsdFjjo/x5vI+7xHnhnn7A9PwNUiKPFrONCn4ALSoN0ZvlRO81OnRddUZpmoHuM=@vger.kernel.org
X-Gm-Message-State: AFuF++mXX21Fd1rMWl5hwzEu9pNR1gf1jduiO5WzfxFmnowOfklvfjU5
	U1rM9KW/osJKPfh+bmZfkkTmoNnHkGbjEr6PT6EhrWMHJ6hcuYGxndj5sxz2kC+3mO5N22kxLVx
	e6gmS7+l799N2og==
X-Received: from qknwd21.prod.google.com ([2002:a05:620a:7295:b0:93c:3d4e:4460])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4385:b0:939:6de6:9516 with SMTP id af79cd13be357-93c363c7c20mr254341385a.45.1790257660204;
 Thu, 24 Sep 2026 06:47:40 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:47:26 +0000
In-Reply-To: <20260924134729.2047213-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924134729.2047213-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924134729.2047213-7-edumazet@google.com>
Subject: [PATCH v2 net-next 6/9] drbd: use sk_set_nospace()
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
2.56.0.rc1.310.g51773c2048-goog

