Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417338;
	b=MR0u5RwKSPW3+DNJSW0ntJeDOYG8ln90cqpGF0ntTU3100tGpLEwTECPIYVVgaQArpBu
	 yZCdmJn2j4dsLn6YtKA3NV00gEZ+TqtXYN2xnl6/cOt9yP3pqOS9p8PJPKP1FbP2szB4H
	 IukD3MtXzjIBNBkv/967MGkdnld30UBk2vOUD5r1O+ZhxZ+KpepwWEHPUxrOezD9MqDsf
	 YKWVCgjLri4wTeN59JMjBEc00nyeAHmnxF4q9LwI76yFSJfBDvte3314uuqofWBxB89LQ
	 aAVkpvDTBlNZLi1F5zgmQScIi05VveQYhFC/sOxT4PLugDVkZarDFkghf5UZ8ISJHaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M808A8cdafbHu3PCH0DvbgfosKGzLw5TjgtHg7aUNV8=;
	b=u8V+XETG9fcyowlgtgF+P2+Zzwf1PJZpHiotUw1m5H+8N4QEv1J91YvWClO/q01gIlUe
	 6gqD+Nj3r7Qr/eG+8x6Etkwp2rdmDMZD5HIWITWL2HZSlUdjD/3VzjAEirv0uy+FSgKcN
	 QQjCrA44/7k9qOU1LHGbghRCYtVrNVZ2GZ0XmXgy2dpUXN+oZaYPka2VjrTO8GlkvmJiA
	 y1IZGVR6nHFhA6fNqMkzzdxM0knWs+Dh5vIEuC0ddJgX/9LcQ/1JU/2MEFyHGWtv+1sN4
	 7tMMZv4JFPkbLcIuO0AZPkxLt5XTA+d3V40OP6jIxSfF+wzUEFFsxOXamOUmKEUeyCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+Fvv+XB;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB0606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 03:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27FB0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+Fvv+XB
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e977109392so9664905ad.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 20:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793417336; x=1794022136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M808A8cdafbHu3PCH0DvbgfosKGzLw5TjgtHg7aUNV8=;
        b=w+Fvv+XBYkX7ai02Vc4XIlsGlhWcFO1aMMn1edEw45FUatWNt4VkrYjSIejMFF+TKL
         qKHtwo/dp9AhCZZp68T2WugeQqe4Br8c/LQqjL96LA9B+OQ1A41kDxt2u/CkpZOoR8D9
         /x4fOMW+VJ2IGluH/ftfC/zGggeJ8pwKdfccmh4Asn7h8ywNlXA/xmslGHDXc9iNoXYC
         hOOTrAM65wlZKq4arnnPdGmQE0XGs7yMuHcRcaZo8Zc57yQbRPa9Yg7cM+F14SEs/4qx
         dPZG7Q2hf/nt/RMxoNTxiYP6vfYz0evdntPFW7G6cfH7LA4BA/UmhK6HdZ8T7kGeYIp5
         5Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417336; x=1794022136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M808A8cdafbHu3PCH0DvbgfosKGzLw5TjgtHg7aUNV8=;
        b=QirjvJcr1JmpynnfHX/DLfry/UIk2KRYieBSv3rHH1egg9DHdsX2u7W8qngtiuj1LN
         eJjjidp6ln3T0gKC5lnKf2v5KpJF6PgcC+aSGGP3QtIzw5WzBsDKzoVodpbD0Jj8VtJO
         tMIouy4OPfqqEAtWCqpdSQiktEf+hzcLwXh665PaTksIglnDD/+RuR9trQf6//izM0EP
         lp2kCObU9uZoh6NK7pbgxD8tSM4IslUUVvgAWePbkkLQJnb/KHv7LJLzluscwTa/Idrk
         rqAPSmlqwFgVThZ1Orz9ZAp42uMCB3dNevCu6cJ04KzgnLF5swa20ooHaypEPhn3EaHy
         DXJA==
