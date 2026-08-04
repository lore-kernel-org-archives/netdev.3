Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4E2EEE6C
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808092; cv=none; b=PfnB+lylxHzV/5HzPlegB+mJ+eZXpAoouHQWzPGN43zZupX0TrRyW/ufdDbUm/MIiXMNRNmZgTwNObKYy84/RPmG0obCgOjc8JN+OnSMWjMjUbREQ+O39mdhTGRKvrFqMaAwpmc/1sPeF/UGCkYMbpfxjpoHwDoDAvds/6m4mMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808092; c=relaxed/simple;
	bh=/1aVlWW0aqZciYFSw+AOVrBgxkbF7Mvd+1bStEYFWQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZOmdSmS06JJNKS9ahWzBbttFK9qJSfNs+XH8+bbksC66rb05nC9mPwwKFROZ7gsPHFFSR9y8R2E3gBB3zC5pLXP5zfEXWnbzWC6P1KabzLICCZanVqItOkY8ruF+FSMKB0XNwzO+gS4eT1s0538wPOwg2swEpDg+WEgoW2TiQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtDiJHQm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtDiJHQm"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84874b52eabso5429190b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 18:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785808091; x=1786412891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yuxY4tXM3iR0bUsRR6CCNuiHoOS0/eoyg0oTXxAyJpU=;
        b=GtDiJHQm/bFbpu9rUDpLcmlkqztxWEKdfxzGLu7qbDVcTiMYKPXCCgVf0jtu2KlDEl
         yFGOzqYt6LdYHqRHSVbiIj/SaS1jtUR0rZlFl1R3Omb5aWZvb0WUgjB2CKaJsltxq40o
         3IerutTBVBRwl6hD6IGQyN60jNEm7Yz9scVHOIInyG/5mp0xsbpWe2dotXNk4ZKWtPcn
         r2oLs1uxVnmTbnyECzV4h/tfUuMLC8DRVKuNWPCjfIKX7RzkpuINrNb6FanTPnwAK04a
         +OPtPu0vJxPHWYAzNyhWtNeyjPjeIf5/IQVXrXRiaf4weXsH7G8DdgmTEu89lLww2A0C
         magg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785808091; x=1786412891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yuxY4tXM3iR0bUsRR6CCNuiHoOS0/eoyg0oTXxAyJpU=;
        b=F8+s5SHTIdL2LOI0oQSKLZLK3E5iMGbWu3zSX8n/4YfTICQCoLxJCtjdpfhW/zzePA
         NXRVzhDLBWEBEvGBUtoakicMGEjZX5yNWGTgCJI+bWL/1BhQ1hI+lW1tdkvk0zqobds+
         BlBaqzZooJNcW3G1zd0eBuOBedBdQXtrJEqAtKgmDI+Z7jlrYtS9NuTxjFY2CA1ucnZE
         6ubx1knLlpwULHkMsKSstUlG+NiQ3pXIht7WlNL+7CidAuPKrCjPuv2PEujr8XnxSFp+
         PBAFVsMxUcMvrKLx9bECRe4WN1Z/nTe+Qjwnl+x5aAi0A/4PobPi6XsS77GTwg6acVAn
         skOA==
X-Forwarded-Encrypted: i=1; AHgh+RrMQ8G3s5OecK2LfYcWsWDQgMYWQ48RfZoLgEdQRUFVf9Vt+8r+V1dctXYDYfbPvicjKK2cgW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6Oy8yw1uG1U4eLc/BHxKJcytUtC6VoiCwMjwR17JDp9eWldt
	bJAkgCAY3T6vSYiD95MvZNqVRiSMURpwf1aIN1cbRqVbxjU1BbZUhdxR
X-Gm-Gg: AR+sD13tjHxfQFDKlMVHpx6lK+VXrtMWC5WS9NdssX/uqf36gTQPfVHGLKLVfp+zAM4
	L53TMCRv8//7p9+olE2WHQgoYMfaPIIBGRKDWrLwviQgxOwASQfdbGrazQgHE7vte7Qdz66U6/y
	SSjVHWz+sPKdu55C9wEdbVzlz6C+4ucRarFNqQlFB56f/oyr/ZO/5NeQNupaGjpF0GQczzMne4w
	GWBfLh6KbwlGVnYvItCj9KtnS4CNNbuXFBk1AwDN6QjweubNi4bb6r0tak2xi+4ecz48XCriRh5
	052a1jK60R/xS42N9k76IUni9OLHnEjVRseugoSj27PZvNf4h/oL1AYRbvgiWmSeN5iBMnplzWR
	fOVuXlxfuxCG8J7JKadVRtKExY9xG1NvORyYehQvmvYVDzF5kkln/UGuxTJIlUSfm1iKmwhTnzG
	JfcyAyjm5Zdha6LH7eXjMcmyt+K3xjJw2/L1McJs/Jhb/W7ILa8jKjq/tYMST4EuU+R5KPbhT4x
	yQGuGvW648KiNjdOpk4kq+ZlXRDvMerMyXiAItQX6fNv7YrJd4=
X-Received: by 2002:a05:6a00:ab0f:b0:845:4d71:8d15 with SMTP id d2e1a72fcca58-84ee4921bdemr11575444b3a.37.1785808090858;
        Mon, 03 Aug 2026 18:48:10 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:cb1c:934a:3e5f:ef88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d7b97sm4410164b3a.43.2026.08.03.18.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 18:48:10 -0700 (PDT)
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
Subject: [PATCH net-next v5 08/10] netlink: specs: rt-route: split out the request attribute list
Date: Tue,  4 Aug 2026 10:47:12 +0900
Message-ID: <20260804014714.4362-9-sigefriedhyy@gmail.com>
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

The newroute and delroute requests alias the same attribute list as the
getroute reply, but requests and replies do not carry the same
attributes. Give the requests their own list.

The two lists are identical today, so the generated code does not
change.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-route.yaml | 32 +++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 62b215614210..9f4a1a253676 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -313,7 +313,35 @@ operations:
       do:
         request:
           value: 24
-          attributes: *all-route-attrs
+          attributes: &route-req-attrs
+            - dst
+            - src
+            - iif
+            - oif
+            - gateway
+            - priority
+            - prefsrc
+            - metrics
+            - multipath
+            - flow
+            - cacheinfo
+            - table
+            - mark
+            - mfc-stats
+            - via
+            - newdst
+            - pref
+            - encap-type
+            - encap
+            - expires
+            - pad
+            - uid
+            - ttl-propagate
+            - ip-proto
+            - sport
+            - dport
+            - nh-id
+            - flowlabel
     -
       name: delroute
       doc: Delete an existing route
@@ -321,7 +349,7 @@ operations:
       do:
         request:
           value: 25
-          attributes: *all-route-attrs
+          attributes: *route-req-attrs
     -
       name: newroute-ntf
       doc: Notification about a created route.
-- 
2.43.0

