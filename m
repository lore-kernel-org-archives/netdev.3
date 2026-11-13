Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573296;
	b=tgW4WdboezmEreaGdLeed3c5YoXuld20sUz9AiJhoQH10+w2i9MLcVubKn1UEtNKZ2cH
	 V8Hp/ifbpto+MOUs6mKgD66cYkWwntrbUChVjjjZaogQjtU6JAcyz7MfYv/Rr5gA6V19I
	 A4aAME2mTAN9h1KZT0G4MskQ6WcwBGbPXTjMNhfCrTuROJgJeMUoPiufkyNc7Uev23mk/
	 A7T/zx+bPn7XHHdJKnHuCWjD2mlAuTIkP4cMwo13VAOgnPrI/Fg2ldy0WdrdiOymODgLs
	 IMT5VXHFuJ8qvBueGKxWVyXmVOfpWChqNJQwHerwswggVxqwdiOidV/Mo9zilN24Uzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573296;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GdBwEYUwKIbbSDjEIosuLoHDz8wh6BeTKAY0EjU0YOQ=;
	b=s94nzDMSwiwYnTj7qmy8a27ElCACRPl5u+UZRzMDDTPV8P6nqqStNAxNwDCXYB93ak5P
	 WNMwPA0xsrpnjp4qvhFe2wg5MXE5rqmEU5ryzj4C0CYol3CwuqWMWrNyPfJbJwZMg69rF
	 721GcynCZ6dnTLFOPvV7QOILvTeGWPD5A7xFWguZrpwvm+iUmtoRsh62hQZcmVmJYdAgP
	 z2/G+OJqYb1QXvBJajFNQjBBk/Wfd6UoSj0TG2NLLyfDQY305RHfEGSCNzuwRmaFc+Sy7
	 G6LzvgViOw+ALxXLIsBghDCgQd0UOosCc4m0p5ySBTMCHaESZit7Jt0OfZKvHJx79Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4dwE7em;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E84606A336;
	Fri, 13 Nov 2026 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4dwE7em
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC851F000C4;
	Fri, 13 Nov 2026 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573295;
	bh=GdBwEYUwKIbbSDjEIosuLoHDz8wh6BeTKAY0EjU0YOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H4dwE7emvGnOm4SO0qhbOZuWCUp0bXyMaPLOE1YbBpJtlts2wg1paUc4/lkN/YKD0
	 HMNVz/k+yJe+MefMQZNuu+i2Hssvi1R/IsI9HMVRaw3Bcjk5RkvJQgMmKlo1nU57v6
	 4UsgYMmxPlgt3GOrmArJI6lOjzbFs3zQcsinEJQxWiUQGgGnO8fTU6+q/Bk1u4uy8x
	 ZzOzlPUSnoUuxh4e/U5tpKWvqCo69fdZHL2o8N8BwSduMI0WWWSZKVodM1I9W+9TZb
	 gSO7aI+/f0yIiT4Z73KpMrNDhtp+BQ53vPwR8RgLfkJAGXd7sitf1HPZHjmx+Gx/p/
	 w9jO28NWdBqfg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xRqUW-00000002Alr-3uuS;
	Fri, 13 Nov 2026 13:34:52 +0100
Date: Fri, 13 Nov 2026 13:34:52 +0100
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
Subject: Re: [PATCH 05/14] docs: security-bugs: explain how to send a fix
 that can be applied
Message-ID: <avcD7Dvj-HXQmziQ@hovoldconsulting.com>
References: <20261109080240.29444-1-w@1wt.eu>
 <20261109080240.29444-6-w@1wt.eu>
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
In-Reply-To: <20261109080240.29444-6-w@1wt.eu>

On Mon, Nov 09, 2026 at 09:02:31AM +0100, Willy Tarreau wrote:
 
> +Sending a fix
> +~~~~~~~~~~~~~
> +
> +Most fixes sent along with reports cannot be applied as-is, because they were

I'd drop the comma after "as-is".

> +damaged by the mailer or lacking a commit message, forcing maintainers to ask
> +for a resend. A fix must be applicable using ``git am``, which is most easily
> +achieved by letting git produce and send the messages (see
> +Documentation/process/submitting-patches.rst).

Johan
