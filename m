Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B3468C25
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516378; cv=none; b=aO2M84XJ6Ywrjn7aXOWb2d74ZV5Tx/rOfvmn/OxCkilxoLULe6nkNe8QyEJIEAvydFodlFocpylj0nAlgeEjUA91xcY9nNdp6uDW0hN8SaFDcenMnqFEzv026q8Igv+iTDyFyX1rmfKQ+weC2fjVrueRteJKj3fRWizbAse7cTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516378; c=relaxed/simple;
	bh=23j6/Kdn4Fky5LWOBfVuEtb/XpL7yJRde7gU8wJcBqA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u0+0TixmhQxFC14ui+8eWuIviLHRgHiPQdaE5gEdm3HZrh6RQUQy4+Wcd1iTXr5CPfDPC8CcjJXB79f9UZcqH2AV2ZN7K8pLxionhIZmcj4iof6OejehUCqgBNFxq2HXxOny6WJJSWBqDvJZw0MXMzH2FWPGAVTwjjAxBZ0gYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LasaUPbA; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LasaUPbA"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso2825536b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785516376; x=1786121176; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2dWR5u6X43A2VripdgjlkdNnkBXaoNaZZnB7Sf6Qf58=;
        b=LasaUPbA9u1cOSlBjj8GjEGHrAQbPsBtbHrDpFFC8ccJknHQiTQ7Tquwbm6qwE/N5A
         x35+L9LILGXTyhLhltSWi3qDD8jolXV4cBFaUmAMU4l9Mn3qSU5E2eahP3Ad1QRHyAIF
         5ouovCN48bjPT5/bH44jcaAxNRC4dbuI+MGR+jcl9cC/CJ71SMfIkthZpUubw1hwXmvz
         u06rgHAAsk0BTORDf3zDYkE/t4Cus04OB9w4soAWbrCVMzhdIwzLoJMabviYbNfSGgEQ
         RPcpoJpqq5D3tipjie51Bj9hXEzQlKe2uXmZDUUrUtYJhyocrvYUfkHbSlBKrAd4d8vh
         1SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516376; x=1786121176;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2dWR5u6X43A2VripdgjlkdNnkBXaoNaZZnB7Sf6Qf58=;
        b=sjV5KyB1D6ikSloD+UaI6FLNX0wpw+R2wNVQ4CiVeu2uM3Z/gAY3PP9Cl6GsCzYzds
         7Qvu+3keqMYoKRZ56guaP4ntPFU7wfdy8lSxWo96bxWpdTB5rvYtW4PrWR8VV6PZGeGH
         vHS/r1A2andqDeYTM/0wkas2CqojG8/uAVL2O0pDgglj7JlMHG/l72VYSV1XGx6mRh/h
         u9f7Q+EwIeDIDgue94mEsaqwQDVHfb2plHgeu2l++nw+9z5Zmp5Eiz18yqAwCiMhz68o
         7oRPJ6CQp3BoCOtE4JlMyGLQNzyQxfVWCadoUcCVcFRZCVHTlJiHSLkmC2/HamP46/9H
         u8lQ==
X-Forwarded-Encrypted: i=1; AHgh+RrII1xhc6ZZtkA7e4p/TJHMaHZVvNeueVs17TwpZ1s/etTASQBayeaQ/II40PO3fAXQQlpE6tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnXPP+npP+yPwSKCWjRHJyFhD5BYmRdRuMzp991mEQrmBBjDV
	jedNMKj4+F8PnwIajpsCGAl84P6U+QKpnJAtSgWlPcD1f1+o/6O9X83hQty2ljqoSqt/xIWI9TW
	GHGW5dQ==
X-Received: from pgah18.prod.google.com ([2002:a05:6a02:4e92:b0:cbb:8616:5536])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cf86:b0:3c4:3672:b86
 with SMTP id adf61e73a8af0-3c92ac44794mr333543637.3.1785516376197; Fri, 31
 Jul 2026 09:46:16 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:45:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731164612.2148830-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/3] geneve: Support per-netns device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 is a prep patch to make patch 2 clean, which
adds a per-netns mutex for geneve linked lists.

Patch 3 supports per-netns netdev unreg by using
unregister_netdevice_queue_net().


Kuniyuki Iwashima (3):
  geneve: Unlink geneve->sock[46].hlist[46].hlist in
    __geneve_sock_release().
  geneve: Protect geneve_net and geneve_sock with per-netns mutex.
  geneve: Support per-netns netdev unregistration.

 drivers/net/geneve.c | 126 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 95 insertions(+), 31 deletions(-)

-- 
2.55.0.571.g244d577d93-goog

