Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F32F4503B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791177780; cv=none; b=KkvYjOx/AjFOsfg6uRSs5e4Oc5/Z5E5FFXhlOU+TcwAZnOJ6IupF2jvHTem+kcK9UQtyQHNncFBpPUrlA8f1GpjwkWElclHRbsvEb1N5Q4qr/i20IGomTQY2JL9brHwjudD8D4d8Bh+2Aan8wSMvtXNYpmiEpSwRddbsCqMPKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791177780; c=relaxed/simple;
	bh=ZbxfQ2cDHg7c4v9IznHZ8AVIZmVh0HeLAOjq0w54Z8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bm20cbo+4OAICN7ClSKSSNf1mumM7/k/Ax6KRUg+vHdmCgXu5hcqG1Jx98JvHHzeMD+lj0dc+YggSUttXslJNVK6BM7ZkHVJ0NftSItJX/3m2lSdhHXonh2MrDTtws6pROIsImTd2IM/eKugU6UlmgA7oyQcd78dfafE1/CEGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=pRioI8d4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="pRioI8d4"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so662355a91.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 22:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791177778; x=1791782578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nuE1vW1ASHOJd6nKCwwRRkzCgzX+Tw7NR3eM9c75bRo=;
        b=pRioI8d4vK+IHsWAWzqeOjvxfBiWvOzY3yvr09nV4fytkvIXl5CYHbEu61XgdSfr5V
         8n8sl1Z3IQiXIZdXyi05TSk79QLNFutjheYydzTRLvtgSY3i2JslkbfZgurnYDTtqm2w
         3XGR1GtN1UayQns/gsHg1B/dazgxwZNIu81txJhVG5iXESiT5W4Ch6Ts+Nvc8djWgVDV
         NIOMJELKb9a4mAi71y3mQ6Y3M1s3O/tk7VIgK6LL6PN0ZyGj/sYJCrNuXVZggpa4gD7q
         +NfYbEr1vNf/ubDsHNglF+yOzlpgSXZwSmKO2p5yF4JAqiaVn/w/20plYu11SkQEwWKy
         OAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791177778; x=1791782578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nuE1vW1ASHOJd6nKCwwRRkzCgzX+Tw7NR3eM9c75bRo=;
        b=dODCTzJsQN1Dl8nfsjIDWVSqiFTt9LhwccIu1ctqNTL5ma//H7tM/omt6yizrIuU1k
         NCSLCEuz2vGmbOeFxolt/xKtYei3cYv0d8Pk2vpepql3oazrP3HR8u3EtRAwypWQDy0W
         uZRDDb0vZ6wPNcyxbV7MTjc/Mgav8T7cqqPHUoqVKM0QPiLKWVV5FTgyLEkqWGYpUA9I
         8x9ct0Xlj56ArVZbYmrxKyInLB3EUfNCTrywHD48UWil9CqIG7h/d28tbTKHSPNSPNfA
         kKv0G51Khh348v5InJcnKbSfkm0T08ACTwlxRcIZt7QmXgbmUp42JZ04f2rmA6LvN09/
         QPcw==
X-Gm-Message-State: AFq9FYLjXpCr+zDczLVc2ud/R5hylLfseExLRwL/+quwp5QbDi3S9FJG
	2FQ5HP3gsmtvWUwZBrd0f41D3Qv6XLUKTsH6tckCFvPEpWtMTQeM+5JMaooM2DhyeU5JEnOCOSR
	xJIb9PQ==
X-Gm-Gg: AYBFou2aWihNNLOEjui92rktBejGKVCWf8FAHIOt6C0k63MMcSLEl9e4AOi9UegDpot
	nHEc1dMjIYANaQp9FxsR9n+21ldoGcasGfaARX+/tU6lj7H3rX0qF4U0q+CKMhTo2FRTXmcw7jO
	wmxIy74Six9PRXId1OdWdzk4EAomJtSvFGxwuCBH8yldGPUMCmC+nS+kme+UwEcWO5Bmzl1QUyr
	Xhv4tiYHgSy9BH4+2ZXzlw1JCutcm7w/F9r7e4KD7fKuH/eRe4wYp7G8MvddCkMpqTcwndHjU1y
	p7nsezdj8RSMrAPVOGKZE68gpsNdRpY3J2veq2IxbN1FTo7mtsp2beQlbFR5z62aljzUvQSvIqc
	ly+GJQD2LKOYQVBX7n/crI8ZOXtVWcvtC7Uk5aWdhOs/m1Hqju8eBitXjoaUhXDvuf52A9GSdiG
	tW6GOMTJHvVG2+PdXOo8Fj3nZjc2daqghD+4KT/vjp2bZbiFSuinXcbcJuTHMKvYT563wLpxAic
	BleAl15
