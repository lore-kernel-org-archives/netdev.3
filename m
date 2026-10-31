Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417347;
	b=RBubTeyo8aVGM68Lg8gDfz1n3p7fU0Ju/JVoyBizyOWTLuR8VihkqBKlZKGnlBUiJEeO
	 tVLWYfxLzFXzOryOe4Wmx3vN/KlCLwYh5Ah0JLX5HutbAoulpVBwiGzJbqbQGxYwrk2xI
	 zlSCgZib0SeCz+6JbosUegLD5Z+hqK4iF/f7wgZeHUT/1wjRJHmoXLaRHvQrlKtfVMPeD
	 zeXcdtSZ4CTUBhL9gJLVoMoWUqIKI36TZ7Kmp1pHmjblEP8J/pBYTq12IR1PBJNTZaNn4
	 jqYNMf4fho0R9eAaxRCFN188RgUKO96yaMrM+PC8uxmrsn1QbxtOfBaFBJdDBrRqi/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VOq7ZgXUCXWxUh5Tbv14sjkPSXL9OgmAdnHY1/BKfeE=;
	b=lh/8G7vZeHvBJG+TYUXwCBnM8bc+mshJDgpf9PVmR9X7Xhwg+pLVOhhu1qKH51s+EbIX
	 awnr7+/+7B9bTMvgKgVljrS7swclmdFmiF5BROQ0p6FGosB5NjmiwREoQTT4MIemDzHx6
	 gYW3OAio8SMCSJIjpDLC8eNBN9IpRuoQipEw3x2LYuCyM4l3yNdURqYwU0OeSiTw2MtAq
	 Z9aQk155gufE3KBn5YoIiPNspjK2nU7f0bztAt8YKqSiU4LZ4UBjgLwZe93cnsI0wGbyb
	 2HSlypVwGGucmCwxLZiiwUPzfOhDTEjQTWH1SOUAaKKxnosMOdpy1w4TnsTdpSVOwPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s0Nwc50X;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F4606A31E
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 03:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 222F4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s0Nwc50X
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd3310348d2so1087512a12.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 20:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793417346; x=1794022146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOq7ZgXUCXWxUh5Tbv14sjkPSXL9OgmAdnHY1/BKfeE=;
        b=s0Nwc50X8TuoMH3sQVIthhvnvDSYX/A99zFYV4ARkAP/govku/xTJxlFZE5SrI1xgZ
         Le013SMoPW0IDL+liS9OH75Xu4ALVIxsFRF0YLLIk7L9skI1u/0SGZe2aJ6g11dzoZnM
         mWhKHzFZMtpluBP1IBPYYFMMvLUDxUn1PPEy97Zf/tUhQtsDqoNALLfTPBLVlGVoJ6px
         D7xdUT+V/sw64nXuBmZ9ZWtTpEwNDP2VnBkED99mWMSxamrZ7CXoJqGZRfLW73NL6Rwf
         Qtx/IfuEMx1ZzMRyeUKdaf9fGhcEeRlxvzf9WqchM/dNrTReWClerAte2h2YYhSkvmQw
         Pb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417346; x=1794022146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VOq7ZgXUCXWxUh5Tbv14sjkPSXL9OgmAdnHY1/BKfeE=;
        b=lgBgxFJlAXj3y6TIOrhhH7m5Bjzg0LBHk0tQmTaMjgCQ+V3ZO6qaKO3WjBXc8vGj8w
         YeijyrXoRDtR0z9VqRSEduageml7YqIUtKdXFQvtIdNbc4W0pOvgG37KOlbzNlBj8/5H
         9ip2tYy9oCiIYcsWRYDYHU62cUfuik70DGLdOweh4QftAp+K24ChUikUXoeXDCOWOIEq
         l+asBrpdtpYGzDRpWTaLyeL673veY8HXldR6wYG6QXeLUclmFzJJJCUYTTHz9tRKdsHx
         O0vqYP0/0gTQEsk2F+uqqVv/Ylcp0u4JRXzDYOHCrEeR9jj7c4mF/6fpEcD8xLv+o+I+
         UR8w==
X-Forwarded-Encrypted: i=1; AKwUvBxxqtzcPZFdmIkr0I8OhTAoP0UUgqeYPYwBBjsxS790fFSERhXJl71HygE5Wpiwcp6rEpnGc/Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2xzMLz0Zr/oV7pqQ466nyan2yupyJ/E7/UomyJ5Ai8AE1Aj+W
	Bto+G2Oo3uwhJY5tu3rvbGVl+N526M17on/RzZdjPBX+VTRyZ9LBtZ2P
