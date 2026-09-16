Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B44D456E08
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544547; cv=none; b=a/xuo95b4pnV/yb7MKzeQTs5eTCHt44UO/EiLzsozuK+kl/ATRZC69NSqI8LtRgCJoptR5aJD5uZXobGBq5Prgffh9rz8MqbjOWV855U7iu7gUuJKlhZlGWYShH7TKb61Sykrh7GLLPcKGfk/i9YVUr+1yIAZ0bZnY6Of6Cl7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544547; c=relaxed/simple;
	bh=SDIDKPg/XJMTZDlOvDmfh7gZvs1x/8ehV8Jyie8JsEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LtfVIVfhE60wGVivqnX0iPrGhGVgL05wWEQQnN28gZstVlpFoqNirfchB1Z61XV/BmP3BNxfa2sCZ+WHTwgWociy6jUJ9vyId3hJO7ov2m5sjyX6+mJiLrUI4wRLvo0lVIOl9q4+AEqlS7Xik2b7800r4J+s0UAokjRtM1jc0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlTJroID; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlTJroID"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6baf77afso402015e9.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789544521; x=1790149321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GWQnH0rufvFzfswnGUXgjHTCIj9a7PTjKQcqx1m/30=;
        b=mlTJroIDRJ2YBcJca0H2URZCjI8ADE6sKm6rQzXRd3cvq2+uw5qBXxjbKszgK0mpUk
         zW9A1rbglJ7TmPsrOXdfrfBCDRC2gd70e43CI+a1eFBdcnra2l8HaQWe7VNIbxiE7fxj
         LKtqhUEWjrXNHkRhGECcXyHWOZuesHZvhGZcuv5X83fgIFJGqDC7CKCAmRI1eCVGS7Wn
         aiDnqkdNCthn5xY0lDchvrznBtlS5EQ4+H4MY4awxjPp8fsaXFhxGpvXx83FASJg0Xuu
         4DgL2NXM6F+vonpUdsIAnTNScKGEvsLXsrgO+vIvqAjjVDwvyJ9OLa4zdEDfA8g1OlSs
         /kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789544521; x=1790149321;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6GWQnH0rufvFzfswnGUXgjHTCIj9a7PTjKQcqx1m/30=;
        b=ep6ezrHzSczw7WEsg8gGC1FAtSwuzCoCV93pIzXD6oNJ1bMGrss+fVm7e6I9MkGDjP
         MuKwBu4KfAaUbX37EIiYCg4IZAdX0TB8atPCn6x9lGNOQyXmqSSeW44Mxr7ZDTcuF25a
         Be2PgsjobsbDPRK2xn0OUBoNrPWcdwQxUhfkCnr4H3hBn005KEH1deYV7wEResdA31tJ
         OE7blJgSYXltiaFWWj3YoX2IAk/rub63g0ZhrpTCnZmgPSP+U2LyDBXfZN57692UIeCZ
         2GnCUCQDTHt1mRA7aKSxPq4BnrGP7NfOgCc++/1SJXVGPBez20er09++M5WRw2ctBXix
         TrIw==
X-Gm-Message-State: AFuF++nhhR2ho0iKt6+ePKQo214wbYMGM+a9RXknAGU1JF+BB5kO8qjs
	3tOZpy0yRT1DcFiGIfvumlh4XWYeqLhIprACKWRc24z01gmFPPhi6O1cdhhQ0xP0/BQxtg==
