Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417342;
	b=hv3oOfpVPyc5qy5nggRTzWIwsd0iQENrnYtKn+ffdle7uwufZezTfCcvuRjSlWJJmIma
	 DMkqddn2V+GWdrJ3H6WgUlnM5rTZ8eN4G5vIz4J+7eWzTRGunRpdbNBCrwQXCCqx+CnLo
	 39I4Vsc1HrRzWiNVJpXOLXXW4SZ1AZ9jQgckuDInut8UWiY9xu/L/thLpwnk/I2B9/5ei
	 2DS5BC4nrISwSS3uQ/7Xoayk+3xEm0SgQeyKT9dw8HJSux6+yQ/IqvP4uE1XM2dJurpjb
	 LR2Vrt+5P1Tse0QYVUkQ8gEM7uFjgswRMNR3fDf+yaluvdOuYdc9DUJ4xbvrNE6tODA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1N2EKxe4+D8kbS8GIyKffFYzwAu5vWlJZDnR/Bowz7k=;
	b=fcpb3QnE+7yYRh2mF7TVMK9Z3hvN+oAWcakGQUSQDQTIimabvC2DrkNfXlI/0LjxTxIu
	 BRMpy5pr61KX4UwOkbHmg/fAW7DNDqAD23RhHIIPhyxmbp/4uW1kf3AIrha2wXaRjdO/0
	 2O7HxyM/mzdtTWhRL3EGMbTEwQSqNLxQmTpapTwcBhlTxqOOveuiYEtvd14s/eFz6nqgQ
	 NESrnwhoe9UQ2zWsrBFzuNWjrhgJQb7EBaXOFeNyOy+AXJ1JJWG5R8LJqPNt36F2b4XwB
	 jskruQXpioM3ZsxrQP7WprPnr41bWNvKkuI7W0NN06dmzrbaKLBWEkUSLpk1tA1n9rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="B866/7E6";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D880606A320
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 03:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D880606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B866/7E6
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so1039731a91.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 20:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793417341; x=1794022141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1N2EKxe4+D8kbS8GIyKffFYzwAu5vWlJZDnR/Bowz7k=;
        b=B866/7E6LhW9/o2mvXurj/6USSVl4HqQuX5SPr0eX1t9NLuZu5Q+O1BvoUkKx2rBwx
         oTtw/GOVwtSdK13++1h22K8z1hbdvP/CQwU/JmMXbPKOPTL9BA5MvfeldUrLO8X8VN7X
         mJCCJmdZ3DxQHmBlYp/HKIgYvnIigJClrrY3hPIGvszTnkYsGzMdZuTGbEiNMOpOR9bn
         NKfn5gDc1KOnk0Ms5JqZeWZL43fUQT7RmVBP9U1XqThuEnGfMwcO/FATlIjCQIH8Bi3k
         0fDUzA+WucqMVdTWNHXXxJ0OQ9NZxyEjgIb1g0jmBLQRE0jpquec4PmyUBob81H+Wl3R
         Sb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417341; x=1794022141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1N2EKxe4+D8kbS8GIyKffFYzwAu5vWlJZDnR/Bowz7k=;
        b=Dk7Jt1K/gb1aD6P5GHrcweLX1UEGP3dGi10fp44d8FTQAkPRR5yR+RE2RefDZw8xCu
         qwdSqc0OdMqY1l+TqEMG9GuIckBJ+0R6wq1B5o37xQSu+TeJMZqbdTOJ8dCO+He8+0Xr
         ush/YevP3g5zMGJTzJtZp5gxRBUNvQ6fsDUBMGKtNeiVjuhk2YeAPcKs+ngJczuJm2k/
         nLvEkp1ldkHLufnMZArJ0aSFrmwr5lQ+bPjc9aqS5CFQXERi2tFQ6pIJ/WVZpqEZzq+3
         YwoaWXK8+ATS8ShJaehcaN8SZqQBSnfAwvMSlpA1A6kL01JZraQDut6zMNblwOZRjzFs
         DEjw==
X-Forwarded-Encrypted: i=1; AKwUvBw6/oscLLFodAMpzY1mqQljxLZ0nRpS/bhh+YY8Dz+/rXwukwV3fgwhzTOimyi1WUVnjpluLqs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzPXwmgU+mlwsD0mhUjoXQYeF53F/RoCa0K0479aR8P2AdubMx
	086mVY+BgyvtRcxsaoDEP1xskHFlpNuCtBDFH8jGrMHhFtkJLdpQ1Zf1
