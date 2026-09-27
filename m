Received: from mail-qv2-f0.google.com (mail-qv2-f0.google.com [74.125.230.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9783590AE
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790537741; cv=pass; b=ck8bZmiGTVtl3egIvyZLxRDE6UXZYrs4sfK13wrgj8dY2UmfTQMj7z9hsfyuu3Twtk2NpgTWbaPomCCgyHFBxg7qPWGQvgHLTzKm4uKzHRZjGZpV+YEnlG34rNwfKpbvHfXjCOyEDZkhlwvyk5hTsswX6CbF8ja+a/bD66npGx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790537741; c=relaxed/simple;
	bh=mrOC+K0YOCPbrTmQM9IR744v9j1UjcD4tQT9sNiYbXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLi1chzRCS82JMG1RS91M36PYnqRNgyj7YhhsQd6sIlCYBUpLsZnBUZYKY1lIZnm4LQUVtFjKCSTuBmOOG0T/3WipCU/BDpFd6nXWvYoKICixYfNOZ9SPP4TrwLYFaRVLF04L9Gi+AZlafjsWYlFhOv/H7lC68AvH0PkxgPdZtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHwNrqCN; arc=pass smtp.client-ip=74.125.230.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHwNrqCN"
Received: by mail-qv2-f0.google.com with SMTP id 6a1803df08f44-910603aa531so10136846d6.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790537739; cv=none;
        d=google.com; s=arc-20260327;
        b=ByfqLXexeklDI8VkARHC+LKC0DiQ1ch8Ab3rMNmDAOpqaHExkIjBdQjHZx//PiJ/Xp
         KMu3evcsxAicHOsl/78Poctz1CGNq6IkXOdc3qyGpuXlqGUG8cHwVAYuJopsF9it+J4X
         f23F0OSdCHf4wzKeswfEbBxC58VTUk2QYBXD0QrImah+8WbyrfB03g3aklkfbKA1FlWM
         FOhXs29jnHIwyvzD+QUljrLocaON0bkuAnW83146EMaAWBZLPMHX1P4CQRxe03vjDMEa
         Jwv1IvSbQTKbSii/I0uAJEdv2Q6ehJf3PXjaih9zPk4P84U3qWaVrOxSUKMnArMpxyPJ
         0L2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mrOC+K0YOCPbrTmQM9IR744v9j1UjcD4tQT9sNiYbXw=;
        fh=3d4EWI8LGpU6D/hrkKqOB/V0+sj33idliV9dzsjAEYc=;
        b=QqTgfD3e9f4VMe+NoCmtT72P6jTuPTRV3/nKDrBrTB15JNONdjYGo9jkVtPr7UEwU0
         QYOE3crTPQ0da1QMK066AaDi7QGzywD8TwQBKSwJ69yJBPWMpRLM29U+pbJC5v8SPz/5
         uH+m1pdTnLqy2MWCe13Jt5lj2SkTRiXnTzxu1+ioHEEWdwkkAHI/KwFyjhBsZQ+ybgpi
         EKMWonQdCUskhkSxT+U3UEb6rath07595wO9OR/UHpyxGxvebf8Dt6wEliQgxr00oX5i
         DvHr/v9JfT2HHt5WyYKHjmu+06ulC+OLhfshv3R/LWv9Y0TbpibIXzvkQNUR1qtKDd/c
         qYew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790537739; x=1791142539; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mrOC+K0YOCPbrTmQM9IR744v9j1UjcD4tQT9sNiYbXw=;
        b=kHwNrqCNBIjvOGTdIi2qtyQCEdklwPoKAl8FXLR7aOWu9sGvNA+PD9Wsir8lkW6YT+
         C7Q3XaJWWd4zezycLkfBP2asDdodt+zliK/B4XfEsAfXXf6cvRzkeiUHPqwZnjhXVLjl
         bJvGEq9TOFodd0zDOHAc6qkQ0EBQS5THKRSeTl3Un+HzKvvU/3dahSunUZSQM5NDlCie
         ZZTstYeYifIod/HSuWBpMKgyos15KaWsMEyZ5Q76S2fh02H0KxHrdYmiEFuDcTGOAqpK
         q2/S6m83Ek7efdHVtYAbhLTw4t4niwZsZjmrtwD2g23SnEqzK+ei8uJkTlug8fertEVA
         EU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790537739; x=1791142539;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mrOC+K0YOCPbrTmQM9IR744v9j1UjcD4tQT9sNiYbXw=;
        b=l85VAaAr40KlV8gqxpwdg5Fjjcfw/DZoBIzflSyd0asA8MMMgzITNG9cHpLXpH3hpA
         aypoyRUpbUMh+IgXuu4ec9qv2/2yKK1mudxjxAcHBuommZoLj7wngWj8QdxAgeA3RSyl
         oQCv1/ntvrhxGV2JeOsWaW7tQCnXjmi4Cdivo+U2YiXChFH4b4CrbMrMWbbW9+k1M9gX
         bcJyWEpkzrx1jFa2RHi4t7vjxK8roKJ63HCfkdbuXqnJT+YCm6FUluszls/p9Hkj7JG4
         PVGXUa530H61MhTzcUAE93VSiL0Uqa4J+tKykC6/4OuGSU9q++H2vF35M2yy4icwsjKR
         mslw==
X-Forwarded-Encrypted: i=1; AKwUvBwgcU+DB3NA2mFMNjhz4Mo7kROuSVE5b0nTiZqH5KhXojkOtYvyxrRpyvHQIBsxxYQXC309va0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL12RG4oqCX59uXboKRSFu3t35lO8r6dNnU3HBQBmoDRAmFeprD
	W5f/GbYfM7w2zLOELdjYi2nYOuYxHiQwjbit/Usq4WnX/pBbmY5RU/QbhkEUvyY3OXLfEwPFE0r
	8M+I2Y16Kj8aXjP7rvqKxKVWKBK329/7sY4xjLIxy6uyrsCk=
X-Gm-Gg: AYBFou2xTpqw5JFiiyPY5qF2iOxrghN1o15CUURb/txiZJBQ2ZefotEHPD0qv/IfUOU
	Va+53+5ryDuBtUTjFyqDMszKQnSFTe2zZjvWI0PG9KMVWKM4+tSNy1h0MX+01K55FqqEuWjSmXD
	rIUXB7GSayIu2aTdCclAKfkSjF/ZoNBmQXoJHFvOSFuyBR7fRHMD909VuHD/oW15oAG7FV8bCW7
	jD+Usni5adHHwvZ6dJpsCiCalSv/5TBsWymZgbefCR0BYz/p5Vrubxx2FakQHAbJ0UnVbScjMwo
	ZU1UmxZbpeK/aqy7p2vEtG5VPdwE+2LBwogngl3tbzeDoJ7bni7OENIT
X-Received: by 2002:a05:6214:590f:b0:914:2c1b:7d29 with SMTP id
 6a1803df08f44-91441fdca4fmr122933726d6.6.1790537738641; Sun, 27 Sep 2026
 12:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790323012.git.petalzu987@gmail.com> <156c41b1-fc86-4ecf-8181-461944734be9@lunn.ch>
In-Reply-To: <156c41b1-fc86-4ecf-8181-461944734be9@lunn.ch>
From: Zixuan Chai <petalzu987@gmail.com>
Date: Mon, 28 Sep 2026 03:35:27 +0800
X-Gm-Features: AclHuK_WZK7MrZ0bZXc1PSjSrdd-S31NImpwP6KMGVrKPrjwr_b812NLnM_khgA
Message-ID: <CADTzadLbmd5E73RG16kQ1rFmwYESNuQqgc-JCX2RVhY0FRh8nw@mail.gmail.com>
Subject: Re: [PATCH net 0/1] net: bridge: avoid recursive multicast cleanup
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ren Wei <weir@nebusec.ai>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Sept 2026 at 00:31, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Sep 27, 2026 at 01:04:38AM +0800, Ren Wei wrote:
> > From: Zixuan Chai <petalzu987@gmail.com>
> >
> > Hi Linux kernel maintainers,
> >
> > We found and validated an issue in net/bridge/br_multicast.c. The bug is
> > reachable by a non-root user via user and network namespaces. We've tested
> > it, and it should not affect any other bridge multicast functionality.
> >
> > This bug is tracked at: https://bugtracker.nebusec.ai/f/4342
> >
> > We will provide detailed information about the bug in this email, along
> > with a PoC to trigger it.
> >
> > ---- details below ----
> >
> > Bug details:
> >
> > When an EXCLUDE (*,G) port is deleted, br_multicast_star_g_handle_mode()
> > removes its corresponding temporary STAR_EXCL (S,G) port. For an (S,G)
> > entry, br_multicast_del_pg() then calls
> > br_multicast_sg_del_exclude_ports() to remove the remaining automatically
> > added ports. That helper also calls br_multicast_del_pg() for each port,
> > which re-enters the same cleanup and adds another stack frame per port.
> > With enough ports, the task hits the kernel stack guard page.
>
> What is the value of "enough"?

Thanks for your review.
By "enough", we mean 151 temporary EXCLUDE ports in our tested setup.
This is the smallest number of ports we have tested that triggers the
issue.

> We get lots of bug reports for theoretical issues which in practice
> will never happen. And we get some reports for real issues which can
> happen. You are more likely to get your reported looked at if you make
> it clear the issues really can happen, give todays systems.
>
> > The PoC uses unshare -Urn, creates 256 temporary EXCLUDE ports and a
> > permanent INCLUDE source entry with IGMPv3 enabled, then deletes one
> > EXCLUDE port.
>
> So a hardware switch with 256 ports is on the high side, but this
> could happen in an SDN setup.

We also believe this is realistic in SDN and container setups, where a
single bridge can have hundreds of virtual ports.

Thanks,
Zixuan Chai
