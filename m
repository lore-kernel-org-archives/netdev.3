Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435F3A9851
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957433; cv=none; b=lvzuv0rIbbGZYS62udy/TSq7znY6b/W000aNI9R9Mn2+8UFdGji0bsCgcu6KD9gEy83RDBhTp0yAcQ/+8ZbawbeutCBYcV/Lr1UOVvga1KEPwxAwASGVl7wvjxMr2Cz9srme6mbMklO5EtsnweLoLj7tyTpOV52eYU2u4Da0MwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957433; c=relaxed/simple;
	bh=MLNPjPUHbKOlsJaVqCvV8r0JMmFBKgzKjDlfjpRlg0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTadShPzeoawbkrCaNwqKjyAzTjNsYOkYJud7oY2FVKXktwWtuhZ239lbNIbS/P0cVHCt4wCFuROCwJPTTJajNzhPYSg05j1o/A33u8UdPOCkCO6A7DTmhdRlNJUU/CSb19QzeOAimWcHQufMV5N8t41p92zggQ9T7x4Du4WBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPdw/rsK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPdw/rsK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84faf87d19dso3256506b3a.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786957431; x=1787562231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4+uxlm79Q6TJohMinCS43/loV24iAAfE2vW9FKZxxcA=;
        b=fPdw/rsK8jn4g+0Xfeb7fC4asV8DmZc1oxUWUUyXMcpVEvB5JnRpkYjsP77DbPMi9j
         qOQbcs7eW4juIAWMz96qwF5Kr8ShQ0DAit7sLnhEfJcLkYIDKcYXCebTT88tBgyU9pIx
         xlmk24lEqKNsuSqwSXpPM3BEr7BH0fT6cZRGCfeQIFDNAS5/NUjd4sNxSd0w3J0Awl8/
         c+Zj1UFKjnlcMy2O3G0Q/aYll5jDVRmbc/qjTt9EY14Bc1AVYRPNyRKOI+FXIc3cOSSI
         C5HVM8t+lctGRp0X3W4RIopD3buiCK217pnbuFHQ2Xbw3S4WSndBMbgKbO8BdjjqGy7Q
         0c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786957431; x=1787562231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4+uxlm79Q6TJohMinCS43/loV24iAAfE2vW9FKZxxcA=;
        b=BddVZiXLeJGqv4PcdA+kcuO1+XOSC5DyZRhgDoNchJxEKIV55IAgFh0TdmM68mFtUT
         pGPUvvA78QDFuwbzz910i8wPvippFK0mxumDfK1LJPsIpkXvcBJhVOX8eI4j6uN6OLR7
         r48UPQxEhEaxbY2k+yeiocGPKjxcraSVhQ0+1gEobieoss9Z9MLinaKwT5dUAcQuiOpT
         GZB8mGozQPlR/477e/9wadlxMySQHHk0ki0v47nbl2q60f98vvComDpGZYZyhIqzkqFv
         H+k78rFv20FcL/vvD0RFwUgZnFhL2q/tmgsYI1qj+21DABBrgaXsdheRA6Q85NAeb1CJ
         LwWQ==
X-Gm-Message-State: AOJu0YwIF5eC9Z+eAsXvmo7JujTb8ELenk8usGkMDdmpvj9JjzE/IURH
	ee/lIwa7jT+qK8ncsFlZLQ1Zj30t2s9QUBEITcZ+WXurtZszAx3CJePWaNEkCg==
X-Gm-Gg: AR+sD11UqG8LyXFpx3vYwYQ6EPKp9lIYtn9dozxwvsCck8oR9cwPfBTLHwMvAWVto9K
	DkbrVWh9+HAKCC/PdHf54YNIaza0WrtSz+jnQFk1ftILERTC6rPlQ+x9FRvyobLLcY/tkspOewV
	VM/twHlPefgPBs/YuXGDY94fWPz+0KNnH7SuRwGxCefKqKGjnsFrFin/es5SCTbyu46KRPfGGgv
	vu9BHV3rbBhr03ZRXawOTfsuFKxEmO/oi3w52n1GO+bTP2beK3rUAAsdJ7uA1cvAjHWA8g4l3Ih
	Vbv/guY2CWiwM1en54mNKlHLjobH3nZbFaJFA3qLNi5+g+nMVQxnAEoB4uVTgIEb5g93T70GDJS
	JTyf69o/F3ycNDApE2kYp0I/p2l1kCofiYWEhUqqB4Gv69cbjxYELbfNjaA3187myY0tI94cY4/
	cPr3sbfU67/yot+9KDb+dnXqUTyqi3htbKH+GpSRCwSKF4vL6+Ce3mH7VRwd/gBFYo25xsIp9Ug
	mNgM23Ujw4VqRmcS4Ih6Q==
X-Received: by 2002:a05:6a00:4408:b0:84a:29a7:f650 with SMTP id d2e1a72fcca58-84fdde01af6mr23222908b3a.0.1786957431356;
        Mon, 17 Aug 2026 02:03:51 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d2476easm2342517b3a.42.2026.08.17.02.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:03:50 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH net 0/3] net: fixes for requests completing on a socket that no longer listens
Date: Mon, 17 Aug 2026 18:03:14 +0900
Message-ID: <20260817090319.3897799-1-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

connect(AF_UNSPEC) followed by connect() turns a listener into an active
session, and IPV6_ADDRFORM on top of that turns it into an AF_INET socket.
The requests that pointed at that listener are still in the ehash, and
tcp_check_req() completes them without holding the listener lock.

All three patches fix a consequence of the same thing, a request
completing against a socket that is no longer a listener. The request is
released twice, or the child is allocated with the wrong size, or the
child inherits state the parent picked up in the meantime.

Hyunwoo Kim (3):
  ipv6: fix request socket use-after-free after IPV6_ADDRFORM
  net: fix out-of-bounds write in sk_clone() racing with IPV6_ADDRFORM
  tcp: do not inherit out_of_order_queue from parent

 net/core/sock.c          | 2 +-
 net/ipv4/tcp_minisocks.c | 1 +
 net/ipv6/ipv6_sockglue.c | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.43.0

