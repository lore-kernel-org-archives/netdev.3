Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367319;
	b=uVFyZtSeQZpAg+jIKiRTE682UPSnfaYJ84djSR+kNe19+06Y9iucTgDIWGfaKoPD03tb
	 8374rsNzTDa3OKup6XV1WphOilU2DwmNH8GlmugGXgqUU3gYQ5Ygn4H5mwccurKIjp6mS
	 y1VugZ7oxC9RIYPTEnoQ6JjhkXc8J7Fpl30ikNp0BcDfocUJ7lSCSRVttgXVJqYPdv/Re
	 SQVfHqHi/jF1fRyJLzo+mGsMfc+0WwaOTDNyH3D7HH+1WnYlJJ2VjRSBCVwDaE/XsVqPY
	 c6Ohi1CdSL21V0JOMwf6YjwUaclt1bom4a+xsqxOYRW0EUTsHIVwU5aityB1NyKDQ4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cbkg7m/iOR1aNdjTqRiCC3H1ik4TfAgb+sSh2QTc/OE=;
	b=ILXfXhzE/XYIpqs0FG2kiSVJTov2CA7qODj1p0Hd0Z50N91dhUvKnAh7l+tv8IjK3yPd
	 2NqZRI8N8uzp9LhLWAV/ko9+sxMGjvkLlG98g8RO/3Kog1CW9aEgrGBBXqIT6c5IHVGw7
	 5AJ6N2FabtEoQvR+9tGjFM/Q+9gvcNbB/WkAGjwFv4gCJkuylbSBrdd1tiPE7GXIvFyjw
	 biQaHNiQ8heegFZFv6HcQFVqDz28dZix7zQdVfVZ8gLDuXdc/p1R26AIKfNDPRkyzYGoX
	 SoVUWRVFIoj7qfb4Op3CvfI2+vFVVgmC1TQtcitqyPP8+fk11y8n4BbRTbKG+UbPJCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHEwGgRI;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86760A2623
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 03:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C86760A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHEwGgRI
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37198ed3727so3452633eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 19:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367317; x=1794972117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cbkg7m/iOR1aNdjTqRiCC3H1ik4TfAgb+sSh2QTc/OE=;
        b=JHEwGgRIAr5i60SI2IrifCNsnwa9zoilr4PVo1vCD2gAhza9h1WnlYqnT5epPzpdVR
         FwiUaNl5lvfdrJ50aIhyBmahLr4XnhILy7J34zfXni/x3WISyy9TVz5pbgUram/+00TV
         ox/fmtbGEGNRUr3nwzgyYsIrckJBxQwXEwMVnou0K/VVY/dWIq+LeivIakaDLOkpNWeL
         S/4AHcsSfEGuVMajrFyz5IlRPWQJYX9gO4ET9sJePCl/d4Ow3hX98MDShb/i0ZL2WNkT
         1UoEWcVPPaPDYi1YU7B8cro796+4KorOVyRYNUBhswuRk6sRl4azptF4od9hcDp7vEbg
         ZyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367317; x=1794972117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cbkg7m/iOR1aNdjTqRiCC3H1ik4TfAgb+sSh2QTc/OE=;
        b=a+p70UEF7LCqVUUzj8aVTwW3s8oDJ1/gJHHX9v2UCjOofS47Yk8hDMjDQ2YNSX4AS0
         8ljxFAy8E+qsAcRUBtHq8xdLMFGcBbOuf5HAnrm1bV+3ZRCcXRH+o63m2X6MWM1QD+L6
         dHLUeIMKu6wY7rFRWPOPtsh/cjddcYWbIcugv70a2bHhuAi7ormJ+/X66sb6Ph8+PhCw
         DNR0oOANJZQOjVdW6erXi0FcPuuqpNo8/HJJB/sUEHqtwKMVvoHb248TI5vV7M1ke6Bw
         jiuoo+nK9DbYi6eGXOTYbB+kCMlqz70KsxMIt/cQRQXDpvS2XxBXN580dQfdkg4aMPWt
         juQQ==
X-Forwarded-Encrypted: i=1; AL+hErH1XdTGzknrcwo9xD6/Z9XrBdcOG/LEpkResWNv3fuCs2n686iVSTMLtYDMA+BeCQJDum+ZtlU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ya17pYGwaypMo59ifauOPPydYe+jm9KwiDT/91ISKDp26NZRo
	0fJcNqWLuDTeJCl6Jk+4vY7viWhTDDlNJoZE/M5+xA8iF9RrvJEC2Gh6
