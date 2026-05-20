Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2A3ED3A9
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297821; cv=none; b=mXgtxfZBIMzD4utoX21VBRNUI5WwxRzoDbYlr3z3+/Y87MebmPxM6pVn/3L870cShiKAYRVvTpWMBlHoSF4fqc+Ygu3EnLgLo5JncCvwwtHstrAzQG+f44/EtdfgduaG1UQ7TrnIWWc7zZwj8Ffq7IzGM2H+t+hWQz7Mms0IEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297821; c=relaxed/simple;
	bh=pq5ewNPh6QbkE7tEQm34DFGGF2XP2Fga+Ldca3aZ7pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmwrlVzM4eGGGbnGILLMEDQGqyrIjnBQMqK+R8J4RO66l1+0o0G8M1eVnhGRpEeBxO9Iw5pdHC31TiAchvBXtgjWqFEsx0MnSG89ZlLNJuhzkwPaJnEwm+Zh/h/YwdVXZ4peiSEED4qU2XBCJfcPY9ypKEsBZCQtPNnyhd+AWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-45e8a834cc2so1889676f8f.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297818; x=1779902618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z0yVai+Va2zy8HPA5HXIs74P3GZW6aeEN+twxmzuGU4=;
        b=BxFfRhOdr2P9dLW3b5Pr5gxm/XzWhanAKG5hzXYUN/9qs6gXrHKQaHVaG39x5sA4At
         Iva5FxSAr5jqZZA1FExUK+GQO4H0ySDTWmoylQgTkZoLQ8ClLhok/20sSkf3DZlKRwVt
         Y12nt4l1H7SoWIL10yGWcyPMXwucDU3dmLfiRHX+AiUoydSnWh817Ybx/6GfHYAc16br
         dQa/9VSp14/cMIBMnzt+AO3bzbFsBs9xyWjtK/PeoELXsfuoJYMh2DPBlIdtXPneIkV5
         fm7lNBvIv7/VeBIM/+ZP+HtIPQ/sabkcpRCkaKZkbQ11EoJHIaKfx7VnbNXFTsRSCg3N
         87Vw==
X-Gm-Message-State: AOJu0YxUBGlyRGDMThYkf7GlpRkcQzSWM08sNyY3yOb8dp9C8G4LqawE
	WlEv/O+zDVByA101WlNTwSc6Cc4NGSszYgANv+dLVXmZieWjSByrblLvjYPs8AqR
X-Gm-Gg: Acq92OEhbOl/0Dv+7kV5B19nXlDla2pHRSrJut87dCWc3Src+/rwDv9H1eotcFnAnMC
	XaZN+/5O2NVHFURY5+0K8quny5LIoIpNtdDaJEb3j3K4rapqfYZ1RyuCEOBuHX94T9n3+Ju/8vd
	OCehox3QUtcwf+O9pk3/QgjEqD/wYfi8n/5JV/KuzzXtmQhW6xH2Dc2gvUtALMhYGpT0FCID/Q+
	Dxb0IYCNKjd4hDgtsIk5yQLh1hBsGobuCSOjEIb6Kryp4nEGaJhraW6Ml5V8fs/1neWCjbDK/N/
	Jmo869BTuI3u8Xq4Naiwtro+Mce1+AEQupmvisIVLF3epYxkCWoqPknm3u+leJ03NHAjdK211J9
	mWXPEve9TOIhd6dy7j6cn8Bsq8ozPc7TLqCUjTayfOaOK3wu7rRsDB1M2UDCtQtaW5Tg0s/QIHi
	+Y8pEg20JmNlcnB9oAPlLhs1eqtUrHr3BMlUXbU9ZAMD4d2iV8KG2pbNF5zb0=
X-Received: by 2002:a5d:584c:0:b0:439:b8b2:fabc with SMTP id ffacd0b85a97d-45e5c587396mr38222091f8f.21.1779297818305;
        Wed, 20 May 2026 10:23:38 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm51125580f8f.26.2026.05.20.10.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:23:37 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Jiri Benc <jbenc@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Perin <matteo.perin@canonical.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2 1/4] net: netlink: fix sending unassigned nsid after assigned one
Date: Wed, 20 May 2026 19:22:35 +0200
Message-ID: <20260520172317.175168-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172317.175168-1-i.maximets@ovn.org>
References: <20260520172317.175168-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the current skb is not shared, it is re-used directly for all the
sockets subscribed to the notification.  If we have remote all-nsid
socket receiving a message first, then the 'nsid_is_set' will be
set to 'true'.  If the nsid is NOT_ASSIGNED for the next socket in
the list, the 'nsid_is_set' will remain 'true' and the negative value
is be delivered to the user space.  All subsequent nsid values will be
delivered as well, since there is no code path that sets the flag
back to 'false'.

Fix that by always dropping the flag to 'false' first.

Fixes: 7212462fa6fd ("netlink: don't send unknown nsid")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/netlink/af_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2aeb0680807d6..0742e97f256e4 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1482,6 +1482,7 @@ static void do_one_broadcast(struct sock *sk,
 		p->skb2 = NULL;
 		goto out;
 	}
+	NETLINK_CB(p->skb2).nsid_is_set = false;
 	NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
 	if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
 		NETLINK_CB(p->skb2).nsid_is_set = true;
-- 
2.53.0

