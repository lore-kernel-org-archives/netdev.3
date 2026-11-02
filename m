Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649306;
	b=zbYFjfGP4+JdfsjBJpjlMAYfl+kKChrMcG9he9BHVB75yLqaH6gLyBMt/nYpxAxkGgEb
	 sNe9nPJZpXKPBouJSWRbNAXft7thh/Wf5aGD5G5wbD4KX03ROmTKCWMmBLdsRiLppRYDs
	 xX8TfipOPVhQEYxvgw9IMxtWEWkvNIfjBREFu78Rq54nfYvpNgRAu1ywwLf9qLJICybU8
	 KSYlxZRZjJeml9qASR037wU2ydAq5qcjmeRgxgB9WuhPO8X4EjFTNGMzxbemZ/kGMkcvP
	 c60P3TdoBiGO7NX7yTR/s7WikssJ95sgx1Wul+IFknsHXB7wSxjB2Uv3LKZ/u6eShXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=2rjL+KHDROa2tYJf5SaQLKL0slmT+VtmFOvPhR55jiM=;
	b=S6sHDjj+bwRrJpW6yqk5bd9wY+WOeJTKlKCAFHxGSGuPTeDog7NZIr6SHtwNyp+GadX9
	 zyykx3K59M9htTETDItx0t9k2w8UUODE8LaUiVL1/tuP7CdFiPgSE4LTvz0AM/hhGLnsw
	 lAiknbV/cOPV+JHaU/5vn7h2PpT/WKZYObRO8vL+xvjtplgBTqpfJtYB92maPy+J/3tDl
	 J1JrOmXKPxzAT/kchLA1PPR27oaOHlzfMdNL+8nVWP3nh5c3PKRM5M9FXzzWZwNTBnV5p
	 d3ZrVMVXc9n6Z7+dUiKTtPGswYVma1rCzGC+tK1q+YHfvgkDaC5t9NI2QjN5DpCe9Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZMW7CrU;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECA5606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECA5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZMW7CrU
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso14253135e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649304; x=1794254104; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2rjL+KHDROa2tYJf5SaQLKL0slmT+VtmFOvPhR55jiM=;
        b=CZMW7CrUmrF93/sElpC2szy9tCLdqI+uBY7Xivbb4Vv++HTp3FgWTB+2C/6aheNeXD
         GKFSijLFdFVHXDDWOL5Nz8wvt2OJn9U7pBzyOzTcNv/0tzbwjCRd3gWi/FpbjH3Q0ufv
         IiItIyO1GnCc63hXSXW3ttDQm+TlyLADC/TcNFaoh90jfZUm/AAow9G1+1W36GOjKRSL
         qZb6vw93EmV5Hqj0+66TCbcBBD0A4OjPw9qjpRRi0w26yf5iHyrAj2EIKa5oFnmea/7V
         7wlgMTFwna9bT6Ccw8rBRfg2q9Xr/Oy17uSOpM3OMwl1Wf9kMf+t6fy7k+i6paFudqfV
         rzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649304; x=1794254104;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2rjL+KHDROa2tYJf5SaQLKL0slmT+VtmFOvPhR55jiM=;
        b=xACXjAaS9DWUwvmsPOzKAMxdGx/4BMQXJT4uj0O9E2pA15viw44yIvb6ZiYqO+z+xz
         QAV3mwOFun2TsVLPQpEWmw/CTCiPS7H4kaCqrLc+v9GWTMe8MLO/RfafJa4A7o53bWf7
         Ze4DIo3Rl0gY3XSgpcpDxKx3OPLg2QaX/I1ppL+NhpqnDg7fgFtkGz1Q9G2GciuCTcR7
         ZGpxixogouNY+hY4f22+YdapEYdvUWvpqiH08ioOO39VlbHVcxheRZlkNQa49o4dNPjT
         iSjZ7vff6lznf+tkA0A4Oflzr2OJfGKVmlU0R4IyRpahjBg6lVl9GYyk/U/Y3577UKmy
         MErw==
