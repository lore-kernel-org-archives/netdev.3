Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792948780;
	b=2Tc+VI1DenzLDAcn4oZM7cIsxuO8YqzW96OODpVhwJhmidDHnaEwx1cT7nIGamkJkYJf
	 JeVGki5vc2AO6XVHTvOtkpEEDG0pOO+HeskMQqVuAdWBpNg7cwNEJ/wcy6Q1UrwbXZFLw
	 NfQYCmL0yOFGVYoLUoZTEq71VBjTPeGlFCj7JoeLhsX3qn6YBp05PJM28beTU/9BgJvZF
	 2Q5AoEHMNBnpX4K2Ov5lM+ITS813QvhVnlnn6gUqQlLAtAmDkOdUkafk2konZ+eX7uuJh
	 pwApiTDgYkpMNnmPt1brRxVkUMeYxwZ9lIKTemQxGVG/qoRUZ7LO6uPNv8R7zZIGNCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792948780;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1QCoEeqMlDVVRDqJEXOAfa8mWgIDoI3oNzTQThcstEQ=;
	b=dypXCsah8oQAn76WVrV1pkuW+EgjX7wufjlUh4KYU8/ssC7bcOslKX7+EhQRcpLSiAZK
	 3NOqLkNJJShqdZv6IqlKxNk4mCivV/93GKdUAmqQMnsRdy0FZqb94KiHYBZIHb/qfQCyh
	 FgzqsSC6GrpPfuV9M3CgVsDn1+T3fmHu2QSvJonSvk5U4QdlLkDU1AK2oGtLws2F0Ljtp
	 ZGyV9eWf17DL5lETrlzVN01YimVFgy71rqVXHW01d2HBA23YW1BhaPk1l9wxmXx1Nlu9a
	 vf6r2KbO05g3UMEQkHgXBnaxx10xGFvUl3ZxLzaJrjHsfa3OqXUB89eL8sug/8oESIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2LYHFLk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F66606A323
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2LYHFLk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D043F1F01829;
	Sun, 25 Oct 2026 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792948780;
	bh=1QCoEeqMlDVVRDqJEXOAfa8mWgIDoI3oNzTQThcstEQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C2LYHFLkjO9s7rbgT4/cgSPKlJS8e34LVGrx+/9ydP3/uLd0krUt7Zp4GUolENr87
	 9iQPdEcacDq1EczQzy2QoK66ORXUrEyzmI6/U2fd2+9LB9EGF2ric94xDCj2eHD9bK
	 jduziSZqu0qFXIynFEAf4fDjzkP6Y5Q9ccn5mkRGxKxHAFCz/qb/wWwWzUtkXXT5wZ
	 j2U6TWcsaW7S5rhh778EC8gNnevcIh9ncjfRsdkpgAbnbXhkCmTqLqAX6jz5pyNEyK
	 Dkf+pyzHKZ7QXElEsLIfdJpCEmaIbLdSu1JqmCjcCwjslN5T62dsO/6LDCWyxbr0NU
	 OCa/7p6xmb7lg==
Subject: Re: [PATCH net] net-sysfs: reject a one-entry RPS flow table
From: netdev-bot+sashiko@kernel.org
To: phx0fer@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Date: Sun, 25 Oct 2026 17:19:39 +0000
Message-ID: <179294877939.3134.15070468351111761899@kernel.org>
In-Reply-To: <20261021155522.67521-1-phx0fer@gmail.com>
References: <20261021155522.67521-1-phx0fer@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes: tag and the root-cause explanation in the commit
  message point to the wrong commit.
- [Medium] The patch fixes the UB by rejecting rps_flow_cnt == 1 with
  -EINVAL instead of handling it, which changes user-visible sysfs…

--

net-sysfs: reject a one-entry RPS flow table

This patch makes store_rps_dev_flow_table_cnt() return -EINVAL when
rps_flow_cnt is 1. With a count of 1 the mask rounds to 0 and the encoded
log is 0. rfs_slot() then calls hash_32(hash, 0), which shifts by 32 and
produces an index outside rps_dev_flow[] in get_rps_cpu().

