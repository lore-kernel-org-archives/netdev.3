Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C040DFA3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705167; cv=none; b=TMsw4x9TUMt3geAIVVUR03XCMdi6chmC3fEwYoBCrUuiUxm905WdRoV+ngIMnG3fsRsHUckbct13+9tLO7OI06dW4Mn4FHADPqCt7LWdwUCQZGYXQRxtphwgi7F4hieyXwZABs1kT7BYkpQ5PiZsKmn8eHwitSdfWoEL247uzDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705167; c=relaxed/simple;
	bh=uJIAB5aQK5warnNdya8/fwYBHVjoZDLyZkCYyd2WN6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTwLi12+yV7IH3in8MLvWMf5oR7wxRrln8IHsD0Uaram4bVXlmCOB77ZH7x9RBD1S+nalnLqksfE+v+oc2EPHTP8HgQ6oRqyJ/7oubSwPhISzfDDLHTEytKRCfueOccRhBx5BtM22QuTSRfpZ2GH1oGDVg6nFag9WZoLytDA+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWpYI3Fz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWpYI3Fz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so28396945e9.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784705162; x=1785309962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yG1zyrx4ZGGVITfwIyi0juPEmhwYGA6Wx/gAK25GPak=;
        b=qWpYI3FzsSc4fl9eNit1vGBjmgtXAAo2AMeTHowX3HD/5a5GYS9DzsQG+H+zbM651e
         /aetiIvH7fHdxrCSehYgSOfr2XzAek1fl+kSb/oWXrBKpJAFQpT/ybliX19WgnDUTQKQ
         /g04gI/sHhbJ+CXK2ikiAFeagDcRhGyPktXL17xPjMrKN0s9zjSwV9km9ulOpDuHSh50
         pwnjVFrlSShXKOztKBkpduCZhrqbaEA4+CI8icnflU6Feo4qwRDzdjLtae//3wTd3HyQ
         9WGTpSXuVclR3eklCj8nm98E2P71LzXDXYLuzr56EgF/JtZ5duAgLl+qcE7GLz6v+6QN
         4w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784705162; x=1785309962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yG1zyrx4ZGGVITfwIyi0juPEmhwYGA6Wx/gAK25GPak=;
        b=se/EWIT6IPzmxY1lr1WAXeH/Sv+k5jmx+6cyd09xYW8jXufpVfHRub9XPGedTwSCcm
         Z6uF9gV9/ofzTa04dyQjr3ZiF3JXImG0bMwIMwNOGoS4VlHsU0IS0SnAPRaOAz4W5p6L
         FlltQOL5i62sFSpaCc+0YSZfx6/Dlh25/UPyCRcJj0QUAr3lVX+MhU53+2tp7Cq9gJQu
         3oISekU85rvtkxvYj2VliZ1gZkZ3fUYTAlPp1WvDHQOtqrcEWcHRhk5PfU8nCFmpQvs9
         qMhtV2XIFPP6rK6TFQAQ9UZ0QluhRp+K2d+7frcYHNwiszwaCJ2pu71A+wXmPk41ekFc
         G2pQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6/U9Nd0V3PYin6RKs7kg7HcdYPkxBrSXyRTsqF8vF/ixf8F5bIqDKnfMN2aPtvrAusWVgiP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPFwF2lgIA+ugsvDJgRrcLOGv3lABGLitRfcfU73m43MMYCpe
	vf1j9uXefu2mUjA1NJYzRo0WZsIJOzjNbh8Tyy+9lHGlrsjVDB6F9dUa
X-Gm-Gg: AR+sD119TtXwQo4qWvcEn53v46GjBVbA6azLGDbyhQ7SQVblDGmZJg3RzmpznSx9Ndt
	i2bvF4dizTqzvQ0tP6Y1HjWZpRFwqSQZGpgR3aU5mAeV3T/MWDYJbsZ5fWq5fKUXn0kxRof2q5l
	UpCQNeKW1JSpIl/jbfdyi5b/hvhJmXzaYWOavTcL9jFQ15b0yuSefqaMNDDPm0V8zlSn+k4IUTg
	ONhGWgy3fus45zDHaJVGF89mFZBIk1ddr6P6XuRV/C9P3r6VPXvQ5h4BvMlEa5tA3Godr2ATVF1
	Rj5CEjp47A2YLGmc5OUaL5pgjYdnb+hZ79GR9X9LpzXRTH11c6DLkxPpsnsIu1Bx69gQZkK39+7
	+GWCyylQoyj6Prw7gPN4wRd3HIoVso9ZWd9LQr1fZ/0DNKRLGlOb20UId3nCJxkFqz8bprYJxos
	ohDN7QJRH/9M0z8S47i/FXvBdIH1nHXXSDUI0OOQ==
