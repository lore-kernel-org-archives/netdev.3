Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773236;
	b=2maqb2m2z21XZn8Bee8qQhnYSSE0c3BX0+gzwxLeXuSqor63w+E4sBX4TdF04e8hfUf+
	 5fGt5Yp+FAhto2KQ52LQ0bUBckMUqY1h1C0ZssmSQgW4y7xP0wUtz6G9JSMYuk/A31F/a
	 fNsmEBglb0AQBr/PlX5toGeq5Ev7vUb5V7DGkck0h3HYj8bCYG+592G40zvfTODsF2spy
	 4EfzJpofTBVCGX4zOkIEG35QbDFCF0LZpJhWkmWHqeT6PEwOcWh5yM/xi4H0cgovg9Ocq
	 RLhi6lnz+Z7PlOM6FtwY4M5L1krbR30Wc9NXl4/QPbnGBUcLqjoq7T5t7gbIGubfj3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V+z8p02HuPEPBTukBBTYVrh63gM4/9qfp3aVcKWZiEI=;
	b=AUWFjb3yDcyO17suK9Tjxew7W4akUzF6DZD+P/o8+5DqTvD3WkgyRugkVFj/fPUOLerf
	 87Xu9Dk65mFa5Uq2BvzGxXaa2+V+pTIYrIbgc6yB4WZzm8vSRgi7EcGmNwOHIycBJjm/Z
	 javvr4jaOCVobGPLyugeF1lVIsnDmW7r/CDiRf+o5MzYAWvnbvzGoN4Wmd/grVFDw+Dp4
	 wUmgSBF8Ey7jBYlv4wV1AdBVRPyPiT+zMxaJDkWgTl3wp04LKJLOFmhsxGnl+nXgSnzV+
	 G4od+ArCiqMUH2MR4Ji2kveYt2zFu8qkVXptHEHdu4wLgxfxhzt16owTlm+LFbONHzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=VmCSziel;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97387606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 06:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97387606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=VmCSziel
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a8cc11ac42so489665c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 22:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1793773235; x=1794378035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V+z8p02HuPEPBTukBBTYVrh63gM4/9qfp3aVcKWZiEI=;
        b=VmCSzielL0jeUpiez/2QYQYT9jLKzER+SJMUOHSrRQLP/k4x+rbwpf2KGe9tmHMHsH
         JnqQuB8GME084qbY/HQIV1FUYT7Ni+51iUhIc+XMAfv+EHqHKx70J+uUZDXQ9Ixl14bm
         XlkICZxXkgKA4vA48b2duAFgeRhPJKyx3gV9ua3RgOd/Qbs3l4W01nJNYCPyoDr4nWE9
         68c4QM+BqGNUDP3oRV35TybGbRhOliY6t3SHh7ppJ1eA6RbEkZo7+qEhdiiHKZbgGl84
         c7Xt7VFe4QF4NzywhmbdWb4s6O9/hXH6S9S8eoA4dkEiC8CFpGEN4KXVUszCV4RdqWjc
         OY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773235; x=1794378035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V+z8p02HuPEPBTukBBTYVrh63gM4/9qfp3aVcKWZiEI=;
        b=A35shlo5gSYhrJjk/7IUyCfP3i7QXGriaH0ukWondTMdMuIxyagvqPJRPYjZORbFe3
         h6zPh+CIdx2XPz6tJL4rX11A5fGbb602KLKLdmGdUn5HhgGNZatLMC/2zphjiDtNdyMl
         bK7fFH33qLUBwr1dJFjvdkCLgqdN9ysyy9U3zaSFFLYF46PMjxHWBJnrwVPv0R5gh1wy
         4JHEEmOm2H5d65rrJYqkPCrg62spozfU8oGuB/JE7IexTVctEmQv5NBIQK/reco7fIsW
         LKnbL7s7R3G73on5JcTOfdrVoDweY6BrahrOnls9H/1ClAa55z0y7p8RY+ctcRTkLVZg
         p91w==
X-Gm-Message-State: APuU4Z99ZGeD7nCuAemoBI9kxzAKD+aIHX8eSNz00WX0amy3uSJQAaI0
	gz2O1q3MuC29jUHn7kD49zWcNzahfnTDYg0UOTQKUKihobAK3l+L05uQeihDYLmIXrIei3TWDO/
	3xQ+X
