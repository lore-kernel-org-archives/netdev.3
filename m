Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360942;
	b=bPGknuNytzc+YplPAOGUnLTL896+ujfI7HChqU4pV8iDBRbnTcQ1WK/hwMKgPG7H69Dj
	 Zy95DcgytSVWAWndjvahexZ0CTiGiG4YP57XGDdXhGYjvtU4CIWlBs62CqBd9QwkOh2A2
	 NQQ4OXJuxsybxxtY0QeNavIyhwAxs9j3bkNFOrSpHoCQAknB7TF4RsZea3y5fRnyou/hf
	 y7uS9Gv5wk0Ez8ieQGulyNmcw4cizDWRrX5dOtzbk/jV5DXNIpeAt5LeKMELu3sIks28L
	 63l5cxXxSVu5HfXy6mIXJarBbDpa9Fmt41o4vZo4FnE1s6KB+9TFlrGFdJDrUiJ/mAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pfQqYpokmZVzyF+aracTrgq2mm2QsLoqIsns9BsxbLs=;
	b=JJ29FnFM7ajvdtwseC+8s4sTliXbAVW13EgD3ETZMJ2d0+jaHcynF3nU5+Viw8Y6v3pV
	 WglvaqXcWFoMD+HB+7Wv4tEXqnKj5W/XvEbMfLquEXDlnNhfkONP1qJFlxtE2vrgIAY4Y
	 s6a26SU2IRVnHWckvHJbp5vl1V21pIwmMJrkJHLgNsoSnwh/alP/CPkbg/ld/IwpUIwAR
	 b5g3Ld4E4ngw/SRQUBh3zfOLZ6z17UxCKl94qmg/7Mjig5lIjduveKx63gUqLprwIIRkA
	 6ZwDTNtHM3jTnom0apD95bqCGuInggWWa9po3p1PthH9r54+w/tYeNReY7/6itosA7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=Bx+xqW+D;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9991606A333
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9991606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=Bx+xqW+D
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1ae58d17cd9so2128692c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1794360941; x=1794965741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pfQqYpokmZVzyF+aracTrgq2mm2QsLoqIsns9BsxbLs=;
        b=Bx+xqW+DV9goEpGGY/QAN0sUO8vxR2YZAfom2OG6TW9RgB6WMH5OunJGSLrsDWpWSa
         m20S6DoegeayR1BMrWO9L6DcrlUtGBpoATX4Q6C4xa2YFTzkVWcdWjI5dViI2bcu1aQi
         9mqL1FNImrGZ2sXzF/uXwUBiBHa9gMHCAEFd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794360941; x=1794965741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pfQqYpokmZVzyF+aracTrgq2mm2QsLoqIsns9BsxbLs=;
        b=Q4d3SXc6rDuq12Ci30xe2uGQvBfqszUtuoRSKC+WiKTUvJo9G0h9cq130FPqbC0tHc
         3rmCFxf8D9vnMwttvwEg2sfoUIiD/Vu578CvfXYHJ0TWUpZGhzujQCobh00aU2iIyKB2
         r5PWtKGQldcX/nM1K9xLBllsWQY6WC3MBvphobjpEsdsLXxBnI399Daak8XLw353uXAU
         1ReQiStmGvwCZuCGqhTN9gLarr7OmeR/gIKG8oYWYgokHNFDMfjFFSP1i3QIP2nWaXhL
         +4wBsijxCO2JEtokZmxw78lMO0YqRvOuhy1YGam2YPOCW++NbXnOVV0V1DxA/M1q8WEX
         TKtg==
X-Forwarded-Encrypted: i=1; AL+hErGHDbnkJ3zuxFqtncAXfNUH3kzNKC1BvfxmZkHKxHTwcwfMrlfAEDiNruiWAWnyk0ZiPCewwuY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5ylIbcID5LjyJ9ZadD/jkkXrE3bNc56o5qBXR/q9E9JwBqBFf
	Oozm9ZMHBEVgV3m4Qn9XplWRYJ3EEAAy4Ox3WMaAeQSi/ALjumya+Rvn2y/u0X0TGeA=
X-Gm-Gg: AYBFou3c+tLH7SBkwZ5pns2aNhMESK7ZauYFbDcG9L6MkhiJved4JP6GmRZl0Ky4g/Y
	ZvT5G4OiDXIxFcrO0FoSZTTpUweq3pHjD4xT6E2RM80SrdqzSD9rUBFOE1BZn1zxi5HdX8EKN/G
	fDzdVoMEA9lK/pfba32Uwv3uJwYsDxjIOduVjISXDZ8hJ30kAEBdlBjlcX8c99n+jJ8o57s6xWt
	5Dmfr05+a8PPZ6YmT1TPS5DhFZQZ3aVNmUGDnUNXgAF+6X3ctRpdcPlKysYV0PgWFt++rUv4owo
	EjTvLkkEj/DIit+vNwEUN/3snbS3NaB/l5egHG7l+5R1lhu3SyiwAEI2hgD5ccIlvVDpdfNyVJb
	90dIUvQ0kNdP3/4uOwIJWczdubIuJnzPYBzmvHhiw/u5B0Cxu8U0MqIMbcwKXe6bDmIrNE1+4pd
	7b5xQp8GBpGhc6u+UtCYd1WxxAgTJeFy7qOzpr+bYIObwTkqkuV0mVon2OzIXfSmTQpreCFQ+pV
	gAV2+YVNVNml5g75FTzKj6JuUeUw51KVRsspGQiH0H6X5VjCM9dWxwm5nZBQ34uG7Pfcli6t1Hm
	VbI68o1Q/G1i6/doWnhYMyUhMXi75XdaKfVFE6i0jEy1CtDDmcfMtBG13A==
X-Received: by 2002:a05:7022:671e:b0:1a3:dbb2:478a with SMTP id a92af1059eb24-1b3c0332a06mr1071478c88.27.1794360940616;
        Tue, 10 Nov 2026 17:35:40 -0800 (PST)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm9696223c88.8.2026.11.10.17.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:35:40 -0800 (PST)
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
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v5 2/2] net: usb: lan78xx: reject short register and statistics transfers
Date: Wed, 11 Nov 2026 09:34:54 +0800
Message-ID: <20261111013454.34542-3-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111013454.34542-1-law.wei.jie@gt.tech.gov.sg>
References: <20261111013454.34542-1-law.wei.jie@gt.tech.gov.sg>
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

Found by code review with LLM assistance and reproduced with an
emulated USB device (raw-gadget + dummy_hcd).

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---

Notes:
    This patch depends on the previous one. Without it, a failed statistics
    read would make lan78xx_update_stats() compute the counters from its
    uninitialized on-stack buffer, so the leak would move from the heap to the
    stack.

 drivers/net/usb/lan78xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 76c2d98b49df..4a58febcddcf 100644
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

