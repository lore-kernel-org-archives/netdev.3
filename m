Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5D2D238F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885191; cv=none; b=d3vtzpViFgCbc5+DoJ/7gUhW7ynZjdDBpyIKS365/Q9ZeTdebvS6rKXZnPVpmc6TAjppGpmwHLNtOvNlZm3LgmiPgDnAZWtIiwz+mfUpL/Orc5a19aUubM4VXJXQedXz7QugDDvHCLVCeGhMviqt8tMkPglUnCvLLiQL26vOo64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885191; c=relaxed/simple;
	bh=itH6vbMqVbMJFlSOzycQd4i1lZJJhxPN2ByoF1230/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPG3Fbo06NHkPGK6gdEAGvUXD75/MFR3WIVU7VYNh+nWCwTY6T6gr1k8EBKeCeiDAzpH/KeYgh8BtR0pmNSoiuYYuE4/dHGsDHaF5nc/ZX1WQ+eajtyPZrfT0OAiKuOtyzGEMW9KOzPk9eawanGs1bQTKtJ/KgBCd5Mpm8ES3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=w9rMd0Hk; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="w9rMd0Hk"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a4805e15cfso2625307a91.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790885188; x=1791489988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=grsKZ1OSZx24kS0KKL4KN4ISoNfQyaFFM1VYosHh8gg=;
        b=w9rMd0Hk+ZowXQ/lND2xLY7F3ULhmQarHLxnV8DxrNfYf6fnLC7OVT/rKuVneGV0pr
         bu24hYzRhqZrmlLBHkwHumGGwxBsFmLh6TEiF0tGqgefrJFgTKJX4An4IG5fz6yHHXiU
         BF47F1Sm/NO8tFdFldO8VxSnSK+wX7NZpBm2+ZEmsMEPIDIK0iZbxgalzK4Q1F1Bhw2D
         XSIW5vRGss3h1EzK/JT0+5ruit9zGmwJ6eFQkb9Y9pZHcfUSdpNtlYmwmXXLz4YpcMvw
         i6yhw63usOXO7nCMaOZusvC6RH0VhOMJxW2K94TffckNPbBVGqHeBS1m+YjRZ2wVBi97
         KDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790885188; x=1791489988;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=grsKZ1OSZx24kS0KKL4KN4ISoNfQyaFFM1VYosHh8gg=;
        b=WOgI4AIugaSF4sVO9pAaYcrqco1q8oyViTZipSyaqa/Xs07DQgETEP2vXi0rVEl7I/
         50fYUD5G/MvDvBf7OdHhVYWwqmS32c0ktawonClhhJmmfUZKoCkUE3bzxWcGR6doFsa5
         wP1FKj/N4ditSR7+tNdgoX8YH8Oao36W4hhqdsTz87Qtyz5rvIYrVULP2OLqdIVmgYn8
         ihZzrhKQPGYWyUAv+7JwMgkZB+be4nbgeXfxMidh04gzrOhivW0O/Z4VnCDdqB2p78VM
         hwznJ2W2+NBRz7IAk7Cxz3NJVaxNBldiGeFilaqy7ShXpf9lK92NzMe5qCQpCouS5UxL
         Odeg==
X-Forwarded-Encrypted: i=1; AKwUvBx7xq+bbHB1YEoKGK4GYIzOuwDUIpsUumhrh6VCN35SZRAFLgKz18BOd9qIVH43Or5zmGpD9JY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8N+/4bEsiiq/JZDP3D9c66Yn56pPdPi1weTnMXg3vtrrKvlBC
	8JehlLdxPGrb2tTVOtiPA2nEVTfasFb9iA+oBBtsvxPPOvOQPnPXW/ainelkpdgj0J0=
