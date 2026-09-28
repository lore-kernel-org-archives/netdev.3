Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB84DA9B7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625248; cv=none; b=hwTX3ed92H3sOEyCCV6v/nDKT2EceyM/cmE/Ro8+ic3tVCilcrD4NEothjwk5nlmVnj1N8LhkE6Mcqkb/+VBDBFkCkQXZEZEVNLBljCg/7EoxTXyzXZvwY4YYSP3mgKxBdGXkPzhYcVSLf4TOJncwECwdM+iFGTilhiqArVVy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625248; c=relaxed/simple;
	bh=l7RDchqyY9IxoRx/9dLzVMzFQqbcZwoUWVNUkJu4ze4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BbLG4+b2oq0f3DpOuZqm9VlZJHdW2mEOEJXdSB5W05BpTV6Yz5Y3ZPcZq/0QncaGJNml8aggKxGovpKIuFUMSzcz7hKP85540lgI3KbMgQMXwSuL1ykkpw/wzclhP9YZlTeGukbRDYcBGdsLTWIm4ZlVCnYry7OMWchv5SZmRCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjttKWGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjttKWGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E051F000FF;
	Mon, 28 Sep 2026 19:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790625244;
	bh=9Qhwyquzwqrj/uWKAYmCXjHF8H1aiq2R1Yk2/ANdW+M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SjttKWGnvVY+vfnPyjjBuNvisbgVcVGJs9PcVfHWFsM4PRrgLLqdBDOKlDRuZ3cb1
	 GRwUZft0ygpRUIzM+TS+S0mDfPhe/MIRiWK6U4kn+yI0AXutjNqCEZhJ69KJIOj1q1
	 OGNlNcO9pJexIyCm2fB537fzdsW4/d3zW4PomHY9tmyzyrzJcOnENG7bKIaCZ4e/J0
	 6RBYvAAcVpwFSzHOL/97WipGJoUQIO8OMUI7oy8cWe/bDoW4CgQBxSza77BrQWB7np
	 u1rqZivRg/l2Z8ANG9PMHYO1I2t7MquMayxpY6b7nxcO9SGE0+xKo/nhOGih9ScgGm
	 QgTY3QmyK1/TQ==
Subject: Re: [PATCH v2 net 2/2] selftests/net: add SO_RESERVE_MEM test
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, weiwan@google.com,
 horms@kernel.org, caixinchen1@huawei.com, netdev@vger.kernel.org,
 edumazet@kernel.org
Date: Mon, 28 Sep 2026 19:54:03 +0000
Message-ID: <179062524319.3145.1235142898193592641@kernel.org>
In-Reply-To: <20260925135244.3715196-3-edumazet@google.com>
References: <20260925135244.3715196-3-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The test assumes the freshly mounted cgroup2 root (cg_root) is
  the real hierarchy root, which is exempt from the no-internal-process…
- [Low] check_non_tcp_rejected()
  (tools/testing/selftests/net/so_reserve_mem.c, lines 191-195) accepts…
- [Low] The fixture changes the host's shared cgroup v2 hierarchy without
  restoring its original state symmetrically.
- [Low] preserved_after_traffic assumes that once SO_MEMINFO shows
  SK_MEMINFO_WMEM_QUEUED == 0 in wait_wmem_drained() (line 53), a later,…
- [Low] The fixture checks and changes the root cgroup subtree_control
  without any coordination, then undoes the change unconditionally.

--

selftests/net: add SO_RESERVE_MEM test

This adds a kselftest for SO_RESERVE_MEM. It covers rejection of
unsupported socket types, bounds checking, reserve grow/shrink and page
rounding, cgroup v2 memory.max enforcement, the reserve of an accept()
child, and reserve retention across TCP traffic. It also enables
CONFIG_CGROUPS and CONFIG_MEMCG in the net selftests config.

> diff --git a/tools/testing/selftests/net/so_reserve_mem.c b/tools/testing/selftests/net/so_reserve_mem.c
> new file mode 100644
> index 0000000000000..920aeccc0ddf7
> --- /dev/null
> +++ b/tools/testing/selftests/net/so_reserve_mem.c
> @@ -0,0 +1,404 @@

[ ... ]

