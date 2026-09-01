Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126A3845BC
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240509; cv=none; b=AH2tZDUIjuvi8I2T90DoTuy6lZ4JAVCTmRRYn91rG3FrpCjkrqEgBcCziCjsJALmQlZULeGJlDgMHpmux2h9MxZ7Y5K4T9RlAQlTGtGhBijAxaD6Zn6RB7w3BxN8aGR3IZTthFWBWSUARi1+BdGZfOHhSCBKEaYXX0Uy7BGe2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240509; c=relaxed/simple;
	bh=W7Q8xg8BSAYA2tpHUW+AynBJ9lC5DWh80C8PRS4kSR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0QFBz7o07X6TH+yBC0xSOf/DgBmZOVBdEWfgqBS+v3Faw7rUxbD/T+9d3ZxSguH1htaGtOdHKRdj0xf6wSUM6DttgtyVEdxqfUgtf+B91ZpsF9DXx+d9magcpZ80iR8nJ5HZRqebzkFOI8F5/Tr9i/1E2wg61HvWZCAmMS04Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw/5LzLC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw/5LzLC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso60903825e9.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 22:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788240506; x=1788845306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7Q8xg8BSAYA2tpHUW+AynBJ9lC5DWh80C8PRS4kSR0=;
        b=Mw/5LzLCzbYfkO9cFPvCiEqpRFxM9o0QArFK+sAPSbBonMM4mGhvT5+QrE4N5GerAZ
         5mkg/qPAl6C5gYKmIrYFV4eKFr+7aJYMy6Eh+X+8/ma/G+4GbKKfWDy6HCJGLeF4aO+M
         5VCbtcope+RPL4XfvwZ9xeCdDkyakwIKzTWF7v6EUanez8v6YKt9PJ+dikMHU6z5e92O
         AVPh671sq+hYHpK474d2daYWRMcEaohSquAQTsmJ/G7aQwhCwp1K0/SdE6w1SQXWsI6G
         yT8l4k69nLhJ3TBK+Sj1AN/+3d3Dzg7Y3zzsLwR5JNHb5RYVzLmpD7QeCLNP+lxSzAWI
         vXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788240506; x=1788845306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7Q8xg8BSAYA2tpHUW+AynBJ9lC5DWh80C8PRS4kSR0=;
        b=aG/LhjT8u/UCEuQyaOGQ8u8H3IIBQxKmRk9MIjYxnyzct3Hn+cGg1rOoUipfgZx2Cj
         XdvI6BAzCCE1wmUsgPlyX7CK9cPpzSp3gPoZxYLZbMc3QcC3dEAAGA7ntukqT0hWBQZd
         sbeGLExZs5KJF/xkpsVdheKlp8VzCJGbobSFdcxY/QNCiDpqMf7UWu3+zKn58Rrwpw4t
         rsmz+g8HBv4t6VrnHKL0qnDMMZXLJBk8qwByDuNpe08FSNogTjygBt9UZX6q8VsAOkWY
         qf/2KPZhBrLeFTaLitwAMS5uxSgITe4UuBLR7BKeUIAPanHvukjavIIP2MYItCFSWoFh
         GH1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqiSzv6bM1zdlhpHDdl/eF0YaDy9I4CtzXt+L75YJbNOsPT3wEbuUR17qChjuOz4dOQytA9T9Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nlJfqJRJdSwx9KUYZ2rD8bhKkn52cyDE64FDokHZbR9nph4wy7
	gWluxx9B+VEtzlJjARzxEtJ1deeqgRiam7FGTBaRcBeDBxnzSOjumxPc
X-Gm-Gg: AR+sD11UrR9BMeA74JDgD3xqqIsH9Nr0vbtlBOTNJla5vK6DPs/70gaHEKvBmQUqz8D
	DHIVw+DcHCdj2Dl4i6xbG9HJDHMg+U972QIFGquYYwStwym6GdtkJihnc7k3ogo4imaLa1A8BcH
	SsQfhppbfX+LdXuyOrj/Eb5NeFLcPE0jjNAGRrR7r72zrRM4YaNZGGHC89KsW+8ABerr5ltx7eQ
	RR66t7pNVTLU7ybaop2BxwpfjeHERtL6dXxMXM88ZGtFVd3fEqwlCfDWeKrsn4N/EXEQexnvZZv
	QKPIZTIKPREcWErqpOkfjxW+NvfB3C2woFKuPPZO6ev6lEZ+e/CIF8cXy0z+6QtygaK5gNfl4qq
	YdYzDNJhd0w02wfdZ4tcqrkq/SATBEedYa3LVJNPiQnZpUGdNsp7gX32vGBmkTDHtCzDWpa5fn/
	oq7FyWePn3NcMlkymr1y+zF9F7qPWduP6cc1QkSlNDO5RBFkk7I0KUKfBdMWaq0wIFw9BEGPDAp
	52FePgyDQCyIlpglThHjtCZbfBGfWktxKKU73GWNIqFXiF1Urq4QH0KbSgYu4Od
X-Received: by 2002:a05:600c:3e18:b0:49a:77c1:d246 with SMTP id 5b1f17b1804b1-49b91c4e073mr525091595e9.15.1788240505850;
        Mon, 31 Aug 2026 22:28:25 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8b9a2efsm140752035e9.3.2026.08.31.22.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 22:28:24 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: sashal@kernel.org
Cc: patches@lists.linux.dev,
	stable@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18-6.1] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
Date: Tue,  1 Sep 2026 07:28:16 +0200
Message-ID: <20260901052816.3815-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260831133314.4125787-466-sashal@kernel.org>
References: <20260831133314.4125787-466-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please drop this one from AUTOSEL.

8fe125892f40 was reverted upstream on 2026-06-29 in b521003c27eb
("Revert "net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in
mdio-i2c""), so it is no longer in mainline.

The probe it added runs in SFP_S_INIT, before genuine RollBall modules
have finished initialising their bridge, so the bridge does not answer
CMD_READ/CMD_DONE within the 200 ms window. mdio_protocol is then set
to MDIO_I2C_NONE and PHY detection is skipped for modules that worked
before the commit. Maxime Chevallier and Aleksander Bajkowski both
confirmed that on hardware.

The timing is per-module rather than per-PHY: the FLYPRO
SFP-10GT-CS-30M they tested carries the same AQR113C as a module here
that answers within 200 ms, but needs seconds to load its PHY firmware
from SPI. A fixed probe window cannot cover both, which is why the
commit was reverted rather than adjusted. A proper fix needs per-module
init timing, and per SFF-8472 the host must wait at least 300 ms after
insertion in any case.

Backporting this to stable would reintroduce that regression on
hardware that works there today.

Thanks,
Petr
