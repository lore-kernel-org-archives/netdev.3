Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227492;
	b=LznNxkaf2fng4j96KkVJqGj4mZ13mZjyuFhxK4MY6ll6YI1QfF1sCKe4vjYI8oca+uQ6
	 8umT9m0Za9pIzjR/SyrcSOLQ/BY95f6FPirjiJIM9mXLRdoIWywE1ppi2bcuHbJOxdx9B
	 7JBlIBZD4yPE5ln7xF/fFyoGz0EnszQvvl5qRBYSvB8n4SjXUOai9cnchwLHLXVTZxZoJ
	 0l4DnyoF6fqeZCpIDO0heTpzkuVeQhDGVJPiM7rZzoJrqtgJj3Ld3EEQBq4JRecD1Z+k8
	 jylWTwR+aZfIS4523bMqUw92IoPaRbgedWYD1bWX5Klf6zJU0HGBAOwS8oaWn81d5mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227492;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=fIXMPIsA/87cWvB95KQ+/8m1Qdamj/60DkL4G69W9RI=;
	b=p3KObY+4/fMrCzfoP2+BWlkvr24bXBBn/xY7w0MkTE6Ra2HVQWc2HgfzDaBTNw9ZwZG4
	 Pf8nuDTGYMPlTWGvXXc9SbHSRGousD55nN+yALYqhY9sSxBoNk8cUshmz5Xiu1TR0mD/a
	 v9e7RMYLIFjtW2plkIstg4L4fvTIKubhgMnmankm52IC5/2mbncmkXUBvZRaFkMQkTvXt
	 fyU8JD9n8qrA4dkLUaPrPpne1JHCBBBbsouY9JDJWCJu+HVgmzlb9MbjNqneHhUIM9UUL
	 7+Q2MKuSmQvcZ/f+Z/CK4rVLBTzI3qc9K1u/F9AJ81m3w0zOJPwZ48BwU0FtaRSWKNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BVn6goM5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=icg2C3zy;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40B606A321;
	Mon,  9 Nov 2026 12:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D40B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BVn6goM5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=icg2C3zy
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794227489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fIXMPIsA/87cWvB95KQ+/8m1Qdamj/60DkL4G69W9RI=;
	b=BVn6goM5DdOyungF+KCccmht5x5GkRSV4guGwd3HLRCXTbHqP2RNiBFSjb1lRM13W51iy0
	nY5UzEMxxhDgwT2yZpZWahcO/gFqmk3egT5469koNPX/h3rPNizr+IxKAMVVirbhfly6wZ
	GbApcLMlTK56edrSa23nENBu4lALoN/Ok5UUwxPBZYFgFD7oMltFdIPLKmBFoHAyZIGP0j
	cb4g0qnyjR42YZWtEp19Jh/oUNlIxTbjt+nejaridLx/hizJ/F3Xx4LHIMDbfB8aQOFq+s
	DON4vr114yGTh1Dsj3tBOMazfCEaQiC5hHj1AzT8sR88fGghX5fUPWaOAyaCRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794227489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fIXMPIsA/87cWvB95KQ+/8m1Qdamj/60DkL4G69W9RI=;
	b=icg2C3zy263T42rXs/vcrNrmpaVc6W/Byd9Lrj/krqLWZRCOZgtpnTqaiIvsOkFPEgixus
	tgqbc4XsQzsLndDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>,
	printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Bradley Morgan <include@grrlz.net>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Bradley Morgan <brads@mainlining.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
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
Subject: [PATCH printk 0/6] Introduce policies for unsafe flushing
Date: Mon,  9 Nov 2026 13:37:17 +0106
Message-ID: <20261109123127.489676-1-john.ogness@linutronix.de>
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

Until now unsafe flushing is only performed at the very end of
panic(), before entering the infinite loop. For other situations
(such as panic-kexec or panic-reboot or emergency-reboot) no
unsafe flushing is performed. The reasoning for this is because
an unsafe flush could lead to fireworks, which could prevent the
kexec or reboot from occurring.

However, some users may be willing to take on such risks in order
to see panic output. Indeed, for the netconsole (which does not
support safe atomic printing) it is a regression that such unsafe
printing does not occur. [0] 

This series adds unsafe flushing policy flags per-console to
allow individual consoles to perform unsafe flushing for such
scenarios. The unsafe flushing is hard-code-enabled for the
netconsole in patch 6/6. The justification is that this is not
less safe than the legacy netconsole.

Later these policy flags could be easily exposed to userspace
via /sys/class/consoles/, once the sysfs per-console interface
is available.

John Ogness

[0] https://lore.kernel.org/lkml/20260915100140.3631650-1-ryan.roberts@arm.com

John Ogness (6):
  printk: Introduce and specify flush reasons
  console: Introduce unsafe flush policy flags
  printk: Evaluate flush policy in nbcon_allow_unsafe_takeover()
  printk: Remove nbcon_atomic_flush_unsafe()
  printk: Add panic+kexec flush point
  netconsole: Always perform unsafe flushing on panic/kdb/restart

 arch/powerpc/kernel/watchdog.c |   2 +-
 drivers/net/netconsole.c       |   4 ++
 include/linux/console.h        |  37 ++++++++---
 include/linux/printk.h         |  27 ++++++--
 kernel/crash_core.c            |   1 +
 kernel/panic.c                 |   2 +-
 kernel/printk/internal.h       |   4 +-
 kernel/printk/nbcon.c          | 117 ++++++++++++++++++++++-----------
 kernel/printk/printk.c         |  16 ++---
 kernel/reboot.c                |   2 +-
 lib/nmi_backtrace.c            |   2 +-
 11 files changed, 146 insertions(+), 68 deletions(-)


base-commit: d01f86a7da8161aac8c6304b377cf58fb75861ca
-- 
2.47.3

