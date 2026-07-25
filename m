Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C33890F7
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784948439; cv=none; b=oej8ucLdeh8t/851o7K2m0z3omLNXuSb5PBV9vCwsZqrwmFy76jTYDwySq42aR3WHb7qwASzI0KoNwigrUU0sQz2aaf22CuZKhLPehg3X9p5t//ZVYOPfoeyzjpRrWYje05IMIzzU0hbMNIBvikX3IfFtSIKqJJkWvuqAEyOaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784948439; c=relaxed/simple;
	bh=YqF8uXn973kV70BvwYjv8iv0rJOPusygYoAgrJ8qSW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpZ9lVxiB29wpGDYl9h7/0ATYY7RtUpq5fmp/JddhrjktLMlRzA/2zKl6Leos7NUgqi4frIOiy90nylI7PCWHUT+14BEUVDu2RQaEWH7liKBHeUGyIqWtZcuIpK/AEzi2b7i0PUzBsT3/rzWfcW9+ev465Hobu1hww8T5F+ejw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPjqOh94; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPjqOh94"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8111c0c7561so8271947b3.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 20:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784948427; x=1785553227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e/c6yCrQuwkxtDBKJryWHPTZlmuJWG49aqIdtTn1MT0=;
        b=nPjqOh94kE5pFXoybmk1JhPScrx7zFrxFev+E9YeCW74B+9USuei3f8NgJtPG3EXmd
         MLhVHiXwxx1kyNDfKqhw/cGJApFy0vWY863XiRyTatwsw2c7QBPco847CCd+4H1VpFKA
         Ht+PDYR6vmKZnYQIHsV4ZseVnjLIU20Cldb8yXpIGavCbotZsFiE3YgiSAPIG4DkJT/t
         OQ1ojFUkBpIxtcGtnhZFhXzqBq/weFBAmtXSxxwNpy9MV85qb9J67cj+XqG2MqEVzfMn
         oFagF9n16Fdb5wSaZzLOD1jcWe8OTK9mn0ycEzR4QY2R1J6QXS3b/kTVEBBGyCvWqnrK
         J9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784948427; x=1785553227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e/c6yCrQuwkxtDBKJryWHPTZlmuJWG49aqIdtTn1MT0=;
        b=NH7+mfaevOZWhQH5rGwN8dtQGvu+NFcbxkARNbcZQKODkP61wGVQlb51ztVNKYWYIZ
         9U8MdhF6gMhlHfuG+DM1i3MahtKAxTLmPHdQjIhF67sf8vdfboPyrnMv//sVbuI/4dny
         GFKAo4EzOYjDfTp33gs7AdZUt1PhIXjQSIduEchrW5TViFhBriiLXLFINL5fnOyz8LYV
         d7JL0H9Q8Kgr7tLrzfi8C+5K6/hVpYX9AlkRSZ3N8bmaHa/SWB7Latsfd7cE85jX/7Dj
         Bup0Xw3cvDJucf8d76MoBbJM9y7dIYZKfxqFQb9l5/NO3q0XaiCa4bCXWrVX7GrSKlhW
         ypew==
X-Forwarded-Encrypted: i=1; AHgh+RrOVY1MTqZjjsbZ71SLAN4d2ed2+i6P4mmiZB3ZAU/y7em1Srp8ho+vGF4vWyyzZluviM/8dc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyezQY/H2U6OTWyhTghRBX6+FAxWzjQ6hDLIPoAteZdaQWHpWyJ
	fa8cDdZ8XCCxLVz12NbXfuGiwT563k8w4U9SK7THHX8RAQmrDHjKUeQO
X-Gm-Gg: AR+sD131zcZU0xPrjvc+WC1d/sW8az0FwVzj2lYeel1gvzZ4X39mpuYHKMugPcFXqSn
	OO2csTZ6mXaDyEbfIy7/WNkngiHVbVn01DsKgVyesdRvS217PXoqddwWGIoHzl4jFrLiVbMMzCk
	V2F22v1Z2d032/aayXjtvdDvlNSHWI/7ukWjD5v9GiWrOLBrgL3q+wRcalw/+7XbR7mTZYMCdKJ
	BXtQeXCTNq3mCTsaZ/8PbaKCwVW2OTqm8fuPFXlm5cMZQOQFhzzn8I2QGoFFEb8HeUxq7TVyl7v
	G1n4FOyWSNIw4HATyAufJ6PYsWmp7gakYX6iwFqv85usXvUwqpIPqttUF12OyIdTjk3x+NLxFAj
	CZ0Rme809xstHzOMHB5TxyT1oBhnfXkWRdaIafGeDSyDx0opA7wrCvamHCUrLwKrWXTx9K1lziR
	6Sk9tYzvdC8gF4E3OSBbCx7nFIHcWsp2aL36dqC2DnkKxSv5AcQoqsUOHaloRy2WcZeGLR+klA9
	Rdxe2RpmL0AGg==
X-Received: by 2002:a05:690c:64c2:b0:81e:9ba9:d36b with SMTP id 00721157ae682-81f69e9bd7amr3122207b3.63.1784948426585;
        Fri, 24 Jul 2026 20:00:26 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f658d32b6sm8270777b3.26.2026.07.24.20.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 20:00:26 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: sdf.kernel@gmail.com
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Fri, 24 Jul 2026 23:00:26 -0400
Message-ID: <20260725030026.191412-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <amPqFHJBnDEQGmOK@devvm7509.cco0.facebook.com>
References: <amPqFHJBnDEQGmOK@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> ... which means they are "lost"?

You are right. The UMEM frames already consumed from the Fill Ring must
be recycled into free_list when the packet cannot be completed. 

Since the current loop calls __xsk_rcv_zc_safe(), and therefore
xp_release(), after every allocation, they cannot simply be recycled
after a later failure. I will rework v2 as a two-stage transaction:
first allocate and stage all required buffers, recycling all staged
buffers if any allocation fails; then run the error-free
copy/submit/release loop only after the allocation stage succeeds.

Thanks.
