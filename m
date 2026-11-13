Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570152;
	b=cplCg2l706t9raInPxwKP644dGMz+s/h2XpFFpnu2Q1DE4sScNnOkog8Ry1bpz9mpTHD
	 KPVEkoyurLol5dtfq2iEfgd/cBYIl83MbMRkmJYmgU3VWwosWlGglHIANsYY0Qf2F6jrh
	 ETQtLWv4OuFWD37Ot2HF1IAQR4RWEyd50Qfuid0ZuG6bxfGWpyz9tUCLsCeFDXFgN1Scs
	 Kll6GOnxf0t9RJCcBoPtCGcf/Dy2a4cs5vwnfc1yA3DrwizqO9FBr4MfWu7o8olP2KC5A
	 C56b8SS8qr8v0ogm+xO09Ppqj3QIjdEFn4n6o4yNbkNBcY+aBdrJUefm4c4ulJAw7nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:From:To:Cc:Date:Subject:
	 Message-ID;
	bh=GkfjZtGpjcjZtys/mwSpi5hx436XAXHBdQQU3vB4joo=;
	b=jOYWcHEe11bJXXqCRYjjIMvPHI19Pp7og+Myl/4kcRQeS5GOvWaC8LSA4u/VPZTuxpRB
	 bYehlIdhTUgb8m6Bi7g33TYDFmYvJ6KAieiClPTFuMqC+WrEbgTu66IyE/a5aucBmOj2C
	 g01aEFSovBJBpoeMnJBFbqB8SM8Ia4d0XnHd9mLi5CLjH6crS5t3NPTqgmyDwiCuV75gb
	 sdTW4VKciVLYSLQQXcgeJntZT7plgCxqjEZq7SUOYkpvS6iveHjnqtV97R1HxBYftX7S4
	 ruXPtuLam1DI3XnnWV551qTw27ZAEPDv6s7JiVGKGGKa2rmj4k6IeemtxeuPxOYxfOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ARHnHhdp;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F639606A338
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F639606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ARHnHhdp
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so940514a91.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794570152; x=1795174952; darn=vger.kernel.org;
        h=message-id:subject:date:cc:to:from:content-transfer-encoding
         :mime-version:content-type:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GkfjZtGpjcjZtys/mwSpi5hx436XAXHBdQQU3vB4joo=;
        b=ARHnHhdpPzM4CruisRP4WClBPxlG7esqgAQ+RW6z56PxLFBu3unB/Pg32ZNhE885Vu
         6ZpPYaGiaAl6be2G/YO/zcxXsebinXNdSq6ryPHqrBW7NBpS/BCKp5N3lWYOon8p/wJ5
         Oyj8/OI/ACd+mY+XODFnheU0UiD7x6lFT+4TuZeydmwUt7oJ5cskVmoAYlXpf2M+RY1V
         0vLFcvddPsBIEwIuGmPPlLGm/K6JqK1VH/oAwklftJ4bSTuTtRZ8Y8u3iKCCBVtMbK4d
         hmMY2s79kKmc1EIQThv3cfrpRvfqzwWLAmMiY5jyE+flpaj1jPfLj8lHIQzTljhy2NKU
         s37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570152; x=1795174952;
        h=message-id:subject:date:cc:to:from:content-transfer-encoding
         :mime-version:content-type:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GkfjZtGpjcjZtys/mwSpi5hx436XAXHBdQQU3vB4joo=;
        b=y9WszcrrSdPSdXes881AgCBWjgg3zpzdm9iausdzbfJ1pyi3AxRJMcyhdWHFTJJtAX
         1UezGre3sr2T7K167g7tJelZ8P6+wWb7cFqo4+yZDq54/GvFBo1PNUbp+/jw+Q6XsThW
         RdvF4IcvkrVeVuHb8YX2e+kJ5xFePYIcXoDHXeFGqonh2uyN/tvA5nK3iZneU797oadg
         LolSpAcriAQUOPwLcCg10hDvF7JZqevxzru5X3SqTgm1peCLZxOAYitcE+a6nIOkyop6
         bY45QE5JA/+gS54KqD9EztK+6S7H9D/sMY096Jz/H6WiCV417qX5U1KLdbUhmMQrFnaU
         yMSQ==
