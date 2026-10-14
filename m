Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988DE3A3E68
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946414; cv=none; b=GlFeE1XKvIgC2vdn/1w9/ob7nx7KS/crrYqdfwrU/udDyUj4ik+g2GtkFE084SgsmIc2IObTXGii26OP8qs049dXOJx/rMV6RWaX8ikkTP1axq0z1sRPQnbVyf0wW8qGX3PJ6BrDWC55h7tGJltTDURvIy2n4usUlS30WnmW62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946414; c=relaxed/simple;
	bh=/Egt3tz5Hs7aeJWjwPyFfGyEMQF3bDb+gjjLGnhPmKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAI9yFcbs6SZkpqF+Y20PRt80LyxE3AvFwW3y7qBKnOSsuaOAPEnlxGRRFp1/OVZ2GcIL/CXHse9rizEId+5ZGCNcZCydizIbgHXJRNGRdf1/s6f8GJAsJkAFEH01qMeRj4cd0DLKm2VEkOxhKtbXo7xYNM8elj4DBk3kFjhp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=uD1MIHL2; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="uD1MIHL2"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35834f72d94so6606618eec.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1791946412; x=1792551212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SsN0OFGAaeGLWTKOy2XE6d+vAOcJRUzLtjGQFjg/b5k=;
        b=uD1MIHL2/gskrJIhLmBhzEKbDYhu7DGRPo9eL5+WTQPad0DrX3AI3N/EDJQuCXpZGi
         Me0IFVb+PQhbAyTtubk18+RatZxZC7huukcazJyNk2XAjFtwRYLL8dFmw5LE0kk5IKHO
         g88nyk8Vgi+Tb1ipY9IYPbFSLrmam5wEjph9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946412; x=1792551212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SsN0OFGAaeGLWTKOy2XE6d+vAOcJRUzLtjGQFjg/b5k=;
        b=ZbG3mvppWiB0ZgtRc62C6qKc65j0Oo0Eu7fWq22OA1iZR3m9EaKj+X4lmVmFwy9ptw
         AWwkIlLMABADX+W8xeLwdvOn4jbnSLeDqtlgC5fVwh2SciW0ncaNIg37R8qTaJiyMdmm
         w1Ont/bMeUVvPQLfbW6g0IHijSfpemhKcCTGOESa+xfF4J/tWEHsyrdmblZoPEjnAHZB
         dDWBDBMNDGVw8WXyDm8QU7LiFcLfHSGIIDCswL/Xlq1sYxNptVch+f/rz41ry1+xq5/m
         IB5qe/SUjsTNbNB4ZznJDldXuYFX/UY6mP5h7incYmhUEszsAJQeSw55vx42zcS6JRVh
         fa+A==
X-Gm-Message-State: AFq9FYKoyrMd7r1+YHDyRXlzZAz0AaIJFa1iPl1Fpxm3P4yLt+ZHNVE3
	dk0Wz9IfkyrmPVLyTb9zSFcFes6Sf8OFM0x9f6QKi6TTP5/BmDpshNzrX4q3rYaTIBI=
X-Gm-Gg: AYBFou3I7hVy0tTpRVr9wqhsgR+5iu4bY3ghhMoH7qxY+gzdZITwJJneN0w7gzZhAV8
	RVXDQEhRlbQndaTwbXUOzJgWoJh02+v/O4uO1DG0f8Yv9EA9Cmr93ws5l91IihwYhfkoldGNS79
	TAJyxFNPfw0WQqu/TOWcVUztNQucahurTP885hjPg3hG1d/J0gwJZckzA0yXp36vqjawYaoHKCw
	Ac226MC8rG4SlFbJMY8rWYo85OmNoyvmU2LmwgHVLb1ioeS6mLTIyOlps+4PphSNrFnnoIYiHLg
	fg+D/cE25xcmnaqBf20wzTMCElUbWCDhMXFvhUc84Zo4Yx84spDkI3/Dr0gSPG1cFoarIf6Mc6O
	vNsVeFMCmWAzzeU/Q6dYSoslC4wjhAcYZh/Aoz7R349PQPPUqk+bV7yoEaz3xVzhUIMJd2v9L6v
	I8dDmitHPZGxzesOt2sRIhLlScp9KPafdfT1kZuhtaH3UETeYolchvMJ/Jjc0cgeFOGKVJNvLcI
	K7tL6fGTMqQwqmQ4FvgwPbLztR3
X-Received: by 2002:a05:7300:2c01:b0:35c:1567:7966 with SMTP id 5a478bee46e88-35c15677c5dmr6988514eec.27.1791946410151;
        Tue, 13 Oct 2026 19:53:30 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm46522557eec.28.2026.10.13.19.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:53:29 -0700 (PDT)
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
Subject: [PATCH net 2/2] net: usb: pegasus: check rx pkt_len against the received length
Date: Wed, 14 Oct 2026 10:53:07 +0800
Message-ID: <20261014025307.25233-3-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014025307.25233-1-law.wei.jie@gt.tech.gov.sg>
References: <20261014025307.25233-1-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_bulk_callback() takes the frame length from the device, from the
receive header on the 0x8513 and from the trailing status bytes on the
other chips, and only checks it against PEGASUS_MTU before passing that
many bytes up the stack. A device that sends a short transfer but
claims a long frame gets the uninitialized remainder of the receive
skb delivered as packet data.

Drop frames whose claimed length, plus the 0x8513 header, does not fit
in the bytes actually received. urb->actual_length never exceeds the
PEGASUS_MTU sized transfer buffer, so this also covers the existing
PEGASUS_MTU check.

Found by code review with LLM assistance. With an emulated USB device,
a 101-byte transfer claiming a 1500-byte frame was passed up as a
1500-byte packet before this change and is dropped after it. The extra
bytes happened to be zero in that test, so disclosure of actual kernel
data was not demonstrated.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/pegasus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 7c7d6b69998f..7bc9312eaa9e 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -520,10 +520,11 @@ static void read_bulk_callback(struct urb *urb)
 	}
 
 	/*
-	 * If the packet is unreasonably long, quietly drop it rather than
-	 * kernel panicing by calling skb_put.
+	 * If the packet is longer than what was actually received, quietly
+	 * drop it rather than kernel panicing by calling skb_put or passing
+	 * up stale buffer contents. count is at most PEGASUS_MTU.
 	 */
-	if (pkt_len > PEGASUS_MTU - rx_offset)
+	if (pkt_len + rx_offset > count)
 		goto goon;
 
 	/*
-- 
2.43.0

