Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960320;
	b=qvz3N+QbtwDYCSG+XIBUdMma+/JL9npS7LCMFuSryFpHROXWsDkU7OcIKXTxhTkc5ajP
	 6TbtLC9iUD1j1M7a3JmHLvAHWMmTaI9QoINuvlVnCr+6ibe+4pcAXiFt1wr0U7Y6gGqxa
	 5uFirNIiRgHOw/z9wbt/cx5v6MBOpbNn2MKam2NUzpkXFVjzKxjW+bCplj17JH1cUwjFu
	 vh08rlQxZapdAw0Mcf6Gl/iKUAEe4i6R0mN3rMVHg4T1j1tB9Xqbc6jZ+asecQ6Xo6oMA
	 HiSpbBzISrCbjcNHU0O2cNRQcBmvRYXi7LM+w99HswqQ1bs632v7y0op7erqK9vcyPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vJIpz2IR2uKayeqq1B9k4Uy/SxrEV0GO4KqXaU7mgEo=;
	b=k80OuLlMOVMxNGCWCWp6gvy/Ard5STE1H1PS2PEamACqz4t6j3thFEY3XLXnLstvzlqh
	 D7PjLC73LxiXr+Gv5g5a8cF9Y5Ca3ExBaB7voHEGyyRUlMcYlG0aQVsp8VAKP3+qp5rUl
	 p6xqN8utX2oopQgn8hLEVJZUzk+fa0tRMVwGIwNeiGtwZEiRNxK4IbNzobV8zZdHz3IEI
	 aq0LwQaQJ3+RAzn00L6s6FhDQU2JyZEYEla1wWNp6L5M5s+frF8hNYfBU9SrvTXKl9cxU
	 IoopuzYosUqYgPfFuaC+dkAE3j7nALgwLDzO+4EfQkVhn2rtjAXB49sYbdtACo0QSLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ce14jaf8;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96A606A325
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 20:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D96A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ce14jaf8
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso4877127a12.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792960318; x=1793565118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vJIpz2IR2uKayeqq1B9k4Uy/SxrEV0GO4KqXaU7mgEo=;
        b=ce14jaf895Ti3kambPTJBFMPUD6UgUFBX3aXbnMuWOgqgRyC09OhUwMm/gSWWfHUKS
         8nxMGygECc7k0F/E+h5Fh/HtNtJKN8OrCVVRrgwr8El7YU6RMW7gxxHLa/Uov9zALaro
         b5kFu6bi16LMTFOy/WkJ4b1+EpNdUsux70gXjwelOXhKrxWHdi7r+xwX1WSAVTdwX4pi
         OV+gP4KWYU63oX93ZkshQcTlsjJ1T5Wwl7mZuNKRVpfnLA05x2reR19gzkZFcEQA5kL8
         whlhkxeGYLfeYrSuMY604MqptkPLP13imaLaCzImos0piZzoM0UMNxNLIAQARNirjXTX
         WoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960318; x=1793565118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJIpz2IR2uKayeqq1B9k4Uy/SxrEV0GO4KqXaU7mgEo=;
        b=11GYaDKlAGUAviLhaJgWzKFQRdGWhUdGwBYIdovkR/o1t71YenjzI40GLBfGeuVgVG
         bpAHsyYHd4PPn1Hucacr5F1oHZ6B2BVBJRt9X2X5oUU7sSQ5RuIph9C3iqMO+dMUsBaz
         tzALTbI4aJO+B2UApGk04Iinx7+eSUsYLNjZ8zfhIislGWflwGhxRHpni3yrmEC9QAAg
         rxmq/5SV+odJK3qGIkyAOf+pkfK+wvSwvEVM2CAE/EMRM5i39obGmqrbgtL4/0DJFBV3
         2yLeqni6eAoCy4ODGF/F+dkqhD6F3jYuPuQvmyAltwtWxB7iGBlTlqTcSImgepboryCS
         tF8A==
X-Gm-Message-State: AFq9FYKhQbFMyhJzcskAPQkpeTVnMWSPPzlxFI3q32IcLC6DoydW/kdn
	VBYDELhREAKQ++6i9aDhJF5bnXTNwsHv3q3FLnPvTt3vNH7imi3qzs5F