X-Gm-Gg: AYBFou0OWs74wlWhvzQUw0T3mAT2ZIc+/f7n4j7dMk+D1DOmsKAdSAIy6qtCJ3zsxxl
	54SRDnrdLGXswrbmchxfQf6joaImI00mSCxf8Mgtzd/4xiyF+fJIiviBEiAEy0ONiS15Rw4Alfw
	ctHP3fSBmjej2FZd1yJv7hUN8n9Q5DWYqRA2U4+ggpH2yhIAgtDnAkRGo8H9jiBgdLj7eGnN6yi
	yef+ogUcuQJZ8YH3IJ8C+Km78ebttTl22nWYJn4Vviwl564+B3OIb7c1S/kr/RdnnI5AInvbUCF
	pZSp/zGfioOQaB8ny/zXtMuNu7FFiKhtOQp3itq3bUJPJ5/CKVnhMT/B5zB0DBo1qD1rk8Rgbs1
	9vdz2B/xSlze0ngqDEMLEBZCCLzLNYLDNPF61vrMuCmqUoEnEOvAZsflP2GQNcOlJsa2ATMtoW9
	H58jOwUtRMHSB8vmFdq4ePHHRhflub+Dj+Ek6VjzX3nF15CpMaA7SjbFJjT6OOxgJ386DiYjlfk
	cHHsBIoCl8=
X-Received: by 2002:a17:90b:4c06:b0:3a4:a2f9:f2f9 with SMTP id 98e67ed59e1d1-3a6cec2c079mr577802a91.52.1790885187917;
        Thu, 01 Oct 2026 13:06:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd135d8asm39150a91.3.2026.10.01.13.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 13:06:26 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:06:26 -0700
From: Joe Damato <joe@dama.to>
To: hengyul@cs.unc.edu
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jirislaby@kernel.org, sdf@fomichev.me, edumazet@google.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	horms@kernel.org, shuah@kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventpoll: return -ENOIOCTLCMD for unknown ioctl commands
Message-ID: <ar69QvnV3y1diHVg@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, hengyul@cs.unc.edu,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jirislaby@kernel.org, sdf@fomichev.me, edumazet@google.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	horms@kernel.org, shuah@kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260924185747.2166326-1-hengyul@cs.unc.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924185747.2166326-1-hengyul@cs.unc.edu>

On Thu, Sep 24, 2026 at 02:57:47PM -0400, hengyul@cs.unc.edu wrote:
> From: Hengyu Liang <hengyul@cs.unc.edu>
> 
> Before commit 18e2bf0edf4d ("eventpoll: Add epoll ioctl for
> epoll_params"), epoll files had no ioctl handler, so ioctl() on an epoll
> file descriptor failed with ENOTTY. That commit introduced the
> EPIOCSPARAMS and EPIOCGPARAMS commands, but ep_eventpoll_ioctl() returns
> -EINVAL for any other command, so since v6.9 every other ioctl() on an
> epoll file descriptor fails with EINVAL instead of ENOTTY.
> 
> Documentation/driver-api/ioctl.rst says that an ioctl handler must
> return -ENOTTY or -ENOIOCTLCMD for an unknown command, and that
> returning -EINVAL there is wrong. Returning -ENOIOCTLCMD was also the
> intent of the original series, whose changelog since v3 [1] says "when
> an unknown ioctl is received, -ENOIOCTLCMD is returned instead of
> -EINVAL as the ioctl documentation requires", and ep_eventpoll_bp_ioctl()
> does return -ENOIOCTLCMD for unknown commands. However,
> ep_eventpoll_ioctl() only passes EPIOCSPARAMS and EPIOCGPARAMS to it and
> handles all other commands in its own default case, which returns
> -EINVAL, so that path is never reached.
> 
> This is visible to userspace. For example, isatty(), ttyname() and
> tcgetattr() on an epoll file descriptor set errno to EINVAL, while they
> set ENOTTY for any other file descriptor that does not refer to a
> terminal, as they also did for epoll file descriptors before v6.9.
> 
> Return -ENOIOCTLCMD from the default case, which the VFS turns into
> -ENOTTY, and update the epoll_busy_poll selftest, which expected EINVAL
> for an unknown command.
> 
> [1] https://lore.kernel.org/r/20240125225704.12781-1-jdamato@fastly.com
> 
> Fixes: 18e2bf0edf4d ("eventpoll: Add epoll ioctl for epoll_params")
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
>  fs/eventpoll.c                                | 2 +-
>  tools/testing/selftests/net/epoll_busy_poll.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
