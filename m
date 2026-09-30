Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0F5012AB
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788969; cv=none; b=X8aDjuo9lYoHwxOJ0yEUQ1WDJfRi8jSpy7VP5NW6O0bo5kUGY94NCdtRLMfXKRHEuIu7PyjtFRAWYs9aZEINi4n5fKZZUTHiyEksEjvgQWlbv1hhgfF+isGIzakCVDMkc+AdopmHakaViKhqsU+oCfwaprM6PNisfs6amDTWvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788969; c=relaxed/simple;
	bh=yK+pDlVhAREALfwAq6t76dUuiQevZNARvK0Q8FpoB5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9cU6F1LPLu5y/AQUBzi2lsKYxkTTUc/hq++KZ4LmbRrdEX6ID/pjdmVP6r/lvmt/mv/pVo3VyZM3KeCC4Srx7elInNAFBPjQvMCRm9x7lQSJ/w5xYzCwuKd88N1i/zR+FTwSPz58Jxx60CWlSQy7eot7qPbj1w5bnxNUPXauwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=hVRvahaO; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="hVRvahaO"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso3236880a91.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790788965; x=1791393765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gNFAtRlTmPFHVIeg50+5hEO3wy5E2ApPL5HtRzKFQzc=;
        b=hVRvahaOOQuWgV62p6y1rWQVjoDgU6EpHQf3kQxqn0TukpjSn3mo+HhbAv+9ED7kgk
         LLncIQ8yut0+hRD8H3wyC144hLNMcuiAOhv3jpxovGU87KAzxCyHHJt2KRrfYPNnhIon
         0eRXeX2RscgOpsSsPWpZerwT/W0ESITGudApV6xhzzq14qsiWKZ6609meeAOosgTClqQ
         /miaAUx9ArGo8smTF3pIlQ4GoDf+WyTDTmNEXb4FRyrXpbvYFZ+ySD+E1G4otg/2d1x9
         4G1N5aHpq1O9Edu/NM5YLJde6y02MK8PL7Fb0eSGLgYWsxZiIcEdBaFR364kqV1V2NG6
         pQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788965; x=1791393765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gNFAtRlTmPFHVIeg50+5hEO3wy5E2ApPL5HtRzKFQzc=;
        b=GNMTVFZ+N5e8FhoMKQHKHiPuBs1NRWerf27XMJtrnYfhVIK55RQu7uKsHJ4cFacoe8
         5TJba3aFdbaTFkEjQft0eFn1GqpAA3fvXPxqwUydL1aBlnF4U9ikjdzlUN8QofdKPXzs
         0aye/+Xxn3Mod45VmGrn7qLKozJrriYsrkUzUVuE/L0uvdVV0cCHryQ8dwp/xTH1USC3
         HBbe0ajDiXHdyzpdLUkpYVvB0Yhh4l4/tRNSq0FExEubK9ICpS6Wd8fod8druxtdK6wH
         R2S6C/k7n6DavAyZBM3sTViEFifNYQuwY9o/XQV7ToJ2cWa5HANTFTREqaTnWouLqwxV
         J1YA==
X-Forwarded-Encrypted: i=1; AKwUvBx2m56Y44iC+uDOTphtQyeF9D3Mtc0qgT0DYv4FarWqUIEugH6av8ytuqHq5TQruBUhPwcNDYA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLs7sfl0o5m10zoYzW2WIgCqY7YzdIpA+Km7HFJbEk2B+QR0K9F
	LfBW8XKdWzLmor1+gW9hGhn2q9SBIZyheWbVJ3EC3q9igUeW99WXu8ZQsyxiCv9x+gk=
X-Gm-Gg: AYBFou2bTRQqbpiKBck99uHcV3FrMYjye8vs5ePiAFbJeiagkC+B677VzLUhsqMKtK5
	ts8wamkZuTIQ/w3T9TOj9Px0CudVzX0mz7rXnY5tfFzZbrydjy4KGB4WbiVnJ7MP3HLTzHcQYDa
	c1f+2rv0pAsr9unnmRuLT1xiH8LS7FobaDQMaac27MoW1l5JxbWX1jfrsZBS3BmJ65l59kDAIsZ
	qY2MPXmkPQGWurIRfXgODdL3NdclAxIMEUPVkRRZWefXVqQFpmV+yNJyyiYAdxSzYwyLPN5Q3LP
	6nYv/LkmKQ5eGyIDkerkCSEczWngCUgh1f2Hk9EemgLtfrjNgKsqARyhGH+LPJWa4fbB4ejtR4z
	0hxZqwcbkoON3hJba0KnkULyIMDB4k8zAfxab3cdlBSF/Kv+Rbz1wOWOJASpoDJARUKlmTkhqj+
	qrUsf41/j/EPBRYkhSFoqqHi2xO8wnCK1OMlN7CgUBn/JoQehjDyU2sEDH3e2KvAq0GLXw9Pjdy
	ZswewihA55X
X-Received: by 2002:a17:90b:4c4f:b0:3a4:97ea:f0da with SMTP id 98e67ed59e1d1-3a4d1543e9dmr2182958a91.17.1790788965538;
        Wed, 30 Sep 2026 10:22:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e697008asm955906a91.3.2026.09.30.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:22:44 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:22:43 -0700
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
Subject: Re: [PATCH net-next v4 3/5] net: Revalidate queue config for
 ringparam changes
Message-ID: <ar1FY5vcgpUMBdWJ@devvm20253.cco0.facebook.com>
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
 <20260925104417.2325213-4-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925104417.2325213-4-bjorn@kernel.org>

On Fri, Sep 25, 2026 at 12:44:10PM +0200, Björn Töpel wrote:
> Memory-provider queue configuration is validated when the provider is
> bound. A later ethtool ring change may invalidate it because drivers
> can size queue memory from both ring depth and RX page size. The fbnic
> consumer is added in the following patch.
> 
> Keep configured RX ring depths in netdev_config and stage proposed
> values in cfg_pending. Validate every RX queue before calling the
> driver. Each check validates the device defaults, then any queue
> memory-provider override. Commit the values only after the driver
> accepts them.
> 
> Drivers which consume stored ring depths through queue configuration
> must initialize every RX depth before registering the netdev. Stored
> values override callback defaults, including when zero.
> 
> The callback receives a rendered configuration rather than a queue ID.
> Validation should depend on the configuration, not queue identity.
> Checking defaults also covers the case where every queue has a
> memory-provider override.
> 
> Drivers may normalize ring depths when applying them. Require the
> validation callback to use the same normalization. Drivers must report
> the applied depths through the ethtool_ringparam argument so the core
> records the result.
> 
> Use the same transaction for ioctl and netlink. Drivers without
> ndo_validate_qcfg skip the new validation.
> 
> Link: https://lore.kernel.org/all/20250421222827.283737-14-kuba@kernel.org/
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  include/linux/ethtool.h     |  4 ++-
>  include/net/netdev_queues.h | 56 ++++++++++++++++++++++++++++++++-----
>  net/core/dev.h              |  2 ++
>  net/core/netdev_config.c    | 38 +++++++++++++++++++++++--
>  net/ethtool/common.c        |  8 ++++++
>  net/ethtool/common.h        |  2 ++
>  net/ethtool/ioctl.c         | 24 ++++++++++++++--
>  net/ethtool/rings.c         | 13 ++++++++-
>  8 files changed, 133 insertions(+), 14 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
