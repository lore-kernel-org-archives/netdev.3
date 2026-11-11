Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425190;
	b=Rg25XW14AF65CoWJhzqjLVfPfUS5AHbxwdoKCMREOjxcnm+nROBVUVGSthzQnxt5Esis
	 UbyBbp/7eJ+e1WMJ/C/WESJK8M5bmwS3cGlpHzz+kN1mJsangXqQjmDUfrUK7TVdYdxOG
	 XNDJJUxN0kkDxjfyxTRts2nnnRgcNWsvNzohJpEVQoUjd8oZTzu4uZW+BpBLWrufk/naV
	 a3T9cwqU+hGFAE0SEKbH8GNmA5A3qTfWcz4VehYM1l0DDeglsFBy3Z2eVsmXZQuLgC5tB
	 77bF8pdE5ZL0hS47gf6g15TIGVjdOm5DRcNH8v6HNuRaQoYup6rZ9vBl06VUp6pnyig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wd2WluVLwj4r2VIyBQDufDpYxaAOyEu9BCBLHFr84dA=;
	b=sGNzZzQ+U7wOvxL/5/LPlHjckdeu+qyqtNJSp7iSUFUzPMSGakHi9pGG7Q04eHU+O1MV
	 tWCCSc00+Y3wYgLS87eItmGMzyX8EETMF/93xwpLajCuNNsB/GUobfl4/iJekmgc4vKdo
	 sdQLVz9lGSTpRrYamMLAYgz7G3MtG2+DkEAthnomqSLmF8zL3jtHIM4CDc8JjRScJpvRs
	 rtl5XG/C9r9tPfObw1XFo2mSCMwCY6Tg3nF5OFOHDf8GSIdXPEHVf6VLObvxZzghOJUSI
	 aiumaIATafn3x6z1wVYKbrbr7NRcqMlpGkdwaAC60sYT2QN7knOsjhNEMJFaWgt6vOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=OIdbE4kC;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B6606B825
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC9B6606B825
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=OIdbE4kC
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b757029223so2519259a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794425188; x=1795029988; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wd2WluVLwj4r2VIyBQDufDpYxaAOyEu9BCBLHFr84dA=;
        b=OIdbE4kC1o3th9fmUSyZNGWnAWSvsiZJeZolzn138fsOmDtNkvO099TP84cZKeQeSq
         1IintyPSolFiqebd0PK52cL5ENVcp48uwWSFmgA3/p7zTiXo+Eh6oNUFyxxRhS90T9aw
         4IdK19TDmdi5YDgJ6UWKOli8HIgcUED302q4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425188; x=1795029988;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wd2WluVLwj4r2VIyBQDufDpYxaAOyEu9BCBLHFr84dA=;
        b=AQeEIZGDtbIS+pZJNomocePqoDofbAlnr7JJPLIiB1QTi2qrYQG7ilOg9K1m6QYWip
         pa+1fxf3vqWMt56RaNMB1lwYXrs53U+FZoxuMUr/oPmr0QxgkGDjQ5fVcRpAfjAv6ptP
         26Qs0Yp+XCL/zEX7xzQoRfkONWZnBI2Cw0fEE8q5mBzyPHloEQVzuFxgm8xZWgWRwlMF
         kCY9i0QLvm5kbYiiEILu6T6CipneHVHxq1wC7Vifs2f+IZf18S4bFeaeWdHk1EgMCbLW
         w+EcSRI2gLqsb90Nhpojx8V818yrVTlzY/80lOivBlQndbf0lVf99Wp9HXa/UeJVMZbd
         LmRw==
X-Forwarded-Encrypted: i=1; AL+hErF7vGYfVAJULj3phkyPiieDL3OMMQeYx/HOVPbbamDvcOSBTpQmJYogQXwECIvfZFuZA7H40MU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iLapNORXLe6h85DZDE/7PcghyffmMMZdCZTnRKg0IN5eZk0kY
	r7FMSTWpoZyWO6dyPw/6/aXp06cTQV2EGF6vnSgV5YtJtYSHWqVpXuFhOH6RTg68/5X0rEbURDZ
	1bV48XRo=
