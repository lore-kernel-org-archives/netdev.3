Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380AA3859DC
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759452; cv=none; b=kdKMgTOljW4dhBTB+x2FWEvrdypOOCkRTXM4L+vWbQ1LtXrykZoIDD/3hzr5qJQ7kCAwoByIM+7Oy5tBU/KmPRr6Hv1qCyPfAR2KEbHy89JfxNUdrKMjNv1rsPb1RNtXGei8/qKOxn2GxYSyNV2KRY26klGRRbWi4IUydW1h4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759452; c=relaxed/simple;
	bh=aLH5YBATn9eCNSGgtO3MOr4x22/bBQ7ESfJaSuBS89c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKTWajXBju3f9DwtgbWd2UmwYWK4bsdAXCoE1SRnhzGmDP6XbSWwt56FcEUm6VFiyU8ZyrXock917KuhPpd0aWTns1rGsLrqGC+3fc9m15ob0++VtOD0lQ1asgky6MMy4BnLfhHasUUjxylC9wGIR9j85IN4g723huTMwQAdrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Eyab5e+l; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Eyab5e+l"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-514ae601e01so49212251cf.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778759449; x=1779364249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDBCsEhXxpxSONCF+uEB0GBHYti2oMl8hGXWjjN3tJ8=;
        b=Eyab5e+lFUjSm4nW7eNvM6JdJ32/ERycNju1lNdhR8GloSudULEoHKEIOfAWwwCyxk
         1hLLj+q0IAW0WwIfH4kR2Cl8+ACdg2zaHD6rF7kkUJ0UAvGUjdlw7SC97bMSX3fPg+bQ
         OOawlstlFz2ig0izecthlVxL2FcB+WazdNVoW8tbv4KkQ2o5m8ZQbsduaB0RVhb/ueFE
         0KiPk6EYrHYS5744qMquHsgLjmapzvLRWV9iCrycWRlAk6x6WjrPc4f5C//OBtmqgOGK
         Y24zVHpX6JwO3SNLCfjdiArqkAzvTi5b6OXi7x5YeNl+YhEPQmOl5IT5B8efllbDhCbN
         zQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778759449; x=1779364249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDBCsEhXxpxSONCF+uEB0GBHYti2oMl8hGXWjjN3tJ8=;
        b=GaxzBZwIVyuEJEbCoo5Yx3d+/oRs3iIb8Scd9g8kKJL+4iyLL02LqTqULBv+Lnqbuv
         MhkDANaXTzmtQ270C/XaLrhbUrrfCKJiuXeJ/qfVpSY4ga5WtAcby32EJTKOMGgZ2KQ4
         xMUmdugdpoHYEBMeM/0qD77wAdMutwgrsEEORmx+nRe3b/jsvIsoLKm7+0lTtvtudiuT
         gOAc2Jw7R0vP02P1zKQTVGSkaZIecsTiAippcaC3tGjzsgAOLfeWGExBCTD33LH+TyWw
         9916OFh4dHrwePHEe7Pda2FmKvPqMnL8L7Bk5b9/OLPj1W/kDQEQqviz3bivkGLu5ycK
         2Ppg==
X-Forwarded-Encrypted: i=1; AFNElJ+FLlaJ4MmeOUAcfoUd70/5k7Q1gL+H97km39cO4JBI5L4JLUTizmLgJHcWdSbM8W0uABSZsTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/SP4o5m81DWYJiHqrioLpDiOOvSGCqmOmmf37dWaWARz5/C7
	U9LARHfmrHyq7oPvcoJy/OG7DoQcno9PIuNIHne1gEn2QUHJGJC6Sj52clgilmPiLKE=
X-Gm-Gg: Acq92OEBNGJnY+GEfmmezY8vRg3Gh3N7fIjX8tYYGxJqVz5qBFj74u+Yq7rFkyL++3/
	NQrxgunZj+z2HdRKDVgZo94wwG9KxlBszfbThor7rYJuXqN7oTDoCtiu0607YsysSunOVyrbIwN
	MSEEMqZegVQk4ayavosfBEyMUss496NY1SQnimWQfbtLRJlu0/l88qvJb/eNbRBqGoXiFt1yYXt
	zv+gpEL/ylSk1NnV0zh7+O5j8iEtN9KFbQMJf4fUeqY8/FRNyWZ6OoxKihUOd+3lx4ZN7iMwUyJ
	DnlcP3e4/Pjd7RD/zh30f8jxvJlLZzMzr+UUnkRIGQ+3S47qvQYxtRtwyTFYKRrJXdV5Z+tlF5Y
	DLZDPLf0mcSlwqh1xaEgw9kOqPCXk6Wz3vuIju/+WF4RYiDBpukmvmgekBi+ilcjUIdpc9W7XO0
	2Ct9XQZWCem1aUGq8qmHULjUySouCd9+QaUjrsSe8zgtgpQndhlgumjkbKy7q2UkGr8imjoMGY7
	HwbwA==
X-Received: by 2002:ac8:7fc2:0:b0:50e:5aed:caea with SMTP id d75a77b69052e-5162fe26062mr96232451cf.14.1778759449125;
        Thu, 14 May 2026 04:50:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585fa0asm15519921cf.31.2026.05.14.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:50:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNUaW-000000057Ee-0Djd;
	Thu, 14 May 2026 08:50:48 -0300
Date: Thu, 14 May 2026 08:50:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Adam Davis <eadavis@qq.com>
Cc: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, hdanton@sina.com,
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com,
	leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
Message-ID: <20260514115048.GX7702@ziepe.ca>
References: <20260513234655.GW7702@ziepe.ca>
 <tencent_3CCD70788A6EAC2D356D4C9674E8D2EEEA0A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3CCD70788A6EAC2D356D4C9674E8D2EEEA0A@qq.com>

On Thu, May 14, 2026 at 03:31:22PM +0800, Edward Adam Davis wrote:
> On Wed, 13 May 2026 20:46:55 -0300, Jason Gunthorpe wrote:
> > On Wed, May 13, 2026 at 02:17:28PM -0400, Leon Romanovsky wrote:
> > >
> > > On Thu, 07 May 2026 20:50:10 +0800, Edward Adam Davis wrote:
> > > > We must serialize calls to nldev_dellink() or risk a crash as syzbot
> > > > reported:
> > > >
> > > > Call Trace:
> > > >  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
> > > >  rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
> > > >  rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
> > > >  rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
> > > >  rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/1] RDMA/nldev: add mutual exclusion in nldev_dellink()
> > >       https://git.kernel.org/rdma/rdma/c/0b28000b64f40d
> > 
> > This seems like a rxe bug, I would have expected the lock to be inside
> > rxe to protect its racy implementation of rxe_net_del(), which looks
> > like it is possibly also triggered by NETDEV_UNREGISTER...
> No, it was triggered by RDMA_NLDEV_CMD_DELLINK, you can see the "call trace".
> > 
> > ie it should not change nldev_dellink().
> While this could be fixed within RXE, the same issue affects all other
> RXE-like submodules when they subsequently support the "dellink" interface,
> therefore, handling this within nldev_dellink() is relatively more appropriate.

Why would other modules have an issue? The problem is rxe's racey
refcounting scheme for its lazy socket creation. There is nothing
wrong with nldev, and now you've created some nasty BKL in the nldev
code to fix rxe while ignoring its other races.

Jason
