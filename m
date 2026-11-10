Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352875;
	b=cgKruKyloOO8q2MGYylXwmMkr8Fwgf6SZ+d72KbIribh4G5P4g5zpuUgxJCcmoUk2H74
	 CfDtIFxr3J249ZkRAa0QXlsMknhx9MbvztNjB2UoD97CymDuMiRZ91fdxzRww2qMajVDg
	 DUIl9OPaod9BWQ3qKdMHWgpIGpJ5Do+cWaT1YjJYXU1NEP/vUsMDmAYjYY1Itus0up1eY
	 uIDtg01VtrG4Xl46GF23UpuOdqVeWaroBpDhlRGE8vDKKO36UupHn15lrA9ajnduF4wWf
	 tGf8GzbaU7Rz15S/fccYBXmtjau45NViKONcp7ufZ/WNZw53/+bh+WMTa+ToyPwNA+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dmjEUol2qh+/Kf+BAZYRdZvYZ50LeNOIlSk9Quu1FKU=;
	b=LUS7kLJn3ohc2qFDekpXaHMeImEmIez6te5WoYmPjbbfis93+eoKZPvLDNmmT7LEajjp
	 SKl2avw2FvVpUfO73qhX8yJjHYGBkvSLKn2cdiULPZUwAi+hF6tGDEXamFv1pEND3Zltv
	 MKLoAsK+rQZoe4hAgrjNXG5dNn02JqgCCNwuKxHgiijnUkWy8RDU6S/f+pRgr55XtojaO
	 jcbHBHXK6aacRxzSsGBg47lrWQFTms3H/laVfQPuuD4pIi1dQzjSYZADjUxurvMgIVHlw
	 zH+6xtDcn6rhSlfCF+BoCiU3DK5ihvdc/RM7mabyr9qOoM2+dGXB2Xh68wRSNVVtIKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ihJmqArm;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC71606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAC71606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ihJmqArm
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9eb579c0eso14781735ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794352874; x=1794957674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dmjEUol2qh+/Kf+BAZYRdZvYZ50LeNOIlSk9Quu1FKU=;
        b=ihJmqArmhhakMFCEzwTIjw/CEHNtN7ibidz+IQW+Zs6SdfWUceC9QePZqpzX8L6jgI
         q2fIUwMTkq9BjGo/g9JF7U0ThMCM4KSMaC+JpiOlUv8xUsZnjMgyTXUMtYwbAZ6GOwZP
         hUPGyQ7Fuay3QW4X1y2qW9MDLjghavNwl0FKVz5+vuL+Rkkq+JcOq+R5TR61/sl9gCR7
         GhH7y4cyRDFqe5NpyFy5R0RlW2hFyjYtFJJkRTorvcoNMpVnunc8C9I2/ACKrMgVPFyG
         EpTYeQsDXpReLgbY3r5W2XN0RozHUsGlvt/9RWYbBBMQ06wNaUSY46JplreNk+b9NjTT
         w5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352874; x=1794957674;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dmjEUol2qh+/Kf+BAZYRdZvYZ50LeNOIlSk9Quu1FKU=;
        b=djiTSwAO3ipbJO/IHnlPYON13KSz6jmCquR+ttfGNmDfDqp8Fu8Ydgep8lgp8Phhd+
         FKnkcsZ9WfeM7p0U/qI498VBjaF7rLYpIbSz4hdVyDDxVvVuiTnrUIdydp4ffC8saPRt
         d/333dCOjslCODtM8x7llmskFqqv+qCUaCNJF2dysmmjG73hVSMqIF8qqDnt3NBKFYhq
         k5YJL3lNOLhWHEhq/cKzf3+qBOP7q6jXc4S7E5zISaJ6ZVjBZO4ZTu79FALnqQIcLG2u
         hMbP7on+cUY/ZFYIXyUM6zCjU0iRamlb/8SHuRtX5to/DYIgGAEltwfXwAuPdn1vbQGE
         M92A==
X-Gm-Message-State: APuU4Z/aPTRbqKfsi9Ba8cuKZJz4O9LyiLdx39NMES4mlEdxd+vIKyuK
	S4rUav11WMy3A/NuwbLz1ufYifHCTZ52Mi+517/nMs+tPoxH1C9t0Rn4/8bxcg+bnAc=
X-Gm-Gg: AYBFou0vOr6G3Eg7fVbQrwwpDDcjnNsbRUMU2p4TH2R/WKtFOssdhgMfR0loysbtKe6
	8mGEibDjuj27srgN0VkBi07bcZTxVNKmO7W5ktt+W3qlui4c7JZplA9DbcrgH9X9hC6FiKKOcsy
	/4ktJ9eiUFbOVkht9kmG+bnL6wvwaqdL5tIwZyQKCCW4M+YF59hnuSmSOVbbzqNiCEfFtgiAh2j
	UuTTN1dBpEpSkHZ9bvRswb6TO77aM6fnLuJHt4JwKyYts+r3Wx5MzKOpY732rrYJvwJbaxzA2LM
	WdTGNt3jm98p2AuSdCxsIxMGOmME6ge0Sps3naF05SIuPlXastiYvZUB75T8rdJBDkUQn9ksqOe
	p/uXmjGmqZf8gesTpyF+z9bvJHuS0PAdo8L0PwJ3xeU0BAa3FY4ZHgFGWuCEX3F5Zd5mhRp/yzM
	+zbNT1uoDoLYJWHeKTHQ1hBNyoD8XFXlRSugvNkXEYPRvtSnzAYpW3TvsYao18ldO84z9P1TGSK
	fHxFL2wdO9y954dBDmpcC4QGpDnNBdp0Ae5LKUVxcxhF3UbXdJpdim2hyY9LBQWvBIXgBWKAy4r
	J2vPBXp5uhqhH6qSnr+SbopYMWGCtdY24ote9W4tD2i84+2G33eP+cXX1N446G2u
X-Received: by 2002:a17:903:2f43:b0:2e2:cb65:a719 with SMTP id d9443c01a7336-2edd77694cbmr7109555ad.15.1794352874082;
        Tue, 10 Nov 2026 15:21:14 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d7a26e5sm1257643a12.18.2026.11.10.15.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:21:13 -0800 (PST)
Date: Tue, 10 Nov 2026 15:21:12 -0800
From: Joe Damato <joe@dama.to>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>, linux-rdma@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/5] mlx4: cleanup and doorbell fix
Message-ID: <avOm6IDyQokvMnc3@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev-bot+sinfo@kernel.org,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>, linux-rdma@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
References: <20261110231304.1859217-1-joe@dama.to>
 <179435264086.488859.12644173782807656441@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179435264086.488859.12644173782807656441@kernel.org>

On Tue, Nov 10, 2026 at 11:17:20PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I ran this code as part of a larger series that also includes SW USO support
on an mlx4 machine.

The only fix in this series is the deferred doorbell flush (patch 5), but I
need the other code (patches 1-4) for SW USO support I plan to submit next if
this series is applied.

Since patch 5 fixes an issue I've never actually seen, I am sending this
series to net-next without a fixes tag.
