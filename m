Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB72E739D
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898236; cv=none; b=eI3GCVJXEgDMHrQo+LZrxMY/eVTDVE6f9QrgOzwBnu3h9rE9i1f/emEoFwDZwyX2se810vC2uzw9bFRxe54DCIBSn2X02c/9Y9aHs25DOD4QA2D5hoMCgNRW7IEiJ35yWzFNrBoGkI4i0s0nBoKrFLsOWZwMwcqvM7JBjXr6zQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898236; c=relaxed/simple;
	bh=BFXO9SAOEEJG0KDbQp94TzNEGH+p9W4HWbKQichJx6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awMu23N6TmaRIQyTe9IL0erdqYHps6nmzXh406PFKzLPrVi3wEP8GGVhHGX5y7mbbyuqpRB5uNq9UvAOaaF69+J8V9+EIer/Zq2bhsPpm5ksXCUb1t9+Hi30SaMi8nuxhnUamMAnSWpVxQp3Cykvj26swk8uJprEnCi2cgLH+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQR0u/l3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQR0u/l3"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso387233a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785898234; x=1786503034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BFXO9SAOEEJG0KDbQp94TzNEGH+p9W4HWbKQichJx6k=;
        b=rQR0u/l3XCY8DoT+B6HM9aPn17DbQnTnfHWoN3pU6FNaxVveOAAGVU1teKryAFqJSg
         M444UpkqRwFzy4f+y7+K3IPamtKwIsU7hS/YEo6UCUUXGjXcgtGMVGKfjROsO99CAVf1
         iQb9qeZR0V6JY4nWrRWx9+AOBUQU5VWA0mO0zixRlXz6r+qx+HOlZ+C40hQp1CZC4N+M
         pkAGs++bYGBus+8jxT3/gil79AX/OVZQ4Fjq0G7Xx7aflD2CJYAfKubM1cfzPyavRACs
         iR7OQg0dl/zaK4WOhYF+IDpJLwLExyqkc3u9k6lvl62yXNJyH1DhKSs+I7OB5gnAGRkl
         SsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785898234; x=1786503034;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFXO9SAOEEJG0KDbQp94TzNEGH+p9W4HWbKQichJx6k=;
        b=DLJXWpkgAGRaHhK3FqGJ4nLyzRY4D/e8diIdscq6JkCtJBTylhT+YlUxIYCd9MDJRq
         nwxyX9ZuzlsMa/G65eyju5NcVGmcWHcByamJDVtbxJ9IHI/oDHh5L3/6FLjCQAe2cdBe
         MGgkJVzHUGBmbhTYG4RBEBhD8NYsyzDzojK1+heB/iQDGmxwPvRbZRjP7K5Fvnvh5la6
         6xfVSZ2TXh+bPmx4djiZofowF+EdprTvoZzefvc/1kGhdQh+F0uFtE2+FNBx8m/MO4+E
         LWkgMTQ+8qJJFIan8ORPrBlv7SFVZ5XlQotJaKkdcFyKi2reiZMOex7vagCXMwxk+SG3
         6JXg==
X-Gm-Message-State: AOJu0Yw1hQ9738TyDngtWQmzLA/YsLx5sm8S3qOrJF239RlrOf/wJeFJ
	KiVcnJanDryCXl3uTVATz7wihZbsbIT/h175p6KK9emPUO55dtcyK5YC+rByIpsl
X-Gm-Gg: AR+sD12XHExwmPMpyR7R3yWLFFiIp8gaa656+pQyLmzz0AnNVe0N0WoDD+9aZ/8B8og
	HbJqbtF4LCFI5yXKIXz334lBCb358WO3sWblxqlzCHajfVMMs3UWrwiO/sxrIC5TcFH1qhb0fcC
	k8XkJ+sMpuGVGj0DCr5NpabJS9DIBSuU923oQ5BC0q4Yzst4tP/UmS7jmrx8EM8eM8nKZ14l+i+
	xgcJnnDZCMIYBPqgPDaWoF9QTDBmqK/N79sLkeo09QCSBlYlL0tol3eh+zwnpJEMolPSy2fNyhm
	I3g1JoR6UFQ2VX8mXXHo8x4MV3IDQO0F9vPHzSi5szZZ2UDepFAPEJlqypcEo5GfA/sQcLHE0E8
	mvd0+2ssgj/JsDOS+VB2MKyTAlwwfCCSvNJPRjeVpHqwE2D/lZswFQk4xyD48fxsOKzQWQoE1X9
	CMYJL5OgYq9Nx+kFtyh45vlfgg7tcl4HvP3616cTVgHaKeDSwN0xdUQNdr
X-Received: by 2002:a17:90b:4a8b:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-3903c5d317fmr2451810a91.15.1785898233993;
        Tue, 04 Aug 2026 19:50:33 -0700 (PDT)
Received: from fedora ([203.175.12.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febfdae85sm2858413a91.3.2026.08.04.19.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:50:33 -0700 (PDT)
Date: Wed, 5 Aug 2026 10:50:25 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de, 
	fmancera@suse.de, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com, 
	kexinsun@smail.nju.edu.cn, ssrane_b23@ee.vjti.ac.in, michael.bommarito@gmail.com, 
	2022090917019@std.uestc.edu.cn, yury.norov@gmail.com, jvaclav@redhat.com, maoyixie.tju@gmail.com
Subject: Re: [RFC net-next 0/2] hsr: Use only one MAC address per node
Message-ID: <anKiHmSnUjBOw1f2@fedora>
References: <cover.1784024900.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1784024900.git.fmaurer@redhat.com>

Hi Felix,
On 14.07.2026 12:52, Felix Maurer wrote:
>To prevent misconfiguration and simplify the hsr code, this patchset
>removes the notion of two different MAC addresses for one node in the
>network entirely. The first patch sets equal addresses on both ports so
>that we are not running in invalid configurations. I also updates the
>selftest to not use/expect different addresses on the two ports. The
>second patch removes MAC address B from the node table and thereby
>eliminates a lot of code, including the node merging.
>
>I am posting as an RFC for now mostly for two reasons: First, I want to
>make sure it's generally accepted to have only a single MAC address per
>node and give everyone the chance to speak up against this.
>
>Second, I adapted the PRP address handling to HSR as well, i.e., to copy
>the address from port A to port B and master, mostly because it is low
>effort. I am not sure though if this is the best approach now that we

+1 for this behavior. Bonding also use this one as default behavior.

Thanks
Hangbin
