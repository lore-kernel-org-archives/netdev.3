Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF943F5BFC
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965643; cv=none; b=VV6hK8Kf+oDv0Haisv1cbJ68FqW64WfWv5lyVqeJBiTAATTTk8f11ndp/oXQ9ovqPU/k11aMWTEiwP6k0FY4W4YX03rgG4osNWLXZNIEOAI2xD0PczZ4RNgWM9r51lKKoft5hVmf4t103qoq9GkECn+U2vQnkBP1Erq9wsYFkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965643; c=relaxed/simple;
	bh=3h1H6/5bkUMyJ+rgH68Twa/JWbPZ0mMggnwjy3rrOhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kwkzu1efOCadLTkLb3fw7zyvCfIonsEKqtMx4tJbIp1RWypZSwrnH8TWvcERxlEB9IIoUkU4swqpcH2v1fWetUreDd9sLaI95YWxD0WDNdvp96VrL0txpHXMB3mFYEiXo9AmFujeXb38Q1EFxHrmyVpGo8qcIlfwcFsYSiybKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9mNpbWJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9mNpbWJ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69a1c7ce59dso210853a12.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965638; x=1786570438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wIL+DgBYUTpJ57QMSvObczLCrJeLPUMZswlx2+I7z/I=;
        b=I9mNpbWJylgedLjOHFA8Ns+GDzFGoiMFD/XbBCLTFAvcSELZuiAqQNRSxm6N7ixjYR
         UKQEainfKSNvzN2X23BavZH0XSLcs7IgBgNj0PRXPixfEo+7UyB1Sn8PlhlQ3YVR3mMh
         w/FdZ1PxokdlgBR74z2kwtqc7n4W2mgOyU3tC0axItfgQHSfb463QCE2iuCWAvHYreqc
         9KbRmeRanb/jUGbruv1YimU22AsI8gqVQayr3262f+yKMhgpAijpeEKKZfhIx73Xf/JN
         p4RnDfpYBm1Qd6DVPl8YNRra5XxnD6sWI1UhGNfDMHobAc+pRRxZbqBuGqYvyLhMist3
         eRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965638; x=1786570438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIL+DgBYUTpJ57QMSvObczLCrJeLPUMZswlx2+I7z/I=;
        b=j4iNSlAJtSqLp5qAaKcYrzTsZNUQg4iWww9MtSH/ofRbNBGqwT/qsB08w1yp+2+sPP
         pc+YXj3YL/zpSUp1viMNp0+9GeEsC7hdrLJJxIDSj9Vm1vMoICRzOCnWyhAjprQikwYg
         lKtMaKzoFdQmgv4JRQ9h6j8taaCkJyiY8sW+Hp5l0JHLDLZiUXzHtLCf3wahvx5+NYqx
         o8YwHwWF5+qDU9DEt0pddvG33RBsimjz9nShxYVg0RB1teBUt4XXB61Yp4KoD4ojEiIx
         7IrrcIjZZUf7BkegrDZCk3qIiworhq2WFvZa22IPNuKdUpJo1Qetnv3UuwXeObB2T5Z6
         oEGQ==
X-Gm-Message-State: AOJu0YxdG2iaa4blzwSzMyiWxuITzKxo7oT3hdHVRj1hkXuTbqyQ07My
	s5wUXAfrA/7WP0D6RXEymGy4MsP7sGaYVIRlPUq8GK2lMGDkmbvbBxfqGNi0cNFLl3M=
X-Gm-Gg: AR+sD11rXCVaSTNhq12QNtwQmFekh5WAjNOSUKfbjdDpPqLG/YWrnwO5dno/CIDncEr
	5RPhIF5w6JnyZMEjAWg28rbw4PLIrOkePvvaOqdShfGghXHcO/n8DrTY+YCvrAWBaIRmuvA1tvQ
	fe+x7+ZDdSw4xk3Brqx4IbhJ+z3yiPZ1lw8O8bVmlm9mSEwgliDTlsPfiD84K3hMUM4NotbzULN
	Pe+ejrXtl4FBd7WUA1ksLagVvUvY0m+8EIrbdekZOHr8W8tiBKJYi1+IpfPzND6sKzRN1rhVhcZ
	s+TmMpB7B0u3xuElvZDb+BAq105McBN9jE2thIQ8TisP41K8vP8cnsJ+T2Q4+WzLPxtuV+HrOvO
	bDlFQOf4Bg/lN9Pnbie1H18q1wwr9YEwg18L/aXN2LvXIOHPJfiQ+emB5mlODaBrpHcPYjdvEeq
	gciiKVEU4KAW9mRsLo+OtH36Qz5QjfTvYPwRa3GRMbiS4=
X-Received: by 2002:a05:6402:4509:b0:698:8785:650 with SMTP id 4fb4d7f45d1cf-6a14f0e0c47mr2906037a12.1.1785965638477;
        Wed, 05 Aug 2026 14:33:58 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:f900])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a196420794sm50844a12.24.2026.08.05.14.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:33:57 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 05 Aug 2026 22:33:03 +0100
Subject: [PATCH net-next 3/4] netconsole: reject enabling a target with no
 remote IP address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-netcons_ipv6-v1-3-170a35b92da1@gmail.com>
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
In-Reply-To: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

The command-line path already requires a remote address, but if a user
creates a dynamic target and enables it without setting a remote
address, we currently try sending netconsole traffic to "0.0.0.0".

Refuse to enable a target if the remote address is unset.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 070bae7b4fd7..a41b0a5ce64f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -471,6 +471,12 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 	int err;
 
 	rtnl_lock();
+	if (nt->remote_ip.family == AF_UNSPEC) {
+		np_err(np, "remote IP address not configured, aborting\n");
+		err = -EDESTADDRREQ;
+		goto unlock;
+	}
+
 	if (np->dev_name[0])
 		ndev = __dev_get_by_name(net, np->dev_name);
 	else if (is_valid_ether_addr(np->dev_mac))

-- 
2.55.0

