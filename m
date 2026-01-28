Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BA36921A;
	Wed, 28 Jan 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612595; cv=none; b=I+b/jqYbe5rvAU+78aWXZBeh2+0w25+z8SYiz2GJqa1U0Ke1VILUe+8RR4iuPFih4aMx73hd5WVXhqlHXpLLjesRc9FYKgT62FMkNDs//yLXERbHU1+Jk4pDxDDpTCEg6sPXhkDvLRjBVIdKNm90I+aLstopiWQzHGldy9A4qHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612595; c=relaxed/simple;
	bh=xRpDRDrCxNCkObRzzrBSD0I2Gthk1cFdrvbOvHKojPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ut5CA56T08K24rEql4u8c3/Dr4NGRBBG0gBEEyTJe3FQ56UYsv5wtEnJlgsmDJnFhfvYI7TFufBip8dWr8/6s+3+5WW/iRBB6LGXi+b37CUJVAd8eKI8DUBk5ybiqor0/4NkyfSWwLtE+bE1+VgB8XfI4sGODYLLRdPyQ+LXV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FexlDwVc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=03BL+UsU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FexlDwVc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="03BL+UsU"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769612588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRpDRDrCxNCkObRzzrBSD0I2Gthk1cFdrvbOvHKojPQ=;
	b=FexlDwVc0Fr+a940MD4BIoWOPtJfgWY4sjMYrBdP30oZGPDkOJWueJ22dhqPgyHhlGgkYQ
	b90aSKqtimrqjxaoWPoLVvmOpLfNrvZcTW6GBMsp7k3RgAk1wvvceqCVGfNv6d5jNG4tR/
	6L5fVuyOXMCsIxo4kPYPVEmSGi2hhmfiIDqpPTGj1c7gZJbtRjDW6loOlr+0qiCuHf92Uu
	CgnlYRv14+0HYcq18IpQpZtc4q0xJ6Q5/usEW0D0j9OKem7I8C1b/grClXqcudBb83RUAr
	+dtQNzPOsttMC4XlHrW9yhgkcbUhv1kIqdApz/fd4QI77z2UwwW86jVRmb3VlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769612588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRpDRDrCxNCkObRzzrBSD0I2Gthk1cFdrvbOvHKojPQ=;
	b=03BL+UsU9msPWGNGeqI27WB7SKIcntI1A6e7M3TDMUzzp8IlxgOmOXEVVDbu60tK8jJQPt
	Kf1oftIjUstpY0BQ==
To: Breno Leitao <leitao@debian.org>, Breno Leitao <leitao@debian.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v5 4/4] netconsole: Use printk context for CPU
 and task information
In-Reply-To: <20260128-nbcon-v5-4-93b4ddbc181a@debian.org>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-4-93b4ddbc181a@debian.org>
Date: Wed, 28 Jan 2026 16:09:07 +0106
Message-ID: <87a4xxlqz8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-01-28, Breno Leitao <leitao@debian.org> wrote:
> Use the CPU and task name captured at printk() time from
> nbcon_write_context instead of querying the current execution context.
> This provides accurate information about where the message originated,
> rather than where netconsole happens to be running.
>
> For CPU, use wctxt->cpu instead of raw_smp_processor_id().
>
> For taskname, use wctxt->comm directly which contains the task
> name captured at printk time.
>
> This change ensures netconsole outputs reflect the actual context that
> generated the log message, which is especially important when the
> console driver runs asynchronously in a dedicated thread.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
