Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793447081;
	b=OI6G67OCKTQnVf5FkTATggW+7uDEAE9l5l7DssHlQe28DWgcSND0nhgrZiQ3lp34q0kw
	 a1lbtGdtEujmsLGTCGQfN0PqK3ZvinEK4R0HfyovNOAZa6qkg9siHm7n/lBh8QzjU05lE
	 RgZgc2ra67NXtDgkbsy21PlXbCug2rq6lX7cHoJvz7WVCd7PnL715c7YoRNzbUxhIAxoG
	 TNsMC99V527RvZ1c5cy8t/80shjv7/hNzBdxQeM+17sbYqdm14IX5LI9W6+8rOgrjL740
	 AjWbgjFdT3oquMLUvCgmUAtsU9O9RWXBk5fpMVrm6fXJIXBMW0Oc/2a9qNDcXuki2DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793447081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rtkwj2aNUl3brz8yXx8iIT0RsCKwrOnzD6bl0O+bC2c=;
	b=IVs62rqKNHN6y81VPJ+zazLmoRkhMTtIVMzdR8imJgtqhUVguFti5HckeTRkk1hO4rAr
	 QEYcOdbZmlEgxaZLLxJvr0HQrdWJE9u4An7Z42mfu0V/vybV3/fSZ+f7AFdKOFKPba7Zs
	 YFyr2xPnAFCbbSmtvM4Jh3pORM54RaRlUM7cN2pUUS7vDI6Ll1Z4C10smyT1GTQeiHWST
	 NgmCCS6c+kf+dh+/U+Esk3GJqv5HD5CBY+BV9/HO3SOx3eZbeLNmzjRA9Daz32OUfXAJM
	 tErmZPyDT8Fn4LrYyJE7eeAnmFa1AoHsQO+l4jyPaQYJmQTG1fbkJ8e7fo0YPn8/hnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wNRVhdOE;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7C606A31E
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 11:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95E7C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wNRVhdOE
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-369f33df08eso3147542eec.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 04:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793447080; x=1794051880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rtkwj2aNUl3brz8yXx8iIT0RsCKwrOnzD6bl0O+bC2c=;
        b=wNRVhdOESz7HbXHeX+lUT7zBM/Sdy2ZaS8KMpUB1CH5uN718jHgBvyAqzp/a71NQj2
         hwRH0UFlempMiiUrS0PvyC+1vDm+mkIOA3ooyAgUuwb1ZJqhvUO3TFLcq8vvqIf8pPoj
         jLRTApohA4ojOpidpJopsOXKXDFTBg2s/Fqjb7mmtvW1sghIXSRwIoOn9yW2fZJBKnrE
         YxsFvXr0FbOXy/OYsec2zRmcm3lc3VEe+zE8GIcVlZSg9C1TQqwNC76BAPKUNdv8dWqX
         gTwb8V4oKiX7PpFaQaLJ0SwVxXzmxXciVC6wsGUVj3LKLLg08kBUf/eJl2isRYfX+wQW
         PxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793447080; x=1794051880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtkwj2aNUl3brz8yXx8iIT0RsCKwrOnzD6bl0O+bC2c=;
        b=LX+2WALBIKlHYbKkcCFgEF9odM9qqlR7Mfi2suoNIgKhJ/z8ByzDcERXXBP88a33+b
         2Ok+AbXjN/3Nqc7zUITWHO8fTB9swdRPP1fZNis2ohp7datmNe8Yh1B8DbQxJcNkOcwf
         yu8cgYIihXQtvGpjhoqNXtHDeLMFRt1OuhzGTWtCXl7FAL13DD4UDNxojtRzY7G2XJH5
         vamVrO6BGPetdweKIY0m1cv+ZGgZ6MFHS3zsMlDzu+z4dbiIOU76We1gP0Y3C2gtG7Oe
         TMLvNW2d8hrR7gbL8dduz/6te/fGgf69ooJ0Lm00qlOiEOiRzWLBiu0WicD3zV5QbhEH
         VuFg==
X-Forwarded-Encrypted: i=1; AKwUvBxNjazU0NFzOUlw3njW0rbP1jIQkKj7xzN8+VWTLMYGfan6cDg5G27ZSN2Iw7yNM/+qagWkeqE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLssV0XtUCLk4YFK/gO0Dd+pOAssb6jKIqfmH+vAfYpAV7q5mrb
	DtDIi6nGdq52qtEG8YHxi1LFY7h5O5NizMbCFDD+39l8pD0ggO11qxQXcXEB+0eIKno=
