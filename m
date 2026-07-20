Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8541A933
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558509; cv=none; b=b3JvRKvcLkcJdY+bLYIDLWKLmhFSowpH3O/FD7R0uIcjOk5Yua2NU0+8XOBBDmdETMAB25xKdusa2hniB5fpZOkKT7C5AyalS8lKZbYEalrnjjdOCCOxnG8khbrJdgWIVFHT6BV+aSni/mI2oId1s2zlFlcTCniBSk+6USk5g0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558509; c=relaxed/simple;
	bh=KRTZWX8XHx8yIZ+zPhckbPNvzR+GFrQlaXMnfbl3Xtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8SuAJxlbTUef0h89LEbSmXX+BQTDqXEQX3IBjoZRyL2cc0CtKyE4xgKX+vsqJxU6vVjkt4/3MqSgke8LCHLoNmsw9AnNaLwTRblGEE/eF+JiJQdGL5XYiwXS85dV7S3lDRtISTnx/o9n5euDbtsTujOdQy2ZfIrvT7SNajdH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ddarjzhw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ddarjzhw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso32036165e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1784558504; x=1785163304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6PVIk0k5pIijY8ckBFA8VaxkgkXZ7BctLgnHiujT0k=;
        b=Ddarjzhw+yliApkZxohNiIoKHbaPCIH5hQdRwEWPajywO/G8+py3B7zpynVwC/1Su+
         fO2RZY66cUYonQRmosf51eVCne3sgcZpOXdMVOMVkUs1qb71+XKUSul1I99w+LDpKROG
         Hu9neJOK36JFku93Kr6zDPszL4ZvXvhy1Imbgb7fcptbYqWdKoAfEKGcZY3Z68JhGPfM
         gaF3UIPpN8Q4lL8yGsEHvo5//cLAHU34oqKdmDCZ4jPUNYd7uHDf5VoIzMerQ33dOp56
         DbvEKgaC8a3sngZ92fvPG5kDhC2JCgHnrZveoVbaINAMzrkV0uvq9Fl9Pyys9/Kt0BcF
         sHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558504; x=1785163304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l6PVIk0k5pIijY8ckBFA8VaxkgkXZ7BctLgnHiujT0k=;
        b=euaCQrxU9qjoRbZyX48JmO5dcYjLnYQJdf4p1YrhdXkwKf6atc4pfKuOHcAt1gQ4/I
         dv8rDnlpPdatXz3lOM2uOtYq11a0VCIUPKJvC8sQdNplF/E76uLXp64PujUWYxVkYSpL
         rLFcdEZzOkOEUKAJxXiKb/72zxOMz0//TlblJ+YAN/ytJ8tTAcn6jFXoSr+GAr+NnC3p
         tUqfUJrka/2U0ODEO2dWCmt3dhpnWxaXbGFt6s/10CFAXC/2uNra70vr7D9LKkBcZPEt
         WQEH0u4xjO+SO2sEBh0DAHoDblqB1CRpdieJY74+VWXHgOlxnBQQ290W/n5tDKDVVXtl
         w2YA==
X-Gm-Message-State: AOJu0Yzn/+IkPxOj7mcFs0X5GHx59ImWwgPnfJptJmaPWKmriZTkUWq/
	gNYCpCxshuYLnZbi3C4jnKhxB5jBfWiu3dOOoECV/7OaN9C3HSfdJmoBMGtotAndyT9imaXOHJ4
	uT1OnHq57/g8+a6V8zy/nXBWHl4G7L/EucYqQS8WSptvmuVHdRzfYsMID4BwLHqvh
X-Gm-Gg: AfdE7clA2vRPN+wC6dQ0c7VVLZJaYDqX/NfaMmnGiX38pkPFQ73riqmKvrQBk46yY4H
	6qv5bcn2Au73uz0Y7lcFAs+D7xdCa0B6sC4pgxfCL/lwyG4jOfClaghlPKf4sw0Zsi5Yg3oeHBv
	vzI0NMJm7KTbYO6rmqc907O11KrD0SgBkt+rfkwCHrairjovaw4AjccKsnkDdQVKnOzWlzfHyqj
	KqdTVVLi/JhjmRQb3CreuGlAlrvZbIPNwfGonOMNV08gbeHM19yZvZ6+BuJYSQ94Ou9iZdSNZVy
	LiRS32cBZTdFYROxhlUZptnmGHfig8CKqeYfSdFgVz5SK07NK6yGL/9Ish5dFmR7bexTyGkfT36
	FdLCy2VmJcIRSfLYea4QDagUncvFjhQ7XhenGg4olqjF5mnjpxWmIyZcD0p7ofKW67oxaKqRFNl
	EJ15zHqXZKF404gLBFol7l+t9w0g==
X-Received: by 2002:a05:600c:4755:b0:495:4a34:16e3 with SMTP id 5b1f17b1804b1-4954a3d0d04mr171628865e9.1.1784558504329;
        Mon, 20 Jul 2026 07:41:44 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cf:3416:35c6:c361])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51c33sm26387406f8f.12.2026.07.20.07.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:41:42 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	longlong yan <yanlonglong@kylinos.cn>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 4/6] selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()
Date: Mon, 20 Jul 2026 16:41:29 +0200
Message-ID: <20260720144131.3657121-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720144131.3657121-1-antonio@openvpn.net>
References: <20260720144131.3657121-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: longlong yan <yanlonglong@kylinos.cn>

The ovpn_parse_remote() function has two memory management issues:

1. When both 'host' and 'vpnip' are non-NULL, the first getaddrinfo()
   allocation is leaked because 'result' is overwritten by the second
   getaddrinfo() call without freeing the first allocation.

2. When both 'host' and 'vpnip' are NULL, 'result' is an uninitialized
   stack variable passed to freeaddrinfo(), which is undefined behavior.

Fix by initializing 'result' to NULL and calling freeaddrinfo() after
the first getaddrinfo() result is consumed.

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index d40953375c86..f4effa7580c0 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1785,7 +1785,7 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
 			     const char *service, const char *vpnip)
 {
 	int ret;
-	struct addrinfo *result;
+	struct addrinfo *result = NULL;
 	struct addrinfo hints = {
 		.ai_family = ovpn->sa_family,
 		.ai_socktype = SOCK_DGRAM,
@@ -1809,6 +1809,8 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
 		}
 
 		memcpy(&ovpn->remote, result->ai_addr, result->ai_addrlen);
+		freeaddrinfo(result);
+		result = NULL;
 	}
 
 	if (vpnip) {
-- 
2.54.0

