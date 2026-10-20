Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455664;
	b=EWvMdakwlkuNqB1i/2aaq9rvXdv2JifGC5LRz/J+UeyBV/GDo4AP0ydTlHg0fWqe7LKy
	 F+9r9X47590bEUuEtoukWJP841qeIzFpxlWKBfsZJ/af/jnFe8P0pFyUSBXyMjpudZfs0
	 A2zNWO+6oajrYKeEYk/kkKf7ZyB37F0dcNQqMaP84LcRmTGC34D7qN3WA57rvfRWCBm9o
	 QpQ6jdG5jXFmFGHy6ESgdCdq1WY1xzA28NqvuXERrtNUB4QPXxo8CM+WpwFUqhhe88jxN
	 my/qcTyexNucVtSi+E824dtltrX6o1D3e3u7dmzQR6GN9Dpk4XSkO4+Vprp7Ih5eMdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xBHf1i3knjux7GbC9NcrP8w6x+jKGVeq5oZiew9XRX4=;
	b=huirr3ownRa7LzLp1IfZ7NaaX/dVxWqw/S3vScqxOB8mPny7mkcK00onUR1BO+Jzxfl4
	 g/hbaDDa+wZM/kJKERTIhtB3SKO/V1HfD60J9fGZ9YAlM4bOFsTsrMhy89VCMoZmPCw4x
	 x3Jmyj57YjhohaVYtUsQdXpaZXy+p+xXf+Vf58N0yI8SyUUVr6B83M4pFSi6TfxbVoQcV
	 bVmHmNCUMaVYSICAEv3inDU+7ngpg8ErTPjgCiwujc2RBcpLAJpjz3+1aCD1J6dPQGicf
	 VKxMDzcSZdlRfzFS+AJqN1KoOzPaF/TEB7z3dC3Vnq5VCwhGUu1hs6eAEDpY4wVHo0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=NzPGYzfW;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68165606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68165606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=NzPGYzfW
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd3310348d2so83171a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792455664; x=1793060464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xBHf1i3knjux7GbC9NcrP8w6x+jKGVeq5oZiew9XRX4=;
        b=NzPGYzfW1WBjfwBOavoylb6rkxG7Bh3thkTixKBzQjgIlVPNNWwY+1+lTxDzqnof39
         wjZOxkOkeS76PtLwWa905tk0DoTPgNgw96iFiAmnfmMw3w6WPWkdWe7roBxc0Gl+vbEm
         w0MmkvTkYGhzElelY8ddSq2xdYktSmICX3ovs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455664; x=1793060464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xBHf1i3knjux7GbC9NcrP8w6x+jKGVeq5oZiew9XRX4=;
        b=ZxY0BNEY8kG9MAujVdViyQgOlqk3NK+cuFK4BIdmay/V/gZfLXm63gyCbIf6CWqCqv
         kwG5iWLpedJH2PyBx6yEloJd8lCwPNmStpyqk7H5VANDGLn4niRC9oftV5nhpMDKJWnd
         3xtH3PGVL/SUGOzvr+5d6ZouurozV+pCxQIwyZ9mAyAGmwY7w7FjMbnpxU4oVPr13v1y
         f5vhQEe1QCbcGpkHcFb5M4Oc9RM53lB7O8tfSLyiOdK4VM9q9XKq4EYa2v59tZGqvw2j
         uJd1s8Tg5zPwcAaIR8VeBYo2S+hn+3EKvvsg2r/apVtwvc8toSN3iKv5EAuaQbyBAe9m
         Jfdw==
X-Forwarded-Encrypted: i=1; AKwUvBwHRfP4zDwoRwPVVtgiz2A5yUQ502Fjlws8Q9FQwwqc45kyXTIeqLig2dDtXzcduUy8rPCaiCg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrvxQqOeHpvl75IQtZT89Cr4Zu6aLhj7N2Wxy96gHXONxwOyr8
	WgcfXPzgoxRZAX7BI6ykxMbsNFZDOrpmfkbzMKYaiWVwMYBpUjY5qo/bMvfckU5MZWk=
