Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE63D4131
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404805; cv=none; b=BrLHLMOTjMw4jPgnCUaGQ7VAyPEaJG8rBfQ63Nhv6nrDONHTPmgLXNwSTXA8BGFVlXteSGB09ptde9x1Cp7jQfwK6Cy5RoDQOQ9mgRUVCu029iIelrleBMdnDeVy94sRG4B+XIRADWZmaXeGA5kFpsxNjYGgBrG78txoBfJsxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404805; c=relaxed/simple;
	bh=TVNdteF77XkZ3uTWh9NTw71cjft6iB9Sfgh71Arqpzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcB3rGIRa9KIGShsBV9by3wxCp4SAhvDqtFN2g+Ka+3wUMy7RNIdPt1t8p0Oist6U2wGoTmC06k0MFRYLRLVhly1uYtQuUgRo3z/Y+DAeqGVypHjHoJHvL2b8A9SJE72SOXSxVd0jtk4OWEkO0SPZT6IqTYG+4mx15hCd6kCFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ddeOq67/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ddeOq67/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4955de8797cso12582835e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404802; x=1786009602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NJThzF0Lf3yEPDin1on/N1TAkZD4ZRj/0OJFnseHLvQ=;
        b=ddeOq67/WUzrCy2MB0bGlTG52E7yfiR/Vrl9Zbgw9tDrI2xDS9fNdcKT1HKaWLh9qT
         LFRigJheKKRroJJJW3MDGXqyuPF7tvfCst1wxgPVZtcYr0/0Z98/RzbPtKok47vOaGjJ
         JGlu/4TqsguQ6j+NhCU5eAQFZIrYDI1SeTL5aNprs60fPL+P+7PKHo0M2PqDhrmxVyGz
         RqYRdIPgTf1xHqDN4alBPwJz2CDmEbnnbDH1iW1SXmPb1gGwBJAi8hmhn5tHuymOkuhn
         S+oTx+cmoCZsysyAtCghOpMgpyCh5IBaEOqvFACF043NoU5ws8rZMqZES4aL1Tp8Ch+7
         a17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404802; x=1786009602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NJThzF0Lf3yEPDin1on/N1TAkZD4ZRj/0OJFnseHLvQ=;
        b=I0kxw1Dw8QN+MGnio3aDAVTAeHNHuMEnnuBoxj9osx7nnwjEPJVSdh5ymCe1k9XwLN
         KsEjS6fcgmM8t3cuSNjU2oA/IDt2FHg0BJ42b/OPYQbeABKbLsRRcqYOvkkVgO/3iNsq
         S2rms4KmcncZtypyvgNf120X6I5uhKIVdxduNy6RhCpeZC7BmhRwaPk8W0ROzglTWYMZ
         ScQU/kxsQRazNj56Gnd9zYtgahUlGb2ct06RkxDfYoKhq4n2uUawI0hK2b2kZ/RUxcge
         hdneuj1kUro0ILDpDGnm5BlnZeNuUnyL7JhDu5tgO1g8soouOkyKbtu55jLyU0Hm9tbL
         JHBA==
X-Gm-Message-State: AOJu0YwSzBGJEjLC8rd7TYrvkSOg1NzyrNEzepDer1E38XPMhto0Wb7D
	Oc0ddG9h1zVkIc141naacsvQx+/3RSbA9U2C49efEXuPwztcBivADN8exJ2b3P2NpnSvqiSqsVr
	7fzvHZctKFHLqOHo9mOglu8H4i5VrVlNX6QN2KFO5jQQncDDdpf/OSD7xJhBB4rAi
X-Gm-Gg: AR+sD134Z7yzd1q4uQCUfE8jsTIH7sq2ycJGbnridyifmGBT5o6LZbPKQszd9o3Zzj2
	6KqQsCw5+X7M3O5A5zwxVYF+B90FtAvhDzcFonNZ2Mou9jg34jD/GERUnc4gzGBoHVMTPUaFUgG
	9jt8+AYXp5ejSRBF82YL8uJoQ+F+hR9DvCPvQ9N6BeE1X1gYMz9NpWW4qDvu8pLB3AHUt0MH7NE
	aCLFiPK8qtHilHbfoi4D18dciC8XBRsH3vfgN0Rr8/UQTO+yldEQObYX0DG+xJlbBjhxX24Yt85
	eCcxHtkMZ0F0e5Nq2ww2yMRCEeG0SnRoLL3xld0nEQSTbUDmefdhRGe7C9mSqF2fXySvrF1MSYl
	9Vq+1KDD7iBSziUfeBORDeZzX04I6Wr99SpUkZseQDbXxO1c1UphkY0dmFgLH34Etp5SZ1slb1d
	vYd1kXEq+3GqiuUFatwpeOVbdG2hHeGOMK89P0ltMQBDk2ToygNfQFvftL/FRdS2QfyRBsMxCge
	Q==
X-Received: by 2002:a05:600c:3b25:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-49800e80f32mr22158935e9.16.1785404801984;
        Thu, 30 Jul 2026 02:46:41 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:41 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 09/10] ovpn: ensure TCP vars are initialized first
Date: Thu, 30 Jul 2026 11:46:20 +0200
Message-ID: <20260730094624.4102963-10-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730094624.4102963-1-antonio@openvpn.net>
References: <20260730094624.4102963-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netlink calls may access TCP global vars (i.e. when attaching
a TCP socket), therefore we need to make sure the
latters are initialized beforehand.

For this reason move the global TCP initialization at the top
of the module init function.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 3a04757d5c31..168cfe9b59a9 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -260,8 +260,11 @@ static struct rtnl_link_ops ovpn_link_ops = {
 
 static int __init ovpn_init(void)
 {
-	int err = rtnl_link_register(&ovpn_link_ops);
+	int err;
 
+	ovpn_tcp_init();
+
+	err = rtnl_link_register(&ovpn_link_ops);
 	if (err) {
 		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
 		return err;
@@ -273,8 +276,6 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
-	ovpn_tcp_init();
-
 	return 0;
 
 unreg_rtnl:
-- 
2.54.0

