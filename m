Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210294334D9
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900575; cv=none; b=tZ5R5OkMKfHG6WUbHk46NrlgNX6VZfHXYa/vimavsQacGavgPxnbwSfPdI6ZjnGRoqXKa+N4Nm2Q08pjuI6EF6AJ1lKK95U47x5MHuuOOpmXq9JUJpwZ7hNwhxq/sJI8RPsy/hG5De7omuvZE7CTnvn5tvcRXZbM6dshiA9gjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900575; c=relaxed/simple;
	bh=nmS6H4FTGfwQIoCXwTuZi7xAO3R/0s18DSvjvFnlIn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5NPkmRBRf6HWsHTvAnXPgnpVNbIfDVcmOnocX7YYq40aoOLgnNFkHutw9Aq2vPWQ3LMVylX3D2sGdlq/j3K+f4jVliQ/bgWVjUO8JVnfAmQEyDlb9ZXRs1TULDwvtdJ7FagZDxfGkEPe9vAzqigXccaQ4BSXHmq7+WkMfAidnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=TUoORDvp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="TUoORDvp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4957eefd361so4048035e9.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784900572; x=1785505372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hzokFwbqCQcQa0BrIKwjqqwQpe6YFNwdchqjati0oWs=;
        b=TUoORDvpHUE7jt0UnLuCr3U1DxrW1G21GQgo3dKWkZcHd67wMIhjWYLOZpzrdyDPsu
         5YvUsIVX/PSk1ovTgm9VjNpZKxy9fk7UMdgzEvA+eoagaZM8kd2jZ3XTfjVe5YUE+lie
         3oM2VrJQ2O3B774l0Kq8vYrfIdrh9k8iR/6LfhWA6+W1ejXsVKsHwisfRujj3Z20yiwq
         P4hdRTJuuo9dTImnEgZi80LbsjPdAydRtnmrY9A2AoCBiJ7fTo4LFaBTEWOX4yNFQ/qL
         ncUnT5o629xMIGHgLeJ0x33MJ8H6js/4J3Dc0bd/b7RfzRWtI95UrXU1P9E0K7VeVwKL
         HZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784900572; x=1785505372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzokFwbqCQcQa0BrIKwjqqwQpe6YFNwdchqjati0oWs=;
        b=GrZlf+X2XQnSJXQH7kkT0mQ+kJmhDgOs+5SGySOrYO9l+1OZFhVF2u3Tx8o5PKgYx1
         y9d2sWlkM/W3N8gYmU6BFPbyuBidyeKJ3C8JIxQCkTBW9a6Q0GgiuBikWiVe01j8laMO
         AeCz/uDfaeEpYKc9CXZVodFG8treEXX8d1W/vRkpgegJfHo4TeznxYIFMqMJIaZn9r0b
         oJEcL1bTNjR/62Nl0sjEV1lRelHptRUaQUFrlEoQyPeoha76QJKpKouNRRrz+MOiJQnk
         Ex+S7Tnz8MvyYRup8NTJFFpjz2MjLI/5/v47uzVheA3s+CBKjT3ekyrzfageUGv3oVuC
         +G/Q==
X-Forwarded-Encrypted: i=1; AHgh+RpDa+AXKKFKhpreAKn9A42kWV4WFXOudEZMc+lXD81DduGU+6SGV2BW/C25XZ+nF3JDOYsJVxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzp1F+r0XWzg76zGB3VlplACE7ur8xx5+lA4Q+p6gnyhRp+dD
	xfzVqdP3qjMVGDfmMbhVrOK8w3jMCCrlg4Ai6pz/A6YfOx1xrH5g0oeCh+3eeIiyKYQp
X-Gm-Gg: AR+sD11cSEzvyKC9F8jjzYcC2sSzsSL5qmwGAfetnKDhUXm0A2OZt2k2Q36w3iLTX8a
	ELW7s/bFthmZdEw/9KFzAaF7nSUpGFpL7i//dj/9Z8hKSR1PRn9O1sxv+0rVpUkM1YsaGZ5d0ee
	6I29UOc0q+3P+fHS0rcdO54TR3eelastp1tSOKFBbxVADXcKI/AosQRLHdxSmhF2DJlYHHWdFoF
	FeisZQkGWVC6LON5STC83tgKsC997GpKRPN3qxloV7IQ3LI46PEQX44WKcp8fADnIkgKVx6haI8
	z5qcSetGMcSfyyBG3aYpCNAogu9fsSLn9nYKEiuvFpZ2GTu4rDsBHA9gYjMUsgNVrYqj7zOYgjD
	7KhCJFkVBYByjpEM6IJ4pbnDPijM8r/Ktq6c4g4wGRRuNJe1h5lhJKVUZsAfveutV/muvZQhg0n
	Hhg2senihTAgLmHSzLAVcNDvXG2pjBWnJCtDUPuG15BONuvXiqgYd6DO+C5KihKAHslvHfGt2Qg
	Yo+a1yFqBOB4TI+8vKI4f5IyA==
X-Received: by 2002:a05:600c:350a:b0:495:441a:39d2 with SMTP id 5b1f17b1804b1-49573cd8932mr92373025e9.21.1784900572398;
        Fri, 24 Jul 2026 06:42:52 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bd850asm23982836f8f.15.2026.07.24.06.42.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 06:42:51 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Alexander Kappner <agk@godking.net>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: usb: ipheth: fix carrier_work UAF on disconnect
Date: Fri, 24 Jul 2026 15:42:50 +0200
Message-ID: <20260724134250.34360-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipheth_sndbulk_callback() re-arms the carrier-check work on any non-zero
URB status:

	else
		schedule_delayed_work(&dev->carrier_work, 0);

ipheth_disconnect() drains that work via unregister_netdev() ->
ipheth_close() -> cancel_delayed_work_sync(), and only then kills the URBs
with ipheth_kill_urbs(). usb_kill_urb() completes any in-flight TX URB
synchronously with -ENOENT, so ipheth_sndbulk_callback() runs after the
drain and re-arms carrier_work. free_netdev() then frees the netdev
whose private area embeds carrier_work, and the pending
ipheth_carrier_check_work() dereferences the freed device, a
use-after-free on unplug while a TX URB is in flight.

Drain carrier_work again after the URB source is stopped and before the
netdev is freed.

Found by 0sec (https://0sec.ai) using automated source analysis; not
runtime-reproduced.

Fixes: bb1b40c7cb86 ("usbnet: ipheth: prevent TX queue timeouts when device not ready")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/usb/ipheth.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index bb1364f85bd1..fdddd761f83b 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -672,6 +672,15 @@ static void ipheth_disconnect(struct usb_interface *intf)
 	if (dev != NULL) {
 		unregister_netdev(dev->net);
 		ipheth_kill_urbs(dev);
+		/*
+		 * ipheth_sndbulk_callback() re-arms carrier_work on the
+		 * -ENOENT completion delivered by the usb_kill_urb() in
+		 * ipheth_kill_urbs(), after ipheth_close() (via
+		 * unregister_netdev()) already drained it.  Drain it again
+		 * once the URB source is stopped, before free_netdev() frees
+		 * the netdev whose private area embeds carrier_work.
+		 */
+		cancel_delayed_work_sync(&dev->carrier_work);
 		ipheth_free_urbs(dev);
 		kfree(dev->ctrl_buf);
 		free_netdev(dev->net);
-- 
2.43.0