X-Gm-Gg: AYBFou2uKyCDH9QAWucbfDMzdXWdKMreupFb4hKN7oxyeQ3G4XtDmohj6sCyZr0p/kq
	0yoIEKt539tGe7eksigYiUKqTOVEsNuYFytIa5D04ijujS5td83t5On6SPkWVvtCvKZCEtOAEld
	rzzZwKWLLSl4gUMujgjuxAk0TafbNfxyYLuq6MicULuez4g7rpWLx4ASFm8Zxf2J8eCgTaFERjk
	TfNvltygQCZaqBpPr6F6zI3j3FHDKDWCkFj9DYY2/EqIuzjp7QqPdj6Go4uywYJKafeb8XpAZuU
	aFBjgjNPLwvvjYxxXi+E9AohyPQCjAsabFMRFgmHoTW+11r2gN+UDOTqd8Ammlr3zJJ9NvtKuAg
	pzya0JW+HBJSwb4HmdXa/SDq6j0Ig3k5aWiGLm3rmNgzXlkErvrXWYDJiueQdNALjcoNhdjVjxS
	0XgmFfvF125k5otEKTXG+LAo9XCAzMLeXDMW2h+7+q2Kuac0jtXcQBDhpDbU255O2fhoKUPiaCX
	mTeP5M09H5nvJlq/sek/1H9zS1kZp+QFi/yhwmzHQpJIf+wYWyluAnEh63mzCIJEJjvT0XOt4gO
	3RZoHVEi2PLWey/sXb+STnjWs7UmzkMOZx8GJYxyM5opA4dGo8UZ3svKp0TQMLQ=
X-Received: by 2002:a05:693c:830b:b0:358:c5c9:2661 with SMTP id 5a478bee46e88-37686755b1amr1362827eec.10.1794367317128;
        Tue, 10 Nov 2026 19:21:57 -0800 (PST)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm9801896eec.0.2026.11.10.19.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:21:56 -0800 (PST)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [RFC bpf-next v3 2/3] bpf: Add PPPoE encap/decap kfuncs
Date: Tue, 10 Nov 2026 22:21:40 -0500
Message-ID: <20261111032141.525444-3-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111032141.525444-1-thisseanzhang@gmail.com>
References: <20261111032141.525444-1-thisseanzhang@gmail.com>
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

Add bpf_skb_pppoe_encap() and bpf_skb_pppoe_decap() kfuncs so that a
TC BPF program can encapsulate an IPv4 or IPv6 packet into a PPPoE
session frame, and decapsulate one again:

	bpf_skb_pppoe_encap(skb, sid, flags);
	bpf_skb_pppoe_decap(skb, flags);

The kfuncs insert or remove the 8 byte PPPoE session header between
the MAC header and the network header, and update the skb metadata to
match: skb->protocol is set to ETH_P_PPP_SES on encapsulation, or
restored from the PPP protocol field on decapsulation, mac_len is
reset, and the GSO metadata is adjusted like bpf_skb_adjust_room()
does (gso_size, gso_segs, SKB_GSO_DODGY).

Both kfuncs accept BPF_F_ADJ_ROOM_FIXED_GSO to leave gso_size
unchanged and only recompute gso_segs, reusing the existing flag
instead of adding a new one; UDP GSO packets require it, as their
gso_size is the datagram size. Unknown flags are rejected.

Previously, a TC program could add or remove the header bytes
manually, but the skb would keep a stale skb->protocol: forwarded GSO
packets larger than the PPPoE MTU could not reach the PPPoE
segmentation path registered for ETH_P_PPP_SES and could be dropped.
bpf_skb_adjust_room() cannot be used for the decapsulation direction
either, because it only accepts ETH_P_IP or ETH_P_IPV6 in
skb->protocol.

The encap kfunc fills in the PPPoE header itself from the session id:
version 1, type 1, code 0, and the PPP protocol derived from
skb->protocol, mirroring what pppoe_xmit() writes. The ethertype of
the MAC header remains for the BPF program, like with the existing
BPF_F_ADJ_ROOM_ENCAP_* flags. skb->encapsulation is deliberately left
unset, like pppoe_xmit() does: PPPoE is not an IP tunnel, and setting
it would narrow the device features to hw_enc_features in
netif_skb_features(). The decap kfunc accepts only PPP_IP and PPP_IPV6
payloads and requires a full inner L3 header to remain.

