Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794387748;
	b=bLBvQf5ez3hLTsxEdmNFYOJWT0+lTLO79r+XYW4D7vRdVxhS7hRi4dZEHSRVuGlb48HD
	 OpNxUi2AfZCwfNtm8qqrpOi3hIT8YOA9dyitEgJqUOBdfCVANibmbWiu02TwWPVNhrE+f
	 /g6JT8FoDurjyvmyLhu3lP3/wSXVLY/bQd0G6rxbQVpqnoizmZGlPdyVFbXDvKMydK0tD
	 9y5IfSanhuLdiD4CXwX/5ArnoacqJ6MfFDKNz+/eGQfmIPUJJnILdRcFfWBvzuxz2JI56
	 gMLgmW4O2yqw3PO4vdOOiZyLUKtZRPP0RiAT99Ei+d1R2FUEY4yJZSN6FP8/a3H1uSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
	b=1XldE7+rlxVDNNWhW+EV0Mi3PC/3iodkIFVgglFEf/nJKvOkshS/dH6DeSWGSCWK9wjp
	 9fMQfHramkxPBqLHsA60Vj8EfLE5COenar0ukz01Q7U+ght2W1bWwOGzjRqVzGCJ9i0uX
	 00nEbE2Hi1hB7s5Kyx2xbXAQu/VL9y5e0dBdgWQoXWhQbVXrFLOQxR8nV5IUeD2DG32dT
	 MI1p5O3bSNv10ZFqPKYiBtm4rNhNtMJfxg7meSF5tFznVfpSGRbyUeSDlltFKgFjJ0ez6
	 jsnpEqLV4YFEzDQ1ePBEMvn3h9SXN7QogHlVOUEcJNMWwACGK6bKBqdSDi57dJPIFMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=ZG1wV17q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E2606A32A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A48E2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=ZG1wV17q
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5361e313e63so30616291cf.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794387746; cv=none;
        d=google.com; s=arc-20260327;
        b=Szq8Xz6YB67szl7WqA+AYLq7dhd2iPq4AMclEubsUrKR4wIa5FHBp14sETcLerpd9r
         AESce7uJF9ObeJHMjDmejGi7R/Lk0z71z2KZUOgchRozLtc18JLVxbj18fvUk6m2xrSX
         fN/CsVC9lcTeFZsUgF9i1kUJDc4F4BQo9MBQVJbeRrUcCgxDQtM1Lj2j/PljqEW4NlwW
         Ak1q4DfKoFKRBNh7yYmDRe7zkrdtpOqEcrlp45rdvCeboUzpDOMPzriuYLYVj9prQiJI
         O9fg2uII2/qcN+paV3dZxzT1pcI8/SQmrOCe31asMqK7NkwtL4oZS31ECzYtIi5UkOJR
         IMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
        fh=wDtX9SBIctGpyEfPXmbC7N+niuDbdm93bTKEIs9Zbh0=;
        b=IcBpBlxR/MkteHKoMBtZeC3lRmuaOEcoC+s1UwiFj6HuCs52HoLH02sMUbkKY/+01Z
         mhK/GA9bujGU9jb0TxoRv2sTMH+CkREqJd1fdU8yKITcK7pG6YJKV/pMNHCKqZADpBQP
         uDCQlB/mIZa/meivCbVfIjtM1GEnWsQCho6H+cDcCdLREemLlSuNr/TG9JArSuxsQPWo
         HbvuY0dWJZjXoSE9R6+JJXjIpAW0Nvs4I0ZmXZxFSmB5LT899MOiUI6DRXZEVfGw9+U/
         8p93JxQOzODTYFTOL8h8+zte9HGbUo2FiQ8/uVQrcmZY5quID8CxOVgvHfhQte+ttfxQ
         O3eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1794387746; x=1794992546; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
        b=ZG1wV17qi7k3y+OgTB9oJ+Iq3qqKdjhEB6Voe1crPeuwQy0wcDNfv/bdudwdrfdRw3
         ADLgOcPbh/kgKQc9CUfDrcimVHeDxii9BVyDhy8gtwLRFQrYbBk+hajpv+6KgFLrz+NI
         al6FswZ2+KsdhNnysas3fU0YuIKpHZj5CWMcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387746; x=1794992546;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
        b=1HYSFcHYDWK+8Ha5ScWLnXXuh23g+qOiMSBqCjKHZKxPFuFqJ0PvjBNAcxrOHgIB1I
         9UbOYgw/cZt05ErlMwIS5hPebA1R3obDs+k6HKGl5BrPeVkjqi3kj84UnqSx8K0J3g7i
         h1t71UY1HkudWGBhoykev+b9Hniw5SWjOk6nRvQeNEPXlz+Ab+Dt0BXI3IL23LxPtwJS
         4QJA6kpq2iOL4bzb6V0TGwBnCODBMg8BddeRFcxlCklkGHYh2zqMXmVuFWx/BJcYil0H
         5k7ncFsO5sAJZHZBk+ifw7qRHNok1Rrrju4YIrwCb7MGd82gmbKlr7s4yl9ljX6nM6A+
         BdZw==
