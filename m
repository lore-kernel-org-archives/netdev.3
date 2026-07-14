Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333AB4C6EF6
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056554; cv=none; b=LsDGAGX90rz/ojfG/hCkIFzaCBImiUTNjFXfpWHuwl6GXTTRWkEMPUGXqpe2j7BdvoVM8W3BNOgNp11RRQxPVaG3/6F/g6s0BDTQWAiEhKyGSMr19hzEQ7kTww33+/hbTNoPl10d5xDny/NsP7TMrdsI+g9e66nNZn5rYxKTlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056554; c=relaxed/simple;
	bh=gR9OgTYQ9fjGLmRFLC+m4hXCInJcvIxRkK82+UFP0WA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zze8q0og/3+2NSBGfbfvdbpF7Ukz5BKdwHLefiGwKYTn+zwSQ/Gc4qZCrenrbfh5LHO3O8yt2YLKxqfATFeRlpG1rOOlrj5uilPQC3FAcJFiJpFXPl/iSou7pO13AQYdec0Aq8D7zP3MmTj29r09y5+5Yh3zYJZ0AevoBykwYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZbECPdR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZbECPdR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso32082375e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056551; x=1784661351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVmBD966C9OYKfvXL3zarSW+MDcZqfgKZz9YMy/NnbI=;
        b=YZbECPdR6rWvh190eaGYke7OS2atGHLooE8+c+qhcZhnxQg6hewjaMF5ITtSusz4A1
         fY0mkOcp5BjIADrtbo4Q5/ygJnKDsgrXIqso/paKsDmp2Hpaq8T2nh8AT/H57O5l1dn5
         Mp2JvgqFJq+8Uasr4QFQ8HDy+h7Gom/LrUp/OlrNwygZ+cdxsRgcFaELkGz49H2vGSca
         Ukl+qvwdTBtF38JfUHV/MQU73npyFeiizRv7yt/qWphKZoXqAHrWSRbyx5EkGxbdUh9k
         pQVvdzDr+h/gzenV3MGC3BO2jrCxeCwiE3CdYv8+6NQ1X9JQ3A4pmcZLYJS0RBwpy0gN
         kCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056551; x=1784661351;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NVmBD966C9OYKfvXL3zarSW+MDcZqfgKZz9YMy/NnbI=;
        b=g5kyOVPyHx+Tf0XqjkD80XiIq47C+Cns7Kmxw5BNyCaPrl4Se6FTLC4cIek9molPiT
         xyoCzHlCPce6F/PgXwLx+Qu0IYrrhHr3lCpos23M7ePsep3uvr37Y9Vu+gO1MxKk2tOw
         MPp9SJI/uEB+dVbAL2GbmE1V3WcV+Lag1rNPtEnH+7J7YMlhsVyBuQeD2lNRCBKBAquS
         yw0Jnr35L5IUPsePEMHoJFBDXpdMrbt3eviKYGobib70i8Ea5pwDPlxYnGeC2/3W4ysg
         C3MoDFu/9BNaOsIBuiCKqNdQUatDEj7HGX1GoBTLupD6bHY7qh96ZLgM45A2ddGLHlIP
         XE6Q==
X-Forwarded-Encrypted: i=1; AHgh+RrDdxpXN7C+AOrP+MMEH5cKvf7iIK2z6FCwPFjWMrYuB3L5H2WJpRCdU0McC5CpuII0htnMPVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzFZ/4WyvdEZ4Iuxb93isqDEPocNeBL82DiuQIFMvn3lT3WU6h
	YvJ7SZ9QAsfC7ghJ+3vMUguN9oR2osRYopavt5N1Qeku93vtA31bAPW8
X-Gm-Gg: AfdE7cnUo6twmtYml50HOkHWHLCKKc+dhz3ui8vURJ3RPuHW1BevbfRenktHwB79eRc
	20go+Jr0/hTjCk4G+AUEYtRObjBl7Z+/knTc0n0dz8MgNU1juwdHnzwZVlnZGkmc90cTZB0rBxP
	ceQ1vzbJz6De7aPdPoSWjZPz1SfHwitDhpOjTRdfOd7pqWlnZpj90TkNO1VZUSupL4WHt3zFV2G
	xaTxPMCVIIO2Hjvcb0DHXiGfeMoosVzo6dha9RSHMpsMIHSo8WJRdQZrafxSygFvo3U4gx+V7BS
	8F8Kncux6Lzrnt17EX40REKgqXDLk83Cl13BlRW7IjKLDVAqYIsm/KJdD5Cvy1L3Vc3pFtIgj0v
	Ty5XRGQ6/sSaA4VmeHqEgTr9ObarlwHUOC+kj+kTWdy5mohOERQsfn6CYc1Cy4E/jX94x4mCr60
	C7NkN5RKb7lxQ=
X-Received: by 2002:a05:600c:604a:b0:495:3aac:1098 with SMTP id 5b1f17b1804b1-4953c28ef1amr1040425e9.32.1784056551104;
        Tue, 14 Jul 2026 12:15:51 -0700 (PDT)
Received: from localhost ([5.83.201.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508725c0bsm96157365e9.2.2026.07.14.12.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:15:50 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: dsa: microchip: make read-only const array ts_reg static
Date: Tue, 14 Jul 2026 20:14:05 +0100
Message-ID: <20260714191406.195375-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only const array ts_reg on the stack
at run time, instead make it static

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 8b98039320ad..5bdf829a6e38 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1101,8 +1101,10 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
 
 static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 {
-	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
-			REG_PTP_PORT_SYNC_TS};
+	static const u16 ts_reg[] = {
+		REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
+		REG_PTP_PORT_SYNC_TS
+	};
 	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
 					    "sync-msg"};
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
-- 
2.53.0

