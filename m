Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424431F9AB
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583898; cv=none; b=AFoZcq97Uydmo0bs78I1fSaWXn+5rrFPZHB+TFVhPs0Ij9WcjXzb49sEJ0BGWVblmDu1ac0ZNJDdOR2O7DaFRnnLNAqcOKjzR2YDo6dEnkE6d6+E6IwAvNdE6ojGcuF8G/uafnUzKlEzrJ+CkaG2Pv/kj3LGmDTo0bN1cBF3bQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583898; c=relaxed/simple;
	bh=+HiAUq8B9doNx03/+UK5dzZU592ZQOyFYQ50hXTQNq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufX73uhW8LVBL1CGN2QGBc8+rhVemtYDvhQ+Y5ZTqR7HZDwD3hdeWvgFai5SRZV4u0G20ZjJC9G95KlGCyQZwIrxwDR4NmHdkkI/XdDFXoMJpDvT0PzShNbEU+zu8VbZf3gc+8cOf9JV78f5kiQJADis2cW4D2pE5ZklsT2mvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DnhQnYAs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DnhQnYAs"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so1108175a12.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780583895; x=1781188695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jHCD/usXrKJEgEC7iBTBFv6T3P+9p6Aw20cG/HazQio=;
        b=DnhQnYAsa2maSkdNrxPHX+yuRVIbZLBkKS47fRbTTz9Ed0XFLHxoOH6NruyDmOnIbQ
         +/PJdnXbbU1pW1lnDd1C7Ki8m4RMojqNI+ebXKgy8rBJhU3VX5Nz5BzEcQImo+1V1XOg
         6J9f48n3RDqtH62+2vJY2xWih4xSxE+7STGog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583895; x=1781188695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHCD/usXrKJEgEC7iBTBFv6T3P+9p6Aw20cG/HazQio=;
        b=gPp4kH/R0zxsSyXx+JFjcfyfAnYf2+V7nkfIJNeTFXXdSrmWUKfn0NSNkrmv2yNja/
         bjrF4yMf7H+u6dKt5+UKWk4ApcLbd3jbUuLiUKhGaUEcLjUc8n4Pp45EqHkmB+KUnfdm
         LZKa+ar9Qa5hDDe4tLhW0Y9XTfRK1+FDuifcJSDhJInNPa9UcP8kpmgZFXDwNUZNIsDX
         yM/XdfBByePjioUDw71yc6c+siWK4e4nwbn/pIuj9flGh5B+gUsoRV5fIyKqCl6cO3G2
         moiB/rPT6JBNazkU3vPy7aFie/II67QCriLurzilnsMWRJklbu8XYN1CxgauWwv5QkOQ
         MSJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CpaWP5PyCgNjvKAxldsz4DCNtof5moVm2Q4OFy4oYP5bArEuUV318yTDpQmsHULmgsLbjjIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCOeLF0ssQCj+Frd0NnrRymTd5FxemP1w/60EWowIQAbasopbo
	/g3gNd1qYDPdJwBnEgtkGQHP0+taCQP+L1oUzfRVv1VYatV9skUPiaj85s0KTeIUoLEfftF31xo
	OCsaA75ncEg==
X-Gm-Gg: Acq92OHcdQsH0/TXCkCAECF38RWK4PVm6lJU25hI4npok/I300JLOoMlpu5+XRLaI4k
	mlgZfG3zt0IS2BGs+ByVBYRHzTxzDcsheS7M+gazvqS//gUPJWZ9PQwp05i4LlLbg24IfYB1YbA
	FncRBzaJbqvpG78qw9yI2KaqoLlCPyys01CYnIb9ekneYGwQMUYrSXJDERtEcGk8Okxk+qvpec3
	g+Gjm3IFkxw0o1h74d0M92N17IYZMKUvGZrizc492trYwUf2LXkcXrYONV+PoWYazFXXmECJLt9
	OXQDKzXcvNAH2XgOxNfhuyKGpT2pQpf4AanSWjxBaOQgzWB4Bl97XShOKcUiFVnnptB7ABktel5
	FQT+HVUkG+MQ8pm7d4fXXugvw8+4fz947GlGIuQsIe3CjQ7Pt9UXBqRlb9PtjOajxLv+v9SKcHC
	HZJ/1Iol120v38Yil2L8Y15jy7456EDIkviRe4uofdDsj++KPy8XnNNhBP8dyc32kO3uUHxfhiy
	WDor+7tIT8=
X-Received: by 2002:a17:907:d109:b0:bee:1e36:8772 with SMTP id a640c23a62f3a-bf0ace08130mr499493566b.20.1780583894747;
        Thu, 04 Jun 2026 07:38:14 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0553fd86csm315766366b.46.2026.06.04.07.38.14
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:38:14 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so1108140a12.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:38:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+lhyhbyxhds8PsRbvX00DKOEAP4i8CbbZ5KrTS7XqQnbilrTqos4Fi3TLR1hxarCjwrzL759c=@vger.kernel.org
X-Received: by 2002:a05:6402:43cf:b0:688:12fd:789c with SMTP id
 4fb4d7f45d1cf-68e70412737mr4177929a12.9.1780583507075; Thu, 04 Jun 2026
 07:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <20260601160455.2c187574@gandalf.local.home>
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org> <aiEb8CTM-ovMIq7-@1wt.eu>
In-Reply-To: <aiEb8CTM-ovMIq7-@1wt.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 07:31:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQB-j53cTs9kM4UeXoXPaFj78aJe3D6Yp1Fohg7i4tWA@mail.gmail.com>
X-Gm-Features: AVVi8CdMcH2Yi8zy-bOiW7jRaCCsKof-RnAg4JQ3nwUYFdve2Wu3l5Vz6H4KhIU
Message-ID: <CAHk-=wiQB-j53cTs9kM4UeXoXPaFj78aJe3D6Yp1Fohg7i4tWA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Willy Tarreau <w@1wt.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 23:32, Willy Tarreau <w@1wt.eu> wrote:
>
> I'm using vmsplice() + tee() + splice() in high-performance applications,
> load generators to be precise, and soon a cache. This is super convenient
> and extremely efficient:
>
>   - vmsplice() is used to prepare a "master" pipe with data to be sent
>     over TCP or kTLS
>   - then for each request, we do tee() from this master pipe to per-request
>     pipes.
>   - the per-request pipes are those that are used to deliver the data to
>     the socket via splice().

So most of those would actually not be affected by any of the existing
patches: the pipe->socket splice would remain, the tee() code would
still just take a ref to the page count.

The vmsplice() would change, but looking at your haterm.c sources, it
looks like it's mostly a fairly small thing ("common_response[]" being
16kB).

That is typically *faster* to just copy than look up pages.

HOWEVER.

It looks like you're actually doing exactly the thing that I thought
was crazy and wouldn't even work reliably: you change the
common_response[] contents dynamically *after* the vmsplice, and
depend on the fact that changing it in user space changes the buffer
in the pipe too.

So that would break *entirely* with the vmsplice() changes if I read
the code right (which I might not do) simply because that looks like
it really does require that "wrutably shared buffer after the fact".

Interesting.  Because the vmsplice() code uses get_user_pages_fast(),
and honestly, it never pinned the page reliably to the original source
- it breaks COW randomly in one direction or the other after fork()
(and I thouht even after a page-out, but thinking more about it the
swap cache may have made it work for that case).

Uhhuh. That does look like it makes the vmsplice() changes untenable.

But I may be reading your haproxy code entirely wrong.

               Linus
