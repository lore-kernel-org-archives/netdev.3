Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C8489863
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723740; cv=none; b=TgBHPna0g+3Dyeapo1wvsH0kZi6K12TmUul4vp1unHdOMScusJaPZcrfmWfiI8alurF+oDd2YLsQdgQkvsBOICwYhGH+VfyAMFq9hpBreVu9yPj9xvX4qc9kTxumQBr7f5AhL4EV5w5FDOMDteSZr0tpv389JasUtyZ1lusXzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723740; c=relaxed/simple;
	bh=XKh2YeO4EAsYmdzfnzNNmoZOno1d9kIUe9waeMV0ULo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6AkvpEjep3vMo57W8h2opQuPJIjEPADjEuc9+A3r9i9ab8zogvSEKf+C6T1ZBRef0b8WVlXYMRZXBFtiBozAoWj9bvxDC7bCO8BW3zXelt41CZWkkHZ6FG/YmW037PBFSA7T7Yp8QikNb/S0E0s55+WF6jui9knuscppmIwGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVoz/+ij; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVoz/+ij"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1188001b3a.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786723735; x=1787328535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2CdDW2946UxRO03u0geIdvw1xXuEfDohd1faqEthz4=;
        b=KVoz/+ijod7nSg5oi/rk3e0mbbVMYvO1poXRyvY/i40O7OvV18hSrJAvseuRrIlPdP
         a7SrBTuWL8y3KCH1XqsqIloXyMhAcgkqJeJ+WwR/UaHIbWHinQFHzSJwkMF1mPG+UDSq
         V9IP0oEX1wN0r5Q4rmQktyR32enaN5Ldh2LfW+Ix8p8JXBGShLCpjgWIUuSicF7wrfV0
         /i42xuYKDJ1MU6BttMzv+ZCZm6O2Ye6bO4yQm2fi90n9/fy4fXh6n6BkgJe72vmDnSf8
         0T4qEI0xBOZkS3okPRfSEj4zU9Gh29bBxwLyxS0sY0SSJn9B9yayFNqvSa2lWzmgGQvh
         nEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723735; x=1787328535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O2CdDW2946UxRO03u0geIdvw1xXuEfDohd1faqEthz4=;
        b=qoMtsoq2h0VV1rSoOnIjbLRiTfPQL5wiUBG6FiBTxixs5/q12G2iTnkA6ZuGx0mi70
         sKzEfzYkJCrYycmO09WglVt57wWWoFFHm8sqJ0VEy+vL8NBzYiA+90R5d6KA6P30KPOq
         Xwxzm/5QlXLepFYFBK4S9KVuL/LWy962fcIQYxQIduvpElar3BooJdKCfjEX8cTNc/D5
         IuVUhk7ZD0Nb+fGPzeqFe9EALWsO4x5/1hIzR72QMTs0nZ98pD3d1kJtBtTzNyDhMm+3
         K7fK6xrgxlk4lFGxQV5kxRCCjhlqyYso569epG+hpLuDUfuGlKJGrMLeloemzhoGZHqX
         1QAQ==
X-Gm-Message-State: AOJu0Yz8g5O+Z64P4SxLJ47rQWGey+4k9OtLuwsHr1lKXi+7j9lMgRSl
	X/fgjQVgTK1wE+Xjl68BTetTGCwXjkdj4+yIU49MnyeJWJzwfsZbyFbT
X-Gm-Gg: AR+sD13heRX4Ry5TlOSSj3UFHAWw8h17T15Y1ywklPwCj4dPrI4NWvxO1XB5d6Sj6GK
	/7w62Mpgkrzkkt77rM2uyhGHKTzADjHmFGrpH1Hopn1QnVqhKWub1yHwwptNKz3c8Yw62kMGU8G
	Ozt0NnZI0gVOceJ1tWQJOz60mYwWKyH3RSq1wzVHSYLhwOIoCZHDfUNxZ3PkyNkhHgNf+JV4fd6
	lgtsPUZ6cKL5wanQOOALIlcIM4f2h3/EeTy40pymkZ5YzsUWat7TpFTjRRHh9K7F6eMYkDGys+0
	gek/1AuX/mBKy99FdZO5iz1M0PIdJXZ6KwTOvohdKC0MnOuZh4wMVEAHvPHipGCCVeyOypyVGxT
	emLXaT4m69kU+cgGfV2+ZFFb4L7UtH4HvCRtXVu/0mtTJXSpBB08K94SCZ9VMcCOZvKc3c9/xZR
	lR7XMV95UIIEH9TOAngFMukO8gafMd4PrcbHtG1rxKSeWJLsP9sQT0/TVNyaqY1/zj2W2avyaRD
	2A=
X-Received: by 2002:a05:6a00:2e97:b0:848:2e7e:353a with SMTP id d2e1a72fcca58-84fdde538d4mr7343867b3a.0.1786723734621;
        Fri, 14 Aug 2026 09:08:54 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8517d248b8fsm694402b3a.44.2026.08.14.09.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 09:08:54 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: tung.quang.nguyen@est.tech,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()
Date: Fri, 14 Aug 2026 16:08:46 +0000
Message-ID: <20260814160846.338273-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <GV1P189MB1988CAF7D299010DB0C80031C6DA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <GV1P189MB1988CAF7D299010DB0C80031C6DA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> net tree: https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
> net-next tree: https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

Thank you. I tried the correct net-next tree. The same patch applied successfully here also as shown below.

<path of the linux tree>/net-next$ ls
arch   certs    CREDITS  Documentation  fs       init      ipc     Kconfig  lib       MAINTAINERS  mm   README  samples  security  tools  virt
block  COPYING  crypto   drivers        include  io_uring  Kbuild  kernel   LICENSES  Makefile     net  rust    scripts  sound     usr
<path of the linux tree>/net-next$ git remote -v
origin	https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git (fetch)
origin	https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git (push)
<path of the linux tree>/net-next$ git am ../../patches/v3-0001-tipc-replace-deprecated-strcpy-with-strscpy-in-ti.patch
Applying: tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()
<path of the linux tree>/net-next$ git branch
* main
<path of the linux tree>/net-next$

Am I missing something?