X-Gm-Gg: AYBFou0jbNRAINvF2qwMEOE7dklmfbhtEliHqGHHASnjIqAFD93dpKKJXq6qIGF8/S/
	NWOxmd7VAeDIWFzsGhnwP4LHTVHREbh+W93uF1KWdMbJKl+x2eD7fiI4sRecz484wVhx57kg4sO
	w4VN+xZlkPIRqducLTPKuGDGup7SeVP6Z1gFoAmspEmZMS9W1SxEH3jitkKCGie+J94b2zerj+O
	ihwXRr8cmoNrq7+n7v5fRLRZ+ubQEJe5hWceaCbd2qYk0BHxgdNLokYccOuVRJxYVk5au/fdpm7
	JlG08cQX6zfdS6HZ67TeD8N9hhyimV3dPip0ur5z/88DjL3++k/Jy6NjjqnEsUxprBIOPQkRQ9Z
	mDibFf2QCa1ttZvyttwgQyqWoGLIhiWPrBG0j1tEa6rWSAfo+PIcqyULchqp7EcpkreGN4YLKhm
	m9prn9M6t047QA4I3SZCVCm36tS/ftbKW8UV6mhk4DoL9ZZgwtkaUxm1R/cOaiEyeqUNHOrx7vG
	QBgHJlAI41OqBNbSEmuy+rWk0n3dAptann0JybhXcve9YN8iqATVeGRXKgpNVfEy/ypYXOzfuqZ
	foFyiaiwDt1AnW60C2emYuY4
X-Received: by 2002:a17:90b:2805:b0:3ad:adfe:5854 with SMTP id 98e67ed59e1d1-3ae89817e7amr3599239a91.40.1793417341427;
        Fri, 30 Oct 2026 20:29:01 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87ee7765sm3212773a91.2.2026.10.30.20.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:29:01 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	antony.antony@secunet.com,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH ipsec v2 1/2] xfrm: protect offload statistics updates from device teardown
Date: Sat, 31 Oct 2026 11:28:48 +0800
Message-Id: <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-0@gmail.com>
References: <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-0@gmail.com>
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

copy_to_user_state() refreshes the statistics of an offloaded SA through
the driver's xdo_dev_state_update_stats() callback. GETSA and SA
notifications run it with only a reference to the xfrm_state, which does
not keep the offload binding alive, and the netlink configuration mutex
does not serialize them with the netdevice notifier.

NETDEV_DOWN and NETDEV_UNREGISTER flush the device's states with
xfrm_dev_state_flush(). It deletes each state under x->lock and then
calls xfrm_dev_state_free() without that lock, which lets the driver
free its offload state, clears xso.dev and drops the device reference.
A refresh that has already seen xso.dev set can then run the driver
callback on freed offload state or after xso.dev became NULL, and can
read the net_device after unregistration has freed it:

  GETSA                              Device teardown (RTNL)
  -----                              ----------------------
  look up and reference x
  copy_to_user_state(x)
    x->xso.dev is set
                                     xfrm_dev_state_flush()
                                       xfrm_state_delete(x)
                                       xfrm_dev_state_free(x)
                                         xdo_dev_state_free()
                                         clear x->xso.dev
                                         netdev_put(dev)
                                     unregister frees dev
    xfrm_dev_state_update_stats(x)
      reads dev->xfrmdev_ops

The expiry timer has the same problem. It refreshes the statistics
before it checks for a dead state, and it can still fire after the
flush has deleted the state.

Every path that frees the offload state of a reachable SA marks the SA
dead under x->lock first. Refresh the statistics only for SAs that are
not dead, with x->lock held, so a refresh either completes before the
teardown or sees the dead state. GETSA, ALLOCSPI replies and SA
notifications now take x->lock around the copy. Expire notifications
already run under x->lock. Dumps run under xfrm_state_lock while the SA
is still linked, and deletion needs that lock before the offload state
can be freed. The timer now checks for a dead state before the refresh.
A dead SA keeps the counters from its last refresh.