X-Gm-Gg: AYBFou3iQtUR1KQVdcrqPzpnIwLw4apiGoGMfhEW3oOf2fCzejuYokc0Kl6KWWdaw8P
	sHx4YwVu1lQaHt2FeHNcLsU5I3GGitu5fDVdvZeXbHpmvfbhXHdAdz5m06n2+18Ep1lzwZSjuR7
	oshw1BCx8x0RG1zpPVl07NhnX919NlwqeIR7KVTkz2mwtEr3qVoQtYyCy2tZpq0ULAB3CPXVNGb
	Sa1l+r6Ss6dMDW6hqXZMrCwVombiGu37g5HiAxsfsAQyu+HbIyx/k1DhUoqZphNvHR+GXqDgTOP
	e6YkD+J4/T1aHPMJa/emyOQ58evGoiWHtVYTlUZaUXdXNMl9bqHKjDzQt/eVCFO9RK9XfTrhzbA
	GIe50TWSdMm6aoRnCTdy9Yiwpd2wT22PCY9o1cOKJzLUaj6vbAmdvjhCdfjPLw8Z151n9aNVE9R
	GMaaPLhy0v0q/lYLsfWdXIIDYIHIHa7UXaqAoSWgHdaf3T+/5kFlXYXMKwFvj6IFE/VxLGWb2vs
	93ozfN+lPM+utupS/i0OQmasx3VQvN1sru8usi2FLIi5TTwLpUeHV8=
X-Received: by 2002:a17:90b:3ec8:b0:3a0:eec6:b065 with SMTP id 98e67ed59e1d1-3ad64ba5d2emr378689a91.13.1792455663750;
        Mon, 19 Oct 2026 17:21:03 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d6df89fsm1694273a91.11.2026.10.19.17.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:21:02 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v4 2/2] net: usb: lan78xx: reject short register and statistics transfers
Date: Tue, 20 Oct 2026 08:16:21 +0800
Message-ID: <20261020001621.2920-3-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
References: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
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

lan78xx_read_reg() and lan78xx_read_stats() read from the device into
a freshly kmalloc()ed buffer, but only treat a negative return value
from usb_control_msg() as an error. A device that answers with fewer
bytes than requested leaves part or all of the buffer uninitialized,
and those bytes are then used as the register value or the counters.

Treat a short transfer as -EIO in both helpers. lan78xx_write_reg()
does not use uninitialized data, since it fills its buffer before the
transfer, but make it fail on a short transfer as well, so that all the
register helpers report a partial transfer as an error.

The write path validation was suggested by Andrew.

Found by code review with LLM assistance and reproduced with an
emulated USB device (raw-gadget + dummy_hcd).

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Cc: stable@vger.kernel.org
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---

Notes:
    This patch depends on the previous one. Without it, a failed statistics
    read would make lan78xx_update_stats() compute the counters from its
    uninitialized on-stack buffer, so the leak would move from the heap to the
    stack. Both patches are Cc: stable and should be backported together.

 drivers/net/usb/lan78xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index cb8204371f5c..c19df8e80b52 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -612,6 +612,9 @@ static int lan78xx_read_reg(struct lan78xx_net *dev, u32 index, u32 *data)
 			      USB_VENDOR_REQUEST_READ_REGISTER,
 			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0, index, buf, 4, USB_CTRL_GET_TIMEOUT);
+	if (ret >= 0 && ret != sizeof(*buf))
+		ret = -EIO;
+
 	if (likely(ret >= 0)) {
 		le32_to_cpus(buf);
 		*data = *buf;
@@ -645,6 +648,9 @@ static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 data)
 			      USB_VENDOR_REQUEST_WRITE_REGISTER,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0, index, buf, 4, USB_CTRL_SET_TIMEOUT);
+	if (ret >= 0 && ret != sizeof(*buf))
+		ret = -EIO;
+
 	if (unlikely(ret < 0) &&
 	    net_ratelimit()) {
 		netdev_warn(dev->net,
@@ -695,6 +701,9 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
 			      (void *)stats,
 			      sizeof(*stats),
 			      USB_CTRL_SET_TIMEOUT);
+	if (ret >= 0 && ret != sizeof(*stats))
+		ret = -EIO;
+
 	if (likely(ret >= 0)) {
 		src = (u32 *)stats;
 		dst = (u32 *)data;
-- 
2.43.0

