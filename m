Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26ED49C4DB
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340545; cv=none; b=hQw2p+S2pZ092xJng6AV70wrqFwxb60jeO2gm99eBaIP0v9LPcTY5VlcQD72ZgTi5vFz1kAZoVEaf5381VIliYqAwlU09idjEQWGkaAI5jWQwFQPMs+O8r4gT0zptSy2WOsu3EjlWjJPs3cNlKsu52WX6rbrL4yMU/QYoqdW6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340545; c=relaxed/simple;
	bh=iGin5NV+8X5pxjGoj6CXgzkmBDszZDkZUkCE3/957mQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amIoDfeDj2ic6oGx9PObKAmcVjcW3QkX0TvFANyJNnaG0IunlfHvlesR7POqzRrA8POIaIlAO4sUK/BG66zZA58ccpXQfAoswWhm+pwhu8hfmXI/rmCE+1G2lT38CFWYOe+3k3QaKB2gj0VNtf9gr0ln6RhcSnxWn8/cz1kUe84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeAlWYJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeAlWYJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E481F00893;
	Fri, 25 Sep 2026 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790340543;
	bh=DNTbz+I6Pm8putGHf0eFMR5t7lOtPdn9LXk/bi/v3QU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PeAlWYJRVzPlOCv1AFkTUnBRsJFDkwYULVnIz5X1kQCVhhj7PXVnFsSsipgKN1BJr
	 dXrsDNUwWK46ubt1MyYWzDO3pU+ScFkmKCNIGzl4xD4wXoFPbzGC717SSNvewacQzg
	 7166IVOZgLKH/lBQxMbi8SZAmhYak+fA45GtINT2FVLzwT6CyOX/BnZfk4TemrG8Vq
	 12aUfZf/e6qoNUxPVzEG6ATXngAGXYrzimLJCAzvC5kP0APNRk5c9uxA/ywpGIEXU7
	 XGLM7vyyd6DA3lZITLjXt0bq6yg9LDpABGlKnIKqrqTya2iyyI1T3AXJ2Sk9BFPssR
	 ZtaiFnhx5Iu3A==
Subject: Re: [PATCH net 2/2] selftests/net: add SO_RESERVE_MEM test
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, weiwan@google.com,
 horms@kernel.org, caixinchen1@huawei.com, netdev@vger.kernel.org,
 edumazet@kernel.org
Date: Fri, 25 Sep 2026 12:49:02 +0000
Message-ID: <179034054266.2160803.16187930067723490774@kernel.org>
In-Reply-To: <20260924123602.1979090-3-edumazet@google.com>
References: <20260924123602.1979090-3-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new SO_RESERVE_MEM selftest needs memcg socket accounting
  but never checks for it, so on systems without it the tests fail…
- [Medium] When socket() fails, check_non_tcp_rejected() only accepts
  EAFNOSUPPORT or EPROTONOSUPPORT.
- [Medium] cgroup_memory_max opens memory.max with plain O_WRONLY (line
  217) and writes an 8-page limit (line 225) to the cgroup that holds…
- [Medium] preserved_after_traffic checks `get_fwd_alloc(cfd) >= 16*ps`
  (line 325) right after recv(sfd, MSG_WAITALL) returns (line 323).
- [Low] The fallback `#define SO_RESERVE_MEM 73` in so_reserve_mem.c
  (line 21) is right only for the asm-generic, alpha and mips ABIs.