X-Gm-Gg: AYBFou3UTo46PjR6FBhJ8q+Y3jPvvk4ZyvN3BdqCB8+vpTu6SLwq0g48fUf28AxsR/l
	C8cYvicHKsKWF1XQsWfGuLQbu+3pRXyPvFl5yNEQWzAIT7ISpNj5BEON1jnneoaYTMk3hDw0Ir6
	t43hsJsGkGiPKfK87J8RmUHrHLP58aoh2eLMCjHkeVE/VfHlrT6zwc+COq7t9bHRn1UUqB20Zpc
	SmhNGHwTx7kvEUAhP7tflbw5gS4uEHMvyVHoIhC2u5wU3XOH4e21GbW6XLGmNcxV8J2dffnp7RO
	t22/GlQ4GRSrcZLTkQlinxcll+cPP8hc1WS8lCxANg5WXSlbU/dV6af+ykwOrlNpD9lL88Kccsp
	h5/ULrGZuCZ1NIXH/oB0TGy5Ur5xQOAHpQrVR0o/TaDLdXNK6RS6okUQzC/iI79U05ZwXlC94iS
	8eh2tiNwWVLT0C48L0pG9TGZOjXXEH9coATfSc5Pp+BWvm9g3BlECm/VBNwmhKMrbOLnNexogdD
	6g56PS1d6HJbIIxw3gcAM5lvagEILZ4M+xDcWpLky5938kn0v/bzalOtgYRUwfpBzSchIQPMPp1
	UQMgq+uJM6H+/8SqUa/o1xcAamn2WnrE8tQ4MpzCECooeciKzas8gODXogZUcW3Nbl8T4hvm5HM
	GmnHmwcko4bXc3CKipwO+iw9tM1aKxbricoB7y6tsbae7
X-Received: by 2002:a17:907:7206:b0:c46:78af:6150 with SMTP id a640c23a62f3a-c46bdac6ca2mr638087666b.2.1792960318542;
        Sun, 25 Oct 2026 13:31:58 -0700 (PDT)
Received: from localhost ([2605:59c1:3500:c210:a19e:c679:44e8:e9a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd350706sm247414666b.3.2026.10.25.13.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:31:58 -0700 (PDT)
From: Selby Mashiki <mashikiselby@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Selby Mashiki <mashikiselby@gmail.com>
Subject: [PATCH] net: lan966x: fix double fwnode_handle_put() and missing mdb deinit in probe error path
Date: Sun, 25 Oct 2026 22:31:55 +0200
Message-ID: <20261025203155.455075-1-mashikiselby@gmail.com>
X-Mailer: git-send-email 2.56.0
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

In lan966x_probe(), fwnode_handle_put(ports) is called after the
fwnode_for_each_available_child_node(ports, portnp) loop finishes.
However, if lan966x_fdb_init(), lan966x_ptp_init(), lan966x_fdma_init(),
or lan966x_vcap_init() subsequently fails, execution jumps to or falls
through to cleanup_ports, calling fwnode_handle_put(ports) a second time
and skipping lan966x_mdb_deinit().

Add cleanup_mdb and cleanup_switch labels so post-loop initialization
failures deinitialize MDB and clean up ports without calling
fwnode_handle_put() on ports again.

Signed-off-by: Selby Mashiki <mashikiselby@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 1179a6e12..7abfd97ad 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1228,7 +1228,7 @@ static int lan966x_probe(struct platform_device *pdev)
 	lan966x_mdb_init(lan966x);
 	err = lan966x_fdb_init(lan966x);
 	if (err)
-		goto cleanup_ports;
+		goto cleanup_mdb;
 
 	err = lan966x_ptp_init(lan966x);
 	if (err)
@@ -1255,10 +1255,15 @@ static int lan966x_probe(struct platform_device *pdev)
 cleanup_fdb:
 	lan966x_fdb_deinit(lan966x);
 
+cleanup_mdb:
+	lan966x_mdb_deinit(lan966x);
+	goto cleanup_switch;
+
 cleanup_ports:
 	fwnode_handle_put(ports);
 	fwnode_handle_put(portnp);
 
+cleanup_switch:
 	lan966x_cleanup_ports(lan966x);
 
 	cancel_delayed_work_sync(&lan966x->stats_work);
-- 
2.56.0
