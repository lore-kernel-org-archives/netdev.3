Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2B3EC6B0
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506452; cv=none; b=Z//VAJX3ve9YYLag0v25urotJphHME22obmelG4p32YcE0kD4woDinaY6l9csSpoHU5fn1IgMF1jszUkA+rOZ5hQP2WHxuKZ8BNPajWhb8tCXj70mYNjebGthAepJxuuuekqed5c7N4yQOhQTkPStNMTSgPGxExDMFoTCr6tD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506452; c=relaxed/simple;
	bh=UBYBBoGbVT0qDMPUQ7wtDEFeoAv8u4EqWKANGBDwPQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miic3yQWFgxrSM4D5ycl0vAYw7i3tFeWJ95B2xzD/7+ssCrM9+mSbBGGt43OvjIx+RtSNTMlom3lD5anYCD7stmkhsTaL86yYT5wXuRhXMVTtPRfqzPGkiISz2raag+JkVPFDplVUKyqjyfH6U/QgHOgFXhDVtkCkxsIfTpBWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5c5ac25089bso359462e0c.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 00:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788506448; x=1789111248;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NS7q+6fusbmwIYCwSSgkm4FqpxMVHZCBweF5L2Z29Tk=;
        b=ZynHXjaOT3Id9Ef3BHSy4oK3cWO2iVFaCWr1kgWKC5xq9FKdnVP+kH5hOzPx7I3VL6
         pk0+56r5MTypxMfrW8l9IGk55f0D01oslQRXMCeQJaYyJqU8l+evqky1teX5NvaqcHIy
         6JK+Htp6AGLmpqZRLaFnc1bBLt210jdh/B+NidHaoEaYdoJ7Xl01U/mLE4QmJIpqbJwX
         5yO4rxKV1VHjTlqv5zgftrJCFd3vjkp6W4x4Vay/9etJ3b8tRyTbC2sT/NnK0GQYLDvI
         ndHcGHWZ5obfdszR876bXNpjLiw1pj645Dq5ePFCnfcdLK1a6CYWTowvLDZ5NEpLKBv4
         /tHA==
X-Forwarded-Encrypted: i=1; AKwUvBylsWLdF9KlLgs+TTR1hO+XJqfNWIfIobdowLNUuNTvo9hjxMAhKivD/WO7cgZ8/c8NamtcTao=@vger.kernel.org
X-Gm-Message-State: AFuF++lfrWy11wPorkQ29wCBia2//K0E53Tbq9wGmONeXNJbJsE0VZdp
	aBbH6E1jAo+X9V+AFydyt3MeloMn+paEdPNGMPO6dVa460Z8BPjw6d1OwcmDrfVao9A=
X-Gm-Gg: AYBFou2Jzg1YpX2Z5srkeh+SAOZoGzXJYMs8aRZA5oNtCkSs5NPVVXMavqU1GX3RtOY
	wYGYp3s7wWtiRAsf3XOomQd2W8rjLiD6pXkyRYAcIkpI16ZOE3biVDJSxBx5PAM/YWjwxWdI3kw
	08WxSWWcc9Xl7/Zk6TCVqIVqiTt4/LLmcvQCyjHe7rpxkrNZBsmZz8FBt5h8UfVrL7tGD42LRgE
	1ZtXXahDLomV2sjBMLTscq1CAyUM70kNW0hXRjSZAG5Cn2RXxohJlL02mchpQszpzjoN3H/LRwg
	pgp6cMRJVjxA7LtYLc/yz6z8ZZQyjpZCN0iWYPGMKdOdixCOrzUb3v7BuZEk661SjbbS2vlFfHB
	tOyDnYtb2/8soTH1cv7ZGuZzAFsnz6vj7V2vbi1Fwk2YidF+TN6xFjtX89UojPG2doxXX6Pg0Th
	m7XHG+CsBxMp0+QvixXK5Cly1xvPuA/VhYFfgFKWCzhRD4fzsJ6qXCNdQv8LFoRONETnN2KISOb
	NlXRJXbZs6/xPiL1Na+u7yw1A==
X-Received: by 2002:a05:6122:6092:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5c7ed83b793mr1634027e0c.7.1788506448492;
        Fri, 04 Sep 2026 00:20:48 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec366bb5sm1516741e0c.13.2026.09.04.00.20.47
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 00:20:47 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-78a4dff7ddfso91659137.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 00:20:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxT+tbKYvarPl8aKpNPYMY0YWtYt10iTHld03utC7whDeQj51Z10sI8G9Pur3aTUS5UddEfdZQ=@vger.kernel.org
X-Received: by 2002:a05:6102:26cd:b0:780:7e65:f0ab with SMTP id
 ada2fe7eead31-78a4a58e509mr845164137.1.1788506447549; Fri, 04 Sep 2026
 00:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>
 <b3d19098-eccd-4619-b667-ad3b7e0a4422@ti.com> <69f7eabf-95cd-4bfd-a1bc-a1227c4b31e8@ti.com>
In-Reply-To: <69f7eabf-95cd-4bfd-a1bc-a1227c4b31e8@ti.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 09:20:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyj-x-tm4E+ZC8KMkzx48hpAxkrK==0hjXeG_HQYZDLQ@mail.gmail.com>
X-Gm-Features: AcwNN1W87AoGB0mn6F4o5J_OUipieRwifJnmyyR6p6PKe6C7v2GciBlPCkwdp3k
Message-ID: <CAMuHMdWyj-x-tm4E+ZC8KMkzx48hpAxkrK==0hjXeG_HQYZDLQ@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: ti: davinci_mdio: Drop commas after match
 table sentinels
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-omap@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sept 2026 at 06:44, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> On 03/09/26 18:00, Siddharth Vadapalli wrote:
> > On 03/09/26 17:36, Geert Uytterhoeven wrote:
> >> It does not make sense to have a comma after a sentinel, as any new
> >> elements must be added before the sentinel.
> >
> > While I agree with it, this seems to require a 'cleanup-series' rather than
> > an individual patch, given the following statistics:
> >
> > As of [0], running
> >      git grep "sentinel.*}" drivers/net/ | wc -l
> > gives
> >      84
> > and looking for the ones that terminate in a comma by running
> >      git grep "sentinel.*}," drivers/net/ | wc -l
> > gives
> >      38
> >
> > So there are '37' other instances (apart from davinci_mdio.c) in
> > drivers/net alone that require a cleanup.

[...]

> > Since this isn't a functional change, I am not sure why a specific change
> > is required in davinci_mdio.c, unless you plan to cleanup the remaining
> > '395' occurrences in the remaining code as well. I am not against the
> > patch, but the reason for picking just davinci_mdio.c for cleanup isn't
> > clear to me based on the commit message.

I know. Over the past few years, I fixed several of them I encountered,
but never got to fixing all of them. After rc1, I flushed a few patches
that could be sent independently, so there it was!

> I have posted the following series to cleanup all networking drivers
> (excluding davinci_mdio.c since that is done by your patch) at:
> https://lore.kernel.org/r/20260904043724.2955444-1-s-vadapalli@ti.com/

Happy to see my single patch triggered your great response!
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