X-Gm-Gg: AYBFou0mi9Nrz5HNXbdhpN/1Abol3Co17qA54tgLg7ixwjyTo7ToNCmo1nbb8ieZwFM
	TJkoDMNRcCJ+K6UDgHMkEDWKEXPXAhgV+BYwPYEBuoOVTYgTGQM9hKQLOQAEhilQ4m1VMfDgjMC
	BvJsGSdQoVWFssUtqmLYm/H7bjerDRayZqCmw53YAhbrgzbSFteH13DuHShQhAV29MB6fG0ofzU
	SGejbrDcRyXxiQt6q+mciVLgxEDFlj8knvxl8TaugOb13LYRmIcbt1REE5jgv89vYQ7gqPck4LV
	qnNc3Fn+q3u8v7+DtZQ0SDATyiSeET86YvOYuVI4QGY2xrBF8nbSNSjQfGbbMd5x61yvmG9jsMj
	PIGKZ5M6vV1lHUsuEhWporQthAtSXkywabkG413pPHqb7VXejeV4krA20KGTBW0DB+BUnO4bQ5Z
	b7aYdwidWwtjiOd9CcQ0GB2hYzsQUFtLsFHDqT+NhYTXN3QlBZahRcQwUZTzgMlEaYY+Gq7eUUE
	QMPmsnxKSVvuigg3fTLK2MruNukLPpy7C4s6h8M/DtB8zZ9Vqpa8K6em7DVePNSdI+mkjdyWxZK
	TPUnynZkQURlAN74DLYI411XPVPBLiOOdXG3vznEroiPMCy/guhVXGtQoeJrftutBSWJYjRkFv4
	COdmiQ4f4U8t+iTxeQwA1tKhE
X-Received: by 2002:a05:6402:2279:b0:6b5:8200:5008 with SMTP id 4fb4d7f45d1cf-6b777869ae9mr1784638a12.45.1794425188212;
        Wed, 11 Nov 2026 11:26:28 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b75790caffsm2555753a12.32.2026.11.11.11.26.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:26:27 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0f2cso3186487a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:26:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH9Jr38cL0+0ZDgOAyilT+r5HcOD+XgNrlZ7EVwJftNJAgQvmf5jfpSo09eF0lmqMUyGvV1kXY=@vger.kernel.org
X-Received: by 2002:aa7:d1ca:0:b0:6b5:6478:a9a5 with SMTP id
 4fb4d7f45d1cf-6b7773edf34mr1838418a12.10.1794425186528; Wed, 11 Nov 2026
 11:26:26 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org> <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner> <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
 <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner>
In-Reply-To: <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Nov 2026 11:26:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
X-Gm-Features: AclHuK8LZq7-9ajWCZDJwTRjmLDnovqaiY30E_XKr8U-iLvj6BsIi-SShy4XPgk
Message-ID: <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 10:53, Christian Brauner <brauner@kernel.org> wrote:
>
> If that's the official new stance than I'm very happy.

I definitely want to remove HIGHMEM entirely in the not too distant
future. And before we remove it, we can most definitely document the
fact that we will not be worried about insane users.

And things like security issues count as "insane user": if you use
HIGHMEM outside of controlled embedded setups or museum pieces you get
to keep both pieces when it breaks.

IOW, it's legacy. We should aim to not introduce *new* bugs to it, but
if there are pre-existing bugs they very much count as "don't care",
this will be removed soon.

I think the only reason it wasn't removed a couple of years ago
already is basically a few old 32-bit ARM platforms that still used
it.

Those platforms still exist, and I predict that they'll still exist
next year, but if those users have to stay at the current LTS kernel,
that's fine.

                  Linus
