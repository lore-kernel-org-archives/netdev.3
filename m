Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105AD25B091
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312448; cv=none; b=gfqFOR6NWOmVCrwaAtKg9+ozuxeg7Eo7vE4DUCpHmA4Qdvxe9rUS+Dlhm5JK9wtArlVfaish/VSpIgxTyZJRneifMJQykYduJNMCPUNK9ekPcxRu2rNTggpok9gFm4fHdtsGkP5oaTsJCqo8gwvgvwMqT2278Ki7mj16/sqyVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312448; c=relaxed/simple;
	bh=A9mTlES4FiyEUqT0WGAsmz3K/NCW6vy/k/LsAtk1d8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PVEzaLyfXzhHw3OWf8zg9mbzVEapVmt6eMZvPsqPznWCY0ZiEQpWFR9laM5A4CyYOKRgP8NXJ65cOOGuZOeu8EK6gWV5hweuiB+b705bQRYbrHHbmrHMfcQhGv7QyGhMNPwmhXBRpwzG1lswtDqdgXnYlrRcloRknDazxB+1/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZLI9iH+1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLI9iH+1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0532a6588so14189235ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781312446; x=1781917246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=59VkZjXi77YrzRnYn71Nazu4YDPodmcJtnPO0AYyw1M=;
        b=ZLI9iH+11xXEj/pg+LcwMtSEbRa/xhdzykB0wLttyGmhefvQUtCV2xaB1srqmt+zpk
         3CBXzNCTVg5Pdou8reUXl3y4d7WhnOS3LRut9WDk7PVSqJyMqCcun5tsllbPZveRgfoH
         Q6eLBagwGBTsUxfh8SV0wMobPcGs3iqfy92JTlg5+dI33Q0oNUqEwwGwttRc+gI+xlkF
         r4dYOZ8a9Guq+MmXy4LngFxujTBs/cVxQmsfHLYgubn9E7w/npcZvrP8tRzPAvcr2sAu
         PlWqNuTFKKo3PC1Qwgid1HdVNtzjwzUimorDIV8RXg790wT1dsEYqofc3ehZOBvlnqBT
         4lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781312446; x=1781917246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59VkZjXi77YrzRnYn71Nazu4YDPodmcJtnPO0AYyw1M=;
        b=OVWNKrn1P9HYC4AZyOpeaP+RbEihYIeCm1DPYi0+4rIFciyzxP+OzuT+I/ffSdhG2n
         K4ay3CXYnk9da0sDa136Lj6RAh5HhkkesX/otjjP0Hw27mK1qVnN1eMS2SQcxHoifXUp
         06EIAi7eulV8gC8tIILTM8TEfGiClAu35YvDQ/hHo8bFx/Kw6cxPGgHjmp4xJNMs+tLO
         p3sHA0psBHFY5bMN7R5eHy7GD1XzBOEt8VjOgBs2WigE6Bfa2e4wzaMgDInAuJO9J7cE
         BnZk+arZ4MYBJqSLAY3swo/jFT5kMnVqVHtibr6vodf/Rv1VuL8EB5iceSuvjKb8Ayyt
         tVUw==
X-Forwarded-Encrypted: i=1; AFNElJ8QQ7vFGtgH3UiDeZbKpTHIMlFjcV+tTLuYDyLstPMY0X6C6l+HR5giSYF5t87vBkfOMy8dIkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYL3rOOQgShsuoVB9+3NI8FnyWcrl+n8ye+5UMjyY2RzIABkQ
	aRA/Do3m6l3JqRs2Jqj0Be/yAuXOrN1RMNjNenmK4x3g6XG76swyAc+qKI/Tpm8qZmohLdPwiNA
	F2XP4Wg==
X-Received: from plmt11.prod.google.com ([2002:a17:903:3d4b:b0:2bd:9e00:f173])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8c:b0:2bf:1e59:d99
 with SMTP id d9443c01a7336-2c6641cae2fmr19608385ad.8.1781312446023; Fri, 12
 Jun 2026 18:00:46 -0700 (PDT)
Date: Sat, 13 Jun 2026 01:00:00 +0000
In-Reply-To: <20260613010039.1362312-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613010039.1362312-4-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 3/5] bpf: Add bpf_skb_set_hwtstamp().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have some hosts where packets come from special hardware
and are provided directly to userspace, bypassing the kernel
networking stack.

