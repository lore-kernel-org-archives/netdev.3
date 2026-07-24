Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0D2931FF
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898114; cv=none; b=Kjy03AzWQacxUmE16MXOnzaKxbPGm4AMjXSBThZvhPmlWxoH5AGYKr/r4mpXk9LxDE+EDy1tveC+/ZWKh3Fq55P67zHDPqFe5zaq4kH4KnjcmM66XYhkH6Lj9U8wAd5Ok9EVldkqpU/++WD+UqO5iC7uOhhtSqGiP3iZmchF+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898114; c=relaxed/simple;
	bh=12UQH4E/W+K4f5veCv1VVHA0HYDs23quINL4dR1bAB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVcnqzEE+xXnQU9rBweZirHXTTkaLVSf5+4BcaTaVkjJTTmuduRCoLefjfyLnb/5mnw4D020i4HSJGoDaZr6bgeiS83Im2Wlgn2FjebXmOLE30FE92o7Feq7YT61zasSFYgiptFQEBNPJTYsep7Dkv878HDeRaGcAig9dXfBylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBmSKsGe; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBmSKsGe"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38511175ad3so214068a91.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784898113; x=1785502913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12UQH4E/W+K4f5veCv1VVHA0HYDs23quINL4dR1bAB0=;
        b=MBmSKsGeflLlKDnV4T6zQAfAAJ3QP6BEku5ossMJe4dOWNjQNoEsmWlU5vhAgXEVub
         9MhnvinHgtozbTOeiMWUrCiDj8oI62THo5l+vWHF7LZ+PzrDayTzAE+HEM+pVXjsYzm9
         W0pffCwBCp90jjBK/JgcDAbBwoMWnp/xzU8TQl40cMGSpVH3Mp/oEUlDqTPMkIn6Ra0M
         mtmKK96IxMkbLjqf+3XqYxUZLPKOmWm7lguAkVK58CvYKYQ24yx0AGVbLnHQo4+TsadV
         eyj0g2yAydkHjQvUq8XFBxPqHKceaNR1ahrd+BivXCQrjKgci0O5wc3mVQsOgQQ1+DFe
         MxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784898113; x=1785502913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=12UQH4E/W+K4f5veCv1VVHA0HYDs23quINL4dR1bAB0=;
        b=A0EzJs5Q6odHd4NFUhRG4uwIrb2dT8v3QdngzLUQCAXEvafF7rfswxcqViAVAx82j9
         QiHyYqy/bYhinrx0t3qfsdqYMZik30ixljv7Y8fs+v6oti4EzAKge1RUsoguZ4MTu2ef
         TTBloEROvISF29BrwPNhgBHkY3Larhl0SViQLW4REOAmXW7LDrWi0whhuEReEqpboZKH
         qfZWQFI0edniQPJ+sdS0zYmtZL/WKgvI2LhjjR5pUT4zo0jiFfvb+j+pkzWCrqGpoAzU
         ppJa82KDgRqo8dIAQ4BDJ9DJ9Qej17NcmnhrTN/1/H7BxWyQpLmQci0prRg0ueWf0eqm
         m/dw==
X-Gm-Message-State: AOJu0Yzj6p9fWVYC0PGTRSOFt4512Vstlkt+1ySCU/FKWk20Q91aLxT1
	qt/5fNRCKKpt8OJ9PkkRy7o9QGO59VgTUgwcOMLcnYNbR/SpyY2aHM0=
X-Gm-Gg: AR+sD11zr2lgAG64fshDVJvohEDKO1R1y0YeePYWCzgfaB3zNDFj9eR9jxjo4rKhTTs
	xqElHyyqTwsV1dEGHAuTwt6KJFDnIUmE0lFbymmPQbzBGZcR77+hH5NZt5eQtI8hOFKPqcHJjEQ
	cqnlKKxddjqFg0o64fdLLRbdU9UfW2X1ey2lKOOl08S2T4PJovxFflNwTlHi5fHyuOgtT2t7gRn
	ggzS93q7LVFnvl+7jjsL5OMZMst2FJvPI1BWKODeXLbnSOY3Yp6U1nAs1q0wT28Bm2Yes52gC+F
	+RdIon19wXispvolCv4T1bqf7o9nVl+ur8G9foYkLo13YKPGblNn4k/fTPhskwLPlsdtoFOvQaU
	zxgh3krSGX9TASyNbBqDSZB2JwqbF5d/KPfUBskpqSEH4mMzPk8rNfb4KRZaWBy7DQlc1Raq9k6
	SN2kRu5laEaC6NoIno4FnIO4PEGA==
X-Received: by 2002:a17:90b:2252:b0:37f:e1af:df22 with SMTP id 98e67ed59e1d1-38ec651b21amr7470693a91.17.1784898112575;
        Fri, 24 Jul 2026 06:01:52 -0700 (PDT)
Received: from localhost.localdomain ([103.214.235.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130262d2sm23547452c88.7.2026.07.24.06.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 06:01:52 -0700 (PDT)
From: Mohammed Hashil M <mohammedhashil786@gmail.com>
X-Google-Original-From: Mohammed Hashil M <mohammed.hashil@dicortech.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macvlan: inherit needed_headroom/needed_tailroom from lower device
Date: Fri, 24 Jul 2026 18:32:20 +0530
Message-Id: <20260724130220.76631-1-mohammed.hashil@dicortech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iJBGR76nTnM+4AujrE1oFKRa7eSYSCYnMB-9S6cXZMq7A@mail.gmail.com>
References: <CANn89iJBGR76nTnM+4AujrE1oFKRa7eSYSCYnMB-9S6cXZMq7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sorry for the misunderstanding. That was not my intention.

I worked on this change a few weeks ago as part of my work while investigating the macvlan code. Since this was going to be my first Linux kernel contribution, I ended up holding onto the patch longer than I should have because I was unfamiliar with the submission process.

When I finally sent it, I wasn't aware of the discussion from earlier that day. My patch was not based on that discussion, and I certainly wasn't trying to claim ownership of anyone else's work or discoveries.

I understand that, given the timing, it could have appeared that way, and I apologize for creating that impression.

Thank you for pointing it out. I'll be more careful in the future to check for ongoing discussions before submitting a patch.

Regards,
Mohammed Hashil M
