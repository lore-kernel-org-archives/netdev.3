Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242036;
	b=Ow/GNFQBm0yDubRG/6DaGBjhR4n0Qx9lS9QLCAfhBOyx76BHC1alavD57FU8Zytd+3HP
	 QIfYb+o+xYxqg5SJhzJfocMQS2MjPUn+BTHD5rPmJ27cXPZzYTfTHlUDNfyPTD9r1e5ln
	 yfKouZDFFlLd+xslyHIpHQUSfI7JBY5rzW6AXhKPG+Q9xqVg12xt7+lODxx6Is4Bodmiz
	 XmyF9kwv8ma0fNxx+42ZENCh6zqmd/PbtwAPbAShixrCNSTU5v9wEI8NXp7rvsh4DhWYk
	 vPT0qOBtWSYBKRieXpvzfTJrO95ZX01jLFq8xt5a37V6vx27mexqjwtnQGudRFbo5kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yc+NMYIoZnK9rhYeskodTJuADVgcripisADy+8ytAic=;
	b=BkwoXrG/ui/5IkrAcLbnGQrDj0CiShwWErlBYcSA4IXI/3HJZ+HeX6SqPC+5V5xsh3OM
	 EmdpnjGvEpj6kaqEMx1zA2VdEFs8DgI+VjE05zzlTKx9y/S7qd+3yi/vEupu+vv/gEBWf
	 0MlPR3WIPhWHGTLnr3cci0ViaqtIOAhDdGIUU+6lJ8uh95Pw6l1b3uowTK1YIzsmpFKvq
	 PqsAPYsD/jzBZ0r9CMimH2j8BH4tM/dtlEYbGUmlWwqIdXtjnnnjfzqdYyjGWsUgrmvxm
	 HzSDHGjKMCgAYQk9FkPTWRv4RN13saX7fIg4YzEW5NwLrlCfnueqi9jU5EwT6f2mwMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zu1rVCtM;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F4606EE84
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 643F4606EE84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zu1rVCtM
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so667417a91.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794242036; x=1794846836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yc+NMYIoZnK9rhYeskodTJuADVgcripisADy+8ytAic=;
        b=Zu1rVCtMoHZO+UI7/rUVwx3jIXYNxWa/jms3Xd2Y0zmMzgigWwG8rucBCDessYIKMS
         0Uh+oj4VltdwqyVJGFtVKf5tBpkb8PrXGhtJjkYQ99K9VZ1j2a39B8c6UPnaljJD4891
         D/180xNSyzPEVVR5xHT/xAIb7anx1Q+Z7mhD1QSnkJJDsLR2IOeIkxxTVe7RWjbB3JFp
         ypBoEs8wBiv0Ze5qUuJ3417LrfIf5OOh6PWYRkhgII6CRP2apqTBFPUeeEiOLW0YebTu
         D7PyoRaC6X6CWgATnc/8Ydhhaa/JFg+UNvSh/kApD/IvwZfiSYDLQQUxIizU0MiO3AVt
         4dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242036; x=1794846836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yc+NMYIoZnK9rhYeskodTJuADVgcripisADy+8ytAic=;
        b=NXoDpyrBiN48XueKpzG59fCCzLXuOtVKfgKJ03Q3A9UYTrF2bpSq7HE8FILmFQHwCc
         zpbfEPOsbZdOEIam92wkEeMmeMR/RMzMR0DgmwWIj38JPLk4EsOmAhgQ+R14AKQuLrIB
         bvtbCGytW/9qZfkQYaqLh2cSujMacm9bY1EXoaP0sTgRCCgNUdaEsxMXTOZfgnARCOnj
         /o0sh9FOwKMgXmgvU2rIGdIRRRCQvp9xqSUVJr2h7PvbmfowvlTI2c5D5YazCoJcnqP0
         udpwWoOPrv1VyIn8KiNhTnnU4AzgHYwGtZvTg8fFaFz2LaNqFz4L1TCvHQj3pbRILkjP
         AVmg==
X-Gm-Message-State: APuU4Z+igkqUptouPnpq8nC09EWSK5a2nN+UV7Cnf8jl8/g1+ui3a2JP
	I9sdGh4Ck4b3geqpA6jhZKLs04vKq7ES0Wf0D7iYLVf0wc8T9owh436o2g2UoA==
X-Gm-Gg: AYBFou2srvRqqO7kwV+1dRz0Flsv5ma6MxL4K/VpTN56+Bmw4vT+uYuddoF1mc7NTIp
	LTZ3dfOgu3DC2K2UtpY9GKAw+D4PBXk/IcTaElciJM0W+doGLPrg1j6hIkK3l3gDq8RDyyKXsqp
	Xt79oFb23eIrW/BtYwfmsB+Lq4BAgvpzXIk1o9DQhkXcuVgJVuvh2y8ZEy/2VKFff3lDUcmEih1
	Xza/gQK9qYbdQOG4o4EZMBz9tee6PIcNY3ho4iw129DbEaMxOfb6rf11Sdvgaa73GRjPzwizJNK
	p7+getw1Go6pTQd1oXFVd+Of7zF015AT+wHklD8h0xI9EAXmOpEqEkPOyjUI5nXJiP+GMrCjQGI
	A29AheiZzIbL3ZyysLfQF4NNdJxL/XuZNfEas8JBCQJ1VhN+UBf0yPu2362MbeeBoOjlrgo7kl1
	8F5gw4RJRf2UftwvVgfhDkTQevMZWe9KZcjI1dihBl1JGIpPMYYROzKm90mAPtGe+CWgLxjoDQM
	Cu4ceUkcvx3Opt8C7a4MsuaiwiGIVASmL3eomd39/ZBuPejgQi8PEfYM8RJ+g4NZ4NdWHg8nPgP
	ct1dGjlsLBs0uBcviED1ZII1DfIm1kQtw/JCDX38tKTit9vImXbbqgguc+o9sjYhlN6TljtUL3I
	=
X-Received: by 2002:a17:90b:5247:b0:3a8:211b:6c6f with SMTP id 98e67ed59e1d1-3b166d00578mr155922a91.67.1794242035723;
        Mon, 09 Nov 2026 08:33:55 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1679c41aasm13995a91.0.2026.11.09.08.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:33:54 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] net: dsa: motorcomm: Report error when FDB fails to add
Date: Tue, 10 Nov 2026 00:30:08 +0800
Message-ID: <20261109163117.1792478-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109163117.1792478-1-mmyangfl@gmail.com>
References: <20261109163117.1792478-1-mmyangfl@gmail.com>
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

fdb_add() ignored any errors returned by the hardware. Return error for
that case.

Not carrying a fix tag: filling up 4096-entry table with static entries
is just asking for trouble.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..a7a9a7439304 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -725,7 +725,13 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	if (res)
 		return res;
 
-	return yt921x_fdb_wait(priv, &val);
+	res = yt921x_fdb_wait(priv, &val);
+	if (res)
+		return res;
+	if (val & YT921X_FDB_RESULT_NOTFOUND)
+		return -ENOSPC;
+
+	return 0;
 }
 
 static int
-- 
2.53.0