X-Gm-Gg: AYBFou3axeHdWYKCywrswxPy+LyjcqyqM4AANWh1w2aqRg/ivNtsxMpsaTvaSj0T9FH
	Dwo9FOwR9doHvWbxxsxoAh8bKKYT7rYtIMYHCF9yYTwLAu7ZW2nYzhR7ov5VfDM5f9oKLvcUrz7
	cwfphUhBhs+jCHysnBXZJE8bMy+nVS4qhZw51rEMUtbfnsDkv3NX8WG8DggHLRbb92/0VHPs/qy
	qfEnAoK6rw0OR1lk3wEOgeF5QSwQyNTcimgefeHXI9wjokaFO/aM/wJ3h3oQ9aB3RsnlQwc9kHJ
	x/xbvFlwBW85LRLWOfkJFekCx2VWzzOx9mbnyS/UIxFOUCzYo2v+vC9b1LMHYzScvlyoBNqnEdc
	PwZx5f7dgJqpdp9iqMLHYSLQEtIBhnBwXssvMxHbWiClN84s6LpLk0ZnDhxDrGeZvARoOGjss7B
	a2tbaLUsRRNVCa6U/ofLAUlgyxY5Wc2i9VSHBWBD+J84rgNTUW98MbxfAdAizB7aZkkBwIJjKhx
	HYf/WN8/zWMXKHJdt4t3Y7pVJbsqC6W0zReIag0JcSvgcyO6qAkoNp1OoCz4Ax744lX32gDyg3o
	LtmPAM5NKcPDmn3Uk6p4TRDe
X-Received: by 2002:a05:600c:4e48:b0:49e:7186:f36e with SMTP id 5b1f17b1804b1-49eb731c39emr16252885e9.1.1789544520893;
        Wed, 16 Sep 2026 00:42:00 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f7cesm5023219f8f.10.2026.09.16.00.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:42:00 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa=20Rom=C3=A1n?= <miguelgarciaroman8@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com,
	=?UTF-8?q?Miguel=20Garc=C3=ADa=20Rom=C3=A1n?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH net] llc: stop connection timers before dropping sap ref on release
Date: Wed, 16 Sep 2026 09:41:58 +0200
Message-ID: <20260916074158.3375909-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

syzbot reported a KASAN slab-use-after-free in
llc_conn_ac_send_sabme_cmd_p_set_x() when a connection timer fires
after the associated llc_sap has already been freed via RCU.

llc_ui_release() currently does:

  llc_sap_hold(sap);
  llc_sap_remove_socket(...);   /* may drop last socket's sap ref */
  release_sock(sk);
  llc_sap_put(sap);             /* last ref -> llc_sap_close -> kfree_rcu */
  ...
  llc_sk_free(sk);              /* timer_delete_sync() only here */

Connection timers (ack / P / REJ / busy) are embedded in llc_sock and
their callbacks run llc_process_tmr_ev() -> state machine actions that
dereference llc->sap (e.g. sap->laddr.lsap). Those timers are only
synchronously cancelled in llc_sk_free(), which runs *after* the sap
reference is dropped. If this was the last socket on the sap, the sap
can be RCU-freed while a timer is still pending or running, and the
softirq timer path UAFs the freed sap.

llc_ui_release() already keeps an extra sap reference across
release_sock() so backlog processing can still use the sap. Extend that
window: after release_sock(), synchronously stop all connection timers
while the sap is still held, then drop the sap reference.
timer_delete_sync() must not run under lock_sock() (timer callbacks take
bh_lock_sock()), so stopping after release_sock() is required.

llc_sk_free() still stops timers again; a second sync delete is
harmless.

Fixes: f7e43672683b ("llc: hold llc_sap before release_sock()")
Reported-by: syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=44efda9647c52be29d9c
Signed-off-by: Miguel García Román <miguelgarciaroman8@gmail.com>
---
 net/llc/af_llc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index b0447c33d..4fc397fad 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -215,6 +215,14 @@ static int llc_ui_release(struct socket *sock)
 		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
 		release_sock(sk);
+		/*
+		 * Timers dereference llc->sap.  Cancel them while the sap is
+		 * still held; llc_sk_free() runs after the final sap put and
+		 * would otherwise race with kfree_rcu(sap).  Must run after
+		 * release_sock() to avoid deadlock with bh_lock_sock() in the
+		 * timer callbacks.
+		 */
+		llc_sk_stop_all_timers(sk, true);
 		llc_sap_put(sap);
 	} else {
 		release_sock(sk);
-- 
2.43.0

