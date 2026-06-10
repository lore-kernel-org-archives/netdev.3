Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4FF3A48E3
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085346; cv=none; b=Co4B4BT4w3pEVp2DtJ6vzsIQe8Q2i6dDMSzhniSIMbw5agO8GalFODgIQi2G3AA/CWQrYz7QDEUAl4v6NjukAESalWxcOyO7jbH6m+FAuhS/T9yxwaOgGJl7lafd9c9Q6pXyfnIXxGVZoOuuNs4UP8HP2E4i6EG9WGZfRgpBwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085346; c=relaxed/simple;
	bh=RxYtaOzOjvXLhABsTLKT5rUdf2WjHUzZ4ozMxheKOIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGDeUFRKkF5Nl62tKs7KM36P5GQZJUV0Z0GUSRPbpaUqPpaHAslOj+hrF1X73ymq8e430lFs6y30h7f4Uk3RF/vOlRTCJGx1IJ3sPGDyYcAv8XfQSPd3iuNeyVMM7dnZdbVPlkP2tc5xnROFFSnorW9lDqjVhXZeTXKXF3jmF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gehZfH0X; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gehZfH0X"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso51335215e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781085342; x=1781690142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXXf5kDNkZaZma579LeFr3+QRDi52FtRCi+F8Ah0BJ0=;
        b=gehZfH0XlCrjPYGryvmNLnz8gas78t1NCCGVCxYQuXc+ezJVxkJovg3gZ68eoCZhgT
         w7yc27Z5FV6OxwB0FcPBX2EqHE5OPYPbURPQ7PvMZtE9MCaPKi95MUdpet0KUehGntqc
         HKRVYuvq7W/adTDWj7WZk+9P4GJHI1tChfCf+Jq9+5a8m4OTJYSviMfYuqiW8Kxn9OQj
         zL7dYye1N7l2Jd7Gx5fa399/j/FnsYswvqucZIgsSiW/jaK10oDH+iMuO0D6AA3auCEt
         /IElReue6IxUwWl0P2t/ZHUQ0JIBvBsH4U6b1xso05OWP1ipmWJ6Je8m+oBQpDhf+jbR
         rK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781085342; x=1781690142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DXXf5kDNkZaZma579LeFr3+QRDi52FtRCi+F8Ah0BJ0=;
        b=sTMGt0nFJfnpYzuKjjA7ObUvjITjMc1qMk9DyZy+p5n3Dp0SpCY5VM2+brF8yNqsP1
         Tkvicy4LC2oMqfBbQqfZuF6IavolkW5wsAoR5UbwK4PafVfsjd7URNAl3nVQYnTa5qp1
         i9EoimTw3os39iHKHUDoDQK7AV35NxhKj/8+yqDkcuRdSrHmcVw5InzljNT26w8cYUso
         hbmGAvRj/25kGUX54xmAc+UCOU0VoU/paABrt8Ak1cSxEMkgv97dFzcqWoyDoNJK7ZZ8
         IvtN7SEP1Z62NVrROyLV8D6z3oxskULkaW1LoHV2wLRUQMGvo1uOOUDhtBe1662ijvEK
         0YFw==
X-Forwarded-Encrypted: i=1; AFNElJ9wYRRnBAyWeA2Cm9jnizUTHbb0/WpFHi0rfrwRWPM2LwcVwk6tTURy0ZRDr1LxzDDbmUUAljU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKkE4Rek0bPHZGGFr9Das+LBxoO6liynU2k49i8jpiXd0pGG+
	N8IT4ch+5KN/3g+vzs8FSYRA2OURhL1Flth4PlzadPnzAD9LNttu9D+R
X-Gm-Gg: Acq92OG+4oANMxIQ4p4wR0yE8fHmBYREzsH+3YyItURuYw4CbqlMqXei7oaxF/0BurP
	PBP7BwFoP+cUVY9SMBSVo5CIGZH+tf+kQ/encycEXGOTNnsKUTbN4/KrPl7L+WOudBjDajtG5Zd
	KsO/dz57VI6yzyKaM0N8RxPmjpr+SPU9fq/X4xSmvXeOYAz9dQ+fQdFZn0wqrG09PFlgOAisrRZ
	As1YDaNesOixz/veI381WoRr87Vaz4qYwT1nILdNqzXiwNiXJaWd5tNcDxxpQ1c9fTl4zm1rJ0m
	1z0kSXXyHTF/LaH2cP7sxCpau6qlO04NLPRIG7jFH1Tz/joFGIvwfee2veyjsdPAl1riURbZ1zD
	LLTAHFVZrr7cQkfJt8rKg89YW/t2OsTysSPo8Uls6AT08IDQC5z0eN74i+CpIVmcPpR9sc6Vw/O
	YnQ+33PotZYWyTVpUAw9hc5+0nAQAqoVOP2gopu3CVuFP60HFMnat1VsGuXKm74nAZsUWWRbOgY
	hg5cgCZtw==
X-Received: by 2002:a05:600c:6096:b0:490:c1cb:48f4 with SMTP id 5b1f17b1804b1-490c2d038e8mr309043665e9.12.1781085342059;
        Wed, 10 Jun 2026 02:55:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm591850845e9.8.2026.06.10.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:55:41 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:55:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@amacapital.net,
 safinaskar@gmail.com, akpm@linux-foundation.org, axboe@kernel.dk,
 brauner@kernel.org, david@kernel.org, dhowells@redhat.com,
 hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
 patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk,
 willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260610105540.5901a5be@pumpkin>
In-Reply-To: <aijxfxXrWLCVqV6-@gondor.apana.org.au>
References: <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com>
	<aijxfxXrWLCVqV6-@gondor.apana.org.au>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 13:09:19 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > Because I think splice() is a *cool* feature. It was always *clever*.
> > I just don't think it's worth the pain it has cause.
> > 
> > And it's been around for a long long time, and after more than two
> > decades it's still most definitely not _widely_ used.  
> 
> A couple of years ago I used tee(2) in dash(1) so that we could
> avoid reading the input line byte-by-byte which is what every other
> shell does in order to pass the rest of stdin to the executed
> command.

The shell just needs something like MSG_PEEK to do a non-consuming
read from a pipe.
(Without the strange behaviour of a second offset.)

That would be simple and could have been implemented 40 years ago.

-- David

> 
> https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=44b15ea09a9ee5872cf477e4ffc6b42ef37d1e46
> 
> It's definitely niche but made a huge performance difference to
> this rather common scenario:
> 
> echo 'command
> ...
> rest of stdin' | sh
> 
> I didn't even know tee(2) prior to this, even though it was added
> way back.
> 
> Thanks,

