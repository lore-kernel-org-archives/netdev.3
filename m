Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9343264FB
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784408344; cv=none; b=pOrRS5jVK8YSsyfeDCzYYSS0Bs6XZGgSeHphPJpV+QJxl3YWlxav1Na9jp8IOFvD4z5Ape1HqaFH+FmiEgL0CrlulIvj7wmd9cJb3BVDN974tVgTnP6bQADiAjPhDhLOAb7/BAghnsl+FVcQ6PtGw5cW8+e3UMlGQbkmkHi2FOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784408344; c=relaxed/simple;
	bh=HqzEZ3bgMLTPXgL/wWvLOLcOK5yTeU+drGBScgleG9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chI7etDNdtgGKYUI7tCJB5vFj9HvqqxTk6mNzepSZ40bGwbgZjGcIfiw9LdH7y0hQ8rU1PM2F0MC2CpqhTSUusOQPcV1mqMHRCnp5/lg64cEO0CiBY8xhMO7g1MRQNwH5SHmno19dhAaINxz0c6hfw9DFZawIz/2GhZHpEWU3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdhFsyBI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdhFsyBI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so69194535e9.0
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784408341; x=1785013141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OfSTmHlc+4PzusgvhlO9OeocHbbw6TEXsXghlFKBcqU=;
        b=bdhFsyBIPJCSoHN+mvWMmpEFX1DLiJ9Ygx/AihNIWeGbKSwSndGhN0GrL6lwxiUOZv
         y3mnSDNIGRqwOusGt/18pkEZDHhcs26VGjGAAVtgZY6KJh7pH2oiRomuMsPCBMIvhdcl
         asb5+4rVqVunaDfhuPo/3Ckdc+LyMVqPvN/iKbIMPvtUcAGBO+WxGVYdAp30LdvFYKVs
         6V603JXIhHxQcC1FGxS9m8t5XT4qzQPjg4OmCJax8c/b0aXqqJMYnXO1eBnXM7uCWEWJ
         iVBdfw/Q1O/BvfJ4YWJKe9Fv5PCI6CLk2GPLApOy8p+oTunVi65pVoxAQspuEQC7la6Z
         5aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784408341; x=1785013141;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OfSTmHlc+4PzusgvhlO9OeocHbbw6TEXsXghlFKBcqU=;
        b=QO3ZbKykQJvQ45x0sUfRn8pJ1eCtY2c4O6xThtSJsN4DvffBpkAKBfC9QvzzeoxCUp
         7hZHRNQXbvONVdFOiACGwxPecyZByHe+FWmCfx7CRCcFdRU1bYQzrTVaAsAsla9Xucbf
         sNRXO4ysiZ9TuEegjWnGQ3eP9zXtJuy6jt4O/te7RxLRkKtjTbOe5WEOiyxBZhyoKTRQ
         JDp/qIn3Xd3hXbn86JNzAHdZTlNpmmlsTh7PcmJy0JJUMteQJAzk+CZ7xn3jmuFFdzy+
         xw5oRGrudxSumSI/dS18c4cXrmzoyeAH8sDjY5LPuSsJHDixT4bWU3MwlhzarjUqD0rn
         J/rw==
X-Forwarded-Encrypted: i=1; AHgh+RpwhBcwF7pX4lnYzZ+70DJJ6M5GDZ3eYT1L9YIa3ZF/CYvhLQiGAqpZ1Vx+weYKxcH29WS0zU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2xj1mNdmcXFhZ6thlPpFlUwB5zV4QajzZ25E71dk7qOkgei4
	0BGrCvp22jH3/7yAK+0tMJeWdt7b8y7FY1X4/r2GKGhtxqhYMunmDzKE
X-Gm-Gg: AfdE7cnTB9GT5EZrU+ps+PpPHFawqx3uixknn+v2c3lbbZMl1gQa4ODnfafIo/TRlM/
	t0g5rap/6Qsu/OMuah3aqrNYGQj/CntLywP4d8ycFFQFQHy50cyapw6VDd7+kcrzZSyy7S71X3w
	vpCZTnvWbQTKaoRjVitxhtVF+FeWQWxDT6q+ELJXscuXwkuLP3SWLBHvpQJtpxK8sQ1iYRMM9hP
	JPBOlJ5aUDRIU3oiQErOKQ3uMPk6tDxLXulY735wmzZtrcDwvaImyW6Iezr6JotSsvQIOScTIAa
	ZLaypNehrxfqaDEQhp+TBhqSzV6RC84EEe2mijA/GX94yha2mOeoptvbNSQFw8IizaqWpwWuVGk
	VO6AuQAL0uqQ++APLLjEHFztPvclIBf3gMcAz4gKQNQEub66EVBAbqLbdP7eoehJ/aXJ8SAYusO
	3+TnbPMOgGr0E/IGxFVdHrIOqtdTxi5iRpRhY1aak=
