Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260302DB7A3
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786800689; cv=none; b=WZFlAnHVlRS0cqvX2aB2fMH5okvlfGX9u/hV7UkPoWNqRq83UAbity5hH2nErV7vgMQzkRghniAiQO9qZDVDAS8+qEqaARNAdWBDcsjuCAr3SAWQ+wKFSswosCOvzKNAgo9ANKdqc+Xj1OtQt9W+cwiIAMjyv5DkAPYBKyc2YvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786800689; c=relaxed/simple;
	bh=ffXPqKdSIu9gxybAgPMX1CVXHu2WOyg410kZcmMe408=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rrfI98wBWtU8gye6Wfymhk+YI0VkM8sZE69G7c1M5S1AeW7SwWhcz3LYmCK36JDfxRrJdy8nP2nHEbDJvqDaXL+K/Ko6psb3hjBeWda/UKLkdNF1hyBk8Lf3KHQRzc0jVxiy6qiWbXz030OfxnLdi7hwVCPEMwIPRofHSrcEJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+yzGkoi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+yzGkoi"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1296555a91.0
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786800686; x=1787405486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xxe+qK628pSv5aRz3Z60BtjyzpuZLQOeH8bhyQjGgxI=;
        b=M+yzGkoibBNBFeNxtACKk5HkYdv00BtxVpwW2G6GoyzGvqHPTphQHkUm/s83wpRt5q
         f/PbSQeBd6uyobkuvcIBWbhba4q7PXwOlei60LSIKZHHSZ3lG8dHulgNYX6EnmZj5CjW
         DoB43A8WJO5UU1PXZm1cJu6V0KWzEnXX7sEbDwDSGN0OsEvNiUBGiK5lrvhLczUYDHyX
         mojF6FSnCY5Aar0BK0/oCLHh0YlQPpH4W8CHTBnb8gG8J4Qc0isQiv34X1KkC5ZzBc+P
         CZngQAS0rV5IAbxRzLeHqTVopyZje/SjZflBYGQGERbgI6ij6rIwi2wpBKJ/WGJviNwD
         +rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786800686; x=1787405486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xxe+qK628pSv5aRz3Z60BtjyzpuZLQOeH8bhyQjGgxI=;
        b=D50pP7+6hMHv0qCymL4eCY0YitlyLvfeKg4iJbkcAnhKTG/ML1JWXMf+SH/JFaaUo9
         nBZ5G1/ht7uIIJAa9+V8v2948A/INg89cjIvzapYh0OIbmju/z2+XuL4c2XiEkwU7Kfk
         WRLgd6kS8LShIXbb7CgMmRgs+z5d8hyjQOR6HE0LTQitkCSUuYOQrwRpZbnr7K2BumzM
         AHckfPel3V7yYBc3QBYpE3e/juRS+biPoTzdCpVIqm29D279mu74McTPeDuaXt1nktqe
         1n2XFfrC/nBkbauQYtlOT7k4On3zPtRENf3nGEcC6bRfotFFFKAhtICqPnK6W5b8RZiG
         9ZXw==
X-Forwarded-Encrypted: i=1; AHgh+RpiJFmAisb1MSRUMQNmi9hFy3lVZ3qAR02azIBAsC7bsB8LyFe2wR6HalIzqnal4zRXs8ZMqwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPiZnI3kRVoUzrQf4eZIvDBl0F/eOWrZriU1zHCF3MNtdBYW0c
	R3srDSRBcqDwiwP+P2Pa3fMO1SdnKHf//2QQ8gS0P5IhCsKk0iXQsMFx
X-Gm-Gg: AR+sD11xY588DfVnHvVTKTTRD9jTIVPxLZrizji+i1mRquhEAm6c9GKp71LKS5fGk+u
	MNozQZ27Ftu9eoIRo5nxzTg83Vwsj04Tv+hAPI38rMcxYxjYFXJ6jD7TJzrCZZVu9gP1fzrBM2r
	HtUnOV4TRr5WLjWFdZHIAKOGjk8wmfJ3Z2GHao8Sk9FXkfV1BJwvwZRxFDr/2cuT0qEY3d2pTdf
	0X7JFZ720fl4rxdcy1WE1Vt4YByGYLTrpBKBf5/w20qKBWQ/hb5P7esl7DHWdoEhMSN21N9BAs2
	ySw2VjMg5YZyzp7yWJCUUNSs1IYU30T5iDFhB1gtVW2rkEqYr5PARXMVjS4O4NcJUAgolnTavZ+
	3BfwLudZuio2fixQpv9xMMtiTbSvrKxXw2NTuJhQPrZvdYzsfYqg9LN9DfkA73EBmOZvZ/GQPTo
	Sc67eD+Qt0b0+hFHhkKNV+5RdiAtf9osD75c1S3ZuCj/rysIrXzB8ET+viY3q6VEYE9ON3KzHbs
	zisYZ1A2nfIAYKYA33VKAPV7pJGOuB88V7NeCOojWP65VfO
X-Received: by 2002:a17:90b:5445:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-3931f450eb6mr16557155a91.3.1786800686259;
        Sat, 15 Aug 2026 06:31:26 -0700 (PDT)
Received: from localhost.localdomain ([103.75.11.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5ff42b7sm17854020eec.7.2026.08.15.06.31.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 06:31:25 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joas Antonio dos Santos <joasantonio108@gmail.com>
Subject: [PATCH net] netfilter: nf_conntrack_sip: fix OOB read in ct_sip_parse_transport()
Date: Sat, 15 Aug 2026 10:31:04 -0300
Message-Id: <20260815133104.50369-1-joasantonio108@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ct_sip_parse_transport() compares the value of the "transport=" header
parameter against "TCP"/"UDP" with strncasecmp(..., 3), but it never
checks that the parsed value is at least 3 bytes long.

ct_sip_parse_param() returns matchlen = end - start, where end is the
next ';' or, when there is no ';', the end of the payload buffer
(limit = dptr + datalen).  If the "transport=" value is only 1 or 2
bytes long and runs exactly to the end of the payload (e.g. a REGISTER
request whose Contact header ends in ";transport=T" with no trailing
CRLF), matchlen is less than 3 while strncasecmp() still reads up to 3
bytes, reading 1-2 bytes past the end of the linearized skb data.

Add a matchlen check before the comparison, mirroring the
sdp_media_type() pattern a few lines below, so short values cannot reach
strncasecmp().

Fixes: ea45f12a2766 ("[NETFILTER]: nf_conntrack_sip: parse SIP headers properly")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 net/netfilter/nf_conntrack_sip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index e4a70d1d7..f3b1d6356 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -707,9 +707,9 @@ static int ct_sip_parse_transport(struct nf_conn *ct, const char *dptr,
 
 	if (ct_sip_parse_param(ct, dptr, dataoff, datalen, "transport=",
 			       &matchoff, &matchlen)) {
-		if (!strncasecmp(dptr + matchoff, "TCP", strlen("TCP")))
+		if (matchlen >= 3 && !strncasecmp(dptr + matchoff, "TCP", 3))
 			*proto = IPPROTO_TCP;
-		else if (!strncasecmp(dptr + matchoff, "UDP", strlen("UDP")))
+		else if (matchlen >= 3 && !strncasecmp(dptr + matchoff, "UDP", 3))
 			*proto = IPPROTO_UDP;
 		else
 			return 0;
-- 
2.39.5 (Apple Git-154)

