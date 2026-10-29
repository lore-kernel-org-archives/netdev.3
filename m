Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243959;
	b=J2I3Yj4SvQ9EXrCXYJk5gKmTxzgvE+A859vOSSB9Ra59bqrnjk3gB6deeEZA5St3H+6q
	 7+SHlh6GZGdm5876/ZNtWMiWmQERgtKI4CFga2xNBfM+qsFs2LBruxlV4a+lPb8inSzzs
	 CvrFbyQuXF7zQzvdk6UcHl9rCQdIymRGW20N6rt8Vs50jVD+fxbcMnBTwaGvosLiEXN71
	 6S75JBsie2RAuxZWGW+u/Xwe2c7lLfTQOcbbcEATkxzd/UVWIEDLgsU7wBC4CFhOAItGc
	 3O0C5V1tVh8dqj8IxfqvWbU4/TZxc97TgRkXOdwu8DRQXOZC96KtB4+wxgW7DYiKGlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XzKZl5NkU/e6R2gEUfTtxSpWsz1HqIcKsauez/M6DC4=;
	b=BTfywLXb9TUi2bedIF/hefVCWm9zakHTgi3F01ePHxH83S8DNBZIOnXmc92TUTLUKvRP
	 fWQ1fL3p2xd3reYYLoF9J0Gmt3Vrre1QyT6cCBaUSvWwKXH4cWiP87OaatggkFORAg9be
	 dlGV6U4BZ4/WSwjOGW6c3l6NHUK7gi/didxCVmMKb+f1YXVbPy4qywyX1Slw4rJ4Mj4/1
	 xjI/sLun50mgLU4MXo+btcKctzbOcGuWvXYGFobbgu9+89QnPBDIAnqj3kzXzAE0AJBfK
	 GHeYRhn/LF1usjnZD4S4PT2HVXEuyQQCC9TP4t8TixCJ5/EsGPrSCwIuwUOPWjVxMlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPzYpA67;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A70606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A70606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPzYpA67
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso9238955ad.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 20:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793243958; x=1793848758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XzKZl5NkU/e6R2gEUfTtxSpWsz1HqIcKsauez/M6DC4=;
        b=zPzYpA677imnZd32/RwR1+ZUbuEcvL9IX9rzGIcgJNM/koSI6lsY5/sd8CUqPRRv4A
         81rZa4NTxz+n1ZdGU/cTYF99b5IvmY79MQmZARsOSuROqpe+rS7K2kPlgczLc3O/HHGh
         alPSRoLyFLOIil4uzY8NZqRQgMbQU13zl4w8YqFn1r65vVLfBcPDOo6GUC3n+JJk6ZMJ
         DF7izwn0Wbm64hG5CY+QpO6gKcFJzhJHZYaGdThRG5+l2PLjvUPKicWNcWHcr/QR03w9
         8XA1NJ8Jfgy1O0yBGn/kWV4NlN6pG30MP4usNUUTaC60EM+ReZr/OzD4bzWEhE+rK3FJ
         nfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793243958; x=1793848758;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XzKZl5NkU/e6R2gEUfTtxSpWsz1HqIcKsauez/M6DC4=;
        b=Clv1tC/qdAq/nP/4AopmWK/rD9Ush2I1LFQk/ttB1aq4dJJbqpV57oVPrcwrvZT4QO
         jqC5c7yio1V99YYKKLkjR0GXL5XntWiPkphGBKkFK2dSKG5k/h9Tu0FlabTFAuDhcZhk
         8VbMbBddHm+Kga1+437xJJ5vhbUogvZH+WUPaV/7N1/U3YT+No+DRn8Xee/bvbEjdt5w
         c7IAaSW3iOPqI+ZDUrgQY/YzAz+55S+t0d04K+Q0AhNF+mXYjID7lUcVTQE2R4L2357b
         /hnTe53kMaQH3ooLwJNPDIsMUN8vAEwZQauu2F3sLFHrFuhAk1Lk4OGhPTj6v6eOlJG4
         G1qA==