X-Received: by 2002:a05:600c:b99:b0:495:4cba:e288 with SMTP id 5b1f17b1804b1-4954cbae4cdmr69628505e9.15.1784408340738;
        Sat, 18 Jul 2026 13:59:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed2313sm14322945f8f.23.2026.07.18.13.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 13:58:59 -0700 (PDT)
Date: Sat, 18 Jul 2026 21:58:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "John Ericson" <mail@johnericson.me>
Cc: "Kuniyuki Iwashima" <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Cong Wang"
 <cwang@multikernel.io>, "Simon Horman" <horms@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, "David Rheinsberg" <david@readahead.eu>,
 "Andy Lutomirski" <luto@kernel.org>, "Sergei Zimmerman"
 <sergei@zimmerman.foo>, "network dev" <netdev@vger.kernel.org>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, =?UTF-8?B?R8O8?=
 =?UTF-8?B?bnRoZXI=?= Noack <gnoack@google.com>, "Paul Moore"
 <paul@paul-moore.com>, linux-security-module@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: unix_stream_connect and socket address resolution
Message-ID: <20260718215855.07284fb1@pumpkin>
In-Reply-To: <e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
	<20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
	<e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jul 2026 15:55:12 -0400
"John Ericson" <mail@johnericson.me> wrote:

> In [1] I observed what I considered some odd behavior in unix_stream_connect():
> 
> > I was hoping this was going to be a simple matter of factoring out the
> > back half of `unix_stream_connect`. No such luck was had, because
> > actually instead of `unix_stream_connect` looking up the socket from the
> > VFS once, it does it repeatedly in the same loop that is used to deal
> > with full listening queues.
> > 
> > (This behavior is rather surprising to me, because it would allow a
> > deleted and recreated socket to be picked up on the next loop iteration.
> > But, I don't want to make any UAPI-visible changes in this patch series,
> > so I did not consider changing it.)  
> 
> I had said I didn't want to consider changing this yet in my patch
> series, but based on the feedback I received for a second version of
> that patch series, I now actually think it is a good idea after all to
> discuss this first, and see if it should be changed prior to my patch
> series. (This discussion will inform what the code looks like before I
> do my v2 patch series, and how big or small that patch series is.)
> 
> Here are two scenarios where the current behavior of
> `unix_stream_connect` is surprising:
> 
> File system version:
> 
> 1. server binds socket `/foo/bar`
> 
> 2. clients fill up the accept queue, begin looping
> 
> 3. `mv /foo /foo2; mkdir /foo`
> 
> 4. another server binds `/foo/bar`
> 
> 5. clients connect to the second server instead
> 
> The loop in question is within `unix_stream_connect` itself, not in
> user code. I consider it very surprising that `/foo/bar` is looked up
> multiple times during a single system call.
> 
> Abstract socket version:
> 
> 1. server binds abstract socket `@foo`
> 
> 2. clients fill up the accept queue, begin looping
> 
> 3. server closes its socket (or exits), releasing the abstract name
> 
> 4. another server binds `@foo`
> 
> 5. clients connect to the second server instead
> 
> For abstract sockets we cannot play tricks with `mv`: the first server
> does need to relinquish `@foo` itself. But still, the result is the same
> where a different socket is resolved on the next loop iteration in
> `unix_stream_connect`. I am not sure it is fair to call this a TOCTOU
> issue exactly, but it feels very similar to one.
> 
> The more natural semantics in my view would be to first resolve the
> address to a socket, and then loop holding that resolved socket
> constant. With these semantics:
> 
> - In the `mv` case, the retrying clients continue to try connecting to
>   the original socket, now at `/foo2/bar`.
> 
> - In the close case, the retrying clients fail, and do not connect to
>   any new socket at the same path or abstract name.
> 
> What do you all think? Is this better? If so, is this a security fix
> which can be made unconditionally, or, absent a real concrete attack
> vector, is this a UAPI-breaking change which is automatically out of
> scope, and would thus need an explicit opt-in mechanism?
> 
> Looking forward to feedback,

My $0.02

If you assume that the client isn't responsible for restarting the server,
then there is no strong timing relation between creating a new server
(by any means) and the connect request from the client.
In other words both the above are very similar to the client being
preempted at the start of the connect() system call.

What you need to do is hard link foo to foo1, create the new
socket at foo2/bar then mv foo2 to foo so that it is atomic.
But I suspect hard links to directories aren't allowed any more :-(
(Creating 'random' hard links to directories used to be 'fun',
you could get 'find' in a right mess.)

	David


> 
> John
> 
> [1]: https://lore.kernel.org/all/20260703073948.2541875-3-John.Ericson@Obsidian.Systems/
> 

