Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FF3EF0C5;
	Fri,  6 Feb 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386931; cv=none; b=Z+MGAaAlhwD4R3Urb7HsAo+r6IXHuoRoEo/n/fEVjgVgTr1R/GXToH4ui+wQthn1fhv4peFS/8u8nDsTf1ho6c0RMvWwjJ/ibwHbtYmVlEVxYptClFC4+6zq7GOTM1bFiBjko+kPJz1sMJUTy5oIdCXHc9SmcTMfK4V9tuspEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386931; c=relaxed/simple;
	bh=ywKby6j14Zksa17L68vte/Gr8DbLBzNeqKKXCE322xM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnpEsM2xEgC6HTyAnCloKMhsdqr/HQ2bg8OUFJC6uLRXYJs4ANJhh1ofBTq1lqeIo1LY9fUaPOOJ1FEdHpWK6KRXwOgUfBZ/pdERYCWNUCQkwzz+qmmSdf0WKWTUbfbU99SNGaS4NsZw127DH1LWJorbe7ssBgYIhbaMKvlSRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QTGC55fM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nq/Sxv3N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QTGC55fM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nq/Sxv3N"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770386929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywKby6j14Zksa17L68vte/Gr8DbLBzNeqKKXCE322xM=;
	b=QTGC55fMPtVb5uERcT5fHoOQ+uCHPE8G7KGb6Nmg/l3fcXQLjjmGW+5+9Xd/L9bNInZax8
	e9KQ+Z96VOLxDEn823bVXf2j6DX6eodB9K3E4OULsbSI/39OGx+6nFRPLDQONV+kJSN1GC
	FdR7DquSAjBV+KPX2+NDzPpTL7fUgsF3p8Jvx18/2sKUbgyG0B6u+lMRVRdCL5hSxSrWs+
	RDxEwuAHlOAwrXrR39LrQOX1OPCMYzfOhEXi/SROvtgAWQiutNXBAW9nn+KQGJZaIDGgFs
	pJX6l1iILcEIUuQtoQO0I1JFYC0isWqHetEFA+tpZXxzuRF1UouJionA3GWGlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770386929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywKby6j14Zksa17L68vte/Gr8DbLBzNeqKKXCE322xM=;
	b=Nq/Sxv3NKTJ1ebB/RjhE7HQiflAVvr8NZwXOzrIxWtaxyXvOdF1AKD2OalYjjjyegV+/80
	XB4FB0vTCV9nXCCQ==
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
Subject: Re: [PATCH net-next v7 1/4] printk: Add execution context (task
 name/CPU) to printk_info
In-Reply-To: <20260206-nbcon-v7-1-62bda69b1b41@debian.org>
References: <20260206-nbcon-v7-0-62bda69b1b41@debian.org>
 <20260206-nbcon-v7-1-62bda69b1b41@debian.org>
Date: Fri, 06 Feb 2026 15:14:47 +0106
Message-ID: <87ldh6klqo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-02-06, Breno Leitao <leitao@debian.org> wrote:
> Extend struct printk_info to include the task name, pid, and CPU
> number where printk messages originate. This information is captured
> at vprintk_store() time and propagated through printk_message to
> nbcon_write_context, making it available to nbcon console drivers.
>
> This is useful for consoles like netconsole that want to include
> execution context in their output, allowing correlation of messages
> with specific tasks and CPUs regardless of where the console driver
> actually runs.
>
> The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
> automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
> the helper functions compile to no-ops with no overhead.
>
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks!
