Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639B448033E
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789942843; cv=none; b=i3qLmtqcp8EHHiL63DNPmfTD8Grm8xnBeZ597eGRdSJXVkhIpnY74PcdUVklBFPcLicb3R+gtEcc2yYdH+W9we6EyZnSxXoixzm3fbkzf8/58/7Qklg3G+6KX6o279vnvGKrZlR306lZWWGroocPGkJvym6ULIcuU+FGX6ZaxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789942843; c=relaxed/simple;
	bh=+54H0ZSrJDrdA0kUPxIm1BbK00gcD0a+FHvu4EWHcug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8Y9tlaz+XhGgRbR94jDrl3m0k6Ml10KqOkMC7g3TIgZVCPkTbomRrLzqQcmbDU0IWfqc+tEL01Hj6pBj2qGm3X210HTxfNzVTgM2vBOn6WnfLpVIyMdMnsti1XG9hXPyadfcqMCd6XZv9KM0Y+S56XgTaZToQUVdY/A7cJjNbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=k0EUoy2R; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="k0EUoy2R"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4843e397f74so1118800f8f.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789942839; x=1790547639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YH80rpgSpJiT4oe8RoFHzKfIvgPsLUkVWLUg9beuJXU=;
        b=k0EUoy2Ru63XvED/bppIwMAaY4DGiY4E6xl4HdZAxPZBY6Zt7jwv5lJEYOe5Ua0mvR
         nI+hH9VS6QBgRs52c/c2xSNOasDmN5zwPMnJyc1MP7f/KX58X5UvC/5CBPUTzPfM8NNq
         TMVnk1lTAuDEnr9pT/UG8Y1aM0DTEn13XLvg+EFpWWTNVzvxHw56Nqt4lrCspogG7Im7
         HPAy1QmjEp7uuaMntJLoATUzzDvXZ7Wllc4TX0+xxxbbRHisB34NDTOtWFV/ooOB+d+v
         FDEvfZsWJiHPuQ/PFE7brGnIC/JSdwhqSLHisF6AxWZNf7w8/O7oDrILLlxIqqo11P8q
         j3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789942839; x=1790547639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YH80rpgSpJiT4oe8RoFHzKfIvgPsLUkVWLUg9beuJXU=;
        b=h7ru+CasMMoHHReMs7IEinzLBW1OVfGJ9Tsn+NV5/dvmkDdKNUOUsuxcpS7BV7Uq5i
         JjYaT48WYe/i3sbBw3C0MBhEQkM0TGh4vMDjfm991ggYSJvF7RetSm9EwckzbBBA492c
         N0gToGqPJZLhiJnKJ7Z37FCCcaQQz5m/JNEp88ksnSZ+3PwKuYsYeucG37GaxItZ780a
         s5scMMtS0BoudMb9wtUDr728TZjLvk2DmOWgnOZ0Yg2vnshn/wf5jsJcQg2PToGM1oCp
         U4/fSo4Hf3SVpPS1UZ29mJfmpS5nTtiNT0zMOVRhpnfrkJ4kdLrGZJ74D2QPtdVNJFUF
         JK6Q==
X-Forwarded-Encrypted: i=1; AKwUvBz4+LEXLYdSk2XQ7zVfHaiKed0P0zxd4YA6VGLjwzGDy2W2ZRTYhHYOaI2bylkUCM0XLgV3Bno=@vger.kernel.org
X-Gm-Message-State: AFuF++nUA+yK6EZurbwnAoh/0Ab+AqlYtgRRo6WXX8nMBUh0CWF/Zpai
	+tyWp2nnt6u6hy1eMsePvSDYBMJDJ56r52dQkA6X+gjjVtUAVUhgSwdyrpbiYU34McI=
X-Gm-Gg: AYBFou39ykiYhpmOBHUSHjIdjrDrCI5GmezbXgQ1+EIozcCFb450WKifqF7TNuY9MKv
	jpjcz30mp8rHFrB9g5FrlDKnwF4TiXKZWojtP+l3StMZIo1Q12dmYA/EkDUUriaa4CY9Rb+F09s
	4LqoG0Ccy08KeIc2ZOCVi1d6IKfLY1V9mrby3aF9FUTHSxOfW8y+nVHv3qWgz78aox6yjJK5pdG
	1XofDTYQ8t+Gtjmvy5+A+c+CCe984nQdbjUCjCLURSlhhbvtx5M5gyXes1kF28LVHRjut656n3P
	4vP9L8wfy1HMZdvuxlqLLig/FPqSqfCdQp1vA8eWbTvsgKExtsTA0uFwWclUPTbBqlRwLlQiGrE
	Edyd23lT7iQU0AggSJS+3K6Aa5sXd8poE6overgiMV1IXhiiZHTx0WjQsR+0pSKljrN+33wfETf
	yrqNXm9JvKHiVlyo72stFkSC1D/dRmds2sEyk3W/ytF8RctlTJOA==
X-Received: by 2002:a05:6000:2612:b0:487:5:9cae with SMTP id ffacd0b85a97d-48713c47421mr20753759f8f.16.1789942839054;
        Sun, 20 Sep 2026 15:20:39 -0700 (PDT)
Received: from remote-01 ([84.17.55.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724589c02sm17230966f8f.24.2026.09.20.15.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 15:20:38 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aleksei Sviridkin <f@lex.la>,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phylink: unwind the PHY binding when bringup fails late
Date: Mon, 21 Sep 2026 01:20:33 +0300
Message-ID: <20260920222033.1751618-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4eedad70-0b77-432b-838f-eb11ca47af4e@lunn.ch>
References: <20260919015338.499611-1-f@lex.la> <4eedad70-0b77-432b-838f-eb11ca47af4e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes, and v3 does it that way.

Nothing between the assignment and phy_eee_rx_clock_stop() reads
pl->phydev, and a NULL pl->phydev already means "no PHY" to the
readers. phy_request_interrupt() comes after it and cannot fail, it
falls back to polling itself. So the unwind is gone.

The fallible call itself stays where it is. phy_support_eee() can
reach drv->disable_autonomous_eee, which writes PHY registers, so
lifting phy_eee_rx_clock_stop() above the EEE block would reorder
MDIO. Only the assignment moves.

Tested on an MT7981 board whose MAC implements the LPI ops, so that
call sits on the bringup path of every port. With an MDIO error
injected there the late attach fails with -EIO and the retry brings
the port up. Without the change the box dies instead:

  Unable to handle kernel execute from non-executable memory at virtual address 0000000000000000
  Workqueue: events_power_efficient phy_state_machine
  pc : 0x0
  lr : phy_check_link_status+0xc4/0xf0
  Call trace:
   0x0
   _phy_start_aneg+0x4c/0xa0
   _phy_state_machine+0x16c/0x300
   phy_state_machine+0x28/0x80

The caller detached the PHY after the failure, so phydev->drv is NULL,
but phylink still had the pointer and started it again.
