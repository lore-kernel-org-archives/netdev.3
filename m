Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846423B14C6
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787958670; cv=none; b=uC8mPqQfV3SJEclihrBbQzHlE+o3vdl+F+05Q0ha7difWsF9Ux6pnltlqjNWlzqyfmuM0y7TAOJe93NW0sD/MR3UXcPT0IAGobh6iotBKwH6yKQgeWtya4qWLrpioNNPqDw6M3xL0qQAtC1oRDVCdwS5QGM+5vUrZaf4biMU/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787958670; c=relaxed/simple;
	bh=YxSjtrLf4cxlGcijQyb/AFgFFuuFqR7je+QDsU77qfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G46rdAbO8gLIOkyiyoDByr+gydbjzvmLkiymMMHsJJ60ux+0tPRCYaWx9LxoCkHGHmmj0fQxF2kNklFmYUCT2FevJ5+bRdlG0OkGaMvjvX1GVRIYyZLfEynO6XSIKEJb6R10u61giWjNc9jgCgWFSiUtZMxCuP0OY54PUVYgu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5IX3r49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5IX3r49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D60F1F00A3D;
	Fri, 28 Aug 2026 23:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787958669;
	bh=fgtlmAQAGyq0joc/Zq5Use+yRg/pXA0Pf4JaR3KC9KM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C5IX3r49wED1deG8gXbh14qmTmdjUJ9bufvpoJLUjLgHGC46t0Wb3RDd9ejmP+K6N
	 TeASvYCRq5mq9Q5YbDi28ePdmlaD6C+7Y7WMMZ5SCZc5DnvdiFn3qp/ms6G1aHiMwB
	 RK4JUIzXnHFD92THhATtb+9+pPMY/kL1AVN0lQspiBuQoEuZisCbCF1/a7Agpd1CuQ
	 xO6RFfkoPvDBJ4cnaHMImP0jrQhMJc7y//ukg3xlGQAG81Xn53YZP4AfdTThcQ1Kgt
	 u+On/nlzhcwp48gIe2XARzsWpLiR6AAH86hDLBLH3FcVcz/RLqXSLiJD7ma+VTSJEa
	 pfXW4UXlGEFyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19842380AA69;
	Fri, 28 Aug 2026 23:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: iptunnel: fix stale transport header during
 tunnel decapsulation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178795861364.2836129.3831261202483160251.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 23:10:13 +0000
References: <20260825123909.1463121-1-dongchenchen2@huawei.com>
In-Reply-To: <20260825123909.1463121-1-dongchenchen2@huawei.com>
To: dongchenchen (A) <dongchenchen2@huawei.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dsahern@kernel.org, kees@kernel.org,
 netdev@vger.kernel.org, zhangchangzhong@huawei.com,
 syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Aug 2026 20:39:09 +0800 you wrote:
> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
> transport_header offset after tunnel decapsulation.
> 
> BUG: unable to handle page fault for address: ffffed102091a42e
> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4-00061-g248951ddc14d #256 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:__asan_load2
> <IRQ>
> qdisc_pkt_len_segs_init (net/core/dev.c:4145)
> __dev_queue_xmit (net/core/dev.c:4787)
> br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
> br_handle_frame_finish (net/bridge/br_input.c:229)
> br_handle_frame (net/bridge/br_input.c:315)
> __netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
> __netif_receive_skb_list_core (net/core/dev.c:6287)
> netif_receive_skb_list_internal (net/core/dev.c:6445)
> napi_complete_done (net/core/dev.c:6813)
> gro_cell_poll (net/core/gro_cells.c:74)
> __napi_poll (net/core/dev.c:7735)
> net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
> handle_softirqs (kernel/softirq.c:622)
> do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
> __local_bh_enable_ip (kernel/softirq.c:450)
> tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
> tun_chr_write_iter (drivers/net/tun.c:2032)
> 
> [...]

Here is the summary with links:
  - [net,v3] net: iptunnel: fix stale transport header during tunnel decapsulation
    https://git.kernel.org/netdev/net/c/28a57fb2c5df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


