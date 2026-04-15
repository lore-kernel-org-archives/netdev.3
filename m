Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86738B13E
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258339; cv=none; b=I+YLUmf2NSe5EwexxqZuffaQNjxreIHe9hdzPGV4A5jPOOyCgXZImqGSj2sEnLeuhNBw6H8Y1dsKohkqOA3JgktwJmS0BdIM/xuVTdXd4ggJmye5OY4c/A5or0b7b9PQqLOuG5FyHeuOUVIDWw17uXmJj/oqhWhcu/a9Ggo64ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258339; c=relaxed/simple;
	bh=2Hs9DNOzuNNqlTQoBag0X062U/H9SGvW0rnDyXV4rTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o9Mxz8joZiG1ryy4/FrfpcfXmTccHk0OnW0FkbEfmvP+svVgdQVB0YKIgdH6cbBRDNOI6Dk88H4KoRHO306NMemPO35B7jN++/JeRnf+wiksJ4v5318OiTfmMK1ABEMFoObqOmT7CDXOTJVNqK/iBjrAlt9qX8baHD9np50JiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wR9JNbk9; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wR9JNbk9"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43ea8161c3aso1877718f8f.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776258336; x=1776863136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdle0JKZzTwFQP890ZPhVWQx6m7HCYXGW3VKR/X9KOM=;
        b=wR9JNbk9kDTHK14yzCGNkKmD1W/dnTMvjTNeoStTKPNA2C4mMvHLrUpZIhaLcZiX8/
         b5+COLaflf1CPQU/KkOKF92eKOy9ufNUqBi/1T98492Q2UbYNihe+qJi8VCo2MyR1dx4
         67hYdNvJ0KdFTPLeySmA0GTojwVVDqNQ/wBw/CdgGiCZzEfZgqAHMrt9N59PClvJzqHg
         Jc19SfEyNmd6MRFK5/QNOkW+7YsuYaCyshCnLuabdN7TUaRhD45oTJ39vY/Xl1RFBGwN
         rdQmlzgJ/NmVMMYltLuCHHxezwAk/c7lwms+jEGSCavU0o8xiSEsHCL97ygn55thPxRK
         x6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258336; x=1776863136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdle0JKZzTwFQP890ZPhVWQx6m7HCYXGW3VKR/X9KOM=;
        b=YSxbik5xVUl2mIIwXd8qyPl5qyyZegi2tP+Iz9AZs8FAsac6mMjF7j4c2nCUo7e2F7
         s0Ho94lUnPANd81D69FyRApkBp3tM9pYI46tDdrVZ7Ffm1kHu5ryVG+QTh46+fYB2Aiw
         PBmxiR0jcmHk6SAMgbT+0NomyfbVq87SA/ceiz36btGewF9kLkJgVLuyDueLKcIQPLuI
         rKOecWVBbb5JrnPqpvYhC3AskoSa+lvPc26LvD5Tu0vm2NGlym+ZNUHkKK0isXcMEKoD
         FpXn/y0VODY3axYzEJ1ZXoLGyvQVSGYJ9y4i9Nkard+Sd5bpA6XVhxMU4VwjhI8KG/7j
         kyVg==
X-Gm-Message-State: AOJu0YwzIaZrQtj2B77NUdkFj8OfvlcdJF7w4vUdfHgIHR8suudFJjjb
	54QCL1x5DSMnkJFhuOsoaBFZ2LKYBBUrLBKjRBsoKKLq8tNJC2b2uwKCnKkW4j5toCHvV9Tc1pI
	aqCwjmA==
X-Received: from wmbjp7.prod.google.com ([2002:a05:600c:5587:b0:483:509d:729b])
 (user=nogikh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a408:b0:488:9324:3ab8
 with SMTP id 5b1f17b1804b1-488d6839838mr233186635e9.18.1776258336271; Wed, 15
 Apr 2026 06:05:36 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:05:33 +0200
In-Reply-To: <69dd48c2.a00a0220.468cb.004e.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <69dd48c2.a00a0220.468cb.004e.GAE@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260415130533.849053-1-nogikh@google.com>
Subject: Re: [syzbot ci] Re: veth: add Byte Queue Limits (BQL) support
From: Aleksandr Nogikh <nogikh@google.com>
To: syzbot+cib904ea9ebb647254@syzkaller.appspotmail.com, hawk@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, syzbot@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

... okay, one more fixed bug, one more try.


#syz test

---
  drivers/net/veth.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 911e7e36e166..9d7b085c9548 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1138,7 +1138,9 @@ static void veth_napi_del_range(struct net_device
*dev, int start, int end)
         */
        peer = rtnl_dereference(priv->peer);
        if (peer) {
-               for (i = start; i < end; i++)
+               int peer_end = min(end, (int)peer->real_num_tx_queues);
+
+               for (i = start; i < peer_end; i++)
                        netdev_tx_reset_queue(netdev_get_tx_queue(peer, i));
        }

