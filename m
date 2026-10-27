Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132561;
	b=TphOfzu1yGKPit0HwsP9DxPA2sXlDVwgA9/8mqCjhRuMpACQRVP7W1Emmrvmb8duKky7
	 yw0607eQW4YtXmZZrcR9pKluDLyJ8VDK6TGam1c86b4PFyHB1P7vmvhYPBwHMZ9PoyKpw
	 e3pge1bb5pzdY/DDnDxlCAe/rgAFo0ljt0SI9YLEODufHFpmx8zvHivv7zQBpNuBB+mL9
	 eRPkuocwZARMcsIxhfOzd6QxLK//OT/uYjLgoiSX7xrea4ClQ1C1A1Yal784BH2m2TV5J
	 u/FtENaVega9V0olH/zrb7ZkYke4fxUXTZNjWh89jNjjTtruGtB7w7KzYZCyYedNZVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132561;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=ck+4woNz9CpLu2b06cLmv8mjKj5XuRT43XbS2D6B5Z4=;
	b=CPbOjLY81Wk68yFiO1X0hgUmNy5aDPF+FiIyzUQ+seVbJgdskZWzZlV+MxIJV4nu9vZs
	 jFNk194lGnvT117n27YvEqq7+WS+OesGU/Q10eZDTUiCunD8ldSyotE3kgMpb/8WzYhLN
	 Gu+Jp0LkFeQRH7iauzjwl0NVf4+z35xbPK9banZyvh8vFn+1hFJBndPFhVR6LOvNl+wwa
	 UuISz3HKDzTzBQUf16AKnK5l9k1j2CM/f5jBXw7LFWTbgVrUZoIEICVfg3EFrHQOdi57U
	 DbHWpdhUODr83JEvOYutalgCECky2l1gJWRo3rg7iZ8lxdgfdctZoL/8FsjrS7uFa3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="hShE/HIs";
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C376606B5E8
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C376606B5E8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hShE/HIs
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ae57dc1ea9so48390a91.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132561; x=1793737361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ck+4woNz9CpLu2b06cLmv8mjKj5XuRT43XbS2D6B5Z4=;
        b=jUTSBSdKzANAk1FDosVvSJOjgh4cPD1HFlvEpDnox+XHQEGDRBIK95ZgrwMKlLIL9P
         j/XEXxyuQlL38YswSal+YoXb8fYTGm9FQdy32HuLBLxTwf4e8EnB5g02C8cBsStp5V79
         gEGJQzTV0VA0fAS7O4mIT5nIpa4/IEPJM7ftiV/+X7MeDJp/eNZC+foF1OnK3nrLgUEU
         LxBMjbd2RwohuoKO/bjlxtMUyyqAcTeAKJU6JiRzuqtYuG7BHrUoJeBhN50jJmxxvm8p
         2LE0oHW+sgukM3H5Vh8NLrQ5XTQHpL+KfFMn1bASgbhnfNlF9i0O85VxqI19+hV1viPT
         quzA==
X-Gm-Message-State: AFq9FYKzmaTKLdV7JPhSQ0sDJyNfFN2P6bygr3y4ZZrHypx9aH3ShHoz
	45H8rfnejH+uX9uwCkuqfwijZupqdk8xXJfREE+trfAhu9/P/fIUVNqzUhTxPFju8DdpjOKrRli
	eOs81Aj4H5mZRTUqaVl/Rajhv3SVUlOW7R9Ur0hHffVq033LTH83Tt1BP12W8bIiLW8zpNz4KJ6
	Klp5e/JFeSvuJ+3U2LOXTBKY2oJKygqUDba1PmdJh3NR3Qhbwl7CuXk0GeVMRUu7N1X7EFKmY4w
	69LpcZ3Xlwt+IW6mcc=
X-Gm-Gg: AYBFou1mwR4jstGx32BVUzrCvHJsVqwFfCjLr241kFn7WlbeBrK4nnqga4sowNpJe1p
	by69qIssmdIt0q+JjXiiApVycRT2z4qkYcUIf5ds11D5kMzr0wvjaC9UlY8HoeDn8stDLVhgFJE
	M/RJyYuFD9P2o0G+gSC69W2A+TvloVFZC9/s/Y/jNzflre0sx50j6mU8/Cjpl/S2GDTa0uCKy8b
	0nPm0sXz1jvx4HiyW2QTsvMvHr8I1/ePMSg4kGTU/wPERDvooAurIhOHRf0TwpoTtyKbFxDgWxQ
	QcXI7YeE7o2LfcjOpNzrt57KTbQBcGTZvfbwj2ZiKcIPe3r+5tJB+nWeEfpsl3Vq0yP8yqyZMa2
	BWlrCsXLL6cqpiziqn5V7P1rRgtRkC0hK4gBKTZx/QVSdB74NNsjg6hBY5sX+GW3NGf/nOzQmDt
	tZJSQMpyZeCYw2f0ey8aAkjL2dlTpGU9EEViJQ3nvE5ig=
X-Received: by 2002:a17:90a:e7c7:b0:3ac:9a03:20bc with SMTP id 98e67ed59e1d1-3ae5824d380mr128537a91.47.1793132560615;
        Tue, 27 Oct 2026 13:22:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae57b98875sm76891a91.4.2026.10.27.13.22.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:22:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d5dbso240289a91.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793132559; x=1793737359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ck+4woNz9CpLu2b06cLmv8mjKj5XuRT43XbS2D6B5Z4=;
        b=hShE/HIs4/5x1plGH2KlK5NsweHXOon2FHshQAEap5SgyxNshxOsjjJCEWLC9sOm/k
         IYrKv3w9WOcT5Hv06MAn20O8LroTI8TO2h8nmfhnnXG5qeqiiqdWYW2KHW+Kc8nBVm6m
         An7JAa/1QMmjMHXW6E9i6CFlEdfciSyaBUdGU=
X-Received: by 2002:a17:90b:2fcd:b0:3ab:189b:6980 with SMTP id 98e67ed59e1d1-3ae5824457cmr114019a91.39.1793132559018;
        Tue, 27 Oct 2026 13:22:39 -0700 (PDT)
X-Received: by 2002:a17:90b:2fcd:b0:3ab:189b:6980 with SMTP id 98e67ed59e1d1-3ae5824457cmr113997a91.39.1793132558504;
        Tue, 27 Oct 2026 13:22:38 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d1650csm275486a91.1.2026.10.27.13.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:22:37 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 1/5] net: dsa: b53: initialize the jumbo frame size register offset
Date: Tue, 27 Oct 2026 13:22:26 -0700
Message-ID: <20261027202230.3539646-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
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

