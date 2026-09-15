Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E042496D4F;
	Tue, 15 Sep 2026 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486503; cv=none; b=XsTUPfdEVYZTAZS+sOGSdz3oQsPxL+dpFry296ZxwSypA3AZrIBJ1f6ZDhLjT88NwIZ14mCqD8/Wzf6BMIQjt0nEDLKPVAb2ZwwbwkR5JdRljPLtM7BSlW5lJzaCVqCBR/0XhMLuwG8y87/zSbcnh7LaKBi41X0SPTY4Gn60e1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486503; c=relaxed/simple;
	bh=Vi8QNQvOSZLu38Lc9fOwm0cZbNGfuNU56o0uf9mHrbs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUa3gObn2DCdKY5PDLn9J+amd1UdNRcSFVTtJJKjB3aktNl1ya6Hq5y3ku/uu/b/+5OxAkVflTm+hR6puIpDWbeXyjcuhvZrV2rhEJqrYh5nuiB3ZXP2sE06SxlBexTPn4pfUaaM9XL87+ik/uQHVtS2jTuDRHCnm6udv+2M/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IW909MCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW909MCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D371F000FF;
	Tue, 15 Sep 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789486501;
	bh=C8YtmFrSxxY0AanUwQl01S3XpkP74Rctp5eoGI1AVSo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IW909MCLfVufJ47Dk81WpQU98oBji+YOqUk+hhsJMij2kDBlow3e5+Mk3Hbr39SeX
	 4SkVw2pKjycEzdiwb87/aZx1HwR/TgIQBDHvwWIYWw1lLj7em2fDkheTDS4V55TyEd
	 jpP8mtDcpwR21X6Lq399/aXjiQ7cCCeDPPnwIYo2PEq5Vfr1JCiT+g+XKhDdL/w2fY
	 eyLQlhJPQ+lyWtadRBnhM2HrK4JDgy6xX8LPg+8A9LzyNBRdGHKRyYCPq1FVH2N6hE
	 NkP8LxAZTxftQp4KtPk85kAkT40FfUIpxG0eKsaJuK6dPR+3xR4DvGSaWL2xvdsx2x
	 lF6KcqN0GFxQQ==
Subject: Re: [PATCH] ixgbe: fix incomplete ACI command buffer backup on retry
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn, kuba@kernel.org
Date: Tue, 15 Sep 2026 15:34:59 +0000
Message-ID: <178948649971.22033.11309152117855565563@kernel.org>
In-Reply-To: <20260912013403.2818191-1-xiaolinkui@126.com>
References: <20260912013403.2818191-1-xiaolinkui@126.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] Commit message overstates the impact of the fixed bug.
- [Low] Commit message names the wrong ice function as the reference
  implementation.

--

ixgbe: fix incomplete ACI command buffer backup on retry

The patch replaces the kmalloc() plus single-byte store in
ixgbe_aci_send_cmd() with kmemdup() so the whole indirect command buffer
is saved before an EBUSY retry, skips the backup when buf_size is 0, and
keys the restore off buf_cpy instead of buf. The code change itself looks
correct; the questions below are about the changelog only, so the diff
hunks are snipped.

> So every retry hands the firmware a buffer whose content, apart from the
> first byte, is uninitialized slab memory, and on a read command the
> caller's buffer is overwritten with that garbage when the retry finally
> gives up.

[Severity: Medium]
Can the firmware actually see that garbage?  In
ixgbe_aci_send_cmd_execute() the buffer only reaches the HIBA registers
when the descriptor carries LIBIE_AQ_FLAG_RD:

drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:ixgbe_aci_send_cmd_execute() {
	...
	if (desc->flags & cpu_to_le16(LIBIE_AQ_FLAG_RD)) {
		for (i = 0; i < buf_size / 4; i++)
			IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i), ((u32 *)buf)[i]);
	...
}

The backup/restore path only runs for the opcodes listed in
ixgbe_should_retry_aci_send_cmd_execute(): disable_rxen, get_phy_caps,
get_link_status and get_link_topo.  disable_rxen and get_link_topo pass
(NULL, 0), and the two that do pass a buffer (ixgbe_aci_get_phy_caps()
and ixgbe_aci_get_link_info()) build their descriptor with
ixgbe_fill_dflt_direct_cmd_desc(), which sets only LIBIE_AQ_FLAG_SI.
LIBIE_AQ_FLAG_RD is OR-ed in only by set_phy_cfg, the NVM write,
nvm_pkg_data and nvm_pass_component_tbl paths, none of which are
retryable.

Also, on both EBUSY exits ixgbe_aci_send_cmd_execute() returns before the
"Write a response values to a buf" block, so buf is not touched by an
EBUSY attempt and the restore is effectively a no-op there.

Would it be more accurate to describe the effect as the caller's output
buffer being filled with uninitialized slab bytes once retries are
exhausted, rather than as garbage being handed to the firmware on every
retry?  As written the message suggests a functional firmware
interaction problem, which affects how this reads for stable triage.

> Use kmemdup() to copy the whole buffer, exactly like the equivalent
> ice_sq_send_cmd() already does.

[Severity: Low]
Is ice_sq_send_cmd() the right reference here?  That function is the
low-level control queue submit routine, the counterpart of
ixgbe_aci_send_cmd_execute(), and it has no buffer backup.  The
kmemdup()-based backup and restore-on-EBUSY logic lives in
ice_sq_send_cmd_retry() in drivers/net/ethernet/intel/ice/ice_common.c:

drivers/net/ethernet/intel/ice/ice_common.c:ice_sq_send_cmd_retry() {
	...
	if (is_cmd_for_retry) {
		if (buf) {
			buf_cpy = kmemdup(buf, buf_size, GFP_KERNEL);
			if (!buf_cpy)
				return -ENOMEM;
		}
	...
		if (buf_cpy)
			memcpy(buf, buf_cpy, buf_size);
	...
}

Could the changelog name ice_sq_send_cmd_retry() instead?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912013403.2818191-1-xiaolinkui%40126.com
