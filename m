Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB02C21DF
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965829; cv=none; b=lSjcGkrZdek9X9wYlrGg4PTa9o3LiK1xYwO4H0P9RiGplM93Ck7YBH0G8EMhYIv1fgMlDrqYrrGSY2o7rY/0UcYcgIHVWyUN+MYec36O18+jxYevSG05TkXJnhYtfmaTu0lId+Y+Yf6tSTKQJTHRozh8bElD3SNzEu+hwhOlim0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965829; c=relaxed/simple;
	bh=a9DGLc0NeseciOnf2q1+7VtYJ5eoK8nd7Li3zgPWEig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnBk3ETZujhw366czLUDw/+l94VrZq1ZDvYQjCZ3+6qHk+xnK+RUFll1InHy0RqwxTe3FMjZvBa5G5/kzq0sn5LA7yGpTW+9FbtNM9uwBXkoUnM0pHn/c7a4+FZtNkhhWoaa9Fno/mFUR0aUHYcrRdhGmM/EsIOWX2yciAlmy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+LJYA0g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvKqvoRW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+LJYA0g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvKqvoRW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790965824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yHtc6IteGKWmX+tDrjk0Un6qMA2HmnuYgSyxy+UifAQ=;
	b=D+LJYA0g8p1rpMgj7Qys76vGAnySS0tekcIJdOL+VtC/MELQHX5M3eX5WlkU+GWf0kidN/
	Hpelu+jp8hxw8f7XML+LxEzROcM/CdJf/H++7WnBbkYqN9S0Q64rOcA68b2EsrdK2voUcr
	xZqnPVG9r0Vka/c21m6FG1mVLohFu10=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-Y5AwPV9FOnKsB7FP_qF98g-1; Fri, 02 Oct 2026 14:30:23 -0400
X-MC-Unique: Y5AwPV9FOnKsB7FP_qF98g-1
X-Mimecast-MFC-AGG-ID: Y5AwPV9FOnKsB7FP_qF98g_1790965822
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb6391e89so485961485a.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 11:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790965822; x=1791570622; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yHtc6IteGKWmX+tDrjk0Un6qMA2HmnuYgSyxy+UifAQ=;
        b=DvKqvoRWavb0KE3lUK4oNYTidIypYumy51xdduyxpCFM3cpmNFS6qJrr8KeyRiwOGs
         PJHDq1nIw9z57+th96lyYdET///coX2Nz1wBZ0V/Oq+aX2d5HvkVokUr8oNGq1+DJ4qJ
         YL4VsMbK7ixrK8F4MCDzp11e0+0iu4eet+dLGzKUCfJpVnll9SUaim9LfOJwXTvrfzgQ
         8kRAc+s5lKAswvSUI9VN382A5ep95O8+qZTfnOLlImpoS36tOCUdUNuKqEPue8cqjyJi
         qSMgsqFJTONjxti9H+FP5x3CJAImzai/0TeVmOUYhtXQKd4JNqEAMZ7ptPqDJkzXH5nL
         9FaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965822; x=1791570622;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHtc6IteGKWmX+tDrjk0Un6qMA2HmnuYgSyxy+UifAQ=;
        b=ZYyH0jxkT6auCb7At8KZpf6aSZgm1v/ikwRfGjxsPr8OW2rcy01g4MhB7EDi1hIIJ3
         s87SRH3SePPKy2Z8/tZd7d8iRnWndDyxx29timKZJ2/shllNLa2Xx3lPd7guavaMxRpz
         l1FFwmOMbqH4tWHsFwUgR+13lzZEsRv87IGrFGhMbB1gMUpExkvmkBLs0QjWFSIDTJlr
         mfmh6wxdoTEK004s2GN6L1fEZRYI63C2RqeB+AlWr2lYEsqIvk9b4Ft8HCQ247eSklxB
         oLF0ThCzHPpTDZNVQf8TB1vcioJzoxga9ZuuZjrHQUvduLEydu1JefLd45+ejdgj7g8S
         AwkA==
X-Forwarded-Encrypted: i=1; AKwUvBws5G2iYdxr6SbxyXoyOZXheyHAl1RVDYNPQE5IyUGMeLbhXryghhzlrT4UZ39CTVH+DOlar9Q=@vger.kernel.org
X-Gm-Message-State: AFuF++ls6BfD0dqj2mREuvR5NqpAJva9QySMLrdZW7QgvFo4BTyYZT1s
	XThrZ9yt7s24+6upkbXVC8O43ESukn6uu5JQmZQ6ZV3qCJNQEwGhqbOsY6umDy5v0hIFH8QSjxO
	NFfAdSy0H4o9e85vGCgWQOPQWEIFv27B2YgYTFbPkYbwigLDFGUs7lvH9hw==
