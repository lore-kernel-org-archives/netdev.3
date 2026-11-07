Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065613;
	b=Plg82mzaXJ3JH/K3/id/+uU/PpNGcUGpcu0iVnzTXirCtfO5P/hH01Wp4ML/A8qbCm7J
	 dN6gksaAQHsjWJOrVgrrB2F4CIHC6+c5YZK6GPi9enw7YxW+xxLQrD6dMV0P7PVO9rvqg
	 V44VaNivV5Dp+8o8eV/AJ8p5Hf90/Ph7pbkR8EPEZNUjlRjx3yT+a0fd0gCTWmjwZUcU6
	 QEFZzOauE5oVzmz9JWmbEmEde735yL9Pfu+2z4HFdY0hFnJZXO5F5oM9SOcsmpRj5F9PY
	 jE0m7OKehsf7BGMhywI7pRZqI58X2E9MocuS81qzxM7ZfJ2ykNtrGCmQQJYK9aV/jUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o5BouOfVj6QrHRMx9FtSeHZTkceBPgzJ2LCjg7lA6F8=;
	b=bDMqIrvdGzDcjtG/RJSi4QrpUOt1pES1TVoqIGycGzVlRnq/osoFoO36egypXAILnJuh
	 gfIO00FhBsh9RfqkzQ/daaUJVNOfsEptyMFaGnHLubexvnqc4doat5T+cecTm1gZWYErC
	 Uf5ZVoDPW9qtkzpJC24X3LJDHTsaMs58DoDXy/YHcKS5tHp3vD9SbzIveEzVNkQ+HtME3
	 juAEwl1xiMeUDV/+abPGcfn0B7dZoFhEGEyCpS19WmHleXIpA+sHxiS+m8jD+9kYRfXFz
	 kyedH+v4xAnp46wWoTFdO7QaJbE1U1o1XUv4tJqUgjUf9UKtDX2sqUK3bWqhGuRMRmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yj4cDSkF;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64703606A337
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 15:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64703606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yj4cDSkF
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2771931eec.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 07:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794065612; x=1794670412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o5BouOfVj6QrHRMx9FtSeHZTkceBPgzJ2LCjg7lA6F8=;
        b=yj4cDSkFVYDWYdtMlaEUcHRvWY/d+c/hagAFafGVJ2kowj7dEQtzde1dFtIr9b8k4O
         TznZsh2F8ZZSCDShb7GwY1Q2EMPyfv4l6WIR8wugF0oVmUUV5XsQvpIkv9BYwYBa4upM
         v49KfCxM6hDHs2bGh3SbigkIGGfWJbKvF7xoSGkOBM8qpXVG9SHqKDSm9MEzjogwlzQf
         doEZfXO7C4/5NyZ9Y+AOCAwV6ZM/0INN4g2SEEtHsmIFnb9AbasKCMBkCp6t85EyOh6X
         pSPMnI/Mi+0bbcN8+9Sj0wBCv1o4Mwu+sfFQU2Ez6P/9d3JirkyqtgmB1V1hLsJMFsqr
         chrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794065612; x=1794670412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o5BouOfVj6QrHRMx9FtSeHZTkceBPgzJ2LCjg7lA6F8=;
        b=GlXOqqNdqcOa+cQp7oqVO+9u63W9o/m+YiddQkrnmTb3t9UT1Xr5zE0kAINShDE/89
         A4Xw+xGJkDqB04VQ5lRupHJJsJqVhbYMxELLkZsm6QUzQwlGn/9tVwLN7+HdcMKrYl3d
         u8GK8UhhhfbxTRnmJLuuYC8fBtV2bIz7oeGJRxTQcDPuEyr8PGHO1GxxiqmP1tIcfG33
         QEGRBOF+Zp00oMI+VRrJd+xSeAeL7lsCTkF8xHGiGL3GahYike70cfZnG4yqlia13lst
         Tm52CLWEEDJLKeFPYHAsWvW679ImE9WMPr0TZI5jLrXxZ+TOH3q19o9dDJ6OoigXmTDL
         ZFQA==
