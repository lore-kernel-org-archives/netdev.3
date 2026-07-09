Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65937998A
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604805; cv=none; b=pJ8B5n6FI8XnDoPpaQ62rd6WmdKNg8ncLe7PpKO0sNiPXLgZW7kqrn2uMjnyux5AnzsbQxjKtHPQkLKXmaCa10KGhb6PqoS9RiAWyY+a5P2gHDwS/GFlsPgKRNhmNAGQcfWK4qbPkVZH3cjv9o2l1WEhxTJKJgyI8DjNYrIVcRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604805; c=relaxed/simple;
	bh=bsyQtC8a3oH24V15nPrleo9VPAS5EZuSVE67jrgpcoE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHfaofjKsekQCbH+3gaNZGjwRx4IwzWo/aHKjY5w4NgXpb2WyIbhCP5bCWQrL+BfSViq6Feizog/dZ2/obd7mOknOtwFuR91vFrGbAa0fdVlq3gJ1nVtYX0SzGMAUKNQeu/oNs1XDLnAS5WbcM8YsdQ8v/h0ryVgEmHNy3ENHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwmDUUiU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwmDUUiU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so17719825e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783604799; x=1784209599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VJDvm2qFGqyazE/f3miZk39Ls5Z/IDZ7Dgt1XYVnHJA=;
        b=RwmDUUiU2zQbQ++rFX3zYLQl7iMVACKmsO+kzetnSR2D4xGpjHkHHzejnAZn95qNDL
         IdsPAsD9mWp2vgchLLlyd17TeUGXVVjm4nPbihEKXW7Ki6hwbs9TwWomupsh0CW3NQJR
         VZXLkmO9is+MfSMpGZ8hS2b4Z8j4713j6adSjvrG9uOp9qwdPqi4ZttaL2Rqy1KpCCWg
         IygR7Myq/DpPbIoE2W6AAJ2dKQeFsllnMVpnEk99QZYdjPlHrIXND5LXwBJ2w14QXIWl
         e+brPRGuGPy8GVgbfObIMRMjvgn4oM30HwblQfEY8qpqmuLRlVM+6obfjpIQf+CJxb2n
         k1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604799; x=1784209599;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VJDvm2qFGqyazE/f3miZk39Ls5Z/IDZ7Dgt1XYVnHJA=;
        b=COv5jYuGt2i9tTfzZO0GCTFE/OvkjRNr6Hll/oufopsKgU6rJSspwWRb22XeztRHj0
         HMfv9+4LglCnj7NwVxJ6z/VZh46KhM/hU+euURkKqZfDXhTiJrnxb/plW1Fgos1VzC9Q
         NHg6rIsYNuTdrWvFLJdzPWKG007kNlrFY8Ete+GP6WJvGsBk+RwbxlpeE8GjiMXYKlxU
         9x8t28iqLXD8UGtKMtuWqgVVfksKzkjIz7RLyOHfPJOwh4a8YefrSz4U/eFZjau2NNXQ
         d2HqM52HlxBxieWjLQ6BbfUNhgTfvAmBthw2dpwM33d1Z+XDIwcQOqRK3yu5ANSK+gQL
         5N0A==
X-Forwarded-Encrypted: i=1; AHgh+RrC2Yk/hhiqk+q7LxZbSUxGM2X6yeYOsyHfWTr6h9QiPtTHWkdPt3bmTMucaQVmiroduX3v8cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZXtyzrt/WgrUHTQGlQ44p/9+avRxjRUOk0eE1+UTBC9XplZh
	GyTq+0YVUyulG6DLm+43Vbnmwh6TiODxkuAMHKiVn9KdbHEP/ZygUUaU
X-Gm-Gg: AfdE7cnySKtycknNuWQJILbW5jcYGW9ZZPhHaeM0BWEaPDuuGzKG/EY2s5L2B4kZSIA
	4sxxfQBzsUSNl1eTa9YjA18evbela4Ha8OZBEh5tezmMGrueJ7ucGYvu148JB9+zyAiN3H0xVYF
	S5+0PXQM8MBvlp0CarOEGNWnRtxigPJjOSqPLa0R/gxBT6ToHtHYJsW1mpoFnSrCCW4UDQZxrZ/
	O/WgyZjXTVJxzkNQwKfohB0EQX/Lv6e+Ruu5/QVj2ip+vxgA7CWV54i/zzSEP2/7tqBeD4Al16T
	mMonZk936McLFd3TwnVnuW7yQATssPdAoODaYiiHjWKFpdgLGIXJjGEkt9dSBL3YjoNKAWgLZuF
	P1pZGOvmXVY7TX+Ra1wrPG4g+XvKZ/0pXLNNFCag5AMjcOksAO1YyKK+AxHaDcxof4QrNR7xBVF
	hEMeY0uEJd8Cv//KqakzaKAOE1SaKmXnWRTnEzoa9HLqMmzYvyaWSLI6sy9KvyrPk=
X-Received: by 2002:a05:600c:4e11:b0:493:ee2b:c876 with SMTP id 5b1f17b1804b1-493ee2bcc04mr21300345e9.35.1783604799102;
        Thu, 09 Jul 2026 06:46:39 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6cccfdsm63149545e9.1.2026.07.09.06.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:46:38 -0700 (PDT)
Message-ID: <6a4fa63e.f4f4081c.1a06be.032e@mx.google.com>
X-Google-Original-Message-ID: <ak-mPUz-V4FANYy5@Ansuel-XPS.>
Date: Thu, 9 Jul 2026 15:46:37 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/5] net: phy: mediatek: move MTK GE SoC
 registers define to dedicated header
References: <20260708102341.53919-1-ansuelsmth@gmail.com>
 <20260708102341.53919-3-ansuelsmth@gmail.com>
 <788172f8-1005-4df1-afb7-320a135bdaf9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788172f8-1005-4df1-afb7-320a135bdaf9@lunn.ch>

On Thu, Jul 09, 2026 at 01:44:37AM +0200, Andrew Lunn wrote:
> On Wed, Jul 08, 2026 at 12:23:28PM +0200, Christian Marangi wrote:
> > In preparation for support of special Software Calibration for Airoha
> > PHY, move the MTK GE SoC registers define to a dedicated header.
> > 
> > It's also needed to generalize the cal_cycle function as Airoha needs
> > only part of its logic (the wait logic) to complete a calibration cycle.
> 
> Can this be two patches?
> 

Sure, will split.

-- 
	Ansuel