X-Gm-Gg: AYBFou3eJRPxaC3PrDkbsJhWdyh0IF9Ik1ElfTzIl7McoJGciR/PPvwNeUkZ6/Jx8mM
	e1PA/QQN/kZix62DKOeqCaxYbPrH1KJ+1KCXm819KQ1TBaCy3DwOEE9jabC7M3fyLlEou15ir8M
	AnyzNVkfct74VvVp1KExX3MfdWfde+y7UWvvG17HUQFVp6KCWKmtg4ySzx9XnmtuUBMgPiDgGQ0
	LEvCzjzPRUtIHx1aoxM/fcZr6F4LlwNCLo/QNH/aFgAgo6pnmW29VUJeUAIFgikMXuRhhP+2hZj
	W/OYJhoVIC7wbr+y5AyK14xh0rMHzFalbvs1Qv8KPmcbn9Gp/cYz9dgOpUucpSWRSlRxaV0REA=
	=
X-Received: by 2002:a05:620a:31a3:b0:930:9091:f0ce with SMTP id af79cd13be357-93cf16b3b8bmr674468285a.22.1790965821125;
        Fri, 02 Oct 2026 11:30:21 -0700 (PDT)
X-Received: by 2002:a05:620a:31a3:b0:930:9091:f0ce with SMTP id af79cd13be357-93cf16b3b8bmr674421085a.22.1790965817184;
        Fri, 02 Oct 2026 11:30:17 -0700 (PDT)
Received: from redhat.com ([2600:382:7723:4eba:66b1:961f:1a2d:af55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca0395dbsm285252285a.5.2026.10.02.11.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:30:15 -0700 (PDT)
Date: Fri, 2 Oct 2026 14:30:12 -0400
From: Brian Masney <bmasney@redhat.com>
To: Conor Dooley <conor@kernel.org>
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>, Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v5 00/23] Add basic clocks and resets for JHB100 SoC
Message-ID: <ar_4NBLHrq2W7_vc@redhat.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930-grafting-undertake-ff3e01060284@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-grafting-undertake-ff3e01060284@spud>
User-Agent: Mutt/2.4.2 (2026-08-30)

Hi Conor,

On Wed, Sep 30, 2026 at 11:43:22PM +0100, Conor Dooley wrote:
> FYI clock folks,
> 
> On Wed, Sep 30, 2026 at 05:42:54AM -0700, Changhuang Liang wrote:
> > The JHB100 SoC includes CRG (Clock and Reset Generator) for multiple
> > subsystems:
> > 
> > The JHB100 SoC is divided into multiple subsystems, and basically
> > each subsystem includes a CRG(Clock and Reset Generator):
> >  - sys0crg/sys1crg/sys2crg/
> >  - per0crg/per1crg/per2crg/per3crg/
> >  - voutcrg
> >  - vcecrg
> >  - gpu0crg/gpu1crg
> >  - cpucrg
> >  - usbcrg
> >  - host0crg/host1crg
> >  - pcierpcrg
> >  - husb0crg/husb1crg
> >  - husbcmncrg
> >  - husbd0crg/husbd1crg
> >  - npucrg
> > 
> > In the current series, we will only add the following CRG:
> >  - sys0crg/sys1crg/sys2crg/
> >  - per0crg/per1crg/per2crg/per3crg/
> > 
> > The remaining CRG will be implemented in future series.
> > 
> > This series depends on the series:
> > https://lore.kernel.org/all/20260806122553.182449-1-changhuang.liang@starfivetech.com/
> > and it has been tested on the StarFive JHB100 EVB-1.
> 
> If this revision of the series is acceptable, I'd (although I'm not a
> listed driver maintainer) like to send you a PR as I've done in the past
> for Starfive stuff so that I can get some of these binding patches that
> contain headers as part of a shared tag to be able to unblock a bunch of
> the soc tree stuff. With conferences next week I understand that, with it
> being -rc5, it's probably this doesn't make v7.4 but I figured it was
> worth getting my intentions out there!

I am going through this series now, and I have a few minor changes to
the clk drivers themselves.

Feel free to send a pull for the bindings and headers though.

Brian

