Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B34973BF
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731822; cv=none; b=qbOsZ6xjuwU6l9ZuSIZ7rPrN+aUm5kTVkM6ahQB/aHka91pOGfX/MJ1D6FF9VOkh6/KuwF7wEO/sB+eJnT1Im4ZLjhdHmPj5LpMQEsUJECqDjnE3garFpKWEJMXu952IFSjlL8eLWr6SK+qOQEuzkrU4xmYxvmRQ19rsAuBkVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731822; c=relaxed/simple;
	bh=SRUumQAnpSXniW/sFyv72eCyMKi1jXmk9Oim8IA3bpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZZBcWHPBMjpVzQ8naz3BG5VzW4tniVdre68InUUk6sUQ+Tfa+ubObg+tMVwdO6Suoa73+v0YhJNHfz0XFj0lwaSHBOzLLrnDd7y4Pu8gVqfAosGuAlnwelcAYWbD+zUz3QILUbPWk5VIDnw5dv4gLhd39lUS0dGsUdOqJNuzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVpiQgRt; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVpiQgRt"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f7so4072555ad.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731820; x=1790336620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/mchxmlE1Z6JjIT7JJbaPsbpmSkFR757IQABr8XiljQ=;
        b=SVpiQgRtq68ATnKe2vHL3UWY+Vb3iZLDqAQdZ+3vE5dSguAlGbK7L7kwIt0XzdFTfv
         5k9jMu600AHPaAt3r8ch4mrvsvl1Lzlo4pdnHw51pTpH17X5AfSOVJfUZsQ8AJMS/Dmn
         4M7MsfDrFZ8J2s4mYk/X/9Y2fOQVGOrQNs0i7VVTeqpwn4k3HOzdof8iQYUptWjV1RQZ
         52V+wvzHhDdonyA3zQtXoUoVq5Jh5JPIK9BXU11jXjnx/x6AAegMkQuYwDuE0sXrhvWp
         n8k9Lp/by+wWOgGkW5S0RgLBQdypBrviumcm280xK7FjUfNEHwBawRf8wX+ClXNXYkpB
         eOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731820; x=1790336620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/mchxmlE1Z6JjIT7JJbaPsbpmSkFR757IQABr8XiljQ=;
        b=gnlXMdca+RGO3/H7MzJM6C7VE5NMuUNWfWKHSiinuDjWxI2E4/0H/gsaY80x1Jla5R
         EptPo/sfCg3gYvoBpVmb6dB4BntowiU1drVxAOnnwv/h/j0I9CKevJk1Ejq93h9JUBl3
         PGqTEr8vhb3/+yYiq93Bm4Z9IJFg89e+3NGTPnWsXxYk0hogljLPGpJcxmlrr6RvJIsJ
         ppkIv8oS6+1ypFPdDU0tG+5pR23Lz2Bz8nCh98JG9vi1CZilJWY2cCe+3oEY423dis4V
         rKyQLAUr+jDgL8WZpvCmlk1ea7Vrg9jFR7CzRbQEKJ9vERVqE2it39IoiQyOvrTU933x
         G92Q==
X-Forwarded-Encrypted: i=1; AKwUvBxEZyX6LyqcGqw+VcVc/pD1wzmOqU1o4ffLICyT4MQ55k68dCzEUitN1D+8wJQHn5G7ngmEvQ8=@vger.kernel.org
X-Gm-Message-State: AFuF++ksSJ6YUS8RN3SbTqifgQj0qYlw0SeODzOrKnt6lG5ck8Fp+K3q
	y9dqjh5SrwSN1pR0OItknjEfEw9MtbTmDv4evOGMuibyZxkwfs1vFTB9FtN0mgBZLUE+qQ==
X-Gm-Gg: AYBFou3Hpvdp/eYCiDlk0KM1MfN/+kX99LslHHqv6/TqLNBHVI77pgXhulthacES8t0
	7llDOhhwGSn+xchNvxL4Hfm7qo98YVdAI6ya+6o8hurHyKH+g8EXABkQzoRO0eLd2H+swTSgisu
	ObYogwHLJydck2VpKIcOcHtdtImT/AKkY5oSmSHZJGRiWzmmiKPCNDPwznyOhxCRPMyqMwOtKPt
	yMBa9QOdcpGroPpB+w99kVVL7qZsmSpMPyUPHhDJf+TuAsQFE/vYdTZxqCPmq+IqdDXEJzuJHrD
	byCB8wYJ0dgN/WqegWoDn3/AmNlSOGlA1xew2GhKTmIyEXyN9YVx8LKzhEiMOk1dIDNqnQg6GWe
	W2FDvkonO20fk0vaBNbMvTV8j5O04f3RgtZEptjRBFYtcqGwU5qMLzA++8UVYu1d4NlXZRD4NHO
	6Na2WpRuab4WA4qUvntnYAC2YClYBo63GyPmvLGVVFXnquntmEHS6sywsZdc0CjDJsAgi9iXbSy
	aRqFuWH2CQ=
X-Received: by 2002:a17:903:3246:b0:2d6:fec3:bd57 with SMTP id d9443c01a7336-2ddb1af3398mr44813025ad.14.1789731819907;
        Fri, 18 Sep 2026 04:43:39 -0700 (PDT)
Received: from 73ebd4c7787b ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c284ac724sm4794739eec.2.2026.09.18.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:43:39 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 0/1] net: netdev-genl: add missing uns-admin-perm flag to BIND_TX
Date: Fri, 18 Sep 2026 19:43:28 +0800
Message-ID: <20260918114329.3659849-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub, Donald, and netdev maintainers,

During static inspection of the netdev generic netlink family and devmem
TCP operations, we noticed an inconsistency in permission checks between
the BIND_RX and BIND_TX operations.

Problem:

The NETDEV_CMD_BIND_RX command requires CAP_NET_ADMIN within the caller's
network namespace (uns-admin-perm in netdev.yaml, mapping to
GENL_UNS_ADMIN_PERM in netdev-genl-gen.c). This ensures that only
privileged processes in the netns can bind DMA-BUFs to network receive
queues.

In contrast, NETDEV_CMD_BIND_TX was specified without any permission
flags in Documentation/netlink/specs/netdev.yaml. Consequently, the
generated C code in net/core/netdev-genl-gen.c only sets GENL_CMD_CAP_DO,
and netdev_nl_bind_tx_doit() performs no capability checks.

This allows any unprivileged local process to issue NETDEV_CMD_BIND_TX
requests to attach arbitrary DMA-BUFs as netmem TX buffers on any device
with netmem TX support, bypassing network namespace access controls.

Note that upstream deliberately relaxed bind-rx to uns-admin-perm for
non-init user namespaces in commit e302aa3d ("net: devmem: allow
bind-rx from non-init user namespaces"), while bind-tx was added in
commit 8802087d20c0 ("net: devmem: TCP tx netlink api") without any
permission flag.  This looks like an oversight in the TX API.

Fix:

Add flags: [uns-admin-perm] to the bind-tx definition in netdev.yaml,
and update netdev-genl-gen.c with GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
aligning BIND_TX with the permission model of BIND_RX.

Best regards,
Yuchao Zhang

Yuchao Zhang (1):
  net: netdev-genl: add missing uns-admin-perm flag to BIND_TX operation

 Documentation/netlink/specs/netdev.yaml | 1 +
 net/core/netdev-genl-gen.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.53.0

