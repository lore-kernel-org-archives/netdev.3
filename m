Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A464C33EB
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578361; cv=none; b=s4onu7mc3+X0OONgY2aSCVglG3++l9Q43K6oszArA45kSLG2qH8eDKdQd2U1jbozt0n4+G7f2iKE3E4iKs77E3CNJ/esOCr9R/A9+F7fmyP0cNhjaCbGCZAvIAq3/JFaSTZsnyN0up5LqtYFUIoO0Xso9r3JCVLqcBAbAQfoSkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578361; c=relaxed/simple;
	bh=smJ+btUvyMLpW0nuhiUI/rkR6uCBK8iVhTfHqjujkSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZ5pg6S2/gvowXdjMDhKDmnmSmWHOtTQ9CQZ/xlE4EGZcDjc6CM+uoZ19L1Nu+jNh5p906/IEuv4bTFEndZq2Hs7P390r3rhQFDywkStYNPQWwJ1oJkd8c1XFLKeFpAsJ9pW8orzodqFmeHnBeRSpv13bp/94vJ5klF+GTFsNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrCFgB6K; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrCFgB6K"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8633a38df87so737123b3a.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789578346; x=1790183146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ta4GSV/f1iLNEWqw1UGps6Q7e0Yo7MBD3Lwe9oPDxDU=;
        b=ZrCFgB6KEmBBpSp9MsFkOlHWODtu47M9B3167cFSXhXdoB8fp2QoJaww1nTouIayPT
         H3ePAACLnA0yBA1dQSEQdXjKBLLpIzeZYlJ7tet0bsf7AaO1/ezUVZ7UfrXhoqCMKQ/t
         nBw+pzeCv6XD4lZhO15aB2uqO0wd6zr4Bhz9KcvEXOiOihzJZDOGW9CYzuOR+KowoRLk
         IflIMJ6LGX8e8Kq+IrfcMjM8Gr/ifAgWMQVAog+JYytBC7O43hWdmesueZOoJBXoIupF
         QxeEzNKTUyRykzzoChjPjVHM882V1jLtQz3wTmCwzIeoJffO5XlkYCYLqydilwl+f3PN
         YWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578346; x=1790183146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ta4GSV/f1iLNEWqw1UGps6Q7e0Yo7MBD3Lwe9oPDxDU=;
        b=ah0xAVHL7z2ZC+JtzoChnpcv5bHREWeeYgVUsUY7N+Ee4T+5KG7BVGveyIXBo4lRCX
         HaO4edPaOuYyOJFO+s/olQgu+ElTNPEH6Qsh+uv1QCp23yU1fRF5CGF9LSmfz7HIRAkd
         ktSsQeqHKwlaKJKEx6HKunZAbAIo2T6lWV8vbLVGGXk7JL3Y1QA3sqS/iQf5ykEs8QT7
         apSlyfGQmkiqy223WKLeC9/7AM5VjmM9UIdawXFNYdY0b6yZ3tZ2/6LXZAy0OalaEVrY
         LAVPiz9UBsgjj6gOHnwAx+LtLEm8oQ/3lorxSUo3U34pSjHwexaD8JBpLTcHnTdW+my0
         Kh2w==
X-Forwarded-Encrypted: i=1; AKwUvBx5fuuqxwBmbkAfCWK1lnvUwnEYzaTp2ax8xuJdeCAl7WcBDEK27bjmGsFn+7qrNjaGLY5ahRY=@vger.kernel.org
X-Gm-Message-State: AFuF++nNo0z4ogPE+Ia24TNSMnANVL4ZcIw/HBcCuw91guO5ecZeaV6d
	ARQJa6o89Mz0rQ277x9a5NjwcakTUxsUYGIrq1PpuBX9bzy3zxmjwcXV
X-Gm-Gg: AYBFou2cxu5oLMT4CVavbT1/ZU3QRnlyZzz0osfujRVJfsy4YqAnubzffr8L527ZepS
	ciBV3+2SMzR3Nr+88N/YWyREtowq78eJ2Jem2bsts8uYLZsmjG/fcOZGAtEzwW6i//b+OQef695
	uEiKDd38fZktQhmJbGX4ZBlgbrYZV6DG7t2H57bDz522YaYd9zBnRUNnPrL5bY1fhw6URXvOBm2
	T3v0Zk9Dm2P16ez8xpsU0AlGRtbrpGm35aWppcXpFgPV71gcSVLw0kcySsZ+fRVBrzDdO11J+Y+
	u4XED7t4jDN5QHvpW6M6OmhWaNym3dePRUoDnLY0SsexCYDuB5RpccntBSIsRXperUDsvtyFOUN
	S2imla5SFbxS3Lvdu211b/0huwc0dj0FT9rrcovbiWyuYo8/NEn7jdK1sZTpf5anBZDg6K2Hna3
	6rd7hmbzU9Fj5U6ULzY45dleOXc4GF0fEKSeM2rLXH/qZhDZZqS0WVWJZc7mZ0V8NwU7n38ZlxK
	4ks37O4iLjuPReD41Puzv6lajN/+QWebORp4WzZMMo=
