Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660607;
	b=RcSrLB96PZmV4+LWkqutBVxWzF9HHMnZsADcLce3JOZOofDgRui75mLXVjSwVXWBM4ID
	 4p4FF90s5LNoQWm3Labn8/m2rdwmXz49h51hYCR05kyH6shiUhybmTiCVT+b6me+jafa8
	 k6ca7SwQ2zsa+UFZdpunuIHd47dSHBEfbq6YTzaZnd3gamz6INyqnJMJ2SvM34GLTI+se
	 m+78acBfZpriV/QYmXr+NRaeR5+oLGYznHYwfoAYF55Y7gcTni8TRuCfQEjTyKTvnwZWG
	 gpYXqz5an4U3G4hF/LMgdkaVoEdhfe82fE/h6dJ2JnvdmhfXiW90hKEoF6aa1Qlh5BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Pv1Dk4E92+Y81x316CmYEZVjvBF08c29+bZvlM2Ctvc=;
	b=kmPlgw4ILAZBonsuqDYQxjaK5A3JdObQHywgHBhFZALrrgpWxayhR1bzV7olLKxAhqXq
	 o06nlYuwO3SbfnT1roP6lXwLrWyrhbOG514B9w/+qrFQ66E2xvtdxzFeuFvxd6/7HkqAb
	 p9bzp7AucW75Qctei4Pd3cKhAhcWk17gIRcg0rmONNGvvigqFGWqDzJONekUCj5xbQBbC
	 ENzsKkxcK1hTTL5djpBKYEdTdeWarXoReZZ2CGqxHq2e5VBAB6ng9L5b5VH92lu/BsR3x
	 Yfs2CcIJyF8312xrsz9fRDM2W2gE706Y7Vu+F8Chqx3gavgH+fjaX9zNZxK3jalrzUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oBDig0Gy;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84013606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84013606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oBDig0Gy
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so1587638c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660607; x=1793265407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pv1Dk4E92+Y81x316CmYEZVjvBF08c29+bZvlM2Ctvc=;
        b=oBDig0GyceFjeMjouhbaHdVz8glcE6nwPqlqfYYJQ9xnRX4ItsNi/O6LX+JHJ1mQcx
         38oPo9ZYyKHz/xkZTQjWD4+ZwFoFqbAgkskL4gShySEx4wGghy8XJg30/AxIPEC17LKC
         5dxPb9CjKF0L5WvLc71m19Jf3zxSj47ztTndtkF8udzBk6tCcEIgxoOVwe4yHWoosQTx
         PK2X43kI/Nqh0POmwy758utryhdmqzJd+ronRlbF1sBE7bzZ5HAIvOS4gpuhPDydM8WP
         vgVt55TO6Lv1ucxLKvKjrxPbbw6d1FrQQDkCtV6287BBr1lMs8WmnW/ctxoPLaZNrGsO
         hZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660607; x=1793265407;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pv1Dk4E92+Y81x316CmYEZVjvBF08c29+bZvlM2Ctvc=;
        b=Avr8bBW2TwX7gohUCDK+SgHNdnparBm4kRHaw+9tGnNmV4Byr/pmwOH+ugIAG6IaOa
         xBSmr8XjFrqXKFA8BPwruvDQW1NuCfk4yIxl+k6MCd9URqVRH7H1jq3ax0RJrCI8AS/L
         cLRZGKL6LIBB37Y/9LeFih6yFoMBzD/rxZxeDRKxM6fQgbjJN5DJFFG5z8HsCQMLdA0j
         M+SZUBE8ofdzorZuFyy0wzuHfsAblWpheoGm5bilRq6xcDKNrYm9Jxtd+UNk7ChT7Fao
         u0052e/u0uLeaCRepBS7ge7ldtP0GjV/yTvbG6XXxnFViNN4AtJ46LXJSYzcwHt97VFD
         4Nww==
X-Forwarded-Encrypted: i=1; AKwUvBzqB0kHzFY4du6yNoEn/h0Zk+H8kgdaNPnzrPCQODCqOCtD7vNxvt4mEOrKyN7PLDxdNp1uW+s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLs2M3cRD6mDILC/2VYp5zFOttQk3jVkWYsLtHOyVa7OgD+Xa8w
	Air3Jdu+kOAy6OK8GY+D3AJix9XMY8SnSrMrphITI2ipBwVT0deyn6lZ
X-Gm-Gg: AYBFou2E+aiy5lUYNfQ0EnUNg4QSCjSl9C/IDppcPjK59NDRec6h3qHJ4pBGHb6nyFC
	KBHEn07qQBl1Do3wVQHp9G8NDD/95mCVhkCJiipVztCD7Kvl+/cy5dGJxJkZBNZ+k1P2pvepXk3
	Tppc5d2ZdWCQCbgi5noLyv6sKGqCRcTclFwQlBSXdqZf6gdsTdpeQ0b2cQHBD+2WriYRLdbR4SV
	Se5/1IlpZ67Y8n5KRXFDrL8Ae9y3qQDJjE4Xh0/WU2+4RwiLiChqRWeKxH2bWpf0LPYlxRzclpi
	HlqXJJULTz7Ylx/pkhqr/q+ovxOOh6vV6E+yLy91opwRqPItf1W7rytyb4esBK/zwtcHqPRnTtR
	3sA1pJWoffteD1yaWuQt6A4v/8WKhTtRa70hxlITHGLyvsqH4qJkNmtBCvhEJcom82y031vFN/q
	k991g4nlVb7M/ZTIAqt8TlXerfR5vORGfLGS/kGLHk+nQWxIVkirmLHf2Orz3vq4TLiClYtdu3Y
	d/TN7J2+bCOhoJxWyfJ7LwNEHrDQZnNwYDl1qDNBoEEBSWQXj8PCd1GelvX+caqc0pSVPAiGzeW
	ws03vxhFgoH/0Zwt/6k=
X-Received: by 2002:a05:701a:ca01:b0:149:50cb:2175 with SMTP id a92af1059eb24-190a67f9f1fmr6394878c88.33.1792660606730;
        Thu, 22 Oct 2026 02:16:46 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d61csm13188815c88.15.2026.10.22.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:16:46 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: tunnel ID zero works on ingress but not egress
Date: Thu, 22 Oct 2026 02:16:40 -0700
Message-Id: <20261022091640.3652180-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

__vlan_tunnel_info_add() accepts tunnel ID 0, creates a valid
tunnel_dst, and inserts the VLAN into the tunnel hash with key 0.
Ingress looks up key 0 and retags the frame.

The egress path treats tunnel_id == 0 as "not configured" and returns
before installing tunnel metadata.  The same mapping therefore works in
one direction and is inert in the other, while RTM_GETLINK reports it
as present.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1:

  VID 100 -> tunnel id 0:
    ingress VNI 0 is retagged to VID 100
    egress emits VID 100 tagged but installs no VXLAN metadata

  remap VID 100 -> tunnel id 3000:
    egress immediately produces VNI 3000

Two independent cold boots produced the same result.

Either reject tunnel ID 0 as reserved or stop using zero as the egress
presence sentinel and make ingress and egress interpret the mapping
consistently.

This is distinct from candidate BR-063's netlink-size undercount for a
tid-zero entry, which has a pending sizing patch.

I found no matching functional fix or CVE.

The self-contained PoC and both console logs are available on request.

This was found with a multi-agent workflow; the
ingress/egress asymmetry was reproduced in QEMU.

Thanks,
Cheng Yongkang
