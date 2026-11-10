Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290344;
	b=Na9tsx6eDqZlL6L5rufzIu5Hw1owzQEskNmeqDsvA0QFn02KAiSSpPHOueLngXgvD3k2
	 XMV4fRwzuzJyqxTEXJaeS5AhJYXmlkEFmGZwv5cbfULf6/0NulfvFIp/GbDmQHc6Fogrt
	 zIN4QtWgF6SHYl53eXydCcMf/Lpjau+CpW7+/ZXaA/V3nDvQfe7gYmqam4lAVOKsuf1tw
	 KhlvnbVXrtVAPwRfceYm7+n8yhnLpONDEQ0FyGppeniO1ZxTXyd82dpyFTr6CVbf+A2It
	 wCh3oWPElFShnKe+lScEBP24bL2dJyptmhp4yjbrUWcTO77QzLHYL1v/383jRPWkd+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290344;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k9OMXHYKjwUvr7v6pNhNNy9UwviPZzUYeEcywDMVG1Q=;
	b=RWeK54lqMGObBvK25HcYhcTob1J/Q26LA7wqntRnIjPbXgYKzX6VNVTWWKagJMa5R7DK
	 yi2ruaDhV79oaX6pkiBFrWpqR6MPc3ayoiuEgwPSkmGc5qjoSn9sDbGHjVQn/4MaxOofJ
	 5zEroFNhv+Gw5jKNt1pw4M2BRY3JRCuG7j0N73Fv9CFtTy0sBpndVMQLefj+0DApl28SK
	 4H19fPRl0jgPb51PCtPwelQ+gPehCvybUeDEWzyziUC9HvZYgFLjMKnwf3NXgM7TtJdWJ
	 bnjyDF3bct2HI6kvrSXuXTRZ3Pz9dphbXtmRSTB0baka/U4ys1zpCJoitAbko3F5bGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G8wZ4Ssw;
	arc=none smtp.remote-ip=91.218.175.239
Received: from mta0.migadu.com (out-239.mta0.migadu.com [91.218.175.239])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93D606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 05:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE93D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G8wZ4Ssw
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dPJoMMXJ/tOJgzyT4oINks0Nr6xe5+vM+b4TFv/4o0w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794290340; v=1; x=1794895140;
 b=G8wZ4SsweAPcyfrG0a6ACWPNQzC3TV7fzhzfngQxiwTZHTy5yAO3dGFG3ghSFHCRLD0NbGPZ
 LCR6qDuODqFTZuC4YL63GBrG6oigmgpKAWpYTFUqeEVqdWRzGofRjT7QY66yOyGh7x/TRG5azRS
 KzWt2tjvETVa9C1RyfehyPJI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id bf9b0b0bdf7fc38d;
	Tue, 10 Nov 2026 05:59:00 +0000
X-Mizu-Trace-ID: bf9b0b0bdf7fc38d
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 13:58:54 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igmp: use the joined device when leaving a multicast
 group
Message-ID: <avKyno2Pcsrfu0u4@fedora>
References: <20261109125312.2208874-1-graypanda.inzag@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109125312.2208874-1-graypanda.inzag@gmail.com>

