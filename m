Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024C480943
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326908; cv=none; b=gc3quBZZn23Q9l6HCFoCFosxGh9cNYDabOS7FtccgTQXtpNjqbTOSt8RVdPbKsCL8HLC4OJ8EvbF7bHH++si+vrUItmgQJGx93TYDgxBtipi+EhUks4YgkX4QOlyl4AtApQ/23yS0BANKT+CYUmaKak3tZPy+3VF7wwj8upy6HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326908; c=relaxed/simple;
	bh=B7TewygujZnaDoAvFCdYw3/qv+UCkSEJvMuQcq5Qjm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrwplFwyNmixtiWBKdg4/jYJ3V61O+2krIUAEk3mtAK9e8hFQ+Taz+ihsIAKjahJVpicMb/oH2DmZ4CBsthykEUvC2voBWjOHVC6FlDzfXFBUfO2TZOILG9vLH8IdLwYtSwm2MiphyKBCfm+r1I5ryb88Y4EiFmnINbMHU8HDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeBq08CV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeBq08CV"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so710210b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326906; x=1785931706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gzb9FT9wUkGMcUEIoMcEc4INRD8xMXaz2c0lYN6UOZs=;
        b=jeBq08CVF0F7/p6XcWm8lVsaFnjt4sPzpKFOfA9VgEBrozFr3w4Fv4d7kSnOAes0Kt
         v/xQ6plUM6OHZeQZHsFlGpbUAAyOU6IapAkqI1k4hi/n1h9EGdoJFtwr8h5wHTuMdYJF
         bfU874jmuu3HcvvNLgSwf5ZCF2myF62Jjk9XBky7qEV3m+vhj2RRvgwrbsWZH7tDtRdO
         N/1fCiN05I+UVyllz1/HuKxZ6qhOpV4LewLVA3OWIxpHshCFxhtVZAEqf94n98EuVrT4
         32yBzcq+uwqKbyM8paWs9XBQMRakkKfmEB5HUPuOmcumWOGSfYoyJfYNuzg3StqfsW/4
         yNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326906; x=1785931706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gzb9FT9wUkGMcUEIoMcEc4INRD8xMXaz2c0lYN6UOZs=;
        b=bW87GEyw1MPWd60fozbLVDzP4xNb8xhoNCNfyyjVVxnSxIr2WyOjUpTpsgsOYQuGdo
         LLJ68JzeejH5uDz9UKz3VFK1mNt1o26LkXJn5+2ZiuyNCPl4OAjV/QFJTWfhFV73rmc6
         5UjjT0eJf9ylVfqSMQe3vYiH+IqX/muUFDDYJMo6bg0aTUSk/rFFN7NQ/sB23Nw0LMpe
         67w2yyHZhDITt40HlsJOLNv9HAYmmI68OG8rlVRNt5oOLvfQl72+8z4nJb9K8GswoRy3
         szN1oMiBOBY611YJY+lFtYIlqMyawWgOZD4tCM16lzNYo/A9NvW+oz2CvecReKUhOQAh
         QLVg==
X-Forwarded-Encrypted: i=1; AHgh+RqMb/CK3sKBnojS9hZzKucT3sw8VVOd7GqtYfI2LoocjR+1oGGy9gZSLLxvL4ianURWx3FXC58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnY1OrLhlpD8uizDJlUj2BwB13ZDGUnfTA8bOO+DPBnmE9RH2a
	AAmMqVXnlG4nrocV9wOB4j5w+9MMu8oObJHf5zbL05LimIaRMvPFG8f7
X-Gm-Gg: AR+sD11CDe0ht8r4sNxX/wNwa0M9FLtqWkaksO7oYbsjvO1vEwtLdn+dRjJkTDRhd0R
	6ABVwufW0CTDiC1O9iV3RbJoWbUa1CjbBlKACx8nXkPtDU1bCws0/4NGYTQwHmNMExdOiohyYFJ
	fMNfjnzubHsUNOBqdIo2IkxgXNzbgxBwNFypgFwmKxyGFEBM4h/8glsgDV0dQjknatFoS3QC9fN
	S3cAOvuFi9bwUj2qwNAjmF1Qq5C4RrEpoOTKG6bvrb/l1h2Ef8YNupCbv3AlhRC8fsdeFEO3CMx
	Vikro5xgPm82jSDvxJOxxF+UyTWIVwnK4bwOd4r8P1ufMKmEUoqbZCzLHrBSt6Fm4u42fYHR/xd
	zJS7CcktI1J5R4pV1VB/bAPKW0TKnpqH0n+tzUGBgZizaUVVk1FCW2LKAtPUOl3DnpnJrT6zUKF
	WEJWqydF2t0xuXKd3ZEaxrNEfo4xT9MzxzcaRBoAD+kTbqRirCnxV4AnGkajJUKKe/bdf0omGka
	bROb9DAT6I3gYYcIaKtnPTzGQFUnEx9f/TZGw==
X-Received: by 2002:a05:6a00:10ca:b0:84e:456d:ab2d with SMTP id d2e1a72fcca58-84e933af6e8mr6425269b3a.45.1785326905311;
        Wed, 29 Jul 2026 05:08:25 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:c705:d3b3:a6d9:8512])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0300ac2sm1263482b3a.35.2026.07.29.05.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:08:24 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 07/10] netlink: specs: rt-route: add route notifications
Date: Wed, 29 Jul 2026 21:07:36 +0900
Message-ID: <20260729120739.47880-8-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729120739.47880-1-sigefriedhyy@gmail.com>
References: <20260729120739.47880-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare the RTM_NEWROUTE and RTM_DELROUTE notifications and the route
multicast groups, so that generated clients can subscribe to route
changes. Both notifications reuse the getroute reply attributes.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-route.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 33195db96746..62b215614210 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -322,3 +322,22 @@ operations:
         request:
           value: 25
           attributes: *all-route-attrs
+    -
+      name: newroute-ntf
+      doc: Notification about a created route.
+      value: 24
+      notify: getroute
+    -
+      name: delroute-ntf
+      doc: Notification about a deleted route.
+      value: 25
+      notify: getroute
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-ipv4-route
+      value: 7
+    -
+      name: rtnlgrp-ipv6-route
+      value: 11
-- 
2.43.0

