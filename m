Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD93B4EA9
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263116; cv=pass; b=MxNACmsqc0jBVwawDi9Oj9kSXnPRZd3KB0+b1FnaBZQukUzCZDpxWiKYPudZPQX41UuQh+3lsasu1VSdMV3Vn6cDOGnjFy0H8M+8rjf1csyTsVCi+6GDqawiLFdm4KStgWznvJVUjtFq0NAuvP4vHgOszYoENUmWAdLe+Tl+WPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263116; c=relaxed/simple;
	bh=i8MOdX8utl8Jm5DtV6+v+Wlhqiegdts/hItafUEDUfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVoUh0CnK2YLcknGVk0ESkWggJbl+njmul9faRGKxdnlgbpuH6yVAOQWg80hHV8ARNDFIuH065tYsL49H9vVrzbMYX4EiacEn/Nt/fmE2tdnnSL2pidqXvRNbCccZpoE9xgh4EPir66JIQtdURfgzNzO16cILE3ayw4rf7vdZ/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbxOl4ko; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbxOl4ko"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76c9deeso20679731cf.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790263114; cv=none;
        d=google.com; s=arc-20260327;
        b=fvwnJX/GdZwqtLzlZyR+xAXmQiPgKDTaZsoAOWOggjF4dEcXTvjCO1ILMjKkqs0J/2
         mJWJ6l1rN0LJPbp9tBlJ7RlSOsLQBOyW8ypA/wQ2FmiFxADWleHcPcVwfUhuvDP1tt3u
         zf61ivBKTynfnh/UmSckZpeRdphKyc5+bvXA24fbkp5/t6XArb7ULv3ouhg50cq4ju+1
         6EIjze/ZPbXiGYMGoW1po8/GZm+ITjydjTIS85WuqlkFMyFWG3/yMVL87Ih4UcIZndPR
         xqtGgA3jSX8lUnhH6nbWtrRQSCpyqFqPqoU8+cje7TTdkB4Ay4XMeawqkYOrolx77Cs/
         Z37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i8MOdX8utl8Jm5DtV6+v+Wlhqiegdts/hItafUEDUfg=;
        fh=lSgcE/fl5+V68Dlv07oydecaZ7+o4/tvGTFLq1UTh0A=;
        b=JNVsKZfZ2hBbdMEdo93s9SXukDC7uNqYRfjf13kxEv0vbf3gVKMmJ4PmJtVKr3CxlN
         2cUMRmymVcLzcAA5AmmCK6PwukVWmKZudCuDyHhKyJWG9EgKizeIOC7StZJ/Jo8p3coL
         zLBg4q/4xf/IuaMeTWQCfUFRPyz9MrSJKpb+ug98v1q8K/CKKcl6Xxv0jx6yHxmUYHrt
         +Ejmjzey2nRaSZrucJ4JjkvD7ySoUJxOGSTc+56jMibfauPidYUWw/ZF400dV7/obpoH
         0pGH59GFI7G3U3SCEcpJUIXf85R0nO4otlt65yrfd0JKxkaHcdcRdfj3MzJdydGMh3Qi
         RurQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790263114; x=1790867914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i8MOdX8utl8Jm5DtV6+v+Wlhqiegdts/hItafUEDUfg=;
        b=JbxOl4koYe9vSy6OnwevV9Qsr4uEa4SliVRNYB+JAEX/X1nTULJs0xUuqwwhkBePDb
         DRrWKExV0yQzP6Eltlnq7hFFrsX9cOcTVH/fpVPBzQvTJgCXoW1kCqD+Mj2CrU34uIKp
         sJBrH4pH4X25sXNJPIHWrNKuFg/+LEqO0jB1rWlYLuHMYdMEI55j9as0ZGkDM3upb9Zq
         kZVL33YFeOHes85UdNX7NOMaRQFVN2cTUbaEpmcVfXSFzDMKTT2e3NQMqv5u1bOhPbtI
         ld40pIALALj/NWbT5JM3TJS/1JVo+uztPIh1ihq2GVq0mV+r30tRWxx5zNYacLSHG9eH
         TAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263114; x=1790867914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8MOdX8utl8Jm5DtV6+v+Wlhqiegdts/hItafUEDUfg=;
        b=Fu3cn7sCg62zff3pxIqjKr+L/EOaLNsDp81U164umnjEMQJQ8bPlTuCzMBrLUOQLC8
         HjmU4IxJI5WGlIwIr3OLrvnu0lM6iKbYDo+NP02aSWHIB9BJ4wvw9uXgrMdDgt3Ik26u
         1Sps4M2EQKVf7bwKKmakwSuVb6Ru/f4jWiM0QymnYUNu+6vu4P9aBVhjs6uxxUR2oVl0
         0TlxB7keTEKep8quDvgbO6gL80fa9ZZrR9E5DTMfU/3kwU8qu++Z7F/G882OpvusxVEy
         PfLhohynP3ZvUKt+MM/gsC9ZEgVXriztLNkcEdghfo/23Kb2TVUHq7xaVkoqAXaiz7qU
         wsgg==
