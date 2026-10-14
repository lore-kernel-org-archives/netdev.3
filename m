Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D960397930;
	Wed, 14 Oct 2026 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945611; cv=none; b=Q2OxsiltIdIl008WExTWzPuhGG9Jvh26oLvCcODkc091zMIKWzIIFcqYCHXM+NB/qZj5i6vO51uecCXwzfIJC6WrsL4Br4JNvRjzJZSI0qekLs6zWS/SpDg7IDuAPyKz/HomyoWX+PFjIlFlPUNCQ/+SI0fstj/RAsN3iZbVEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945611; c=relaxed/simple;
	bh=X8lj5J4ZUuGxbnbcgCbLyk0XKbqXPSWIhxxb3NYP7qc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=daCJb9IxcUhSHhDuRKYMcDFyQV831V7e3FJFxf2NAnky8JG3zl8zRdpcYFhNHCLgCQ5oRk38nLqycBVC9Wh7RJqso/C0eLhZQGR7iWsM66zAA/fu4gsc0ApcbLp5yj9QBi+6xDpZLnRcYND8FEVqyZiHvZTNUsO2txqBuKCRujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGmaWVhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGmaWVhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81931F000FF;
	Wed, 14 Oct 2026 02:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945609;
	bh=hBkVpvKUPtDDjwwzZ3YUQSxJAQTY2TrMIaX7dOwsj6w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KGmaWVhxCW8ztqS65PueVuORxF1wb2xc269m9LFQSeGyCMR/UCuzwjBRR11ZOykIY
	 ksQkcHup27juJiNIjSrxov0ihiu+qk7rU8GqxR9h+pRjsj4+BrrrvrDJR6cvjOvchV
	 Rry8l34ah/adO3pCtnE+2DitNjhepaNK6kYzmBk7CoQnWzOebpo6lMELj0iz9Vj+29
	 LJ1a5I1whqpBeVe5is6HmUvCR/5WJq6nvKvgqBZkjvjQtkxV1GNKrz2xtGGkiLwoI0
	 DMmbH6ZdBZCIZ9chbhMGgjVx/5kwl5jw+oUAC3NRFu8r4ZFpEOkpY8fbBlWHsMhpV+
	 el1qm2eZj8qCA==
Subject: Re: [PATCH net v2] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: edumazet@kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, nicolas.dichtel@6wind.com,
 kees@kernel.org, i.maximets@ovn.org, leitao@debian.org, jlayton@kernel.org,
 kexinsun@smail.nju.edu.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 02:40:08 +0000
Message-ID: <179194560847.434549.7995246256511325364@kernel.org>
In-Reply-To: <20261013023859.3075601-1-bsdhenrymartin@gmail.com>
References: <20261013023859.3075601-1-bsdhenrymartin@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The code guard is correct.

--

netlink: fix out-of-bounds bitmap access clearing stale mc groups

This patch adds a bounds check to netlink_update_socket_mc().  With it,
__netlink_clear_multicast_users() no longer tests or clears bits past a
socket's nlk->groups bitmap.  Sockets whose bitmap was sized before the
multicast group table grew are skipped for groups beyond nlk->ngroups.

> With in-tree families the overflow is only reachable on 32-bit
> kernels: the ~54 dynamically allocated genl groups fit the initial
> 64-bit bitmap on 64-bit kernels but exceed the 32-bit one, so the
> table can grow there, and a later module unload then touches bits
> past the bitmap of stale sockets.

[Severity: Medium]
The guard looks correct on every architecture.  Is the claim that only
32-bit kernels are affected accurate, though?

genl_allocate_reserve_groups() in net/netlink/genetlink.c does a first-fit
search for a contiguous range.  It grows the table whenever that range ends
past the current capacity:

net/netlink/genetlink.c:genl_allocate_reserve_groups() {
    ...
		if (id + n_groups > mc_groups_longs * BITS_PER_LONG) {
			unsigned long new_longs = mc_groups_longs +
						  BITS_TO_LONGS(n_groups);
    ...
}

genl_unregister_mc_groups() frees IDs with clear_bit(), and nothing
compacts the remaining allocations.  So the number of live groups does not
limit the highest group ID.

The initial bitmap also starts with five bits reserved:

static unsigned long mc_group_start = 0x3 | BIT(GENL_ID_CTRL) |
				      BIT(GENL_ID_VFS_DQUOT) |
				      BIT(GENL_ID_PMCRAID);

That leaves 59 free IDs on a 64-bit kernel, only about 5 more than the ~54
in-tree groups.

With most in-tree families loaded, can an unload/reload sequence fragment
the free space enough to force growth on 64-bit?  For example:

  unload nl80211 (7 groups with CONFIG_NL80211_TESTMODE) and psample
  load psample, which takes part of nl80211's old range
  load nl80211, which no longer fits in any free 7-bit gap

At that point id + n_groups > 64, mc_groups_longs becomes 2, and
__netlink_change_ngroups() raises tbl->groups to 128.  Sockets that
subscribed earlier still have nlk->ngroups == 64 and an 8-byte bitmap.

A later unload of nl80211 then reaches:

genl_unregister_mc_groups()
  __netlink_clear_multicast_users()
    netlink_update_socket_mc()
      test_bit(group - 1, nlk->groups)        /* bit 64 */
      __assign_bit(group - 1, nlk->groups, 0)

Without this patch, that would be an out-of-bounds access on a 64-bit
kernel with only in-tree modules.

The v2 notes say Cc: stable was dropped because of this reachability
description.  Could this paragraph be reworded so backporters don't
conclude that 64-bit kernels are unaffected?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013023859.3075601-1-bsdhenrymartin%40gmail.com
