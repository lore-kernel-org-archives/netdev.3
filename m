Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792883216;
	b=RixDlLOaqQgpGp3BS0c/kCFzVCpYRn+Kez+ylIWC7IGzlovYtiOhEbI9keLMN+5pHCkl
	 6uqayx92B7Q4gIwyORm/7nmUzlDxwgn4BTLfC0syZ+bfg1ZEMuu4B3X58wFJT+d0Ga0aQ
	 DqZUU/j8cJlPCi+5B8T+J0G/CyGc47TXhBmWrOQ2grtHxx4SyE3YBV9rCcr/AvPr0z/VZ
	 HY8x0I6CrjzQ3W82k0/hTWIdqj/AnwEQmV5pewzhQ9l5UWyebqtKCOrvcfE2E3jHV1XpK
	 a7L1P8clOwL3z4Btaqb3YsGw4d4OjHLNk9fLmIjvsLqURGM01cXjfY3z4OvOZ5RN0zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792883216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Mj/IlOlFiVg3XOKyCX4qOu3ZEou8sRwfHozl03ktwdA=;
	b=Au1nJivPW4lnUwPSud/m3ooIRF8mOYPlu+VIovh0Wx94eGSaBkVim7iAX897rOrRql0O
	 MkdkpLxyXHQcBvL+VdJo2rMANJx6cbKIvsfSniDNoOq6dr0F5PCq2Qa1LXj8LwV4//L7A
	 S2W4vqYTycOWL3pOGmTHcNG5gJnqBc35MQ3J7jSyWAeXdiC0pp3uCQRHKpGn0WzjmJziW
	 Hz8w+rHuTjLY8gZXwq3031ugb5zKFnJFNATCNkTOhMzU30RmRpqKLuJKTyLaO6KH50TB9
	 QgtInc5Cl4A5K/FPIdxzi2mX7HdEmaJWusQ71FvjW1k6LNosZKcR7g1oAlNtpJXgLNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mjChOsJS;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B0606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 23:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 803B0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mjChOsJS
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c315869241fso234534866b.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 16:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792883214; x=1793488014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mj/IlOlFiVg3XOKyCX4qOu3ZEou8sRwfHozl03ktwdA=;
        b=mjChOsJSBKyxYdudhgBUdrwXDZGnRq7mzjLe4b896IiV9ScSlVs3nf+OdHOnuR+1+2
         5aNUB0kHa3/MgRYtn8QeLa8NCE4u0Z2G++vMIRh5j1wAwJF5i1Vkmg1Zv6Qdrjs5r5dG
         IWWojEH5bOTcWiUWjGAtZlSR9l6mtGnF6YPrxxpQ5CEvwo6lLHjUKuxvzFGALlyFIxN1
         w8kmicB2OGO7O9l88oR0+LZ/qjZjm9YHj4K2myOmdiIavK3SMx+uSqPu0cPs9HgztFEu
         rbVwqsnvWeoiJulYX1P327B7wf9oE0X2Uk66Ft1WGTE4DvpcQMBjLtemfNKuWEizxfkz
         v33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792883214; x=1793488014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mj/IlOlFiVg3XOKyCX4qOu3ZEou8sRwfHozl03ktwdA=;
        b=Z/39S3oE/EmJrgCeAjlQIIp/q7DpKbPIx8gK8GFdEZK/qr14EtvUQdKTNRdVChNQCE
         sdzKJxIWRY/PAa7xSgfjJ4TUl6ifaWd7fYbdlAVgCSXnDsxGUoeOU4gRmqzeCEPi498y
         ynr86VNEsSRGfsTF4K0GBGey5HRf59jQpAN6yEzLXO24ULZkPqDQKweoxfNb8O82im18
         KRuPRjiiqivtgGp+Bk79++XowWrPXLEuOGlFskcamymgB+lSYc4Vd7jC7MYNOz9Igb73
         91ZeEzdi9vdEDfiugeYGJY8ldsrfe6Q+7tqzBOWjf28uDJJGK1fIgdzmhdE/aj22F4hY
         eBvw==
X-Forwarded-Encrypted: i=1; AKwUvBxo9E9YACkr2Xt9tRyFMAzpuOFIbYViXMPlp87NocoYNL0bg9/AXoQf1cL+kLUDZbaby3iN/oM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLb8m/q04G7T0rQp92AStbmN7TpOw/j26vzI1HJaYT3ssUQig2f
	V2nSo/h6g+H4BRLMtUNZo1O7RctA40f4FVCUerjggb7tmw6yjwfOnis4
X-Gm-Gg: AYBFou0rdM6vGHQlKvzuurbpKFH+OoO0VPTazefD2u8EE4+9CsXHDXJfp1wHAPCFnii
	t7KDk1qKKm2KXLRgu0T4CVC3qDEPNhreRhUlHaqO1KpKZKk2RebCWaDQgKllHRsVGDvgUjroVJ4
	n/UkvujYsCLUw6YMyv79lQe0ZeLdlEYmKyjkqWHD6ZkqIpDjZ6qXFchVvMTE7fVK9ffMAx8Tc9Z
	vMvMkSHkWzp/A4CLvHH1Rwck1GxWZ9VbP6v51hG/jJsLCo3vvyORQTKk0jzdE78P/McdnwXqznD
	fZJQ+avHgNorUj09bXQEgcmL5/sekbK3Xn0ZdF9WWxV8Ba6D/G/HwP5euAXmC8pfxmW1lO9vsi6
	ZZPhh6mFXrws9/ttzPeY6ffOX607bQw1ep07xKWUrlQR7aHNIg8+H2drliEypkWzHQdfLWpYmUT
	VhIK7CLdJPK1trXDyo+rzlyStB2JcrJlkVzSXI3c2aUe0LOM98czEI/+l0KfsRusvdJVFddphpK
	6Di4JzLRS4ceVKiG4r9QlnanURNxM0j8wsEI+NQrr2NTKFCEtgImbAtd667C0hUQ/81XpSSGmDc
	Kg==