When standard socket applications are run on these hosts,
a userspace proxy is required to mediate traffic between the
hardware and the applications.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              ^     ^                               ^
  userspace   |     |                               |
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `--->|  virtual interface  |<---'
  kernel     | |   skb   +---------------------+
  -----------| |-----------------------------------------------
              |
              v
       +------------+
       |  hardware  |
       +------------+

However, even though the hardware fully supports timestamping,
the HW timestamps are not directly accessible to the socket
applications because the skb is consumed/injected by the proxy.

For RX flow, let's add a kfunc to update skb_hwtstamps(skb)->hwtstamp
at tc/ingress.

With this kfunc, the proxy can carry the RX hardware timestamp
via encapsulated packets (e.g. in GENEVE option) and BPF prog
can extract it into skb_hwtstamps(skb)->hwtstamp at tc/ingress
of the virtual interface above.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              ^     | encap packet                  ^ recv payload
  userspace   |     |  w/ RX hwtstamp               |  w/ RX hwtstamp
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `--->|       geneve0       |----'
  kernel     | |   skb   +---------------------+
             | |             |             ^
             | |             v             |
             | |          +------------------+  extract RX hwtstamp
             | |          |  BPF@tc/ingress  |   and set it to skb
             | |          +------------------+
  -----------| |-----------------------------------------------
              |
              | RX packet w/ RX hwtstamp
       +------------+
       |  hardware  |
       +------------+

This allows transparently proxying RX hardware timestamps to
the socket applications via SCM_TIMESTAMPING.

Note that bpf_skb_set_hwtstamp() calls skb_unclone() and
bpf_compute_data_pointers(), so it is marked as a packet-changing
kfunc.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Remove __packed and use unnamed bit-field in struct
    bpf_hwtstamp (Alexei Starovoitov)
  * Use skb_unclone() instead of skb_heaeder_clone() (Sashiko)
---
 include/linux/skbuff.h |  5 +++++
 kernel/bpf/verifier.c  |  9 ++++++++-
 net/core/filter.c      | 25 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 115db8c44db2..0f62f7cd22e1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4701,6 +4701,11 @@ static inline bool skb_defer_rx_timestamp(struct sk_buff *skb)
 
 #endif /* !CONFIG_NETWORK_PHY_TIMESTAMPING */
 
+struct bpf_hwtstamp {
+	ktime_t hwtstamp;
+	u64 :64;
+};
+
 /**
  * skb_complete_tx_timestamp() - deliver cloned skb with tx timestamps
  *
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..6b23577d001a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11191,6 +11191,7 @@ enum special_kfunc_type {
 	KF_bpf_session_is_return,
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
+	KF_bpf_skb_set_hwtstamp,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11283,6 +11284,11 @@ BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
+#ifdef CONFIG_NET
+BTF_ID(func, bpf_skb_set_hwtstamp)
+#else
+BTF_ID_UNUSED
+#endif
 
 static bool is_bpf_obj_new_kfunc(u32 func_id)
 {
@@ -11364,7 +11370,8 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 
 bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data] ||
+	       meta->func_id == special_kfunc_list[KF_bpf_skb_set_hwtstamp];
 }
 
 static enum kfunc_ptr_arg_type
diff --git a/net/core/filter.c b/net/core/filter.c
index acdc66aa4f27..bee1e7eee5ea 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12372,6 +12372,30 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+__bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk_buff *s,
+				     struct bpf_hwtstamp *attrs, int attrs__sz)
+{
+	int defined_sz = offsetofend(struct bpf_hwtstamp, hwtstamp);
+	struct sk_buff *skb = (struct sk_buff *)s;
+
+	if (attrs__sz != sizeof(*attrs) ||
+	    memchr_inv((char *)attrs + defined_sz, 0, sizeof(u64)))
+		return -EINVAL;
+
+	if (!skb_at_tc_ingress(skb))
+		return -EINVAL;
+
+	if (skb_unclone(skb, GFP_ATOMIC))
+		return -ENOMEM;
+
+	skb_clear_tstamp(skb);
+	skb_hwtstamps(skb)->hwtstamp = attrs->hwtstamp;
+
+	bpf_compute_data_pointers(skb);
+
+	return 0;
+}
+
 /**
  * bpf_xdp_pull_data() - Pull in non-linear xdp data.
  * @x: &xdp_md associated with the XDP buffer
@@ -12500,6 +12524,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sched_cls)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
+BTF_ID_FLAGS(func, bpf_skb_set_hwtstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sched_cls)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
-- 
2.54.0.1136.gdb2ca164c4-goog

