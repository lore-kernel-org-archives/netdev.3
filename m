Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58B3EA957
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336336; cv=none; b=ZKuHldDnwjPi1phOP3to9OCJoRea5+AL5uM1Fknu02fgmde9w5Acpw2wRwkDYhYMrKjbKvp3MqUU1N7tn5RSto4sEQb3N3eioVW3y6ixNrqlHOIFDr2L400Z9A/oZVNum4EpteTpJyB9z1hz/vBwXv94W/W6hIoGrLeQ8/1C7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336336; c=relaxed/simple;
	bh=zY1FtHsFvhZmr1r51XZIN6gnDmySfJ2JQJfMaOFqjAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMuURpoT1gp4gcptDMPVDPQRIRZ9bRwdkK/QUmCmwUxSakATbh1+EFAH1rFGysEEDtx3cRor4TbwzEa5SV9vPX2oyP5JNxa/btW6Nm+usJni02odpAmAHGR9i4kk+SySd1X1HoM3VAH08OJcqWvYET7M1cNn0SSMdrBFv6n8WbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=iXBbEivX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="iXBbEivX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so5902805e9.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788336332; x=1788941132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4Vc4iq3TPgEkaMSVSCPjErXwdDQEeK6K78XniZIP9s=;
        b=iXBbEivX1+W+t529Rcjtz2c1XlKsEPS1jM75ZGnaN97tQYy0wwnN3l95l23pqFjTqP
         k1MKKExp5uEsra3gF3Iv1LonhRrGyM+6GNQ8xWhcY1Jb5QIj34W5vXjDDY5oj7WFl1RM
         DlO6IJAFf7KjC6jk9xx4qAKfywZw5RUHaz3nvjFoOdF9NhDZpSa/wXd99qXpThvc/Ne5
         nA1/pZCUUJhlZB6IrSJQDJ4+djSNLwA0skALx53fnatGrhb1H5a1k1l8CXRxRCu1sg+/
         t50D4erNFHONFn1IEKsU+DrSrpamyCcaIGIzl7NzfBeWIVSy0qHpQvb8G6NP6bB7krkF
         VPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336332; x=1788941132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4Vc4iq3TPgEkaMSVSCPjErXwdDQEeK6K78XniZIP9s=;
        b=V0aDeTi8kjWfrrtuVj8IzX2bf14tlxwjtUIlGmS8Yc9DNNePyGOFqco26HWITvH2TH
         XLwSUCiZxM0oVzJLWkK1nwu4eJhf43qqoubFk5qIJK3+n+5I0SBaoy4wnWVZ6rZHS3n3
         cN1N92sBCQOLQW8a2izlqZtN7YuQ//6dEal5CRj9PCjVqjFi3dCaDRxRfYjVhct9uWXN
         1uL0mceVz9MPWYPI0sMd/snkABm2KnDPT5yc7t8aNBGHUcTUcLZ7Y6dNAO8Gtkg3vS36
         37FftEVuMvERa9qLX3LboRHC+0vcYWKXIFmng2XXhfWWrnRHN4gkJUPWVYejyMdJLalT
         vBeQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTxliz0pIRaNsWEvNAUQzOOzZqO5J6t25616hRh8FfXJ16V9TpgCvQF9Gu6aKWQAIBTyIQXuM=@vger.kernel.org
X-Gm-Message-State: AFuF++n1tH2Rb+9nQHpHWueSUJayr9UI2gFg1XZdJXDdNFQev9c+n9po
	PkINGRnDROtrgdG2Qx+/SGkQIAtxLvt76YtBjyTxgHbnlUKB+n5sbTz/Fn4qNAXZzrc=
X-Gm-Gg: AR+sD124vjhdw+q2R4HhwdieAIcur6yE0vRBAsnzrkLJGf9bi55awHLwlqkQ6WiaMBS
	kGdATXIE/t5tXlzpOXaYAJdzoC7PyOOo+jD2enn65qi6QWk5ivIaMT6JY2KrNZEgFkR5T7WyPdJ
	EijLisxTTe1i7PHLkxukfLuntoIK0edMX/rvy4wRHl/AS5rDiXE8zovXdMvYbxkiVou6+BHKBG+
	ihb+b1nf/MX+wF/6TDRqRYjJkrZzOiWSLoTSyYm9G05Grn8DJCrZDLdUu247JydpTtwqwY6Dquw
	pcs1dCrIk9sURxvtx9zS7bV6zk1EDRF+JjChot9G91z55DcuJT7LpmtC36APrxtwn++s1enfKni
	ZhUHeTwy8kw+d4CL8rtA2k05c5IY7nf6PIy3FuOfwisokNZsEjeiSyex3peiMrk/gZUJN6072/z
	SEZjj1G++8Ehzk7yN3PNkPFiNgy2q5xarpRNEiud8=
X-Received: by 2002:a05:600c:8a17:20b0:49c:d818:8771 with SMTP id 5b1f17b1804b1-49ce5808d4dmr37954585e9.7.1788336332155;
        Wed, 02 Sep 2026 01:05:32 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce7dd5154sm17766875e9.2.2026.09.02.01.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:05:31 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: "Th\u00e9o Lebrun" <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: macb: reject an unknown link speed in the taprio setup
Date: Wed,  2 Sep 2026 08:05:28 +0000
Message-ID: <20260902080528.2211468-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902080528.2211468-1-f@lex.la>
References: <20260902080528.2211468-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

speed is a u32, so SPEED_UNKNOWN arrives as 0xffffffff and passes the
"speed <= 0" check. A taprio schedule installed while the link is down
then has its hardware interval limit derived from that value, a limit
that rounds to 1 ns, and the first entry fails with a misleading
"exceeds hardware limit". Name the case instead of relying on the
sign.

Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a43855db1e45..81530b9257b2 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4324,7 +4324,7 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 	}
 
 	speed = kset.base.speed;
-	if (unlikely(speed <= 0)) {
+	if (unlikely(speed == SPEED_UNKNOWN || !speed)) {
 		netdev_err(netdev, "Invalid speed: %d\n", speed);
 		return -EINVAL;
 	}
-- 
2.53.0

