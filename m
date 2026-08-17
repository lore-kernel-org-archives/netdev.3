Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5316042903B
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972382; cv=none; b=BJisynkgg3N9vV+YacT6UyGOPeXs6sddpGMoKqU/UY72c6Hoizy+3Zs071nfLQuHbG4Srx8isRPA93RIIi3gEGh84+qY5mYnrRr32a5a0gvkbD7avvjwenjBX47c8PH0v/rEulEWwUGOQxQGMJtxuZWZsKIrBd0bCkXlI0nT6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972382; c=relaxed/simple;
	bh=4QruugZiDYbn9n5UGyi2+FT6/ZrMmd+8+jAf5GVJ40w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBjvx+Xqoy90XmN207UjDClSfCdHmE+i7QiHxIfkDPhbUXlSJZ6KQgBr+zY0hevOI9GUKb48tLGJxndOBlB4gzkoi3vCNrTD0LaicU6vdRa66rxbow3OdTOSr9oDOkSbWLS/VPdQhwVI3B8SDrJn/6mAGw0bF0/1NpJrUsm9OEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=d5HhxuZM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="d5HhxuZM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848643382fcso3456077b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786972381; x=1787577181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ata04BjbhgcCIeKGSAUINAv3LxYkBqq+xOXTmgSke4U=;
        b=d5HhxuZMGGzl2Qsg+ObR+FLw56RVRMVzUCa8Mhq+uEASyXueNbWy66l1zOoElAhRR+
         4GoOC0GlQ+YtyeQnsAn8FwebBgK8fZt/57csFZpt36I0rpPHJ3auMOclG3gQlpcMij2A
         2DWOXCb1o3xagWro3iyI0VDSQrqQd5lcAfEuU/7xBVs9ZpNWoL6Np1L/LZPKtsnqlKZE
         yXRKKDmiAWIUHLTkXdT9Mq7sj3u2CHYdDHs8DNN/VRUQnMeAD7Lz02RHX0iDOTOqNRz0
         gsp6SVQLV/rWVaeiQwe0qcD6+GAWIwMaUgxPNNmET0FzMH6WJPy0+VgQ8EFiiLDdX/sQ
         rc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786972381; x=1787577181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ata04BjbhgcCIeKGSAUINAv3LxYkBqq+xOXTmgSke4U=;
        b=EtrGwc91R2KpOWON6rOJyKrxLRq85hYLP7hSsl55umn2MAQzT4NVgEWzqMHuqV7pKY
         FlrV9FNrjBL9wiIIMAzD8NNaGLgiSV0Usuz6Cua3e1ziZWZbbOtLasFqPSn1w58Zb0Qe
         +unWD4xcd649RmH0jzxfRFKbbIzDB1fz+IJF+FVl7WTux9J9peCMu9o8jPQ8mluazhki
         OwqTOu3okxP3fD0tmT4AQKR6X8uR9fjwtpK2mZMCbagYsSSyydJc2meDGkiqvnILBnZr
         xvLOpKo7jbSeJ5TS1Np5CDy8GFkhMR6Ctn5/vaWTO0vqK39JAFnR/4Q5V+NCm54MQu0g
         NxMw==
X-Gm-Message-State: AOJu0YzNxFnvnmNh2ENlsPNbBfVFJ8dwogHugWpjl8vDVmaFOvgl88uS
	Hgp7ls+AW9XkslSfFIfQQ9X5Q6hniTdSl8idsy/dhj7v6V+sO+6A7gGZaJ4oR0z+AWx0jaPCkGa
	NxsYC47OBN7g=
X-Gm-Gg: AR+sD10P3g7zFzUA4k6Obfhuk1zIH17u3xiYfEgy+gMV4ryWUYvk1VxUt8jisn3ww2N
	X2WtIsy8KzSEp5ZmHjM+6r2B+MvYURqDRJwfYwKtZHT6pJAw6au1wgrvKQJ2Ny/m3ojoDcgfQh8
	aPD7ayZo1malTAMyWc5dFgzT/EIuwGW0ALnpIFMdUto8J1JLL7O21sWzCQCdZFiGFxy3irc0n3p
	CWNAmaF+KMHiqjSEMMYsqs9qYThkRosc7oK0kxYJm47Uasi+rWbH/SaSRbgrbuWaswfZenQ2L46
	1n9UX9CTv73K73wuwBkIzup9FpMSZQjxozXACGgIxW4ciwhFmQrIO64KdLR+3CaxkgseWVaTrTJ
	Q9/N6U9rtSRN2vf72HJZAhiYVL+bxy2dE4Czv+RtvQ8itkuuyk4honQE7Ow79s2ziZukb0XfnA3
	pyeHUo2jW3wF7ODyNugZJPuvpEHCDP9qnrsf0i0SKh/g9bnHFybIPRyA==
X-Received: by 2002:a05:6a00:44cd:b0:847:8f8a:a05d with SMTP id d2e1a72fcca58-851b8906afcmr584528b3a.29.1786972380530;
        Mon, 17 Aug 2026 06:13:00 -0700 (PDT)
Received: from gmail.com ([115.196.71.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fefb3asm261312b3a.53.2026.08.17.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:13:00 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	davem@davemloft.net,
	pch@ordbogen.com,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 1/1] ipv4: Fix fib_rebalance() divide-by-zero race
Date: Mon, 17 Aug 2026 13:12:10 +0000
Message-ID: <2080e22819c552b0d186563eda255a44c68404f7.1786812660.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786812660.git.zihanx@nebusec.ai>
References: <cover.1786812660.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_rebalance() reads ignore_routes_with_linkdown while summing active
nexthop weights and then reads it again while calculating each upper
bound. Sysctl writes are not serialized by RTNL. If all nexthops are
link-down, a concurrent 1-to-0 change can leave total at zero and make
the second pass divide by zero.

Route insertion and link-state updates call fib_rebalance() under RTNL,
and netlink devconf changes are already protected by RTNL. Make the
sysctl handler take the per-net RTNL lock before changing
ignore_routes_with_linkdown. This gives both passes a stable policy view
without adding work to route lookup or rebalance paths.

Fixes: 0e884c78ee19 ("ipv4: L3 hash-based multipath")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv4/devinet.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a35b72662..71d961013 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2604,6 +2604,23 @@ static int devinet_conf_proc(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int devinet_conf_proc_rtnl(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net = ctl->extra2;
+	int ret;
+
+	if (write && !rtnl_net_trylock(net))
+		return restart_syscall();
+
+	ret = devinet_conf_proc(ctl, write, buffer, lenp, ppos);
+
+	if (write)
+		rtnl_net_unlock(net);
+
+	return ret;
+}
+
 static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -2709,8 +2726,9 @@ static struct devinet_sysctl_table {
 					"igmpv2_unsolicited_report_interval"),
 		DEVINET_SYSCTL_RW_ENTRY(IGMPV3_UNSOLICITED_REPORT_INTERVAL,
 					"igmpv3_unsolicited_report_interval"),
-		DEVINET_SYSCTL_RW_ENTRY(IGNORE_ROUTES_WITH_LINKDOWN,
-					"ignore_routes_with_linkdown"),
+		DEVINET_SYSCTL_COMPLEX_ENTRY(IGNORE_ROUTES_WITH_LINKDOWN,
+					     "ignore_routes_with_linkdown",
+					     devinet_conf_proc_rtnl),
 		DEVINET_SYSCTL_RW_ENTRY(DROP_GRATUITOUS_ARP,
 					"drop_gratuitous_arp"),
 		DEVINET_SYSCTL_RW_ENTRY(NOXFRM, "disable_xfrm"),
-- 
2.43.0

