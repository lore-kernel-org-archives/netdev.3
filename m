Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE236F8E1
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 04:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916688; cv=none; b=azGwHu1Lxv9kvEgWcim0wH9NGIcu7Lsce2PUH0STf1lukjKhMIf3yoklsEr32e4kw7XqKsf5ynYi3fyZpfSEnILUtzXzBEpHlHzg/9RhuQ6UmGn7QmOyVZtVIA5FB3w8Jy08CTvBRDBlrh6FQnNfdmwAnX46SmCPzmAg/uqoRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916688; c=relaxed/simple;
	bh=NWTciQTPQGFxRl8e5NBASdT1gbmDf6XBJprffVSqZLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6xZ+UURZfJ9QDc9X/IvMOFaV8o9uc8IBNZuNJ3qmx46rVZADKeM7QTYF56raI0uYjcGym9iJgv7wx4XLcYljaty1TaCowm+tnDgFc30hFoaZcmPuWnqFRtwFgBpRFmn2thpGUKpBUFixJUOOG730KSrB9uESPYiMl52LpvTXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2xrXilc; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2xrXilc"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e69so2602399a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 21:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790916686; x=1791521486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=acJBQIXpi9PcvXHZyXDn71ZRsavqRs7vpb0bJgNaqtw=;
        b=m2xrXilcb3k4jn60JkCRh7MCGKDcBSnva/PljWY32PouUGp6DHQne0z9iVbDw0XXuK
         lLCgl0L0pTgoS9ZD2MVMrH9fir8FKjAXTEv6OP+YZLrGbE3d7kHdk5CVSIxTw3E272xE
         YZmYypBMbu8sTKCaPin9Rau/Cty+nydFIg4+BVU5we5UKDjibn0vHjKjrnjGF2tTihgP
         xXhewDyDTYQeX40vLqwDLyx5MU/WGBH1tWTX0P0h45KyBOcHdNmjfDkaBR+Iw7ZAt9+R
         3KVYilAmLlas6HFrhPf4murGq5vH2ZWtxgL29GRuDHcVDOR9gx4OgDX9gPUMn3pCzaD+
         tgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790916686; x=1791521486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=acJBQIXpi9PcvXHZyXDn71ZRsavqRs7vpb0bJgNaqtw=;
        b=R4cKrQX3+6AqwNIMWP+pxblM8dzIeZaYoMEKtfJ8G69wsxfMyPkaseTE7+9Cg2RYwi
         YUJyZas0QUJKJt57Gu5g3u2Qh0eOUk5/QwAV9Ye3Tho0G36frtUsSkjdvtp8ffu0BGji
         SmjvWRj7PfoKBLNZs7lkVKku1YuMZAueliEBY1ZShpU/GK2r2Br3FivLjPD2s/vZcpm/
         i+HHT/KmX40mOUC9W7o9cC3qnZ0j3F0UICsrXH0xZVm2yrO/S6MUkyS2MC844aWMWDw5
         +3I4TgozTZSs/P5SqWTBTdXlBUqhHivafskF/R99uzabMpRr2HqwNNAaaAJ6EIFDRLrt
         HK7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwtgWtHW3LsrksK8ZuGObfEHEteh32OQfrmq73+Dwz1C/uSmpyW70GIfHYjjmXqo4D/lr/6Rz4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqoOxwL+4hagvP+6EqJh8KXhokaULrXjKP23exo1PbYOWwOOb5
	Xd45J0a92jdRPCNJfTvySKED4JPWDdVc7oBayL6t5Yq9/FUYKrH1yMKl
X-Gm-Gg: AYBFou2CcIdc2HPIgOODI6Bjdt4gWc11Op9CMXmK3h2mrXgfOhuSZY8cAOfxYpNs9Kv
	3EQnr8Adyqzf8oZ2Qt5VvENkz+hc1CsCjswg32ysggBWFrni4Zvt5kEIttxxdxh1Dq4eojQ23sp
	45kocZ10PVB3Kxeo0y66Z7rH9pleMX4Gmmbbl1O3IqvaFXnsKfTzStipbMGGdhf5iqBUOBMGWBt
	tg1ctlqCU0zv05rr31fjjbALFAuNa67slk11sQnyNL0RwVMJixUUvJ7oQhheNBRtO8/IosMma7g
	DiUqyp4ScbVNZlqywY33Hh200o1SnfQvHeq913Xr6Cxz5w4Q3151QgErDRYbWsdC7h6lakpNuni
	4yNuStmCwFWXNzRXoP/WCninIZwyaveAeoaXqGqbf1ExNp2Fwu3OCrVpJ0t6PQrcCjMpP3gex6O
	LqONiUzs0syXTu9mhcNJPFKWUFhCRILPK0kwsf4rWZm9r8HjznZOY7p8aV9RSO1JSiHKZo5Y78V
	SjENBezDgk=
X-Received: by 2002:a17:90b:56c7:b0:3a4:c895:562 with SMTP id 98e67ed59e1d1-3a6cec1fdc7mr1563842a91.62.1790916685941;
        Thu, 01 Oct 2026 21:51:25 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd3962f0sm642682a91.3.2026.10.01.21.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:51:25 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Donald Hunter <donald.hunter@gmail.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v2 3/3] ipv4: stop route notification sizing when nexthop group shrinks
Date: Fri,  2 Oct 2026 13:51:00 +0900
Message-ID: <1054fa46165bba1b473782fa41367804aa908e86.1790915964.git.4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790915964.git.4ncienth@gmail.com>
References: <cover.1790915964.git.4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 680aea08e78c ("net: ipv4: Emit notification when fib
hardware flags are changed") added an RCU-only fib_nlmsg_size() call
for asynchronous hardware flag notifications.

fib_nlmsg_size() checks fib_info_num_path() before each iteration,
then fib_info_nhc() independently reloads nh->nh_grp. If
RTM_NEWNEXTHOP replaces a group with fewer paths between those loads,
fib_info_nhc() returns NULL and fib_nexthop_nlmsg_size() dereferences
it.

Stop sizing when the indexed path is absent. Nexthop groups are
dense, so the current snapshot has no later path.

Fixes: 680aea08e78c ("net: ipv4: Emit notification when fib hardware flags are changed")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv4/fib_semantics.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 5c9021ea3a799..47469b7758082 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -542,6 +542,9 @@ size_t fib_nlmsg_size(struct fib_info *fi)
 			struct fib_nh_common *nhc = fib_info_nhc(fi, i);
 			size_t nhsize;
 
+			if (!nhc)
+				break;
+
 			nhsize = fib_nexthop_nlmsg_size(nhc, nhs != 1);
 
 			if (nhs != 1)
-- 
2.55.0