> +FIXTURE_TEARDOWN(so_reserve_mem)
> +{
> +	char path[160];
> +	int fd;
> +
> +	if (!self->cg_mounted)
> +		return;
> +
> +	snprintf(path, sizeof(path), "%s/cgroup.procs", self->cg_root);
> +	fd = open(path, O_WRONLY);
> +	if (fd >= 0) {
> +		dprintf(fd, "%d\n", getpid());
> +		close(fd);
> +	}
> +	if (self->cg_child[0]) {
> +		rmdir(self->cg_child);
> +		self->cg_child[0] = '\0';
> +	}
> +	if (self->restore_subtree_ctrl) {
> +		snprintf(path, sizeof(path), "%s/cgroup.subtree_control",
> +			 self->cg_root);
> +		fd = open(path, O_WRONLY);
> +		if (fd >= 0) {
> +			if (write(fd, "-memory", 7) < 0)
> +				;
> +			close(fd);
> +		}

[Severity: Low]
Can this leave the host cgroup hierarchy modified?

FIXTURE_SETUP() only calls unshare(CLONE_NEWNS), so the cgroup2 mount on
/tmp/ksft_so_reserve_XXXXXX is the same hierarchy the host uses. Setup can
write "+memory" to the root cgroup.subtree_control. It then creates
test_<pid> and moves the process there without recording its original
cgroup.

This teardown moves the process to cg_root, not back to where it started.
The "-memory" write can fail, for example with EBUSY because another child
has since enabled memory in its own subtree_control. In that case the
global change stays and nothing reports it.

The teardown also only runs in the test grandchild. On a harness timeout,
__wait_for_test() in kselftest_harness.h does:

    kill(-(t->pid), SIGKILL);

so the teardown never runs. The same happens on an external SIGKILL or
SIGINT. In those cases three things are left behind:

  - the empty test_<pid> cgroup
  - the /tmp/ksft_so_reserve_XXXXXX directory on the real /tmp
  - "+memory" in the root subtree_control

[ ... ]

> +FIXTURE_SETUP(so_reserve_mem)
> +{
> +	char procs_path[160], ctrl_path[160], ctrl_buf[256] = {};
> +	int fd, ret, val = 0;
> +
> +	self->page_size = sysconf(_SC_PAGESIZE);
> +	ASSERT_GT(self->page_size, 0);
> +
> +	if (unshare(CLONE_NEWNS))
> +		SKIP(return, "Failed to unshare mount namespace (need root)");

[ ... ]

> +	if (!strstr(ctrl_buf, "memory")) {
> +		if (write(fd, "+memory", 7) != 7) {
> +			close(fd);
> +			so_reserve_mem_teardown(_metadata, self, variant);
> +			SKIP(return, "cgroup2 memory controller not available");
> +		}
> +		self->restore_subtree_ctrl = true;
> +	}
> +	close(fd);

[Severity: Low]
Only the mount namespace is unshared, so this reads and modifies the
system-wide root cgroup.subtree_control. What happens if another memcg
user starts relying on the memory controller after this "+memory" write?

For example, a second instance of this test, or a cgroup selftest running
in parallel, would see memory already enabled. It would create its own
child cgroup and rely on memory.max.

The unconditional "-memory" write in FIXTURE_TEARDOWN() would still
succeed. cgroup_subtree_control_write() only returns EBUSY when a live
child has memory in its own subtree_control:

kernel/cgroup/cgroup.c:cgroup_subtree_control_write() {
    ...
			/* a child has it enabled? */
			cgroup_for_each_live_child(child, cgrp) {
				if (child->subtree_control & (1 << ssid)) {
					ret = -EBUSY;
					goto out_unlock;
				}
			}
    ...
}

Children that only inherit the memory css don't block the disable.

Wouldn't the other user's memory css then be killed while it is still in
use? memory.max would disappear, and new sockets would lose sk_memcg, so
SO_RESERVE_MEM would start returning EOPNOTSUPP.

The return value of the "-memory" write is also ignored.

[ ... ]

> +static void check_non_tcp_rejected(struct __test_metadata *_metadata,
> +				   int domain, int type, int protocol,
> +				   int val)
> +{
> +	int fd = socket(domain, type, protocol);
> +
> +	if (fd < 0) {
> +		EXPECT_TRUE(errno == EAFNOSUPPORT ||
> +			    errno == EPROTONOSUPPORT ||
> +			    errno == ENOPROTOOPT);
> +		return;
> +	}

[Severity: Low]
Should EPERM be accepted here too, ideally by skipping this subcase?

The non_tcp_rejected test calls this helper with
AF_INET/SOCK_RAW/IPPROTO_ICMP. inet_create() rejects raw sockets when the
caller lacks CAP_NET_RAW:

net/ipv4/af_inet.c:inet_create() {
    ...
	err = -EPERM;
	if (sock->type == SOCK_RAW && !kern &&
	    !ns_capable(net->user_ns, CAP_NET_RAW))
		goto out_rcu_unlock;
    ...
}

The fixture setup needs only CAP_SYS_ADMIN and filesystem permissions: it
calls unshare(CLONE_NEWNS), mounts cgroup2 and writes cgroup files. So a
runner with CAP_SYS_ADMIN but without CAP_NET_RAW gets through setup.
Examples are root under capsh --drop=cap_net_raw, or a container that
drops NET_RAW.

That runner then fails this EXPECT_TRUE() on EPERM, and SO_RESERVE_MEM is
never tested on a raw socket.

[ ... ]

> +TEST_F(so_reserve_mem, cgroup_memory_max)
> +{

[ ... ]

> +	/* Move test process back to root cgroup before lowering cg_child's
> +	 * memory.max so the limit only governs the socket's memcg charges
> +	 * and cannot trigger OOM on the test process itself.
> +	 */
> +	snprintf(procs_path, sizeof(procs_path), "%s/cgroup.procs",
> +		 self->cg_root);
> +	procs_fd = open(procs_path, O_WRONLY);
> +	ASSERT_GE(procs_fd, 0);
> +	ASSERT_GT(dprintf(procs_fd, "%d\n", getpid()), 0);

[Severity: Medium]
Does this assume that cg_root is the real hierarchy root?

In a non-init cgroup namespace, cgroup_do_get_tree() makes the namespace
root cgroup the root of the cgroup2 mount. This is the default for Docker
on cgroup v2, systemd-nspawn and similar. That cgroup has a parent, so it
is not exempt from the no-internal-process rule.

Consider a namespace root that already has memory in its subtree_control
and populated domain children, as in a systemd-managed container. Setup
succeeds without even writing "+memory", but the move back to cg_root
then fails in cgroup_migrate_vet_dst():

kernel/cgroup/cgroup.c:cgroup_migrate_vet_dst() {
    ...
	if (cgroup_can_be_thread_root(dst_cgrp) || cgroup_is_threaded(dst_cgrp))
		return 0;

	/* apply no-internal-process constraint */
	if (dst_cgrp->subtree_control)
		return -EBUSY;
    ...
}

Wouldn't this ASSERT_GT() then report a failure rather than a skip?

The same move in FIXTURE_TEARDOWN() fails silently in every test. Then:

  - rmdir(self->cg_child) fails with EBUSY because the process is still
    inside
  - cg_child[0] is cleared anyway
  - an empty test_<pid> cgroup stays in the real hierarchy after the
    process exits

[ ... ]

> +	/* Send & drain traffic; cfd must retain its 16-page forward alloc,
> +	 * while sfd (0 reserve) reclaims its forward alloc back to 0.
> +	 */
> +	ASSERT_EQ(send(cfd, buf, sizeof(buf), 0), (ssize_t)sizeof(buf));
> +	ASSERT_EQ(recv(sfd, buf, sizeof(buf), MSG_WAITALL), (ssize_t)sizeof(buf));
> +	wait_wmem_drained(_metadata, cfd);
> +
> +	EXPECT_GE(get_fwd_alloc(_metadata, cfd), (__u32)(16 * ps));

[Severity: Low]
Can this check fail intermittently?

wait_wmem_drained() returns as soon as SO_MEMINFO shows
SK_MEMINFO_WMEM_QUEUED == 0. SK_MEMINFO_FWD_ALLOC is then read by a
separate getsockopt(). sk_get_meminfo() reads each field with its own
READ_ONCE() and takes no socket lock.

When an ACK frees a skb from the rtx queue of cfd, the counters are
updated in this order:

include/net/tcp.h:tcp_wmem_free_skb() {
	sk_wmem_queued_add(sk, -skb->truesize);
	if (!skb_zcopy_pure(skb))
		sk_mem_uncharge(sk, skb->truesize);
    ...
}

That ACK processing can run on another CPU. It can come from the
delayed-ACK timer, from ksoftirqd after the test thread has migrated, or
from a preemptible softirq thread on PREEMPT_RT.

The test can then see WMEM_QUEUED == 0 while FWD_ALLOC is still
16 * ps - truesize. FWD_ALLOC is not polled again after that.

Would polling until a single SO_MEMINFO snapshot shows both
WMEM_QUEUED == 0 and FWD_ALLOC >= 16 * ps close this window?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925135244.3715196-1-edumazet%40google.com
