Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572226;
	b=tJfCz+esJATUZasej0qRClvDmqiJ7yjQ5eEYKc8JiC+2lW7Fj3gCDqanHk8MdlwSL5+R
	 pCBkVAVfC29CLr5HSZ9kGDoVmFS3wYCD36CBF6zR1s05THHd6jtNIzdJ1YpfBPTGyGVk6
	 n0FMshHyvi2yG11tDpjhnpYoBmfdSLVOOvoMU6b1EOfBmzxXuWVmLa87dtgZK00WhFI5y
	 80YYaqoL0OpAiHR4lqIaugrqRhSBOo0pCCY1cmgOiaQgukUO35s1FBTqRc5YoU5uwA7Y5
	 c/bIMuzRb/WM9iUo6agY6nfsZI7aGPz9S4hRjeC0STEZ5L8n+zuT+ybKJlGLQb+lM9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572226;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gMNZIhJUy45+bLtHPJViVH+RoArxXfnidm2oR4cfTA8=;
	b=qtGIkNUzT0b3einqmbjRlyWARPUk9taJxblkuJoW/a3ILWUzCH1zeD9XYg3ccLOuIlOk
	 D7iD2jfZCccTD0//EL+UrO6BwtD/BBxt/I21EVJ9H7VXgoMG6WdJtk6JuDGvfPXvs+76O
	 fpnhPOFaeIR2XgLWaz6ZWMqkyJ/am5Uz83xbCk5urxY7SOFvnjweNPcNo8abotTw2uyZ8
	 eO1xmNau9+ygrfhv78+w8WmgVb0MOb8jOqVrDf1XmnI7tbiClBEgPlI87VOF5Wn6ATn1X
	 tPZt+JktB3vFNTkBmeQUVDS93XtyqKIBWNUbvSbwC44kaLkRygkwZscc33AsYq+ZLyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9W5jiG9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D2606A31C;
	Fri, 13 Nov 2026 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9W5jiG9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C560D1F000C5;
	Fri, 13 Nov 2026 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794572225;
	bh=gMNZIhJUy45+bLtHPJViVH+RoArxXfnidm2oR4cfTA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J9W5jiG9Fwv/IVu9EcOt6QMOiWwQJ8xxCK/WPzloEN9cbllxvw1eNzNsjt+i9j31M
	 xvBD0Bo9tEbdf0KtCaYfziLxRUhpI4BP6XGifCSpT13qEW56XqFwrQUaLdbhxC2DeN
	 I6e8qTcKtG6nWKki0JnaGt43F9AC7SEVP0hEK9iWzWVeQp55nnq55Wu0BhNF9z/BQF
	 eRSZ5yZKi0EP4bhmu3VTR4MuueO/oBtSvzqXb5vSoL82BrfNouzxF99qqu1hajit1U
	 MiZxaaEwgFgDVADojAJZWiSzcJumrR+OIZBw8LPbIM/u3h+a7uHvBQIOjOk/8Lsfwi
	 5iMh5343kypGQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xRqDH-00000002AW1-04rf;
	Fri, 13 Nov 2026 13:17:03 +0100
Date: Fri, 13 Nov 2026 13:17:03 +0100
From: Johan Hovold <johan@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
	Randy Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, gregkh@linuxfoundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 02/14] docs: security-bugs: clarify when to Cc the
 security team
Message-ID: <avb_v71CXTsqEKXd@hovoldconsulting.com>
References: <20261109080240.29444-1-w@1wt.eu>
 <20261109080240.29444-3-w@1wt.eu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109080240.29444-3-w@1wt.eu>

On Mon, Nov 09, 2026 at 09:02:28AM +0100, Willy Tarreau wrote:

> @@ -250,15 +250,36 @@ equally be forwarded as-is to the relevant maintainers.
>  Copying the security team
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -The report must be sent to maintainers.  If there are two or fewer
> -recipients in your message, you must also always Cc: the Linux kernel
> -security team who will ensure the message is delivered to the proper
> -people, and will be able to assist small maintainer teams with processes
> -they may not be familiar with.  For larger teams, Cc: the Linux kernel
> -security team for your first few reports or when seeking specific help,
> -such as when resending a message which got no response within a week.
> -Once you have become comfortable with the process for a few reports, it is
> -no longer necessary to Cc: the security list when sending to large teams.
> +The report must be sent to maintainers.  You must also Cc: the Linux kernel
> +security team in any of the following cases:
> +
> +  * it is your first report: many first reports are incomplete, too long, too
> +    strong, difficult to handle, and put a lot of pressure on maintainers. The
> +    security team will help with the process and with the qualification of the
> +    issue. Note that this rule also applies if you were asked to fix or adjust
> +    a previous submission;
> +
> +  * there are two or fewer maintainers among the recipients: the security
> +    team will ensure the message is delivered to the proper people, and
> +    will be able to assist small maintainer teams with processes they may
> +    not be familiar with;
> +
> +  * the maintainers could not be clearly identified (see above);
> +
> +  * the impact of the issue is uncertain and needs to be qualified. In this
> +    case, your must clearly state upfront that you are seeking help to qualify
> +    this impact, and you will need to share any information you have;
> +
> +  * you are seeking specific help, such as when resending a message which got
> +    no response within a week (and please do not ask for feedback before such
> +    a delay, some subsystems have a long report queue, and some maintainers can
> +    only read them on spare time).

I think you reword this one in a later patch, but still:

	s/on spare time/in their spare time/

> +
> +In other cases, i.e. when a report of clear impact is sent to a larger

This perhaps reads a little better as:

	Otherwise, when a report of...

> +team of clearly identified maintainers, it is not necessary to Cc: the
> +security list.  Never Cc: the security list on a message sent to a public
> +list.
> +
>  The Linux kernel security team can be contacted by email at
>  <security@kernel.org>.  This is a private list of security officers
>  who will help verify the bug report and assist developers working on a fix.

Johan
