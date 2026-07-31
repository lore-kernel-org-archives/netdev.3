Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096046C857
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522820; cv=none; b=ml/xowbg1xVZeJXQ7gVoAFnPdR3zFwIIZfeiLBnod6NckfhtnN8/dvin5Y+GbA6leEUCV9JYtJWKJhKYktEi/7O0RddG9FtJq478FZx8mmNFifj4imcz2Pt2eAoUZKfiXvZVdKj31CB9E3T9aJ7o28Z8VI/VEn/CiKpzSceQi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522820; c=relaxed/simple;
	bh=c9JcSWid4Tlze59tgR6pTgHi4316qVQ76fGNHfD+tYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i/REyqyv0Dlev3BTqGJqpe7k5niks6JYtJrmLSZ4xnQiFKr2X9V7OQrQZiZNEY7psxlfB7PsHBxOFJZovjDbAP0b7GIqYtiBuOND9aJkTroJBf6umJKWeddvYLOvSMtDQJZf+LviS2kiiBWzaau9/jBuypc9TGK57Ec2tYXNivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7Sl9o6t; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7Sl9o6t"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1421504f8f.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785522816; x=1786127616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SgvDiRBCDuNDz6F1z+I21byZ3S3YM0bsok3NwpDcpas=;
        b=l7Sl9o6tJOuOUX/nFSr9ZhSWXHwNLeFLOoCOucemlMRs+ucsgBZ/RN39CVanmomxGN
         uLl2XOsfqoFA2OpAUu0gbQ53FwKgIbpfpMJNi+ppQSeO30SQtCKB0hvO+GyTHMPJV45z
         PohX0FbObyNFHlJLrWOZE4PRma7On8AjOGrqrA5jhNkvu6i31KEnIdkar3yn0GX9zmzE
         cVMKt5R1eII91nO57//WGP6giiVWnQ+SYsRsy7D7aw8U/ykL/nPdp0HEVI+Z4sk31TNO
         i0NQE7twBejArj/2qW8XbdRZZPlCc2ZM+SWRoPOVmom/18SvStzRzopXqXlaEZHTG+DM
         LWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522816; x=1786127616;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SgvDiRBCDuNDz6F1z+I21byZ3S3YM0bsok3NwpDcpas=;
        b=F9p/mMQHw0jENMfChQxjadqck/MV19o4fReEyrDk7b6rTYL2MhP2wkoGV8srnC0U91
         H+2TZArJ4LOe/yFcEdPEuUpp0FqUupgKJOeX99vAawvmbIUSLTl+v/77BFXdJOL8nM6G
         1QvozFx/NeFinFoaVCXPCFGygGQqj3fgHBD87vkZmj0VNpDRaHgk+C6mkbWIZTkP5TdT
         bZYFTLBZ4mGEYKeLD0lnPuzSacQ/vxdRF/zYDpiz3s5XUyVjb5WWbjiAZM7b35tYwbtr
         4jPwHv0jWcvLQZO1oQ13aDadQv3UMrVT4wXiMClhh63WSyF2g2iAlEPSKG5AGdbxWC+p
         P0+A==
X-Forwarded-Encrypted: i=1; AHgh+RphbG49jqde2bIVH8PIC1cRI6YHyxEsNrN0+86qr1l7EXY/wZSfgW7K+5CZBdJcKkSdiuXVysw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiggNSfoM+T5ortAux/z8l/i5JprqzmZ4/Kojt8ZdUpVMhzFL
	47pgfQNVILB9oM4A6tHgLsafxVs1VyEHyhUVyLVTxGJx1IiWpQSFYMmA
X-Gm-Gg: AR+sD13JKvheIS6rJ2/C54g/8DV8O5/vb9NKJWsps+eZxLLtu5h7eOhiyxbjhUuJhF9
	Ae7v0jXj6NIhGEkTd3y7pxa17URd3LjNOQUoyUoOZo5mYeMtnKSjrmsNAdJBpofXzezIY2b+CnS
	mj8YGuqMHbaMNj2BGeqff8jzgMhO9qnpZZhL06SV0/IeZ3Ud2qYYXfQOfvG/8ubEHh5OPDbXg+M
	SPXSgnl5HQISwQKt/tLhtwyXXcSPIW+WZ5v0N2zohyqmE6qdNmuoriBQjLb38kM63BvLMwhUnGL
	bXwadnLRpYSkMjBTdn/bLDXG/xWTJZ9id1JttoDRCpjp5ZapEMAjYBhS5kY96rTYu+xvYuCz1M0
	b4V4eIIGe0kwrZvQD84tGqNAnFz8p+8g0OwSfPb4pPyfm+DzNXu+R2BfyClPaUiZWgnLlLiTZ1o
	bDdRkZcWUmCvM4y2QWIlaOQyiKg4mfgvagN1Kh6VbSxq+ZoOD4vNPodZLaqrEMgH1WaOrDcYkUU
	YbPdb/T7NCDfpMZdYFyfwJUcF494thsKcGKGBM2gt9/68FZK6nmnPmoxE/m+o+Ro18=
X-Received: by 2002:a05:6000:2489:b0:475:3a97:8e2c with SMTP id ffacd0b85a97d-47fd72a8634mr1552956f8f.16.1785522816037;
        Fri, 31 Jul 2026 11:33:36 -0700 (PDT)
Received: from ThinkPad-P15 (67.85-86-63.dynamic.clientes.euskaltel.es. [85.86.63.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1240sm7477683f8f.36.2026.07.31.11.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:33:35 -0700 (PDT)
Date: Fri, 31 Jul 2026 20:33:34 +0200
From: Pablo =?iso-8859-1?Q?Vallesp=EDn?= Aranguren <pablopva014@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:TULIP NETWORK DRIVERS" <netdev@vger.kernel.org>,
	"open list:TULIP NETWORK DRIVERS" <linux-parisc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] net: tulip: xircom_cb: drop runt frames before skb copy
Message-ID: <amzqfjeo0Yo1p0Rd@ThinkPad-P15>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

investigate_read_descriptor() takes the 11-bit packet length straight
from the device-written descriptor and subtracts 4 for the CRC. A
length below 4 underflows pkt_len to a negative value, which is then
passed to skb_put_data() as a huge unsigned length and corrupts memory
past the end of the freshly allocated skb.

Drop the frame as a length error if pkt_len is negative after CRC
removal.

Signed-off-by: Pablo Vallespín Aranguren <pablopva014@gmail.com>
Assisted-by: gkh_clanker_t1000
---
 drivers/net/ethernet/dec/tulip/xircom_cb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/dec/tulip/xircom_cb.c b/drivers/net/ethernet/dec/tulip/xircom_cb.c
index e5d2ede13845..62c64da1c8fa 100644
--- a/drivers/net/ethernet/dec/tulip/xircom_cb.c
+++ b/drivers/net/ethernet/dec/tulip/xircom_cb.c
@@ -1110,6 +1110,11 @@ investigate_read_descriptor(struct net_device *dev, struct xircom_private *card,
 					/* minus 4, we don't want the CRC */
 		struct sk_buff *skb;
 
+		if (pkt_len < 0) {
+			dev->stats.rx_length_errors++;
+			goto out;
+		}
+
 		if (pkt_len > 1518) {
 			netdev_err(dev, "Packet length %i is bogus\n", pkt_len);
 			pkt_len = 1518;
-- 
2.55.0

