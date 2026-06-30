Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01403EC2F5
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814357; cv=none; b=dM2lIR1BJbrDl08srRcowlIJdQZxCZZebNG9hlkb4h4Si7qjRnnkRivvBn/4/CZwyVizRxM5KAXdI0o1azV/n2mlggU4DLLEIrhRYprJEt7JVHfHPQ9ryDYaiz8NjLqy3hTsMkH7U58EQMyCOmw5oAHMJGNj7/ZGaG8xqQGdWjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814357; c=relaxed/simple;
	bh=fpVV70lRt6gaxeu9NgkMR0EjFnDbIYv9+3uh2IF88IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBzgtSvpUtzkT7ECd9ko2Ylk4Oh4hrIdTMcc1qBgkNh0odwjkypsRR4tCb7yqBYdiDKa1jH5nnmf6kBC+ABy54z6EY4aMmCQobbnZ4e3D5jFUFcedXKBu9GZv2S3XrcPW28tn1aFyS2VYufkaDgchXxDCY4iF1qcSwzVvvkilkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahCmdf53; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahCmdf53"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664c4a04081so1388239d50.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782814355; x=1783419155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ME3E5bLTc9knmTM+lqxIbMll01z0y4z3RLqE7f/es5c=;
        b=ahCmdf53tcQpDbVjnO6xYQeZqIqITEqGnTKbGSPt6OQUlf/x7W3ZMm2L5mgjrcE5Ho
         fIPTFoxDwA806NuteKa23Thn6h/8G/Cr5LUpPyvPu/d3LOWrXv18eD86LnF8GiOwHd5m
         5J1murSrwPBT8cEuf7Mq/8dxcEeaUkGOITZ2VE8ftuUXxqvcBimd3KgFzW4jVxHFwVBX
         LvduVyzK41DOiCU8WQXY/glowyhOpDKZa/8QixhaIGjsVBTyj4gifJLZFo4lYP13jEm2
         Ko910SOyuHj8CX4LyVh66XcUgH+5pOdJew3p/bBKjO14hrkfLaxCvtLnjBLT44nEt7KA
         v3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814355; x=1783419155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ME3E5bLTc9knmTM+lqxIbMll01z0y4z3RLqE7f/es5c=;
        b=iCh7c/U5Dc2ydkekQwVQzUsuwsFYGpD5TmF1GyZ8TSJWwQBIHvipBAOUR9W9Wcz/df
         4FzpVdYywgD++AgQdnQuhkGLt3TSiBsjfsEbDAxuU/SRS+TlWgiUjC4X1Ddk3Dx8nMbK
         Y4jSAbFRGrtT7ZGtECFjArPmQeZGrps+ivfVeO17e1Dl+XhNLF3DmDrSorEzkOKIWKyG
         hfMrv31YIXbwxWohqN4cc2QLGR08fTlc0ySMrPuuXkhYMm+4rNhxShoWU8vfdPZRH7ck
         hky1qSEZS8/De6RCfiE++ItXIpFZcy8BlzSmIPAKCPzIk2CpWgtrGDTuWLZIBtv3nLjh
         igDg==
X-Forwarded-Encrypted: i=1; AHgh+RphMjQQ+NovFbxCKp2F9RHo33JlCX177QeMUu/7ccBkGJ4OsejUowFgvl9KwXXQfkqEvf7ejXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqAd3mRFhrUhJRGfJnNLF/peTtr8CqyHtT2CGfssY6O0FMWeeg
	C1a7eY0iBY4Arl40+MDt/zJETFgl/t3FcTqjfqIcmmnbhkdfRcliwlCI/HqZw6qZG5c=
X-Gm-Gg: AfdE7cnrL4JRQ2pPfnnxKopUGn6Zlx8MJVGrqVjRePy8eTjFOpf18eZKFRo6r5L863h
	yKx2yj6Od6U+2l+P0j1xqUENCqDW9gn/33XQHWG+0XZFC9vr+S9eFVrh+yVT3p32FkNoGmVG07q
	Dl27s2/Xy7hRRDZmRpc/1u/jaddEMAgnsfQ1H1ENR0Z/pUWYtcSk6c16l5w3Ga2EDnH/cCoPlvF
	fE3/kax5tGF1R4VDVXVHrpBDbTCbRZFg7DqAHxkDUkE1U2WiHStTTmIAMytWI4MVU9AtxLVe16f
	b2X9UcYj8zAVpe3HM5N+Hmk4VWW5oxClJj4CBR6UsS8n+dI610Dx/qSxortSoq6NcyTlNrD4i+I
	WTwcIxO2OYny11XP4bZlCSVi5Eubk3rqEW63WRqipmeQJBuYqnZwbeBALkK9xg8R2vHSHdIkujp
	6Eez2/oRIloHh08rN7+iWP5DLANQ==
X-Received: by 2002:a05:690e:140a:b0:664:deaf:b25e with SMTP id 956f58d0204a3-664f940be22mr2947968d50.0.1782814354875;
        Tue, 30 Jun 2026 03:12:34 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6650053f901sm725450d50.1.2026.06.30.03.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:12:34 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: [PATCH net-next v4] net: usb: rtl8150: handle link status read failures
Date: Tue, 30 Jun 2026 12:12:16 +0200
Message-ID: <20260630101216.10365-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_carrier() ignores the result of the USB control transfer and tests
the stack variable supplied as its receive buffer. If the device rejects
or aborts the request, that variable remains uninitialized and the driver
chooses an arbitrary carrier state.

Leave the existing carrier state unchanged when the link status cannot be
read. A transient USB error should not be treated as link loss.

Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
Suggested-by: Petko Manolov <petkan@nucleusys.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v4:
- Target net-next and drop the Fixes tag as requested.
- Rebase onto current net-next after the 24-hour repost interval.

 drivers/net/usb/rtl8150.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index c880c95c41a5..d51e43170e03 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -732,7 +732,9 @@ static void set_carrier(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	short tmp;
 
-	get_registers(dev, CSCR, 2, &tmp);
+	if (get_registers(dev, CSCR, 2, &tmp))
+		return;
+
 	if (tmp & CSCR_LINK_STATUS)
 		netif_carrier_on(netdev);
 	else
-- 
2.54.0
