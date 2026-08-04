Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F30392C25
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808086; cv=none; b=WaPQW/kEgpI9GEHHZYkEhXFNa9z6JjXcNZwkjFagaE1FzLFrY2MDc9b7z8CWf5kjiuKQTIYXr/ytnB9eX7OGFsbCvO5Zhz4iFXDSnGkSSvxMV9IaNWShBa4GI5rlORdhwA7ezUPFRg7PrBiKiDNnTQIjEmuYTQY23zDFLLmvSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808086; c=relaxed/simple;
	bh=B7TewygujZnaDoAvFCdYw3/qv+UCkSEJvMuQcq5Qjm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbK4n6yAUY/Bc9MzLKFXti++HV5wPL2CP+7LxfUoGMtHaJE4nzyBse36reN+JywZqqPS1DNkVTEro69T5Eke7V6mBcZ83QqsX51h1KWu4q66R4kjP0GMyUOvvxBDMLHz4SLwIE8QKZB79AYmtUVFNtF+1yTw/2GjNfucVAf1CZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxKakGrA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxKakGrA"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8485ef63b68so4392596b3a.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 18:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785808085; x=1786412885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gzb9FT9wUkGMcUEIoMcEc4INRD8xMXaz2c0lYN6UOZs=;
        b=UxKakGrAXK+srhhZ7fjyBs5IDSMnp5r+YnxN43B0IJziyG6VhXvAwso8rFShH2FZuZ
         uShlAXaS4N8JSsxaugTPdL/VwZZ5KC+KDxSUiUknhNmENx1Iqig6QOjKdikfUlea5SaV
         LWicsudki4ZBMchIQxmPpnd/l2KhU6SDIFZFXSAkNO0Lb3KPzlkX9CWAZjQvXGmg3swd
         ss8JKOE8AqPJ+qpWnmPOyiuGJwCedNuhYWT2Jb/DL9WyqoPBu5+em5b0rzOWnH7o+iK3
         hJE8mSH8BXYsABNz/YQ1vTDwRcJ2o/GaheVu2VnouJuijnFgKqS6Dbz48t6ibgw8v9LM
         dw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785808085; x=1786412885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gzb9FT9wUkGMcUEIoMcEc4INRD8xMXaz2c0lYN6UOZs=;
        b=Fnu3z6mlmMQKXNcmiSHPN/eT9u3e0eyVL1ybQxpmz72RfZG8+LLOXzNENVxgGbKpYV
         SDzhqAlule5lModO9WbAvTBHeEQRpkYaY1g4Yy+bJtbIwBxSbr7Lsgzl8yfubPIKaBR6
         VED458sGn9AaSaGFA6FD9QMIupDyyaj5ScvU1aZ/e0KOPBDmQJiY61AozE8Yt/GGFS3X
         lZWn6DdIitzcpVk3pNYsHJ9ISlQv4hX27XeaxM00QSL9N11sdM9GRdwskmuHrpob9GY6
         g+8uvRr0vd1wgROX+FZ2n9bKXcEXOWOFmKSa1c39jJCt8+wyLpBtq4GFB1WCuR6Jrpu8
         eC1g==
X-Forwarded-Encrypted: i=1; AHgh+Rq2qwa3tJanBJ2dyPo7O/zCJj2KCSMwemcokN6blNIChBlOJlf/MaiGSUnLBUNClrJjQdg1+E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJactN+ZXOZkFv9hStvLGzo/C92BUtWU1pRz/zjCjkJaPvkAS
	GisMk2PtoGm6PodWE6oK5ipz6G44Q0I1IXjts7UpsP5pDCh7Zq7k2uDs
X-Gm-Gg: AR+sD13bqgSFuwkN37WC8qR6zX+80ifGrVq0PRLy3D+S+CjRxwzzOCWnhiikhgiEyXj
	75rEpJkWiJAYpixJeIbcmvaUXdog9ENbsjy1TEJAenHESozg7RzzRivPpzzM0KC4lHBQV2GkNeJ
	dEl3tm7z2vsSwQ1/1ONl4YYhKce9acDMk233WRNg4c83eXKwavAARsQmtnEbn9n719KM5ssx2QW
	dHQX7+rkhSNsIBT5OtxEtoxdpjTLpS0NcLdWAALiG/4LiF2jr0Wv/3SCfZv+USmmQk69jO8zV8C
	es1nCY9jBv3f8UfT/Dli0s8HSo7Wjsl9+D6O6iFzUbU+z5yz/HCOLtXgxl4ytxGvya+NfwqSNJ/
	SXt145yI47Ss/5/f0B7j7B/j83esoncmq4/GYNbVvsoBdF3DUHPMST2f5fVqaCdsx/8UzIaqA6/
	yney24e8HrFGWp3GW8xtPf2VibcEZ8J5MEGAMqDM6rsciNdS0n7WlHUSsYazbRZuQD4UESpE19R
	67//cYf5Jh3LL+e+JXFed6zdn+CWGJxIcy0IWj7JBVC1OGRuQ4=
X-Received: by 2002:a05:6a00:1488:b0:848:30fe:da34 with SMTP id d2e1a72fcca58-84ee489a8dfmr11000766b3a.45.1785808084960;
        Mon, 03 Aug 2026 18:48:04 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:cb1c:934a:3e5f:ef88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d7b97sm4410164b3a.43.2026.08.03.18.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 18:48:04 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nimrod Oren <noren@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 07/10] netlink: specs: rt-route: add route notifications
Date: Tue,  4 Aug 2026 10:47:11 +0900
Message-ID: <20260804014714.4362-8-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804014714.4362-1-sigefriedhyy@gmail.com>
References: <20260804014714.4362-1-sigefriedhyy@gmail.com>
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

