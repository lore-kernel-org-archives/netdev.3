Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93D46EC69
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143166; cv=none; b=RYl8AxdYNz5K3lozF3zTCBQGt3WkDYWpYjgWvF4Ou98NiOKPDN2MvK6KM/aJYhOL0IOvLSPHO70lq3bRMtCyWqBOHiqKJA10QIbI1p4n3z3SG9F58wHSuoXmGi3E/qLpvb9b4Qs5giNzCGpkOmx0+/ofuSB/gaV8k2vUNowcX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143166; c=relaxed/simple;
	bh=Z9Mwbxdb/e66pqI6wraTgavodNtN8iMAFiUVb6k+BFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNQ+WcRmmUIKxQe/3cELpdk2rJNXqRroo8QpWYSFHJYtpj1jX4GmUppeiucDEGmkcUg9036LdtgtOp/JCA1LAckz0bZrrNQ479GL54p0mu/RRoB0vnPAdrikdLiTJSGJ0hcemr/G3heK31wFaozc5ONpQo6S++v3rLEes2hm49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHERSdA9; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHERSdA9"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2288507eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792143165; x=1792747965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHmkv6BikJoFrn087jxAAKsWlqagsvtugyCffrxtj2U=;
        b=bHERSdA9g4cxrnlEyUlZpv50EfUtdP2CgtywULH7Y86PJg1PkvgbAYKt/r5Akzd5tF
         xJ0u0rCEoKruYyh4Gjg84HFbYdmPD8VJ02AMCONA/B3DLbI3NrhXC5A2Bx/EKvVEi/ZC
         v08zwYv1oGveh7VXBAsSl7fBQroVMwetkP1LCx9RfI/r9AMxC0/g7qpIbKp2tSFLeghq
         tnLm0YTh+06dsOt+Nuru3F22cxusAGVZUqVV5xxX68n5CGpTnKpCIA173KoDijwo4SWr
         k/A8wq8PGZFlKwLzifwbCWX2FmyWDeKUwsCQNvd5MOaVuXFOGm7ufaJEUettfoYRGz4D
         watw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143165; x=1792747965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XHmkv6BikJoFrn087jxAAKsWlqagsvtugyCffrxtj2U=;
        b=J2M2C0z7dSzjwKuLD/1wiWDA0+U1ICjkXv/cx+8xUBkBXPW8OKLUr5Ndv0XYQFEJAZ
         1F4aA23nwcPJle92/1inoJudUL9ri5gBX9hQHlC3Mjv/OZD0tf6CSbp4DTeJ1ZcohEHk
         ZYC0BUOyoJO0l3Jns6D3/ZFDQ5gahpzchD7UDTVgnbttHQf7j7YtH7PFGYmui2XAAHbW
         HJLZb9/O9gFPkjT98t29N8EybHGhkmGJm8Zj9hDhWTofgOnkyCCXXVimXUNndUWribQf
         lBDyc2gCaIxD+ZSmpI5IPfDOE0BFSPq3D9MkErbnqCqIBWJlzVRKCy3m8xsPChDMNqI9
         Y7kA==
X-Forwarded-Encrypted: i=1; AKwUvBxBc2Q3q+iXwX83bPaw7Ib7DOsqNB2rOFKzlv02lXbt96rFKhzwtqZy9WvGOTVB7a7NMQC2ILo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhzzDWuT+gEWdseCsgB8r1ePpx7jVSjZMO/yjqDk8KU1PP5LNA
	QH3vGnLYgCU8okvBnUo0Gt6m7iqsbWEfHX1JL4uekcFBgZ3aVfqGPeC1
X-Gm-Gg: AYBFou2I3puhkv6z7nmdnL/fvwFtAAZA9GsoB5RArWtPTbyImVQph5QNYeAfh4vt85Z
	NLUgqG1A1/z0cBiCrYJ7YpG8UVZQ3v4nuz3/5Ner1x1Pm8QTVELu064VFRxspqnJB2jFi3br5aE
	1MprZbBWfGCjogQnEscBxEvpq+OZoI385KPS51kVQAHorHwMJH8I2VQah+LNNby26a51QRgk2kp
	V05fiSBkNcsQoSsduz3PJqRopvrdK43VRVCHAoPzH2Ix7uVrWky1Fg6CzIwzNRbrUsveaD3rGRi
	26atOqNQKOuyuNN7Ur7vtd39VzWI1iYK5OomKHk7k6JYD8d7N4EwXCu9P7qMl06yJ+6BIKzuz2y
	eEGXx/qfMwSt8m8z7Ps3vmlt5Gc4eebyTLUBRuMsJFlaQTUbYqYeyTaV7bwHUtcMl9s77vgXAHs
	6r94HEyZ8nMaoExs5G4fFkp1g5a0uZI+YHcTgyTlU8+e6lPwmDeQiax5bZE86A5hVEic8adWpti
	ZYdod5J7TU9ORt1+5Jo333hW3gn9UCgsAPu1RNuWrqKbjISIZ5gYrxb7JJkPBV3BglhbAVFmImF
	NIlR6WQn6JUshgWoaLD2wQEvIesOoh4IibxzqEb4Ja4=
X-Received: by 2002:a05:693c:401c:b0:35f:2349:a574 with SMTP id 5a478bee46e88-35f2349e961mr6538038eec.40.1792143164540;
        Fri, 16 Oct 2026 02:32:44 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm5157172eec.18.2026.10.16.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:32:44 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v7 2/4] gtp: hold RCU for the device lookup when adding a PDP context
Date: Fri, 16 Oct 2026 09:32:23 +0000
Message-Id: <20261016093225.1036375-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016093225.1036375-1-anilkaushikwireless@gmail.com>
References: <20261016093225.1036375-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gtp_genl_new_pdp() calls gtp_find_dev(), which looks the device up with
dev_get_by_index_rcu(). Since commit e2d1baca2b33 ("gtp: remove useless
rcu_read_lock()"), this only runs under the rtnl lock, and kernels with
CONFIG_PROVE_RCU_LIST warn:

  WARNING: suspicious RCU usage
  net/core/dev.c:1047 RCU-list traversed in non-reader section!!
  ...
   dev_get_by_index_rcu
   gtp_find_dev
   gtp_genl_new_pdp

Hold the RCU read lock around the lookup only: gtp_pdp_add() allocates
with GFP_KERNEL, and the rtnl lock keeps the device alive afterwards.

Found with the gtp selftest on a debug kernel.

Fixes: e2d1baca2b33 ("gtp: remove useless rcu_read_lock()")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 drivers/net/gtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 99836b773e5c..15b5d845fc3b 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2050,7 +2050,10 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 
 	rtnl_lock();
 
+	/* the rtnl lock keeps the device alive once found */
+	rcu_read_lock();
 	gtp = gtp_find_dev(sock_net(skb->sk), info->attrs);
+	rcu_read_unlock();
 	if (!gtp) {
 		err = -ENODEV;
 		goto out_unlock;
-- 
2.25.1