- [Low] FIXTURE_SETUP writes "+memory" to <cgroup2
  mount>/cgroup.subtree_control (line 80), and FIXTURE_TEARDOWN (lines…

--

selftests/net: add SO_RESERVE_MEM test

This commit adds a kselftest for SO_RESERVE_MEM. It covers rejection of
non-TCP sockets, bounds checks, reserve grow/shrink/rounding with the
matching SO_MEMINFO forward alloc, cgroup v2 memory.max enforcement, the
zero reserve on accepted children, and reserve retention across TCP
traffic.

> diff --git a/tools/testing/selftests/net/so_reserve_mem.c b/tools/testing/selftests/net/so_reserve_mem.c
> new file mode 100644
> index 0000000000000..c2ca02ebe8353
> --- /dev/null
> +++ b/tools/testing/selftests/net/so_reserve_mem.c
> @@ -0,0 +1,333 @@

[ ... ]

> +#ifndef SO_RESERVE_MEM
> +#define SO_RESERVE_MEM 73
> +#endif

[Severity: Low]
This isn't a bug in normal builds, because the Makefile pulls in the
kernel uapi headers and this fallback goes unused. Is 73 the right
fallback on every architecture, though?

parisc uses a different value:

arch/parisc/include/uapi/asm/socket.h:
#define SO_RESERVE_MEM		0x4047

So does sparc, where 73 (0x0049) is SO_BUSY_POLL_BUDGET:

arch/sparc/include/uapi/asm/socket.h:
#define SO_RESERVE_MEM           0x0052

If the fallback ever gets used on those architectures, the test would get
or set an unrelated socket option.

[ ... ]

> +FIXTURE_SETUP(so_reserve_mem)
> +{

[ ... ]

> +	snprintf(ctrl_path, sizeof(ctrl_path), "%s/cgroup.subtree_control",
> +		 self->cg_root);
> +	fd = open(ctrl_path, O_WRONLY);
> +	if (fd >= 0) {
> +		ret = write(fd, "+memory", 7);
> +		(void)ret;
> +		close(fd);
> +	}

[Severity: Medium]
Should the fixture skip when memcg socket accounting isn't available?

The result of the "+memory" write is thrown away. Nothing checks that the
child cgroup ends up with a non-root memcg. Without one,
sock_reserve_memory() rejects the request immediately:

net/core/sock.c:sock_reserve_memory() {
	...
	if (!mem_cgroup_sk_enabled(sk) || !sk_is_tcp(sk))
		return -EOPNOTSUPP;
	...
}

mem_cgroup_sk_enabled() is false in these cases:

  - CONFIG_MEMCG=n
  - booted with cgroup_disable=memory or cgroup.memory=nosocket
  - mem_cgroup_sk_alloc() left sk_memcg NULL (root memcg, or memcg bound
    to v1)

tools/testing/selftests/net/config also isn't updated with CONFIG_MEMCG or
CONFIG_CGROUPS.

On those kernels, the ASSERT_EQ(setsockopt(SO_RESERVE_MEM), 0) calls in
grow_shrink_and_rounding, accept_child_zero_reserve and
preserved_after_traffic fail with EOPNOTSUPP instead of skipping.

With cgroup.memory=nosocket, memory.max still exists, so cgroup_memory_max
fails too: errno is EOPNOTSUPP rather than ENOMEM.

In the same setups, non_tcp_rejected passes on the memcg check alone and
never reaches the sk_is_tcp() gate, because both checks return EOPNOTSUPP.
Would a positive TCP control be needed there to show that the TCP-only
restriction works?

[ ... ]

> +FIXTURE_TEARDOWN(so_reserve_mem)
> +{

[ ... ]

> +	rmdir(self->cg_child);
> +	umount2(self->cg_root, MNT_DETACH);
> +	rmdir(self->cg_root);
> +}

[Severity: Low]
Should teardown restore cgroup.subtree_control?

The mount namespace is private, but a cgroup2 mount always exposes the
single global v2 hierarchy. That makes cg_root the host's root cgroup (or
the cgroupns root).

FIXTURE_SETUP writes "+memory" there. Teardown never records the earlier
state and never writes "-memory".

On hosts or minimal CI VMs where the root subtree_control starts empty, the
memory controller stays enabled for all child cgroups after the test. That
changes memcg and socket memory accounting for later tests and workloads.

> +static void check_non_tcp_rejected(struct __test_metadata *_metadata,
> +				   int domain, int type, int protocol,
> +				   int val)
> +{
> +	int fd = socket(domain, type, protocol);
> +
> +	if (fd < 0) {
> +		EXPECT_TRUE(errno == EAFNOSUPPORT || errno == EPROTONOSUPPORT);
> +		return;
> +	}

[Severity: Medium]
Should ENOPROTOOPT be accepted here as well?

MPTCP can be built in but disabled with net.mptcp.enabled=0. In that case
socket creation fails here:

net/mptcp/protocol.c:mptcp_init_sock() {
	...
	if (!mptcp_is_enabled(net))
		return -ENOPROTOOPT;
	...
}

inet_create() passes that error back to userspace. As a result,
socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP) in non_tcp_rejected fails with
ENOPROTOOPT, and the EXPECT_TRUE fails the test.

The test doesn't unshare the network namespace, so it sees the host's
sysctl. Any other environment-specific socket() errno also becomes an
EXPECT failure rather than a skip.

[ ... ]

> +TEST_F(so_reserve_mem, cgroup_memory_max)
> +{
> +	char max_path[160];
> +	int ps = self->page_size;
> +	int fd, max_fd, val;
> +
> +	snprintf(max_path, sizeof(max_path), "%s/memory.max", self->cg_child);
> +	max_fd = open(max_path, O_WRONLY);
> +	if (max_fd < 0)
> +		SKIP(return, "cgroup memory controller not delegated");
> +
> +	fd = socket(AF_INET, SOCK_STREAM, 0);
> +	ASSERT_GE(fd, 0);
> +
> +	/* Limit cgroup memory to 8 pages and try to reserve 64 pages */
> +	ASSERT_GT(dprintf(max_fd, "%ld\n", 8L * ps), 0);

[Severity: Medium]
Can this write OOM-kill the test process?

FIXTURE_SETUP moved the test process into cg_child, so this 8-page limit
applies to the test itself, and memory.current is never checked.

memory.max is opened without O_NONBLOCK, so memory_max_write() enforces
the new limit synchronously:

mm/memcontrol.c:memory_max_write() {
	...
	if (of->file->f_flags & O_NONBLOCK)
		goto out;

	for (;;) {
		...
		if (nr_pages <= max)
			break;
		...
		memcg_memory_event(memcg, MEMCG_OOM);
		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
			break;
		...
	}
	...
}

The process's charges after migration include accounted slab objects (the
socket, inode, dentry, file and seq_file) and any anon or CoW pages. Anon
pages can't be reclaimed without swap. If those charges stay above 8 pages
after reclaim, the memcg OOM killer kills the test during this write. It
then dies from a signal instead of seeing ENOMEM from setsockopt.

Usage is often only a few pages here. It depends on runtime details such as
glibc behaviour, THP on fresh faults, and LSM blobs.

Would opening memory.max with O_NONBLOCK, or setting the limit relative to
memory.current, avoid this?

[ ... ]

> +TEST_F(so_reserve_mem, preserved_after_traffic)
> +{

[ ... ]

> +	/* Send & drain traffic; cfd must retain its 16-page forward alloc,
> +	 * while sfd (0 reserve) reclaims its forward alloc back to 0.
> +	 */
> +	ASSERT_EQ(send(cfd, buf, sizeof(buf), 0), (ssize_t)sizeof(buf));
> +	ASSERT_EQ(recv(sfd, buf, sizeof(buf), MSG_WAITALL), (ssize_t)sizeof(buf));
> +
> +	EXPECT_GE(get_fwd_alloc(_metadata, cfd), (__u32)(16 * ps));

[Severity: Medium]
Is this check racing with the ACK being processed on cfd?

send() charges the queued skb to cfd. That leaves sk_forward_alloc at
16 * ps - truesize, with sk_wmem_queued equal to truesize.

sk_unused_reserved_mem() subtracts sk_wmem_queued. Forward alloc only
returns to 16 * ps once the skb is freed on ACK, followed by
sk_mem_uncharge() and sk_mem_reclaim().

On default non-RT kernels, the loopback softirq runs in the sender's
local_bh_enable(). The ACK lands on cfd's backlog and release_sock()
processes it before send() returns, so the check passes there.

With CONFIG_PREEMPT_RT, use_backlog_threads() always returns true. The
same happens with thread_backlog_napi or RPS on lo. RX then runs in a
separate backlog NAPI thread:

backlog thread
tcp_rcv_established()      (sfd)
  sends the ACK to cfd
  tcp_data_ready()         <- wakes the reader

test thread
recv(sfd) returns
get_fwd_alloc(cfd)         <- SO_MEMINFO, no socket lock taken

If the reader samples cfd before the backlog thread handles the ACK, it
sees fwd_alloc < 16 * ps and the EXPECT_GE fails intermittently.

The commit message says:

  - Verify reserve retention across TCP send/receive/ACK cycles.

However, nothing here waits for the ACK to complete. Would polling until
SK_MEMINFO_WMEM_QUEUED (or tcpi_unacked) reaches 0 before this check make
it reliable?

> +	EXPECT_EQ(get_fwd_alloc(_metadata, sfd), 0U);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924123602.1979090-1-edumazet%40google.com
