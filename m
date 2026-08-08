Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A72F8BC3
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150647; cv=none; b=DArNI+FMBcXTzULntqU8gvO9FkFAu8dJx7cGXbtMskiY8Q5Knb07S6+7mTloPcfKvC4YBRaXPEWxquZdI/y4HJFugFVD7iJyIFSBpHBQ1ptLm+V5E6HgeGODPNoCMVCOeUnh7znAAyzTcmnyChvdO1vUJD/3fhadJ5tAXn0GlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150647; c=relaxed/simple;
	bh=/1aVlWW0aqZciYFSw+AOVrBgxkbF7Mvd+1bStEYFWQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svts93j95W/czuPfLWMN3JP39QkGk/cvLDNohxIxfYzNbPnmaGzsVCTDmiv98Yvm81XGRbSAZCM0LljYFLwvCocIgKzicfth8TUlh73JjWVQkB/98Lz1Vzf2ZHIn0em18CMf+0eOVla4NTW6N3w2ZKJ7rbGXEFMk5QJiLL63QR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okFlVBKO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okFlVBKO"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38deea72eebso89883a91.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786150646; x=1786755446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yuxY4tXM3iR0bUsRR6CCNuiHoOS0/eoyg0oTXxAyJpU=;
        b=okFlVBKOC752/QidXq6WJmPC8WPZfQpgKT+E+4pX06HnXaaY7tcP3tS+YCAHRy38k7
         +wW0pV/pkgYYNmUcvEmYeSndORXgS7VOUWwx3p7Zb2ErVBnAbouAs3+O2jFlUY7d9YQu
         qm2l/K7493H7c91Al5svUEFG/KUY+NR2hwehEy+c4GkuaGalfhlFA3XhtKubDL8g79ZI
         iTT9xGv3gvhU4KSE5XNTKJxTpg7W/+tLXao3KAKKyq3JNPhRI3Bt15r209c9s0Vjkifs
         ZalZEen9Pka8QuoHr+iirsxWYttju+5nLH/AwfJxTOd6Mga8T0KGvJJfhIM57ZQVI03L
         zdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786150646; x=1786755446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yuxY4tXM3iR0bUsRR6CCNuiHoOS0/eoyg0oTXxAyJpU=;
        b=HCstUPhnvu5mlGq2kGhGOMo7ebHJcGx1lApHOhrl4SIYXgxsReqjZI28GD82n4V0FM
         R2bstN5j+AoTZvx6qTh3frjH7lAogR8xMW++tR4eJh6rvwxXT8xmjwZKvz4FF05aUFzy
         mPXOj6yaKDHhPYdybJtZwZahFF9NCa9Rwfz3PlmNQsSw+lI+zRCjD45XZ4UROHbV4JdY
         F8YhPvfyCxOLAe1bdLy/0RgLhBu/6RXW0XkcS9vYkv5nhHbKQAPcagx8OCCwFdq3V/4b
         FIKTlfJnqeSXxrJX450EiNGwYJzAv4AzzNpv5kmBGOxtHEvzkeB80eG0QBXjhPX3Pz0d
         RcPQ==
X-Forwarded-Encrypted: i=1; AHgh+RonSovSZ4gIuiW0qHSsD3nQt4ZHvMgxwefsSxJPVD6UXAbk4jIKpEYEXJ2Ln0Cb60AdFyzmg80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8tqTF/knAc6eJJORCbvGTBTT2+qn0rFipjcelv05Wnp55pAj
	R3gxEKPiNDdcXkw16+zhZLpK9nxFcy7BKxiOTs0e7k3wAATGXKVC5wy6
X-Gm-Gg: AR+sD12gKHx8upafO/6x+bpgOVxUFcwCHiv4TNFyXIqUk3xHfgiUuYP4wdssIJr3KEm
	L012HI3RLnHl0jfZhVW19U9ReI11FIooN2HDZ/pFuRYHKbgt2CIubhwUNeMqTwxL6T7chQxKI6Z
	SM9qWGsX6Cw5epxrrQHJT5HYPVaF3k9Fuk+UmOgPmK6+dxH+/FxsUEUKRERfMcyrvBOfwCsd5sg
	BpUO6/4qUChi5XFp692JeGCCyHCv522sfPM8ju78PIiiFmc/rcZOh6jaP2hxE8QcdZHgTsf6Efl
	ceni1OCud8v6eGidK/QdOGnWtk705Xr8Wv/a5piA0cjGfXKBBqZ0B/DsY4yf0fTC3GYBTV+JURh
	DyvsKyKJ692c1tUnvz4zPLP93BRBOA1jBWuGEYNPg5DtsHzdVvt22/q/Vt8pB3Bw+8jjU9SIhiD
	NVm/aW/QUT4JWGHPFjHgoXHt5KpzOIP0XXAfOlVAdA6Y2WMvtMEajCaeA2uE9EZytkOZ67OHP/D
	9fQr8bxpSlhkU+UyvmVLmBKvTCCQqfX2KEYOXTt0jy6v0yhXHE=
X-Received: by 2002:a17:90b:4f81:b0:38c:e9e9:e7ce with SMTP id 98e67ed59e1d1-392822bf6abmr3156672a91.3.1786150645933;
        Fri, 07 Aug 2026 17:57:25 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:d7e9:6449:7464:1dfa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6c13asm4205182a91.2.2026.08.07.17.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:57:25 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v6 08/10] netlink: specs: rt-route: split out the request attribute list
Date: Sat,  8 Aug 2026 09:56:40 +0900
Message-ID: <20260808005642.26901-9-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808005642.26901-1-sigefriedhyy@gmail.com>
References: <20260808005642.26901-1-sigefriedhyy@gmail.com>
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

