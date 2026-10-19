Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421713;
	b=D/qLXu7x/mXP5DeAgTEIoHWSyYIqnRnYJWUznm7WUgJ5sKhC5FzMrVy9Pr3pmw2TxYW5
	 LZ+hXJzGpRWr2ZLickwoudNBCd1CKOU7Q0Z85fwYtQmtpNE2r3B6zOg9wv0WP0GhP+kSI
	 LHS+hov2hzb9tQbRhG9+ZCZDl7ZV+o4W+EdMHbeQchYrXBapnTwAP9O50eiHhD7TWkP+n
	 GXmUk1qzjN4hMuBbtV9Ec7L1rMHprRsBSwra84A9hN+PZx1i4l9e6jp+o9br+mZlDCTpG
	 jOYzVKa4WmcHHxPihEQH90GzTy7HQV0p/K0Ba7kxNtOHZdGJGQq9eXhJshzaSjjuCYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421713;
	h=Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MmAvYMzYsSLV9YGDTAToTSx5qORIoNpIq25+Tdy+3Zw=;
	b=Iy2keD1+FQZRUOnQlm/qWjinJOkAgRJOxo8BXMLlFAjfce1/tV4jI5EBJD9/hDTockiB
	 OycfNVfLu/lHl6eyqXe2bC+VAxGG7fGwPWrqYgSsjrbtYBpUjM2HVJqqwJyl8jn3t4o3a
	 lgSfKjztAKRUDl9Nc8S148fFT6KXgxCkGqd0WgunnbdfWDlItEUhbZdKmHHwkXMLSIJ+S
	 rLB+I+zW1C/gWzMWq7JpNsZXfIjo+JokywTi8uocHlzKPA/0xXFrxCRytEv2is3y8S5R7
	 vaovotPd2k6QBVukP4kfgbsKmUO8GMqjvwyELdEolfZnatFW1Y1hAMLmptFVT7lj34g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fnhsvt9K;
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBDD606EFF0
	for <netdev.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fnhsvt9K
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8376513C1
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421713; cv=none; b=FL7EiDQ6VJqCUZNFtbPL3h5cf2W6OhVRkyYQbT6zzehFFOjosMcKJStz1pELk8S7f5zDMzgyk1NuoLlxXNhNF3tGoi8KU+9QaP1u9hPkzbQdH+CrBv35acYlY6Ij4TbOd/HLubkuNIWPrybQXly8MpsZZiVpwJD4O3WhNT0DtZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421713; c=relaxed/simple;
	bh=RLy20rUqp920ststPilGHR8safvwyNqGX8plEY72uGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d70FAGy1Zkxz41TcII9JYISOJW1KpURWoMFJFi+fhM2hYvfsnoc01bxvItiT8IB/m25c0aoUhLCXFO5xiqv0pPAiRyZ7idiUC30G8vJ0Zv57q60EGMrU4cVpplY3E9e3Dqcdm2d75ZlRVaa8XkD3SfOd1VDqvhM+WxIN1MVdJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnhsvt9K; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-353804b591eso4220252eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792421711; x=1793026511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MmAvYMzYsSLV9YGDTAToTSx5qORIoNpIq25+Tdy+3Zw=;
        b=fnhsvt9Kbw1KHj0wOt6IqTMP+1DcDpUsv4BTYunt5bj0b8ii+uHxtylm34um3hiQOr
         yYQ/z8AWiIF7yBb79h9Ne5A+LFsYYnif+sS8cWKpfWO1SxbhT64IrzvIVr13sG0zcdXe
         BlhPc/RHgKns/+w3vSZAOr9PraRqKPrtVheWj5zx9uzoYHhhPRQU6Ta1JpssPAgHFRwQ
         biSv0E5Mmq0KH33gTcNH+XNmqI97O63iY/vEcpqDcT3FCi5J2sM0zealfq0Szv5UXXRL
         97Z2C/xW4D4lFZ3moB2iKwe/pwDRaAtJvw9sZEXrwqlhb4BvHpZqxD4VOWhzoar9DR4M
         I1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421711; x=1793026511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmAvYMzYsSLV9YGDTAToTSx5qORIoNpIq25+Tdy+3Zw=;
        b=VSkA7nwTulyMdtN5w0ARqG3qqJBHv/ZIn6J0tyZw2tPpS1h/Zf6cEg3yiif5j2KqPC
         oeIxS9EdGOr89W54+/BcNwdOLdw5lh1c+MPLxJOGyWo+DLUAOgMMKHzcOOIfJlzhSsLl
         MGb2eZMdETYLhM29M+i8JcWTzcqkwCoCnPxTaYuqf2/d9aTEvCkmxHTrwEq12kKWNCPL
         Rwul6gcEApc7LsDoh8CeBhzhxtaKQRDsJ6/IAPJ0q6nIzluyW8Qs7l2ykGAQ6X1lbHE/
         cFtb+qS6jGx5Hr14xP8bZyX6qHRK14gOfZKcpALydVpzTlRnvYQkDbKSx34OihYZc8iH
         JHHA==