X-Forwarded-Encrypted: i=1; AL+hErEKiEYLsAYsEmAcaRaWdAMLmmdXAVuk+sEndPjVDdb4S2a/m7wWD7KpiSfqBhZJ33eTK+Vq85U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KGtQjsiUDa6QQG41G0adoPZOnuM6wqB4JlhTaEfaw6h6V5AhS
	pUay3lJYYHwOvhQIdOkB8IrbfgMCpwKFf2Sbf5qzjFsN+rh7hzibw6ob94GtNVN0D300oTaLJc0
	KorZkSRHbW5bWxvlStIEs2yx1a6D7ViLz69BCV0Wc/w==
X-Gm-Gg: AYBFou2HJn4N7/eNmpXAhzwfxAx0Ry5u5oD+eyybiKG6yXZljLmDhi5qq9q4RAeDx5i
	NRTAR1V+pKYE2oY01PFYspp5obeFbLCyqITXCPITTXbi+2m++nbbXQzAlU0HrlG+kNNC7MtN0qz
	vxG4yj/AG4QAOmMEuvrigQWxDLIG4pCEigbWV6PjUDOxxYtDgbsRpFL7Rcus0mM3PNbmzurTiUo
	I/1LJx5Co31+Ed/hXMSnd7YevFD85XOjCaSDFnVdnG/wlAxI/muiA2MoU52+zdXbYgC7QuFS9qk
	ONo1nLFUSldAqjlUHiMip0Cc52WHPifoKLF0fyS5TnYQAlsblqiUeU2JNKDiNi8dFhBtcAcVJh6
	8GW5+JYsgAtnr86S7jNX71WUGRb2S3tmw3W6z9FIC064xnQb6/Q0/mVUtXCL7BbzrKQ==
X-Received: by 2002:a05:622a:34d:b0:536:8f5a:64a with SMTP id
 d75a77b69052e-556c222b82bmr24946931cf.63.1794387746372; Wed, 11 Nov 2026
 01:02:26 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-3-kas@kernel.org>
In-Reply-To: <20261110145241.536019-3-kas@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 Nov 2026 10:02:15 +0100
X-Gm-Features: AclHuK9XqiIqd0G6zWinytDup_EFg0rRz4_cn9sSXLX9jTiH3KRFdGlFPrXk02Q
Message-ID: <CAJfpegvEeGN073FbaCRnhMeX8RHrckSxmFjkpdoyea2EuRf+zg@mail.gmail.com>
Subject: Re: [PATCH 2/4] fuse: don't move pipe buffers into the page cache
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amit Shah <amit@kernel.org>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 15:53, Kiryl Shutsemau (Meta) <kas@kernel.org> wrote:
>
> A splice() into /dev/fuse with SPLICE_F_MOVE lets the reply to a read
> request steal full pages from the pipe.  Each stolen page replaces, in
> the fuse file's page cache, the folio that the request allocated.  The
> page can be a page cache folio of another file, a page written into the
> pipe, or a gifted user page.
>
> Always copy.  The server sees the same data, and the move was a hint
> that splice() never promised to honour.

Did some research and looks like this feature is not used by any major project.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
