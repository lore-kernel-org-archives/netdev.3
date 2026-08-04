Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC33E9C36
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808098; cv=none; b=EH1BRicU+RatPOPifflMHok+HmfaKyexvqYT6LSJ7k+obp5XgncaGY6CRzm7c1KT8TRhF0YhJrqjM0mnjjBKxNe5gys+VxxLRNXy+FqCCbEWUIKRM+bQtGwN4o0pZIfXMhwBcprzEU8ebhY6N+oEWnmH1BvvsDFTrL2mem9MtBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808098; c=relaxed/simple;
	bh=uoRqyxiUw9LCurSdEf9hIm/MOgPeemDa9zCCwG7QUiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3nRJuUqo+pL9F2eKq9ug+6dROEk/dF83mq2LPP+2vMqltHoRf1ZO8wIc9aWYF+KtzKPhjJ90djHw6H80p5XLCLeetQs/83lnj1o2+Kdc5rHG9V0agSnJAu7CIHq80H9Gx6dMUmTE6cNJ5layCfLdKczS4psEvWUgLXVcn0yJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4crGZx1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4crGZx1"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso2321445a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 18:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785808097; x=1786412897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hUtJiaQMigx86+BTH4O364XnmOj7lYQYaBG+rEXNuhM=;
        b=D4crGZx1muWeCgSFPBkDeVZYFB+XQO3WdPl7YbtJI8ydDA6MFM7i36drhbYg7eITNn
         GCP8Btf4eFVn6Pfi7B02Zdg5g7BctUZcE3xrRaFilscFcT204DNfsH7ktgSTIjTyO/Eu
         LE8WdO1p7CD16M8K/cohwXdoquUAu5tri6OJycTO+bNeY1OY39afMAHHnJnA35sYx0T5
         rRQq7NhT3f8eiNElDzSl1mQ4XiUQDIj1yEvJcTJGETvIU/q3xRE0osLDPOwJhMP6/O0Q
         cblDLO/5hMPpTLXywtWdLIopDwIA4K3hzxm8o4CyOejSdeFrxq5GHrT1ZL5gvwzfe8iK
         WXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785808097; x=1786412897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hUtJiaQMigx86+BTH4O364XnmOj7lYQYaBG+rEXNuhM=;
        b=T59hCKgsXnFASVO8rMaURnup+te8W2nP2KagVmRBKnvbov+9c+Cg/Anp97kqucoMAe
         XPSkjWPQpbnugpPcMN/jg71z4TP6oP+6FpzBLyovXNT6JprAaw8gB7qDHaDnEdXuaGXW
         tENtz64/Sp2755h1CCleH8GUSsYy7OKQydaWG1YqHTCe74qqQh29ss7dDWoijVq8/IBD
         63MTuo3xdpe4/QV07Vu4BK60qUWTIlGgFZTPAboSXOcY6YL8DdXoG0GlVC/BuHA/IB9A
         nVDvxrdutrkc2ZGwwFMB7rSPl2kxg3ptxpGHDSymMXWybSgImB2rVrhAgQn7OmnS2297
         8fGA==
X-Forwarded-Encrypted: i=1; AHgh+RqTrgbW0H4b0ytBUM0RUlFcBwog8FC+jsqTQmiJY/pwTy76KvxXj3dqLLLOOkQ4tWG6H4raWxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQw50AOJmLn71r9T5AzHIGhdMCagpUqNchjJDWD8Swp9NVXdV
	D1pVQrb2wWa8EuqUpPXaBd0PU4uuzMLdbO5viOZDgW7cmuWUWa5GPALo
X-Gm-Gg: AR+sD13o02xi7XyRVFOdutnNTHhGuD1Pt6icX3W7xbM6+Y2TV5O0qK80HkoY04hJHmz
	ZD8LIPynxtZy8n/yBQaDdRcWYJg3aQMsp/JMO8k2p26VQe+5q2j1YBobJoYHVZNk94QFcomKCY5
	c+edyWJRXvHKqe/RLf0/36bVADnC/1OWOGdtHjAW6CUndZXiTjw32+ISJLMRVYtk6v6T8ILfqfl
	JQWamI1V0xpEzduyHRRVIgy2yzmk0ZF1XqCghsNYjjjIHV+sepRC9aZy6io/m3rMgSEhHGmNhzu
	UfJJJnd6z/ufdQe5SNZkkeBvYCrB+mpSAvVq1MZ+O3zZdnPrnZ55JM2meu6YbCjKmD7xl4jMnbA
	JH3ajDiGt7SN0bB3UKZo0FK0flbo9At1wEOyG213iVIsMNbUtMv1LrdFqqdUQUyAXmX4OMYiE8/
	DT6yPtI9gInmXIMwN4ml9f9idRvistf+MXas7zf3DBZ6wMlPplY2+fok+9yDPk/QTHV6WyKC0MG
	8rnnpvWKLa8DrGm1N9g8cH361JPRYvVn71EGveFvvjD8kRFxV7d6ec+fjY/yw==
X-Received: by 2002:a05:6a00:951c:b0:842:6a3b:60d1 with SMTP id d2e1a72fcca58-84ee4865f9fmr11371595b3a.31.1785808096804;
        Mon, 03 Aug 2026 18:48:16 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:cb1c:934a:3e5f:ef88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d7b97sm4410164b3a.43.2026.08.03.18.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 18:48:16 -0700 (PDT)
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
Subject: [PATCH net-next v5 09/10] netlink: specs: rt-route: add the route deletion reason
Date: Tue,  4 Aug 2026 10:47:13 +0900
Message-ID: <20260804014714.4362-10-sigefriedhyy@gmail.com>
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

Add the del-reason attribute and its enum to the route attribute set,
and to the getroute reply, which the route notifications reuse.

The attribute is absent from the newroute and delroute request lists.
RTA_DEL_REASON is above strict_start_type in rtm_ipv6_policy, so
encoding it in a request is rejected with -EINVAL.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-route.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 9f4a1a253676..f14532798640 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -78,6 +78,15 @@ definitions:
       -
         name: rta-used
         type: u32
+  -
+    name: del-reason
+    type: enum
+    name-prefix: rt-del-reason-
+    enum-name: rt-del-reason
+    entries:
+      - unspec
+      - expired
+      - ra-withdrawn
 
 attribute-sets:
   -
@@ -185,6 +194,10 @@ attribute-sets:
         type: u32
         byte-order: big-endian
         display-hint: hex
+      -
+        name: del-reason
+        type: u32
+        enum: del-reason
   -
     name: metrics
     name-prefix: rtax-
@@ -299,6 +312,7 @@ operations:
             - dport
             - nh-id
             - flowlabel
+            - del-reason
       dump:
         request:
           value: 26
@@ -313,6 +327,9 @@ operations:
       do:
         request:
           value: 24
+          # del-reason is notification-only. It is above
+          # strict_start_type in rtm_ipv6_policy, so the kernel rejects
+          # it in requests.
           attributes: &route-req-attrs
             - dst
             - src
-- 
2.43.0

