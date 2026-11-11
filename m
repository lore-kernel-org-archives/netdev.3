Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412239;
	b=EBlYISLS+8GE87dR/vSJWcIxfGSvGgKQX46iWwGzGZW+xYd9l5qAPI6gn8f98hP18VMT
	 S7Lsjb2QC8WaGegkspK/EyBiMIinu3V6QRZg0eJIs8ncd6aLS4ttVyrLBo6TX3wnC3q6g
	 zAyJHlopJPBSZIuvdrh8B5UMcqLUGAWsb8rLkreX/mfLzQsZeEHe6iia80tPCpcRERi9P
	 Zlabvm0eTyEmDAilj01te7Bd96R5i0r8itl6XsoMu9ztpxd0rUvDEO8xQ9JeNP6L/ydxV
	 nrYWbDztwWXzkibbbCGe5DgNgA853rCgRy8FwNkomeCjcDGXKM3YWfZC9SDcJ6hOLcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412239;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8KzQ+7NCaEl204EfDW/Y8h/f7LSbabrvgPKHfKnDzoU=;
	b=TUhlboVKBxcvkdSBPY3Kac89KPgetURvsNt81bKd0YvX6DvtxCRaVa4dctpwSgcg97lP
	 okBVhjI5WVnTbZSy+xUFAgCTxCn2PfNiIRkJZ0ou9GrQmAaRMIDqXnXlTea7mwXT4gbrb
	 kEqOFwiXCcddlQkF1POAfLMxEsIF8UoH2uBbFhiGHqn7rIj665fX4rr8qvWOjDM9KUhMn
	 BLupcuIj4FqTNIt++1FhfNFYbQMUOnWvHXAPyRyqI91nF3tqHVy2pPu+hpYkLtyVgVF3g
	 UiwoJpDlPtM1DErnyOzss7f3YYDPlgyccPKvpvuAW124Ro3pkq6Aw82+YcR4+/c3fSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3tQ267P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C8606A335
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3tQ267P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD331F00A05;
	Wed, 11 Nov 2026 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412238;
	bh=8KzQ+7NCaEl204EfDW/Y8h/f7LSbabrvgPKHfKnDzoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R3tQ267PaUEHswz6bgkMLHLo9y2NGpXcbSU/c3KyyqxHWAOnCY1sMxloBegKV1AOn
	 gNSL9L0wYnhCmAPcDEqnLNaUPjhOK6y5F2k6r8Nsc6gJ1+qtiAqGBIgCme/1eoJ5ez
	 2bkZMq5Lb9tH916OxKX9RVgiC8qNlKJMsdAyrCclrsxq/NpgdWwvOvYKa/t0d5dxUF
	 fENUqvwJ8Ezb7Q4qd65vH/zNx29DPcpjM5bI4rfl3T/W7Fd9nZafDUovhn/IyyFYur
	 Hkm2QlYlwRXA2WGnBDin5qkyOIHi0u+yafuZWdhCgRZGqtzmlLkA/wtehO7N4qCHpv
	 7RsI5R6Adtw0w==
Date: Wed, 11 Nov 2026 15:50:34 +0000
From: Simon Horman <horms@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	harshitha.vr@chelsio.com
Subject: Re: [PATCH net-next v5 REPOST 03/12] cxgb4: add T7 hardware
 management support
Message-ID: <20261111155034.GF18859@horms.kernel.org>
References: <20261105131549.547554-1-bharat@chelsio.com>
 <20261105131549.547554-4-bharat@chelsio.com>
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
In-Reply-To: <20261105131549.547554-4-bharat@chelsio.com>

