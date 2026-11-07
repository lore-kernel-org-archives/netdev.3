Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053830;
	b=N4M6Wzvh6sJLflNVlIy/lSmVHjRnKscNRNn9kTkBTIEBETt4zmkhInDHMeBXFWIi3H4I
	 YjilvUOFG9NZ4xIR1BIHG9m1jcW9WlbzKS9Wd0klKMc016Fib+8Hr3Y1J7vFqDUXAP9Mx
	 o8jhnkksoRI5JsOCfCXByZaUj1W2Jeh8d4FThztPyC+buMr+KM0TUA6QK031d9seTwpEK
	 8NdmUxNhfXFMq5rt2DpH8+WnC5pYlbDlWuApbQVdnBdiTPVYODgYABd83e4Cv6ALlZxeo
	 m72SkjzlyoGVyC2I7Jridu99Yx4pll2YJINhW89s7Zv88tKWjyFDRgo45KcIUJ3bRLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OzZ+my+gF/xrpmdUcbUTj2FL7CyDhVz3E3zrCVn/fRY=;
	b=mNETd13RDbg6XH/3IzNFksT7IqvhGNLdJyG+SiSqu8iOGZ4aCtQKBRZeFIC1LF/7z8aX
	 saoy18q0u31OR2YP4wv8KvxNxBNq1wsN5cNcDMIbdgFkJSEI+l1uaVoVYAgiuZ/Pu0EAC
	 AnqXxm0D2VWvYq9RwSW7/jQplgvoFrsG2z+kJwJ97Z36bR92K2N3jVY0D+UmmgOvfGaz7
	 oAcg3AUMTs/KQn+I/zWKBiWu1BDDNCaM6O4Xv3CdKeByzUJel2KGhvM9S4pMZOLbhuJ/F
	 lt1BVmlXLThWyAM7zsRKND1HjRPwP/4ML6pHZgbFZWF88wqjI3j72hVQErd5FXXR/9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b3J8NaK7;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AA606A32C
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 750AA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b3J8NaK7
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed0890476fso8058485ad.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053830; x=1794658630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OzZ+my+gF/xrpmdUcbUTj2FL7CyDhVz3E3zrCVn/fRY=;
        b=b3J8NaK7zrhtmM0Aa8QCoegX0BxH7a1gG0KzXhIxMGCyoQUh+Rz3dZY72/EscNp2u1
         7BzzBGweO2IaTPfPZhN4qoOUneYgCNBB3xkDdgGrIDBKq734sRcLOD9U6eULBb/TodX+
         ixujhXiLeKQcrvlHIsQT/owX9J7HyI/XBqicJxizdwikj+sSYepZfeSHDp9fxTDbBmPE
         llGwkQDbN71jiuyRigHsSft+4Hdno2wgV/TC4ZqvxX469p6y0D40MaGMvUdAXTZMfMQM
         OsmUPvXO1ky4hjp9znGIJIug8Zs0YSZrveP0W7upYGNWo9Z0gHjRavoIToiVkgT49dOj
         cm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053830; x=1794658630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OzZ+my+gF/xrpmdUcbUTj2FL7CyDhVz3E3zrCVn/fRY=;
        b=tqWqh/fiA3b2DQf13D+3iJgp4TbVF7mOb/3I0y7KMfOCrgGMWWmCzqMV/olWI8Ocyb
         4NX9OeaJqeAkxpER5CUA5thsq3hrHclYaodWmfFpsmErPZcSAH3RGHqwYoNMRtllxsXC
         aOygy3na3OQP45luHM2FSTeOuSgLYXj5RJm66a00RAB6AMiGijbKtWKCwfzuOIeYrl+J
         0qSWPWwXcrGcMbSZzf4toZUYTl9ely28p75K7w/vIBUGPl0ZZEEh8+HE14s/nwnFZjUN
         VdR/FsMYC2lvYrdG79k5l38oj9gh6muIngCXWXHVtPCrU7ziQTGspnDhBvC3f9ikkte1
         xrVg==
