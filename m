Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4E33A9F5
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216623; cv=none; b=Rf5VtBjqsRv1kGK2dcMBg29VjG99aQFqUKlztjTRxcGFEN24GK7nDwtdTHnVGrJ7nHU7IuYDBq6IIewa7/C+ZIw68GYB0CEAgWxIkCyEeJfk6nZT64tkLYtL5zz02aSadnIX506uqen4Lms/IDBsYevIz8t3pmRqOoutio8zzIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216623; c=relaxed/simple;
	bh=rH75EzXICa0XdEgVwHY4Yfy9qWAaivBxfj522dz1C6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SnwYl9V0VllVNa0Da9nByhXw6jb1AA5dJWwsLK2P2o2/EGvB1VOuZjOblIEfCWAFi4mO+4mKj+yMNU+t/QIHbNt9ddxGyOaE9KlEbP0DSJ9ihfEA14rd9Rn4VUHUwzMYnx5+IKaHNJil5ZNLmFIMx1PVz8EeISKFyns98elFCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx0g773o; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx0g773o"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1614804757so714385966b.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784216620; x=1784821420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zBypqS7GnltF0qflde2eBCHFe4sgdKQRHHH8Z6tCV90=;
        b=Qx0g773oFC9yHmm0fB4xBDoVtAGZmJbBHJTgVyo0ju7t8AsVJ45zSImShPZpH4GlTl
         8ckZWmjde9Rj913GfB3aj+0RmpKDiTA3idKum3GFnkY2xTCiw/3ZGivzoJVBwuyY+yV/
         Wnh9VPDD9r+Ub3P8/xaOfq0vhEr2dW8YDTYZqK62llV2xVVA9kV8jONrFeuBL4G/oXAC
         NMG/EiK51bDrZIq8SPVnS9Zg5fxSGe0AclL74UIT6Pko1rjRkHFBUkBwfkNQGfJuphat
         KNrNwlMdOEZ0beLEn6f5NBjcG5WdAmavabCroOdU4p2HF/m+UzNyWLXwW5UJCONAf3BQ
         Sarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784216620; x=1784821420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zBypqS7GnltF0qflde2eBCHFe4sgdKQRHHH8Z6tCV90=;
        b=dwWt2oxFu+PSwNX1D+4x21JLVPMOcIYbsNXTHriwm8E79x5HHb2P4wIow/kQ4u+9N8
         /ePnkZDO4hAF4LlApnf7AbuEtHSl1zkLAoafPNKm5fTHE9wC89ZUpIedQHGglVf6LhJ9
         tWn1/QjydWX08EG1CAS06v9oF/OwCImyVcwzPWTM7IgT1tuy89uLhFTeCK1D+84bot82
         kbHc3ZB6RctuG/+XjxGlsBAJ4MXhnL5d56lVYQgbWiHHwG8lpa8tc5nIBRDPklb2jpOK
         xnVx747Yyx6m5/KwOpbOMnmhVmB9yMfRwY8nsNneMQ3v/I3KtP5a1G8/LWw8+Hm25Sab
         1QBw==
X-Forwarded-Encrypted: i=1; AHgh+RqesobcXjKDMp2dX/b0TM1muIMl0QAqsdLnnbKfZKdgqAoygtDLP7Y9pxCObJ30BBpyACmgyr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEcU/SyTckKuX56JuqUAiz5x+ADR0lbFFophgFZZQY8ZZCpFCv
	5UawGSsXA/p7EeC1R9r3Cy8bIIiKRDv5yxNVEkn70pyEZASQwAYYFbBh
X-Gm-Gg: AfdE7cmcyzdhHCJiRCzo0fIetVmlFzz0wcxbgqt7BceVq49C31sluyTHFApU66eihAc
	CAQtILYX3iWBj5gtDw0Tw/RiHIGG3q0UvqbjU2+kJoiJpm08RV0L9CR7Oz/B2RKhABEDb8WGKhD
	Z7rbYYpRG/Z6vt/YN5aprnKzKf4BZLo2TOVstoGWfVrRWDOaUbU27GTpfqmWXa8perBy6BteHiR
	HqDr6vYh1nI40WEKpJ0F8+h3ProPLrspFc2MWi98WcRtmQdVWMO/ha8qm9QWQ8J4EC4UXM+wKLD
	HM2qzmAgSfDhCLELpZdWTN23wk8+TOVclLu8YP5U9wcvZ3TH9zTwiK+ufpbseSFaNV+DkZjXEZY
	3a6txH4uMZ9TDHWGSnQzBZlqfNPpymgs0KZBxCygJF0bNKQYO5LtIeUZ5/1h1w/TIfJSRuw==
X-Received: by 2002:a17:907:3e12:b0:c12:8664:6aec with SMTP id a640c23a62f3a-c1679364167mr456134966b.53.1784216619477;
        Thu, 16 Jul 2026 08:43:39 -0700 (PDT)
Received: from beelink.. ([164.5.253.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168a1083c7sm195166566b.30.2026.07.16.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 08:43:38 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH net] net: qrtr: restrict socket creation to the initial network namespace
Date: Thu, 16 Jul 2026 12:43:19 -0300
Message-ID: <20260716154319.3297699-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QRTR keeps its entire port and node state in module-global variables
that are not partitioned per network namespace: qrtr_local_nid is a
single global node id (always 1) and qrtr_ports is a single global
xarray. qrtr_port_lookup() and qrtr_local_enqueue() operate on that
global state with no network-namespace check, and qrtr_create() places
no restriction on the namespace a socket is created in.

As a result an unprivileged process that creates an AF_QIPCRTR socket
in a separate network namespace, e.g. via
unshare(CLONE_NEWUSER | CLONE_NEWNET), can send QRTR datagrams -
including control-plane messages such as QRTR_TYPE_NEW_SERVER - to QRTR
sockets owned by another namespace, and vice versa. The receiving
socket sees such a message as coming from node id 1, indistinguishable
from a legitimate local client, breaking the isolation that network
namespaces are expected to provide.

QRTR is a transport to global hardware endpoints (the modem and other
remote processors) and has no per-namespace semantics; its in-kernel
name service already creates its socket in init_net only. Confine the
socket family to the initial network namespace, as other
non-namespace-aware socket families do (see llc_ui_create() and the
ieee802154 socket code).

Fixes: bdabad3e363d ("net: Add Qualcomm IPC router")
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/qrtr/af_qrtr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index d02ef9a74c3c..a30fa56e6aa3 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1263,6 +1263,14 @@ static int qrtr_create(struct net *net, struct socket *sock,
 	if (sock->type != SOCK_DGRAM)
 		return -EPROTOTYPE;
 
+	/* QRTR keeps its port and node state in module-global variables that
+	 * are not partitioned per network namespace, and the in-kernel name
+	 * service only operates in init_net. Confine the family to init_net so
+	 * a socket in another namespace cannot reach the global control plane.
+	 */
+	if (!net_eq(net, &init_net))
+		return -EAFNOSUPPORT;
+
 	sk = sk_alloc(net, AF_QIPCRTR, GFP_KERNEL, &qrtr_proto, kern);
 	if (!sk)
 		return -ENOMEM;
-- 
2.43.0

