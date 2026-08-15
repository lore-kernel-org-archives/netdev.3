Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D135C6B9
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786807058; cv=none; b=r1ncEeKtZmK2h/rOVtUqnPNrwNDdrlkyxCZ1FkQK4EDf6CDcIC1aXlcbibaDux/OfJiEqDKLnbcqO4qmuzweK3l5aq2znQhYvEZViIoaTOi4uOeH7olVNeo7RfGTCYkKouWG8mw6hoIPblcOB8r6LOP5EK0F91g15sP2ODAo71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786807058; c=relaxed/simple;
	bh=Cy7ehUO5QJOp009fJSDqmDrznAwOwERfwSLS7fpTfZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Urm5NTNV9vhh+2xeEewlfDBqxHlbLFbUOEi+V7VNKNzwhb7QtUxIGfZKHcXwR2LBHA/zR20JAXeTXQAPPWmkKLoSxkzo/zTDnq0C8SjlxMay2Ag1Z/Dpi6oNiRct+XtZ7Zo/rdhtDGhlleLYRMFbCK4KcREQAtIS9QFFy6Eblpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7cI/o5n; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7cI/o5n"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso2055806a91.3
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786807056; x=1787411856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TM5YKUrM+Rjhg2FVhoNuNFP8y5+WDuZJ/t6rMuZQeiI=;
        b=Q7cI/o5nZQHmrk7aEse5r2N7L5zIfk/8VQ1JDrs9oaP9a0ysdFKtPn1XELnXSNqyRS
         o+AmlT5hg/tNamQg4PQD0OFvVobaf5emAVX6J6JZpKMmpy8LFslLuSA40HxvcpgQt1gw
         DO5qA9ntfwUma5nK+vn7XemT0qHD57+/BWceh7x1RcVAj6pAMMjUWMnsR9HhEPS18qbN
         0VgW1jEGLr49J6r8toZuNxx1CRo77icovk88ZE3QYr4cCei1Swm2ham7/1ABhm146wj3
         KqgNVtTqhWiKNmtH7YXSKzU6NfCChljjZpuG1gYLsaTmzq7N0oDwFHdtFaMezE05/3v9
         YNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786807056; x=1787411856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TM5YKUrM+Rjhg2FVhoNuNFP8y5+WDuZJ/t6rMuZQeiI=;
        b=IJXDjYO5W7cxFkbnTM5TRiYeLyNs2FW3NFQKB7hde2jEvVmXnlAmcehUsO29TRbsrD
         hTnNaqof3RJXtGhlYpivyTqUUBLV346YWQWqyoZDjoJc6mk3Zu2tOSjlHwfQNkHsExmR
         Feao8kDAE9RNLl6G/LhpE9yVVKJ1Al+yYSJR6mZRSzQfEGCC3q86YW31Rw+GwHrti3Xx
         YSbrUtvOZKV/0lChUEDcvqnp+YluoTEvsGq9OPlBJvTMdD00WCCVYUwTwswTvWvhWqet
         PUusc5DpSsGSE5+H3Z9Uz82bLSlbUA/Hw6fSXNYRd8RjbVP9dFIuz6jB9T/3DWvqImhF
         B3bg==
X-Gm-Message-State: AOJu0Ywkq4YO6uLdLNK1kEoalQmSsdVDyJLoir52YmGJM9AM+o1YbVa6
	BI5huJJtPxaLzjNR/lI0hczc68Q68ka4mt4x8RExxvHTt788hJ3oZtTP
X-Gm-Gg: AR+sD13POoR7jgO0F6BR6PRvxWv/keUvqFDCR4WL1EMYWNd9gM2P5GL4LddTWoLmXCN
	tI9+gmzm0ePr8SrEI0M0RVHhMeTbd/2Er3qHMF1y8Dg+3kA5gRuwYJIIwPB4AMjHY2/96SDuujL
	a+0hn/7gyDZbK3YMjSlICowEy+BIsLC7Bx49Eqq9yLiBpbVmrONodjeGkBN2WMtK+EDmEqj0w16
	IxDVK/qQJQIKJjAKYMPP/r2rDRzl+Omc+ivf9ZJpULH7MwGbIESSyYt2td5msai5ypxkw+QLiB8
	zwuGuPIJlcR9vKyzkwvFGW6x71odkM0j91G2BfOE6usaLlLtl+k+TZvrJGTiwBWm7r1YVvXZaEF
	kj4Lfu6GAVE/DTyEOnrQdJx4hDF/eEmDtO/USQA43WBOz/o1dtyeASMp8ixIhftqPkVBdytZ43m
	PnYRQB3AWIxLciEQjz98y64lJtOksiLAHKF2nJj8i0sPsCU4qn6TjBL9wWjsGhMPYxF6YY1FNjV
	tZOFVGT
X-Received: by 2002:a17:90b:3c44:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-3933bf4ac9amr16342589a91.21.1786807056055;
        Sat, 15 Aug 2026 08:17:36 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:5225:2a2e:8e7c:13a7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebc32b24sm6424695a91.17.2026.08.15.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 08:17:35 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Yi-Hung Wei <yihung.wei@gmail.com>
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: openvswitch: fix nf_connlabels leak in ovs_ct_init
Date: Sat, 15 Aug 2026 23:17:29 +0800
Message-ID: <20260815151729.3757984-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovs_ct_init() acquires a connlabels reference before initializing the
conntrack limit state. If ovs_ct_limit_init() fails, its error is returned
directly. The pernet core does not invoke the exit callback for the
operation whose initialization failed, so ovs_ct_exit() cannot drop the
reference.

This leaves labels_used elevated when Open vSwitch pernet registration
fails for an existing network namespace. Subsequent conntrack entries in
that namespace may allocate label extensions even though Open vSwitch
failed to register.

Drop the connlabels reference before returning a conntrack limit
initialization error. ovs_ct_limit_init() already releases its partial
state, and the original error remains unchanged.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
Cc: stable@vger.kernel.org
Assisted-by: unnamed:gpt-5.5 typestate
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

---
Changes in v2:
- Initialize err unconditionally and use one return path.
- Add the stable Cc and Assisted-by tag.

v1: https://lore.kernel.org/r/20260814134040.1386967-1-ruoyuw560@gmail.com/
---
 net/openvswitch/conntrack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 95697d4e16e64e..38c6f34776c280 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -2001,6 +2001,7 @@ int ovs_ct_init(struct net *net)
 {
 	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
+	int err = 0;
 
 	if (nf_connlabels_get(net, n_bits - 1)) {
 		ovs_net->xt_label = false;
@@ -2010,10 +2011,11 @@ int ovs_ct_init(struct net *net)
 	}
 
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
-	return ovs_ct_limit_init(net, ovs_net);
-#else
-	return 0;
+	err = ovs_ct_limit_init(net, ovs_net);
+	if (err && ovs_net->xt_label)
+		nf_connlabels_put(net);
 #endif
+	return err;
 }
 
 void ovs_ct_exit(struct net *net)
-- 
2.51.0

