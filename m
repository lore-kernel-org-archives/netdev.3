Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484596;
	b=ich43zudWhpyqnwaVOPbybzZ1qltIq1yHN85l2lQw8UamYBaeyBu0QPP/gQJg/wyddUQ
	 F2CN+67KEKWogd6dRvL9wN/ZBnUicnlw37AHj85YT4E0tLcRnoKF04wtXdL0NqsrcY+Qs
	 4D0Es9wbIcuCoyqdl7n7qlL6yUtGRAkyO1EwHbl97HoC7U50HWgYkj37ypvQ/tY1G2tW4
	 NmMufumClJYsvNVIOXTh/AZG6StqF6lyQVnBgi5D7P6YM4nRHDodmhggAC23MQMgMAgxh
	 CTcyL907eBP/J82pUw4Kdrb9uLdpc8UxcwgaZAs0j+yJbCvUmNu6CZmkpYw//Jfg5Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AYAooeFUC47HXA3GtiinK14fsxDzY9i4mk2b1PHqREI=;
	b=GJWKwDacH2MFKx+g8IYUrogyrX2H1uJ6ht26hlSDp5Pw8fo5TlbFML/QWc37nSLGJk2F
	 BZJ0X6CFVdn8qvoHP4/BZrkz/oFNv+I1/mrcvkCMW34A2TUNMSI274bngmxfIQKukjB/n
	 yQipcVgR11PKsWBi+rRT0mq4ylzd1vnqevovG/AMbKyobwiUq5O87BjR9ODdt8+HgAoqI
	 vcXcxI+nGjBiD7v7BXrm7vOa9sUYBZ6z58+XlOJz9mR/6uHYCGFDjaanr6vPY1AyuDBjN
	 +sYbhQS7/eLCXFbyr7E1hKly5VS0YiHIp3jyO17KqvhiOdxl803+XQmiWqIJ3fJt1hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sf3ZNOQG;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E1606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F5E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sf3ZNOQG
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06210b29fso761238b3a.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 01:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1792484595; x=1793089395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AYAooeFUC47HXA3GtiinK14fsxDzY9i4mk2b1PHqREI=;
        b=sf3ZNOQGb/y8xKb1LemkS8KzSTimIw7R7l4kGJJ7G2XWOFsTQXDwqDAai8DmW/dkKM
         EK+RTePaAGe5v9TTH02H3LZSy8/ZrBJhYDPJlgwB76Ur47eQoNVzIMix6pq8loP2GUfH
         cYEXf9LSyUgX6YP9z7ZlA27fmHAtCzIx7MKA6DYFqsRtpSWe128GqHnpjC/Hw+QhtJA/
         8LpBJHsCtrorQQSMTd3jUCWphMCXjhul/3oam8wCBxRERV5YC2BUgN6JcbEFyXJILu8g
         s/gXmgtiWr2V5UUhcI4FoOepML99jfkCV+oL6xgXYh9neQTpFVcyEI9mw0ddOAg1a5k1
         8/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484595; x=1793089395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AYAooeFUC47HXA3GtiinK14fsxDzY9i4mk2b1PHqREI=;
        b=YsODV1bq42faIo6li5cHVcYbgrZpt92A9sYHZvzIKswJrX+OAUnPMovdq4gueA2n2q
         Xwq7l8vXzspGfHSSMRXZfy4j4+CpqX61BxQgDNv8RaYVLZRySkn5UF4GopqfjiKCWhoV
         iIA4yzGQPRFEdgTqq4jVShx46g/BE1UIiicXDEh57ttbLMg5LgA7FFfRvnrv7zKypL73
         wi3MkcunnHqMO/LrYD4/heI9Qcl4XFMdhjgqTXv9fHHAW3ZQ2+31JfRsotez5lE/YgDl
         Zg+AJbfBHD+ycPOoA2rOomJN+yipr3tKReZf4Tfd7y/O9SxGGYXPnTI/GK6oMdfn7Xm+
         w4sw==
X-Forwarded-Encrypted: i=1; AKwUvBzSTRKvHXOKyKMCBwbSL0+peh375I7VldgFLWZ6h6z3ibS9avwMmUbFV5F+UpZSrW8sVQCnZ8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJitgdhdsqOU9QcgKW4stTDoQDvP0VBYucnMAoHFsVKnMO7mj6p
	GgkoO5N9myCeHRGWZvCwWebb9e5LgWyp7Td7PPVGakB60YADW/php49SjNGAcPeXMA==
X-Gm-Gg: AYBFou02Nx09AugwShxXk9T6Ppf9w4X8PuycLSQ1kY7EGy2qEUNdpLeh8Y+F4m2iYrJ
	gQz7yAaC8dI1elqT53GBhmr72d7ndeV9v/EFiYXO2jmjRtM2aXLXLASWCM02pMWlydwPiVjlkkC
	CmjLI5vVP5lU5V617pLeJU/cUZ27XRk4wMrghBptKV8mKOvfoJ6jRV1M4oix44r1yMUAipSRdSj
	16B/FgVx7/DpKnoFmOrpeGF+56EjgTmMzHQC3sobko0LlN7N9Prgvrn/RYWRzIMqmE3v6fb1F+V
	95evm4UJCYWZGgxHlkpDsfXtO9aFaBA5CTLBxYpfC87SYdUhNN4SVn3S6/Vzgl9Z6SBfjKwec6N
	wBrrOJck9YvgCAD86Uo12GSv+9nVUnB/nDThU5abwchj/hVi/vjvazIOber5pbyy8/MdXlaES85
	30KhT4VIy4jxK43RK7ci/HDM2JTJmWWJ8OKtnWcVkdVdETvzFdl3QD4p/x62M8TXjNABUae9vUW
	/filDk00JvC9uc8TebOvxWXVmymZ8DbKQZ7eKyQhqAGmFDoASvRZzp3OO09FuUF
X-Received: by 2002:a05:6a21:7a46:b0:3e0:da23:8746 with SMTP id adf61e73a8af0-3e225f355f5mr8247362637.18.1792484594268;
        Tue, 20 Oct 2026 01:23:14 -0700 (PDT)
Received: from cantal.lan ([58.136.73.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm4419397a12.20.2026.10.20.01.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 01:23:13 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Chintan Vankar <c-vankar@ti.com>,
	Aksh Garg <a-garg7@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: fix support for PTP_EXTTS_REQUEST2 ioctl
Date: Tue, 20 Oct 2026 15:23:07 +0700
Message-ID: <20261020082307.1267591-1-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020003525.1237742-1-jjc@jclark.com>
References: <20261020003525.1237742-1-jjc@jclark.com>
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

On Tue, 20 Oct 2026 07:35:25 +0700, James Clark wrote:
> Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
> ptp_clock_info") modified the PTP core to validate the supported flags
> of external timestamp requests, rather than relying on each driver to
> check them.
>
> am65_cpts_extts_enable() ignores the flags, and am65-cpts was not given
> any .supported_extts_flags. Since PTP_EXTTS_REQUEST2 always implies
> PTP_STRICT_FLAGS, the core now rejects every PTP_EXTTS_REQUEST2 for this
> driver with -EOPNOTSUPP, where before that commit the same requests
> succeeded.

Adding Aksh Garg and Sebastian Andrzej Siewior, whom I missed on the Cc list.
The full patch is at
https://lore.kernel.org/all/20261020003525.1237742-1-jjc@jclark.com/
