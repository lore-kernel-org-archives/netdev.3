Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792939736;
	b=fC332/5b30ewutx2FK3OKgjRMT0XZ74FigpJwaSdDnrVlikVpu55+CziBcWgk+55FPq0
	 +mUEG5f8IDRvQAT8yDkS8c5PDqhKfcJZ1UDd4jJD/QBLIk3rQdBVA7M3PBRDu+L07LMnH
	 fsCppSAh/PJAHyQyn/Ehfxu4C0YQvQ7F2MkzwKOj/nyqgzZyae+qRw7J3c1hlnssYHNC3
	 fhfE8xU4eMtAjGsT/JJFE2Kw6wbsF+9XMzQfkmXnzsNif3J+rV8ywR5qVdaCCWjQDQb/v
	 hYnOENgxkYN1a4GsIszFCpzeTz8m2SW1wQ3Ui+QcTKizIm+6oS0VNTlysO4p/pGAq3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792939736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0BHKQxHth0jV1Qy3AAfupSHQukbGmTDd7nK1ds2NmEM=;
	b=2JV0JxttjkapqcPElhS0U7wlFDJFX7C3IJPCfg2/tz+8pCgWwC6jisYTzbE/vbVPlZwv
	 O64X7TLdCA46D4HB6WXCsaLZDIPrzTAzbnkxsxmqvYSOEwOp3anKK0/MYVKCto8BGUw4C
	 HEulWpm9UldcDFXUtVP62N/P3sxPO6PnuI9p1A+NajO0JChJ5EphCGcSeJz4KCKLk+H6z
	 8tjojBAJvWY8YISPfa5fX+OEgcfcYbQa7u6NE0Vyhlv1Fc3G0uIB3wq3LZrfnRzkOZkII
	 FtNXbhIugnx3gNn3sooDiC/p19i8dGUgKrLhsmxl08NhG/XEZEM6g2gtGPktOvZc2XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZgAPG+Wz;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A158606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 14:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A158606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZgAPG+Wz
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso28435a91.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792939735; x=1793544535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0BHKQxHth0jV1Qy3AAfupSHQukbGmTDd7nK1ds2NmEM=;
        b=ZgAPG+WzyVCZaoNPpfze2BjqHkSO4yHwl8QI1W6Bnl1swkOB6WPUaIeTuFtgPN27Tp
         cgjWbVx2UZ/gUcb/cfbMlvqadmy4QRY9lg/cnLh0NjOioIzzGhSqC0ZJg09U7zCXCGIZ
         Mg9zOQzJRSOiFoWWPP3SRdusvhNnI/pi1DRS8keyR6+7w+gLkwVo/rAXduD29ROYsg4B
         wUsDbVEoNjGyt6uiL7P0YAZ/7MivD4P0zxJNIvAD9TH/5ZOfyIqqnq7jg2ctPn8T3J+r
         b8v72fsYuQz4L+tjsumPMpF/kio/MKuhHeAigKRnV0HPBHS7AsdslZpPmoSL5naT4w0H
         ObsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792939735; x=1793544535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0BHKQxHth0jV1Qy3AAfupSHQukbGmTDd7nK1ds2NmEM=;
        b=qZk9DWgqLQTIiMLNx+V4DJ8TFWiE0jz0SpA/JyetA33uvzgk73i7e1JK59OX5iJF6I
         gegGlBsjUN51x4TnuMc9j3/vM4NEBZaS4SFB3M9TtSYNzIx2E0/oFWX4NogIwjBb4Pqi
         dtmhG55rkBVNaIZn4lC5m0lLA2YqyBAJnrR6jelt+ypl1UKeM7Kjy9Fw2ItCu4/u43DX
         Rjp1JJngkPDUONqaL9qFomM6OHUY8QeK9qWX5NzfmWeNwa9zHavdXQu/pSQx/zQUKOjP
         XBPyeOCCBWSPTWq6RUzUUzfQ6Wx6NZj3Qw5uMT5pjUGtdFfSN9sJ8q3JxLjGCIMs3UyZ
         mQfQ==
X-Gm-Message-State: AFq9FYKe/G3zfQHomTRQqE4Zc2IQHG23vLaoWgOapzM8gpzcRYTt9xvo
	559OtMuDQUXTXxBChgGcRXUNWy8imQxIs02aaY9EAeRPl6CTHe5b7hLzegvU9A==
X-Gm-Gg: AYBFou3VwcFW+QlBHepHRawLo5HtsAD3NDlTLsJEPhCknZLw5MmuXPIZew+vecD2NUF
	lod9OOgXNo6c+4O34Q31rF/EV3zWGkrQ0NYcsTo4pdFPH3R/fBi9iRNp8BoDIFLe7BpSk+0s1Yq
	Mhu/YwKPv2ZPtUC26EP3bOvi2f0m479yJTxF1wIIhU1m5WjlVrrp2gef8nT8BsnCSovSANX6zGb
	7wneyqGEjRE58pq4b4H9mPufMiVbSzI/JRHGKbG9xwefcdWwhn2yZa904U0vENn0CMiYB8XgkW5
	Rfawmx9p+kQGo4ih11x9vhb+e9Bo59qlfK5dz5EYsKoOP0RdocjDWcJ6SYaCZZBGgii8Sq6PQuv
	1TapSK5o1w9Cu9w8WVUkjrKpkitan8gbYLzSd+lYbbW00+AIzAq7U9cL5FQL1fzX8r8HtFKV/I+
	sWU3Iobs6dqMkAO9CBkib1ArJ2bypvIApiQzwmiy4TrxvGC/vdy/taOfOKaZVNCXJp9XusrLxKP
	ybulI6eglaI2A9ijqA1fns6l2OHUkh7SK7eOdduMy5qkIjhOjE3MQTlldhUBq42MDKZdsB8Y/zk
	auVTCCnCwDCqlV0pPSKsFSsYWGf5
X-Received: by 2002:a17:90b:314e:b0:3a2:bb45:d37b with SMTP id 98e67ed59e1d1-3adeaae8947mr4089569a91.25.1792939735592;
        Sun, 25 Oct 2026 07:48:55 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6212:1232::1d0:de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebac408asm5265009a91.0.2026.10.25.07.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 07:48:55 -0700 (PDT)
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
Subject: [PATCH net v2] net: dsa: motorcomm: Isolate all ports during chip setup
Date: Sun, 25 Oct 2026 22:48:31 +0800
Message-ID: <20261025144834.2810828-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The chip setup only blocked unknown unicast and unknown multicast
frames, known multicast and broadcast were left open (though the former
cannot appear while the FDB is still empty). Before port_setup() runs,
broadcast frames received on a port flood out of the other ports.

Close the window by fully isolating every port right after the hardware
reset.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2:
 - reword and reduce code changes
v1: https://lore.kernel.org/r/20261024144023.1010237-1-mmyangfl@gmail.com
 drivers/net/dsa/motorcomm/chip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d4fc20c52a58..08a880867ee1 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2221,6 +2221,7 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
 	u16 eth_p_tag;
+	u32 ctrl;
 	u32 val;
 	int res;
 
@@ -2258,6 +2259,17 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 		return -EINVAL;
 	}
 
+	/* Block all traffic as soon as we reset the hardware since it now acts
+	 * as a dump switch.
+	 */
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		ctrl = ~(u32)0;
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

