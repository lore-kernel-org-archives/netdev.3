Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D325A642
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556009; cv=none; b=G8P5gqDh9XV3vKumnzAsvG7guqWQigajXyKoSOtLR0DR0sAkyK4xWFbNCNlMXV7WazV8lUCNKlX7gR8mz4BRsWYq68nU7rhLdbMXM0q5wdUYuJfcbAHJFIqetua10TyQ+Fppj8hW6LHXJh6RB/kVOBe5gnAaEzenqAiB5BJMvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556009; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zrohn5nyo5Cn9nHeVhfFMxQqoKNmXPBkiZQxmUQb65SJAXXD6NwpGZg2MW7uPlOuTNTtYTkBF2EKtjCyYzqeP3G+hBmNphPv6Hx6iqhM0fvDkd9eniLOp7chCRU/s1z7g2C9Rr8155s+lKaqPMkE1NC5ELKfT63IQOSpcvlzfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aronleigh.au; spf=fail smtp.mailfrom=aronleigh.au; dkim=pass (2048-bit key) header.d=aronleigh.au header.i=@aronleigh.au header.b=NQzBpmj5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aronleigh.au
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=aronleigh.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aronleigh.au header.i=@aronleigh.au header.b="NQzBpmj5"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38101f85591so3383460a91.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 00:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aronleigh.au; s=google; t=1787556008; x=1788160808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=NQzBpmj5e2ufVKvJJaoPPITr67fPfF8luZiUkdlHSdOPS+6QJLW7ChVmZ7qCRgSEDJ
         7zb8g0Q460O6R3XGnCeXF6Qk17bhYAeuIEOeH8UaQKp4LXbwXHlRjx2hsQQwQWlRjsvX
         07xiBGIkaIAQB/O9GBVLoDg1k5UGdQpdDGSZyJu8ZxKrnx5UrQggkWZtx2CMuECFTox/
         h0ABTOch/ZGlQ5ix4sZEZswtNTPgfmiRLF0KNKHmqUshX0BRHT99oog4jkuEOofpFx1e
         iFonubHRj3q1bhduTCLbwoF4wDLdjkNxCsI1EML1mtq11HpnigVAYmTUD+8vrWdkvKQq
         Xtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787556008; x=1788160808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=aZwdGCGtwDYv+kGtbtWmCBZxv7r68+xb3rgWyUJT/JO9WSv4nK4Kpt58bySt5CVpI1
         StETanYDu8tLsZccGug4AmYQ+4u2bHrw/n9dTA2dAI6jDbaVy4gXqVf3S+MnF5vAAVhf
         cwya9humnBMa34INlr2AA+4G3b/qhqYPwXkja87DwiiuDLjJM6ub3VKqZTAwgtOfy2k9
         6Vqel/OqYZ3PEHuINch2xbagDF5E4dejbh265rGEx4lXm0NdczQHQAuS7XLkB/1ujWTC
         C4eLQLcCpVzVCXdYSGrNaKyNUrKTsGTX/9JIvAaPBgk214XUIzPaKdVlZBLggjj+P+qI
         H9cg==
X-Forwarded-Encrypted: i=1; AHgh+RoPmWFWjEXmyg9KVAVMH3WLaMajXX0h4PJSpZyx9T+aqz/eFY8OB7aggZVSsm2yDqcAQVM78Bc=@vger.kernel.org
X-Gm-Message-State: AFuF++ntZC5EuFNeUYJ+TnWST41u6AGdHi1wrSkVxc2iQTiwLy+8in9v
	o44HH39mzkDNsao9wX42cv6yOhqj8l8GZUAM92KmOkKfIGu9cmt/Hnoi5l8NFEWGHFvd
X-Gm-Gg: AR+sD10BUO+Ai2agDQXPoIakJlljVliNrmYsaVFYOj/6AWsLQExZPvgVSCdG6AXI9gt
	j2JxzyvEjZUkxIgHGRAW6gdh2NteIfB2eJtnd5TecCVHQYzbfWID/5d5Yoe6V7S2DO10ds1NIjp
	eGkt/sW1WPpeJqVl8XPyst4TPfnpwSMCv0FpI0XUxnCt3cGeywxTlVd5ZHTvC3VJGvgjoR3McPG
	VfFmE/KkHISYOttDIXC8loeImHDsLJASReNKi1mGvB2vpPCsQHuGz7juvsAdJkqFQH6blPFLxW0
	Z8v4GIb9H8jg7GnGf8yLSUBF23ocmMkRZZQKyCMDG5NYPIHxYvXm4/ZOZOouWz6cP5HBFS7ocAr
	wDKnPSIauvm7nSOtOE8Pqwl5afc0tEpfXSo/aISyYrdJIllaLQgbrfhpzULvSI3UxvgYQmiOB1M
	8YMaBm+pF5POXsVTS1efCvhJVPaapT+//wLHLGM6gp1ftPQs54pckQbiofOBdUtJapLTyyxsxzG
	ToPxxHmE1yisxPbne184zQZyMYS
X-Received: by 2002:a17:90b:57c3:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-395c4fa443fmr21606911a91.6.1787556007825;
        Mon, 24 Aug 2026 00:20:07 -0700 (PDT)
Received: from ghostoverflow.. ([1.145.153.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4af750esm9003810a91.11.2026.08.24.00.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 00:20:07 -0700 (PDT)
From: Lilly Aronleigh <lilly@aronleigh.au>
To: lilly@aronleigh.au
Cc: chopps@labn.net,
	davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com
Subject: Formatting error, apologies
Date: Mon, 24 Aug 2026 17:19:47 +1000
Message-ID: <20260824071947.297893-1-lilly@aronleigh.au>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFrrV-NeRaP=0k5a1b+6oNOCz0qBUuFwCo2xxC3bDc6XR+wmsA@mail.gmail.com>
References: <CAFrrV-NeRaP=0k5a1b+6oNOCz0qBUuFwCo2xxC3bDc6XR+wmsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