X-Received: by 2002:a05:6a00:ad84:b0:869:c368:3675 with SMTP id d2e1a72fcca58-87238f94fb7mr7145850b3a.17.1789578346003;
        Wed, 16 Sep 2026 10:05:46 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8720172b0d9sm1608450b3a.35.2026.09.16.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:05:45 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Peter Oskolkov <posk@google.com>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] bpf: clear stale IPv4 options after LWT encapsulation
Date: Thu, 17 Sep 2026 01:04:07 +0800
Message-ID: <20260916170406.1280954-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_lwt_push_ip_encap() rebases the network header after prepending an IP
header, but leaves IPCB(skb)->opt describing the inner IPv4 header.  An
ingress LWT route can consequently make an ICMP error interpret an
inner-header byte as an option length and copy 255 bytes into 40 bytes of
stack storage.  The trace decoded with scripts/decode_stacktrace.sh is:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo
  Write of size 255
  Call Trace:
   <IRQ>
   __asan_memcpy (mm/kasan/shadow.c:106)
   __ip_options_echo (net/ipv4/ip_options.c:96)
   __icmp_send (net/ipv4/icmp.c:949)
   ip_forward (net/ipv4/ip_forward.c:176)
   lwtunnel_input (net/core/lwtunnel.c:465)
   ip_rcv (net/ipv4/ip_input.c:612)
   __netif_receive_skb_one_core (net/core/dev.c:6264)
   process_backlog (net/core/dev.c:6728)
   __napi_poll (net/core/dev.c:7787)
   net_rx_action (net/core/dev.c:8007)
   handle_softirqs (kernel/softirq.c:645)
   do_softirq.part.0 (kernel/softirq.c:546)
   </IRQ>
   <TASK>
   __local_bh_enable_ip (kernel/softirq.c:473)
   __dev_queue_xmit (net/core/dev.c:4961)
   packet_sendmsg (net/packet/af_packet.c:3143)
   __sys_sendto (net/socket.c:2281)
   __x64_sys_sendto (net/socket.c:2288)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
   </TASK>

A helper-only reset can be restored by bpf_prog_run_save_cb(), while a
program without ctx->cb[] access can clone-redirect the skb before a
return-only reset.  Track active LWT runs and their control-block family
in the BPF network context.  When the control block is not BPF scratch
space, save its original contents and reset it immediately so clones see
the new-family layout.  After the program returns, restore that snapshot
when the verdict continues through the original protocol callback, then
invalidate the stale header metadata.  Verdicts that reroute or redirect
keep the new-family layout.

Preserve the state across nested runs and retain the ingress interface and
L3-slave state when the protocol family changes.

Cc: stable@vger.kernel.org
Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
- Save the incoming protocol control block for programs without ctx->cb[]
  access.
- Restore that snapshot before a verdict continues through the original
  protocol callback, then invalidate the rebased header metadata.
- Keep the eager new-family reset for clones and final reroute/redirect
  consumers.
- Add Cc: stable@vger.kernel.org.
- Correct the patch author and reporter attribution.
v1:
- https://lore.kernel.org/bpf/20260915170147.3943392-2-bestswngs@gmail.com/

 include/linux/filter.h | 10 +++++
 net/core/lwt_bpf.c     | 96 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 39decde7fc730..0edd3e6ce563f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -848,6 +848,15 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+#define BPF_RI_F_LWT_IP_ENCAP	BIT(5)
+#define BPF_RI_F_LWT_RUN	BIT(6)
+
+struct bpf_lwt_ip_encap_state {
+	int iif;
+	__be16 cb_proto;
+	bool l3slave;
+	bool cb_access;
+};
 
 struct bpf_redirect_info {
 	u64 tgt_index;
@@ -858,6 +867,7 @@ struct bpf_redirect_info {
 	enum bpf_map_type map_type;
 	struct bpf_nh_params nh;
 	u32 kern_flags;
+	struct bpf_lwt_ip_encap_state lwt_ip_encap;
 };
 
 struct bpf_net_context {
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63de..4c0461b4dccf7 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -36,19 +36,103 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct lwtunnel_state *lwt)
 #define NO_REDIRECT false
 #define CAN_REDIRECT true
 
+static void bpf_lwt_reset_ip_cb(struct sk_buff *skb, __be16 orig_proto,
+				int iif, bool l3slave, bool use_new_proto)
+{
+	__be16 cb_proto = orig_proto;
+
+	if (use_new_proto)
+		cb_proto = skb->protocol;
+
+	if (cb_proto == htons(ETH_P_IP)) {
+		if (orig_proto == htons(ETH_P_IP)) {
+			memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
+		} else {
+			memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+			IPCB(skb)->iif = iif;
+			if (l3slave)
+				IPCB(skb)->flags |= IPSKB_L3SLAVE;
+		}
+	} else if (cb_proto == htons(ETH_P_IPV6)) {
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = iif;
+		IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
+		if (l3slave)
+			IP6CB(skb)->flags |= IP6SKB_L3SLAVE;
+	} else if (orig_proto == htons(ETH_P_IP)) {
+		memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
+	}
+}
+
 static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		       struct dst_entry *dst, bool can_redirect)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	struct bpf_lwt_ip_encap_state nested_lwt_ip_encap_state;
