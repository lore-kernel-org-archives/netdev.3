Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8508126BF7
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909152; cv=none; b=KpLSbtEb4ndH/yeytsa1ZvgGcHIUeGLcoYaXevxW1fvzPG3S5RqcQQ9VVQiGKI/NupciHUSL6Id0/yrnb3pkwMMwfsZsrxFZv8UN3oMWC3WdOndChb/qSi09R204bAzNYTqxL1HsBXMtkmGPMWsn+iE5GlHyJhJKWj7vdMNFsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909152; c=relaxed/simple;
	bh=NXQQ0WkSmgtYQRflH9tioiw7U5+rUuPB44dqz2UDnCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0Vf/m6VXZn7n/X2cHaI31LA6Zz/DWOnvTw3VSAM0ZSeZ6CkLvnkeVZ4KyIwob0brRGJJ9XiLsmaC9cGlfu28i+J7ZfvakBAJHrqlwA/fjpj4UeOtBvIIPzu+vb5PZfCcMBokoElj2ae4rbnQpaBGTgYs01r2RdMj1hv93VBRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45c798c92edso3276244b6e.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 03:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909150; x=1769513950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhcjOLbEZG4bgQTQWPq2S3Utcl+3a4AuxvSi1hMPyUE=;
        b=d0j8dDHAbsFDSj1GJcjH9onZ2h6PZt9W0+p3jR78mx+wFnmKFMfcjiPUtGg5LHqP/P
         nXIwLeFm4eqIN47BJwUHO3PWk5poHiIhWfP/C20s881RQrVIuBGmDhxqaSc3/TgV7LT9
         55lCyIY7bcNxsjhqsCizyRwJqK318cMkJoujBZKARm0axyQ6ga4hVG2DGEeDBAOXHCz6
         /PyJwJ4rdixr6Pk+tYHX3ikwMkUOES1JfClhLKSyUr1gPVIOfO6Kv9XRUscgdmN3VQqL
         Uuv/hKYECe2MeX7rLuFe/7Ow6efk4P6rWSXyHYpp56SiSeYCX7pcT/cu7NUzFGJaNDva
         RAgw==
X-Forwarded-Encrypted: i=1; AJvYcCVbeFumJBa+5GG1AqpuSpvJsy9FAmttGavADGcVun9dCUkeJODxVUYpLtmP0Pk4HoU3N4QxP58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVrq/o+l0XXHrEJriqQkF39a93ms8R0pjdbAMZdlgQz8YerBwa
	PjIbEpVb9FTwy4dqHDKJ3c/zWtlxvfPx9sl50/4Ok70aRXp9q1OkL0ZY
X-Gm-Gg: AY/fxX68jMTT9n4LgjQy+poPy8xMxoM1kfQaXS4+i2OpxUhLp1Y8gpCIQPtE/z/anEe
	b4WGhga9z+mX+FJAxJqvvAe/26wVCN/2MKiStt9hCwK8jOrxzVCNcNf9qwMft4e1S1Lsb2Y/bhH
	EGrJOdGfSJHGD1PvM2JT+GIlPK0Q0OK+GUfacsKILMwMwNkP7jlVrLmrR2mTjm4pzhyj/y13Qlt
	q/9dFnfxJK3bquKgu43T7iMrb7/cs/zYee42qAI/WsqMVOOHwOa6+anqkgx4zfMN960HPcdY0o2
	aCH1wy5TXYp7RYdo8sUhF8lIsJJuYB+3kJFLdSYJphN1KqG35NeMsmmxdA2tcALB3datbsm+K8y
	y8bvyNBwMKOC8YSZhKbR6hKtWiAHJCP823WP0+yIFCgta0OIuq1nNTVuy/p3lpGvsz1U+uWlVTq
	1lPw==
X-Received: by 2002:a05:6820:81ce:b0:657:5f31:31b1 with SMTP id 006d021491bc7-661177c31c7mr4988879eaf.0.1768909149768;
        Tue, 20 Jan 2026 03:39:09 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6611890c9aesm5874107eaf.4.2026.01.20.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:39:09 -0800 (PST)
Date: Tue, 20 Jan 2026 03:39:07 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 0/7] netconsole: support automatic target
 recovery
Message-ID: <aW9pLtSpTwp4pwn9@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>

On Sun, Jan 18, 2026 at 11:00:20AM +0000, Andre Carvalho wrote:
> This patchset introduces target resume capability to netconsole allowing
> it to recover targets when underlying low-level interface comes back
> online.
> 
> The patchset starts by refactoring netconsole state representation in
> order to allow representing deactivated targets (targets that are
> disabled due to interfaces unregister).
> 
> It then modifies netconsole to handle NETDEV_REGISTER events for such
> targets, setups netpoll and forces the device UP. Targets are matched with
> incoming interfaces depending on how they were bound in netconsole
> (by mac or interface name). For these reasons, we also attempt resuming
> on NETDEV_CHANGENAME.
> 
> The patchset includes a selftest that validates netconsole target state
> transitions and that target is functional after resumed.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Tested-by: Breno Leitao <leitao@debian.org>

Thanks for your work here, and sorry for so many revisions!
--breno
