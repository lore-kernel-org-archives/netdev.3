Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421190;
	b=MdR3vh6afqCWGXp5jp0Bg1TELXfNyc6hzFKr5hmabfItUBDrT7OD6U4PctZQzeNpkGXm
	 BiPcw4FRy36YSWonFn5YbaK2Ao5d2dCKg4pGa7eU6a1eH7qmfF3Xv3Xn0+290duMZcZ3N
	 T5246od4unJcE3YsvTLgL2e58MD2UF3f5AxiZQBWwMr5frEoxccpj779JnhgrQJJKvIRj
	 h5aGfLyeybo1+sfNl6WoPA+7yVqBSMmYOhoTX7fDQYIupYE+2xd4hI+qqIonqaq64Pjp1
	 t9/SmNZd22ctTcAOGpilm/cx7k7/qGMhjM2G3F+P6bV4jHentzhbAi1zUSIuEEIlQaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421190;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U+Dj0snY+kfTXfG+VRMdB3cQPdoVXWSwHQgeJoQUXLU=;
	b=Yoch6zkiPNDU6XcxV1AUoVqh1Te2+mA0Est8F3UbGQpQBGOn7jNfUEMaYCUZXDA37VQ2
	 2VjVsihObLos9uZDaOLxDXnYBAZla6RQrQsT8OHjA6nifUccsAyLSQilOrSdEXkIDFNQS
	 56z1nwtaJUzwX3lkXLG0oXd+/4GiSWuil9xKzRqwoGVxx7pbVyCDeTxjb6EMP7FvFWH3b
	 YLo7FWXKFUYEzLmSjvue86nhEIcDZV6Ij8aTdR8Kb4/ZIbZ4ypMyVDfTKQiEh8kEsBYk7
	 r2xY9mbi79qe+EU67RE353EBewJK6ptoXGCCch28y8QYpqQsj66VEEU3lGNZdYN+4Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="LwRHuO+/";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qG3gFHcN;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD4606CB2E;
	Wed, 11 Nov 2026 18:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5FD4606CB2E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LwRHuO+/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qG3gFHcN
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794421188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+Dj0snY+kfTXfG+VRMdB3cQPdoVXWSwHQgeJoQUXLU=;
	b=LwRHuO+/ZN3tMg7NzfH3ajl6QJbbQDyuwnRI8WUxJd3BZtXtXxqtT+geKnGJT41TtnFF8v
	mVdarGKNZnjTMwmzvZfklNpb9HUKskCl/8+IFYsDEPMV7oevfPtPVaJdd+P2zIKiPm7q73
	iHPsYb4KZ0MDwS2RyGtZslnuIRQFFl7ZKXwvYhkfQ1raBVU8ltwEEClmA9x4OsTbGxFqsn
	sNUkYf2Reh98B7+UoP08JUzlsHJgW0Iud8i85UD/nY7/ZR5xXTKRiZU1wK7pqpa/SyfagG
	yWjOoEJdyEZx2hEjd46ZW4J17hyi1zm9HsyQ5pWUylsvKkTm268Q/cM7rv5v/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794421188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+Dj0snY+kfTXfG+VRMdB3cQPdoVXWSwHQgeJoQUXLU=;
	b=qG3gFHcNdGqoZspX4hgqVVSm+WQcAQnmGZuHf1C0UKAY+NZ9pcFr+x5Z8KWIHv6Onlm/Sn
	5U6rMEfxApR41TCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>,
	printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gustavo Luiz Duarte <gustavold@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH printk v2 6/6] netconsole: Always perform unsafe flushing on panic/kdb/restart
Date: Wed, 11 Nov 2026 19:25:22 +0106
Message-ID: <20261111181942.593695-7-john.ogness@linutronix.de>
In-Reply-To: <20261111181942.593695-1-john.ogness@linutronix.de>
References: <20261111181942.593695-1-john.ogness@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a legacy console the netconsole would perform unsafe flushing
during panic/kdb/restart. With commit 7eab73b18630 ("netconsole:
convert to NBCON console infrastructure") the netconsole is now an
NBCON console, however it uses the CON_NBCON_ATOMIC_UNSAFE flag and
this prevents unsafe flushing except for at the very end of panic().

Enable unsafe flushing policies to allow the netconsole to perform
unsafe flushing during all panic/kdb/restart variations, just as it
did when it was a legacy console.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/net/netconsole.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 267254f046de9..6c1587958e915 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -2695,6 +2695,8 @@ static void free_param_target(struct netconsole_target *nt)
 static struct console netconsole_ext = {
 	.name = "netcon_ext",
 	.flags = CON_ENABLED | CON_EXTENDED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.unsafe_flush_flags = NBCON_PANIC_FLUSH | NBCON_PANIC_PRINTK | NBCON_KDB |
+			      NBCON_NORMAL_NOTHREAD,
 	.write_thread = netconsole_write_ext,
 	.write_atomic = netconsole_write_ext,
 	.device_lock = netconsole_device_lock,
@@ -2704,6 +2706,8 @@ static struct console netconsole_ext = {
 static struct console netconsole = {
 	.name = "netcon",
 	.flags = CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.unsafe_flush_flags = NBCON_PANIC_FLUSH | NBCON_PANIC_PRINTK | NBCON_KDB |
+			      NBCON_NORMAL_NOTHREAD,
 	.write_thread = netconsole_write_basic,
 	.write_atomic = netconsole_write_basic,
 	.device_lock = netconsole_device_lock,
-- 
2.47.3

