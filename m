Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CC37700A
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907498; cv=none; b=jFq6rE94bLpuJcK0n4RGU1BkdoN9YlUGLXRT4T5INy27BS4I+p72js6WPZMgdLUO96XLuI/rbaHZi4bGfojhF67awmK0VfQfa4jybid/9aUJj7g1qefDtjT61tCElhMvH+u0w3az8lpel65B6TtWbTOO355YL5/ziVVcr5nx4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907498; c=relaxed/simple;
	bh=17kF8wWimjf9twN6Xa4D/CV4JIXpBBvhsxfBp+GehSE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c+hv60xw71Y6kNAhMxkcaz2wN63i2+ZRfkpprRNYhJ708qGssV1LoFqb033Alchj14JIi2sIz2ZiFHMpQ8rSWWfJlO15OGnqr0+QXGjlFli2ZOz1SvNE/mL5HL46L8SETzoA4hTS+RxrLmomdPXpLHCwHVQiFWTJQ/Fr2nXKpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mCPotAsD; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mCPotAsD"
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8f0ed4fe79aso14287926d6.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 05:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782907496; x=1783512296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=31qtIdPRughmMnZkk1ciwsHFkc96yKhQhs2M7I5hPVQ=;
        b=mCPotAsDbmi4pN7+hL37OZuLOQUQL3bax6bjkTFpFCmOCDbNZ7f4RBO/HQ4rib194E
         thj5OlpB9sc5ufz4oGcyyW4irM15AJ0LEdyCJYr9xvfdCjPBqLQeSfq7wh1BviNKfwk7
         vXS2A7Sty1y2UHcRKN6p0S6vWDrXIy60hqVCUcxBn7wV3UerEGfpsS3hG4WZhQfTkm8m
         AmJOzI7E+I1BCVBlpsuIIDaxhFr7nnYipXu4jNqPWzFJwyF2UeUQqQgeYZt0wLDeT12t
         tc1ulS4Hiuz640Kd2i4pW6jIM0bO22umJc8ZBZhH0OQsmEbL7hZzg/NjjOst20wDIPuQ
         vBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907496; x=1783512296;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31qtIdPRughmMnZkk1ciwsHFkc96yKhQhs2M7I5hPVQ=;
        b=BsFcxQ0n6J8o47yjGb2PGNPNBTGZZLw3yNq05IsYKIlu9mJXOZmp0GmyWi5y6JPOVz
         zW/VwjV3XhnsMcFqFIAx7CSTZF/p0z/6medAFeBz5w8Y+D2cDjtHdhQuqV4jMBWa0hYx
         NVhFjtExxAdQyLotHkqktUoBGiwwjDtzw3aN4mUXgd1f0MzqfxPtCmSYY/QFpiMVx8kq
         ns+EFaZkbvV+6bNpkZi1LVGUN+m9jZRB3RmkV5eTCfkhWM729697FWkGHbKvDqfd8RpA
         ItxPOQuMw3uA7NsnfOxCaUJYrIfTmdXgaw0FYEPSBdsR/HRgiMzUdj/cs83uMZ/rf3hl
         9KYA==
X-Forwarded-Encrypted: i=1; AHgh+RpW8TH0OeNjx7+rZJQFARCL6Jr3Os6j4XU2lB1NLioQO8bGp85oENuSX921AzC0koIhGQskpjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44F0LKn2UbUoE8KwapLBg6eDTrULjOmcwZqCIxcka1IXj+O69
	ehBigLvA63Jzc+H9mKYGULGQt1rBnUHv/cI6SMLIfa3KAALnW5A1+NV9woKXOi4PrFws26x9tAe
	Sc9Yd27QnV1e9tg==
X-Received: from qvbdw3.prod.google.com ([2002:a05:6214:a03:b0:8f0:6480:c887])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2604:b0:8ea:47d7:5e3d with SMTP id 6a1803df08f44-8f3c8ff3641mr13700876d6.45.1782907496090;
 Wed, 01 Jul 2026 05:04:56 -0700 (PDT)
Date: Wed,  1 Jul 2026 12:04:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701120454.3533252-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] geneve: make geneve_fill_info() RTNL-less
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series makes geneve_fill_info() independent of the RTNL lock by
converting the device configuration to an RCU-protected pointer.

Historically, geneve_changelink() updated the device configuration by
copying the new configuration over the old one using memcpy() under RTNL.

To prevent the transmit/receive data paths from reading torn values during
the copy, geneve_quiesce() was used to pause the data path and wait for
a synchronize_net(), causing packet loss and latency.

By converting the configuration to an RCU-protected pointer, we can
perform atomic updates via RCU swap. This allows data path readers to
safely access the configuration locklessly under RCU read lock, and
removes the need to stop the data path during changelink.

With the RCU infrastructure in place, geneve_fill_info() is then updated
to read the configuration under RCU read lock, removing its dependency
on RTNL.

Eric Dumazet (2):
  geneve: convert config to RCU-protected pointer
  geneve: make geneve_fill_info() RTNL independent

 drivers/net/geneve.c | 390 +++++++++++++++++++++++++------------------
 1 file changed, 229 insertions(+), 161 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