X-Gm-Message-State: APuU4Z+A9jg5FYDyygceIi4MP7yQvhkCLBMmic4vKcSjBUePFoWuwW+r
	y1eLCKguHHs8pWJOhXwsS9At+fSbt54VP7vFcMAC/lX4IYebhaOTYm9dAeP8tmAxY/A=
X-Gm-Gg: AYBFou0qX4CS/D4ENq56jomwmWQ0B3U1md54347JdzgKAZjHRBF81G7WOhzNHtuV9/A
	KrEArrAILP3eQ1kYeQbU7WlGKGOGjNJvouCmo6t9XN8qg/JY8Ff0+HfM+tme1/JUrutO/xCzzOh
	X3w3grcawRbCon3cp/lG36R5UmziHjd1Dsfa5cYR2a80z36DrC8YaSB1yZPQSh4S3GHuwbzCnVc
	hWOJDwSzQejWSqmKz1FdrGz4iT44GkkvoWpoeHlqNm9V7O2APnzvDZPwVoGkOKxnxnOkxxmjBNz
	G9+ZzyJaipdnOUtGj3/dTvh7obGrvTIIkVfAw9H8FiNieOD91BL6F0LSiRmoL4b9JpXfcmATGxK
	/xxySGJRmw2aeKbPKzurnW0zV7UDdjsqAGIBZhEbtJLKR55TEOkjYJjV2aHoSggcXR9EFe6f4Xy
	j1oK1GRY8ylrA9q1o+eI7/othPJCeiLC1vEH0COQHvBs3eMGRsW6M6s69m+xI+WeNQa/c8+7NR8
	0U8ddCnuXsoqQGpCzp133iTwy1SHuvSl67nDwqQFFUiIdAWbwy3GGqijYX5jVr/U0vchabHDfsL
	pA5PLG+EHt5enRw9Ysw4Jgw0r3Zj17r2Ch0iGW95jjn0g95Z5+gA1Q==
X-Received: by 2002:a17:902:e5c3:b0:2ea:41ad:e310 with SMTP id d9443c01a7336-2ed40dcd43amr62813255ad.46.1794053829446;
        Sat, 07 Nov 2026 04:17:09 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f35asm12773555ad.49.2026.11.07.04.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:17:08 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/8] net: dsa: motorcomm: Add BR_FLOOD and BR_MCAST_FLOOD support
Date: Sat,  7 Nov 2026 20:16:21 +0800
Message-ID: <20261107121631.1040612-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Offload BR_FLOOD / BR_MCAST_FLOOD to the hardware for bridges when
feasible.

v4:
  - fix VID 0 handling
  - reset port flags on bridge leaving
  - remove local cpu_ports_mask
  - translate FDB VID for VLAN-unaware bridges
  - limit offloading to exactly one bridge
v3: https://lore.kernel.org/r/20261103140109.874443-1-mmyangfl@gmail.com
  - refactor port isolation and filter action for standalone ports
  - recompute flags when a port leaves bridge
  - honor BR_HAIRPIN
v2: https://lore.kernel.org/r/20261011030228.2761810-1-mmyangfl@gmail.com
  - fix build error
v1: https://lore.kernel.org/r/20261009005542.72860-1-mmyangfl@gmail.com

David Yang (8):
  net: dsa: motorcomm: Fix VLAN SVL and learn limit definitions
  net: dsa: motorcomm: Drop VID 0 VLAN table programming
  net: dsa: motorcomm: Reset port flags on bridge leaving
  net: dsa: motorcomm: Remove local cpu_ports_mask
  net: dsa: motorcomm: Isolate all ports during chip setup
  net: dsa: motorcomm: Rely on port isolation for conduit port
  net: dsa: motorcomm: Translate FDB VID for VLAN-unaware bridges
  net: dsa: motorcomm: Support BR_FLOOD and BR_MCAST_FLOOD offloading

 drivers/net/dsa/motorcomm/chip.c | 293 +++++++++++++++++++++----------
 drivers/net/dsa/motorcomm/chip.h |  10 +-
 2 files changed, 208 insertions(+), 95 deletions(-)

-- 
2.53.0