+	struct bpf_redirect_info *ri;
+	union {
+		struct inet_skb_parm ip4;
+		struct inet6_skb_parm ip6;
+	} saved_cb;
+	bool lwt_ip_encap, nested_lwt_ip_encap, nested_lwt_run;
+	__be16 orig_proto = skb->protocol;
+	bool use_new_proto;
+	bool l3slave = false;
+	int iif = 0;
 	int ret;
 
+	if (orig_proto == htons(ETH_P_IP)) {
+		iif = IPCB(skb)->iif;
+		l3slave = ipv4_l3mdev_skb(IPCB(skb)->flags);
+	} else if (orig_proto == htons(ETH_P_IPV6)) {
+		iif = IP6CB(skb)->iif;
+		l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
+	}
+
 	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
 	 * BPF prog and skb_do_redirect().
 	 */
 	local_bh_disable();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+	ri = bpf_net_ctx_get_ri();
+	nested_lwt_run = ri->kern_flags & BPF_RI_F_LWT_RUN;
+	nested_lwt_ip_encap = ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
+	if (nested_lwt_run)
+		nested_lwt_ip_encap_state = ri->lwt_ip_encap;
+	ri->kern_flags &= ~BPF_RI_F_LWT_IP_ENCAP;
+	ri->kern_flags |= BPF_RI_F_LWT_RUN;
+	ri->lwt_ip_encap.iif = iif;
+	ri->lwt_ip_encap.cb_proto = orig_proto;
+	ri->lwt_ip_encap.l3slave = l3slave;
+	ri->lwt_ip_encap.cb_access = lwt->prog->cb_access;
+	if (!ri->lwt_ip_encap.cb_access)
+		memcpy(&saved_cb, skb->cb, sizeof(saved_cb));
 	bpf_compute_data_pointers(skb);
 	ret = bpf_prog_run_save_cb(lwt->prog, skb);
+	lwt_ip_encap = ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
+	ri->kern_flags &= ~BPF_RI_F_LWT_IP_ENCAP;
+
+	use_new_proto = (ret == BPF_LWT_REROUTE &&
+			 lwt->prog->type != BPF_PROG_TYPE_LWT_OUT) ||
+			(ret == BPF_REDIRECT && can_redirect);
+	if (lwt_ip_encap) {
+		__be16 cb_proto = orig_proto;
+
+		if (!ri->lwt_ip_encap.cb_access) {
+			if (use_new_proto)
+				cb_proto = ri->lwt_ip_encap.cb_proto;
+			else
+				memcpy(skb->cb, &saved_cb, sizeof(saved_cb));
+		}
+		bpf_lwt_reset_ip_cb(skb, cb_proto, iif, l3slave,
+				    use_new_proto);
+	}
+	if (nested_lwt_run)
+		ri->lwt_ip_encap = nested_lwt_ip_encap_state;
+	else
+		ri->kern_flags &= ~BPF_RI_F_LWT_RUN;
+	if (nested_lwt_ip_encap)
+		ri->kern_flags |= BPF_RI_F_LWT_IP_ENCAP;
 
 	switch (ret) {
 	case BPF_OK:
@@ -604,6 +688,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool ipv4, int encap_len)
 
 int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 {
+	struct bpf_redirect_info *ri;
 	bool is_udp_tunnel;
 	struct iphdr *iph;
 	bool ipv4;
@@ -657,6 +742,7 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	memcpy(skb_network_header(skb), hdr, len);
 	bpf_compute_data_pointers(skb);
 	skb_clear_hash(skb);
+	ri = bpf_net_ctx_get_ri();
 
 	if (ipv4) {
 		skb->protocol = htons(ETH_P_IP);
@@ -669,6 +755,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 		skb->protocol = htons(ETH_P_IPV6);
 	}
 
+	if (ri->kern_flags & BPF_RI_F_LWT_RUN) {
+		ri->kern_flags |= BPF_RI_F_LWT_IP_ENCAP;
+		if (!ri->lwt_ip_encap.cb_access) {
+			bpf_lwt_reset_ip_cb(skb, ri->lwt_ip_encap.cb_proto,
+					    ri->lwt_ip_encap.iif,
+					    ri->lwt_ip_encap.l3slave, true);
+			ri->lwt_ip_encap.cb_proto = skb->protocol;
+		}
+	}
+
 	if (skb_is_gso(skb))
 		return handle_gso_encap(skb, ipv4, len);
 
-- 
2.55.0
