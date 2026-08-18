Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C62E7BD3
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059674; cv=none; b=p01MxSmK/x93B9+oIDMoo5XMf+ZcBC6ybeT09xmrflLnOi1UbRntEz58KkySMUsbQw4+l9KGKJXEGMLn1FWMt//UTz7s2NUAMq1GTkmXCIJjS4QumL+Tfpb21vmPjvRbdDIWreJV6eumWVUdy6paCzfnTSmtfiBfojbbCUjTGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059674; c=relaxed/simple;
	bh=rTTS7quJf2T2nNu9O2zdGrrwK5Ml1SS3Nb7HexDkArE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkwEIUML0BrJc9Otp4I6PIGP9Yf4b4FroaLC7wk53QIe/TmBtj3Bo4fAY06DzwtsVgOAdq6r4uSUfEN7uyIqsTbcfNRSKYVe+0cUaT378y/S9Ol3avGoJeF5y1oSD0jje34mfobzNJNQI0H82RxhNdXX6h7106QXWJROTj7n/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr+aCAai; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr+aCAai"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ee4f241f42so641496a34.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787059672; x=1787664472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5CxSIJ4pwOIXRfZe+DypDIst1ZmDwbyPkrqdJW1SIc=;
        b=Dr+aCAait1eqvSEvpjI/NAlj3p+0JIJKqfUE8kjZHdx8TLhemUVmcorvswc9/ZsG2a
         UQMz9TfjQzlRxTGNg8tCP/QJ9eSS+mKerhO2Q9SCBRXA0Vh2KVLpD78jo5uDwJE/vPGa
         c9lUk3cpkGvc4CH9E1VVcTWyUc1DgOAf88sRxzu5AuNfoZrOTHxhgE4NBuIpx4kW1poV
         HaULVv/cI/IBAeeWGIXGLS/5WGlvIbYQxNf7OwP9sanZB2srmA79OuaFmK30of/knuG5
         hZVU1HoaD2OwbhRBdOkHlnU6m3XqJVrZ05PmrOStyA2QNWzzx2OyuBjH8Mi39xwqCSRT
         M1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059672; x=1787664472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5CxSIJ4pwOIXRfZe+DypDIst1ZmDwbyPkrqdJW1SIc=;
        b=azbnR+tva4WxDu0KSGODQWZ9UpGFZSS6ow3gR+ptrQtX7CcEh/ZYtdzqcMuSbyYfQa
         RvC8spORM+3N2jsmLEPm4KGpw4mstGrtSmlMa5nEcDQqthAjOGNQA94xI0cQkXA+E0tr
         gTIRALEKawOHlGdjJfw4E2sNtOjtukhjXe8tldpbYh4kg+EaMKAw6D/Rri2ppcgzXzmJ
         OAJlIUai03bqb6wHVEeA3RtFc9eJNEYZgjcEUY78mOIPz1yx1cgtMU0jGxhxDnb6WTKY
         D44zvuJuh76nzS8uqgFGtQ7L2X3w2Qc7warNu82wpjzTYO37gEE6nHTdZmTwYhlvJFZ8
         xylQ==
X-Gm-Message-State: AOJu0YyRozZwqJMC938Ye//QMFvJYPah7ttLHx8IU9cenD8Z1Xj6OAc3
	9uY/fAhNMB7CcZ6uRWXE0hIZ67BcyNcD2ZM22iRx8G5ntN7tBBsiJRYG/GasZ12sKf/8
X-Gm-Gg: AR+sD11VkNxq8+9yliWvbjeUQPFUBgBtIdyxmrdxjwQ9Z+yRQQ4Jk8li/nKUe4Kji/r
	ST0SeprlJtTl2IoKcku/xzkg7JTSQCjQKnpIEBEp1w5DzxcOxnJW1tLtjrpow6+WevvBjHyPsxq
	SJmUfatmnMr/zttU0wFNCUHHYhuDhAqg1DClkL2nZfnwgzAK8o88hDqjY3khbO9bqzJMBLajf9V
	78Blf4W3xNJw7PU7talw5cdTCYfpCDgeSnu8xhRjO4C/lLe5TUPDdIdY+eHeHsBym2I98xXFqXa
	V4qG655YlYxyQ9b+RW0d/54VYuYEWjls4ArHhcLecDfKFi1OcJl/iC/sh4gP124v2at0mdugbpS
	My7oG4/U/5MPp59UykKT7z2uWMexYDsaT/a4Xb18ocsCoPcz3Oe65mhcgQX4zCGXzWbdHWbj7pD
	Kz+jiTODXg9RVC3MM5DVk4cMsfgSIlcfs1SAQC5HmUBqnhNjbetUweeH8UbOPpYrEX6/GLCuMGW
	//AY5ybpNjIotpQGMlQiPRU8nK9Ue3jMd+PE0/bGjGVaFUFoUe3qHeE5ydbP4hJuO3BoPeNVrAE
	9H4=
X-Received: by 2002:a05:6830:2005:b0:7f3:f914:4fd7 with SMTP id 46e09a7af769-7f4264c857emr3895877a34.14.1787059672410;
        Tue, 18 Aug 2026 06:27:52 -0700 (PDT)
Received: from codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c0f6d05sm4256336a34.24.2026.08.18.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:27:52 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] tools: ynl: handle calloc failure in ynl_ntf_parse
Date: Tue, 18 Aug 2026 13:27:39 +0000
Message-ID: <20260818132739.469624-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of calloc() before dereferencing the allocated
response structure in ynl_ntf_parse().

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 tools/net/ynl/lib/ynl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 2bcd781111d7..af101544c31a 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -889,6 +889,9 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 		return YNL_PARSE_CB_ERROR;
 
 	rsp = calloc(1, info->alloc_sz);
+	if (!rsp)
+		return YNL_PARSE_CB_ERROR;
+
 	rsp->free = info->free;
 	yarg.data = rsp->data;
 	yarg.rsp_policy = info->policy;
-- 
2.53.0