X-Received: by 2002:a17:90b:5628:b0:3a5:3f7:271 with SMTP id 98e67ed59e1d1-3a787644f23mr4662652a91.58.1791177777745;
        Sun, 04 Oct 2026 22:22:57 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6d2406b1sm209442a12.8.2026.10.04.22.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 22:22:57 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	jhs@mojatatu.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	vega@nebusec.ai,
	bronzed_45_vested@icloud.com,
	enjou1224z@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v4 0/1] net: loopback: reject skbs with a short linear Ethernet header
Date: Mon,  5 Oct 2026 13:22:48 +0800
Message-ID: <20261005052249.1914367-1-weir@nebusec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wyatt Feng <bronzed_45_vested@icloud.com>

Hi Linux kernel maintainers,

This v4 contains one patch for loopback_xmit(), following Jamal's
request to replace the pskb_may_pull() check with a direct check of
skb_headlen().

The issue is a missing check of the linear data available before
eth_type_trans(). A non-linear skb can have enough total data while
its linear area contains fewer than ETH_HLEN bytes. Pulling the header
in that state violates the skb length invariant and triggers a BUG
in __skb_pull().

The patch checks skb_headlen(skb) at the start of loopback_xmit().
Packets with insufficient linear data are freed and counted as TX
drops before eth_type_trans() can access or consume the header.

The earlier discussion established that restricting an individual tc
action does not protect the driver from packets arriving through
other paths. The following reproducer provides an additional IFE-based
reproduction of the loopback failure.

ife_reproducer.c:

#include <arpa/inet.h>
#include <errno.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <netpacket/packet.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

#ifndef ETH_P_IFE
#define ETH_P_IFE 0xED3E
#endif

#define IFE_META_HDR_LEN 2
#define PAYLOAD_LEN 8192

static void set_eth_header(unsigned char *data, const unsigned char *dst,
			   const unsigned char *src, uint16_t proto)
{
	uint16_t be_proto = htons(proto);

	memcpy(data, dst, ETH_ALEN);
	memcpy(data + ETH_ALEN, src, ETH_ALEN);
	memcpy(data + 2 * ETH_ALEN, &be_proto, sizeof(be_proto));
}

int main(int argc, char **argv)
{
	static const unsigned char outer_dst[ETH_ALEN] =
		{ 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
	static const unsigned char outer_src[ETH_ALEN] =
		{ 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };
	static const unsigned char inner_dst[ETH_ALEN] =
		{ 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 };
	static const unsigned char inner_src[ETH_ALEN] =
		{ 0x02, 0x00, 0x00, 0x00, 0x00, 0x02 };
	const char *ifname = argc > 1 ? argv[1] : "lo";
	const size_t inner_off = ETH_HLEN + IFE_META_HDR_LEN;
	const size_t len = inner_off + ETH_HLEN + PAYLOAD_LEN;
	struct sockaddr_ll sll = { 0 };
	uint16_t meta_len;
	unsigned char *frame;
	ssize_t sent;
	int fd = -1;
	int ret = 1;

	frame = malloc(len);
	if (!frame) {
		perror("malloc");
		return 1;
	}

	memset(frame, 'A', len);
	set_eth_header(frame, outer_dst, outer_src, ETH_P_IFE);

	/* IFE metalen includes the two-byte IFE metadata header itself. */
	meta_len = htons(IFE_META_HDR_LEN);
	memcpy(frame + ETH_HLEN, &meta_len, sizeof(meta_len));

	set_eth_header(frame + inner_off, inner_dst, inner_src, ETH_P_IP);

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IFE));
	if (fd < 0) {
		perror("socket");
		goto out;
	}

	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_IFE);
	sll.sll_ifindex = if_nametoindex(ifname);
	if (!sll.sll_ifindex) {
		fprintf(stderr, "unknown interface: %s\n", ifname);
		goto out;
	}

	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0) {
		perror("bind");
		goto out;
	}

	sent = send(fd, frame, len, 0);
	if (sent < 0) {
		perror("send");
		goto out;
	}
	if ((size_t)sent != len) {
		fprintf(stderr, "short send: %zd of %zu bytes\n", sent, len);
		goto out;
	}

	printf("sent %zu-byte IFE frame on %s\n", len, ifname);
	ret = 0;