X-Gm-Message-State: APuU4Z8/CIyrKLfnlJKAL7EJIdEFKEYWB59/GZjHC3vLIy4d33LHaki0
	ObMTQG9Oh268OzxccyIiwM/n3n50b4ZILARiduNWQcaI1lZz1XkT6wuV
X-Gm-Gg: AYBFou1mpu667fCuCXAQ4AzkmCFUZYQqasWGnR4FuIRZkI7d9ORv8tI3r9HI/mt+HPi
	BymLVEvTaHxhiae5L92vOcq8A1og3cMZjE7h2+CzwjpdDrijEHg+SQtMPmBgJlNkQXB2mn+6sKI
	NSbW8lYm6yMK+/901t526Tf7gmZdBJ3Iehp5cAa6qA3hR4RtiOy5/0JORUceOJ6LmrUbcnxgFVO
	cfmekSYD/+BjpYNV5D8ea5K2y+qZm0i3mxTGwjt9e2DKQbUUeTieH2rc3PkOs03k08wzGimtprN
	nxoc5pli43uKM96TWx+p1qegHlxLU8CEq/u1SgkadrwCKmiXVyQSQvvVAxLx3dvkV2uv8tfM8KT
	xBLO55oxlfiAb3VeXd9/YSXP+ts+Qm9guIEc2FrZZEJ1VKMtpp7AJASWAy+yjSLl6wpdgg5/RPg
	SavdNzFhTTMkOqRWms2GwRLsACjOEVfFgCR4zYfm15VhbazDq+XkYzlX23wNSIWiJmX9UO9srzn
	GeI8d/LIv2KPbayfmmfrj2+hybz+bxOhqvijso/ONWtAXET2o/ItX0nYuZxwCKU1fFb8NTHwikD
	a9KjcHFyHOIrm2R2Qu+5WLYL6mzSaSU3px59pA==
X-Received: by 2002:a17:90b:2cc3:b0:3ac:8af9:4a73 with SMTP id 98e67ed59e1d1-3b1b0a0db9emr1816819a91.28.1794570151823;
        Fri, 13 Nov 2026 03:42:31 -0800 (PST)
Received: from [58.206.202.11] ([104.28.215.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae981c55sm4347234a91.1.2026.11.13.03.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:42:30 -0800 (PST)
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Haoran Wang <haoranwangsec@gmail.com>
To: Steen.Hegelund@microchip.com, daniel.machon@microchip.com, UNGLinuxDriver@microchip.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 19:42:25 +0800
Subject: [PATCH net-next] net: sparx5: check DT port reg against array size
Message-ID: <179457014579.23820.10657909253312598784@gmail.com>

From: Haoran Wang <wanghr2026@mail.zgclab.edu.cn>
Date: Fri, 13 Nov 2026 19:42:25 +0800
Subject: [PATCH net-next] net: sparx5: check DT port reg against array size

mchp_sparx5_probe() reads the 'reg' property of each ethernet-port DT
node into portno and passes it to sparx5_create_port(), which uses it
to index the fixed-size sparx5->ports[SPX5_PORTS] array:

    sparx5->ports[config->portno] = spx5_port;

The value is never validated, so a device tree with an out-of-range
'reg' value (runtime overlay, corrupted or attacker-controlled DTB,
kexec-supplied or bootloader-fixed-up DT) turns probe into an
out-of-bounds write, potentially far outside the allocation.

Add a range check while parsing and skip nodes with an invalid port
number.

Fixes: f3cad2611a77 ("net: sparx5: add hostmode with phylink support")
Signed-off-by: Haoran Wang <wanghr2026@mail.zgclab.edu.cn>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 08a398adf121..6616e76bd0e3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -845,6 +845,11 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 			dev_err(sparx5->dev, "port reg property error\n");
 			continue;
 		}
+		if (portno >= SPX5_PORTS) {
+			dev_err(sparx5->dev, "port %u: reg out of range\n",
+				portno);
+			continue;
+		}
 		config = &configs[idx];
 		conf = &config->conf;
 		conf->speed = SPEED_UNKNOWN;
--
2.43.0
