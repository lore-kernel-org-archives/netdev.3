Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899651121D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786649; cv=none; b=MyukYPN77R81muix0Ca6JCA0QHlaz0BQ2FHxiCz3EBhEQofQ0jtprSZtl/9iiwr21fvhtdChnZYHeK767Wnw9bhVrG5heUC26IhMr4om+QLUdC4oiE1ZPf6K/0VPtIUJzP/OAc82qCfdjzBjV7FnkduZDPZ4Nv3II2rqEUO+kNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786649; c=relaxed/simple;
	bh=IlOWPmoIS1wBYoM/00Hywy9qyD6BB4xhp9iVnM/iX8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Avyp4pRJhA+gczttjowrXRpFFS25Ralt0GA11cUxJAR8jE4amdJSi692d+RaHZcXwoRxfU/zopzORG7fMcwqy+Uet3xwCfLJ86bANeYE6lno0JX0DVFtz+B/XHG3z1a/Uwi1H60v5WF4QukSu9g9F7zUfBOVkf0Hh3Q6sQb1pZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=RLqFp+gq; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="RLqFp+gq"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f7so25284115ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790786646; x=1791391446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W33h7LP0cHQ4lydwZhCKuU0weHrmwtzViKu5Dtf4WpU=;
        b=RLqFp+gq1gtZHRAJ7J6pg4LyuxJz0ALeaC4BLXm5WdYLthF0aY71xGsw/t06TWo5DS
         +yqB5pjq9zCt41x91hnMDDu5WmXyht8COG5H/7JJtAiWmOwTJGNwG+2oVtt8BuTh58tF
         BuCg83Ej/4gY8pdP5eXqajGKPoJ4yTtK0TjweGilCAZD5qOezzZyQDgIkH7Wlh92EUgv
         EzNbzWl7Ja1tVzNNsVsYGUrgnYstiWUZnkGwifLMr6TFKtUR51TnevaCOfHE82rPlIDh
         k8TYkxStM0jPzS/kmTeQ9NZuP4KoSbPWX8tFnpoDPcwTdAwa+UoHLkm4iQyTQ4FjDdW1
         1hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790786646; x=1791391446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W33h7LP0cHQ4lydwZhCKuU0weHrmwtzViKu5Dtf4WpU=;
        b=AjdiDrx5X5J3ZTvT5F8GAMiLg+yEY6wtR3JiOJSNG4IOTTaIsI61RKu8qZ3ns6Lc1W
         Sd3FPRB9WofHI1viq5nthK28rNvDlOgjPRSTLbrm+tNlfY+k5RoEcBUI5BtkZnkrl9yv
         WUFLY8Z3zvvOjT4DWJk3xVmtRpLQW6tqoV0FRmco63dwkKTvYua2KPL8mNq0OeuUu9VQ
         5cCiUX0hzSAcno1PLpHhYudMsr6b2vgLB/ecT3K4X33CvHjOZQ+gPpItAd0YUxVH6J5J
         7Vt5K+MZ7j3UGJolUSB30DBo/vae4WmzALmDY1KtERWXwBN2xuvlWn8t2Xp4nM3fLGmV
         jnJg==
X-Forwarded-Encrypted: i=1; AKwUvBz5C2hjGJvtQ5EM2sYHXfC7ux0fAjL/EhkfjLe3M5GFNNJ02695WJclssS7oaJaSVRGsrEcbDM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIg5/3xn23yUVZ87dIdfAlD1saCusRTCyLF/myHO0L7fx8UrseD
	m9IX+1ynhJFcUGLt7OMXWpmKDJ0Z0E/i9AVTIohT3CUkOrK1rEqrsBPHd9+PacZ0NOU=
X-Gm-Gg: AYBFou3H/k7gZ/5X2/My5N21PzOcrRIZeQswk1FGNDyprUyVgblTzv4YHV5oyIl+25Q
	2Qe5EBqOSFKaN8e9yUKTsR8Yoo5E5C/E+5za2C4IsVYrzhCKseCVhO0wH6empSpPtRthT0jfHbz
	WzbpgMMiEXauVD7j5ZWIMADlhYAcxX3Dh7kUR/aOCvwPpT1bUcB3s22FFx5LK+aGPRE/ZX5I+9/
	Dkx/fNRZNwoRGRMFjNfasvpDFTLKk8DE5eb0mY7ArGgMWilLkixpi3wkT7KbdkUbky2SsgXCscw
	iX6E/8s45Zez8JVPwPGuGw18mL8k3Ns6JC67WQV42QNpBFbxHqvwarvcfmnumsTznapS+jHe3GZ
	PiVKx/E/N9uag+23cLzo6XWak1zaK2715A9hAFGBfrrJDAEFXZdLbP52HiyZ23Pksxnwmrl62bH
	kvLBDGWQi30LDwG/r8pJ1ooTRoqdONYbf+reRySZYbKXKsSDEC5O+tae7XoCChFc49jkkYx9KIK
	kO8G4BGXhKs
X-Received: by 2002:a17:903:b06:b0:2e2:fc69:c15e with SMTP id d9443c01a7336-2e2fc69c990mr2871005ad.65.1790786646189;
        Wed, 30 Sep 2026 09:44:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e3005839d7sm396175ad.6.2026.09.30.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:44:05 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:44:04 -0700
From: Joe Damato <joe@dama.to>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Dimitri Daskalakis <daskald@meta.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>, Tao Cui <cuitao@kylinos.cn>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next v4 1/5] net: Add netdev_config helpers
Message-ID: <ar08VMVC+hYDI62t@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Dimitri Daskalakis <daskald@meta.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>, Tao Cui <cuitao@kylinos.cn>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>
References: <20260925104417.2325213-1-bjorn@kernel.org>
 <20260925104417.2325213-2-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925104417.2325213-2-bjorn@kernel.org>

On Fri, Sep 25, 2026 at 12:44:08PM +0200, Björn Töpel wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> netdev_config manipulation will become slightly more complicated
> soon and will be used by both ethtool and the queue API.
> Encapsulate the logic in helper functions.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/dev.c           |  7 ++-----
>  net/core/dev.h           |  5 +++++
>  net/core/netdev_config.c | 37 +++++++++++++++++++++++++++++++++++++
>  net/ethtool/netlink.c    | 15 +++++++--------
>  4 files changed, 51 insertions(+), 13 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
