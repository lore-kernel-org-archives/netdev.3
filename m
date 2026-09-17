Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17347FB10
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679056; cv=none; b=MjF5FyzsCr+q6n0dmXXjqkGp65GTYfNerHmKKGPXEVJ97h3bkcRXLuqppQ1+5GFyZM0RshQCuWplE7Jo4ldhLPAyRiDGUHBg465fseHa0KnaZifCWyqPDqUF/BD3/Yov66GxPAk6zSYYURCI3hTFUe8vfBOeAY4b/yrUbnDisWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679056; c=relaxed/simple;
	bh=VWCrXi8EDNnlXkbpZEVq75srh7i90DNgXcIc39O2ulk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FerMYamqCVMtEGqw69kZaCjX1KOCJkDhRnJbn9kM62DQ9bojoEUEwWeisW1U1K+/TMMMdJJCGC4XDqmvWqYCO0V2ULagM8+3kG47ZDlqHW3EK79/yi2pvNBmzUzBZWS3IZ2xvj0aESHHJowFGR3g6XAQZUHJlcg5emGPezG/6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=gLp0nCy3; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="gLp0nCy3"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso717835e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789679053; x=1790283853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWCrXi8EDNnlXkbpZEVq75srh7i90DNgXcIc39O2ulk=;
        b=gLp0nCy3fClim7tKr3ndm76uFg2DiyA0D6cqIOAnKRJOSpQ8o+xyPLpP3vZx8LwlhX
         ZzaxtcxoD75E5CLIDsNLK7vEF2GAzjR114fWmkG1JaRoxEQPenEGnDj7UNdS37j0KznZ
         BYFvi7HezkRNnAy9r4sWHTnsyQRQdmFhp7cLlj8IqT908bOTKOR24W0bteIq+H5cVX0z
         5lvrXKvu0kBSnzrHLByl4k2BH+I3UobjNZrpvzkxAxGZUXRJa8I2afHvEKcCgpwmxOy2
         KR3QfRucc63p5Axc97F2Fiw9izR5yByJl9PNfMtQS8ZsW8arzqjBHRglSHLAB7jJW9m6
         qsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789679053; x=1790283853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VWCrXi8EDNnlXkbpZEVq75srh7i90DNgXcIc39O2ulk=;
        b=ckxgCuhCW1JsnXv4xoODhooGcBeNPdzC5YVhtkEg5FeIEeDYWcQQ4zGrNtsoLKC9E+
         GEx27lbzG/gAb8/iwTSd2EKXIx7B26EK4gFqCwUpsk6TYQK8DiqWcIg/otewEibPfm4A
         aSN6JJxQUdI5TwYqVqSmB3sBICsTXU6hK1Vr7pdBxu0snqdkDZ2L3b0IFf/oMYSpAjoU
         Uf79twna8OMPdflwiIR9F/KCsIlrodUWOjKldYjN5ZVJ4sqJrx4TyJSAIs2eW6GheP1Z
         INkqfZVQUFuHF4p5A7S22WTI1wjM/4+dZksEDwCWSVJG6YtyOWmUhM8OKJglRWmGC0vK
         hvjw==
X-Forwarded-Encrypted: i=1; AKwUvBwCXxEZ1YNzGSMasgw7Keql/NXwYFCGFXzJW8Trtdcoi91H2qatn3x0gKMRhDSYIUOmDHUqyss=@vger.kernel.org
X-Gm-Message-State: AFuF++k/2ywWsMLx3omMheMZv9exFiAs5Laazz3wuEdrgrU0wuMNFI4Q
	beH+H456pWaCoYCz9Yxvg9UT6AOfJJbuT23L1LsT443qADD/xC90KtnuaM94vEKHcgQ=
X-Gm-Gg: AYBFou34BEv8YFUit6Pr71ZMEwWVHWbEwErDqmIUtzmNz3Kvj4INd9OfBsJaMsmWPtd
	LwatvGiQetWO+gE4LCcK5czgxNnFpVy13ZslLASLk3hZGrXIUoCP0ycChNdjMfbvMzHw5I13LRG
	y1ze7HzXAM9oNyAhcZgEBt0TiSdrP3QljIyHcAO95U4HfD1xmctw1FoYZYBIhusWEUbzPm5niDC
	N7b+Nke7lm1bzEYOVYUun+wKzN6hRYvVuYi5mUYyZAsFmcTNpoWkNkO0UuYHP6Q05usf3uhb+yK
	VFV6yNlOGa0sDRCrQfi0HQQ3o/1u1Sbkhbwi1UT7ix8b4yj8H4Mw3nDjiOLNayLqPRnFJbYhC5u
	LQruPzxkIQoLlg6X9vzrdW+zmGNcsgqfFkxxe9J2Xzycub0rqeJV1Of2+paceChnGgaNAIBhOSN
	CStdeYuRtx+xmXQ4df8Mumt36g3JhRjHCTLWXrb2KNOEPTKO2xgA==
X-Received: by 2002:a05:600c:4f44:b0:49f:c3b9:66b4 with SMTP id 5b1f17b1804b1-49fc559517fmr2558025e9.0.1789679052231;
        Thu, 17 Sep 2026 14:04:12 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc53b1b78sm4018825e9.3.2026.09.17.14.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 14:04:11 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: reject attach while the PHY driver is in transition
Date: Fri, 18 Sep 2026 00:04:06 +0300
Message-ID: <20260917210406.1651902-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <65b2eff4-6818-4cfa-a0e7-d48729e0cd9e@bootlin.com>
References: <20260914204200.2743251-1-f@lex.la> <6e82dc04-a68d-4c54-a6f0-a13c04fa2eef@bootlin.com> <20260917183345.37604-1-f@lex.la> <65b2eff4-6818-4cfa-a0e7-d48729e0cd9e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I need to correct what I wrote earlier, because it decides the tree.

What was seen on hardware, with no instrumentation, is the class of
bug: an MT7981 board running an OpenWrt 6.18 kernel, with the distro's
backports and local patches plus the series I was testing on top,
oopsed twice on a NULL phydev->drv after a sysfs unbind of the PHY
driver, once inside a running phy_attach_direct() (in the driver's
config_init) and once in the PHY state machine. I was unbinding on
purpose, racing it against port teardown and bring-up, to stress that
series; none of this shows up in normal operation.

The dereference this patch prevents is a narrower member of that
family: drv already NULL when the attach starts. That window is the
short stretch between phy_remove()'s last store and
device_unbind_cleanup(), and the board never hit it on its own; the
msleep() was needed to reach it at all. So "the msleep() only made the
race deterministic" in my previous mail was wrong. The patch closes the
entry to that window; the wider race, an unbind landing mid-attach, is
untouched.

I will put all of that in the commit log. With both facts on the table,
net with the Fixes tag or net-next is your call.