out:
	if (fd >= 0)
		close(fd);
	free(frame);
	return ret;
}

Steps to reproduce:

 gcc -O2 -Wall -Wextra -o ife_reproducer ife_reproducer.c
 unshare -Urn sh
 ip link set lo up
 tc qdisc add dev lo clsact
 tc filter add dev lo egress protocol 0xed3e pref 1 matchall \
     action ife decode pipe
 ./ife_reproducer lo

Panic logs:

[  232.617378][ T9354] kernel BUG at include/linux/skbuff.h:2830!
[  232.617416][ T9354] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  232.668599][ T9354] CPU: 0 UID: 1001 PID: 9354 Comm: ife_reproducer Not tainted 7.3.0-rc5-00170-g6dc989ea46b9 #4 PREEMPT(full)
[  232.671146][ T9354] Hardware name: Red Hat KVM, BIOS 1.16.0-4.module+el8.9.0+1408+7b966129 04/01/2014
[  232.673184][ T9354] RIP: 0010:eth_type_trans+0x549/0x750
[  232.674452][ T9354] Code: bc 31 f8 44 89 73 70 be 0e 00 00 00 48 c7 c7 00 f9 1b 8d e8 d9 30 0e f8 31 d2 48 89 de 48 c7 c7 40 f9 1b 8d e8 18 b0 d5 ff 90 <0f> 0b bd 00 01 00 00 e9 1e ff ff ff 48 8b 7c 24 20 e8 21 d3 a3 f8
[  232.678665][ T9354] RSP: 0018:ffa00000076275d0 EFLAGS: 00010246
[  232.680030][ T9354] RAX: 0000000000000000 RBX: ff1100004f3c7e00 RCX: 0000000000000200
[  232.681787][ T9354] RDX: 8000000000000200 RSI: ff11000026190040 RDI: 0000000000000002
[  232.683553][ T9354] RBP: 0000000000000020 R08: 0000000000000130 R09: 0000000000000000
[  232.685315][ T9354] R10: ffe21c000d3448e1 R11: ff11000069a2470b R12: ff11000037fa9000
[  232.687081][ T9354] R13: ff1100004bccad60 R14: 0000000000002000 R15: 0000000000000020
[  232.688834][ T9354] FS:  00007f98d54cb540(0000) GS:ff110000d5603000(0000) knlGS:0000000000000000
[  232.690796][ T9354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  232.692258][ T9354] CR2: 00007f98d540b2a0 CR3: 000000004c72e000 CR4: 0000000000751ef0
[  232.694009][ T9354] PKRU: 55555554
[  232.694809][ T9354] Call Trace:
[  232.695559][ T9354]  <TASK>
[  232.696237][ T9354]  loopback_xmit+0x20f/0x700
[  232.697323][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.698602][ T9354]  dev_hard_start_xmit+0x19e/0x790
[  232.699774][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.701060][ T9354]  __dev_queue_xmit+0x27b9/0x4390
[  232.702219][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.703500][ T9354]  ? __pfx___dev_queue_xmit+0x10/0x10
[  232.704721][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.706005][ T9354]  ? find_held_lock+0x2d/0xa0
[  232.707100][ T9354]  ? __might_fault+0x138/0x190
[  232.708190][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.709476][ T9354]  ? __might_fault+0xe0/0x190
[  232.710544][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.711819][ T9354]  ? write_comp_data+0x29/0x80
[  232.712930][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.714226][ T9354]  ? __sanitizer_cov_trace_pc+0x20/0x50
[  232.715502][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.716775][ T9354]  ? _copy_from_iter+0x146/0x1950
[  232.717940][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.719221][ T9354]  ? __sanitizer_cov_trace_pc+0x20/0x50
[  232.720497][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.721776][ T9354]  ? _copy_from_iter+0x146/0x1950
[  232.722946][ T9354]  ? __pfx__copy_from_iter+0x10/0x10
[  232.724181][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.725461][ T9354]  ? __sanitizer_cov_trace_pc+0x20/0x50
[  232.726741][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.728029][ T9354]  ? write_comp_data+0x29/0x80
[  232.730968][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.732251][ T9354]  ? write_comp_data+0x29/0x80
[  232.733363][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.734639][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.735915][ T9354]  ? packet_parse_headers.isra.71+0x2a4/0x870
[  232.737308][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.738588][ T9354]  ? __sanitizer_cov_trace_pc+0x20/0x50
[  232.739862][ T9354]  ? __pfx_packet_parse_headers.isra.71+0x10/0x10
[  232.741321][ T9354]  packet_xmit+0x242/0x360
[  232.742358][ T9354]  ? write_comp_data+0x29/0x80
[  232.743473][ T9354]  packet_sendmsg+0x277a/0x6ec0
[  232.744616][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.745898][ T9354]  ? avc_has_perm+0x3c4/0x6d0
[  232.746995][ T9354]  ? __pfx_avc_has_perm+0x10/0x10
[  232.748159][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.749443][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.750721][ T9354]  ? __sanitizer_cov_trace_pc+0x20/0x50
[  232.752009][ T9354]  ? __pfx_packet_sendmsg+0x10/0x10
[  232.753211][ T9354]  ? __pfx_sock_has_perm+0x10/0x10
[  232.754398][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.755671][ T9354]  ? write_comp_data+0x29/0x80
[  232.756784][ T9354]  ? __entry_text_end+0xfdf35/0x102039
[  232.758026][ T9354]  ? __sanitizer_cov_trace_pc+0x20/0x50
[  232.759324][ T9354]  ? tomoyo_check_inet_acl+0x1d0/0x340
[  232.760566][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.761846][ T9354]  ? __pfx_tomoyo_socket_sendmsg_permission+0x10/0x10
[  232.763383][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.764666][ T9354]  ? write_comp_data+0x29/0x80
[  232.765785][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.767080][ T9354]  ? selinux_socket_sendmsg+0x1b8/0x300
[  232.768345][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.769630][ T9354]  ? write_comp_data+0x29/0x80
[  232.770751][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.772036][ T9354]  ? __sanitizer_cov_trace_pc+0x20/0x50
[  232.773311][ T9354]  ? __pfx_packet_sendmsg+0x10/0x10
[  232.774512][ T9354]  __sock_sendmsg+0x1df/0x220
[  232.775607][ T9354]  __sys_sendto+0x290/0x360
[  232.776644][ T9354]  ? __pfx___sys_sendto+0x10/0x10
[  232.777787][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.779071][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.780346][ T9354]  ? __sys_bind+0x188/0x220
[  232.781377][ T9354]  ? __pfx___sys_bind+0x10/0x10
[  232.782484][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.783759][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.785042][ T9354]  ? __sanitizer_cov_trace_pc+0x20/0x50
[  232.786322][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.787602][ T9354]  ? fput_close_sync+0x114/0x240
[  232.788733][ T9354]  ? __pfx_fput_close_sync+0x10/0x10
[  232.789933][ T9354]  ? dnotify_flush+0x79/0x4c0
[  232.791024][ T9354]  __x64_sys_sendto+0xe1/0x1c0
[  232.792122][ T9354]  ? srso_alias_return_thunk+0x5/0xfbef5
[  232.793400][ T9354]  ? lockdep_hardirqs_on+0x8d/0x120
[  232.794597][ T9354]  do_syscall_64+0x12c/0x7d0
[  232.795665][ T9354]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  232.796996][ T9354] RIP: 0033:0x7f98d53f2eec
[  232.798001][ T9354] Code: 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 19 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 64 c3 0f 1f 00 55 48 83 ec 20 48 89 54 24 10
[  232.802214][ T9354] RSP: 002b:00007ffcd38504e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  232.804066][ T9354] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f98d53f2eec
[  232.805816][ T9354] RDX: 000000000000201e RSI: 0000560acb7992a0 RDI: 0000000000000003
[  232.807579][ T9354] RBP: 0000560acb7992a0 R08: 0000000000000000 R09: 0000000000000000
[  232.809336][ T9354] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcd3850e96
[  232.811091][ T9354] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
[  232.812851][ T9354]  </TASK>
[  232.813548][ T9354] Modules linked in:
[  232.814547][ T9354] ---[ end trace 0000000000000000 ]---
[  232.815759][ T9354] RIP: 0010:eth_type_trans+0x549/0x750
[  232.815820][ T9354] Code: bc 31 f8 44 89 73 70 be 0e 00 00 00 48 c7 c7 00 f9 1b 8d e8 d9 30 0e f8 31 d2 48 89 de 48 c7 c7 40 f9 1b 8d e8 18 b0 d5 ff 90 <0f> 0b bd 00 01 00 00 e9 1e ff ff ff 48 8b 7c 24 20 e8 21 d3 a3 f8
[  232.815860][ T9354] RSP: 0018:ffa00000076275d0 EFLAGS: 00010246
[  232.815892][ T9354] RAX: 0000000000000000 RBX: ff1100004f3c7e00 RCX: 0000000000000200
[  232.815937][ T9354] RDX: 8000000000000200 RSI: ff11000026190040 RDI: 0000000000000002
[  232.815965][ T9354] RBP: 0000000000000020 R08: 0000000000000130 R09: 0000000000000000
[  232.815996][ T9354] R10: ffe21c000d3448e1 R11: ff11000069a2470b R12: ff11000037fa9000
[  232.816024][ T9354] R13: ff1100004bccad60 R14: 0000000000002000 R15: 0000000000000020
[  232.816053][ T9354] FS:  00007f98d54cb540(0000) GS:ff110000d5603000(0000) knlGS:0000000000000000
[  232.816088][ T9354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  232.816116][ T9354] CR2: 00007f98d540b2a0 CR3: 000000004c72e000 CR4: 0000000000751ef0
[  232.816143][ T9354] PKRU: 55555554
[  232.816161][ T9354] Kernel panic - not syncing: Fatal exception in interrupt
[  233.941757][ T9354] Shutting down cpus with NMI
[  233.945688][ T9354] Kernel Offset: disabled
[  233.946825][ T9354] Rebooting in 86400 seconds..