The report below was collected on an earlier kernel with a built-in test
device that supplies no-op offload add and delete callbacks. Scheduling
probes paused GETSA after it sampled the device, then ran normal
link-down and link-delete requests before resuming the read.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in copy_to_user_state+0x6ce/0x6e0
    Read of size 8 at addr ffff888104be0308 by task ip/446

    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     kasan_report+0xe0/0x110
     copy_to_user_state+0x6ce/0x6e0
     copy_to_user_state_extra+0x8a/0x1450
     dump_one_state+0x1fd/0x440
     xfrm_state_netlink+0xda/0x150
     xfrm_get_sa+0x12d/0x320
     xfrm_user_rcv_msg+0x3b3/0xc20
     netlink_rcv_skb+0x133/0x390
     xfrm_netlink_rcv+0x76/0x90
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     ____sys_sendmsg+0x88b/0x9d0
     ___sys_sendmsg+0x125/0x1d0
     __sys_sendmsg+0x13e/0x1e0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
     </TASK>

    Allocated by task 420:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kvmalloc_node_noprof+0x353/0x930
     alloc_netdev_mqs+0xa0/0x1250
     rtnl_create_link+0xb8e/0xeb0
     rtnl_newlink+0xb7b/0x1f40
     rtnetlink_rcv_msg+0x7b9/0xce0
     netlink_rcv_skb+0x133/0x390
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     ____sys_sendmsg+0x88b/0x9d0
     ___sys_sendmsg+0x125/0x1d0
     __sys_sendmsg+0x13e/0x1e0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 451:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     device_release+0xd7/0x280
     kobject_put+0x1ad/0x610
     netdev_run_todo+0x927/0x13d0
     rtnl_dellink+0x3aa/0xa30
     rtnetlink_rcv_msg+0x7b9/0xce0
     netlink_rcv_skb+0x133/0x390
     netlink_unicast+0x504/0x840
     netlink_sendmsg+0x7f7/0xcf0
     ____sys_sendmsg+0x88b/0x9d0
     ___sys_sendmsg+0x125/0x1d0
     __sys_sendmsg+0x13e/0x1e0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff888104be0000
     which belongs to the cache kmalloc-4k of size 4096
    The buggy address is located 776 bytes inside of
     freed 4096-byte region [ffff888104be0000, ffff888104be1000)
    ==================================================================

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Assisted-by: LLM

 net/xfrm/xfrm_state.c |  4 ++--
 net/xfrm/xfrm_user.c  | 10 +++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 0555e5d796ed..1aeb6208ea8f 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -649,10 +649,10 @@ static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
 	int err = 0;
 
 	spin_lock(&x->lock);
-	xfrm_dev_state_update_stats(x);
-
 	if (x->km.state == XFRM_STATE_DEAD)
 		goto out;
+
+	xfrm_dev_state_update_stats(x);
 	if (x->km.state == XFRM_STATE_EXPIRED)
 		goto expired;
 	if (x->lft.hard_add_expires_seconds) {
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a5fbe38839c4..781d4ec565aa 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1179,7 +1179,11 @@ static void copy_to_user_state(struct xfrm_state *x, struct xfrm_usersa_info *p)
 	memcpy(&p->id, &x->id, sizeof(p->id));
 	memcpy(&p->sel, &x->sel, sizeof(p->sel));
 	memcpy(&p->lft, &x->lft, sizeof(p->lft));
-	if (x->xso.dev)
+	/* Device teardown marks the state dead under x->lock before it frees
+	 * the offload state. Callers hold x->lock, or xfrm_state_lock while
+	 * the state is still linked.
+	 */
+	if (x->xso.dev && x->km.state != XFRM_STATE_DEAD)
 		xfrm_dev_state_update_stats(x);
 	memcpy(&p->curlft, &x->curlft, sizeof(p->curlft));
 	put_unaligned(x->stats.replay_window, &p->stats.replay_window);
@@ -1633,7 +1637,9 @@ static struct sk_buff *xfrm_state_netlink(struct sk_buff *in_skb,
 	info.nlmsg_seq = seq;
 	info.nlmsg_flags = 0;
 
+	spin_lock_bh(&x->lock);
 	err = dump_one_state(x, 0, &info);
+	spin_unlock_bh(&x->lock);
 	if (err) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -4167,7 +4173,9 @@ static int xfrm_notify_sa(struct xfrm_state *x, const struct km_event *c)
 
 		p = nla_data(attr);
 	}
+	spin_lock_bh(&x->lock);
 	err = copy_to_user_state_extra(x, p, skb);
+	spin_unlock_bh(&x->lock);
 	if (err)
 		goto out_free_skb;
 