The kfuncs are registered for SCHED_CLS and SCHED_ACT with the new
KF_CHANGES_PKT flag, so the verifier invalidates packet pointers after
a call, like it does for bpf_skb_adjust_room().

PPPoE GRO/GSO support must be built in or loaded before this path is
used; loading pppoe.ko is left to user space.

Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>
---
 net/core/filter.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9..3d9143552 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -47,6 +47,8 @@
 #include <linux/ratelimit.h>
 #include <linux/seccomp.h>
 #include <linux/if_vlan.h>
+#include <linux/if_pppox.h>
+#include <linux/ppp_defs.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <net/sch_generic.h>
@@ -12919,6 +12921,184 @@ __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 	return 0;
 }
 
+/**
+ * bpf_skb_pppoe_encap() - Encapsulate an IPv4 or IPv6 packet in a
+ * PPPoE session header.
+ *
+ * Insert an 8 byte PPPoE session header, made of the 6 byte session
+ * header plus the 2 byte PPP protocol field, between the MAC header
+ * and the network header, and fill it in for the given session id.
+ * skb->protocol is set to ETH_P_PPP_SES so the skb reaches the PPPoE
+ * GRO/GSO support; the ethertype of the MAC header is left to the BPF
+ * program.
+ *
+ * A packet whose VLAN tag is still present in the packet data is
+ * rejected, as skb->protocol is then the VLAN ethertype.
+ *
+ * On GSO skbs, gso_size is reduced by the size of the inserted header
+ * and gso_segs is recomputed, like bpf_skb_adjust_room() does. With
+ * BPF_F_ADJ_ROOM_FIXED_GSO, gso_size is left unchanged and only
+ * gso_segs is recomputed; UDP GSO packets require this, as their
+ * gso_size is the datagram size.
+ *
+ * A call to this kfunc changes packet data. Therefore, at load time,
+ * all checks on pointers previously done by the verifier are
+ * invalidated and must be performed again, if the kfunc is used in
+ * combination with direct packet access.
+ *
+ * Parameters:
+ * @skb_ctx: Pointer to ctx (__sk_buff) in TC program. Cannot be NULL
+ * @sid: PPPoE session id, in network byte order
+ * @flags: BPF_F_ADJ_ROOM_FIXED_GSO to leave gso_size unchanged
+ *
+ * Return:
+ * * %0          - success
+ * * %-EINVAL    - unknown flags
+ * * %-ENOTSUPP  - skb->protocol is neither ETH_P_IP nor ETH_P_IPV6, the
+ *                 new length would exceed the maximum skb length, or the
+ *                 GSO metadata cannot be adjusted
+ * * %-ENOMEM    - the skb head could not be expanded
+ */
+__bpf_kfunc int bpf_skb_pppoe_encap(struct __sk_buff *skb_ctx, __be16 sid,
+				    u64 flags)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct pppoe_hdr *ph;
+	u16 ppp_proto;
+	u32 off;
+	int ret;
+
+	if (flags & ~BPF_F_ADJ_ROOM_FIXED_GSO)
+		return -EINVAL;
+
+	if (skb->protocol != htons(ETH_P_IP) &&
+	    skb->protocol != htons(ETH_P_IPV6))
+		return -ENOTSUPP;
+
+	if (skb->len + PPPOE_SES_HLEN > BPF_SKB_MAX_LEN && !skb_is_gso(skb))
+		return -ENOTSUPP;
+
+	off = skb_mac_header_len(skb);
+
+	ret = bpf_skb_net_grow(skb, off, PPPOE_SES_HLEN, flags);
+	if (ret < 0)
+		return ret;
+
+	if (skb->protocol == htons(ETH_P_IP))
+		ppp_proto = PPP_IP;
+	else
+		ppp_proto = PPP_IPV6;
+
+	ph = (struct pppoe_hdr *)(skb->data + off);
+	ph->ver = 1;
+	ph->type = 1;
+	ph->code = 0;
+	ph->sid = sid;
+	ph->length = htons(skb->len - off - sizeof(*ph));
+	put_unaligned_be16(ppp_proto, (u8 *)ph + sizeof(*ph));
+
+	skb->protocol = htons(ETH_P_PPP_SES);
+	skb_reset_mac_len(skb);
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
+	__skb_reset_checksum_unnecessary(skb);
+	bpf_compute_data_pointers(skb);
+
+	return 0;
+}
+
+/**
+ * bpf_skb_pppoe_decap() - Remove the PPPoE session header from a
+ * packet.
+ *
+ * Remove the 8 byte PPPoE session header between the MAC header and
+ * the network header. skb->protocol is restored from the PPP protocol
+ * field; a payload with any other PPP protocol is rejected. The
+ * ethertype of the MAC header is left to the BPF program.
+ *
+ * A packet whose VLAN tag is still present in the packet data is
+ * rejected, as skb->protocol is then the VLAN ethertype.
+ *
+ * On GSO skbs, gso_size is increased by the size of the removed
+ * header and gso_segs is recomputed, like bpf_skb_adjust_room() does.
+ * With BPF_F_ADJ_ROOM_FIXED_GSO, gso_size is left unchanged and only
+ * gso_segs is recomputed.
+ *
+ * A call to this kfunc changes packet data. Therefore, at load time,
+ * all checks on pointers previously done by the verifier are
+ * invalidated and must be performed again, if the kfunc is used in
+ * combination with direct packet access.
+ *
+ * Parameters:
+ * @skb_ctx: Pointer to ctx (__sk_buff) in TC program. Cannot be NULL
+ * @flags: BPF_F_ADJ_ROOM_FIXED_GSO to leave gso_size unchanged
+ *
+ * Return:
+ * * %0          - success
+ * * %-ENOTSUPP  - skb->protocol is not ETH_P_PPP_SES, or the PPP
+ *                 protocol is neither PPP_IP nor PPP_IPV6
+ * * %-EINVAL    - unknown flags, the packet is shorter than the PPPoE
+ *                 session header, or no full L3 header would remain
+ *                 after decapsulation
+ * * %-ENOMEM    - the header is not linearly accessible
+ */
+__bpf_kfunc int bpf_skb_pppoe_decap(struct __sk_buff *skb_ctx, u64 flags)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	__be16 inner_proto;
+	u32 inner_len, off;
+	u16 ppp_proto;
+	int ret;
+
+	if (flags & ~BPF_F_ADJ_ROOM_FIXED_GSO)
+		return -EINVAL;
+
+	if (skb->protocol != htons(ETH_P_PPP_SES))
+		return -ENOTSUPP;
+
+	off = skb_mac_header_len(skb);
+
+	if (skb->len < off + PPPOE_SES_HLEN)
+		return -EINVAL;
+
+	if (!pskb_may_pull(skb, off + PPPOE_SES_HLEN))
+		return -ENOMEM;
+
+	ppp_proto = get_unaligned_be16(skb->data + off +
+				       sizeof(struct pppoe_hdr));
+	switch (ppp_proto) {
+	case PPP_IP:
+		inner_proto = htons(ETH_P_IP);
+		inner_len = sizeof(struct iphdr);
+		break;
+	case PPP_IPV6:
+		inner_proto = htons(ETH_P_IPV6);
+		inner_len = sizeof(struct ipv6hdr);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	/* A full inner L3 header must remain after decapsulation. */
+	if (skb->len - off - PPPOE_SES_HLEN < inner_len)
+		return -EINVAL;
+
+	ret = bpf_skb_net_shrink(skb, off, PPPOE_SES_HLEN, flags);
+	if (ret < 0)
+		return ret;
+
+	skb->protocol = inner_proto;
+	skb_reset_mac_len(skb);
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
+	__skb_reset_checksum_unnecessary(skb);
+	bpf_compute_data_pointers(skb);
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12965,6 +13145,11 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
 BTF_ID_FLAGS(func, bpf_icmp_send)
 BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
 
+BTF_KFUNCS_START(bpf_kfunc_check_set_skb_pppoe)
+BTF_ID_FLAGS(func, bpf_skb_pppoe_encap, KF_CHANGES_PKT)
+BTF_ID_FLAGS(func, bpf_skb_pppoe_decap, KF_CHANGES_PKT)
+BTF_KFUNCS_END(bpf_kfunc_check_set_skb_pppoe)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -13000,6 +13185,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send = {
 	.set = &bpf_kfunc_check_set_icmp_send,
 };
 
+static const struct btf_kfunc_id_set bpf_kfunc_set_skb_pppoe = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_skb_pppoe,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -13023,6 +13213,8 @@ static int __init bpf_kfunc_init(void)
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_pppoe);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_pppoe);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
-- 
2.47.3

