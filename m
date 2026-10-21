Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548229;
	b=3VjuFRHSXfRT/xEQX2njlTwBTLC6A6N5RBfuvpEclQKuuSwvqBzRjkfYhTQxK6+CIJF2
	 3zG7EWVJAEluwiHJXHbOyOLwpzk4oL7kXCsaGof0TfkoQGs7Y35VjoWi3sBPNPhDHXn4n
	 TmBC2H+On0sgK+N3K2V85SUbSH3tdvBPCh6mW9uOlJWYlX1C870VGTn7YlOVZnOU4mMI4
	 NyVlucztbqcRvFHVfcm3h/Y82LQwVjpqeGNgCcj6Frjy7Yv0o4JRf+9FHF+5RtjZJP5YN
	 VF4R0Q/sPeRlPqq53VgWfYdI4eYhlG7FQDyyfOvhhxX3vj9vZEkUdYrnVlVBbt6VWkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MO3SgQuzAg3V5kXrREryHNzNfwh74+uhBA2alimYoe0=;
	b=ydP7Soe3A7eSSzb8beSxZ2xlhK+QnhLm8+2Pr9ICKJo3A83zG/tL+dbcBvTRslNMl9Dk
	 TKPSLqS/YNW5CxHMKZsxc/BjJB4rkfPG/xODL7yOSoPBuTURYoeHiN3NS9S/H2mvvxn4p
	 O0E/a7EdbJYOjZlkuei1nB/FIE4Pyi8Iojj1+NjhofvE7z1FudOjZ+uOP6KqLJ2EUjdT9
	 OMbkjEcu+11QfkmqPfZJj8S5KmIr7LrGH8uVaw3X7I/IuDxifZbPrJw7m8uxgUIFovzBq
	 Vt3p76uDAH9S5Mj03u4KRNXbS2cqnu4Dpy3A0TNDIbHryc73MaDv5p9JpetAimhQ9uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b="h/m2fH6O";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A6606A32D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 674A6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=h/m2fH6O
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so203685a91.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792548228; x=1793153028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MO3SgQuzAg3V5kXrREryHNzNfwh74+uhBA2alimYoe0=;
        b=h/m2fH6OaMEnC6tFW0u2SOm4dnJ4dQnTTGMGtxG3gBMRjJpIgeYI5Ph9/yGfHLuJHJ
         l7DEoeCiqzQT8VtZedA4lPcgWm8kT617+FpU3o/RkURArUAMsXsyTQBykQWO8kfYGSZo
         Soi15z+FgGAS5L/q8tkyr6VDOm1aeDpEZElc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548228; x=1793153028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MO3SgQuzAg3V5kXrREryHNzNfwh74+uhBA2alimYoe0=;
        b=CxK74WjzT2jcT2+gWCwzVYCj4rIUhA9O6lQJC082a3ZkXkeZ9jQGD1e97mJfZhR+Wp
         mdIPid/bpdDp/XAnkaPZGYor54PWz3Wd9CRjcddfx8u6i6C2lS3Unzxh2CjaE5RAFANp
         xms+dgzxpEVpJpapndzScxiNi0qkXzjKg/WUBCN8UgCOHeIMZBE+vdzZD+f1knRb7PXX
         BzQRDhWpA1oDKu8zA0OvxACwHIzWneJ/gvAnsoRRoyyf9/DCQhMiBgt/sUm9DubkH/L1
         Ba2CFOPDrKXvPOGdhVWCqq3fPnOoHTeYdwzAtPylFQad75DQozFdQ+FQBVcbBbeewuGv
         v7Gg==
X-Gm-Message-State: AFq9FYJm0jNiSdTUKiot5DVuXbGvT2bLRhu3drpuxmQB/npqx1Wj731o
	2wTt6mVU9zHqd57m0sJZIPOokgfIQGc6A1z5OkmHKxHKalZCba19mqEn/hPI/Q1BNL8=
