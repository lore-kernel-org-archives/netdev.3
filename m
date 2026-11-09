Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227495;
	b=5stgj6gAuvA7FNLrMhP+PZjkFCm38gjyDtfDC/GlWTUHIsBsZkLJV3fo8uZr9WYoAGyd
	 dw1yTFUt2SNinssdcDRKednMfOocLOii+XNbNFLv9bhJ8m77oAh0xJT1nXWaWZnde1AMU
	 hMFCCsRZNvMdPpD8enGPbStlGEznFp8Yae/AQjeyE7vd5zF/Coc/GRFbgcg33Jsg/QxXO
	 GRJDnmFtpmVbA66Z1fra24+1SiSD6KNt4p0mSUmOSZcOIo7+l/V0Z045cSP2nOfCnTbwO
	 HHyEHGo4SOjfVKj1GEafQtxKoBdhottVBg4KFMeYBgiuL8J0QAL06V6TXwIv2Ak4cHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227495;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U+Dj0snY+kfTXfG+VRMdB3cQPdoVXWSwHQgeJoQUXLU=;
	b=UzT/hdAOQP+ksuIUkmlQ28go7qLxeNVidrG4jmMAHRtx+fNd58PMfaRHoj3UGuHCCNwx
	 Ntl6eQTdSJ4LBqkPSpCQwTjyuFWckwz0k8IFSDUu+hml1As0FGJ4yV+Gzzn/WuT8OH2fO
	 Di+AQVuFFUcw9D52LU0UIkAuM+SA1Xf9K4SomIhCXjQeXS5nL6wYSkzWHNUkuGCHCue+D
	 LpFvmBhbtzBHu5DQbf/oRduhcZTgitPjGmVWO3bgvwokvZc4lu82qaMwBEY34uTNn3Lge
	 tI1CCTXyxVm0iVgPo6cfNYVmyFy1OTIxaDkrQ+ybiGjHxZc4KaKF5+veXciVw9KTJYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YGDzl48j;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6xr7PFmf;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23941606D817;
	Mon,  9 Nov 2026 12:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23941606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YGDzl48j;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6xr7PFmf
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794227492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+Dj0snY+kfTXfG+VRMdB3cQPdoVXWSwHQgeJoQUXLU=;
	b=YGDzl48jYxHNdQWqwzNV5+QEK5o2Kg+YtE6I5R275wGjN0HYtjQdCgRd5ky/lY+rhD0Qeo
	tHw/E1efPQUfsZ/jlNeTR1oxqYCbkOZGnVg+Uq5Vv8wfKDDtqGaZn/WrDTF9WeWxAURlEB
	pcZqWoViGMQFsNmPlbCpu+DOuuflw21r0Gnh9BIpQbVgawuzs5a3FXsauNOmusnTnQ70u7
	GgNqniIODXVigg0MAmdDaZbxdtD9DtTMXx3naSCdTZlXFr2nCt4AKRzJaVPU8/roKKBt6k
	gzvy1JaX2Opas0XDVcwX4MkVopbyv50xHXVqg7JKBGjAWakNamPG8CMCDsKaEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794227492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+Dj0snY+kfTXfG+VRMdB3cQPdoVXWSwHQgeJoQUXLU=;
	b=6xr7PFmfvnfZEgJrYF2lOI1GpwHyCQZKyXHko+03Y4661Q1+t74W76iQkYV+5jIqHY/Wc4
	2HCIiZcLDXSmuJAA==
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
Subject: [PATCH printk 6/6] netconsole: Always perform unsafe flushing on panic/kdb/restart
Date: Mon,  9 Nov 2026 13:37:23 +0106
Message-ID: <20261109123127.489676-7-john.ogness@linutronix.de>
In-Reply-To: <20261109123127.489676-1-john.ogness@linutronix.de>
References: <20261109123127.489676-1-john.ogness@linutronix.de>
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

