Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33C39280C
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628473; cv=none; b=gcA6NsSUwF4jtuTIgLsvR/lbPENIOMh3FPidXmBH4MrvGzIy599xUnC6MJkEq5iahV8a3bpe/Fd8rnK30FL5z1vW+jEr9tht71vUmnkCiiBLOlkQMHmKtcWIZfKi499aXRagdNe8vRnaJpeha1i8CpFvFG8pKHFoa81DOvcGBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628473; c=relaxed/simple;
	bh=CpYn3dhZnO//DQniJI8cbgzIKG5lpksVyDcdBUBx4DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoDTEEO1SiZDf7GukNk6kKUvden5wLjyFGp2BcljQX/HiABO0YbqK02+oMIsAUVUAnmEU53vcLmSQX1jcUtXkXk9mpuSFAIMsdPxZtjYH3guCAw48exJE1o5i28ghtjszKHzPnBkPQ01HvJPDUbmTo8d3Qi84H3dill4wX+fN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfACpuDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfACpuDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB4C1F000E9;
	Thu, 13 Aug 2026 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786628472;
	bh=9EE/BH3UiuwcrIxxvRbbgXCdLnjpoDTMD4n+FkY/R8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BfACpuDe5G8qX7sXQsqAK7gc+rT3WtYryujv1ByOx0sFeKgZRL2D/yRcGBOrClB2E
	 qmTY4WFCODY/ZB5YoXB6bHsdjpWpJgTlprQiwb5LcQs/BFsHcUpMSoGqJ1LEBfHbH4
	 FhMhPSz7/IyNzTNoiioswWH54ID3Df+3jvBKBQL+mcdW7dyl4QMuRfQ0mEDZyIyGJZ
	 Ri3rljowrqmzPDI2go1esnXjSWiM1aF+qIt5bkLBiUkuyXEHwF5vi39ANePS50U2Wj
	 fJTntFGeCDVKeMTFMz6ADvV6Ebo9chsxYK2tIKNuVheNts1xTS9ICFtRwtVCQrtVF1
	 YvVp32Y1IpMcA==
Date: Thu, 13 Aug 2026 14:41:08 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, joshua.a.hay@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible race on
 remove during a reset
Message-ID: <20260813134108.GC265046@horms.kernel.org>
References: <20260811171751.22165-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811171751.22165-1-emil.s.tantilov@intel.com>

On Tue, Aug 11, 2026 at 10:17:51AM -0700, Emil Tantilov wrote:
> Reset and remove can race, leaving NAPI registered and enabled:
> 
> modprobe idpf& sleep 1; ip link set eth0 up& rmmod idpf
> 
> [145561.805104] WARNING: net/core/dev.c:7699 at __netif_napi_del_locked+0x11a/0x130, CPU#30: rmmod/22393
> ...
> [145561.810238] RIP: 0010:__netif_napi_del_locked+0x11a/0x130
> ...
> [145561.817678] Call Trace:
> [145561.818125]  <TASK>
> [145561.818653]  free_netdev+0x110/0x2a0
> [145561.819109]  idpf_vport_dealloc+0x452/0x460 [idpf]
> [145561.819668]  ? enable_work+0x9f/0x100
> [145561.820133]  idpf_deinit_task+0x51/0x70 [idpf]
> [145561.820694]  idpf_vc_core_deinit+0x32/0x170 [idpf]
> [145561.821193]  idpf_remove+0x40/0x200 [idpf]
> [145561.821667]  pci_device_remove+0x40/0xa0
> [145561.822132]  device_release_driver_internal+0x1a9/0x210
> [145561.822691]  driver_detach+0x4b/0x90
> [145561.823161]  bus_remove_driver+0x70/0x100
> [145561.823721]  pci_unregister_driver+0x2e/0xb0
> [145561.824207]  __do_sys_delete_module.constprop.0+0x190/0x2e0
> [145561.824715]  ? kmem_cache_free+0x312/0x550
> [145561.825213]  do_syscall_64+0xc8/0x6b0
> [145561.825709]  ? clear_bhb_loop+0x30/0x80
> [145561.826216]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [145561.826602] RIP: 0033:0x7fe628130beb
> 
> Make sure to call idpf_vport_stop() in idpf_stop(), irrespective of the
> IDPF_REMOVE_IN_PROG state, to allow a reset racing with remove to tear
> down NAPI in idpf_detach_and_close(), which runs under RTNL lock.
> 
> Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a reset")
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

