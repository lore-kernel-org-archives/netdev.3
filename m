Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592386;
	b=jN6Wrp88ZGpw6YdhAqDBLCwU9dyMqzYzBNdGqY2NvtMokV8KCBGEgH6BhdEll48LIU0v
	 PW2GOycXorL/Wjuc4/zrp8gHCbFz3rJtVm5bg09Kby2s+QRhlsQx7FQAyCPQ8aGwcdra7
	 kG9GHsGOOBGv/txs6SrFt4EdMqWLfrOZTZJ7N2gEtlEBmyU0aUvRxfUIgcwuljpmRLIRq
	 8BOtk0p+kCO/UtorBhr7NCy9IU8Ndqtr+sos4tqXp/Rm/l1kvhwlR4c8zAV2B1ux0af73
	 TKwfeflCL+t764DBVITe7YZyysA+Bm/FyWWv39FxhNyZ8hctjJAEsG/+/FnNLb0Tx5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=xZE1hno674x2taHCO5d6NjAT9iH9OyhYJiZL+LV6wH4=;
	b=zhN9r4qi0dRuGinSILjrWEJwU8WNT16NnHkFZ3N/0BdrDVB9r+Ban5qFgJqC9FEmAZyf
	 TjhdSrmVHUGarBNo87njjsHAieMaVtMr9t4MjJTTxHBy8iMEWCZqiQk8pfzfXDPkaoGuO
	 uAdqtsMlCRsQPCToz+lFg5WVnyq5Pe+V5BJz/icU+rrnSDzroFJclotFEyzYwwWpzdRyS
	 JU+QqEPS7BuWMZTA6vu3k6bo09rNwQMD0in4dgHxlb8G6H3gFWcovOZlVJnI7J+hoV7yx
	 A94PDqdHEahQvBXynfm3RUtYpzSWePgHjQOlYGs+H6Ky9/iUR416f6L832zALzpKK6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iTkWpyyc;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5AF606A328
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E5AF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iTkWpyyc
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1b0168fafso973065e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592385; x=1793197185; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xZE1hno674x2taHCO5d6NjAT9iH9OyhYJiZL+LV6wH4=;
        b=iTkWpyyc/EjfBErstsZseyJuQgR+H5M3FT/BnZZoAAAhQTUda00m0YXs10NTKhcm/e
         UfqiycjE+MTIImowm1JutrP42yeP6hf5dcSmH0SerVFExLtSHMNFIDibbsl9NLgTQrZ9
         WKLKcp5Fvk/+cQX1dSFIGSO+ChLs2HhW1WPuqDU8dq2IxhfxcKNkZ39D5z23mkcLx1VO
         8NA3CTEHz7uzUFF6SnzDXzE7C3s1L4UxpBsJmJqtsPYtJ5i1qBuVZTBN8lystUiPd711
         UmDFtojJ5tgC3ZTGrZMlXU53NAo9w3iecR93uNWiU/hAyJ64TWIOc8V7VtMh3Cg3S6vh
         SqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592385; x=1793197185;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xZE1hno674x2taHCO5d6NjAT9iH9OyhYJiZL+LV6wH4=;
        b=eX5cCfuROIha8cLFwlMn9Sll7wUSPeLI5+cwZGHb3St0SJMewX6UtOV3xcTj4Yg8ql
         JpuaTcOU/V6gF1Lors/AIE39XB2s5GPViKUTOHeyCTEbs2l8zzaEmdjQWXvHCQToDb9R
         Popgx7MTVgvmvHVkQchk9ARa4dFm0FUruiiHh32eJFOH51jkh1CGKt45YHV0uZVkLHaz
         mgW7jVnIOzG2/+azpkOV2kAHtq60Q8gB3f5vC32lkn1+kAsQCetgqs/j/Rj2sQPJqgDl
         dRQqmnL0j/lr/CeXad21HeJzDLhPwpTWZUF3jR58qtutTm3OX3fb8gGQxMc5UvUzCkkN
         8rFw==
X-Forwarded-Encrypted: i=1; AKwUvBw4Qrpukyskg+sleDNIOGilKvJc5iD8ZAImsYQPH0EYjbOWTvbaolF/C44TD1GAD1co3XAJHAU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNYvSVhGok4S1NBqAx9Y43zc0ku7f+nrI8C6v4SSJqoBxwFRrt
	+3+ON0sH+suKr2TokaAwO6cvVIyBAIiEfPuFmCNyW8m+wNNG1+42mBKF
