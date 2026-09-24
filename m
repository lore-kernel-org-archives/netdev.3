Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031448382E
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287156; cv=none; b=cqDSqS5TYpu1cCe1zl1thjyDJ2Dcg1fKe9+8Tb7cwAJfXLqQX6My8909NwQuKNFnueAxYfatlJeNmAqyS9uK5WsSdJih6NZcyBoY0Vr65odTiOD2BH3xi3wDePCn3/aqCEDB3RhiY3tRBX4sT94nISlsS02sEQHtN4rExbMlGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287156; c=relaxed/simple;
	bh=jdOnvM7WMqeUpU7l2mytGEp4oxIHLj8qtVUlj6NmVsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoJvdppHx7HVl69/Xm5Owy8sIcTfKw/oO5tG4bRUo9ZLHQ0t6jhS3YN300nKmMFzSNzH853pgv/SzbPVbBpxuY1S5SEUYtNY9P2q0/wYJ3yGWZmy0rYmk3mVawlDZ05CB2UXO4AqSlP/yVTlxJoFO3AyTZeeodNR8X9yVPUWXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=vPEiD9ry; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="vPEiD9ry"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bcdf41a3so12572a91.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790287154; x=1790891954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bbmWMvcZGPaQES2g8FHXYoBiPxQtaNORw16tr7nwuuw=;
        b=vPEiD9ryapYVAbcs8kdk/aarwnWZDJyTINZAS9v17BANQiOuYq1oHVyJBCxjEAkD7W
         OctHq3duc79f++pDhRki9fmBx8iaZqo7WTEO3/KRGGQo6+bxo/NBJz7x9mDaDx9yeSkm
         H+ok/Eqr1G1IAHpAGCOJjW0tBbSC6GZQ4faR6VgM1LIofN1MXaQ2GrHLhpxb84L3erPF
         MKZKqlLcvnbE9KVPFO5CWFiC3ortqSZHI1Hj3EY76mwz0EQDeYKZlJcdkfMa+9Tj7hHN
         d8re22ksBgofM9DHjvonMZM1H/MckT642VKR5gjzZ82kbtpL4sunMCl1BfUBlHuqr/JA
         83ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287154; x=1790891954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bbmWMvcZGPaQES2g8FHXYoBiPxQtaNORw16tr7nwuuw=;
        b=cJkq9wlpi5XRoygGu9iCQmESAeDXeFwY99bCP5K+IWkQ3IDAKBZKeVra64Galtmth0
         9Vn4ILPkjopn47OqKvjvcEj+M/xpbFpm9n+MGu1SlyLMqA9ssL+xvsbKDl28YPkvJ00i
         YFLNiKRJLiBs1uLtYRl8UL9sp+MSBtdbSC3aCqNJuNRE9KXVwkXTg6qOcvShfzqdFpVh
         E/i1A/lunebQyfFDK49Ad4hFeslxL9zKRyqWNyqNA8uaZ4Yzi3Vt3KPMbahAJFPGcWAP
         DRYHUU5WoIZaWBsYgTfHAE7JJqROnNfqwbHWgmQaWSjdi/SUSlDxKGBOvoPsjRHq0zmS
         lGTA==
X-Forwarded-Encrypted: i=1; AKwUvBz0HhHL6C0f1N14oJOVbzCCoP8oiQcVXxcBSG6isaPJ5ptmeFnHY4Tgc0A5DVkfbPEOstkky94=@vger.kernel.org
X-Gm-Message-State: AFuF++lJIc+JV8SXSOzdmE1FWsj1boerZ76EPDaWWPc6ORx32bZ/2AEe
	wwGMT/EnN5ERZszkVtKPpPuBxRg7cohckRlr/xVP+9X7PCAPXtOh9ItAb2b+P036O1Q=
X-Gm-Gg: AYBFou1ZQqu8ucjeTftbbUKuR0C2crSlaNBWgaGJAG0Ld7GmV+TZNuuT8eiTSc4QjMQ
	83gVRBIRZByHONgMdCk0RvsU/GEWPhvIysnQuON3DcbvxCciGv5sstWQJD91FFzHIuuMVbXACC0
	bSWFee235MXWyARqsRxALjSxLFZZB+YYbkMI9d06wFkRo1nsSlNrFIdQsRBpsHdmcZa0+ZfN+uX
	SXAfPDoNR2f6V2ZFfJWgoigbR9FCzEMY3oSkdFVxLbLYHmm4CZowSvhc6OwUTjoHUfUJ6GC5nd6
	7tFkN4/k3EVll6hkZNMK7hO8P+TbV2vHiWnC9TIgkv8k9+oqiTw7V1T7+TmqgJP+aiTCeFsYukh
	usS7VyqnmHf45lGeJhLChkYEiM3M48gvx5mJQ/Aw8L6qiJIiBfLj3OCBazCOVj6Mwyk5Wfl+G5Y
	CNXhF+KedLwFIZc3JuSC4+AJErz1HbGLS8gOfl2NoD9/bbzXvA/OAYqSh40AJeG/Uy3frVSDKeP
	cXjb/kV0yvFWFmNIszdUzo=
X-Received: by 2002:a17:90b:35c3:b0:3a0:bcc8:1546 with SMTP id 98e67ed59e1d1-3a0bcc815f2mr76894a91.64.1790287153608;
        Thu, 24 Sep 2026 14:59:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9481e17sm582065a91.8.2026.09.24.14.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:59:13 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:59:12 -0700
From: Joe Damato <joe@dama.to>
To: hengyul@cs.unc.edu
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jirislaby@kernel.org, sdf@fomichev.me, edumazet@google.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	horms@kernel.org, shuah@kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventpoll: return -ENOIOCTLCMD for unknown ioctl commands
Message-ID: <arWdMDek0iv0obDy@devvm20253.cco0.facebook.com>
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
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index e0c4bf88a838..adf30b720b13 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1264,7 +1264,7 @@ static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd,
>  		ret = ep_eventpoll_bp_ioctl(file, cmd, arg);
>  		break;
>  	default:
> -		ret = -EINVAL;
> +		ret = -ENOIOCTLCMD;
>  		break;
>  	}

I think based on the documentation this is probably right, but I am now
wondering why both ep_eventpoll_ioctl and ep_eventpoll_bp_ioctl need to
exist.

Maybe when I first implemented this I thought it made sense to factor
out the busy poll ioctls into their own function, but in retrospect maybe it's
cleaner to just collapse the ioctl function into a single one instead of
having two layers?

In other words, maybe:
  - delete ep_eventpoll_ioctl
  - add the is_file_epoll check to ep_eventpoll_bp_ioctl
  - rename ep_eventpoll_bp_ioctl to ep_eventpoll_ioctl
  - fix the test (as you did in this version of the patch)

Would result in a cleaner fewer helpers / cleaner code ?