On Mon, Nov 09, 2026 at 09:53:11PM +0900, Junyoung Jang wrote:
> ip_mc_leave_group() resolves in_dev from the leave request before
> matching the request against the socket's multicast membership list.
> This lookup can return NULL even while the interface recorded in the
> matched membership (iml->multi.imr_ifindex) is still alive:
> 
> 1. An application joins a group using a local IPv4 address, that
>    secondary address is later removed while the interface stays up,
>    and the application leaves using the same 8-byte ip_mreq.
> 2. An unprivileged user joins a group with a 12-byte ip_mreqn
>    specifying a valid imr_ifindex and a nonlocal imr_address, then
>    leaves with an 8-byte ip_mreq containing that nonlocal address
>    and no ifindex.
> 
> Because imr_address is nonzero, the early -ENODEV check is bypassed.
> The loop then removes and frees the socket's ip_mc_socklist entry
> (iml) and returns 0, but skips ip_mc_dec_group() because in_dev is
> NULL. Closing the socket cannot release the group via
> ip_mc_drop_socket() because the socket membership entry has already
> been unlinked. This leaks the interface's struct ip_mc_list reference
> and multicast MAC filter beyond the socket's lifetime, allowing an
> unprivileged user to repeatedly leak multicast group entries on a
> live interface.
> 
> Fix this by looking up in_dev from the matched membership's saved
> imr_ifindex under RTNL, matching ip_mc_drop_socket(). If the interface
> was genuinely removed, inetdev_by_index() still returns NULL and the
> existing hot-unplug cleanup behavior is preserved.
> 
> Fixes: 4eba7bb1d72d ("ipv4: igmp: Allow removing groups from a removed interface")
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> ---
> Tested on Linux 7.4-rc1 in QEMU/KVM as an unprivileged user (UID 1000)
> for both the unprivileged ifindex/nonlocal-address mismatch and the
> secondary address removal scenario.
> 
> Unpatched 7.4-rc1 guest output:
>   IGMP_VM_BEGIN kernel=7.4.0-rc1 expect=--expect-leak
>   IGMP_VM_CASE=nonlocal-address
>   uid=1000
>   control_explicit_ifindex
>   after_drop=0
>   after_close=0
>   case_address_only
>   join=0
>   drop=0
>   after_drop=1
>   after_close=1
>   joins_ok=16
>   drops_ok=16
>   closes_ok=16
>   groups_after=16
>   result=PASS
>   IGMP_VM_CASE=removed-secondary-address
>   uid=1000
>   address_removed=1
>   primary_present=1
>   after_remove=1
>   drop=0
>   after_drop=1
>   after_close=1
>   result=PASS
> 
> Patched 7.4-rc1 guest output:
>   IGMP_VM_BEGIN kernel=7.4.0-rc1 expect=--expect-fixed
>   IGMP_VM_CASE=nonlocal-address
>   uid=1000
>   control_explicit_ifindex
>   after_drop=0
>   after_close=0
>   case_address_only
>   join=0
>   drop=0
>   after_drop=0
>   after_close=0
>   joins_ok=16
>   drops_ok=16
>   closes_ok=16
>   groups_after=0
>   result=PASS
>   IGMP_VM_CASE=removed-secondary-address
>   uid=1000
>   address_removed=1
>   primary_present=1
>   after_remove=1
>   drop=0
>   after_drop=0
>   after_close=0
>   result=PASS
> 
> Reproducer (igmp-multicast-reference-leak.c):
> 
> /* SPDX-License-Identifier: GPL-2.0-only */
> #define _GNU_SOURCE
> #include <arpa/inet.h>
> #include <errno.h>
> #include <ifaddrs.h>
> #include <net/if.h>
> #include <netinet/in.h>
> #include <stdbool.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <unistd.h>
> 
> /*
>  * Run in a disposable network namespace. The affected kernel retains
>  * groups after a successful address-only leave and socket close.
>  */
> #define BATCH_GROUPS 16
> 
> _Static_assert(sizeof(struct ip_mreqn) == 12, "ip_mreqn must include ifindex");
> _Static_assert(sizeof(struct ip_mreq) == 8, "ip_mreq must omit ifindex");
> 
> struct observation {
> 	int before;
> 	int after_join;
> 	int after_drop;
> 	int after_close;
> };
> 
> struct accumulation {
> 	int before;
> 	int after;
> 	int joins;
> 	int drops;
> 	int closes;
> };
> 
> struct interface_state {
> 	bool up;
> 	bool primary_present;
> 	bool additional_present;
> };
> 
> static void die(const char *operation)
> {
> 	fprintf(stderr, "%s: %s\n", operation, strerror(errno));
> 	exit(EXIT_FAILURE);
> }
> 
> static struct in_addr address(const char *text)
> {
> 	struct in_addr addr;
> 
> 	if (inet_pton(AF_INET, text, &addr) != 1) {
> 		fprintf(stderr, "invalid IPv4 address: %s\n", text);
> 		exit(EXIT_FAILURE);
> 	}
> 	return addr;
> }
> 
> static struct interface_state churn_interface_state(void)
> {
> 	struct in_addr primary = address("192.0.2.1");
> 	struct in_addr additional = address("192.0.2.10");
> 	struct interface_state state = { 0 };
> 	struct ifaddrs *interfaces, *ifa;
> 
> 	if (getifaddrs(&interfaces))
> 		die("getifaddrs");
> 	for (ifa = interfaces; ifa; ifa = ifa->ifa_next) {
> 		struct sockaddr_in *in;
> 
> 		/* IPv4 aliases may be reported as eth0:1 by getifaddrs(). */
> 		if (strncmp(ifa->ifa_name, "eth0", 4) ||
> 		    (ifa->ifa_name[4] && ifa->ifa_name[4] != ':'))
> 			continue;
> 		state.up |= !!(ifa->ifa_flags & IFF_UP);
> 		if (!ifa->ifa_addr || ifa->ifa_addr->sa_family != AF_INET)
> 			continue;
> 		in = (struct sockaddr_in *)ifa->ifa_addr;
> 		state.primary_present |= in->sin_addr.s_addr == primary.s_addr;
> 		state.additional_present |= in->sin_addr.s_addr == additional.s_addr;
> 	}
> 	freeifaddrs(interfaces);
> 	return state;
> }
> 
> /* /proc/net/igmp prints each group as a hexadecimal __be32 value. */
> static int group_present(unsigned int ifindex, struct in_addr group)
> {
> 	char line[256], device[IFNAMSIZ];
> 	unsigned int index, group_count, raw_group, users;
> 	bool on_interface = false;
> 	int found = 0;
> 	FILE *file;
> 
> 	file = fopen("/proc/net/igmp", "r");
> 	if (!file)
> 		die("fopen /proc/net/igmp");
> 
> 	while (fgets(line, sizeof(line), file)) {
> 		if (sscanf(line, " %u %15s : %u", &index, device,
> 			   &group_count) == 3) {
> 			on_interface = index == ifindex;
> 			continue;
> 		}
> 		if (on_interface &&
> 		    sscanf(line, " %x %u", &raw_group, &users) == 2 &&
> 		    raw_group == group.s_addr) {
> 			found = 1;
> 			break;
> 		}
> 	}
> 	if (ferror(file))
> 		die("read /proc/net/igmp");
> 	if (fclose(file))
> 		die("fclose /proc/net/igmp");
> 	return found;
> }
> 
> static struct ip_mreqn join_request(struct in_addr group,
> 				    struct in_addr interface_addr, int ifindex)
> {
> 	struct ip_mreqn request = {
> 		.imr_multiaddr = group,
> 		.imr_address = interface_addr,
> 		.imr_ifindex = ifindex,
> 	};
> 
> 	return request;
> }
> 
> static struct observation probe(const char *name, struct in_addr group,
> 				struct in_addr interface_addr,
> 				unsigned int ifindex, bool drop_with_ifindex)
> {
> 	struct ip_mreqn join = join_request(group, interface_addr, ifindex);
> 	struct ip_mreq drop = {
> 		.imr_multiaddr = group,
> 		.imr_interface = interface_addr,
> 	};
> 	struct observation result;
> 	int fd;
> 
> 	printf("%s\n", name);
> 	result.before = group_present(ifindex, group);
> 	printf("before=%d\n", result.before);
> 	fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> 	if (fd < 0)
> 		die("socket");
> 	printf("socket=%d\n", fd);
> 	if (setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
> 		       &join, sizeof(join)))
> 		die("IP_ADD_MEMBERSHIP");
> 	printf("join=0\n");
> 	result.after_join = group_present(ifindex, group);
> 	printf("after_join=%d\n", result.after_join);
> 
> 	if (drop_with_ifindex) {
> 		if (setsockopt(fd, IPPROTO_IP, IP_DROP_MEMBERSHIP,
> 			       &join, sizeof(join)))
> 			die("IP_DROP_MEMBERSHIP (ip_mreqn)");
> 	} else if (setsockopt(fd, IPPROTO_IP, IP_DROP_MEMBERSHIP,
> 			      &drop, sizeof(drop))) {
> 		die("IP_DROP_MEMBERSHIP (ip_mreq)");
> 	}
> 	printf("drop=0\n");
> 	result.after_drop = group_present(ifindex, group);
> 	printf("after_drop=%d\n", result.after_drop);
> 	if (close(fd))
> 		die("close");
> 	printf("close=0\n");
> 	result.after_close = group_present(ifindex, group);
> 	printf("after_close=%d\n", result.after_close);
> 	return result;
> }
> 
> static int count_batch_groups(unsigned int ifindex)
> {
> 	char text[INET_ADDRSTRLEN];
> 	int count = 0;
> 
> 	for (int i = 1; i <= BATCH_GROUPS; i++) {
> 		snprintf(text, sizeof(text), "239.250.34.%d", i);
> 		count += group_present(ifindex, address(text));
> 	}
> 	return count;
> }
> 
> static struct accumulation accumulate_groups(struct in_addr interface_addr,
> 					     unsigned int ifindex)
> {
> 	char text[INET_ADDRSTRLEN];
> 	struct accumulation result = { 0 };
> 	struct ip_mreqn join;
> 	struct ip_mreq drop;
> 	int fd;
> 
> 	result.before = count_batch_groups(ifindex);
> 	printf("groups_before=%d\n", result.before);
> 	for (int i = 1; i <= BATCH_GROUPS; i++) {
> 		snprintf(text, sizeof(text), "239.250.34.%d", i);
> 		join = join_request(address(text), interface_addr, ifindex);
> 		drop.imr_multiaddr = join.imr_multiaddr;
> 		drop.imr_interface = interface_addr;
> 		fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> 		if (fd < 0)
> 			die("batch socket");
> 		if (setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
> 			       &join, sizeof(join)))
> 			die("batch IP_ADD_MEMBERSHIP");
> 		result.joins++;
> 		if (setsockopt(fd, IPPROTO_IP, IP_DROP_MEMBERSHIP,
> 			       &drop, sizeof(drop)))
> 			die("batch IP_DROP_MEMBERSHIP");
> 		result.drops++;
> 		if (close(fd))
> 			die("batch close");
> 		result.closes++;
> 	}
> 	result.after = count_batch_groups(ifindex);
> 	printf("joins_ok=%d\ndrops_ok=%d\ncloses_ok=%d\ngroups_after=%d\n",
> 	       result.joins, result.drops, result.closes, result.after);
> 	return result;
> }
> 
> static int run_original(bool expect_leak, unsigned int ifindex)
> {
> 	struct in_addr interface_addr = address("203.0.113.77");
> 	struct observation control, affected;
> 	struct accumulation batch;
> 	bool pass;
> 
> 	control = probe("control_explicit_ifindex", address("239.250.33.1"),
> 			interface_addr, ifindex, true);
> 	affected = probe("case_address_only", address("239.250.33.2"),
> 			 interface_addr, ifindex, false);
> 	batch = accumulate_groups(interface_addr, ifindex);
> 	pass = control.before == 0 && control.after_join == 1 &&
> 	       control.after_drop == 0 && control.after_close == 0 &&
> 	       affected.before == 0 && affected.after_join == 1 &&
> 	       affected.after_drop == expect_leak &&
> 	       affected.after_close == expect_leak &&
> 	       batch.before == 0 && batch.joins == BATCH_GROUPS &&
> 	       batch.drops == BATCH_GROUPS && batch.closes == BATCH_GROUPS &&
> 	       batch.after == (expect_leak ? BATCH_GROUPS : 0);
> 	printf("result=%s\n", pass ? "PASS" : "FAIL");
> 	return pass ? EXIT_SUCCESS : EXIT_FAILURE;
> }
> 
> /*
>  * The caller first adds 192.0.2.1/24 to eth0, then 192.0.2.10/24 as a
>  * secondary address. After "ready_to_remove_address=1", it deletes only
>  * the secondary address and sends one byte on stdin; eth0 remains up.
>  */
> static int run_address_churn(bool expect_leak, unsigned int ifindex)
> {
> 	struct in_addr group = address("239.250.35.1");
> 	struct ip_mreq request = {
> 		.imr_multiaddr = group,
> 		.imr_interface = address("192.0.2.10"),
> 	};
> 	int before, after_join, after_remove, after_drop, after_close, fd;
> 	struct interface_state before_state, after_state;
> 	char token;
> 	ssize_t n;
> 	bool pass;
> 
> 	printf("case_address_churn\n");
> 	before_state = churn_interface_state();
> 	printf("address_present_before=%d\ninterface_up_before=%d\n",
> 	       before_state.additional_present, before_state.up);
> 	before = group_present(ifindex, group);
> 	printf("before=%d\n", before);
> 	fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> 	if (fd < 0)
> 		die("socket");
> 	printf("socket=%d\n", fd);
> 	if (setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
> 		       &request, sizeof(request)))
> 		die("address-churn IP_ADD_MEMBERSHIP");
> 	printf("join=0\n");
> 	after_join = group_present(ifindex, group);
> 	printf("after_join=%d\n", after_join);
> 	printf("ready_to_remove_address=1\n");
> 	if (fflush(stdout))
> 		die("fflush");
> 	do {
> 		n = read(STDIN_FILENO, &token, 1);
> 	} while (n < 0 && errno == EINTR);
> 	if (n != 1) {
> 		fprintf(stderr, "expected one-byte address-removal signal\n");
> 		return EXIT_FAILURE;
> 	}
> 	after_state = churn_interface_state();
> 	printf("address_removed=%d\ninterface_up=%d\nprimary_present=%d\n",
> 	       !after_state.additional_present, after_state.up,
> 	       after_state.primary_present);
> 	after_remove = group_present(ifindex, group);
> 	printf("after_remove=%d\n", after_remove);
> 	if (setsockopt(fd, IPPROTO_IP, IP_DROP_MEMBERSHIP,
> 		       &request, sizeof(request)))
> 		die("address-churn IP_DROP_MEMBERSHIP");
> 	printf("drop=0\n");
> 	after_drop = group_present(ifindex, group);
> 	printf("after_drop=%d\n", after_drop);
> 	if (close(fd))
> 		die("close");
> 	printf("close=0\n");
> 	after_close = group_present(ifindex, group);
> 	printf("after_close=%d\n", after_close);
> 	pass = before_state.up && before_state.primary_present &&
> 	       before_state.additional_present && after_state.up &&
> 	       after_state.primary_present && !after_state.additional_present &&
> 	       before == 0 && after_join == 1 && after_remove == 1 &&
> 	       after_drop == expect_leak && after_close == expect_leak;
> 	printf("result=%s\n", pass ? "PASS" : "FAIL");
> 	return pass ? EXIT_SUCCESS : EXIT_FAILURE;
> }
> 
> int main(int argc, char **argv)
> {
> 	bool churn = argc == 3 && !strcmp(argv[1], "--address-churn");
> 	const char *expectation = churn ? argv[2] : argc == 2 ? argv[1] : NULL;
> 	const char *ifname = churn ? "eth0" : "lo";
> 	bool expect_leak;
> 	unsigned int ifindex;
> 
> 	if (!expectation ||
> 	    (strcmp(expectation, "--expect-leak") &&
> 	     strcmp(expectation, "--expect-fixed"))) {
> 		fprintf(stderr,
> 			"usage: %s [--address-churn] --expect-leak|--expect-fixed\n",
> 			argv[0]);
> 		return 2;
> 	}
> 	expect_leak = !strcmp(expectation, "--expect-leak");
> 	ifindex = if_nametoindex(ifname);
> 	if (!ifindex)
> 		die("if_nametoindex");
> 	printf("uid=%u\ninterface=%s ifindex=%u\nexpectation=%s\n",
> 	       (unsigned int)getuid(), ifname, ifindex,
> 	       expect_leak ? "leak" : "fixed");
> 
> 	if (churn)
> 		return run_address_churn(expect_leak, ifindex);
> 	return run_original(expect_leak, ifindex);
> }
> 
>  net/ipv4/igmp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 144fca158..52cde8782 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -2463,6 +2463,8 @@ int ip_mc_leave_group(struct sock *sk, struct ip_mreqn *imr)
>  				iml->multi.imr_address.s_addr)
>  			continue;
>  
> +		/* The drop request may not resolve to the joined device. */
> +		in_dev = inetdev_by_index(net, iml->multi.imr_ifindex);
>  		(void) ip_mc_leave_src(sk, iml, in_dev);
>  
>  		*imlp = iml->next_rcu;
> -- 
> 2.43.0

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