On Thu, Nov 05, 2026 at 08:15:40AM -0500, Potnuri Bharat Teja wrote:
> Extend the cxgb4 hardware management layer to support T7 adapters.
> 
> Add T7 handling to hardware resource and topology discovery.  The TP
> load balancer mode and the firmware supplied TP channel map are read
> into adapter_params, and t4_get_mps_bg_map() and t4_get_tp_ch_map()
> account for the T7 channel layout.  The load balancer mode distributes
> the four TP channels across the active ports as four ports of one
> channel, two ports of two channels, or one port of four channels.
> 
> t4_get_chip_type() moves from cxgb4_main.c into t4_hw.c so that chip
> identification lives with the rest of the hardware layer, and learns
> the T7 chip version.
> 
> Add T7 flash support.  The flash layout is described by a table
> indexed by flash location rather than by fixed FLASH_*_START_SEC and
> FLASH_*_NSECS constants, with t4_flash_location_start_sec(),
> t4_flash_location_nsecs(), t4_flash_location_start() and
> t4_flash_location_size() returning the bounds of a region.
> t4_flash_cfg_addr() now returns int so that it can report a region
> that does not exist on the running adapter.  t4_get_flash_params()
> learns the flash parts used on T7 and a four byte address serial
> flash interface, which is required for parts larger than 16MB.
> 
> Add the T7 register ranges to t4_get_regs(), the T7 PCIE memory window
> registers, and T7 support to the CIM ingress and egress queue, CIM LA,
> SGE context, MPS trace filter, PM statistics, scheduler and I2C
> accessors.
> 
> T7 implements multiple uP cores.  The number of enabled cores is read
> during device log initialisation and the per core device log
> parameters are kept in an array, so that the device log and the CIM
> queue accessors can address a specific core.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  .../net/ethernet/chelsio/cxgb4/cudbg_lib.c    |    4 +-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   89 +-
>  .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    |    2 +-
>  .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |   17 -
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    | 2200 ++++++++++++++---
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.h    |  139 +-

Hi Potnuri,

I've looked over the first three patches of this series, with the help
of AI, and I'd like to provide some general feedback:

* These patches, and the overall patchset are very long.
  I would really suggest splitting up these patches.
  And I think that means also splitting up the patch-set,
  into stages.

  I know that sounds like it's going to take longer.
  But experience tells me that getting review of large
  patchsets to the extent that a merge occurs tends
  to be a very long road.

* Being long, these patches do many things.
  But the preferred approach is one thing per patch.
  This is much easier on my human brain.
  And I don't believe I am alone here.

* It seems to be a bit of a stretch for patches 1/12 and 2/12 to
  claim there are no functional changes. And to be honest,
  they are two long for me to dive into the details.

And, some specific feedback on this patch:

* It appears to introduce new kdoc warnings. Which I believe
  are gating part of our CI. This is not desirable.

Warnings before: 262 after: 276 (add: 20 del: 6)

Warnings removed:
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:12909 No description found for return value of 't4_read_cim_ibq'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:12951 No description found for return value of 't4_read_cim_obq'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:13550 No description found for return value of 't4_i2c_rd'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:12909 No description found for return value of 't4_read_cim_ibq'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:12951 No description found for return value of 't4_read_cim_obq'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:13550 No description found for return value of 't4_i2c_rd'
Per-file breakdown:
     6 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c

New warnings added:
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:9269 No description found for return value of 't7_wait_sram_done'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:10396 No description found for return value of 't4_get_tp_port_chan'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:13332 No description found for return value of 't4_get_chip_type'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:13641 No description found for return value of 't4_sge_get_qpp'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:14243 No description found for return value of 't4_read_cim_ibq_core'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:14319 No description found for return value of 't4_read_cim_obq_core'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:14373 No description found for return value of 't4_cim_read_core'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:14429 No description found for return value of 't4_cim_write_core'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:14484 No description found for return value of 't4_cim_read_la_core'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:15019 No description found for return value of 't4_i2c_io'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:9269 No description found for return value of 't7_wait_sram_done'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:10396 No description found for return value of 't4_get_tp_port_chan'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:13332 No description found for return value of 't4_get_chip_type'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:13641 No description found for return value of 't4_sge_get_qpp'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:14243 No description found for return value of 't4_read_cim_ibq_core'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:14319 No description found for return value of 't4_read_cim_obq_core'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:14373 No description found for return value of 't4_cim_read_core'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:14429 No description found for return value of 't4_cim_write_core'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:14484 No description found for return value of 't4_cim_read_la_core'
Warning: drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:15019 No description found for return value of 't4_i2c_io'
Per-file breakdown:
    20 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c

-- 
pw-bot: changes-requested