X-Gm-Gg: AYBFou2mvuxKhko2kI6sjWu5RX6s5ptxbL+9SWsv3wFk/LEiHgOUKbXUDTIGLKuQENT
	AGfqnQW2+ODduKWXY7HN4POXL37KrErDidasTWqVNR6gLd5L7OyZf4x4mfgwIIgikbsvb+DExlf
	69500z8RqUjG4wgKsf9MZWkWHqOghBiGGU4Lmab5CA2IhmFk89pjw8SaREOz4G9wJ+saI8jCpBj
	r2uDW2kVeCR5qQOr8BxSzAr9iY7wXbGRdWt8sVGLVYQPbwuUbCIbUaSU2bjSz5WKHX6115Bhdz5
	iT7WjkiKyEP6KQ9Pk8MtOrvNe1k0rYr8TQ+abtgXv/nZEMD/j5s7Rc9ZQMD8EgUhqN1TC8eYgwt
	/xX0Oswr+lQOpFyu5lDFygKYq3kiICklMyy8QEokWi/iezbtpC+HOi8SDYGWQeR7tpEcSoBhrCq
	OBz0QBaZKbVl3k8HOV4B9hbr1sZvMdOMI1wS2KpymFE8m/Y6E4BdXMPGfmCQwy/FIqXICuK7B1P
	2FU1cdnzQhesqNdtDTZHNFq+VCcXs1SFN6XE5rWbMJgLSNOKmtV2fm5rYCtrWKUXHxaJd6pPM4A
	iXoefLBh7MlLFlZTPPWjInenersWTMuVAqOc1XIHC4kMw8C7G+LBkY4o2RN1VHfdW+OsP9axB4K
	1x92e+MhRiaF4+7sLuBo/G7ZQ9+DQljvP5CldPBAHWhDjBDk5
X-Received: by 2002:a05:7022:108c:b0:163:c5eb:d42f with SMTP id a92af1059eb24-1ac574551afmr21038784c88.5.1793773234518;
        Tue, 03 Nov 2026 22:20:34 -0800 (PST)