X-Forwarded-Encrypted: i=1; AKwUvBx8lGVxhHl9Iywy0n0BlC/HMMrtVgCnKEZod7NDbQ8VLhObJTdrwlnWJmNsHqh6XFgFtXnUsF0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvQjVNoURCH65+a+ijr8a3AHp9c5HcrMUNWkz3STzTZ2XArpPK
	TOQshTD2j5lBzW3RTp7BD3x/1rDJKDgjgZ5/2hUDcQ2SvgLbytvtJDv1
X-Gm-Gg: AYBFou1k6okqhmup+n4IfiE04xZgmsCI1KAWl/rvF7aXz1VA0MrbRclJtfGyWcd3Jex
	RAh5gle868AUvCHeysULgv30qOqtEGye5Mx/ubmdpnXQ6Gx5JQN6W+779h1lo883/9vZe3VlUEb
	lp/6C+a4TT2sPxXBOV9JrWsJBv1pw5YCcAN0omzjSbnt7bHh7yuiGF1bZUjZQsYNEtsys5/+MDQ
	dgzbI+cigd62WePQyXWVntgfJyRDWWf12mMANkrfyJWMMzIuiGilTdwaLzBEGFOsTCkGbmLnDnG
	8SRwxG3O7syImyj+M1tERJ5WBvdZ3kRZoTPlViMOZyzT5Sd6z1VCcCzbauLoo7ZFJNaZaAmoNRD
	9jQxO/WxizirAwRuFTZ/yZgVttx6DQP5kL7btEPXKNQpwxRI+spkvLNNPFCOhkL6oFIHK2FhLvP
	B1Sa27nRBpyB4+euf5kWNeZquNC1MjiGEO8R+j/fzF9eih3Smowif479qHm3IfhmRbCBWcDbpdP
	jb7fSrvUZAz9dXzF1+gIqreF3FwR9f21XXC9LCIb0JA3Al24RnWpoosbTAtUYKb5VaTqCbM+48l
	Db5+LAZ4Azv/6qaUXqDgMhuD
X-Received: by 2002:a17:903:4690:b0:2e5:dbbb:6c7f with SMTP id d9443c01a7336-2eb00158002mr39139165ad.1.1793243958250;
        Wed, 28 Oct 2026 20:19:18 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c3362esm27767765ad.44.2026.10.28.20.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 20:19:17 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH ipsec] xfrm: keep the mode module pinned until destroy_state returns
Date: Thu, 29 Oct 2026 11:19:11 +0800
Message-Id: <pm-xfrm-core-objects-candidate-0003-v3-3f3e13b81234df0bb10f@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An IPTFS state keeps its mode module referenced while mode_data exists.
However, iptfs_destroy_state() drops that reference before returning to
xfrm_state_gc_destroy(), which has no reference covering the callback's
return path.

With CONFIG_XFRM_IPTFS=m and module unloading enabled, deleting the last
IPTFS SA can overlap with ordinary module removal in this order:

  XFRM GC worker                      rmmod xfrm_iptfs
  iptfs_destroy_state()
    free mode_data
    module_put(owner)
    <preempted>
                                      delete_module()
                                        xfrm_iptfs_fini()
                                          unregister mode callbacks
                                        free_module()
    resume in freed module text

An unload started after the put can finish before the callback resumes.
GC invokes the callback outside an RCU read-side critical section, after
its grace period. The RCU waits in mode unregistration and module
freeing therefore do not protect the callback. The GC mutex only
serializes GC with device state flushes. Resuming the callback can cause
an instruction-fetch fault in the freed module text.

The Oops below was observed on an earlier kernel with scheduling probes
holding the worker in module_put() after the decrement until ordinary
rmmod completed. The fixture created and deleted the SA over
NETLINK_XFRM.