> store_rps_dev_flow_table_cnt() accepts rps_flow_cnt == 1.  For count == 1
> the round-up loop leaves mask == 0, which is stored as log == 0 in the
> tag (tag_ptr |= ilog2(mask) + 1).

[ ... ]

> Fixes: a435163d3100 ("net-sysfs: use rps_tag_ptr and remove metadata from rps_dev_flow_table")

[Severity: Medium]
Is a435163d3100 the right commit for this Fixes: tag?

f3483c8e1da6 ("net: rfs: hash function change") replaced the per-queue
index hash & flow_table->mask with rfs_slot(), which calls
hash_32(hash, flow_table->log). It also added this to
store_rps_dev_flow_table_cnt():

    table->log = ilog2(mask) + 1;

Before that commit, rps_flow_cnt == 1 gave mask == 0, and every packet used
slot 0. After it, mask == 0 gives log == 0, and hash_32(hash, 0) shifts by
32.

a435163d3100 appears to only move log from table->log into the low bits of
rps_tag_ptr. It keeps the same ilog2(mask) + 1 calculation and the same
hash_32() call.

If that's right, kernels from v6.15 through v7.0 have the same
out-of-bounds read of rflow->cpu and write of last_qtail in get_rps_cpu()
when rps_flow_cnt is 1. set_rps_cpu() is affected too with RFS_ACCEL. The
current tag would point stable backports at the wrong range. Those trees
also still use struct rps_dev_flow_table and table->log, so the diff would
not apply there as is.

Should the tag be Fixes: f3483c8e1da6 ("net: rfs: hash function change"),
with the explanation pointing at the ilog2(mask) + 1 calculation rather
than the tag encoding?

> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 352173df75785..038f7930544fb 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1088,6 +1088,15 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
>  		while ((mask | (mask >> 1)) != mask)
>  			mask |= (mask >> 1);
>  
> +		/* A one-entry table rounds up to mask == 0, which encodes
> +		 * log == 0 in the tag.  get_rps_cpu() then computes
> +		 * hash_32(hash, 0) -- a shift by 32 -- and indexes the
> +		 * one-entry rps_dev_flow[] with the full 32-bit hash.
> +		 * Require at least two entries.
> +		 */
> +		if (!mask)
> +			return -EINVAL;

[Severity: Medium]
Rejecting count == 1 here changes how the sysfs interface behaves, and
nothing documents that. Was that intended? Every other non-zero value
written to rps_flow_cnt is still rounded up to the next power of two (3
becomes 4, 5 becomes 8). Only 1 now fails with -EINVAL.

Documentation/networking/scaling.rst says this about rps_sock_flow_entries
and rps_flow_cnt:

    Values for both are rounded up to the nearest power of two.

It gives no minimum, so by that text 1 should give a one-entry table.

The per-queue formula in scaling.rst (rps_sock_flow_entries / N) can
produce 1. So can the script in
Documentation/networking/device_drivers/ethernet/intel/ice.rst:

    # echo $(($NUM_RPS_ENTRIES/$NUM_RX_QUEUES)) > $file;

Both give 1 whenever N <= rps_sock_flow_entries < 2*N, and those writes
would now fail.

rps_sock_flow_sysctl() in net/core/sysctl_net_core.c still accepts a size
of 1. roundup_pow_of_two(1) is 1 and ilog2(size) is 0. After this patch
the two RFS table-size knobs would treat 1 differently.

Since v6.15, writing 1 here has hit the out-of-bounds bug rather than
working. So no setup that works today loses anything. The difference is
against the documented rounding, the pre-6.15 behaviour, and the sysctl.

The table is already allocated with at least a page:

    sz = max_t(size_t, sizeof(*table) * (mask + 1), PAGE_SIZE);

Could mask be set to 1 when it is 0 instead? That avoids hash_32(hash, 0),
uses no extra memory, and keeps the write working. Another option would be
for rfs_slot() to return 0 when log == 0.

If the -EINVAL stays, should the commit message and scaling.rst mention
the new minimum?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021155522.67521-1-phx0fer%40gmail.com
