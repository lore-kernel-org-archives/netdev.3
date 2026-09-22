Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78308538D9B
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075001; cv=none; b=Jzcjz/xjCHjNwdD2234yR2GUuf6ifLCjna1qSvDjuLlQ0ZpwvN+Dkg3j/Vq3wPB+2H6sc4FjKiLjFL8OrxTFUvCZrQBoWewIRUfTD6EeGFWp+Oa6l4AqBQEf0ecqKNIEytXg7LuRfzweKwaw7XSPnMp7X+cEJdAibzcSIaaJVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075001; c=relaxed/simple;
	bh=AKXo4HFyGH+qOtzhSzfVmyUzvAxDbIKAOw+B0wfwJ/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGmnG4iZMXxawUUkr+gTZpDQ7XpjbMHyW1lqlakMQ5UfjjGsdr64E5zB79B/kOsziBBkh2wZk3x0RcI7XQelnmsgZaBgQvcM+gQA4cAvnCcRnErvSY4cfPPxaKz+FyJfK6BQI7/1Wd9szSuTKoqorlWEhGORucSX8se+n6KuBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Re0GYu4S; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Re0GYu4S"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so21281975e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790074998; x=1790679798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKXo4HFyGH+qOtzhSzfVmyUzvAxDbIKAOw+B0wfwJ/s=;
        b=Re0GYu4SyfK5Lso5wuUrGXWsmztb++hqnMp+ez0X7BtQj1KAQJD6r/kNUWsdKU9e2S
         h/kmIHD8iHd6qKR30qub41YANqNlf5E2sz6Qfl6SuVUsXdNE1+Cnj08zknSn2cW7PqHX
         rxCWmnitCxgzkmqAfG/ye/6RjoZI9lbssLO1/b6FlMaWs10vKnw07fcWaGXeIUv1tOFv
         s2ili8uiFjg5EKCdZcqBviCWpZwDgfN7qmm2it3taECCZWRsV3NlCYE/2wBkdYuRN4O2
         QSkCBXmw6d9zWTL0igkSb8y0TTTvwWQdwRhrogdgFOhzV/g11uUQxt+EbJvq1rNjHjZd
         VLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790074998; x=1790679798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AKXo4HFyGH+qOtzhSzfVmyUzvAxDbIKAOw+B0wfwJ/s=;
        b=UU8HpbjuMZ15uZnfA6lQv+K6xA0je9qDvH+EDPYnv4sZKnRWG+aqY8uQBOt/3lrLbF
         n7KgYk5+Hrhr/U3vYgmaRFmJC0nJYRVWl54W1qjje9rIl7WXDvPn/0H+IrUKVLxBaKd8
         mrCXoSyc8Y1Mz/cSA8GjNNvzWdOD4kZiSs/+BPLRiiJQhDLQA9OGnQ5qmkw4iJdgEU0G
         qQv5lBvUELzqE1DBSzTq+SCsHOofBTYH2usUUQ7Rdz6UfriL1l/2izVp80dIJkm2uPnJ
         kcK3H8uyuzdSh4yn9O9AyPxYgpYTlWfMvG+lCRB5MHT57fLW2rEXpKzrrclpOBaZ1SVU
         Dh7Q==
X-Gm-Message-State: AFuF++nhEmFoK2oPpmiHoYQ5zXMOl38mYylJOMEWSs35/EY/ZLKC+uyd
	qXUr/bAzZvqfnKesIkLrovimKeTa5t3j/6h8gJA7wDfESjYwKYuU7AXnMKgB85pkxjkoE1bJByW
	IgL2KroJcZi7V
X-Gm-Gg: AYBFou3kM/LuvzHL7mNIrLLJ2ktpVgNN5KgI5tzhVZYS73O0SrKH3XrROvcTgax9fFp
	Ql01tKv4ZnjTeMC1dj8aZOjs9eM/1/d4y8msA7eY1Edm7J2QxZHEn65La9c62HwyX6VpsxTenwZ
	MooY6ilqeIVZoGw+vQNkQJvhcmzMeJwUiEToLE4ewMtS6BsXcO20hNkLIi7I4MnyF5iP16yqku8
	QeywtYAUixEJD16Ggf+2j+EcQYUudGWmCYXg5CL3jttzrpxpctdPvj+4jBTgnzMWUtuxXUkWYvF
	bA7VVea15nIwiXsoPkXdsjV9pbIkdZAPIXjn/CQowEGyYzCkS7o0Mh/TR/BLHOfBWHkMv9oF7+Q
	7ytW4pdUgbgotxuMGf3N6vv+W0rB74tQwNvaSg1BXw868/w7a/yRIF0LdrLjTp3C4meWA9VNQYo
	ACxxRFjipnFsIZzAQpuML5+T4V4AJJNq6yyhyNEh41MRzjrdhh6Q==
X-Received: by 2002:a05:600c:1c20:b0:49c:fa20:cc07 with SMTP id 5b1f17b1804b1-49fc5741914mr220584495e9.30.1790074997555;
        Tue, 22 Sep 2026 04:03:17 -0700 (PDT)
Received: from remote-01 ([84.17.55.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdab0c240sm29990795e9.4.2026.09.22.04.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:03:16 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v9 0/4] net: phy: keep a PHY interrupt across a generic bind cycle
Date: Tue, 22 Sep 2026 14:03:14 +0300
Message-ID: <20260922110314.4028755-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919015326.499479-1-f@lex.la>
References: <20260919015326.499479-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrew, please don't spend time on v9. A v10 follows with one code
change.

The store in phy_detach() moves inside the generic-driver branch. As
posted it runs on every detach, so it also takes the value from the
drivers you listed that set PHY_MAC_INTERRUPT in phydev->irq alone,
which is what you said genphy should not touch.

There is a second case for the same fix. After a failed request
phy_request_interrupt() leaves PHY_POLL in phydev->irq while the bus
table still holds the number that failed, so an unconditional restore
hands that number back on the next cycle.

pw-bot: cr