X-Forwarded-Encrypted: i=1; AL+hErEmmmETIMWQkPR5TkIumA6ZWktg7OLau6JEDybL1fuLhbuHycyLGXds46rBqBc29z7OBmOLOF4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bfuTLRc8kieocXuRNQhchGbiydhDkkREZVmsnYN7JAF97fC5l
	eowQm3E40UntkNi68L/wcntexTnVnyFBfGCKFDG/B1hhn3zxJDYKxwVP
X-Gm-Gg: AYBFou1quIoHNCywj96xg9QNEKVoRGFY8FCsrcm+My714buoSmzmfcw3p7w67pOvFIZ
	cz/TT2b5m3FNjSKGZkynKHb3dvFWfZ8ZQEke+8TbyRrs9h1Rn21naaKALHPAgzNstapf6X6hn09
	16lrWFtqqMnXRJzsONgDzkEwpRIinVEnaupQs+R0lcciXFpPjigpa+xHcJjpSjWUCM5+5qapnUT
	orFRpo91UervkmxkCGuRuyYBrhjOLEDad1v6haiIpcoCQlsc4YaJfJIAD2OcLf6QRMEv48Mmje4
	tpnLcVgVf30dqNNuYbUpevEuH+8yn1xeP+vOFZ8zpgpbpPMl3oheTPPQUUszo4PSZ8SIv6PIvCX
	KeRXU6uVTDjULW7dYP8WuFCT2oDiMeYm2RUJLpC3PK3peA2tHDbWWpuk+8CHyPNP/CDzimgKORU
	utFoOuqgPIGghmKpGTGhLLF+D3YJ6OWZefZK37eNZtSOz7IW3gnIlLaFooLgsc7r9iTot5uFeXZ
	Hw/Cjn4ImFyJH4wlqloap2oR7AZz05hdBwMXkAvm+XQhtDzHem9unhuQmLGz8ify2ircwO2WdZE
	/EAkvkPm0Ex6S5sjM2bLQFkGvMqFQZWuNEOSiuvM85I2Y9/BRHU0Ytg+ge+IpGNoiGa7Sw==
X-Received: by 2002:a05:7300:10c:b0:369:f97f:72c1 with SMTP id 5a478bee46e88-36f771025d2mr8735252eec.36.1794065612157;
        Sat, 07 Nov 2026 07:33:32 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa96fe226sm17256890eec.12.2026.11.07.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:33:31 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: peak_usb: pcan_usb: cancel restart timer on stop to avoid use-after-free
Date: Sun,  8 Nov 2026 00:33:19 +0900
Message-ID: <20261107153319.3765325-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

pcan_usb arms pdev->restart_timer from pcan_usb_restart_pending() (the
restart-command URB completion) during CAN bus-off auto-restart; the
timer callback pcan_usb_restart() obtains the pcan_usb via container_of()
and calls peak_usb_restart_complete(&pdev->dev).

Unlike the other PEAK USB adapters, pcan_usb provides no dev_stop
callback, so restart_timer is never cancelled on teardown. When the
interface is brought down or the USB device is disconnected,
peak_usb_ndo_stop() / unregister_candev() tear the device down and
free_candev() frees the peak_usb_device (and the containing pcan_usb)
without deleting restart_timer. A restart timer still pending then fires
pcan_usb_restart() against the freed pcan_usb (use-after-free).

Add a pcan_usb dev_stop callback that deletes restart_timer, so it is
drained on ndo_stop() - which unregister_candev() invokes on disconnect
while the interface is up. pcan_usb_restart() does not re-arm the timer,
so a single timer_delete_sync() drains it.

Found by static analysis and code review; not tested on real hardware
(needs a PEAK PCAN-USB adapter and a bus-off auto-restart racing unbind).

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c..4c13195 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static int pcan_usb_stop(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
+
+	timer_delete_sync(&pdev->restart_timer);
+	return 0;
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -1051,6 +1059,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_stop = pcan_usb_stop,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.43.0

