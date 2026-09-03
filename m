Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555433BFAC8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467568; cv=none; b=IBgQAtaI4tDfzNhQdKXNuEl1P//0Ivr3bSq5xUhFtQd4g14SSfSn5YJz3Kjmlor3o4GrBk2VleSSss3xvpe8zV0RuvK7QhHUOf5naGKZx1dYoc154awf5z3u7LHz4BT2pnT7YmXD1xGcdm/9jHhL9QhjbZSYn/+M+49Bnd94K/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467568; c=relaxed/simple;
	bh=IsWt4XOkAHQ9rW34uIss+tMCmJKr0RG3LWZEe/16FWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJCpyjcdjh7Lfa9XApsTe1LHgQdkVNc9Wl9xks0tv0BMwT6DyT11Sz369/NTkJHMl3PXbwf7YxWjla0lvVv6Le3HFQ75o1A+J9YJ+UOOP6QrDiO2eootQ3aWcW4saJ713iQJ1RImmmnA9Ts2Pj/lhwgpy2HNyuc6PsPNHxbP9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=H/Q81zSN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="H/Q81zSN"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84864086bfeso235277b3a.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788467553; x=1789072353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hw68qJNNQgPl5BfjIrFiMNlvcoO9q+fAliZobIeqAxk=;
        b=H/Q81zSNOYm0dmftv4qecfUh6zO9PyfOgJ9UqAe+ZB7/QEb9kYQ9cKxIQue6z7M5vG
         KEgptMCmiX5gQIUc0uFsEaNHdjcf6/y1KHuAE8tUFXd7ejJn7og60kOEAKOWCb7als1q
         f2E+/RJkXJp7isIM0hLY8jOpvuvHvI4n907B3y76WgwaK+KPc/9j3eO7tQw/Qe6HXwH6
         Q3DMS2y1ZruC1T5QQU1tVOK0jOAXC5XpsRdteiktZVza/uaqi7jviJITKktez4v1BKvz
         8mq1LPxocWorsfslQd1OxiaZMGKsh8dlgL+e1f6rMVKe6P3Rz3r95JLcFtnjJ+emBDA1
         lyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467553; x=1789072353;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hw68qJNNQgPl5BfjIrFiMNlvcoO9q+fAliZobIeqAxk=;
        b=XobCBbdM+xI5nNofbMfZNQFZ8YsaP36FUp87PSA8Ex+bo6TzS1W3Mj1qO9aXO6QSB9
         xe769D0jAV4uvxF3QOjGHvwvg+IKWFLVCd5NzmgGtmAf6/D96iRZTioNINDuusX1j7zD
         miYpve0GsvWvLSyyxP53gf9oRTdXvzYlc6Vqn2DcpMB5UoWIzrdRZlp3lP1F948oXW5J
         qEpmk+RZzmgB4GZaW/Ghkv+qpYZ6Qswtmw9PYpCfrhhx/lDvnVk7D/FncA3SsfdFLh62
         OcYJEEMdKoub5mBlhe1apxjqkOFxkj+AC/caE2QXIwXpYKo4VXWn3+KJ82W6Xn0TIbo5
         Burw==
X-Forwarded-Encrypted: i=1; AKwUvBwEJnNNzBlj9WmCOoZAiKRoZnR1VKhVznNYbK8QOPdvbvWdCsxtFv4aekLWKgVXm/5rwxdlV1k=@vger.kernel.org
X-Gm-Message-State: AFuF++kTmQPB04C3Nxl0ReF1HXCiH7oJvk//R8/XKtAfTBjEjppGGzMX
	49a4faSm5xa2/NwAQ29fjDrTolOaNgKnVbxaSpIe9P2JMUddOKOIP03SDS+D3IzTHnk=
X-Gm-Gg: AYBFou3Do6I65Zv8EJLu67rYB1i1PeSgKvK4KZHKTe2YdXy3IAZJJGJr3rVbztvZJeD
	9NI8iKzJZ4iCBH307NFUvEI2JTvxhZNh1Opz5QB8a7vcb1i6SIU0DHMPBZSkeJ4BLSAunnRDlLd
	K2Wbp6eSXfgK6chjXQ7yKLi5R+/8T85eyILcT/W/Ovpnf9WEFYP9Y9z77otIJp/M8r5jkZD3dVw
	2lxX1Jo/8qBsxTVeaF+0OcSkK36M+JJ0k+Iv0asWaXTRqCM3+ODSPgARFzeKChGsYq6JOJ9DIxn
	cBlQr3MEFYyhZrulJBYW1gvt+6OJCFl9jpRLqszgr0K3Nd+tmObaauwKizNBIS9CBrnkzts7+tH
	UQsac34R7s90B6G9sQXWWYp4e3xXhWrtUbHiW+rbGPZDJ44RlPb3E9gIPxrp7xMYRjnddkija4a
	faWrAAeupJxl0LrVV+vqAt2DY30mZWNQ+YzhZwvxsMwg==
X-Received: by 2002:a05:6a00:22ca:b0:857:726d:2e9d with SMTP id d2e1a72fcca58-8616b966f55mr1774968b3a.26.1788467552686;
        Thu, 03 Sep 2026 13:32:32 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-861520404f7sm356356b3a.16.2026.09.03.13.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:32:32 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:32:31 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	andrew@lunn.ch, olteanv@gmail.com, leitao@debian.org,
	yinjun.zhang@corigine.com, louis.peens@corigine.com,
	oss-drivers@corigine.com
Subject: Re: [PATCH net 3/5] eth: nfp: drop the replaced rule from the list
 when reprogramming fails
Message-ID: <apnZX0ITjgH6R8M4@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	andrew@lunn.ch, olteanv@gmail.com, leitao@debian.org,
	yinjun.zhang@corigine.com, louis.peens@corigine.com,
	oss-drivers@corigine.com
References: <20260903032611.3000029-1-kuba@kernel.org>
 <20260903032611.3000029-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903032611.3000029-4-kuba@kernel.org>

On Wed, Sep 02, 2026 at 08:26:09PM -0700, Jakub Kicinski wrote:
> nfp_net_fs_add() replaces an existing rule by deleting it from the
> hardware, decrementing nn->fs.count and programming the new one.  If
> nfp_net_fs_add_hw() fails the old entry stays on nn->fs.list - only the
> success path reaches list_replace() - so the list is one longer than
> nn->fs.count, and it advertises a rule whose hardware entry has already
> been torn down.
> 
> nn->fs.count is what ETHTOOL_GRXCLSRLCNT reports, so userspace then sizes
> its buffer one entry short of what the GRXCLSRLALL walk wants to write.
> That used to overwrite one u32 past the allocation; since the walk is
> bounded it is a permanent -EMSGSIZE instead, as nothing ever resyncs the
> counter.
> 
> Fixes: 9eb03bb1c035 ("nfp: add ethtool flow steering callbacks")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: leitao@debian.org
> CC: yinjun.zhang@corigine.com
> CC: louis.peens@corigine.com
> CC: oss-drivers@corigine.com
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <joe@dama.to>
