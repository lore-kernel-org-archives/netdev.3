Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032438;
	b=SLuaOvj29Zg0b0hdOyp8dh/HwYuLWEqse8Prrgi05d9X3FdBi03it6q1hO99wUSykIfi
	 479EVSPdHbxQ0BD3c69qRynhHUxHlBcxQNYVZjH1ASDyXwxp0bqBh7TSqyGbKm5kg227s
	 bwBpF/Ue3N7HxSaeXXndnaH3wWT9gDcqucezhl9gyKtber7WBOHMD29ORn8dqx5mvwBg0
	 a8ZVpb2nbZk35N1DqA2duGE0j7KUVrWJUTW8Yjs9IQ9iBQKRd8E9qZNgtUtileoe7BDFf
	 +dF3/HQOW5qsuX+gXUBmfAYg4Z35lQM2LCsdBqgE2vUuaEem0RjIa0dywmsMU4vTiBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032438;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=4bbi5ZDYjyZH4Tu/Y/XLUEpo8GjU1EDuQ47hyKKJWNI=;
	b=wlJ97zznzHCqDd04Q+V/58P2C3So0oAf0ZGESi4uezzn1xTf9mmvMY8ddV3uDfSUFmov
	 WDrSCtgQO/DL0XQCwj3ArJ2HSihVmwX4AfCDDVE8mLIJ/+IeE4qPx0lzhYjFto5un0b/G
	 0X+RbncEm16Uz46vakzEf9UexRSv/RQPMeKfcPWEXB9as1BmdEuPuL9GMu77bKIKag1Pn
	 0azOahBrD4fm+/qTC7fTzFS3QimURU6dIzsV5WwBzlFO7Q2/S9XG2+GY03ClULVY5vOv7
	 42WgzPBvcaynoL3TOGKrVoHniTOTtfw9GSYHrYgn5h1YFGQ3V02ykwWilXtH4e6jvVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wt7EV5RW;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=3bleRp7v;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7789606A31E;
	Mon, 26 Oct 2026 16:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7789606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wt7EV5RW;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=3bleRp7v
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793032435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4bbi5ZDYjyZH4Tu/Y/XLUEpo8GjU1EDuQ47hyKKJWNI=;
	b=wt7EV5RW9Rzfw1nXP7UkC5TIRfJHPG6iy4JE8vXSSGS5dv43Rjno+9KJOYE7B4Xvx1ScR4
	klocIYf5GzTJaLg4QuV+q1YSqDdAvEoE7L4wTrL86vPsYvZQvUuv3oxVc+VThcOoVSVnLO
	dcH60PCYJXw4BuDAvrbIwntoEeo4BJte8mOZjPxtscZDzJyJ8bN2UbUT9agGJ1zIU6WZtu
	kpyOWDgwBJEuHSRu8eNQq9LmxVUYOIeM7X2x6XNowiguguWUYt99X3myJ0ItS548TnV5sM
	S6a4ipnU7Vte7b7z4d1al2BPrqvwfAVCy0dQC8JlSy6RNUAQCip+n1h7uHEaUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793032435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4bbi5ZDYjyZH4Tu/Y/XLUEpo8GjU1EDuQ47hyKKJWNI=;
	b=3bleRp7vVaPaXa21CiUma3MxPks+Kk4koD4akBrrEiJJqtZwXjMJWfoHoPbCmkCkzfHhW4
	28TLbVEwhCDoySBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Breno Leitao <leitao@debian.org>, chris@chrisdown.name, Sam Crossley
 <samuelcrossley@gmail.com>, Thomas Gleixner <tglx@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
 <rdunlap@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer
 on demand
In-Reply-To: <at9qgBucVm-QHnye@pathway.suse.cz>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de> <at84qygscue8crQi@gmail.com>
 <87a4o0k3qa.fsf@jogness.linutronix.de> <at9qgBucVm-QHnye@pathway.suse.cz>
Date: Mon, 26 Oct 2026 17:39:54 +0106
Message-ID: <87zew0ifpp.fsf@jogness.linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-26, Petr Mladek <pmladek@suse.com> wrote:
> The "replay" approach looks like a big hammer. Many messages might get
> duplicated, especially when the outage was small.
>
> A better solution might be to do not increment con->nbcon_seq
> when the transmission failed. And try it later again.

Note that there was a time during the rework that we used to allow the
console to return failure but decided it was too complicated [0].

The kthreads are setup to stay in their printing loop until the backlog
is clear. Having a nice=-20 task busy-loop would be bad.

> con->write_thread() currently does not return anything. I believe that
> it is partly a historical limit. Two problems come to my mind:
>
>    1. There used to be a global "console_seq" counter which was common
>       for all console drivers. But we have a per-console counter since
>       the commit a699449bb13b70b8bd1 ("printk: refactor and rework
>       printing logic").
>
>    2. There has never been a try-later logic. But is should be easier
>       to add it now. We have the kthreads. And even the legacy loop
>       is able to break when there is not progress.

I suppose for only the write_thread() callback we could implement some
sort of throttled retry if the console driver reports failure. But this
is assuming console drivers can even detect if it successfully sent or
not. The netconsole certainly has no method to _know_ if the UDP packet
was received. And UARTs (asside from flow-control) also have no way to
confirm that the other side received the data.

Breno and Sam simply want the user to trigger a replay of the full
log. Essentially a sysrq-R but per-console. I think that is a reasonable
request and certainly much easier than attempting some sort of
transmission guarantee.

John

[0] https://lore.kernel.org/lkml/ZdTCZqhZww8_WgSU@alley