Tested on the net tree at commit 6dc989ea46b9 (7.3.0-rc5). Without the
patch, the kernel panicked as shown above. With the skb_headlen() check
in patch-1 applied, the send completed and the kernel did not panic.

Changes in v4:
- Replace pskb_may_pull(skb, ETH_HLEN) with
  skb_headlen(skb) < ETH_HLEN, as requested by Jamal after considering
  the Sashiko feedback.
- Update the commit message to describe the direct linear-length
  check and the TX drop handling.
- Include the IFE-based crash report in this cover letter.
- Retest the revised check with the IFE reproducer and confirm that
  the kernel no longer panics.
- Submit the loopback change as a single-patch posting.
- Correct the Fixes tag: the unchecked call and the skb pull invariant
  are already present in the initial git import. The previous tag,
  7eebb0b28f75 ("loopback: packet drops accounting"), changed accounting
  rather than introducing the missing check.

Previous versions:
v3: https://lore.kernel.org/all/2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com/
v2: https://lore.kernel.org/all/cover.1784709375.git.bronzed_45_vested@icloud.com/
v1: https://lore.kernel.org/all/cover.1782548651.git.bronzed_45_vested@icloud.com/

Thanks,
Wyatt

Wyatt Feng (1):
  net: loopback: reject skbs with a short linear Ethernet header

 drivers/net/loopback.c | 6 ++++++
 1 file changed, 6 insertions(+)
