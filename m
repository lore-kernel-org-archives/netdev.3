Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15F4A2065
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104911; cv=none; b=aPq+Ss7B2GjXxho+AXlfnA8sTqxu/Fv8jboaGLCc9J7PC4bA2gSXxtb2zO2ClAJk6532I4K7BFjlHSgelxZBCq0DSq9cIn4MdvKXmHUjRQfAyZ5Zh3HOlUSQAhBAlx/CaQ0MYloVdm9lXPQZj9D63AlvS2FbS85/EtUJnZsX7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104911; c=relaxed/simple;
	bh=WglRJSnjlsAmST57yTlQNeatq1kNvTABDrq4X0RxpO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDQv3ypS5IweSva39UkUIwcQ+McBziMdKXq6dMsTDR3wuE4yX/R7rA2nQDkaPqd4g32HxqVYOf0jnLWlpEjfE1iqdx1HxBFiVAPsmwJCSe+qA+OLRkn/j0I76MiOxxwq1yLSiKS4poNvkaPwp3ANCCIocjOytN9t7rVm8t9AbMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tsb1R/JL; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tsb1R/JL"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso422115ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790104909; x=1790709709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RCe7TYl6tiq7DNGTOK5dXqNjh9GPuVqZPFdaHK8siew=;
        b=Tsb1R/JLPLz/zq0hWMpvUyzYyHhfjR2hdozF4S0zK+3b5AfNQgSz3mwV1p5NG634q+
         t77QMmv9zNIPLNvc9M9iLKkGRtBE9Q2h5KtEWMH8XuSi8pXYEmMw2z2zlB0VchOmS86g
         Tq6sK1+/WN0GakZJIBYcTdeMEt9w+ie/bmYRGZZW/mO7koIKE0Z7SvI18iL+S4Z7ftyU
         h0g7T+5QsKK6r7nri+wYeT3eFSEFPBQQbqCqcb7WrZ+RNz31uPXMEzeHXqBYOePBUvJ2
         1lR0xXHtcPDiEj3s93yO+K020O5sFSe4yVb3P6G6rHAMsna0bT+tnMcQkuaR4t9DjUek
         RVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790104909; x=1790709709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCe7TYl6tiq7DNGTOK5dXqNjh9GPuVqZPFdaHK8siew=;
        b=Az9ri6G9bAIpeFl4XFGf45V94IwFGO8up6Dnz2NHmjvAEmvbzQnrxCSrYiLRy9EgLd
         IDGH7ymg5Rblg+79b2ZmF2B9xj10m8+07BglXDVU1aMvZAR6PaUuUZaZ06FJjsG0bY4h
         G4CQYMrqEw8rjoDIhKpytzhtE6TPZBbhAJvqDF6GOwtsIO8NWEGIuRv9XvO86kdOuXhm
         14zyIsypM+8ajy+YtJlgnOy8un+GLEQbNGxGiyL8tqlUhVwaU3oQgr/9rl6WJLIpOdo+
         HkScnpUkKb66jqBB5SIblBIhRPUYwpZ/wI1nO/Q8MAbSe6sfkBxE7onDDwlq1f5FNd0r
         hiyg==
X-Forwarded-Encrypted: i=1; AKwUvBz/HAtWbezwFZ0PG39rsPk/UO/BPDasBHNaNt6l0Of38I7mfWVJjSN1V9Oqe16Qsm5OIu2EREo=@vger.kernel.org
X-Gm-Message-State: AFuF++kbKkdpJ153lkFsL/QsDmm5pvxUCKeFq0DPOugXCnaPHG/a7EUZ
	KNRQAEmq71tPVxGUf1iZsV8a1lumwu83rEIh6sC+RaC4NvZKrji1Fbcq
X-Gm-Gg: AYBFou36e8c3Rp7pb4H2IkjUSml8sMwQv94LZo13P1MvyDzGa4vb5bYH9OJsRPRK84a
	a9kOrTvsiDOJUPVIo7kt14FgXQ88xb8zNtbC6Qnzeh8R2AX+m7hZwG1atqkjKy74cW524Gk+hcg
	dYRkSxCbeOkIOAwA5Qmjb8HyLsaRUayji7NTGH9P13yPdoboEVSkyFfKq+L4pzXPQg9qLceg/bb
	dRUf2LbrR4KUpA45C/nmr5rR6RfyRhMJSqsjsCnaGd3MRoV3swnTDBcVSks6aHRIg4LN36sOj/g
	YmARZrE9poSrqjdAJrgYgNUjL402o2ixTbQsm4eQBYtbq5w+kulXSaFzCUy2MBRmk0GwNqiU+V2
	pA+tsKc3zUyPKmrv1GCMBgmE/g2EX3jSIydTtIQEC1bBPqpwyKpibPpR7gR0CUPxtwmVqY5QoGl
	4lgD8VawaEQP8B9Yki9muhsaSUiuLuzOJYja09VR7DIEe4UE5uU41I/dGSH8VHcU3G
X-Received: by 2002:a17:902:fdac:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2df69d33d29mr3282205ad.4.1790104909074;
        Tue, 22 Sep 2026 12:21:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a60c4a8sm339135ad.79.2026.09.22.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 12:21:48 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:21:45 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v2] net: opt loopback into instance locking
Message-ID: <arLSItTdl8TQTSCa@devvm7509.cco0.facebook.com>
References: <20260921190452.1467853-1-kuba@kernel.org>
 <arGd3auaaTerBqNb@devvm7509.cco0.facebook.com>
 <20260922111507.6fae8770@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922111507.6fae8770@kernel.org>

On 09/22, Jakub Kicinski wrote:
> On Mon, 21 Sep 2026 14:14:19 -0700 Stanislav Fomichev wrote:
> > On 09/21, Jakub Kicinski wrote:
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > > v2:
> > >  - move setting the request flag from gen_lo_setup() to loopback_setup()
> > >    to avoid splats on the blackhole dev which we don't care about  
> > 
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > 
> > (mostly because dummy is also ops locked, don't think loopback should
> > bring any problems)
> 
> Stan, the issue Matt reported in the BPF CI is a generic sw device +
> netdev lock issue. We are triggering it on lo because.. probability,
> but it reproduces with dummy + netkit already today.
> 
> Do you recall why we have separate classes for each device type?
> 
> Classes make the lock_set_cmp_fn() ineffective across different device
> types. Quick test removing the classes and sticking to just the cmp fn
> seems make lockdep happy, I'm running the ksft suite now. But maybe you
> can tell me if it's the right idea before it finishes..?

No, I don't think there is a reason we added both. It might have been
that we started with a class and then added cmp_fn on top. This whole
function is a 10+ years of whack-a-mole with lockdep :-( Agreed that
removing class (which prevents cmp_fn from working properly across
all instance locks) sounds sensible.