Received: from localhost.localdomain ([103.196.55.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c69c3fsm4486279c88.20.2026.11.03.22.20.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 22:20:34 -0800 (PST)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	david@ixit.cz,
	horms@kernel.org,
	gio@octane.security
Subject: [PATCH net v7 1/3] nfc: nci: uart: serialize driver selection
Date: Wed,  4 Nov 2026 11:50:24 +0530
Message-ID: <20261104062026.80599-2-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104062026.80599-1-shubham@octane.security>
References: <20261104062026.80599-1-shubham@octane.security>
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

NCIUARTSETDRIVER assumes that tty->disc_data remains NULL until a
transport has been selected.  Two concurrent callers can therefore both
allocate and register an NCI device for the same line discipline.

The transport registry can also be changed while a caller is copying a
template from it, before the transport module has been pinned.

Allocate one UART context when the line discipline is opened and claim it
atomically during driver selection.  Protect the transport registry with a
mutex, take the module reference while holding that mutex, and copy only
the immutable template fields.  Keep TTY callbacks disabled until the
transport has finished opening, and unwind the context so a failed
selection can be retried.  Use acquire/release bit operations for the
selection claim so a retry observes the completed unwind.  Treat the driver
number as unsigned before using it to index the registry.

Discovered during an AI-assisted source audit using OpenAI Codex,
gpt-5.6-sol.  Patch development and test planning used the same assistant.
Confirmed using an unmodified kernel, a pty-backed user-space NCI
controller, and two concurrent NCIUARTSETDRIVER ioctls; no error injection
was used.

With the fix applied, the reproducer passed 100 cycles under KASAN, UBSAN,
and lockdep, and 50 cycles under strict-mode KCSAN.  No in-tree selftest
covers the NCI UART line-discipline path.

Fixes: 9961127d4bce ("NFC: nci: add generic uart support")
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 include/net/nfc/nci_core.h |   1 +
 net/nfc/nci/uart.c         | 142 ++++++++++++++++++++++++++-----------
 2 files changed, 100 insertions(+), 43 deletions(-)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 664d5058e..2f542f5c9 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -454,6 +454,7 @@ struct nci_uart {
 	spinlock_t		rx_lock;
 	struct work_struct	write_work;
 	struct tty_struct	*tty;
+	unsigned long		flags;
 	unsigned long		tx_state;
 	struct sk_buff_head	tx_q;
 	struct sk_buff		*tx_skb;
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index aa20e8603..529c8cf88 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
@@ -34,7 +35,12 @@
 #define NCI_UART_SENDING	1
 #define NCI_UART_TX_WAKEUP	2
 
+/* UART flags */
+#define NCI_UART_DRIVER_SET	0
+#define NCI_UART_READY		1
+
 static struct nci_uart *nci_uart_drivers[NCI_UART_DRIVER_MAX];
+static DEFINE_MUTEX(nci_uart_drivers_lock);
 
 static inline struct sk_buff *nci_uart_dequeue(struct nci_uart *nu)
 {
@@ -102,43 +108,82 @@ static void nci_uart_write_work(struct work_struct *work)
 	clear_bit(NCI_UART_SENDING, &nu->tx_state);
 }
 
-static int nci_uart_set_driver(struct tty_struct *tty, unsigned int driver)
+static int nci_uart_set_driver(struct nci_uart *nu, unsigned int driver)
 {
-	struct nci_uart *nu = NULL;
+	struct nci_uart *template;
 	int ret;
 
 	if (driver >= NCI_UART_DRIVER_MAX)
 		return -EINVAL;
 
-	if (!nci_uart_drivers[driver])
-		return -ENOENT;
+	if (test_and_set_bit_lock(NCI_UART_DRIVER_SET, &nu->flags))
+		return -EBUSY;
+
+	mutex_lock(&nci_uart_drivers_lock);
+	template = nci_uart_drivers[driver];
+	if (!template || !try_module_get(template->owner)) {
+		ret = -ENOENT;
+		goto err_unlock;
+	}
+
+	nu->owner = template->owner;
+	nu->ops = template->ops;
+	nu->name = template->name;
+	nu->driver = template->driver;
+	mutex_unlock(&nci_uart_drivers_lock);
+
+	ret = nu->ops.open(nu);
+	if (ret)
+		goto err_module;
+
+	/* Publish transport fields before callbacks observe READY. */
+	smp_mb__before_atomic();
+	set_bit(NCI_UART_READY, &nu->flags);
+
+	return 0;
+
+err_module:
+	cancel_work_sync(&nu->write_work);
+	kfree_skb(nu->tx_skb);
+	nu->tx_skb = NULL;
+	kfree_skb(nu->rx_skb);
+	nu->rx_skb = NULL;
+	skb_queue_purge(&nu->tx_q);
+	clear_bit(NCI_UART_SENDING, &nu->tx_state);
+	clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
+	module_put(nu->owner);
+	nu->owner = NULL;
+	goto err_clear;
+err_unlock:
+	mutex_unlock(&nci_uart_drivers_lock);
+err_clear:
+	clear_bit_unlock(NCI_UART_DRIVER_SET, &nu->flags);
+	return ret;
+}
+
+/* ------ LDISC part ------ */
+
+static int nci_uart_tty_alloc(struct tty_struct *tty)
+{
+	struct nci_uart *nu = kzalloc_obj(*nu);
 
-	nu = kzalloc_obj(*nu);
 	if (!nu)
 		return -ENOMEM;
 
-	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));
 	nu->tty = tty;
 	skb_queue_head_init(&nu->tx_q);
 	INIT_WORK(&nu->write_work, nci_uart_write_work);
 	spin_lock_init(&nu->rx_lock);
 
-	ret = nu->ops.open(nu);
-	if (ret) {
-		kfree(nu);
-		return ret;
-	} else if (!try_module_get(nu->owner)) {
-		nu->ops.close(nu);
-		kfree(nu);
-		return -ENOENT;
-	}
 	tty->disc_data = nu;
+	tty->receive_room = 65536;
+
+	/* Flush any pending characters in the driver */
+	tty_driver_flush_buffer(tty);
 
 	return 0;
 }
 
-/* ------ LDISC part ------ */
-
 /* nci_uart_tty_open
  *
  *     Called when line discipline changed to NCI_UART.
@@ -156,13 +201,7 @@ static int nci_uart_tty_open(struct tty_struct *tty)
 	if (!tty->ops->write)
 		return -EOPNOTSUPP;
 
-	tty->disc_data = NULL;
-	tty->receive_room = 65536;
-
-	/* Flush any pending characters in the driver */
-	tty_driver_flush_buffer(tty);
-
-	return 0;
+	return nci_uart_tty_alloc(tty);
 }
 
 /* nci_uart_tty_close()
@@ -180,14 +219,17 @@ static void nci_uart_tty_close(struct tty_struct *tty)
 	if (!nu)
 		return;
 
-	kfree_skb(nu->tx_skb);
-	kfree_skb(nu->rx_skb);
+	if (test_bit(NCI_UART_DRIVER_SET, &nu->flags)) {
+		kfree_skb(nu->tx_skb);
+		kfree_skb(nu->rx_skb);
 
-	skb_queue_purge(&nu->tx_q);
+		skb_queue_purge(&nu->tx_q);
+
+		nu->ops.close(nu);
+		module_put(nu->owner);
+	}
 
-	nu->ops.close(nu);
 	nu->tty = NULL;
-	module_put(nu->owner);
 
 	cancel_work_sync(&nu->write_work);
 
@@ -211,7 +253,8 @@ static void nci_uart_tty_wakeup(struct tty_struct *tty)
 
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 
-	if (tty != nu->tty)
+	if (tty != nu->tty ||
+	    !test_bit_acquire(NCI_UART_READY, &nu->flags))
 		return;
 
 	nci_uart_tx_wakeup(nu);
@@ -300,7 +343,8 @@ static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 {
 	struct nci_uart *nu = tty->disc_data;
 
-	if (!nu || tty != nu->tty)
+	if (!nu || tty != nu->tty ||
+	    !test_bit_acquire(NCI_UART_READY, &nu->flags))
 		return;
 
 	spin_lock(&nu->rx_lock);
@@ -328,13 +372,12 @@ static int nci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 	struct nci_uart *nu = tty->disc_data;
 	int err = 0;
 
+	if (!nu)
+		return -EBADF;
+
 	switch (cmd) {
 	case NCIUARTSETDRIVER:
-		if (!nu)
-			return nci_uart_set_driver(tty, (unsigned int)arg);
-		else
-			return -EBUSY;
-		break;
+		return nci_uart_set_driver(nu, (unsigned int)arg);
 	default:
 		err = n_tty_ioctl_helper(tty, cmd, arg);
 		break;
@@ -370,33 +413,46 @@ static int nci_uart_send(struct nci_uart *nu, struct sk_buff *skb)
 
 int nci_uart_register(struct nci_uart *nu)
 {
+	int ret = 0;
+
 	if (!nu || !nu->ops.open ||
-	    !nu->ops.recv || !nu->ops.close)
+	    !nu->ops.recv || !nu->ops.close ||
+	    (unsigned int)nu->driver >= NCI_UART_DRIVER_MAX)
 		return -EINVAL;
 
-	/* Set the send callback */
-	nu->ops.send = nci_uart_send;
-
 	/* Add this driver in the driver list */