X-Received: by 2002:a05:600c:c84:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4954a3ed426mr236754125e9.10.1784705161604;
        Wed, 22 Jul 2026 00:26:01 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956537c7desm176881885e9.7.2026.07.22.00.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:26:00 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:25:59 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: John Ericson <mail@johnericson.me>
Cc: David Laight <david.laight.linux@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Cong Wang <cwang@multikernel.io>, Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Andy Lutomirski <luto@kernel.org>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	network dev <netdev@vger.kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: unix_stream_connect and socket address resolution
Message-ID: <20260722.bfca37efd700@gnoack.org>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
 <20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
 <e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
 <20260718215855.07284fb1@pumpkin>
 <85991dc3-6fa5-4466-a0cb-b407291cdb44@app.fastmail.com>
 <9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>

Hello John!

On Tue, Jul 21, 2026 at 04:37:07PM -0400, John Ericson wrote:
> In case this is useful or interesting to anyone, I deep a some history
> spelunking, and the restart logic in question seems to date back to
> Import 2.2.4pre6:
> 
> https://github.com/tbodt/linux-history/commit/7d4fc34b9bbc0a14d3e5f6b2f978373422e1ca8a#diff-0553d076c243e06ae312480cb8cb52f1cebe1d80fc099d3842593e12c9e0d4f3
> 
> ---
> @@ -673,9 +703,25 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  	   we will have to recheck all again in any case.
>  	 */
>  
> +restart:
>  	/*  Find listening sock */
>  	other=unix_find_other(sunaddr, addr_len, sk->type, hash, &err);
>  
> +	if (!other)
> +		return -ECONNREFUSED;
> +
> +	while (other->ack_backlog >= other->max_ack_backlog) {
> +		unix_unlock(other);
> +		if (other->dead || other->state != TCP_LISTEN)
> +			return -ECONNREFUSED;
> +		if (flags & O_NONBLOCK)
> +			return -EAGAIN;
> +		interruptible_sleep_on(&unix_ack_wqueue);
> +		if (signal_pending(current))
> +			return -ERESTARTSYS;
> +		goto restart;
> +        }
> +
>  	/* create new sock for complete connection */
>  	newsk = unix_create1(NULL, 1);
>  
> @@ -704,7 +750,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  
>  	/* Check that listener is in valid state. */
>  	err = -ECONNREFUSED;
> -	if (other == NULL || other->dead || other->state != TCP_LISTEN)
> +	if (other->dead || other->state != TCP_LISTEN)
>  		goto out;
>  
>  	err = -ENOMEM;
> ---
> 
> My question can be basically restated: why should the `restart` label
> not go *after* the `unix_find_other` call?

To elaborate on David Laights answer -- the classic way of restarting
a Unix Domain socket server is that the server unlink(2)s the socket
file and then bind(2)s the address again.  In other words, when the
server restarts, the new instance offers the service on a socket file
with the same name but it's technically a *fresh* socket file.  So a
"normal" server restart is not technically that different to the
example you gave in your earlier mail (the "File system version").

Another variant of this is one where the server uses rename(2) to
switch out the socket file atomically during restart.

I was not around when that af_unix code was written, and cannot
guarantee that by interpretation is correct, but in the hope that
someone will point it out if it's totally bogus: My interpretation is
that the "goto restart" loop in af_unix.c is designed to smoothen the
server restart cases in a way so that the client doesn't have to deal
with manual system call restarts.  That loop needs to include the
repeated vfs lookup so that it actually gets the socket that belongs
to the fresh socket file.  (Otherwise it would just observe the same
SOCK_DEAD socket from the old server process again. - The new server
serves from a new struct socket.)

Example Scenario, where a client connect(2) races with the shutdown of
an old server during an "atomic" (rename(2)) server restart:

* Old server process serves on /foo/bar.sock
* New server process starts up
* New server process binds (and creates) /foo/bar.sock.tmp
* Client runs connect(2) to /foo/bar.sock,
  does the unix_find_other lookup, getting the old server's socket
* New server process renames /foo/bar.sock.tmp to /foo/bar.sock
* Old server process shuts down, socket transitions to SOCK_DEAD
  through unix_release() -> unix_release_sock() -> sock_orphan()
* Client connect(2) syscall checks the socket and discovers the
  SOCK_DEAD state, because it still holds a pointer to the old server
  socket.

To recover from this, connect(2) does the VFS lookup again, because
the already looked up dead socket isn't coming back.  The connect(2)
function pretends that it ran a tiny bit later and only observed the
new socket.

In this scenario, the userspace server is already going to great
lengths to make the switch atomic - it would be surprising IMHO if the
connect(2) operation could still return errors to userspace due to
race conditions in that case.

Again, this is just my own interpretation.  I also did not find any
better documentation on this.  If I am wrong, I am more than happy to
be corrected. :)

–Günther