X-Gm-Gg: AYBFou1ftIxHrm6b4pQtcNrlZJ7gz2ULQJugp163VMBpnjbWkRFo4G2JMJZpClNgHwX
	BVbdoHeqqV7Bn7zFgqFgLkm5eKd3VYeAVTwi69sHIbgUxPob0DXOZuZpDROKEZ6J2VOHiA7yG0U
	NoxY2DloVx+kOOYGHICFrAvZNkqBvM/Q9AIcvWaroYjP3pUW+WIsriqYPYLiR6mAkCy7d1EjIBL
	e6qwaC0kFt/pVP646yY3Ic1txHEjZ38e0+2JPYuzVMwACz5l90bG/7CMQA3wAgr0JiFULaH1f3j
	s5yDQCMZywTVtb4Os2AJ/Q9w9NgZDTUNySCjlmfcZ3ff8vf+9CX9fnICnD62s0yXSEKhZVElBrC
	4apUsYDjDblbpqWajX9rxa28W9zrlU+D7Fsh3uvS5DUnrZb4bSmwFGT7ILFRzfzNT3SkoOy/NmL
	mT7VG4OWXEYAoj9i0Q5+zDsLbjKdjN2256e998JmopWBPdnWylCWFFKaN91pWOcnZkDdu2Eda0l
	8zb0LhLXEY3gbK1flJyP+WNxI+A+C/NpxeBnKTdW6SjKglb+dsJBhaKe7yCTFIHAbW7LRQpAx6H
	p/myCebYC05vYaHh8MSqm48PdntMoz8XvOdZY1PMFButvg==
X-Received: by 2002:a05:693c:2409:b0:369:b75e:d24f with SMTP id 5a478bee46e88-36a423ed004mr7318546eec.24.1793447079579;
        Sat, 31 Oct 2026 04:44:39 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a98f65sm15960512eec.28.2026.10.31.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:44:39 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] netfilter: cthelper: report absent filtered deletes
Date: Sat, 31 Oct 2026 20:44:36 +0900
Message-ID: <20261031114436.31788-1-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfnl_cthelper_del() returns success when the helper list is empty, even
if the request names a helper that does not exist. The same request
returns -ENOENT when an unrelated helper is present. This makes the
ACK depend on unrelated list contents.

The empty-list success case is needed only for an unfiltered flush.
Return success when a helper was deleted or when neither a name nor a
tuple filter was supplied. Otherwise return the existing -ENOENT.

Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
An arm64 QEMU/KVM kernel received NETLINK_NETFILTER cthelper DEL,
NEW and GET requests. Deleting an absent named helper from an empty
list returned success before the change and -ENOENT afterward.
Deleting an existing helper and an unfiltered empty-list flush kept
their success responses. Tuple-only deletion and packet traffic were
not exercised.

 net/netfilter/nfnetlink_cthelper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index 5b6a09f46903f..774edb07fb1a3 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -700,7 +700,7 @@ static int nfnl_cthelper_del(struct sk_buff *skb, const struct nfnl_info *info,
 	struct nf_conntrack_tuple tuple;
 	bool tuple_set = false, found = false;
 	struct nfnl_cthelper *nlcth, *n;
-	int j = 0, ret;
+	int ret;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -719,7 +719,6 @@ static int nfnl_cthelper_del(struct sk_buff *skb, const struct nfnl_info *info,
 	ret = -ENOENT;
 	list_for_each_entry_safe(nlcth, n, &nfnl_cthelper_list, list) {
 		cur = nlcth->helper;
-		j++;
 
 		if (helper_name &&
 		    strncmp(cur->name, helper_name, NF_CT_HELPER_NAME_LEN))
@@ -738,7 +737,9 @@ static int nfnl_cthelper_del(struct sk_buff *skb, const struct nfnl_info *info,
 	}
 
 	/* Make sure we return success if we flush and there is no helpers */
-	return (found || j == 0) ? 0 : ret;
+	if (found || (!helper_name && !tuple_set))
+		return 0;
+	return ret;
 }
 
 static const struct nla_policy nfnl_cthelper_policy[NFCTH_MAX+1] = {
-- 
2.55.0

