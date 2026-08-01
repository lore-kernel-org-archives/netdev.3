Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14FA381AE5
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622132; cv=none; b=anvT6+Uhx2kYCVxeTrRjiNBRWvjQ5T0WbljOH2TMLqKArpwdQNAIddfpvjqTfsyIkIjcYDilUkXJDCF95nU2gdCm8CpSANuXBy8AHoCKZ281xx0fi2tVRuQzhaQanbEr+xLXvT75A39X9YoeiTFwNhBqDdQkS4dZk41h9+MJ4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622132; c=relaxed/simple;
	bh=NoXcdRooBIPIanQ647b061elFHa9QZWXVs6RX2LpHV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNuJD/Q5fWyJgkZGVptNG1qwK+HJCoW0dED4QxLI0WRiUIbhngzR6/mpRSHRIAEUNN6FKJD861lvsw3HKu5yKrtc835ri+dm8S4Qjj9/epW5d+ostPrEh8RaeLVIpyNyWWJFYqGlB+Olk+RbonOshFHSRfKkPn6ipMu29Cj4gH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JozBL6ol; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JozBL6ol"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f23e851626so13992956d6.3
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785622128; x=1786226928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NoXcdRooBIPIanQ647b061elFHa9QZWXVs6RX2LpHV4=;
        b=JozBL6ol9P/HemSKaSQFHOPAW0o5AyDB1RK4oepwrWU5dJkhJDP+rNY3zffXivkZ6y
         4Q6qNdsHvbNNI4UsuATSetNbXaFhEzHIA3NZpju+UCttgCW8Kj9U2NewefU1cDq5KlyK
         eW4ZpvlO+z+BbFDoLGp7RTwOdCSvnAn+3RQ71y+TQaU3hdtOOuavUUXFYmyl4Y2je1Nd
         clHbVE2C40aanh9FNzG6fiha6TypexJVsp2O9wIKyO+ZNhktdtghDPaGRGM9ueW0MjbS
         5CF3xTw2MeYod2PNEdaWsE8nq2YvgS/uFIEwulYJdC6XpxWYRBO2D8NlIjrTNCgfEENk
         K6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785622128; x=1786226928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NoXcdRooBIPIanQ647b061elFHa9QZWXVs6RX2LpHV4=;
        b=YLfKLFeLRst5YvGCJl3U3CC/250xaVKxnbX/AJ0UzrKkaivD4Q1y11X5TVx+qdS56Q
         y81MwqOf4nTgXufnPTSTIJbxv2j/nI9ptxcPeOdOBdM2h4js5znH9zDTEbMR0oGxN0ap
         za7P5L2p9FRsB3mRtdID5xvlZlEk/90tngLgWmfhPFur/wxcaYVbsLsq3DXEa1o1OYq0
         n/fINXFle+aQIG9EjWYjCJ90uhgUuN23bjcjpUsLV3wL4Fc2Tit9ReieJFrMV9/8r26x
         Y9oDATFqyzZxc2ydPJn+DTS7YVoAEyNmNin/l5b3jFwwmzEny8P7Pdt5EQkEziKIrke2
         uWQw==
X-Gm-Message-State: AOJu0YwH7543k3TFTL5A0I6JDd20aDOo546KmJsnU2qC2O7Wcy+wsoIj
	OC/OLAA2N4HWVnWcT/orKr8DRrF3vlFZCGjT9ITtv15IpYyvmnzbvfsl
X-Gm-Gg: AR+sD10q0KLmQAsvFYtECLbQG+Vy5UikuaEBoxDqc+aM59s42ZgHrKvMbbpd3s9Twm3
	sKdc0LnfgT7ucD3N136IBazVtvY8fwCoSDoTEm5SNK96ZClRnFJ/AuGzkmSVa1Uc8272nVYSxSv
	Zen+30/yTK3vBzYOmlxzXAX6V589qS9A5rd84DVUl1HlPcN4zoTcfxHnNpS6ih9k8fMH4KSf85P
	gp8UuI34//5lZ+I9aZde2BVCAwz7MBxepu4o2Jeo0mUWFeT1aTAAOKhfD4TKokuT1xzE9NCdekL
	RNrWkw4PLLYiICRnMEzR6No9LuN7J2kR3wHxlkEkI4f3GVaA0VAR3beq1oOybwHe3ErqafmXIiG
	8wKrPcqZ8zg5ZlBq1XN2Set6Mon3Q4Wm1qb0r7UDkm16C9/ZRiSWDzBcS3bxJxlilzxoT0seM2n
	zABS3KgcK6ueUHSHB9pAIZcFZa13WxN1tUPIwWJ2dJ/i0orqV9Li2pt+fw3GoVDMdoCHN/y+oMn
	Cdz4yegmggvLh/vO65Dd7hW1KuhW0LBSU63iNKabCAZPB0l408Hl5F54nWIrDz2SG9iFsQUUGe6
	WVkIhEJqo5lfwPP+HpLbT0VIsA==
X-Received: by 2002:a05:6214:4a88:b0:8cc:d588:4523 with SMTP id 6a1803df08f44-9084957b982mr116150616d6.13.1785622128022;
        Sat, 01 Aug 2026 15:08:48 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal (ec2-32-195-55-166.compute-1.amazonaws.com. [32.195.55.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435dee46sm41358536d6.36.2026.08.01.15.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:08:47 -0700 (PDT)
From: Deep Shah <deepshah146@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v2 net 1/2] ptp: reject frequency adjustments that overflow scaled_ppm_to_ppb()
Date: Sat,  1 Aug 2026 22:08:46 +0000
Message-ID: <20260801220846.28467-1-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727132259.3837774c@kernel.org>
References: <20260727132259.3837774c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

That's fair. I'll resend to net-next without the Fixes tag.