Take an additional reference to the already pinned owner before calling
destroy_state(), and release it in XFRM core after the callback returns.
Cache the owner before the call so releasing the extra reference does
not need to access the callback table after the callback has finished.

Oops report as below:
    BUG: unable to handle page fault for address: ffffffffc0407455
    #PF: supervisor instruction fetch in kernel mode
    #PF: error_code(0x0010) - not-present page
    PGD 80a9067 P4D 80a9067 PUD 80ab067 PMD 0 
    Oops: Oops: 0010 [#1] SMP KASAN NOPTI
    CPU: 3 UID: 0 PID: 53 Comm: kworker/3:1 Not tainted 7.2.0-rc5-pmb-xfrm-functional-v1+ #11 PREEMPT(lazy) 
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: events xfrm_state_gc_task
    RIP: 0010:0xffffffffc0407455
    Code: Unable to access opcode bytes at 0xffffffffc040742b.
    RSP: 0018:ffff8881013e7aa0 EFLAGS: 00010282
    RAX: 0000000000000000 RBX: ffffffffc02199c0 RCX: ffffffff816fc84e
    RDX: ffff8881013c0000 RSI: 0000000000000000 RDI: ffffffff86338344
    RBP: ffff8881013e7ba8 R08: 0000000000000001 R09: 0000000000000001
    R10: ffffffff893e0257 R11: ffff8881013c0000 R12: ffff888107e9ec00
    R13: ffff888102b07980 R14: ffff888107412ec0 R15: ffff8881013e7ae0
    FS:  0000000000000000(0000) GS:ffff8881fd929000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffffffffc040742b CR3: 00000000080a6006 CR4: 0000000000770ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ? pmbd_gate_maybe+0x47/0x60
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     xfrm_state_gc_task+0x17e/0x790
     ? lock_acquire+0x17b/0x2f0
     ? __pfx_xfrm_state_gc_task+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     ? srso_alias_return_thunk+0x5/0xfbef5
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kthread_parkme+0x175/0x220
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x34f/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf80
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>
    Modules linked in: [last unloaded: xfrm_iptfs]
    CR2: ffffffffc0407455
    ---[ end trace 0000000000000000 ]---
    RIP: 0010:0xffffffffc0407455
    Code: Unable to access opcode bytes at 0xffffffffc040742b.
    RSP: 0018:ffff8881013e7aa0 EFLAGS: 00010282
    RAX: 0000000000000000 RBX: ffffffffc02199c0 RCX: ffffffff816fc84e
    RDX: ffff8881013c0000 RSI: 0000000000000000 RDI: ffffffff86338344
    RBP: ffff8881013e7ba8 R08: 0000000000000001 R09: 0000000000000001
    R10: ffffffff893e0257 R11: ffff8881013c0000 R12: ffff888107e9ec00
    R13: ffff888102b07980 R14: ffff888107412ec0 R15: ffff8881013e7ae0
    FS:  0000000000000000(0000) GS:ffff8881fd929000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffffffffc040742b CR3: 00000000080a6006 CR4: 0000000000770ef0
    PKRU: 55555554
    Kernel panic - not syncing: Fatal exception
    Kernel Offset: disabled

Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM

---
 net/xfrm/xfrm_state.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 0555e5d796ed..45a52771796b 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -596,8 +596,14 @@ EXPORT_SYMBOL(xfrm_state_free);
 static void xfrm_state_delete_tunnel(struct xfrm_state *x);
 static void xfrm_state_gc_destroy(struct xfrm_state *x)
 {
-	if (x->mode_cbs && x->mode_cbs->destroy_state)
+	if (x->mode_cbs && x->mode_cbs->destroy_state) {
+		struct module *owner = x->mode_cbs->owner;
+
+		/* The callback may drop the last module reference. */
+		__module_get(owner);
 		x->mode_cbs->destroy_state(x);
+		module_put(owner);
+	}
 	hrtimer_cancel(&x->mtimer);
 	timer_delete_sync(&x->rtimer);
 	kfree_sensitive(x->aead);
