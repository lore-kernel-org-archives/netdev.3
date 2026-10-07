Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F435838E
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 05:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350653; cv=none; b=GCy0hxPB/cXgpBgEn2tJlBbnSn2Jh4pq4x3/UekOTqKY8/ZCbEjrM3tr0k2tfgZvogx3pakKWX3fcUX8Uxi6ZjhMaPc/5vGtjWMU9y7iETKlKlXXb588OGFfGlfpVBX8rfNUnXl3dIWwNAHTTk/7VeVsO24999uKShmJUNzBAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350653; c=relaxed/simple;
	bh=yBxhH1X8FwRDNynk9/Cf8yfzteLxe/rZbDYYuZW3AA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uyvc84z43BWvOqVujspQjJu9STjLAqC67+ZjrFeYgEcEzksppg2UBULFLwzr3oxVGp3ltQtWwGuKm9Jf0jz1IEqm0YIwvVx2xU+W1vuETZGjjd3ls8dn+ucPCgT3Rvdg8txFWC05+X7o4ccIhLKRj6US9vv3M1F63uG2Lbuy5ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=exrT79PJ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="exrT79PJ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8253bc5a613so2530279a34.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 22:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791350651; x=1791955451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nSsHXzg/zAiuljQrmabDi2S1XxlM4/g5SvdsTjxLDkA=;
        b=exrT79PJafB4ahJeTPpuAHZZPWNNrBccMsjPXvqBmCyjSxT86AQCaxLfnsQ9QJWbcr
         F0RocTo+5uOm9mFaTlMn4SG1VEY4kFPDZrvcd/7x8MsTopkg+rAytffZPvfJUQ7iSXsR
         wC1XRt5EJ5t8qU5q3Vdi2qgSEVbACLGYqYmzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791350651; x=1791955451;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nSsHXzg/zAiuljQrmabDi2S1XxlM4/g5SvdsTjxLDkA=;
        b=TVR4f7HJD/mI4zSK6HKxl/jLtG1Y1rLgnQn0crO9qMISA3R9p7XSaqAVCZhTO+zGLW
         BUKxHpzSRF4bKga3pDqLufDaImuuxPLY4pfy3h1Rgr7FAWUme8e7C/j++qa3NRK8Zu31
         rIZHjW+Dq91wLK+95MkK1eYRPLrZjTpO473rHPy9nPDhgreU/PyJZ7Zgp8U0dC6IIEcz
         JZYf9kYgRbAlexGYY7tSUT8PLfRmzjFaEuED2g/9+WnTotRrsaGDwohHnFQrGtp+aop0
         nNKvjE4nhMo1TNhb8WhbQVOpMvef0wmB+xfH6rwQCa1XXwnGfeLk4HIOpZekdhqv7u+a
         yxxw==
X-Gm-Message-State: AFuF++m88P3kEVfv0Jpz7CqBh3wa6K/RydTv/yyYtrrxkJ/rNv7g8/fv
	jqZX85Zq4YGFYUiEYnuAkdcqkh3gNU0TE8U7WE9WSZsa1A86bvsEiWEwkQSzWm7ASYg=
X-Gm-Gg: AYBFou2D35kNhDpvePjMVorgAat5CTcIPp5tnGGJcTNbXvbxn3hYDbRT1QgqaBFgVXs
	3jjl9qWWRxvwVMz1SFN7iMzg/9854sMTAFYjBIby0roRihWw8wOTRdOEOToCpi+p2QMw98gk72e
	EYvKl781qR4In98BzbbsnHKXAd56Ff8AttA2CMhjfUnceAKLdU6M0LF92BvdRqRDZ01hbDiUOj4
	hbvvh1b+t7SgiG1ti+Dr9YAF+bvTAfKMnO69RdSuIdu/z1MZajKlz/pCfGon4dKMToFtw4zyYHa
	fVP7bdcmpEOt6iusXeXkr9OPs3Vc2ytkfb3+gyu2fs2Rdb0L5eR8iQnmUD69fSPDsQV/hO015QC
	RrvPEQm94HVxEm0sA3NTJtPqccJh72LBZlkXR6ppt0tSJUSq7SDEr7LAVpda1VvIgbBIGdlJo9H
	4G5zuYMjh2JP4hStkVAv6HSb1RiRSoySUZdLTWPeMbf410maqi3XRlTmzuQVNMolfpyBwdiLb6x
	gKUa6Kx43DDi1HrtkLV4OhoXVkLPd8CHVhs2sOgDRZGZy7NTk+I64DhmpSi0gBZ
X-Received: by 2002:a05:6830:2302:b0:81a:9522:f007 with SMTP id 46e09a7af769-82ace793d07mr2045456a34.5.1791350651470;
        Tue, 06 Oct 2026 22:24:11 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82ad9ef4a8esm1882490a34.1.2026.10.06.22.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 22:24:11 -0700 (PDT)
Date: Tue, 6 Oct 2026 22:24:07 -0700
From: Kyle Zeng <kylebot@openai.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, outbounddisclosures@openai.com
Subject: Re: [PATCH net] netlink: avoid hashing the network namespace pointer
Message-ID: <asXXd4Xb8yCZFIqy@com-75606>
References: <20261006224149.50498-1-kylebot@openai.com>
 <179132696042.2231598.3001993287250723765@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179132696042.2231598.3001993287250723765@kernel.org>

On Tue, Oct 06, 2026 at 10:49:20PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I have a PoC for this issue and the symptom is that it can lead to
information leak (kernel text pointer).

Best,
Kyle
