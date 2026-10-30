Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394987;
	b=BYpx21KoXaDlozNYfEgJ+XHc4EM22JvmTHYfUDiq0LRcllMXND7TBIVP00VK3GenTrIz
	 hsFsW4kxkKxLT2Xb/jd1NGtIRdY1Cf7P9A9tQxKbL0DdzGelMEHsNDTjYplLXBXq3AaBx
	 Y8O/pmZCjqv2JKCpGjxNSkoNfNi+3AgkQR4Yje9cU7XvTpi/UCehhyPr8pQZn7IOJ8VPj
	 vU59vdamRZofxnw2NfvNjdzFtyLW3t4bLTIWMGGSKA8Fr0mN2M6PcyAouP85lhYUcUyLS
	 XC/yS7iSlR76jzDeoqjl0nJybfaJM43Dx5+oYxDUz24KfYzNi+aM/6QQXo66LeqJ4Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394987;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=r7/S1yrh0Xh4BzOz3EN4N+JMRy3rpsmCaRVhbCsIs9Y=;
	b=D4QC6R7JTkbSFAflPk0g2Zo5S4eUd42/AzpkUvXwoUrzV007gWLYpcmrbFOu7xOtzJMd
	 WYMKpZ+YdECZvBvRGmmoWSzKrxdeP9QC5hjSA/Kk6LZZo9usq+2IRucC0XX2aePq8W7vU
	 sdzxoIt8LR69OrcLZtFPtgC/MEbduSEIucshhiBvXmwOIfIyclKPn0TvskcCzVVvNJsS/
	 qeAhZir+LifBKsCSF05JUDdcmdOfNoSdpmDe3MD3u/vFmsqzjwtpfQx58ehnQ5k0uS68q
	 0wYeWwkcofXaZkPaCC3NOMdDR1HQF4Ccy26Nu8oZQwRBUpxwCJu0R61JKGy4ThZBj3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ADKylezU;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FE606A325
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D25FE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ADKylezU
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so993785a91.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394986; x=1793999786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r7/S1yrh0Xh4BzOz3EN4N+JMRy3rpsmCaRVhbCsIs9Y=;
        b=H5y8x8ZBfvbpDiujdcMKeRDm6BmdmUxIt7UMZZG5fUzOTlD0dU00oW4kgPYzoku9j7
         phxOQPmAOCovWfl0FZC9+4XgqznciP43eWSU+Wim6G8XPSgUvhsFBFqfcjMb3P1DNsCl
         c6bYQCP01stKpEnFbsXFR5x2rnERN3Waq6y5Mps73CkoVd2uPFfZcx+QKKjCuUqfQNlA
         6P5VSn4IiFvuoKephQIsNnJ30YJZlhR1Zigufo21SYUu5UlnmZmSbL5rl7cJvW1XMKQK
         hUTqZK+QfylGE0pfQq6sceh2uofMyLouo5XWE8x2uO8PlziEFILSuL9zg6syB/ayoKXn
         yD/A==
X-Gm-Message-State: AFq9FYL6cewwi1wO6loxnYwMyCICBG1bsw9iPzMXUDifMCqoJ5/296Ou
	46CpDw70oxG0Nv9WBmipluAM0x+XQfQEtfj0QKfYMrEgGSDwV1gwh2a1orXhFB7aBjfHSsOEQj3
	l3bY6XtCpx52lwW7LDEx5Fqk74iM95vex8XOmCjm+VaNpb/21x31MHLkCS6X1gEfw+GWoAoueCX
	ihlPvYFNj7xR3yp5DnFZafORQ1JjlLX6l5uLsj6lbH8/QRTsLRHOoojq30GtpahSQp9n9Gf5RaA
	DCbT/G0lIKwdfIkiiQ=
X-Gm-Gg: AYBFou1VV5qvlT/uhMo10jkZNM1LlM6rJQcBgtA7VZMYoPDg4vKa0f0itz1SgWxHOP6
	rhllCaUxM+aqBuoswpB3T9maco2MBO9N6brJLs8mlBdomZI2Sm6Bx3RPduQD4agSmttKLuF9/l5
	vq+F8CNPqCe/a7oBZnh+kO0mtA7i6J2dQUDU2grBtgu8YTkwEeo3+xWsGcFNTUkH7mfTA2926lF
	wz9rBoNCjD1skazj0Wz3oFElcKSwEy0VxWZyLtjwnmB3UsCJCm2Euwu7qi8cJx0Au8Qa2+bv8l2
	g/XJDB5D6h0K6g8ucjY10B0j/04rsceAscS2A17xdLh81JHF+iV5hWb9qWLYyV39n8KezZcQ/8X
	9AnSIi0EBayhv5pmGprxWd7gIvQufjpjsHvTwomQfrO+8svoGEhMMNaWDEx/BCk7xh48i3//9UA
	I7boQWtAoQUTh2SnRhF5QO//NEtGvC0WM/JMaWUrQC
X-Received: by 2002:a17:90b:528d:b0:3ac:7f4c:a68c with SMTP id 98e67ed59e1d1-3ae897c144dmr3116680a91.49.1793394986254;
        Fri, 30 Oct 2026 14:16:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae87fd8e2fsm901667a91.4.2026.10.30.14.16.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:16:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c3c370b17so1926229eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394983; x=1793999783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7/S1yrh0Xh4BzOz3EN4N+JMRy3rpsmCaRVhbCsIs9Y=;
        b=ADKylezUDFkCq32MDfzjf6B2x24ZDyzS0nn4boxR0RmhV02ebLv9mF3LIWoQjvYTL2
         y43VQLcMmQk2pO7PS2kcCo3M6yWEQH+P6gEL/sOvfnOothoJGlxVjZ1cDkyqckXfvmOi
         SYgGcTduZhDmSbeOeeb9k9RvJM4NJHc19Vkxw=
X-Received: by 2002:a05:693c:8811:10b0:35e:da0a:75b0 with SMTP id 5a478bee46e88-36a423be72amr4997318eec.25.1793394983240;
        Fri, 30 Oct 2026 14:16:23 -0700 (PDT)
X-Received: by 2002:a05:693c:8811:10b0:35e:da0a:75b0 with SMTP id 5a478bee46e88-36a423be72amr4997261eec.25.1793394982323;
        Fri, 30 Oct 2026 14:16:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13513535eec.16.2026.10.30.14.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:16:21 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 1/8] net: dsa: b53: initialize the jumbo frame size register offset
Date: Fri, 30 Oct 2026 14:16:10 -0700
Message-ID: <20261030211617.288562-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030211617.288562-1-florian.fainelli@broadcom.com>
References: <20261030211617.288562-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The chip data specifies both the jumbo port mask and frame size register
offsets, but b53_switch_init() only copies the former into the device.
Since the device is zero-initialized, b53_set_jumbo() writes the frame
size to offset zero instead of the chip-specific size register at 0x05
or 0x08.

Copy jumbo_size_reg from the chip data along with jumbo_pm_reg so frame
size updates reach the intended register.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0880310c9ce3..559d4b360c82 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -3109,6 +3109,7 @@ static int b53_switch_init(struct b53_device *dev)
 			dev->vta_regs[1] = chip->vta_regs[1];
 			dev->vta_regs[2] = chip->vta_regs[2];
 			dev->jumbo_pm_reg = chip->jumbo_pm_reg;
+			dev->jumbo_size_reg = chip->jumbo_size_reg;
 			dev->imp_port = chip->imp_port;
 			dev->num_vlans = chip->vlans;
 			dev->num_arl_bins = chip->arl_bins;
-- 
2.53.0

