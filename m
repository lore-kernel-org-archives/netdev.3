Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479125;
	b=yMWERRu6yVt6EoT+IblJWkgzr4CyCTngMU1M7dPBG4rV0c5/5EyWmjXs+zqu3kfsj2d+
	 7s0CYqF4CG+G2DFS8egagrdpGjozsgk8GLkRAJTZfzSeBgEHO3HRC0PDm7wG4IqX8Gmzs
	 LSs6K8sAB906CVy/hqkhxeqqOTiVe/GgYcbQjqlKs7tuDykgcj7YrgTvXgKoOCzTuDAg3
	 tqg9a0SNRkQe+tBEvCRQYInkh2uSz/kgbH3NhyqouG2H1MvPtsmDAqFqlQ5W6IqZc3jFL
	 Iuu4wgINjd6C2vm/rDgcI9X2P+oplyNq02BqtSzj5LDE7cHA3Jcot5UfGQ0XCqM5LEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oDF42rmnmkhzedotr2E1sl7hiMAx0kNtO/q61gkgaPI=;
	b=TKj5fJ1q0c9vN5Wdnx+yoJo7zbh9wqXH15M11LBsqn0sT6Ll31B+Y3r7uE6sEh8oGGCb
	 7kfvmikp6/qI+hQ+ky599VGLmZoyOZzvPLCsleMxbbHjw5XKOSrBqlHA35AOULZsLjyGJ
	 zPTtpUTHr+XqY6uSX3MGHUh2ClyUeQUYboOU4xQ1M3yLFWJTBNFtAZ6pku4+VfscAdjQq
	 Ihgc0p8uURQjamA3XiOAXAIJ5mbHdu4qXGdn4uqUoSKM13vEmcHYdZMeMbVmHWgyNvY/3
	 dMIVcgTouieeVvNkH8a+LkIVVugqqCohuLaftCaiRwrDjjnhUgIW4OByTc4V5CiKjSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=T2ieWWm2;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F0606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F8F0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=T2ieWWm2
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso395126566b.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792479123; x=1793083923; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDF42rmnmkhzedotr2E1sl7hiMAx0kNtO/q61gkgaPI=;
        b=T2ieWWm2fJMs0ly/lKc+VBaeNbR7JULdp/Yv1onwgfgH6q5MD5rmGllkC4r1IGDjPh
         b/oViX0b6w+uMFqC5z0zvmY+lbDh55jK+TCaZMeqXjulSW3NEhRsiuz2anP+CryhJBrp
         lyXFOsCuCjD/XcDxIqSfX1dJPC9p/wimpItQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792479123; x=1793083923;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oDF42rmnmkhzedotr2E1sl7hiMAx0kNtO/q61gkgaPI=;
        b=dij2V4gjlnYIdlhjIwqYFcZLFJ3WiF7mlyvK2MVoOSGUuFlDqwgc5y2CtB01RJJ3Wd
         /aY+pUjHo7lvuS18zN/MagfAMoHIrYoFbYqc0Ms1TWV5XE69SWGxPzWpwzotVuaagWkl
         7zVW3pk2fZNeI/H5q5ZtaKhxVd1xvdi1QZ/lQ4I98HLHvZTBIt/t6XQl85HMGK9b9uov
         rblIrxsgH/UZAU/lYY+rvrFMe0S05JYfaF04FebpWS3LCINXS7iCpqKJ4z/2YgCYoY8n
         8UKbZWqa+lBbny1KI2AxeTmq4aEKy9mSjDvXbzVMZvLrlVQXdadpDqkby6+GhDR+Enyb
         ESqw==
X-Forwarded-Encrypted: i=1; AKwUvBxW+n+MYBN8XtnjDo3TokFjVSgp/MVs7s9dmU2Ojm0+Igwg4HN1lUiiq6eCCF4aesYSvhM0Vyw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCabZhcTT6HdjETMIgI5uDIrs/or5vh25SRXy/sh+U6JUdLRWR
	qR7xPXRmr/1PFKx72h5FmNHIsiE0ozHtfVRpwHmNTnQ33Xr3i9w+D2S/p1YTbxKATjMkhoMaIoi
	LxETkMug=
X-Gm-Gg: AYBFou2rKKeqksBpx67uEJdAnwV2X82YC4qBJl4hn5NbqI/SY8hRvlTOTg3sDNKhs9/
	TDLvbRFrRAaS4cwAdOCCVC+DD4Bt+tMzzCdzs+E9vI9UU0befH51hQo1E5TVeOQUx3k6fn73/9v
	pkKJp13tCvst98/w2xeZCgffQuxf+V+fGofapeH3+xvLGgPVzLOxZwfJannGFZTrV4CbxYLivSh
	nL/PHyS02stAbfMgV2/6fS8R8JYFNyNwr9/Ra0WdVmPdz5KmWESAbldPV61OYsOCtjm+quC9j/H
	/+nhNOK8c7ER2tBfw5esvHmSGIOTo+PlqB43b3icIiFHnepinMBkFwsWzmdxGug3QzhzG5h1YQq
	9OlMi03frIJTYFE70XaZ3aQFuNG6YLLLMFESl/bT9FLyQtf140HVGlkSr51sBupFKzCYhFv+wUA
	zrAFl9QVdZaBubgZFuJ4FKeaoaY2norM8PLHUktl7XN0MclB2UMeU3aUvAU8IojJdwJXPuYOQbO
	U3L/tWLRjoTmM/CKRWn9fW5f0pSk3opxN4xgaiR2Ip2kDQ=
X-Received: by 2002:a17:906:ba89:b0:c26:2a2:b91d with SMTP id a640c23a62f3a-c419a93b941mr611701766b.6.1792479122679;
        Mon, 19 Oct 2026 23:52:02 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32874bsm444109666b.9.2026.10.19.23.52.00
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 23:52:00 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4395d31228so252266366b.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:52:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzes627CFI/JFMQLunmF7IkHoYYkMBQqayCFh2MA9ni3pmlso5AHO7HDAhT950NUVQR7py4AYM=@vger.kernel.org
X-Received: by 2002:a17:906:dc8d:b0:c46:645f:cedd with SMTP id
 a640c23a62f3a-c46645fd0e1mr41541566b.8.1792479120078; Mon, 19 Oct 2026
 23:52:00 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org> <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261020021924-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 19 Oct 2026 20:51:43 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
X-Gm-Features: AclHuK8XyMOfalc2h8xLYAwuI7OOaq7eZ0Xa-sCHFlL0Wx6hRPrX61Uqe-VGGwI
Message-ID: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Haoran <haoranwangsec@gmail.com>, jasowangio@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following seems to work for me. Testing would be appreciated.

I have a whole branch that removes __get_user() and __put_user() entirely.

Somebody should check that I did it right. But I didn't want to do the
pagefault_disable() around the vringh_notify() part, so it's not quite
the same as yours.

Let me just push it out. I was going to let it simmer, but your email
made me go "I should just let more people look at it".

Mind taking a look at the 'uaccess-cleanups' branch?

It builds for me. That's all the testing it has gotten so far. Blush.

                   Linus