X-Gm-Gg: AYBFou1kS2Ml3q6TtBOCdz6nIPj9W6AYHqjV29IXrsYdCCg2oZ7i4kBdUaHIERq7D6F
	VP0GM+/7gx1Q7yLTzvNKuCy5hikCSal05NWObU5bibXMKSgQRi9NCexNFe2nVSJuDPm1s+77Cgw
	DpuEinaN3s/d84QPxps3XPys9dFyI58FYAumZCtShejvQvY48raSpMSBGb3tahPWWT4GbWqrwFm
	O7q3Cm/g5RrFZbhXBQPto2B95RIrQ1jjcGvQnl4DvXqvgq4KIlpae0yGB9rMeAniLZSB71rOKI6
	e8/yL8QjVl+fwdm6S5h3QQFsrJ2Sych+AyufL4OuqGO9gVo9vX4ySX3hjG7fjEqG8mgdJ6/sAJe
	DhL//qz6wzELrJP896JOs87gU7gpSYIyhewTkCMy7aR/u/f6Q3PoEJl31iXirgPnMx+0zJT8JNh
	Avq90+MZjR+n9W3ui50Ni4dwUTHQGBrjDfaFlPaLsqi9g78TZX0yOt/rIKejT9ugT+9jPyq2PRV
	IGU5/LGRtco+tw92ukPYrf37Cohz8+v08Gz+Ss5NCYgtqPOiCECMt7QqaOo3dQtAcBFuwFEtXGr
	4ifcSFCNK9ix+PgOBG6PFwcKgNTEufxVYS8Ha1RuwD+mpg==
X-Received: by 2002:a17:90b:564e:b0:3ab:b764:8256 with SMTP id 98e67ed59e1d1-3ae897276a1mr2527847a91.17.1793417346367;
        Fri, 30 Oct 2026 20:29:06 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87ee7765sm3212773a91.2.2026.10.30.20.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:29:06 -0700 (PDT)
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
Subject: [PATCH ipsec v2 2/2] xfrm: use cached offload ifindex when migrating an SA
Date: Sat, 31 Oct 2026 11:28:49 +0800
Message-Id: <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-0@gmail.com>
References: <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-0@gmail.com>
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

An xfrm_state reference keeps its offload record alive, but does not
prevent xfrm_dev_state_free() from clearing xso.dev and dropping the
device reference. xfrm_do_migrate_state() checks xso.dev before
xso_to_xuo() dereferences it to obtain the offload ifindex.

With XFRM offload and migration enabled, XFRM_MSG_MIGRATE_STATE inherits
the old SA's offload configuration if the request omits
XFRMA_OFFLOAD_DEV and does not set XFRM_MIGRATE_STATE_CLEAR_OFFLOAD.
Device unregister can flush that SA between the check and the read.
The supplied report used a scheduling probe to delay migration in this
interval while in-tree netdevsim was removed through sysfs.

    Migration (xfrm_cfg_mutex)       Device unregister (RTNL)
    xfrm_state_lookup(): hold x
    test x->xso.dev != NULL
                                    xfrm_dev_state_flush()
                                      xfrm_state_delete(x)
                                      xfrm_dev_state_free(x)
                                        xso->dev = NULL
                                        netdev_put(dev)
    xso_to_xuo(&x->xso, &xuo)
      xso->dev->ifindex: NULL deref

The netlink configuration mutex does not serialize with the notifier,
and migration takes the state lock only after this read. The result is
a NULL pointer dereference even though migration still holds the SA.

Use the ifindex cached in the offload record at attachment, as state
dumps already do. The SA reference protects this snapshot throughout
the read, so serialization no longer depends on the device lifetime.
Annotate the binding check with READ_ONCE() to match the concurrent
WRITE_ONCE() in xfrm_dev_state_free().

Oops report as below:

    Oops: general protection fault, probably for non-canonical address
    0xdffffc000000001c: 0000 [#1] SMP KASAN NOPTI
    KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
    RIP: 0010:xfrm_do_migrate_state+0x1f06/0x2c50
    Call Trace:
     <TASK>
     xfrm_user_rcv_msg+0x3b3/0xc20
     netlink_rcv_skb+0x133/0x390
     xfrm_netlink_rcv+0x76/0x90
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
     </TASK>

Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Assisted-by: LLM

 net/xfrm/xfrm_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 781d4ec565aa..1cea24380797 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1240,7 +1240,7 @@ static void xso_to_xuo_ifindex(const struct xfrm_dev_offload *xso, int ifindex,
 static void xso_to_xuo(const struct xfrm_dev_offload *xso,
 		       struct xfrm_user_offload *xuo)
 {
-	xso_to_xuo_ifindex(xso, xso->dev->ifindex, xuo);
+	xso_to_xuo_ifindex(xso, READ_ONCE(xso->ifindex), xuo);
 }
 #endif
 
@@ -3462,7 +3462,7 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 	} else {
 		bool inherit_offload = !(um->flags & XFRM_MIGRATE_STATE_CLEAR_OFFLOAD);
 
-		if (inherit_offload && x->xso.dev) {
+		if (inherit_offload && READ_ONCE(x->xso.dev)) {
 			xso_to_xuo(&x->xso, &xuo);
 			m.xuo = &xuo;
 		}
