Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579631A3AB0
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032119; cv=none; b=QG4KCDZgPISRPibK8Erfn3wm3Z/hmbZ8J9aBWyTtfgQFHdeldabod6spFsSTqSj/+j6DLC8kFi2hbFD6Hib7jwdPl8YyS8cSPzVigpQiy+lTD+Nv3N3Z3FlpnNwZbmnmucL3oztVZDT92aiLOtijjjr8Li0c/A767Fe5RyilKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032119; c=relaxed/simple;
	bh=R0j/qNYveSeY8vyL0/e5npQklgus96CIbETe93stoCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImOjU5fzfZBihCErNH1Zi5OL1hV82bRdzvXpZJC+ehmPBWOyp1jXavoC9Tsrzsv0gT1LYGLTGrDljnOkdZ6EQNe51pmGKf30m5JbfU/b50WdHhx+PKZeAul7jrCLOx+lUtgz44HaHo3eB2Thq4khHADOoLJhowyEQAzUzJim294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeTiiQm0; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeTiiQm0"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca00ea47337so82487a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783032115; x=1783636915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mZhuHYG8y80lULc2rLkcuyGBpLEov+tMve8Tm1aOgdM=;
        b=NeTiiQm0iKSV1DQwy8xf4OrDLdbx8EzBT9m8yftJlaWxK2HQDyrxMrMKfUZC7NpwwB
         rjSyqs2LW7F7JFRk++7pR15GNbj6zWDpFk/V0cHvvoB/88IrCx5Y47NT7t2N5rhTywWg
         I67JUZpkYYCw/+nBqii7xAzXwZohHPFW8AxVdepnEs3Xf2/jnJ7tTJ9cp03MV10rloZJ
         BcWsm8Hr8oXv9zPC8gh05HFabXrhqlTuSk0HVCG8fSQ40q2L2mICn61X4It7gNwWFAAb
         y9r6F6MaXWPcG/vSVXY8j/KZSuhRzTxRSXvqJSrmHYbc1FJ1XjU2kKOFw+5dQbsjgN8/
         lN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032115; x=1783636915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mZhuHYG8y80lULc2rLkcuyGBpLEov+tMve8Tm1aOgdM=;
        b=CEHJRw53Ippc6HAnH3NJ1DO9yFHTfJkLq07d4t9UaVqbZszqSmC+C7ndM3+nFda2ZS
         kaMnUMmR0cbfbOejSy0YuUp+VcYGVc/c0U9NvkuUFSmg+K6B/FJpRle0lU7F8ldcHbWT
         Lh2vMCdfpMX6hMxOjUwcc3wXaqgVK4bzddTv7WdugjNcF01Lz+VYHDiLBzWx0AJYpWvc
         h4/mC2svzl47rCWHmXKQgj/D7e/Yn8iwZs4TYX5K2q/FKu+z/dF5vEW1dqjXD5EJF3Wq
         V/4YD2k69WlZD4detdBl/3zIRoOVXe8tVzFKPWe07JyKUfxECL1JP1BN22rHIQ9igxOa
         EYKw==
X-Gm-Message-State: AOJu0YykeZHw1x93bLvOGkJg0NLzvNnYmmuyM10DIMo8cJFOwB6N9brR
	yUVP8ZdIvEpLTcNL5qfAzc+/xEuT7UVj+lI4YVYBy5IplPwNIjEqwhkvMHcpRiVx
X-Gm-Gg: AfdE7clqv1IE04nmrcwknhK4JmkwnxwlUJaSno/mpJC4mqIuqrOCH/sCDjw3+paU8Fp
	7qbD+bzrZaa80X9lT/l4oDuXULVsQGELs+glq448mE4Qt1I7YXpwS7nPaMTPLE8YiipzOa5pivh
	XErUCuCDXSPmSrpCtKSoHyQbgG67yFI6msRW8iuF5UiaD8dqQ/HNRTjikFremYQfZ6BhcgzgXDW
	DPxTTrLkqMbdAZVQOw7HhHwVjU5KyXTFU2HE65NJwFXcvXtfocyZCqKStoyT1XQkSVbXElbZnxA
	o5B2aZbZqG/EfWsbZ62byBRnHMAOjd6hJ3RPPvXhakGgCAYGoOgvtmrAxs1umu4rXcV6EMOYiB5
	dXxc+lA6j89OHatDFg+CKLvgrAH72Zi3LT8BazvbDEJl9hIjuRWg9jmr2+sqauAAVk/7xAVWdbg
	fHgQ0Yf6cUBQk9HURN
X-Received: by 2002:a05:6a00:3902:b0:845:d285:3b6e with SMTP id d2e1a72fcca58-847c5208e29mr6591848b3a.58.1783032115126;
        Thu, 02 Jul 2026 15:41:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f1ddd7fsm1823013a12.8.2026.07.02.15.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:41:54 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 4/6] net: rtnetlink: take instance lock inside rtnl_configure_link
Date: Thu,  2 Jul 2026 15:41:48 -0700
Message-ID: <20260702224150.3730033-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702224150.3730033-1-sdf@fomichev.me>
References: <20260702224150.3730033-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_configure_link calls __dev_change_flags() and __dev_notify_flags,
both need the instance lock. rtnl_newlink_create grabs it but stacked
devices do not. Move the lock inside rtnl_configure_link.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/rtnetlink.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 12aa3aa1688b..1b7d6f6b8b68 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3660,14 +3660,16 @@ int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 			u32 portid, const struct nlmsghdr *nlh)
 {
 	unsigned int old_flags, changed;
-	int err;
+	int err = 0;
+
+	netdev_lock_ops(dev);
 
 	old_flags = dev->flags;
 	if (ifm && (ifm->ifi_flags || ifm->ifi_change)) {
 		err = __dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
 					 NULL);
 		if (err < 0)
-			return err;
+			goto out;
 	}
 
 	changed = old_flags ^ dev->flags;
@@ -3677,7 +3679,10 @@ int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 	}
 
 	__dev_notify_flags(dev, old_flags, changed, portid, nlh);
-	return 0;
+
+out:
+	netdev_unlock_ops(dev);
+	return err;
 }
 EXPORT_SYMBOL(rtnl_configure_link);
 
@@ -3918,22 +3923,20 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		goto out;
 	}
 
-	netdev_lock_ops(dev);
-
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
 	if (tb[IFLA_MASTER]) {
+		netdev_lock_ops(dev);
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
+		netdev_unlock_ops(dev);
 		if (err)
 			goto out_unregister;
 	}
 
-	netdev_unlock_ops(dev);
 out:
 	return err;
 out_unregister:
-	netdev_unlock_ops(dev);
 	if (ops->newlink) {
 		LIST_HEAD(list_kill);
 
-- 
2.53.0-Meta

