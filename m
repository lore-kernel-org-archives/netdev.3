Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9C23C81B5
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900944; cv=none; b=ptsMvuOGeCUaY06Amob6f/0vN2URCioCLcsIaOBH00+3zLfFgjo1244QTXbRIQJBxXPGnBEwKHW+kYK3wfF5mzsaU4DK7s/t/HnGdpHLXLlBBfTgHsJPzCDc7jSgQwLrLc/R9xD7Hnu6uFmeHUEj3JmqEH7SIC1iyVhwkuX1EU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900944; c=relaxed/simple;
	bh=iQGvaY4A2XWpsFs/4qbmlFejoMEeU9G0r/eDjAiQTPA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P+IpizHUAbpN9NgbZMU2h/QDKnMIV/WYaJX2UQsN/3yPaICSPWbT7muBgSFDdOPP4WiiKOm0T0wEoIcyJ4qhEzUIXVJoOyritcvbGjhzMCb1c7XXTjVCJsyEgMzdFUABj8iRd+I/NYAN0LwD1CWlsD6P2ceXCoUmb/nQEWVis1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8mbxRFl; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8mbxRFl"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso1687265a91.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788900941; x=1789505741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3155qygpgPkRa/1v2IIFg/vH8DXuU6DW0fDr3ZFw9g=;
        b=u8mbxRFlkNNeOpUDg5xe4+Ynf4aZnWGarwqzltcHDvk26/c9LytRFY3OtJqr3zecQ4
         +wYRnoGAxMvjSXF7srkObz952MQNpyZcfmGN4l/9evoW3IKM+WmvGm4PJrE39dH3kcME
         h8vLrO7F+shZdGSb3nVrNEBDy/oqJrbyWgAL+MmzrA/lbJEqstLwXBKpxCyM2i3Tm402
         pMWGHY7DorFOBPJNJgHZVLEMvLGN6OWG7f3ZBhXQDH3GX1edl1cPNpUvH9Hm7x6xbq89
         SOAdPt4TLW6PIv6thaoxVWp6NRJVfT5SBTymvc65XN725fONQdU09QY6Xr3WqZVZxngy
         Cj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900941; x=1789505741;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3155qygpgPkRa/1v2IIFg/vH8DXuU6DW0fDr3ZFw9g=;
        b=YpLJrHRQdpZwXgVzmGecKeMi5YoHfwVnrXHvyuRZSreoSf85ZrOD5cnOg3L8zBHVik
         rFKTUEM/0+ymVBbuZyZ7hWIQdb5K9nVdcGK9C47vo9n8U8cJ9bD9Sbwrs+rV4LPCOTMr
         QmzKIvU3wwEKXBTQKeu1XjmV7qpyVO4Pj3x5DypoxAVdGmJRcfQkT/PSH4UFZPZEA3oL
         J/9YR6yo1K2k+1EQFQz2WacMnzKYmFzj6h/03ALshuj9ZppSEWtjOsnfUNN0+IMEXWwf
         VpaK2XkKyIAaXKlsHVe7nRbZGr20Qi7YLYZr6SvPTnHbMIUmFR0YkvLM1qhfQutcgMlh
         oA8A==
X-Forwarded-Encrypted: i=1; AKwUvBzawhYAlbsx/J56p93WJSXDdpEcuUu8yAd3Gg/vUxIWuTiIjYMdkWgXwWYuOxC0I0SKLwowuHs=@vger.kernel.org
X-Gm-Message-State: AFuF++lv6SMMPzS1+nHS4H5qVxfQRapprkl6nJaxmQ8+dmBeytcAaxNg
	m1PFwfCEEo7ZmaPxZ1yaHqhZztFRVqTGvI/kLYbHC2EhiFkGoCk++669HPTfEUqj0l8NFx9qfO8
	1nb8G4A==
X-Received: from pjbnm21.prod.google.com ([2002:a17:90b:19d5:b0:398:df3f:7569])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:534e:b0:398:ba0e:96f6
 with SMTP id 98e67ed59e1d1-39b2624f0f4mr45085659a91.23.1788900941263; Tue, 08
 Sep 2026 13:55:41 -0700 (PDT)
Date: Tue,  8 Sep 2026 20:55:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908205537.863484-1-kuniyu@google.com>
Subject: [PATCH v1 net] net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"

If a netlink socket sends RTM_GETCHAIN requests repeatedly
without recv()ing the responses, tc_ctl_chain() hogs CPU and
triggers Hung Task splat. [0]

As caught in the stack trace, netlink_attachskb() could confuse
tc_ctl_chain() by returning -EAGAIN when the userspace netlink
socket's receive buffer is full.

The replay: label exists since commit 32a4f5ecd738 ("net: sched:
introduce chain object to uapi") but was not used initially.

Since commit 9f407f1768d3 ("net: sched: introduce chain templates"),
the label is needed for RTM_NEWCHAIN because tcf_proto_lookup_ops()
may release RTNL to call request_module().

However, the replay logic is unnecessary for RTM_GETCHAIN.

Let's apply the replay logic only for RTM_NEWCHAIN.

[0]:
INFO: task repro:1018 is blocked on a mutex likely owned by task repro:1022.
task:repro           state:R  running task     stack:14096 pid:1022  tgid:1014  ppid:961    task_flags:0x400040 flags:0x00080000
Call Trace:
 <TASK>
 ? clockevents_program_event (kernel/time/clockevents.c:372)
 ? pskb_expand_head (net/core/skbuff.c:615)
 ? skb_release_data (net/core/skbuff.c:1122)
 ? netlink_attachskb (./include/linux/skbuff.h:1323 ./include/linux/skbuff.h:1332 net/netlink/af_netlink.c:1232)
 ? __netlink_lookup (./include/linux/rcupdate.h:882 ./include/linux/rhashtable.h:711 net/netlink/af_netlink.c:499)
 ? tc_chain_notify (net/sched/cls_api.c:3045)
 ? tc_chain_notify (./include/linux/skbuff.h:1384 net/sched/cls_api.c:3041)
 ? netlink_unicast (net/netlink/af_netlink.c:1335)
 ? rtnl_unicast (./include/net/netlink.h:1198 net/core/rtnetlink.c:985)
 ? tc_ctl_chain (net/sched/cls_api.c:3242)
 ? rtnetlink_rcv_msg (net/core/rtnetlink.c:7146)
 ? netlink_unicast (net/netlink/af_netlink.c:1354)
 ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:7177)
 ? netlink_rcv_skb (net/netlink/af_netlink.c:2556)
 ? netlink_unicast (net/netlink/af_netlink.c:1319)
 ? netlink_sendmsg (net/netlink/af_netlink.c:1900)
 ? __sock_sendmsg (net/socket.c:800)
 ? __sys_sendto (net/socket.c:2281)
 ? __x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:2284)
 ? do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
 ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
 </TASK>

Fixes: 2ed9db3074fc ("net: sched: cls_api: fix dead code in switch")
Reported-by: Taras Madan <tarasmadan@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sched/cls_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 9966766661d5..c47d2ee13641 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3254,7 +3254,7 @@ static int tc_ctl_chain(struct sk_buff *skb, struct nlmsghdr *n,
 	tcf_chain_put(chain);
 errout_block:
 	tcf_block_release(q, block, true);
-	if (err == -EAGAIN)
+	if (err == -EAGAIN && n->nlmsg_type == RTM_NEWCHAIN)
 		/* Replay the request. */
 		goto replay;
 	return err;
-- 
2.55.0.979.g7e5102b832-goog

