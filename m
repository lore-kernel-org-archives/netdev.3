Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816A30D41E
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842157; cv=none; b=dBo9JEABkzFwIz6c5SKlx5BZwU7NoTKtasFK2L+R9/0aAzC3mdmJN32T/1sQ+Ic9NiVOka7GBLvL05Uea4UwjME4CS53Ae1JU9AKfTufVy3BxAI9pqh/ROoAJQ93V6KNrsBfFtu2TibW3Ngzb/3WBfmDkMgNMyTgvoSuzCIuee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842157; c=relaxed/simple;
	bh=WNLViiZXHLNZHhM81zRdXyy6SH8DdP+urVk+CBN6VHQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NmA6Al3Gaj1DzIdmgoYAH1xS7EXAohTia/m4EQXAJ/wNOSoa1pIMRwi2c89F9kS/j58aCbEBLP7nOci9dakcaHLsCactrgb6uCB9elT3soFVK7QQOcFLUwXk8VILnRKcfgCBiEZsSdCWkFJnRWX3V4L9etLNKzDNEYAhdCKXLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7btT0y8; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7btT0y8"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6688a2dceb8so819508d50.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784842155; x=1785446955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hkMbyPvxMStiYzt8Nao4TcAxn/yAX444Nxo2FT5xX1Y=;
        b=E7btT0y8iewlPnnlgT5AUdMYp0ZfNP4naAKA06hlN38f92twwKOXwQ/vIhQ5lZOyxK
         w2jVbaspSYOz6eOfIDyAzu90YIbJnCyfbHNwDia3M3QNZj3umHbHEDJTyKe60Jfqbtr9
         0ntfnoiVkK4nQxP1RCI7MT0bRBYIBqGlBtEHYo6WIqx2MDtuelwbHmbThtBW9Si33Uz9
         UcdVJKJod3b6w6hstsfNI99W4k4G354bqYPdTvRZoEHBx46iWAIhMdncLRJQeo7KX9G9
         Zx6mbwItuJwfpuIt1vsuBbnjbiZSA2d/7LS/EVE7rV8p9qtenAluBclYNPsPsFXZ+Au2
         n9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784842155; x=1785446955;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkMbyPvxMStiYzt8Nao4TcAxn/yAX444Nxo2FT5xX1Y=;
        b=rlroFRnLarLPN9UU2arBtbjPLYCi6tjjOGGz3Dy6wmuldJMmOPG7ZhCxzprF28YBFd
         dzcGbFGypW8ThievVSkvZoxT3QQk524EGpa1mBRD+zxuEt190tYNZj9YgBjfYAMwp9W6
         4h6YFjZWtmIk5AZiq+txE6OQAhb9kaV+PTSrdOg6hhb4zFkM641Rh+qOr4sL0kmiNAzS
         MxerjyTckOf7dFdujN5Uad/RfqP0yMFSoIWB5B1x7bo8fHyPldO5QX8m4nXplLGXdKGD
         LO3XHY1LPVi79hUMCsqVbGJ6WhwF4I+B5iYqzoUN46W8vFxGDzCnO8KrnUI/bCvgSNNG
         bgyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqEjUF0OVNdThFl07LdNvjFuQ3iK97K8oils6ZoGNRptoRmNTI49K1Y+yqeBDtKAL1DLWQWDPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyolvWFjJ1xBSe8jaWmKw2rQPDPrDivnRcU9fBZJ9aipv0gt7E9
	o86Ng71LYNy9AdIgLO/PvWOZzbW6rcPz0FpOkx8Tly8wL/9WIzDhIwF7/Ktn+Eqt
X-Gm-Gg: AR+sD128kavCnFRPgpTi1YbGPwVO+Lw7qhOugpk6EELsd02G6ESDEcj/9SJSskUIX7f
	l0/BUJWrFHb9WxTMD0PXtkU0I3rXX5jL46nfoahStRZdUP1qtEQY/YcI4rWNFIGMgQnpQZ8ojqz
	z0xX4zwOaRH0eXXRIhC3pptFBLWCVazsS6SpV4sL3i7TkrHPld3CnzJTsmYPf/TlECRAT+d3Uqg
	lJyEikOfiqubf1ETQga1VFuaUOc3tyayK5U4042/4ePrAf/3XPCAcpFcwtgxWluivO8N/plVgy6
	A6ci41p6D3KmfUhfw7LnHx9XaoQabXwvS3dsL1QYRdWEOB0dPWaGLxSQds0EkaSQW7bo49Rzndr
	lBl4xVj3YM5N3aMjOQkDM2WPCu50iczXdyL4U5HHpJkcODTjxGhmu3cHaomzxl4vs4dgflodLEF
	VMdEMPMrl50hFC+N/NsEVshjPQoJKdF0irF1JVnPYl++IXst+D4pBm4Bo=
X-Received: by 2002:a05:690e:428b:20b0:664:ae6a:ef2 with SMTP id 956f58d0204a3-668a4fbd253mr1085690d50.80.1784842154981;
        Thu, 23 Jul 2026 14:29:14 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6689071c1ffsm3841113d50.16.2026.07.23.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:29:14 -0700 (PDT)
Date: Thu, 23 Jul 2026 17:29:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew@lunn.ch, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.9e5ac85b024@gmail.com>
In-Reply-To: <9c0a0bb5-737b-41b7-828c-1953d885fb1c@gmail.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
 <20260722204454.3234605-2-willemdebruijn.kernel@gmail.com>
 <9c0a0bb5-737b-41b7-828c-1953d885fb1c@gmail.com>
Subject: Re: [PATCH net-next v2 1/7] net: ethtool: add hardware pacing offload
 support to rings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mohsin Bashir wrote:
> 
> 
> On 7/22/26 1:43 PM, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Add two ethtool rings operations:
> > 
> > - get pacing offload horizon: active and max
> > - set pacing offload horizon: active
> > 
> > Replace u64 max_pacing_offload_horizon with u32 active and max fields.
> > This occupies the same original 8 bytes. Reduce precision from nsec to
> > usec, which is sufficient.
> > 
> > Update the FQ scheduler to test against the active limit instead of
> > max. It is the administrator responsibility to set the active limit
> > before installing FQ.
> > 
> > Assisted-by: Gemini:gemini-3
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > 
> 
> If I understand it correctly, the horizon lives in dev and is read at Tx 
> time, so it shouldn't require touching ring config. But some drivers 
> reallocate rings unconditionally in set_ringparam. Can we highlight 
> somewhere (maybe in commit message) that a horizon-only change is meant 
> to be non-disruptive? I may be missing the underlying reason though.

What do you mean by underlying reason? 

> > @@ -281,6 +301,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
> >   		err_attr = tb[ETHTOOL_A_RINGS_TX];
> >   	else if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max)
> >   		err_attr = tb[ETHTOOL_A_RINGS_HDS_THRESH];
> > +	else if (kernel_ringparam.pacing_offload_horizon >
> > +		 kernel_ringparam.max_pacing_offload_horizon)
> > +		err_attr = tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON];
> >   	else
> >   		err_attr = NULL;
> >   	if (err_attr) {
> > @@ -302,6 +325,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
> >   
> >   	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
> >   					      &kernel_ringparam, info->extack);
> > +	if (!ret)
> > +		dev->pacing_offload_horizon = kernel_ringparam.pacing_offload_horizon;
> 
> Since a driver may be reading dev->pacing_offload_horizon on the hotpath 
> without a lock, should we use WRITE_ONCE() here? and have the driver use 
> READ_ONCE()?

Will fix in v3
