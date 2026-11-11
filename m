Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421186;
	b=s3fD4q/luU6PLoTXEHqAW8wUfls5UfJusn3WPMUlDMkqHJiiMqXWxDAZpUBxk5QwSf5V
	 KAdyOryeQxRWU/nbIJF9KnY20bM/tbzsJSigebLyAoZk8Y/zGgLzbL9Re8X3f6ov3taaG
	 wPrthIh1sMW7KT3KBm9BhprLrp6HpdH8jfj/B6PavbEPbKIHsNws3co7vFcQQ/2nnFQoH
	 9Rnan8KNyXG8IXA/W76c0YVEPxkAzyzLVMDMfiH9Ilo3INZUq88FcbCEhiL57INJu0f1H
	 qeJ2j1qBDR0zaOW3opZeM9pXefiAMtbsmK6IHju3fbR2DeWlpsENE6Tvh/qW8OjlGFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421186;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=miHmWkTPhUcAEvpsJtGNKtqPm0O9WXg4DLHkHhO3x30=;
	b=R1HdPnGof7E9CYjvxMzTOvwA/WtY2hehRN6X2SZgfTRzZK36xjGT+NqUStQxk27oq43P
	 5Xsy8A8ptTGS0FVukQV/GJAYFH6uecy7gDfRCAbxAXuPnxTFDUF6B+6OOX0V9itc/fKYV
	 6z5LFERecJn3rmCXmXeHg3S0Gkr28fEU5PnpbbFG01CMMx1eKZjb6vj9bF1gS4cFxwQHX
	 w+b6ORkvmFjs7YS8QuSsoiOiP14EBxC+wv4nNvaL2smdUQ7wzNjvXeglNX8J2PqCYCriG
	 LmrsVT9ebHz7N1kv7ZdddwDemjGnYopRvwpwcXlB5EaUqz5O+kMyR+VFW6hXOqS2Bdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rXyV+V8m;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="67f/wVrW";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C8606AE1E;
	Wed, 11 Nov 2026 18:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F8C8606AE1E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rXyV+V8m;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=67f/wVrW
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794421184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=miHmWkTPhUcAEvpsJtGNKtqPm0O9WXg4DLHkHhO3x30=;
	b=rXyV+V8mB3WGQYt0D1cbKm+3TdQH5P7EkBB0BuarwzijqP3FTDgXeDtU+702Qha3Vjesjd
	ZOM+Cs2Cjqf95W9HPfwGmTijj2qXHfWvu2anJBtqLqoaWKO9FjvL7fGv6zbAmkaqKvsvsQ
	RLNM7MfGFGooJ30UY9ORSGfoi0Y4Pd/bLfBvxxCuZ0XnCWN6lhknFqGFfTdjfbjgodCXyL
	9khOfeXGPBb8Che0NlD4shfupUeTEen9ahuAZgPlfkyLNV7YY0wetUpUm0wM8itMWW7+PD
	8f+X28nEXLQlCNh1FQ2LsARwu+5HxRkTrDJVnz2voRACc/e1f7hBk3Crxa9Caw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794421184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=miHmWkTPhUcAEvpsJtGNKtqPm0O9WXg4DLHkHhO3x30=;
	b=67f/wVrWqykxVxVPvO3YPpqenX7yBp2KyE+jBcUbzvEX+HrwwBjv1vgxB6QxoqLtZqXPOF
	cVUFfC/MqkcyEyAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>,
	printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Gal Pressman <gal@nvidia.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kgdb-bugreport@lists.sourceforge.net,
	Randy Dunlap <rdunlap@infradead.org>,
	Alessandro Carminati <acarmina@redhat.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	kexec@lists.infradead.org,
	Gustavo Luiz Duarte <gustavold@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH printk v2 0/6] Introduce policies for unsafe flushing
Date: Wed, 11 Nov 2026 19:25:16 +0106
Message-ID: <20261111181942.593695-1-john.ogness@linutronix.de>
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

v1 is here [0].

Until now unsafe flushing is only performed at the very end of
panic(), before entering the infinite loop. For other situations
(such as panic-kexec or panic-reboot or emergency-reboot) no
unsafe flushing is performed. The reasoning for this is because
an unsafe flush could lead to fireworks, which could prevent the
kexec or reboot from occurring.

However, some users may be willing to take on such risks in order
to see panic output. Indeed, for the netconsole (which does not
support safe atomic printing) it is a regression that such unsafe
printing does not occur. [1] 

This series adds unsafe flushing policy flags per-console to
allow individual consoles to perform unsafe flushing for such
scenarios. The unsafe flushing is hard-code-enabled for the
netconsole in patch 6/6. The justification is that this is not
less safe than the legacy netconsole.

Later these policy flags could be easily exposed to userspace
via /sys/class/consoles/, once the sysfs per-console interface
is available.

Changes since v1:

- Make console.unsafe_flush_flags unsigned.

- Add missing kerneldoc description for printk_trigger_flush().

- Remove the WARN_ON_ONCE() in
  nbcon_context_try_acquire_hostile() since hostile takeovers
  are now possible from non-panic contexts.

- Also provide a flush reason for console_flush_on_panic().

- Add a global variable @legacy_flush_reason to track reason
  for legacy flushing.

- Explicitly set PR_FLUSH_RUNTIME to 0 since it is now used to
  initialize @legacy_flush_reason.

- Temporarily set @legacy_flush_reason during legacy flushing
  of console_flush_on_panic() and printk_trigger_flush().

- Also set/check ctxt->allow_unsafe_takeover in
  nbcon_legacy_emit_next_record() to enforce flush policies
  for legacy flushing.

John Ogness

[0] https://lore.kernel.org/lkml/20261109123127.489676-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20260915100140.3631650-1-ryan.roberts@arm.com

John Ogness (6):
  printk: Introduce and specify flush reasons
  console: Introduce unsafe flush policy flags
  printk: Evaluate flush policy in nbcon_allow_unsafe_takeover()
  printk: Remove nbcon_atomic_flush_unsafe()
  printk: Add panic+kexec flush point
  netconsole: Always perform unsafe flushing on panic/kdb/restart

 arch/loongarch/kernel/reset.c  |   2 +-
 arch/powerpc/kernel/traps.c    |   2 +-
 arch/powerpc/kernel/watchdog.c |   2 +-
 drivers/net/netconsole.c       |   4 +
 include/linux/console.h        |  39 +++++++---
 include/linux/printk.h         |  27 +++++--
 kernel/crash_core.c            |   1 +
 kernel/debug/debug_core.c      |   2 +-
 kernel/panic.c                 |   8 +-
 kernel/printk/internal.h       |   5 +-
 kernel/printk/nbcon.c          | 129 ++++++++++++++++++++++-----------
 kernel/printk/printk.c         |  38 +++++++---
 kernel/reboot.c                |   2 +-
 lib/nmi_backtrace.c            |   2 +-
 14 files changed, 181 insertions(+), 82 deletions(-)


base-commit: d01f86a7da8161aac8c6304b377cf58fb75861ca
-- 
2.47.3