X-Gm-Gg: AYBFou0Rq3fDJn7vB2SxBWLzK7Ix07rB7ItAJPBPo0D3+oAWfmVFF/vYBcCH8ApOM/y
	wiA5fwsFrWQLVRYpGPay11637qUDUsNtlyVFHeJr+6TR6Kqz3arNE6qONbUCJAReqQLf53J7X1G
	5nA0fOlvW6xnIfok8SuYxxwc7LR0AOrqBRXIkKwK4HcnGAntI/RIl+ue0EQ2v/uP9p6IkLgZ8Dh
	A26nJj++T6ye+48LEVrLuLs6gg4hGkXdAsfXgBNF4ummxxnugA1Qai8ZKcWr+yFbcEzBj5W+/mB
	gdn6WueO5hvcQOk4TxrL9YcOWAWxBKJv2e07waJtuADtCyFRHem5qMaRHIeKum1QpJUdv1kEKXR
	togu7427LBPk7suwtxrA81t1gXEdJgJWcCap3BQVVrbpIf36pP8va5/YoHFLkjlRuJWfK6l4zk7
	WWFmGOgiQsr0q7rm4GghPRaBre44MCPxirtnGBPyaxv6vXU7+K+JoxNY6SZlUC8qL4QlsD+RwTn
	IoZVMX8+U27LBi6D1gS1bm8zeNokKzxjlkj4mxZjXGUVQo1wFT+I3b1
X-Received: by 2002:a05:600c:3e87:b0:4a1:d899:b633 with SMTP id 5b1f17b1804b1-4a1fdae0e9cmr45391125e9.1.1792592384342;
        Wed, 21 Oct 2026 07:19:44 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1d:5d00:1a26:c015:c64b:f840])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a201d7ac99sm19837805e9.9.2026.10.21.07.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:19:43 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net v4 0/3] netconsole: fix target enable race and configfs
 read locking
Date: Wed, 21 Oct 2026 15:19:04 +0100
Message-Id: <20261021-netcons-fixes-v4-0-3857120c6340@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNTQ6CMBAF4KuQrq3pD1PBlfcwLtoyQI0UQ5FoC
 He3oDEElzPzvnkjCdg5DOSYjKTDwQXX+jiku4TYWvsKqSviTAQTiuUCqMfetj7Q0j0x0FxqiTy
 VQhkg0dw7XA6RnEmMkstnGR7mirafP82x2oW+7V5L68CX8Lcg2xQMnDJqDJQlAqo806eq0e62t
 22z/B7ET3PG1FaLqK1WIAqAskj/tFxpLrZaRs21thlgcVAK1nqapjehKyJlPQEAAA==
X-Change-ID: 20260925-netcons-fixes-93a3e14326b5
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

While looking into the sashiko report about local_ip_show() and
remote_ip_show() missing proper locking [1], I noticed a couple other
places that need locking:

Patch 1 fixes a null-ptr-deref when enabling a target races against a
NETDEV_UNREGISTER event.

Patch 2 fixes a use-after-free when the local_mac_show() callback
races against a NETDEV_UNREGISTER event.

Patch 3 fixes yet another race, in netcons_netpoll_setup(), where
netconsole could miss the NETDEV_UNREGISTER notification and keep
holding a reference to an unregistered device.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Changes in v4:
- Add patch 3: netconsole: fix target enable race and configfs read locking.
- Link to v3: https://patch.msgid.link/20261012-netcons-fixes-v3-0-1aac85ed7665@gmail.com

Changes in v3:
- Use target_list_lock instead of RTNL in local_mac_show.
- Link to v2: https://patch.msgid.link/20261006-netcons-fixes-v2-0-ca652d55fd4a@gmail.com

Changes in v2:
- Resending for the 'net' tree.
- Link to v1: https://patch.msgid.link/20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com

To: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Gustavo Luiz Duarte (3):
      netconsole: finish enabling the target before releasing RTNL
      netconsole: read np.dev under target_list_lock in local_mac_show()
      netconsole: recheck device registration after waiting for carrier

 drivers/net/netconsole.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)
---
base-commit: abeacca61eea4f6803df4a595b656ea45c2d3249
change-id: 20260925-netcons-fixes-93a3e14326b5

Best regards,
--  
Gustavo Luiz Duarte <gustavold@gmail.com>

