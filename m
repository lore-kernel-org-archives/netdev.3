Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E736C9D9
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336333; cv=none; b=JO6B+p2D9Blr1KdKaKyX5XyshiLe/bwHoDkxz62CNMncAiFYgKC9DCzI4lqnko1swUENQsKOCVb7CkVnjrpwVSNcliz/VTwbWzafqOHwn2S+WpSESP+3xg5qgEhzkFsn6EsNueQXzuI5ztAMFidoBvN6Ekvm6+ZeOkFTx91SeVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336333; c=relaxed/simple;
	bh=uwT2KUAI1VvCWLMzjJ8R9s6y5wJv5+DsF35eViA8fUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WjOvlpwe3i5glQTGC8Tb6wPpgegBCIiwFC9pv9CdLXH/bFwtYFZUz4TD5ycFaYuxKZoA4XPyeg89AslkczVdhnQFd34KBYWJXuq3CeCBDPCMltGyYbcuz9F+9VnsJzudBzS+IhrJt5/XyMa/8tdfbx5Er9Zs6/dlCxriWoafh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=FputoI0c; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="FputoI0c"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so6562285e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788336330; x=1788941130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cb3utlTtnJeIblx6OWLfMMuXM2H1GUHEGzZQA00gdUU=;
        b=FputoI0cokTZZLIeui22dUOWyMeGub6F8v/XVCwvcfr8YolKFGi6VkpAgilL0BLfB6
         sGJb8540rkbAK03bw7vrrh3tvp/3wmeZJ8Utgxl7uS0ZMss0j8UdH/FtprpZMjIKhONp
         pmJVWYtXY5u2huAkLN5HAHuHfRCtqlkvtzQjBj5EUfx9IH29pb8qt0zefetrQTnAwz6N
         qRqKwqOiyQwoKEzCBuPoJ971jhb4xOIb4Hu23ERY7b2CCOsF/2MS+WqMKX/xLPfMC6Hm
         8CQwREIv5tfT7pRCC4U2OiFcvqJuUFj4Ak01Hzbsmaf6+vsI1fbAY44CzsmJ4DkK1Q7h
         R6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336330; x=1788941130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cb3utlTtnJeIblx6OWLfMMuXM2H1GUHEGzZQA00gdUU=;
        b=FiDhD8WQKahzELwB4FIOXDxVbOfKEcej800Z07PiRbgq0SiA8kqgeIluZXTRvfN+HY
         Fx/Xmi9nRhjFVguufDmGeq/9UY5Hz3JnHCGLZIDhl2+MWm0AwdawhNyv6PzSX3dMtiP2
         58l2MKUPnkkvvGjb7P8NzHK9XUDVFXs7jOiZboe7dCEYbQPb4MtE7ZshqL79c9IrhFPR
         X9RSwiy/SPTtYMX9ZMq7Uz4zisVm2nnCrYiyH+C9Jp7OD1UyPv1TK7Vujf/XmR15oEjU
         vat4wCILExOsIde7cCJTojgL39qwo/No/QVmEFR8aAfEN42NnCWdeQpikLIjEz9oMf2j
         wVew==
X-Forwarded-Encrypted: i=1; AHgh+RoekvZ59EQlikyLD6j57ceWrKd001toqhJsyqqGusw6HZMwCDIrVKZDyfolk6vO7PoxCa7uLx0=@vger.kernel.org
X-Gm-Message-State: AFuF++nhKHSJZPI5h+sZhLufXqS3u8tlIz13kF8MPOmqzaN5M1vJE7mT
	E0/HOnE8eOurPD2BXEPAC02sYeL/qggyQbi6/xm0vV9nlPWLqmX15hwQN5+fbt6UBYA=
X-Gm-Gg: AR+sD102E/F7C9AezjaJnvNv8LY0VcEZ9wlB8ooTjJvl2dkEYPhAAGygCQ9qyL/t4og
	bo4n0cv+fHksY31PNXaH8GCb/5jazPkBaa30ze8k2oYnZd4mVnjZNof9ZXrKN68OtheoAnaqPFx
	WHQDfa5N+iTf3eT9HkoExEIbR6pjGs91Mnj+vYk/R9o977eRI3pFxoFnd6mIvRBtLwIQ8KrHWQH
	tFYvR42231pJFcX1S9xllnonbQS9zQhYbsdHl89iihVjCH+ZWZCio9E3NeD/AaJ6xS88MAU7res
	SNtF1pyaCowgQpnJdffRf5tx+V1bd3TSNgTNFkJ9oYJyPvrzFA6dZ44Pm4OJc6lQsTLdE0PUorf
	nV02iW6RC8OyqlU+nIo3lLBvcCkwkd3PuOafGA1lF3lmdRP4Wu/gpoVhiMQFTmWc9bcgs7MLg1n
	+dgMBonnqbD/7d1iQObhs96AWTu0PBMKZZEJKmKJc=
X-Received: by 2002:a05:600c:8b62:b0:49c:d293:70c8 with SMTP id 5b1f17b1804b1-49ce57f524bmr58112675e9.3.1788336329943;
        Wed, 02 Sep 2026 01:05:29 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce7dd5154sm17766875e9.2.2026.09.02.01.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:05:29 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: "Th\u00e9o Lebrun" <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: macb: fix the link speed the taprio setup reads
Date: Wed,  2 Sep 2026 08:05:26 +0000
Message-ID: <20260902080528.2211468-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small fixes in macb_taprio_setup_replace(), both in how it obtains
the link speed it scales the schedule with.

The first: it hands phylink_ethtool_ksettings_get() a stack variable
it never zeroed, while phylink fills only what the link mode provides
and even reads one field back from the caller. The second: the speed
check is written as "<= 0" on a u32, so SPEED_UNKNOWN passes it and
turns into a 1 ns hardware limit that every entry then exceeds.

Compile-tested against net; the driver has no test surface, and no
macb board here.

Aleksei Sviridkin (2):
  net: macb: zero the link settings taprio reads back
  net: macb: reject an unknown link speed in the taprio setup

 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.53.0