X-Forwarded-Encrypted: i=1; AKwUvByCPy/cHmnNOeXh62LdwgWKCDDkYfLY5sr43O8fPvHOc+rTKKHw3LLLYPJkYIXJ8KGLplK2Wac=@vger.kernel.org
X-Gm-Message-State: AFuF++lRw2KTyXXjVZ8XSYSEmrSKjYCAli2fKc5lplcm0pRSHfMujGcZ
	YdjlKex//9MmalpEYNm+z86byLl/IZLMwrm8ze88Vot9oFwJlo9st75gc67NWRC+Sgq/gSJTb+K
	kMUOWW6g6VW1q98OBy7iHrRaNKC2Dc8txMe1KtSaZ
X-Gm-Gg: AYBFou2+IjTM2i7wTFFE1QszRHqKeSpyVV3ovqoWRSIBalIGkKqQ+zT5un+aYPOsc12
	e7ZkzlXfr07vTDUc3u/xie5zC3M0rNVIpgQ1WcgK9kHxCKZD2K1HLz22NCuyx9KxKdenqDIpwIx
	Z1NJpZiM4l0tniYhuuTbXytuOUGdfA+W+8RTYxdRpz9NxWMr+QZxYNWuTYkWnqZN9OFwMhrO6ou
	wEuKI+wQGULdj/Leg0ntOKiXp6+dFBflQYG48rQYWtrlNnizjI9vhqQgE/yFvm+E/oOXf/5rFIF
	d5aEsdAR0Fa25NHKVsJqFuWC46PYr5ob5uHHpfaNxiKEfUypMRbvLn1Y3QMcnm+Ewj8fmQxYorI
	vDaOV2JanfGw6mAPQaC1XyNvE6QqhUnfQUh8jx07TU6F993eQJklvXEdq1WZdx5mrPFd0
X-Received: by 2002:a05:622a:82:b0:530:f6df:7735 with SMTP id
 d75a77b69052e-532feb43a6amr28550641cf.41.1790263113231; Thu, 24 Sep 2026
 08:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923223545.3815583-1-kuba@kernel.org> <20260923223545.3815583-2-kuba@kernel.org>
In-Reply-To: <20260923223545.3815583-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 17:18:22 +0200
X-Gm-Features: AclHuK-TnkkKVDDXC180OJIS8E6QNfXzcxp909qSjptnlCGINspF9zIm67XioQA
Message-ID: <CANn89iJaV_BDLZ+j4KxPaZab8L8ssS8pj+ogwCDC=G0pExwv4Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftests: net: add test for netdev instance
 lock ordering on unregister
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Dismantle two netns holding a dummy and a netkit pair registered in
> opposite order. unregister_netdevice_many_notify() takes the instance
> locks of all the devices at once, nesting the two kinds of devices one
> way for the first netns and the other way for the second. With lockdep
> enabled this used to trigger a circular locking report.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
