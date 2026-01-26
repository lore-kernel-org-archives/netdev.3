Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8965B2727FA
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 06:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408128; cv=none; b=CZcN0qrvx/JkjLz6sYCQA+M6qzPCl+QvgMcWu7vjPDlGa3zd3I6e5kCkZ9frwO6CEn3le4SlbfrBi378a4IaiAgJtOZGwDqKB81JQU1rUq68oe3SaxQSSN7JNOXTsP5rXbHHHHlZyhFFTP5G62iPVrz950gw4Xv03FsTN1F6lIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408128; c=relaxed/simple;
	bh=ObrmwWLHEgXJXhqfzUvxApLqh7ht8xYEb8z0erge2J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+qSY5xMWNDos8uJG74vkEN4NC41vnQC2ozKZdOth8/semwPZJLO1BzWVM1RJnXo8W8Aeld/q1RE9WKF2HT/vohK9zdvfxfPSACev1Z42v5Kb887chQ4fv2fZ+PXrIiPxqUPrWwHS3q9MtygmMBKHrT+amS2cFAvKIrXlYqHenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqcSrQ3o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqcSrQ3o"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a7aa9efc55so30029835ad.1
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769408127; x=1770012927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwzqgsYbRQv2GZw6RztdTtcB5Hu8Wd4ivWKt/DZh6kM=;
        b=FqcSrQ3o3MJj22UG0TX8lIOfuhT3mhfbvCWQQZNgYHD/I2DV9n5BI7G6C0bNIw89xm
         yJNE418LOxHzoFKkL0GJICNHxP/OXzt30BBY+RU+sm2Lb6HJkpvxwKgfEv2Ck/UYFlZt
         3mcvA6QvGtAuxjJBnE09/GV3v2VXPKfNU2dq8ng4PPXd4EWs0fdEuVGVVZaj5iAjWM/i
         4b/dMoMKhAW3U+ESyNs1QV8SRrpGWiH0aawVqnBRVMO2N5TzvDcDJVdFGUfW+6Pcbpzd
         z32nxWt+MEWjiptesdOyc3OX9bhW9qhzlehLGruYwx6+cqWtbvH+PyooDlHPSnv/0jZ7
         I/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769408127; x=1770012927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qwzqgsYbRQv2GZw6RztdTtcB5Hu8Wd4ivWKt/DZh6kM=;
        b=n+sysEChQPacta44DWbBuH6a8AQoEuvuu+R79/UI4IxfQ0exN+g3SgiPc4D25Qa7cq
         ofJWF3xZB+yHircPaOR+LHwaHDdtewcJ2NMdh62e3JypJSTSJ+7+ujhwU5Ze9cfKGHKj
         SsT2DAbNZ6wW92daEwdK0w2RmIDAUzwYNKKcBaMUvJ7A7CvFbtbwGtu9wxVLD6ATvlKn
         7gTB9YMQu3KGaPlp9osPEa0poeV2EiTKXDlVCMTVgQFwSi44aQH0AWhzecbBtllyNsw9
         zm30/to52jCExdt+244bXCmY4AKm0uHOU33Um8vXEKLOg9s/p5F9dnzxUYI40BwSA2oR
         Yg0Q==
X-Gm-Message-State: AOJu0YwW+auOY3hD/M+66SlkYaZQB/cfuwXAgYC8tuiYAluxqhauGzFV
	qB/44sN6Ra/v5Ji2pBkveVVEfnt+LgO68nHnj+JEq1tei89El/4Y3jz0cTsygg==
X-Gm-Gg: AZuq6aL9SrSzLIhP+XhfdePFpecv1iUm95zPmsbN4H3lgmBT4UDmctITIq4KC+VrbcY
	incyolf727U6C76tS1O/TJq1xhpeOOJ3SrCdk/PiQ50glA4NaKoqjUTfznhgbbGW0hxefFQVQBk
	gL4vbuD8n84EohX/RVPhvG8Uey7xW8i0mNEIUP73hqY7XBi6qhOE4YhefGXjhns7nSp7FG6JOGX
	T8jXUXmoiUZgO0R6XmcMgd8GMitOnZNr1/1wdSUecgbuQq9ITdavpisyeHZqfd4oU5/yZ0VOQ2D
	2dufOENVLMEak9com/VfdUdE0o2p7OMyU5oFs6/3Ss3ZdpuQiVF0w4Zw7cDAdpWzo+7iksTZ6Zq
	EYHwha0PtjtJVmduxqG6eP3Ymd+q4gu6ckV2YZSyPePcmPlDgY9lJiF/+JZ/WzFArGRIh3X1k9t
	g3N+5vcsna1kpYtAbhUjrs+aZvHy8VXov78FukRa9Ll9kNGJ9X+GUtJw==
X-Received: by 2002:a17:902:cecb:b0:2a0:9755:2e97 with SMTP id d9443c01a7336-2a845257e5amr35235865ad.15.1769408126789;
        Sun, 25 Jan 2026 22:15:26 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm79477325ad.44.2026.01.25.22.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 22:15:26 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: dsa: ocelot: check policer entry
Date: Mon, 26 Jan 2026 14:13:31 +0800
Message-ID: <20260126061340.757543-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126061340.757543-1-mmyangfl@gmail.com>
References: <20260126061340.757543-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rate_bytes_per_sec might be 0, check for it.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/ocelot/felix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 9e5ede932b42..fb2d02ff0fe7 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -2011,6 +2011,10 @@ static int felix_port_policer_add(struct dsa_switch *ds, int port,
 		.burst = policer->burst,
 	};
 
+	if (dsa_mall_policer_tc_entry_type(policer) !=
+	    DSA_MALL_POLICER_TC_KNOWN)
+		return -EOPNOTSUPP;
+
 	return ocelot_port_policer_add(ocelot, port, &pol);
 }
 
-- 
2.51.0