X-Gm-Gg: AYBFou3/LVfaGaLavrDol+Y7ADlAej3xovhZnTCgEeSJa9V2l6RwiqR/2bqtSOn39PI
	2DWGF4uF69GiFgVVg8+qoWoM5fh6wLKUqN5D/dS274M7RYJzpsJxj49r9RjsfCeZH2HJSHXasET
	zcMQ85rbgMh/zg8IJh4SgN+NglvKvLFOjqMMdUlDhgMTdIIQXwlERMRQPyqrh1kI2PoIyzA6LiX
	sFVoBba26kOtPpRcvvdDNTj3qEV/2RJwu9I2gxblvhaE2NelOvZDw0nFoqfx9udDslB+cVwzK1/
	hl7XkBWOZMygbQbV1Ueuu0q2QCDmcR7eamShpnvwfspi31ljOqXbjVrZj8rLVxMGRhGE6tRbMDt
	WuKwBgSQfiV9FAzix5OLC+PMNfQyjyZWgg1oFRc51u6KPHLI6+Jl+UvTPW5mHFUwvv4/HbPGXJQ
	gJSKjCGBTq8zTfV1qXdSewk/4qjLrEwM4Hg4ge0GUrGHblTKQGgtKeBzsvWFYpqqWAywJyQCVva
	zXayDDyKAt0cFtxkSWaIVu2nR/g5FuQEd/vrGIe1dWi2Wbn/djlvJjvZjJnR+fmyrYcJzrMHfMy
	UcRJ+OJm+Q==
X-Received: by 2002:a17:90b:380e:b0:3ab:2737:3395 with SMTP id 98e67ed59e1d1-3ad86f73897mr573324a91.42.1792548227728;
        Tue, 20 Oct 2026 19:03:47 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([203.125.131.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8035a117sm1934124a91.16.2026.10.20.19.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:03:47 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] net: usb: pegasus: check rx pkt_len against the received length
Date: Wed, 21 Oct 2026 10:03:10 +0800
Message-ID: <20261021020310.34045-3-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
References: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
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

read_bulk_callback() takes the frame length from the device, from the
receive header on the 0x8513 and from the trailing status bytes on the
other chips, and only checks it against PEGASUS_MTU before passing that
many bytes up the stack. In two cases the stack then uses bytes that the
device did not send:

- A device that sends a short transfer but claims a long frame gets the
  stale or uninitialized remainder of the receive skb delivered as
  packet data.

- A device that claims a frame shorter than an Ethernet header gets
  past the check as well. eth_type_trans() takes pkt_type from h_dest
  and the protocol from h_proto without checking skb->len. If the
  transfer is also short, those come from bytes left in the skb by an
  earlier transfer, or from uninitialized memory.

Drop frames shorter than ETH_HLEN, and frames whose claimed length, plus
the 0x8513 header, does not fit in the bytes actually received, and
count them as length errors. urb->actual_length never exceeds the
PEGASUS_MTU sized transfer buffer, so this also covers the existing
PEGASUS_MTU check. Valid Ethernet frames are at least 60 bytes long
without the FCS, so they are not affected.

Found by code review with LLM assistance. With an emulated USB device,
a 101-byte transfer claiming a 1500-byte frame was passed up as a
1500-byte packet before this change and is dropped after it, and
frames claiming 0, 4 and 13 bytes were passed up and are now dropped
and counted in rx_length_errors. The extra bytes happened to be zero
in the first test, so disclosure of actual kernel data was not
demonstrated.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/pegasus.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 7c7d6b69998f..68e4b6658dd2 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -520,11 +520,17 @@ static void read_bulk_callback(struct urb *urb)
 	}
 
 	/*
-	 * If the packet is unreasonably long, quietly drop it rather than
-	 * kernel panicing by calling skb_put.
+	 * Drop frames shorter than an Ethernet header, because
+	 * eth_type_trans() reads the header whatever the length, and frames
+	 * longer than what was actually received. Passing either up would
+	 * expose stale buffer contents, and skb_put() could panic on the
+	 * latter. count is at most PEGASUS_MTU.
 	 */
-	if (pkt_len > PEGASUS_MTU - rx_offset)
+	if (pkt_len < ETH_HLEN || pkt_len + rx_offset > count) {
+		net->stats.rx_errors++;
+		net->stats.rx_length_errors++;
 		goto goon;
+	}
 
 	/*
 	 * at this point we are sure pegasus->rx_skb != NULL
-- 
2.43.0