+	mutex_lock(&nci_uart_drivers_lock);
 	if (nci_uart_drivers[nu->driver]) {
 		pr_err("driver %d is already registered\n", nu->driver);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto unlock;
 	}
+
+	/* Set the send callback */
+	nu->ops.send = nci_uart_send;
 	nci_uart_drivers[nu->driver] = nu;
 
 	pr_info("NCI uart driver '%s [%d]' registered\n", nu->name, nu->driver);
 
-	return 0;
+unlock:
+	mutex_unlock(&nci_uart_drivers_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nci_uart_register);
 
 void nci_uart_unregister(struct nci_uart *nu)
 {
+	mutex_lock(&nci_uart_drivers_lock);
+
 	pr_info("NCI uart driver '%s [%d]' unregistered\n", nu->name,
 		nu->driver);
 
 	/* Remove this driver from the driver list */
-	nci_uart_drivers[nu->driver] = NULL;
+	if ((unsigned int)nu->driver < NCI_UART_DRIVER_MAX &&
+	    nci_uart_drivers[nu->driver] == nu)
+		nci_uart_drivers[nu->driver] = NULL;
+
+	mutex_unlock(&nci_uart_drivers_lock);
 }
 EXPORT_SYMBOL_GPL(nci_uart_unregister);
 
-- 
2.54.0