X-Forwarded-Encrypted: i=1; AKwUvBwiKdJy+USl9WoZsamTEqHim+CQfzhTmrJulY98W3K5JVefUS7nVtT6fw30p2H+/EXUY4cap+0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN5bgU2cyacr5UNDxwEhUzeMqQT/Lwrl+Gr7oD9NGg2ricrzKs
	xBFh6D9OyRMU8XzWfQFcRg25bpADnEP/WmNTJrjDzsySVtzdc0A3as/O
X-Gm-Gg: AYBFou3xGeIfsly9N/ZFmTBQ1p/3u+UkUbLCRFsTHhlLPdl06bqx+5+qhzDicrYnNOe
	3NMrWXKi8aBu0tBXhDVtj6BAAiNjy8bTkhxO7o2f1EWSv7M920x88Zx2TQ4QPtQZT6X+6Mypx/z
	MEuz2ewvjFdVsuPnXID0uY2JsCUCMdaSM9fxFJsoHXu+h//uyC6hvJGmVOSoF0CQ5ecuJmRWluf
	rbuGUCeE/Jul77B0AkmE9wNm3gsrU2BndOpAFy3RSxEQi5H8rkcMpcu7FGLPcOlK2GseX4oZatL
	wgf2LptbgrczZHAyTYrK3VDFGYtA373E7L3ZEfuzfKE6X0MPtzjH8H1wq5BuqOpm4wRlyfsjCMd
	QZd+qT6X73Fituzs1gcD/iuxKNk6AWrjAWL2PxdEqxkLQfzkMxjXno1OaHYrKh8PgqvJnoFuRHt
	w9BxQp+QQohQ5uDyw6P0SXY25Ty4KGi69NTKMnppTexSXV64JSToyFdUDkNoe6oYTgKATcgPTj1
	Kmdmu65TYYFJURyUVq/UZyOwKb3hWcE6QwhpCKjGio6XQn+FWOoPnWTjBSQ3aT4qr2EXTyKdpU3
	64MFfcVeU7E=
X-Received: by 2002:a05:600c:c08c:b0:4a0:1e9f:64f6 with SMTP id 5b1f17b1804b1-4ac12193b17mr206341205e9.0.1793649303477;
        Mon, 02 Nov 2026 11:55:03 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:f93e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abea533a1esm199719785e9.1.2026.11.02.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:02 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net v5 0/4] netconsole: fix target enable race and configfs
 read locking
Date: Mon, 02 Nov 2026 19:54:48 +0000
Message-Id: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNwQ6CMAwG4FcxOzuzdesAT76H8TBGkRkFw5BoD
 O/uRGPIPLb9v/5PFqj3FNh29WQ9jT74ro0DrlfMNbY9EvdVnBkIMKIA5C0NrmsDr/2dAi+UVSS
 1AlMii+ba03yIZM9ilB0+y3ArT+SG96d3rPFh6PrH3DrKOfwtyJOCUXLByxLrmpBMkdvd8WL9e
 eO6y/x7hJ+WQphUQ9TOGoQKsa70n1YLLSHVKmpprcuRqswYTLVeaJCp1lGrHDMJwhmlxVJP0/Q
 CDIK5unsBAAA=
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
Changes in v5:
- Add patch 4: netconsole: stop waiting for carrier once the device is unregistered.
- Link to v4: https://patch.msgid.link/20261021-netcons-fixes-v4-0-3857120c6340@gmail.com

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
Gustavo Luiz Duarte (4):
      netconsole: finish enabling the target before releasing RTNL
      netconsole: read np.dev under target_list_lock in local_mac_show()
      netconsole: recheck device registration after waiting for carrier
      netconsole: stop waiting for carrier once the device is unregistered

 drivers/net/netconsole.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)
---
base-commit: 7308ef8b4a6779a39f68d053c19b53a5c584a663
change-id: 20260925-netcons-fixes-93a3e14326b5

Best regards,
--  
Gustavo Luiz Duarte <gustavold@gmail.com>

