Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A6E391517
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791048338; cv=none; b=FckpM8yqTCHv3x79YFwOPunMUgSMWrvfX3gyW6u2MnSzACU46ukCC/fY1uTB6ukiwWMLOAndpdenaebXHNuJk+2f+k5VIvFX13MnW5+znvxLB2rdP1NInhIi4CK/MfzUEkzBVLmmjwuVZl0gmEmDXcPVtz1XxE2PadMbowxPce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791048338; c=relaxed/simple;
	bh=+67JRRdlaPsn0nv+yCFFYOj1t5ajXQY+uGgZEsdgSww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1D1tKfXts1xHlZOzPvQSgbrpfQ1bZNly97NTLNfOmsTyfN0BwHtIpnQqSzS5afiIpPS3BNj55n38ejv+eOh1ivGY1VKxuIZg+HuaF+m3EInPT8CudvwdOdAejvKdtgZO8yg7/pElyPTbLml+pSDSueAItGtxpOmSGPl+mXzRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVKtxKro; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVKtxKro"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6af82ce3c83so775514a12.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791048335; x=1791653135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+67JRRdlaPsn0nv+yCFFYOj1t5ajXQY+uGgZEsdgSww=;
        b=pVKtxKrodPXv3WTyL49M/zZwVQuh0vLv/eFtZLkRDEcOwVTlVQR4cyc3r76u+T9eMP
         QkN2Vytw1aBGqyC5O3nOdsG2DuARDgXf9OY4v5s2C80nPQQrmGrkZeXu+TngXBggxi5D
         1LE1uuZFXzo7QA227U8vVO3gehM2IT9rfp97kNmvhCfIogKllbGCH3SgVrSqsFRGb0Y5
         Evq0NtjyExc8fAgNC/3Yj4S/nMXxGUkFLK6TlqBu2zWy/zILcMudiWnuhgv00bQz+uxt
         +Nf0X6cIi4dQ8gklZZ2+lL1YdOs27lvdXXs0gCakSylJQHIUtPwm/BWi59X+28JgkdSJ
         qP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791048335; x=1791653135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+67JRRdlaPsn0nv+yCFFYOj1t5ajXQY+uGgZEsdgSww=;
        b=iRNH+cBez6pfhnmkUHa5L5H94Kpo6lmjNhBh3iPMmY5JHYzt68T+KbaCgfH1M1g0pI
         /zBYDBvPftQ82pqfgbqXrTYoOD2vHgDjB27E+TBltFuAF8Sv5M9r326lZ+blLELr2UUm
         +KyWpZztzstq4FBSmFeDGrLjquwVXl6a2FQhHs179JExv8fODvYc5FkK+qxmWCswT/gA
         Blw6FFbaJ4/9czv0GwmMEBal+PgZkGanRCEPvoL/ToRkXa0AeWEq9/0ujDQEKoN78cip
         nq8//whI2Kfgd6ggjhGGqXoE7QM1GXtmSzsba2BT1xdCQ2W4flZVrktTnyK64n7vb3Gj
         VFDA==
X-Gm-Message-State: AFq9FYJlnd3Ti7mezz9Bn6ATlrIiTOlbm2FITxfCafED73EBw/9iEBb2
	/ZQFobXEWtTxIs7ww/iaKCpOKvoL+04zjb120/afoHQY7e6UqCyVVMpYkp5mSlTAlcYcWA==
X-Gm-Gg: AYBFou2eshI/97PdVfJpvTzlNFhlAhnqebA1IeyIvvJdJvAePD1eFw0PQB0ip52IGgu
	8lEjkhnouI3AwSPo13UOuGn9JI/USHD/ER2OhWDQookhIHyr7zjYXRlglVksEEtPO8Mn8Ugy70G
	QzTV8JBpjXHmuML7okBJC5RJ2uN8mvO3FLjmn0dBzZ9QYAAGvy9WbO3BYB6TlGvI5x95ZEJC1Pe
	zgEkdYE+j4ZxvOXDzpHbdC6EGQO5naGJLeneVcvOKPGhbTOBFzLYsMb2f/vcubJotSWlWRwjamh
	SALUXRX7PRwcf6iMRnR1mmu9SDl0bMryVjEjQlYMXjOxJuuu3bt6T7Ny7Eyc2CkJuF1yBEHqyaq
	tlOWLk1Nm3DUu/NzpPNR7G/GXPyAqEsJZ3yQHVN6o3yt3R8kV3hJfI0pEXQTjpgIAa5ib4bYyI6
	rJ7IIM3ANmsSYUvVGSxYupboEDKYVlZgPfgtkH879CyX81ZS0TFQnrStnQAWgj5grzgafibf/1V
	Sqc3KkAzM3p4VmTQ3ccYnWJEOdm4Lmg18kx4+hjvX4bTEQRXcHI98AR
X-Received: by 2002:a05:6402:50ce:b0:6ad:b23f:e325 with SMTP id 4fb4d7f45d1cf-6af9e3193b3mr4811704a12.20.1791048334952;
        Sat, 03 Oct 2026 10:25:34 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:7995:7ccd:ec2b:6712])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e592csm1023285a12.6.2026.10.03.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 10:25:34 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Ziyang Huang <hzyitc@outlook.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] net: dsa: qca8k: serialize CPU MAC pause during MTU changes
Date: Sat,  3 Oct 2026 19:25:19 +0200
Message-ID: <20261003172520.239-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <179091424456.434549.5853243408552872110@kernel.org>
References: <20260928220811.1880-3-yongzhao.derek@gmail.com> <179091424456.434549.5853243408552872110@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review. v5 will clear and restore LINK_AUTO on ports 1-5,
limit MDIO bus classification to the selected internal CPU port, and use
negotiated PAUSE on that port. The dropped MDIO write errors are handled
by the separate MDIO error-handling series, so I will post v5 after that
series lands in net-next.

pw-bot: cr