X-Forwarded-Encrypted: i=1; AKwUvBxBYuavhof87EOnBVWTIKFD28n7QggY0N8JRtHqTA5z/B5LN/rvSdKaXsI9pjUBm1Rq0I6ZcJ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTv0kj0NONDOOATzPictD/nseEFawT94nQHGfemKhxYTgp5dGH
	BdD3/kIY7tC/AgSI5Y8aglJCeO+CGlo4YUHnui5zoao0QJUUT339K4of
X-Gm-Gg: AYBFou37GvA4p1Grt9GZct+F5TSEpdOggeA1sIQvIpmdtohqrArl7drOjRFD0JetK9w
	6iDC97spFwOpfTNwVn1FfJswnmiFDZeBWckVehIiXTkg1wYFRTVsLORVd0XsbUF/0Qpxj0FR74T
	BwwY9O9oeMxFrqwL4ZHoNGwJZ8EVcNHsuEVXCfaDVoSteuHcVt/q9Xt7Mzqis+gxiLEAKNvGU6S
	sTGrFl97VS5oGsL3EtTU49H96BvXXggQSgbJu1TMV3SZTrEXuQMY7/n9bff22TT4Lxt5e8Dltub
	vyiytU3XvhEIYZCIcIeJusUEJ8Muof3h/nilG7bePgxnSUTXdimF0Xvzfl0DWLxmsvTw/OEWK/6
	FDIkpJt52dG77bc35vEiovkn3YaPaCNZg/GJbd8Khstm0OvIYhHZHbN8bwe3OX49tQrpuPoPDdr
	0IacJaTOl7ksiCCu/THyk2e2sXGP9UkyxyBLJVRAPs84R2x8wliFkQ1mG9dYkJQVc5DbDIQYBd6
	zx2+DCTwdf3aWW/aOYzoju7emxlOy9sqOX8HU6Qd0qG62CVo2jw5zJ0alSY4PAufD63eAVODOy/
	aDwmvant2qHtRVdM6MqhYzsU
X-Received: by 2002:a17:90b:28c7:b0:3ac:83c1:2bd with SMTP id 98e67ed59e1d1-3ae897f33cemr3295046a91.28.1793417336425;
        Fri, 30 Oct 2026 20:28:56 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87ee7765sm3212773a91.2.2026.10.30.20.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:28:56 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	antony.antony@secunet.com,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH ipsec v2 0/2] xfrm: fix offload state use racing with device teardown
Date: Sat, 31 Oct 2026 11:28:47 +0800
Message-Id: <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-0@gmail.com>
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
Content-Transfer-Encoding: 8bit

NETDEV_DOWN and NETDEV_UNREGISTER flush a device's offloaded SAs with
xfrm_dev_state_flush(). It deletes each SA under x->lock and then frees
its offload binding with xfrm_dev_state_free() without that lock: the
driver frees its offload state, xso.dev is cleared and the device
reference is dropped. Netlink requests that hold only a reference to
the SA can still be using the binding after they checked xso.dev:

  1/2 The offload statistics refresh in GETSA, ALLOCSPI replies and SA
      notifications, and in the expiry timer, calls into the driver.
      Refresh the statistics only of SAs that are not dead, under
      x->lock, which orders the refresh with the teardown.

  2/2 XFRM_MSG_MIGRATE_STATE reads the ifindex through xso.dev. Use the
      ifindex cached at attachment, as state dumps already do.

Cen Zhang (2):
  xfrm: protect offload statistics updates from device teardown
  xfrm: use cached offload ifindex when migrating an SA

 net/xfrm/xfrm_state.c |  4 ++--
 net/xfrm/xfrm_user.c  | 14 +++++++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

---
Changes in v2:
- Address the incomplete RCU protection raised by Sashiko:
  https://sashiko.dev/#/patchset/97864
- Patch 1: refresh the statistics under x->lock and only for SAs that are
  not dead, instead of using RCU, which covered neither the driver offload
  state nor the cleared xso.dev; fix the same race in the expiry timer.
- Add patch 2 for the same race in xfrm_do_migrate_state(), also raised by
  Sashiko.
- Trim the crash reports.

Link to v1: https://lore.kernel.org/r/pm-xfrm-core-objects-candidate-0050-v3-dbfb7194ffb750193d02@gmail.com