X-Forwarded-Encrypted: i=1; AKwUvBy1T8FR6jL6/GigCTe+SvvhaYZpSOqOJaLa4MAad4kncsY8CztUmekniz2FWqLEiDSz8HnzJ3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAcQf9nfch2vRvCmFEHGYBOyJxmM4EqI0JfARVC3Cn5TE8vTBZ
	fQ5x5ok0oKSORI9Nb1iQWpHOpkgnhjWh1SxnHa5iK5f4c//qCs9OeJZHpQVkdzOS
X-Gm-Gg: AYBFou1oBj+n9oBKOmMVm9iEWRGm1cI42tiiuYvPf9F1TfCo2oJuju74BjQK4IRW3mL
	IDJZJv1D8EYT7fSqm51fRN5rFDP55SF+IafTbMvo8npXRqX31ziyGPypV52B3b1gJL+bondWDxk
	/jIKZnMw88gmXdPN3wI1yYwvcrDlmoY07s8+AWt2dra3St4i46mHMh1tUcDzv2cZyEYX3tPRi8J
	GKwSNXN8HG+n1oDFVP12rIpAGyb8LV4Z3o0O91xEhgXvb0FvfBQKnIJ+o9+Elzk87Jfm2kd3GV9
	SRe4FHVqHtVK5pteXe/62Lgz/ODWP/H3r03tDqh1Y6WveOUYfx/GbP4LNKAQC4kaz8PsboVJsdA
	SVQM1vaSlawvOdRuVGnlwYw/ywH7X2qJ1gEEMTUbVXFFW2i7Yf+XD2DcWYH6Tk2UR49OcB4eGie
	bQ9X+Zr1Gdv7HJeKXWjiCbE6cr3L3zQ1INyfxXU5E3s97hyflovYa1w44Fqzx+EtLDIXW5eA==
X-Received: by 2002:a05:7300:8284:b0:358:bbb7:88da with SMTP id 5a478bee46e88-361a234c05emr10464488eec.32.1792421710542;
        Mon, 19 Oct 2026 07:55:10 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7a80:50::3cf:67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082e81a06sm31590887eec.26.2026.10.19.07.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:55:10 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com
Subject: [PATCH] nfc: pn533: bound the OUT URB wait in pn533_usb_send_frame()
Date: Mon, 19 Oct 2026 21:55:05 +0700
Message-ID: <20261019145505.176036-1-ngocthang2710.1999@gmail.com>
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

pn533_usb_send_frame() submits phy->out_urb and then calls
wait_for_completion() with no timeout. During probe this is reached
via pn533_finalize_setup() -> pn533_get_firmware_version(), with the
USB device lock held by hub_event(). If the device never completes the
bulk OUT transfer, the wait never returns: the hub kworker hangs inside
probe() and every other task needing that device lock (e.g.
usbdev_open()) hangs behind it.

Bound the wait with wait_for_completion_timeout(), using the same 5000ms
that usb_bulk_msg() gets in pn533_acr122_poweron_rdr(). On timeout, kill
the URB (usb_kill_urb() waits for the handler, so the on-stack
completion can't be touched after return) and fail with -ETIMEDOUT,
which __pn533_send_async() already unwinds.

Fixes: 9dab880d675b ("nfc: pn533: Wait for out_urb's completion in pn533_usb_send_frame()")
Reported-by: syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1c5368988052dc2d8201
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/nfc/pn533/usb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index efb07f944fce..569b1915afc9 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -184,7 +184,12 @@ static int pn533_usb_send_frame(struct pn533 *dev,
 	if (rc)
 		return rc;
 
-	wait_for_completion(&arg.done);
+	/* device may never ack the OUT transfer: don't hang probe() */
+	if (!wait_for_completion_timeout(&arg.done, msecs_to_jiffies(5000))) {
+		usb_kill_urb(phy->out_urb); /* waits for the handler, so &arg can't outlive us */
+		phy->out_urb->context = cntx;
+		return -ETIMEDOUT;
+	}
 	phy->out_urb->context = cntx;
 
 	if (dev->protocol_type == PN533_PROTO_REQ_RESP) {
-- 
2.43.0

