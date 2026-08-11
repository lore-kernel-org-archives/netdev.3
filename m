Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B014188CC9
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408579; cv=none; b=lBYmhIy29BU4myntoObaP6xpV0yCJ+bPuX4DPdK5rY6+//IVptd4lD0mHjXSQdB3ftO3W6FLtu6OPwS65idjiscURWbT5JEqVfpB1blkFuFVn5f/iOzySoIQQyMiEuEjr9vrX87BQBSan09AHepa8IhRGNj51LYcYaopF9UiUc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408579; c=relaxed/simple;
	bh=DX8pVUfZEgyplmk04LfsiN19ml5nMNGHM+ADEJiHV7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTX2MH5cuSFqjUjMatWYuQ68sIFNBhpKjdcbusCjTaH57BPk8TvB0sohZoi7xVD97b+FL55uXXVzxSd7/UvoCR0kOhSAAjerHOfQk+UT8MWH4m8KSZ1X7TekNb1iXrYZV/dmcOHq+5k57AGgeUAElMyNtcMFp70oZy/d3CrHa9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=evalinux.com; spf=pass smtp.mailfrom=evalinux.com; dkim=pass (2048-bit key) header.d=evalinux.com header.i=@evalinux.com header.b=PLxjr5KV; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=evalinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=evalinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=evalinux.com header.i=@evalinux.com header.b="PLxjr5KV"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b051b557f6so1367672eaf.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=evalinux.com; s=google; t=1786408577; x=1787013377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PSWiEpelW7KW6ZP6fu658nEfdOUDpoSUD/jD0E6v+hc=;
        b=PLxjr5KVwRCuDCvI70CxVKf3F344tgm9wWBwdXxoUyDqpLKgpcDiJOOCCFOIZNU/u5
         TzZKfYXebAK2+04yC0rM4kWegEPffkK4xOsWUU/qoUlUhVDmJAsgsMyQJ/E6tmwUmqlP
         xgBtwfAXhYjEW6PLB55HZZmBvy1tPEi7wx4JOWstlgRL+mGHluRPjfkLBd41YOdRzuZ3
         MDfYGZBIWIdITo8rkynppolmFfK+PIiwGX8Kt8b7HNaTlJBgSkkAlNJ/UBjd9ah+14MN
         6qB19PmLIIYP+YVTbEtLUYFk4Nl1285MA0jAfKrR1BLRGXgrJu1Sjx953BKCbXE5vjWr
         OPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786408577; x=1787013377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSWiEpelW7KW6ZP6fu658nEfdOUDpoSUD/jD0E6v+hc=;
        b=X+JGvA5VX4Ix9AlTvVG8Mv5IT5V125hCMl/9xHQwtooIP+VUU2wAvnTAdR0JxCwwyS
         ON7GpHbjihgnlzz4F7U65SSYelrfdUhHfSCapO+OJp0hVBWjlJkHEUZLfaYlWGpEdecB
         X2wP3jTwnura6LueE7PdISQr59byjMo2M3quFura37kVCDYETXf4XiDGu8oNDSD2G7Vv
         s16q20z0peKJbfD0deAbqI1vTcSb0uLtT3/KKv1LJtYjS7H4qpy4t5AB7r1f2Qs3SLv9
         AdsoccxtIhLjRJuYMY9+3cjF20ezcfeADKz/gM/CLSLGeTaz7WNe6ZcODXf/R2ekFFBl
         4BJw==
X-Gm-Message-State: AOJu0YxSNtkmanw5Vu9nYn5yLYPW66wfxbFbOEF4aeG2774gBfgNz85P
	UljGB0CW7dxHCqO25twKiV8dM3JeCX6YnDJ9fNxpviugV3vHpyUOuxdVB9Bd8gdEUEo=
X-Gm-Gg: AR+sD10ylrOuyHO36wL/CQcR4VC15Z/eiK0GtfZSoTTXXx+2hp2QfqYNT2wEOXaTMsW
	1EbbLmKBl5JznEffM1WCev1bdw3aePzix5kZMWD/voILfHymSlC6VjT/8oTCZg+umbgGaq4Pi/y
	asTCK9YiqCdtJwwbWl1Pw/xkkmc7/GY845SUSu3fC8r1t+6NQrNxmRY44n7XvgD7exIOl11F1lG
	By6mDXNS3yxfVi9bcyIWHtwQTCODG1u/W8x05PmqdtbcuzoTmCumfh9JKjQmtJeoxur50cBYQkb
	fgLYxqUceDqIIXStAqPQnv+n8YOCz0HcHUFzj6aJeq/oH+akDKsTZf91MeKYervcpdt6IDkGRnc
	1wLL6JDZBjVVbDeFuzOsh9hqh4V8BmMsf5mN9sQSPm5LRIO7dwYr7x7qdo37T/DZ9rP5L6tqlOF
	5AQomZK8Aimxd1HCVRQ369slS2fLZVjJJ2fHxXest+uVAnvjpUgoo3GgVOuPa1uOVFQl3TuA/H9
	KeLcBVvh+i1YuyA0AEzkg==
X-Received: by 2002:a05:6820:1c85:b0:6ac:a5a3:460e with SMTP id 006d021491bc7-6b0352ab430mr12242564eaf.19.1786408577058;
        Mon, 10 Aug 2026 17:36:17 -0700 (PDT)
Received: from desktop.lan ([2001:470:1f0f:2e4:14ce:9fa2:a97a:cd20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b09fce1741sm97299eaf.7.2026.08.10.17.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:36:15 -0700 (PDT)
From: =?UTF-8?q?R=C3=A9nich=20Bon=20=C4=86iri=C4=87?= <renich@evalinux.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org,
	Joshua Washington <joshwash@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	=?UTF-8?q?R=C3=A9nich=20Bon=20=C4=86iri=C4=87?= <renich@evalinux.com>
Subject: Re: [PATCH net v2] gve: use gve_schedule_reset() on AdminQ flow rule timeout
Date: Mon, 10 Aug 2026 18:36:11 -0600
Message-ID: <20260811003611.509920-1-renich@evalinux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Aug 2026 14:13:00 -0700, Harshitha Ramamurthy wrote:
> gve_reset() does not acquire the rtnl_lock(). Also, there is no inner
> driver lock context that is acquired at this point. The inner driver
> lock context that the AI is complaining about is possibly
> priv->adminq_lock but that is already released on error by
> gve_adminq_execute_cmd(). gve_reset() is also written in such a way
> that the onus is on the caller to acquire the appropriate locks -
> either through the ethtool core when calling
> gve_user_reset()/gve_set_rxnfc() or explicitly by gve_handle_reset().
> 
> Sashiko has also called out a few issues this change could introduce.
> Considering this issue hasn't actually been encountered in the wild,
> there is no lockdep splat and the commit message is inaccurate, I
> don't think this qualifies for the net tree.
> 
> For the net-next tree, a more holistic change is in the works for the
> reset path that also changes this path and removes the synchronous
> reset anyway.

Understood. Thanks for clarifying the gve_reset() lock mechanics and
adminq_lock release behavior.

We will drop this patch from the net tree and look out for Google's
upcoming reset path refactoring in net-next.