X-Received: by 2002:a17:907:96a1:b0:c46:75e7:25af with SMTP id a640c23a62f3a-c46bdd6feb2mr358195166b.11.1792883213773;
        Sat, 24 Oct 2026 16:06:53 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:46::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd5206dasm137287266b.33.2026.10.24.16.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 16:06:53 -0700 (PDT)
From: Sam Crossley <samuelcrossley@gmail.com>
Date: Sat, 24 Oct 2026 16:06:03 -0700
Subject: [PATCH RFC 1/2] printk: add per-console replay helper
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-netcons-replay-upstream-v1-1-9613f38496e5@gmail.com>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
In-Reply-To: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Paolo Abeni <pabeni@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Sam Crossley <samuelcrossley@gmail.com>
X-Mailer: b4 0.16-dev

console_try_replay_all() rewinds every registered console, which is too
broad for a caller that needs to resend records through one console.

Add console_try_replay() for that, sharing the locking and flush logic so
existing callers are unaffected. A NULL console is rejected, since the
shared helper reads it as "every console".

Like the existing all-console operation this is best effort: it does
nothing if the console lock cannot be acquired immediately. That lock is
global, so unrelated console activity can cause a replay to be skipped.
Records have not necessarily been printed by the time it returns either --
consoles served by a printer thread are only woken here.

Signed-off-by: Sam Crossley <samuelcrossley@gmail.com>
---
 include/linux/printk.h |  6 +++++
 kernel/printk/printk.c | 67 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index f594c1266bfd4..9cd06a67e7c83 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -203,6 +203,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+void console_try_replay(struct console *con);
 void console_try_replay_all(void);
 void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
@@ -301,6 +302,11 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+
+static inline void console_try_replay(struct console *con)
+{
+}
+
 static inline void console_try_replay_all(void)
 {
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9a205f94bfac7..59e6df8a57de2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3494,13 +3494,14 @@ void console_unblank(void)
 }
 
 /*
- * Rewind all consoles to the oldest available record.
+ * Rewind a console, or all consoles if @target is NULL, to the oldest
+ * available record.
  *
  * IMPORTANT: The function is safe only when called under
  *            console_lock(). It is not enforced because
  *            it is used as a best effort in panic().
  */
-static void __console_rewind_all(void)
+static void __console_rewind(struct console *target)
 {
 	struct console *c;
 	short flags;
@@ -3511,6 +3512,9 @@ static void __console_rewind_all(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
+		if (target && c != target)
+			continue;
+
 		flags = console_srcu_read_flags(c);
 
 		if (flags & CON_NBCON) {
@@ -3557,7 +3561,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	console_may_schedule = 0;
 
 	if (mode == CONSOLE_REPLAY_ALL)
-		__console_rewind_all();
+		__console_rewind(NULL);
 
 	printk_get_console_flush_type(&ft);
 	if (ft.nbcon_atomic)
@@ -5047,6 +5051,48 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
+static void __console_try_replay(struct console *con)
+{
+	struct console_flush_type ft;
+
+	printk_get_console_flush_type(&ft);
+	/*
+	 * The console lock is global, so the replay is silently skipped when
+	 * an unrelated console holds it. A trylock is what keeps this
+	 * callable from any context.
+	 */
+	if (!console_trylock())
+		return;
+
+	__console_rewind(con);
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
+	if (ft.nbcon_offload)
+		nbcon_kthreads_wake();
+	if (ft.legacy_offload)
+		defer_console_output();
+	/* Consoles are flushed as part of console_unlock(). */
+	console_unlock();
+}
+
+/**
+ * console_try_replay - try to replay kernel log on a console
+ * @con: The console to replay the available records on
+ *
+ * Try to obtain the console lock and replay all available records in the
+ * printk buffer on @con. Does nothing if @con is not registered.
+ *
+ * Context: Any, except for NMI.
+ */
+void console_try_replay(struct console *con)
+{
+	if (WARN_ON_ONCE(!con))
+		return;
+
+	__console_try_replay(con);
+}
+EXPORT_SYMBOL_GPL(console_try_replay);
+
 /**
  * console_try_replay_all - try to replay kernel log on consoles
  *
@@ -5058,20 +5104,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
  */
 void console_try_replay_all(void)
 {
-	struct console_flush_type ft;
-
-	printk_get_console_flush_type(&ft);
-	if (console_trylock()) {
-		__console_rewind_all();
-		if (ft.nbcon_atomic)
-			nbcon_atomic_flush_pending();
-		if (ft.nbcon_offload)
-			nbcon_kthreads_wake();
-		if (ft.legacy_offload)
-			defer_console_output();
-		/* Consoles are flushed as part of console_unlock(). */
-		console_unlock();
-	}
+	__console_try_replay(NULL);
 }
 #endif
 

-- 
2.53.0-Meta

