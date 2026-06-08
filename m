Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83993C7E1D
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931282; cv=none; b=fBQzVljj7IcfLBYNNRL4tOHEphgHa/48rZDUf0PNp0+kQ28rl7Ygj9qYTI/hycCYQOkyFoB6bZb9eGxrki5lWnSEcFh+6lYgJaIhXqR3tMCI9HJIkNnAG8LTGLbZjdYrZbSuJgPkO4oGwzvqpR/7CxQp0FYcPEL4hjPiH/egiFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931282; c=relaxed/simple;
	bh=42P38pT8zxLdaYcwxJbRwgJLGe2N1dqhWk2AEmR+f4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip5Ythyig8Sy30y76M/NIaGxAleaFr/i5sQHjfU02l/ml8AOj4/lTFNYbCVRpuMSmNNFP+V6orXUQXaugH9qcDz7SqQvpsWJuvk8PRMZptJmb+s4bNObWGXtYibmvreG6YSjEa1KzLh6KYCYwxegdsJzURMYVomh6AX9da+ZCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PIDgRB+8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PIDgRB+8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so29293885e9.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1780931279; x=1781536079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOUozNbuvMTx1Rqg8Th7XMrmgzs8QbeIZy1utVtlpbI=;
        b=PIDgRB+8fgmVSGmXTaFNcURknaCstRqn9IQLEFgoVpxyfnoOQjvqV05Ug5awLdAhtM
         H1+C+PReUrQlQxr6bw19hfU/aUTB03CIY4Bu2rM4q06yNJ+8ZbvOow0xImjRYRt80cQH
         kbkRPRPlkT8jMkfoIW81enH/eEZ0pAMSneo5DTsi4FsZlZD+0c1y2yTvvk8+Hlx87Eln
         rZtqUHNLMXY0EdaDimTtNIoL5u3APugZOgJ/UyL95iVITRXsKo2ay7vLXWBrBiZkcBqj
         9NLFJq610TauEvueNNfA8vbNOanNjbMtj92/xARsaRQMAraK4Zq6oIi+PSliu9Mx1gQR
         RIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931279; x=1781536079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOUozNbuvMTx1Rqg8Th7XMrmgzs8QbeIZy1utVtlpbI=;
        b=ARGZB/IdfgtXOMv5fGxooKxFd8jjbNfaYDaE6/8vUosFljojipsv3uandL55pceYry
         OFyrBXKLTglxoF8R2JPI8u9HM3kL5yh8t/oSQkiXF7DYc7xm7sNnQzNwA7tktNl4kAQE
         666/62/N4+TqLL6WohowAAtp2jCVLiQofLjWb5jaMyYcv6WR67yYndN8SRXgMEr3jNPz
         tie/DmG0guaAaEnPdE4WpCQi21MS6Z5IfAkuZ7QIbAg4r3M18JCuKmcSNee8J86NBb6I
         QjkGLslmhqBGaZJcQUId2RDc8WP6tOY4fq9CCopkLP6s/+OG1Zlp4MAJsX9antfZb8Tm
         +ATg==
X-Gm-Message-State: AOJu0YxXdq3l3iPo63JJMLtbOhWw31tstBDENYPlq3tVRmYgTxFMD2SO
	nd/yOLxs/Rs0E+qiF2C+kJLYo4e7ZbC0YwdRbPLgwfQtR6OqOM4MwU8vocuaOY3B5UfrWIRbPtz
	f84WxX4V7/49GbiWJN35v9m5dytny8eH9vmKkJLaxmqQfdMYDhoHqnaIXTDzm9mOAmRg=
X-Gm-Gg: Acq92OGc9nC5pWUCCLnZ91kYDnPk58nNf1W+5vpXOcKprj3FbpsjYaLdjVHqagUcRVp
	+FL+cZAWYowO0vECHioa3VwkCkG7S+wcnjw8o05MSS+7fx3P64vjUHKjvtFhPnrftaYztjafgJS
	G6RcdtjMXxHfiW1ehbAEz2Egyd2t5lLOA9yEw0yCELKUeGyFIQ+uL9rVzaIY/CkVrYdbMjL1GYb
	6j/rdet3UWKPIcvgqzMHia1Ut7Ty1rvepRr9g7Cb3bQJ91g3u7jgX+OpZnrzOnBMsQHYxOLFPIs
	TJ1QFjB8Scq46svdUNf+McOTpaTSyj7z9Zk4ZYqFguQabfb2zvRa6dE562gbWUNLa3VNDeJh8EA
	FpsUUjugD/oOT489Tpzya7M7tY7g3j/gibxyiayzNHL7bN2jZwaMZUodo+gMsF3XhAYA1XnwzV4
	qLQIDjqE2P9CJuJTyjLSEee5rqRcxTGGLwxfQ5ahOCSm0sC5o+f5FQCc5nxwXKli+wcOlo
X-Received: by 2002:a05:600c:8b85:b0:490:9d5b:d721 with SMTP id 5b1f17b1804b1-490c25f166fmr270562135e9.16.1780931279306;
        Mon, 08 Jun 2026 08:07:59 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:7e36:aaf2:5280:7b3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm390659705e9.5.2026.06.08.08.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:07:58 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: longlong yan <yanlonglong@kylinos.cn>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 4/6] selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()
Date: Mon,  8 Jun 2026 17:07:35 +0200
Message-ID: <20260608150741.3320919-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608150741.3320919-1-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
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
2.53.0

