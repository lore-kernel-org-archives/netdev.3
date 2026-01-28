Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577E291C10;
	Wed, 28 Jan 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611769; cv=none; b=EbbUHg/IHUXL9H9n2jBuwYyDu5V6n+bLcsO2MWcAXNfaWAZNwO1b5kQSujhHxU7+ECU5B2oJ7oYM2uLqbuMP+Axl+3EBkeUtyRbtlU+2IXOC23oX1tSvaU5yPxo5G3mqJH3FQFmq2oeZkD3MlXd0iBQxUsdrziArtdZLTgQrpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611769; c=relaxed/simple;
	bh=Hl7r5ottBqn33zr/iQl/s1av+yp/dTMhuQMXmo41TKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Py4k86TZQHk0ZnsSvOdfMCd+IB63ZEz9BWns+5PrOlUMaIqt+iu5Y/R0IEIibtmK4ENIAD03jziZXEWZ8xcj4BEtQ/Eo4hBV8OYFKXoCsT8SUW0QGfC4AuTrVGLumbkXTfAeIvt55VqRw6skPS3ts8DXJIomoyBt47TH8iKbw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bm7geCmB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hUbDdIBQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bm7geCmB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hUbDdIBQ"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769611765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/vWGICoApFxtNEDE/sAHqakShwhJUuziA/CPjsJAHY=;
	b=Bm7geCmBy7EUBx6Vi917C27yI2OyhB6AkK01DNF6e1IOMM1VU91yy+feIrJUJaANmEDoIa
	Qalsd6pvLGBijJwXlksl4c6BXf3gViwMY3I0M4/jfFIUpBIjWM5ASZlQQBuuhodNUA67XL
	CGIgzNzBbY1iuNgZgs11uye0Yb7GoVxznF9RufYt1P7yPyF/fJ3z/Xqlenow9353VbNv/D
	Fz42M9QHjfxTsbjhlOwWRpG3qR2kvEnJ2MskTuRI/7Cib/oP7VYA780WZWou8vHHKiZfPg
	vjfbP0+oxRPv6Z6L77d1lYqvN8BuwcBQhNngTXfJjIVJDQGUfO7kZWzLyAd5jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769611765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/vWGICoApFxtNEDE/sAHqakShwhJUuziA/CPjsJAHY=;
	b=hUbDdIBQDUCgQmGAk6GekfwdWIT1d/SFeV2Hu+axTwqkzNTmsIa/Wer6ePQaqpo7if5qvC
	ebQNXeatN0OHcqAQ==
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
Subject: Re: [PATCH net-next v5 3/4] netconsole: convert to NBCON console
 infrastructure
In-Reply-To: <20260128-nbcon-v5-3-93b4ddbc181a@debian.org>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-3-93b4ddbc181a@debian.org>
Date: Wed, 28 Jan 2026 15:55:24 +0106
Message-ID: <87cy2tlrm3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-01-28, Breno Leitao <leitao@debian.org> wrote:
> Convert netconsole from the legacy console API to the NBCON framework.
> NBCON provides threaded printing which unblocks printk()s and flushes in
> a thread, decoupling network TX from printk() when netconsole is
> in use.
>
> Since netconsole relies on the network stack which cannot safely operate
> from all atomic contexts, mark both consoles with
> CON_NBCON_ATOMIC_UNSAFE. (See discussion in [1])
>
> CON_NBCON_ATOMIC_UNSAFE restricts write_atomic() usage to emergency
> scenarios (panic) where regular messages are sent in threaded mode.
>
> Implementation changes:
> - Unify write_ext_msg() and write_msg() into netconsole_write()
> - Add device_lock/device_unlock callbacks to manage target_list_lock
> - Use nbcon_enter_unsafe()/nbcon_exit_unsafe() around network
>   operations.
>   - If nbcon_enter_unsafe() fails, just return given netconsole lost
>     the ownership of the console.
> - Set write_thread and write_atomic callbacks (both use same function)
>
> Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
