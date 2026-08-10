Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA232B10A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377522; cv=pass; b=KMhCoYPxrKyKTkLJ1N47C3kjnR7dGzZCIB3kreS5XP2B6SY+MQZPL8dC1j0EWA5+6LuFYBn3v0q9BsY0lar2HyR0ONhNxQU9XtW82JA+YB3ItKI6c6JzOiGsMQbHTIHWOpsnynFVHkEbi15E2hNZHl/Mq83wMOuQbS6r9F38hNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377522; c=relaxed/simple;
	bh=IpSNJVCkG2TKyURgWPEcuAOKWeqj8AWA7ximAH8zoes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsMTeaJaetp2ObXtLncBuYjh2bYIDVAOadKkDHAY9HLOuJUyXlZrwI6xhY87tt8M1ASPbk1ZBR8fM9Cm3+EWk+1ijpe88WjIJU4EtN3LnO3dpEdNoUNjC/vrit3aakbJvMWEtK/ZcTV6amSL4NGrJ29lN5qe+u+qhrto0t0tgag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ShEf/Gwd; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ShEf/Gwd"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c276bfce7eso1632581e0c.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786377519; cv=none;
        d=google.com; s=arc-20260327;
        b=L/r+pofo8D4NxAoYw7X3qSpz2eBBbWrawHKKZU8WH/BVwMN6wplSfiXRNOxYCBuuxA
         H5qq21wz0YkfO2zSdQD8S4UxOQTKYoeowSr6PpBftDeQ4/4MxH60hsnFjzR9nd9hoC4c
         BqSO9H+Hiuwu5wmAMi16hiqAY05q8kJ97hIE+0tI23x3KmHJjqy3yDlcHDQ+esseIYpo
         fsF+1JrzNu1v2U0RDZlV+r8vBVDxG0J1+iP6DckKP4qmwFPadFFQRblPb4l2TjDlukyY
         SLFVwQNEB3Pa3jEW0513b02jW3e01gNLKB983bN2MB3PysqzR/T6wh/2iLy0bzYk+Zr2
         +1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C7efo7KFLZfyiRAwiiichjAUs9Xf/LzpX1GiiQFwOSM=;
        fh=/Jo4aHu1eiin7tqhr/KPxKF1WwSS8Rs4TinB3y26dkY=;
        b=lxHl/6d8McfG+NS0zleYYaKXAdgu+L8uWAmiGSGoqhKcBKWajPeGS0GJbbVlwLVTz3
         2RA+u+PNcse+3LujUVPwmDDXweYgs+5h1WdszRW1rElkygWm1NWL9G+nG1Tr2wGIqd2J
         /1kTuWXuSm1nUyWHF6rglvCKsbtZnSeMyjGSYMwA35OfaWhNKOAtYtfLm+qfSulZ23vw
         y5yosH6SrJpFN37LtaP/O7BLaE+1vQ8s1+g69LloXcvH7nkKrC1THI5A1aRdUNwMp79s
         BTd+y3y9aNl31tnSruyGSFWNA/z+Qp2QRQWGpIm50bZhlvxlUGsxVhCvJr6Sjt9elUA0
         hk2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786377519; x=1786982319; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C7efo7KFLZfyiRAwiiichjAUs9Xf/LzpX1GiiQFwOSM=;
        b=ShEf/GwdZHNGreOB3PfA9tP7cQn9+KNNiEFX8CFIHqKHCAdF0o0gOTRpGJxoNbJPs5
         iN3/Gl1yBmdO9ujqjXiyV1a6okGw7M5Mo7MYPrFz3vK86ksbgt3728ddtW++rflH4xPJ
         hYH93Cm3bV/FYHGECnIaqHGstCGWyTOlY7YbgiCJwnbgMAgIyh/IT/u+2iLOumhh+iTU
         7MUlgISDcczwF6djUtWleegmcuiz8aPxbdTsBYlg2mDffbIiTvTh+T67FUWFYhKP60FD
         OVSFAnGFI4s7EO5mtzXVwu8wetwkawf/3L6kLjkpnCuAdklVqOHRwgZDMojpm3eEZhT+
         MvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786377519; x=1786982319;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C7efo7KFLZfyiRAwiiichjAUs9Xf/LzpX1GiiQFwOSM=;
        b=q8P2AI+H42UYHG09x54Qat8477Hc7jr368uFVtArPtXQ7nJ+8zuHUQ2Jj1FDVsUC00
         +OEwpFhRj5mNVAGRmrB7BNUdrVmY9sec7zncZlCZfeSNTGdK+457tLUZ5ysDw/I+CqOB
         lFk3P2V+r1czg3+RGffe2dwNa2OZCfW5lxl90/bPjwPWXg8VUswJ21tKtIAwjzRO4A9v
         6ey3/sE3lf9rSmjvc+VYN7Ur0XMiEas/hjHAWujXLdFJeu5bpilWLlMnnxnTRrrfRILt
         IiUMHfjgxNe7wTHGEn4xJNj/wpasFmYYPUMxMb0te6qjoSqrW2Ihf1JskISyoHl6NsaN
         pEFw==
X-Forwarded-Encrypted: i=1; AHgh+RqSmJ8g4+V7KqC4axeD/VrPNxl+3731CwlDw47/3Mx7ww5yc7qYRmBpIR9eoTvN9ZT2mBqOZak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCzWi1+JzSL5uWKWdVd+TlWuvJ4tRQReUIfbixa6Qs670X38/
	fpMg1ZKjtifn50AWxepk6IEChNMXM5ayfDtCp8nJbhJFB9y8eueC66YKm+17bc3p4RLKECPFgAP
	XQ/XbxiGjh9eCcyeSS2VsFwImOKlIG1AqcObF9upWBw==
X-Gm-Gg: AR+sD12xovYm42FnsB8qUXC3ZV4NpxIPuYyAxgBqdErvnzRlsOhf1nGojlqjnebXFf2
	kFqG+bqd8DAK/iYg2e06N6ohyMzs8MEoY2VDdh1aliCRIAUJEdLWJc1cbxsoGVKKHZOGoutO2do
	D8QcNJx0MIjdoEe+fIK24/ucP09LKM/hFmg99AJRpaDtdi5hQejwWJTJUplrNHW85LMWRSGqdy8
	OPvbw7sCMN+mjxOCeUgYYxH9ww84YIdsluhgakaPVs3tdCAE8PgxXTklyl+u0tKZ8T9TIMVGM5L
	AZtlOObsjcdibfTalfwN8r75D8mkyarY/eYOLJwiHRpAU9rlbcFIy+3GUfSZkjc6giS6ZcrOSY6
	W5zQ=
X-Received: by 2002:a05:6122:32c7:b0:5bf:9bfa:53a0 with SMTP id
 71dfb90a1353d-5c4418e4a2fmr450231e0c.1.1786377519321; Mon, 10 Aug 2026
 08:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805102505.740806-1-david.lee@trailofbits.com> <CAM0EoMkMcpE4JZdroYvVuPRzUC8Xwbwv3p4+qkABj=Qk55kWvg@mail.gmail.com>
In-Reply-To: <CAM0EoMkMcpE4JZdroYvVuPRzUC8Xwbwv3p4+qkABj=Qk55kWvg@mail.gmail.com>
From: David Lee <david.lee@trailofbits.com>
Date: Tue, 11 Aug 2026 00:58:27 +0900
X-Gm-Features: AUfX_mwPZU9OmcCj9F5MpKZeyen6f7o3QXLS7637BJOMsRUZ3dSvIT60OyQal6A
Message-ID: <CAC_etQEByQLf5pMWzbyVfT3xtzereqEgu+XZYmwDjyvpRCzxjg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: defer qdisc freeing after failed creation
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007984980658b36d2a"

--0000000000007984980658b36d2a
Content-Type: multipart/alternative; boundary="0000000000007984970658b36d28"

--0000000000007984970658b36d28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jamal,

I have attached the reproducer and satnizer logs here:

---
[  230.057740] ipip: IPv4 and MPLS over IPv4 tunneling driver
[  231.667279]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  231.667738] BUG: KASAN: stack-out-of-bounds in
__ip_options_echo+0xdf7/0x1860
[  231.667738] Write of size 255 at addr ffffc9000029f008 by task
ksoftirqd/3/37
[  231.667738]
[  231.667738] CPU: 3 UID: 0 PID: 37 Comm: ksoftirqd/3 Not tainted
7.2.0-rc3-kasan #1 PREEMPT(lazy)
[  231.667738] Hardware name: QEMU Ubuntu 26.04 PC (i440FX + PIIX, 1996),
BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[  231.667738] Call Trace:
[  231.667738]  <TASK>
[  231.667738]  dump_stack_lvl+0x5f/0x90
[  231.667738]  print_report+0x15b/0x4ec
[  231.667738]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  231.667738]  ? kasan_addr_to_slab+0xd/0x80
[  231.667738]  kasan_report+0xf2/0x130
[  231.667738]  ? __ip_options_echo+0xdf7/0x1860
[  231.667738]  ? __ip_options_echo+0xdf7/0x1860
[  231.667738]  kasan_check_range+0x13a/0x230
[  231.667738]  __asan_memcpy+0x3b/0x80
[  231.667738]  __ip_options_echo+0xdf7/0x1860
[  231.667738]  ? __pfx___ip_options_echo+0x10/0x10
[  231.667738]  __icmp_send+0x8c5/0x26e0
[  231.667738]  ? __pfx___icmp_send+0x10/0x10
[  231.667738]  ? sysvec_apic_timer_interrupt+0x54/0xd0
[  231.667738]  ? __pfx_nf_reject_fill_skb_dst+0x10/0x10 [nf_reject_ipv4]
[  231.667738]  ? _raw_spin_lock+0x82/0xf0
[  231.667738]  ? irqentry_exit+0x1cd/0x7b0
[  231.667738]  nf_send_unreach+0x303/0x810 [nf_reject_ipv4]
[  231.667738]  ? __pfx_nf_send_unreach+0x10/0x10 [nf_reject_ipv4]
[  231.667738]  nft_reject_inet_eval+0x4cd/0x8a0 [nft_reject_inet]
[  231.667738]  ? nft_do_chain+0x45a/0x1ae0 [nf_tables]
[  231.667738]  nft_do_chain+0x25a/0x1ae0 [nf_tables]
[  231.667738]  ? __pfx_tcp_v4_rcv+0x10/0x10
[  231.667738]  ? raw_local_deliver+0x3b9/0xc80
[  231.667738]  ? __pfx_nft_do_chain+0x10/0x10 [nf_tables]
[  231.667738]  ? update_stack_state+0x26e/0x6a0
[  231.667738]  ? fib_validate_source+0x455/0x770
[  231.667738]  ? update_stack_state+0x26e/0x6a0
[  231.667738]  nft_do_chain_inet_ingress+0x44f/0x1420 [nf_tables]
[  231.667738]  ? __pfx_nft_do_chain_inet_ingress+0x10/0x10 [nf_tables]
[  231.667738]  ? unwind_next_frame+0x18a/0xac0
[  231.667738]  nf_hook_slow+0xaa/0x1f0
[  231.667738]  __netif_receive_skb_core.constprop.0+0x19b6/0x31e0
[  231.667738]  ? __pfx_read_hpet+0x10/0x10
[  231.667738]  ? ret_from_fork_asm+0x1a/0x30
[  231.667738]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  231.667738]  ? clockevents_program_event+0x2bd/0x750
[  231.667738]  ? run_ksoftirqd+0x3a/0x60
[  231.667738]  ? kasan_save_stack+0x4e/0x70
[  231.667738]  ? __kasan_check_write+0x14/0x30
[  231.667738]  ? _raw_spin_lock+0x82/0xf0
[  231.667738]  ? __hrtimer_rearm_deferred+0x18a/0x520
[  231.667738]  __netif_receive_skb_list_core+0x314/0xb10
[  231.667738]  ? sysvec_apic_timer_interrupt+0x54/0xd0
[  231.667738]  ? __pfx___netif_receive_skb_list_core+0x10/0x10
[  231.667738]  ? kasan_save_track+0x27/0x70
[  231.667738]  netif_receive_skb_list_internal+0x5eb/0xde0
[  231.667738]  ? __kasan_check_write+0x14/0x30
[  231.667738]  ? __pfx_netif_receive_skb_list_internal+0x10/0x10
[  231.667738]  ? __pfx_napi_complete_done+0x10/0x10
[  231.667738]  ? __pfx_dql_completed+0x10/0x10
[  231.667738]  ? __kasan_check_read+0x11/0x20
[  231.667738]  ? dev_gro_receive+0x20d/0x3060
[  231.667738]  napi_complete_done+0x1b6/0x830
[  231.667738]  ? pick_eevdf+0x19b/0x7e0
[  231.667738]  ? __pfx_napi_complete_done+0x10/0x10
[  231.667738]  ? gro_receive_skb+0x292/0xa90
[  231.667738]  gro_cell_poll+0x120/0x1f0
[  231.667738]  __napi_poll+0xa3/0x4c0
[  231.667738]  net_rx_action+0x4c1/0xfb0
[  231.667738]  ? __pfx_net_rx_action+0x10/0x10
[  231.667738]  ? finish_task_switch.isra.0+0x1f1/0xc10
[  231.667738]  ? __switch_to+0x8d7/0xd40
[  231.667738]  handle_softirqs+0x1ae/0x670
[  231.667738]  ? __pfx_handle_softirqs+0x10/0x10
[  231.667738]  run_ksoftirqd+0x3a/0x60
[  231.667738]  smpboot_thread_fn+0x29d/0x6e0
[  231.667738]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  231.667738]  kthread+0x333/0x420
[  231.667738]  ? calculate_sigpending+0x78/0xb0
[  231.667738]  ? __pfx_kthread+0x10/0x10
[  231.667738]  ret_from_fork+0x426/0x7c0
[  231.667738]  ? __pfx_ret_from_fork+0x10/0x10
[  231.667738]  ? native_load_gs_index+0x3f/0x60
[  231.667738]  ? __switch_to+0x8d7/0xd40
[  231.667738]  ? __switch_to_asm+0x39/0x70
[  231.667738]  ? __pfx_kthread+0x10/0x10
[  231.667738]  ret_from_fork_asm+0x1a/0x30
[  231.667738]  </TASK>
[  231.667738]
[  231.667738] The buggy address belongs to stack of task ksoftirqd/3/37
[  231.667738]  and is located at offset 376 in frame:
[  231.667738]  __icmp_send+0x0/0x26e0
[  231.667738]
[  231.667738] This frame has 7 objects:
[  231.667738]  [32, 33) 'apply_ratelimit'
[  231.667738]  [48, 49) '_inner_type'
[  231.667738]  [64, 68) 'data'
[  231.667738]  [80, 88) 'rt'
[  231.667738]  [112, 168) 'ipc'
[  231.667738]  [208, 264) 'fl4'
[  231.667738]  [304, 416) 'icmp_param_u'
[  231.667738]
[  231.667738] The buggy address belongs to a vmalloc virtual mapping
[  231.667738] The buggy address belongs to the physical page:
[  231.667738] page: refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x100c1f
[  231.667738] flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x1ff=
fff)
[  231.667738] raw: 0017ffffc0000000 ffffea00040307c8 ffffea00040307c8
0000000000000000
[  231.667738] raw: 0000000000000000 0000000000000000 00000001ffffffff
0000000000000000
[  231.667738] page dumped because: kasan: bad access detected
[  231.667738]
[  231.667738] Memory state around the buggy address:
[  231.667738]  ffffc9000029ef00: 00 00 00 00 00 00 00 f2 f2 f2 f2 f2 00 00
00 00
[  231.667738]  ffffc9000029ef80: 00 00 00 f2 f2 f2 f2 f2 00 00 00 00 00 00
00 00
[  231.667738] >ffffc9000029f000: 00 00 00 00 00 00 f3 f3 f3 f3 00 00 00 00
00 00
[  231.667738]                                      ^
[  231.667738]  ffffc9000029f080: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
00 f3
[  231.667738]  ffffc9000029f100: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
00 00
[  231.667738]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  231.746888] Disabling lock debugging due to kernel taint
---
=3D=3D=3D=3D=3D=3D=3D=3D Affected Versions =3D=3D=3D=3D=3D=3D=3D
Confirmed Version:
* 6f5156d7a31a8c3b0f34af4675c9299c8f877cbe (post-v7.2-rc3)
Required Configs for the Vulnerability:
* CONFIG_INET
* CONFIG_NETFILTER
* CONFIG_NETFILTER_INGRESS
* CONFIG_NF_TABLES
* CONFIG_NF_TABLES_INET
* CONFIG_NFT_REJECT
* CONFIG_NFT_REJECT_INET
* CONFIG_NF_REJECT_IPV4

Additional Configs for the Proof of Concept:
* CONFIG_NET_IPIP
* CONFIG_VETH
* CONFIG_PACKET
* CONFIG_USER_NS
* CONFIG_NET_NS

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Step 1: Build kernel commit
`6f5156d7a31a8c3b0f34af4675c9299c8f877cbe` with KASAN and the
configuration options listed above.

Step 2: Build the attached `poc.c`:

~
gcc -static -O2 -Wall -Wextra -o poc poc.c
~

Step 3: Ensure the `nft_reject_inet`, `nf_reject_ipv4`, `ipip`, and
`veth` modules are available or built into the kernel. Run `./poc` as
an ordinary local user on a system that permits unprivileged user
namespaces. The `ip` utility must be installed.

The program creates its own user and network namespace, configures a
veth pair and IPIP device, installs an inet-ingress ICMPX reject rule,
and transmits the triggering packet. KASAN reports the
stack-out-of-bounds write.

Best regards,
David


On Wed, Aug 5, 2026 at 2:01=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:

> On Wed, Aug 5, 2026 at 6:25=E2=80=AFAM David Lee <david.lee@trailofbits.c=
om>
> wrote:
> >
> > From: Kyle Zeng <kylebot@openai.com>
> >
> > A qdisc's init callback can publish state to RCU readers before
> > qdisc_create() completes. In particular, clsact_init() binds a populate=
d
> > shared ingress block and installs an embedded mini_Qdisc in
> > dev->tcx_ingress. If subsequent rate estimator setup fails, the unwind
> > removes that pointer but qdisc_free() immediately releases the qdisc an=
d
> > its per-CPU statistics. A reader that obtained the miniq before removal
> > can then access freed memory.
> >
> > Add qdisc_free_rcu() and use it for the creation error path, matching
> > normal qdisc destruction. This keeps the embedded miniq and the per-CPU
> > statistics alive until pre-existing readers complete.
> >
> > Fixes: 51ab2994c387 ("net: sched: allow ingress and clsact qdiscs to
> share filter blocks")
> > Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Signed-off-by: David Lee <david.lee@trailofbits.com>
>
> Thanks for finding the issue. But you should know the deal by now,
> send the poc - you can send it in private. Same goes for your other
> patch.
>
> cheers,
> jamal
>
> > ---
> > Bug found and triaged by OpenAI Security Research and
> > validated by Trail of Bits.
> >
> > Trail of Bits has a reproducer for this bug that triggers a
> > KASAN use-after-free and can share if needed.
> >
> >  include/net/sch_generic.h | 1 +
> >  net/sched/sch_api.c       | 2 +-
> >  net/sched/sch_generic.c   | 7 ++++++-
> >  3 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 45a1e8c782..d45442c926 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -793,6 +793,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue
> *dev_queue,
> >                           const struct Qdisc_ops *ops,
> >                           struct netlink_ext_ack *extack);
> >  void qdisc_free(struct Qdisc *qdisc);
> > +void qdisc_free_rcu(struct Qdisc *qdisc);
> >  struct Qdisc *qdisc_create_dflt(struct netdev_queue *dev_queue,
> >                                 const struct Qdisc_ops *ops, u32
> parentid,
> >                                 struct netlink_ext_ack *extack);
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index 668bcd60d1..041bd60072 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1373,7 +1373,7 @@ static struct Qdisc *qdisc_create(struct
> net_device *dev,
> >  err_out3:
> >         qdisc_lock_uninit(sch, ops);
> >         netdev_put(dev, &sch->dev_tracker);
> > -       qdisc_free(sch);
> > +       qdisc_free_rcu(sch);
> >  err_out2:
> >         bpf_module_put(ops, ops->owner);
> >  err_out:
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index ef2b4bf515..86d551fbab 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -1103,6 +1103,11 @@ static void qdisc_free_cb(struct rcu_head *head)
> >         qdisc_free(q);
> >  }
> >
> > +void qdisc_free_rcu(struct Qdisc *qdisc)
> > +{
> > +       call_rcu(&qdisc->rcu, qdisc_free_cb);
> > +}
> > +
> >  static void __qdisc_destroy(struct Qdisc *qdisc)
> >  {
> >         const struct Qdisc_ops  *ops =3D qdisc->ops;
> > @@ -1127,7 +1132,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
> >
> >         trace_qdisc_destroy(qdisc);
> >
> > -       call_rcu(&qdisc->rcu, qdisc_free_cb);
> > +       qdisc_free_rcu(qdisc);
> >  }
> >
> >  void qdisc_destroy(struct Qdisc *qdisc)
> > --
> > 2.53.0
>

--0000000000007984970658b36d28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jamal,<br><br>I have attached the reproducer and satniz=
er logs here:<br><br>---<br>[ =C2=A0230.057740] ipip: IPv4 and MPLS over IP=
v4 tunneling driver<br>[ =C2=A0231.667279] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>[ =C2=A0231.667738] BUG: KASAN: stack-out-of-bounds i=
n __ip_options_echo+0xdf7/0x1860<br>[ =C2=A0231.667738] Write of size 255 a=
t addr ffffc9000029f008 by task ksoftirqd/3/37<br>[ =C2=A0231.667738] <br>[=
 =C2=A0231.667738] CPU: 3 UID: 0 PID: 37 Comm: ksoftirqd/3 Not tainted 7.2.=
0-rc3-kasan #1 PREEMPT(lazy) <br>[ =C2=A0231.667738] Hardware name: QEMU Ub=
untu 26.04 PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/=
01/2014<br>[ =C2=A0231.667738] Call Trace:<br>[ =C2=A0231.667738] =C2=A0&lt=
;TASK&gt;<br>[ =C2=A0231.667738] =C2=A0dump_stack_lvl+0x5f/0x90<br>[ =C2=A0=
231.667738] =C2=A0print_report+0x15b/0x4ec<br>[ =C2=A0231.667738] =C2=A0? _=
_pfx__raw_spin_lock_irqsave+0x10/0x10<br>[ =C2=A0231.667738] =C2=A0? kasan_=
addr_to_slab+0xd/0x80<br>[ =C2=A0231.667738] =C2=A0kasan_report+0xf2/0x130<=
br>[ =C2=A0231.667738] =C2=A0? __ip_options_echo+0xdf7/0x1860<br>[ =C2=A023=
1.667738] =C2=A0? __ip_options_echo+0xdf7/0x1860<br>[ =C2=A0231.667738] =C2=
=A0kasan_check_range+0x13a/0x230<br>[ =C2=A0231.667738] =C2=A0__asan_memcpy=
+0x3b/0x80<br>[ =C2=A0231.667738] =C2=A0__ip_options_echo+0xdf7/0x1860<br>[=
 =C2=A0231.667738] =C2=A0? __pfx___ip_options_echo+0x10/0x10<br>[ =C2=A0231=
.667738] =C2=A0__icmp_send+0x8c5/0x26e0<br>[ =C2=A0231.667738] =C2=A0? __pf=
x___icmp_send+0x10/0x10<br>[ =C2=A0231.667738] =C2=A0? sysvec_apic_timer_in=
terrupt+0x54/0xd0<br>[ =C2=A0231.667738] =C2=A0? __pfx_nf_reject_fill_skb_d=
st+0x10/0x10 [nf_reject_ipv4]<br>[ =C2=A0231.667738] =C2=A0? _raw_spin_lock=
+0x82/0xf0<br>[ =C2=A0231.667738] =C2=A0? irqentry_exit+0x1cd/0x7b0<br>[ =
=C2=A0231.667738] =C2=A0nf_send_unreach+0x303/0x810 [nf_reject_ipv4]<br>[ =
=C2=A0231.667738] =C2=A0? __pfx_nf_send_unreach+0x10/0x10 [nf_reject_ipv4]<=
br>[ =C2=A0231.667738] =C2=A0nft_reject_inet_eval+0x4cd/0x8a0 [nft_reject_i=
net]<br>[ =C2=A0231.667738] =C2=A0? nft_do_chain+0x45a/0x1ae0 [nf_tables]<b=
r>[ =C2=A0231.667738] =C2=A0nft_do_chain+0x25a/0x1ae0 [nf_tables]<br>[ =C2=
=A0231.667738] =C2=A0? __pfx_tcp_v4_rcv+0x10/0x10<br>[ =C2=A0231.667738] =
=C2=A0? raw_local_deliver+0x3b9/0xc80<br>[ =C2=A0231.667738] =C2=A0? __pfx_=
nft_do_chain+0x10/0x10 [nf_tables]<br>[ =C2=A0231.667738] =C2=A0? update_st=
ack_state+0x26e/0x6a0<br>[ =C2=A0231.667738] =C2=A0? fib_validate_source+0x=
455/0x770<br>[ =C2=A0231.667738] =C2=A0? update_stack_state+0x26e/0x6a0<br>=
[ =C2=A0231.667738] =C2=A0nft_do_chain_inet_ingress+0x44f/0x1420 [nf_tables=
]<br>[ =C2=A0231.667738] =C2=A0? __pfx_nft_do_chain_inet_ingress+0x10/0x10 =
[nf_tables]<br>[ =C2=A0231.667738] =C2=A0? unwind_next_frame+0x18a/0xac0<br=
>[ =C2=A0231.667738] =C2=A0nf_hook_slow+0xaa/0x1f0<br>[ =C2=A0231.667738] =
=C2=A0__netif_receive_skb_core.constprop.0+0x19b6/0x31e0<br>[ =C2=A0231.667=
738] =C2=A0? __pfx_read_hpet+0x10/0x10<br>[ =C2=A0231.667738] =C2=A0? ret_f=
rom_fork_asm+0x1a/0x30<br>[ =C2=A0231.667738] =C2=A0? __pfx___netif_receive=
_skb_core.constprop.0+0x10/0x10<br>[ =C2=A0231.667738] =C2=A0? clockevents_=
program_event+0x2bd/0x750<br>[ =C2=A0231.667738] =C2=A0? run_ksoftirqd+0x3a=
/0x60<br>[ =C2=A0231.667738] =C2=A0? kasan_save_stack+0x4e/0x70<br>[ =C2=A0=
231.667738] =C2=A0? __kasan_check_write+0x14/0x30<br>[ =C2=A0231.667738] =
=C2=A0? _raw_spin_lock+0x82/0xf0<br>[ =C2=A0231.667738] =C2=A0? __hrtimer_r=
earm_deferred+0x18a/0x520<br>[ =C2=A0231.667738] =C2=A0__netif_receive_skb_=
list_core+0x314/0xb10<br>[ =C2=A0231.667738] =C2=A0? sysvec_apic_timer_inte=
rrupt+0x54/0xd0<br>[ =C2=A0231.667738] =C2=A0? __pfx___netif_receive_skb_li=
st_core+0x10/0x10<br>[ =C2=A0231.667738] =C2=A0? kasan_save_track+0x27/0x70=
<br>[ =C2=A0231.667738] =C2=A0netif_receive_skb_list_internal+0x5eb/0xde0<b=
r>[ =C2=A0231.667738] =C2=A0? __kasan_check_write+0x14/0x30<br>[ =C2=A0231.=
667738] =C2=A0? __pfx_netif_receive_skb_list_internal+0x10/0x10<br>[ =C2=A0=
231.667738] =C2=A0? __pfx_napi_complete_done+0x10/0x10<br>[ =C2=A0231.66773=
8] =C2=A0? __pfx_dql_completed+0x10/0x10<br>[ =C2=A0231.667738] =C2=A0? __k=
asan_check_read+0x11/0x20<br>[ =C2=A0231.667738] =C2=A0? dev_gro_receive+0x=
20d/0x3060<br>[ =C2=A0231.667738] =C2=A0napi_complete_done+0x1b6/0x830<br>[=
 =C2=A0231.667738] =C2=A0? pick_eevdf+0x19b/0x7e0<br>[ =C2=A0231.667738] =
=C2=A0? __pfx_napi_complete_done+0x10/0x10<br>[ =C2=A0231.667738] =C2=A0? g=
ro_receive_skb+0x292/0xa90<br>[ =C2=A0231.667738] =C2=A0gro_cell_poll+0x120=
/0x1f0<br>[ =C2=A0231.667738] =C2=A0__napi_poll+0xa3/0x4c0<br>[ =C2=A0231.6=
67738] =C2=A0net_rx_action+0x4c1/0xfb0<br>[ =C2=A0231.667738] =C2=A0? __pfx=
_net_rx_action+0x10/0x10<br>[ =C2=A0231.667738] =C2=A0? finish_task_switch.=
isra.0+0x1f1/0xc10<br>[ =C2=A0231.667738] =C2=A0? __switch_to+0x8d7/0xd40<b=
r>[ =C2=A0231.667738] =C2=A0handle_softirqs+0x1ae/0x670<br>[ =C2=A0231.6677=
38] =C2=A0? __pfx_handle_softirqs+0x10/0x10<br>[ =C2=A0231.667738] =C2=A0ru=
n_ksoftirqd+0x3a/0x60<br>[ =C2=A0231.667738] =C2=A0smpboot_thread_fn+0x29d/=
0x6e0<br>[ =C2=A0231.667738] =C2=A0? __pfx_smpboot_thread_fn+0x10/0x10<br>[=
 =C2=A0231.667738] =C2=A0kthread+0x333/0x420<br>[ =C2=A0231.667738] =C2=A0?=
 calculate_sigpending+0x78/0xb0<br>[ =C2=A0231.667738] =C2=A0? __pfx_kthrea=
d+0x10/0x10<br>[ =C2=A0231.667738] =C2=A0ret_from_fork+0x426/0x7c0<br>[ =C2=
=A0231.667738] =C2=A0? __pfx_ret_from_fork+0x10/0x10<br>[ =C2=A0231.667738]=
 =C2=A0? native_load_gs_index+0x3f/0x60<br>[ =C2=A0231.667738] =C2=A0? __sw=
itch_to+0x8d7/0xd40<br>[ =C2=A0231.667738] =C2=A0? __switch_to_asm+0x39/0x7=
0<br>[ =C2=A0231.667738] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0231.667=
738] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0231.667738] =C2=A0&lt;/TA=
SK&gt;<br>[ =C2=A0231.667738] <br>[ =C2=A0231.667738] The buggy address bel=
ongs to stack of task ksoftirqd/3/37<br>[ =C2=A0231.667738] =C2=A0and is lo=
cated at offset 376 in frame:<br>[ =C2=A0231.667738] =C2=A0__icmp_send+0x0/=
0x26e0<br>[ =C2=A0231.667738] <br>[ =C2=A0231.667738] This frame has 7 obje=
cts:<br>[ =C2=A0231.667738] =C2=A0[32, 33) &#39;apply_ratelimit&#39;<br>[ =
=C2=A0231.667738] =C2=A0[48, 49) &#39;_inner_type&#39;<br>[ =C2=A0231.66773=
8] =C2=A0[64, 68) &#39;data&#39;<br>[ =C2=A0231.667738] =C2=A0[80, 88) &#39=
;rt&#39;<br>[ =C2=A0231.667738] =C2=A0[112, 168) &#39;ipc&#39;<br>[ =C2=A02=
31.667738] =C2=A0[208, 264) &#39;fl4&#39;<br>[ =C2=A0231.667738] =C2=A0[304=
, 416) &#39;icmp_param_u&#39;<br>[ =C2=A0231.667738] <br>[ =C2=A0231.667738=
] The buggy address belongs to a vmalloc virtual mapping<br>[ =C2=A0231.667=
738] The buggy address belongs to the physical page:<br>[ =C2=A0231.667738]=
 page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x100c1=
f<br>[ =C2=A0231.667738] flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpup=
id=3D0x1fffff)<br>[ =C2=A0231.667738] raw: 0017ffffc0000000 ffffea00040307c=
8 ffffea00040307c8 0000000000000000<br>[ =C2=A0231.667738] raw: 00000000000=
00000 0000000000000000 00000001ffffffff 0000000000000000<br>[ =C2=A0231.667=
738] page dumped because: kasan: bad access detected<br>[ =C2=A0231.667738]=
 <br>[ =C2=A0231.667738] Memory state around the buggy address:<br>[ =C2=A0=
231.667738] =C2=A0ffffc9000029ef00: 00 00 00 00 00 00 00 f2 f2 f2 f2 f2 00 =
00 00 00<br>[ =C2=A0231.667738] =C2=A0ffffc9000029ef80: 00 00 00 f2 f2 f2 f=
2 f2 00 00 00 00 00 00 00 00<br>[ =C2=A0231.667738] &gt;ffffc9000029f000: 0=
0 00 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00<br>[ =C2=A0231.667738] =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>[ =C2=A0231.667=
738] =C2=A0ffffc9000029f080: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f=
3<br>[ =C2=A0231.667738] =C2=A0ffffc9000029f100: f3 f3 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00<br>[ =C2=A0231.667738] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>[ =C2=A0231.746888] Disabling lock debugging due to k=
ernel taint<br>---<br>=3D=3D=3D=3D=3D=3D=3D=3D Affected Versions =3D=3D=3D=
=3D=3D=3D=3D<br>Confirmed Version:<br>* 6f5156d7a31a8c3b0f34af4675c9299c8f8=
77cbe (post-v7.2-rc3)<br>Required Configs for the Vulnerability:<br>* CONFI=
G_INET<br>* CONFIG_NETFILTER<br>* CONFIG_NETFILTER_INGRESS<br>* CONFIG_NF_T=
ABLES<br>* CONFIG_NF_TABLES_INET<br>* CONFIG_NFT_REJECT<br>* CONFIG_NFT_REJ=
ECT_INET<br>* CONFIG_NF_REJECT_IPV4<br><br>Additional Configs for the Proof=
 of Concept:<br>* CONFIG_NET_IPIP<br>* CONFIG_VETH<br>* CONFIG_PACKET<br>* =
CONFIG_USER_NS<br>* CONFIG_NET_NS<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Rep=
roduction =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Step 1: Build kernel commit<br>=
`6f5156d7a31a8c3b0f34af4675c9299c8f877cbe` with KASAN and the<br>configurat=
ion options listed above.<br><br>Step 2: Build the attached `poc.c`:<br><br=
>~<br>gcc -static -O2 -Wall -Wextra -o poc poc.c<br>~<br><br>Step 3: Ensure=
 the `nft_reject_inet`, `nf_reject_ipv4`, `ipip`, and<br>`veth` modules are=
 available or built into the kernel. Run `./poc` as<br>an ordinary local us=
er on a system that permits unprivileged user<br>namespaces. The `ip` utili=
ty must be installed.<br><br>The program creates its own user and network n=
amespace, configures a<br>veth pair and IPIP device, installs an inet-ingre=
ss ICMPX reject rule,<br>and transmits the triggering packet. KASAN reports=
 the<br>stack-out-of-bounds write.<br><br>Best regards,<br>David<br><br></d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Wed, Aug 5, 2026 at 2:01=E2=80=AFPM Jamal Hadi Salim =
&lt;<a href=3D"mailto:jhs@mojatatu.com">jhs@mojatatu.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Aug 5, 2026=
 at 6:25=E2=80=AFAM David Lee &lt;<a href=3D"mailto:david.lee@trailofbits.c=
om" target=3D"_blank">david.lee@trailofbits.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Kyle Zeng &lt;<a href=3D"mailto:kylebot@openai.com" target=3D"_b=
lank">kylebot@openai.com</a>&gt;<br>
&gt;<br>
&gt; A qdisc&#39;s init callback can publish state to RCU readers before<br=
>
&gt; qdisc_create() completes. In particular, clsact_init() binds a populat=
ed<br>
&gt; shared ingress block and installs an embedded mini_Qdisc in<br>
&gt; dev-&gt;tcx_ingress. If subsequent rate estimator setup fails, the unw=
ind<br>
&gt; removes that pointer but qdisc_free() immediately releases the qdisc a=
nd<br>
&gt; its per-CPU statistics. A reader that obtained the miniq before remova=
l<br>
&gt; can then access freed memory.<br>
&gt;<br>
&gt; Add qdisc_free_rcu() and use it for the creation error path, matching<=
br>
&gt; normal qdisc destruction. This keeps the embedded miniq and the per-CP=
U<br>
&gt; statistics alive until pre-existing readers complete.<br>
&gt;<br>
&gt; Fixes: 51ab2994c387 (&quot;net: sched: allow ingress and clsact qdiscs=
 to share filter blocks&quot;)<br>
&gt; Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber<br>
&gt; Signed-off-by: Kyle Zeng &lt;<a href=3D"mailto:kylebot@openai.com" tar=
get=3D"_blank">kylebot@openai.com</a>&gt;<br>
&gt; Signed-off-by: David Lee &lt;<a href=3D"mailto:david.lee@trailofbits.c=
om" target=3D"_blank">david.lee@trailofbits.com</a>&gt;<br>
<br>
Thanks for finding the issue. But you should know the deal by now,<br>
send the poc - you can send it in private. Same goes for your other<br>
patch.<br>
<br>
cheers,<br>
jamal<br>
<br>
&gt; ---<br>
&gt; Bug found and triaged by OpenAI Security Research and<br>
&gt; validated by Trail of Bits.<br>
&gt;<br>
&gt; Trail of Bits has a reproducer for this bug that triggers a<br>
&gt; KASAN use-after-free and can share if needed.<br>
&gt;<br>
&gt;=C2=A0 include/net/sch_generic.h | 1 +<br>
&gt;=C2=A0 net/sched/sch_api.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
&gt;=C2=A0 net/sched/sch_generic.c=C2=A0 =C2=A0| 7 ++++++-<br>
&gt;=C2=A0 3 files changed, 8 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h<br>
&gt; index 45a1e8c782..d45442c926 100644<br>
&gt; --- a/include/net/sch_generic.h<br>
&gt; +++ b/include/net/sch_generic.h<br>
&gt; @@ -793,6 +793,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev=
_queue,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct Qdisc_ops *ops,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct netlink_ext_ack *extack);<br>
&gt;=C2=A0 void qdisc_free(struct Qdisc *qdisc);<br>
&gt; +void qdisc_free_rcu(struct Qdisc *qdisc);<br>
&gt;=C2=A0 struct Qdisc *qdisc_create_dflt(struct netdev_queue *dev_queue,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct Qdisc_ops *ops=
, u32 parentid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct netlink_ext_ack *ext=
ack);<br>
&gt; diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c<br>
&gt; index 668bcd60d1..041bd60072 100644<br>
&gt; --- a/net/sched/sch_api.c<br>
&gt; +++ b/net/sched/sch_api.c<br>
&gt; @@ -1373,7 +1373,7 @@ static struct Qdisc *qdisc_create(struct net_dev=
ice *dev,<br>
&gt;=C2=A0 err_out3:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdisc_lock_uninit(sch, ops);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netdev_put(dev, &amp;sch-&gt;dev_trac=
ker);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0qdisc_free(sch);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0qdisc_free_rcu(sch);<br>
&gt;=C2=A0 err_out2:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bpf_module_put(ops, ops-&gt;owner);<b=
r>
&gt;=C2=A0 err_out:<br>
&gt; diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c<br>
&gt; index ef2b4bf515..86d551fbab 100644<br>
&gt; --- a/net/sched/sch_generic.c<br>
&gt; +++ b/net/sched/sch_generic.c<br>
&gt; @@ -1103,6 +1103,11 @@ static void qdisc_free_cb(struct rcu_head *head=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdisc_free(q);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +void qdisc_free_rcu(struct Qdisc *qdisc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0call_rcu(&amp;qdisc-&gt;rcu, qdisc_free_cb=
);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void __qdisc_destroy(struct Qdisc *qdisc)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct Qdisc_ops=C2=A0 *ops =3D=
 qdisc-&gt;ops;<br>
&gt; @@ -1127,7 +1132,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_qdisc_destroy(qdisc);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0call_rcu(&amp;qdisc-&gt;rcu, qdisc_free_cb=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0qdisc_free_rcu(qdisc);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 void qdisc_destroy(struct Qdisc *qdisc)<br>
&gt; --<br>
&gt; 2.53.0<br>
</blockquote></div>

--0000000000007984970658b36d28--
--0000000000007984980658b36d2a
Content-Type: application/octet-stream; name="poc.c"
Content-Disposition: attachment; filename="poc.c"
Content-Transfer-Encoding: base64
Content-ID: <f_msnf08go0>
X-Attachment-Id: f_msnf08go0

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGFycGEvaW5ldC5oPgojaW5jbHVkZSA8ZXJy
bm8uaD4KI2luY2x1ZGUgPGxpbnV4L2dlbl9zdGF0cy5oPgojaW5jbHVkZSA8bGludXgvbmV0bGlu
ay5oPgojaW5jbHVkZSA8bGludXgvcGt0X3NjaGVkLmg+CiNpbmNsdWRlIDxsaW51eC9ydG5ldGxp
bmsuaD4KI2luY2x1ZGUgPG5ldC9pZi5oPgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8
c2NoZWQuaD4KI2luY2x1ZGUgPHN0ZGFyZy5oPgojaW5jbHVkZSA8c3RkYXRvbWljLmg+CiNpbmNs
dWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNp
bmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL2lvY3Rs
Lmg+CiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1
ZGUgPHVuaXN0ZC5oPgoKI2RlZmluZSBRRElTQ19IQU5ETEUgMHgxMDAwMFUKI2RlZmluZSBDTEFT
U19IQU5ETEUgMHgxMDAwMVUKI2RlZmluZSBUQVJHRVRfTE1BWCAxNTAwVQojZGVmaW5lIFVEUF9Q
QVlMT0FEX0xFTiAxNDU4CiNkZWZpbmUgSVRFUkFUSU9OUyA1MDAwMFUKI2RlZmluZSBNQVhfREVM
QVkgNDA5NlUKCnN0cnVjdCBubF9yZXEgewoJY2hhciBidWZbNDA5Nl07CglzdHJ1Y3Qgbmxtc2do
ZHIgKm5saDsKfTsKCnN0cnVjdCByYWNlX2N0eCB7CglhdG9taWNfdWludCBnbzsKCWF0b21pY191
aW50IGRvbmU7CglpbnQgc2VuZGVyOwoJaW50IHJlY2VpdmVyOwoJY2hhciBwYWNrZXRbVURQX1BB
WUxPQURfTEVOXTsKfTsKCnN0YXRpYyB1aW50MzJfdCBubF9zZXE7CgpzdGF0aWMgdm9pZCBkaWUo
Y29uc3QgY2hhciAqZm10LCAuLi4pCnsKCXZhX2xpc3QgYXA7CgoJdmFfc3RhcnQoYXAsIGZtdCk7
Cgl2ZnByaW50ZihzdGRlcnIsIGZtdCwgYXApOwoJdmFfZW5kKGFwKTsKCWZwcmludGYoc3RkZXJy
LCAiOiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKCWV4aXQoMSk7Cn0KCnN0YXRpYyB2b2lkIGV4
cGVjdF9vayhpbnQgcmV0LCBjb25zdCBjaGFyICp3aGF0KQp7CglpZiAocmV0IDwgMCkgewoJCWVy
cm5vID0gLXJldDsKCQlkaWUoIiVzIiwgd2hhdCk7Cgl9Cn0KCnN0YXRpYyB2b2lkIGluaXRfcmVx
KHN0cnVjdCBubF9yZXEgKnJlcSwgdWludDE2X3QgdHlwZSwgdWludDE2X3QgZmxhZ3MsCgkJICAg
ICBzaXplX3QgcGF5bG9hZF9sZW4pCnsKCW1lbXNldChyZXEsIDAsIHNpemVvZigqcmVxKSk7Cgly
ZXEtPm5saCA9IChzdHJ1Y3Qgbmxtc2doZHIgKilyZXEtPmJ1ZjsKCXJlcS0+bmxoLT5ubG1zZ19s
ZW4gPSBOTE1TR19MRU5HVEgocGF5bG9hZF9sZW4pOwoJcmVxLT5ubGgtPm5sbXNnX3R5cGUgPSB0
eXBlOwoJcmVxLT5ubGgtPm5sbXNnX2ZsYWdzID0gZmxhZ3M7Cn0KCnN0YXRpYyB2b2lkIGFkZGF0
dHIoc3RydWN0IG5sX3JlcSAqcmVxLCB1aW50MTZfdCB0eXBlLCBjb25zdCB2b2lkICpkYXRhLAoJ
CSAgICBzaXplX3QgbGVuKQp7CglzaXplX3Qgb2Zmc2V0ID0gTkxNU0dfQUxJR04ocmVxLT5ubGgt
Pm5sbXNnX2xlbik7CglzaXplX3QgYXR0cl9sZW4gPSBSVEFfTEVOR1RIKGxlbik7CglzdHJ1Y3Qg
cnRhdHRyICpydGE7CgoJaWYgKG9mZnNldCArIFJUQV9BTElHTihhdHRyX2xlbikgPiBzaXplb2Yo
cmVxLT5idWYpKSB7CgkJZXJybm8gPSBFMkJJRzsKCQlkaWUoIm5ldGxpbmsgYXR0cmlidXRlIG92
ZXJmbG93Iik7Cgl9CgoJcnRhID0gKHN0cnVjdCBydGF0dHIgKikocmVxLT5idWYgKyBvZmZzZXQp
OwoJcnRhLT5ydGFfdHlwZSA9IHR5cGU7CglydGEtPnJ0YV9sZW4gPSBhdHRyX2xlbjsKCW1lbWNw
eShSVEFfREFUQShydGEpLCBkYXRhLCBsZW4pOwoJcmVxLT5ubGgtPm5sbXNnX2xlbiA9IG9mZnNl
dCArIFJUQV9BTElHTihhdHRyX2xlbik7Cn0KCnN0YXRpYyBzdHJ1Y3QgcnRhdHRyICpuZXN0X3N0
YXJ0KHN0cnVjdCBubF9yZXEgKnJlcSwgdWludDE2X3QgdHlwZSkKewoJc2l6ZV90IG9mZnNldCA9
IE5MTVNHX0FMSUdOKHJlcS0+bmxoLT5ubG1zZ19sZW4pOwoJc3RydWN0IHJ0YXR0ciAqcnRhOwoK
CWlmIChvZmZzZXQgKyBSVEFfQUxJR04oUlRBX0xFTkdUSCgwKSkgPiBzaXplb2YocmVxLT5idWYp
KSB7CgkJZXJybm8gPSBFMkJJRzsKCQlkaWUoIm5ldGxpbmsgbmVzdCBvdmVyZmxvdyIpOwoJfQoK
CXJ0YSA9IChzdHJ1Y3QgcnRhdHRyICopKHJlcS0+YnVmICsgb2Zmc2V0KTsKCXJ0YS0+cnRhX3R5
cGUgPSB0eXBlOwoJcnRhLT5ydGFfbGVuID0gUlRBX0xFTkdUSCgwKTsKCXJlcS0+bmxoLT5ubG1z
Z19sZW4gPSBvZmZzZXQgKyBSVEFfQUxJR04ocnRhLT5ydGFfbGVuKTsKCXJldHVybiBydGE7Cn0K
CnN0YXRpYyB2b2lkIG5lc3RfZW5kKHN0cnVjdCBubF9yZXEgKnJlcSwgc3RydWN0IHJ0YXR0ciAq
cnRhKQp7CglydGEtPnJ0YV9sZW4gPSAoY2hhciAqKXJlcS0+YnVmICsgcmVxLT5ubGgtPm5sbXNn
X2xlbiAtIChjaGFyICopcnRhOwp9CgpzdGF0aWMgaW50IG5sX29wZW4odm9pZCkKewoJc3RydWN0
IHNvY2thZGRyX25sIGFkZHIgPSB7CgkJLm5sX2ZhbWlseSA9IEFGX05FVExJTkssCgl9OwoJaW50
IGZkOwoKCWZkID0gc29ja2V0KEFGX05FVExJTkssIFNPQ0tfUkFXLCBORVRMSU5LX1JPVVRFKTsK
CWlmIChmZCA8IDApCgkJZGllKCJzb2NrZXQgTkVUTElOS19ST1VURSIpOwoJaWYgKGJpbmQoZmQs
IChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKSA8IDApCgkJZGllKCJiaW5k
IE5FVExJTktfUk9VVEUiKTsKCXJldHVybiBmZDsKfQoKc3RhdGljIGludCBubF90YWxrKGludCBm
ZCwgc3RydWN0IG5sX3JlcSAqcmVxKQp7CglzdHJ1Y3Qgc29ja2FkZHJfbmwgbmxhZGRyID0gewoJ
CS5ubF9mYW1pbHkgPSBBRl9ORVRMSU5LLAoJfTsKCWNoYXIgYnVmWzgxOTJdOwoJc3RydWN0IGlv
dmVjIGlvdjsKCXN0cnVjdCBtc2doZHIgbXNnOwoJc3NpemVfdCBuOwoKCXJlcS0+bmxoLT5ubG1z
Z19zZXEgPSArK25sX3NlcTsKCWlvdi5pb3ZfYmFzZSA9IHJlcS0+bmxoOwoJaW92Lmlvdl9sZW4g
PSByZXEtPm5saC0+bmxtc2dfbGVuOwoJbWVtc2V0KCZtc2csIDAsIHNpemVvZihtc2cpKTsKCW1z
Zy5tc2dfbmFtZSA9ICZubGFkZHI7Cgltc2cubXNnX25hbWVsZW4gPSBzaXplb2YobmxhZGRyKTsK
CW1zZy5tc2dfaW92ID0gJmlvdjsKCW1zZy5tc2dfaW92bGVuID0gMTsKCWlmIChzZW5kbXNnKGZk
LCAmbXNnLCAwKSA8IDApCgkJcmV0dXJuIC1lcnJubzsKCglmb3IgKDs7KSB7CgkJc3RydWN0IG5s
bXNnaGRyICpubGg7CgkJaW50IHJlbTsKCgkJbiA9IHJlY3YoZmQsIGJ1Ziwgc2l6ZW9mKGJ1Ziks
IDApOwoJCWlmIChuIDwgMCkKCQkJcmV0dXJuIC1lcnJubzsKCQlmb3IgKG5saCA9IChzdHJ1Y3Qg
bmxtc2doZHIgKilidWYsIHJlbSA9IChpbnQpbjsKCQkgICAgIE5MTVNHX09LKG5saCwgcmVtKTsg
bmxoID0gTkxNU0dfTkVYVChubGgsIHJlbSkpIHsKCQkJc3RydWN0IG5sbXNnZXJyICplcnI7CgoJ
CQlpZiAobmxoLT5ubG1zZ19zZXEgIT0gcmVxLT5ubGgtPm5sbXNnX3NlcSkKCQkJCWNvbnRpbnVl
OwoJCQlpZiAobmxoLT5ubG1zZ190eXBlICE9IE5MTVNHX0VSUk9SKQoJCQkJY29udGludWU7CgkJ
CWVyciA9IChzdHJ1Y3Qgbmxtc2dlcnIgKilOTE1TR19EQVRBKG5saCk7CgkJCXJldHVybiBlcnIt
PmVycm9yOwoJCX0KCX0KfQoKc3RhdGljIGludCBxZGlzY19hZGQoaW50IGZkLCBpbnQgaWZpbmRl
eCkKewoJc3RydWN0IG5sX3JlcSByZXE7CglzdHJ1Y3QgdGNtc2cgKnRjbTsKCWNvbnN0IGNoYXIg
a2luZFtdID0gInFmcSI7CgoJaW5pdF9yZXEoJnJlcSwgUlRNX05FV1FESVNDLAoJCSBOTE1fRl9S
RVFVRVNUIHwgTkxNX0ZfQUNLIHwgTkxNX0ZfQ1JFQVRFIHwgTkxNX0ZfRVhDTCwKCQkgc2l6ZW9m
KCp0Y20pKTsKCXRjbSA9IE5MTVNHX0RBVEEocmVxLm5saCk7Cgl0Y20tPnRjbV9mYW1pbHkgPSBB
Rl9VTlNQRUM7Cgl0Y20tPnRjbV9pZmluZGV4ID0gaWZpbmRleDsKCXRjbS0+dGNtX2hhbmRsZSA9
IFFESVNDX0hBTkRMRTsKCXRjbS0+dGNtX3BhcmVudCA9IFRDX0hfUk9PVDsKCWFkZGF0dHIoJnJl
cSwgVENBX0tJTkQsIGtpbmQsIHNpemVvZihraW5kKSk7CglyZXR1cm4gbmxfdGFsayhmZCwgJnJl
cSk7Cn0KCnN0YXRpYyBpbnQgY2xhc3NfY2hhbmdlKGludCBmZCwgaW50IGlmaW5kZXgsIHVpbnQz
Ml90IGxtYXgsIGJvb2wgY3JlYXRlLAoJCQlib29sIGFkZF9yYXRlKQp7CglzdHJ1Y3QgbmxfcmVx
IHJlcTsKCXN0cnVjdCB0Y21zZyAqdGNtOwoJc3RydWN0IHJ0YXR0ciAqb3B0czsKCXN0cnVjdCBn
bmV0X2VzdGltYXRvciBlc3QgPSB7CgkJLmludGVydmFsID0gLTIsCgkJLmV3bWFfbG9nID0gMSwK
CX07Cgl1aW50MzJfdCB3ZWlnaHQgPSAxOwoJdWludDE2X3QgZmxhZ3MgPSBOTE1fRl9SRVFVRVNU
IHwgTkxNX0ZfQUNLOwoKCWlmIChjcmVhdGUpCgkJZmxhZ3MgfD0gTkxNX0ZfQ1JFQVRFIHwgTkxN
X0ZfRVhDTDsKCWluaXRfcmVxKCZyZXEsIFJUTV9ORVdUQ0xBU1MsIGZsYWdzLCBzaXplb2YoKnRj
bSkpOwoJdGNtID0gTkxNU0dfREFUQShyZXEubmxoKTsKCXRjbS0+dGNtX2ZhbWlseSA9IEFGX1VO
U1BFQzsKCXRjbS0+dGNtX2lmaW5kZXggPSBpZmluZGV4OwoJdGNtLT50Y21faGFuZGxlID0gQ0xB
U1NfSEFORExFOwoJdGNtLT50Y21fcGFyZW50ID0gUURJU0NfSEFORExFOwoJb3B0cyA9IG5lc3Rf
c3RhcnQoJnJlcSwgVENBX09QVElPTlMpOwoJYWRkYXR0cigmcmVxLCBUQ0FfUUZRX1dFSUdIVCwg
JndlaWdodCwgc2l6ZW9mKHdlaWdodCkpOwoJYWRkYXR0cigmcmVxLCBUQ0FfUUZRX0xNQVgsICZs
bWF4LCBzaXplb2YobG1heCkpOwoJbmVzdF9lbmQoJnJlcSwgb3B0cyk7CglpZiAoYWRkX3JhdGUp
CgkJYWRkYXR0cigmcmVxLCBUQ0FfUkFURSwgJmVzdCwgc2l6ZW9mKGVzdCkpOwoJcmV0dXJuIG5s
X3RhbGsoZmQsICZyZXEpOwp9CgpzdGF0aWMgdm9pZCBzZXR1cF9uYW1lc3BhY2Uodm9pZCkKewoJ
aWYgKHVuc2hhcmUoQ0xPTkVfTkVXVVNFUiB8IENMT05FX05FV05FVCkgPCAwKQoJCWRpZSgidW5z
aGFyZSIpOwp9CgpzdGF0aWMgaW50IHNldHVwX2xvb3BiYWNrKHZvaWQpCnsKCXN0cnVjdCBpZnJl
cSBpZnI7CglpbnQgZmQ7CglpbnQgaWZpbmRleDsKCglmZCA9IHNvY2tldChBRl9JTkVULCBTT0NL
X0RHUkFNLCAwKTsKCWlmIChmZCA8IDApCgkJZGllKCJzb2NrZXQgQUZfSU5FVCIpOwoJbWVtc2V0
KCZpZnIsIDAsIHNpemVvZihpZnIpKTsKCXN0cm5jcHkoaWZyLmlmcl9uYW1lLCAibG8iLCBJRk5B
TVNJWiAtIDEpOwoJaWYgKGlvY3RsKGZkLCBTSU9DR0lGRkxBR1MsICZpZnIpIDwgMCkKCQlkaWUo
IlNJT0NHSUZGTEFHUyIpOwoJaWZyLmlmcl9mbGFncyB8PSBJRkZfVVA7CglpZiAoaW9jdGwoZmQs
IFNJT0NTSUZGTEFHUywgJmlmcikgPCAwKQoJCWRpZSgiU0lPQ1NJRkZMQUdTIik7CgljbG9zZShm
ZCk7CgoJaWZpbmRleCA9IGlmX25hbWV0b2luZGV4KCJsbyIpOwoJaWYgKGlmaW5kZXggPT0gMCkK
CQlkaWUoImlmX25hbWV0b2luZGV4Iik7CglyZXR1cm4gaWZpbmRleDsKfQoKc3RhdGljIGludCBz
ZXR1cF91ZHAoaW50ICpyZWNlaXZlcikKewoJc3RydWN0IHNvY2thZGRyX2luIGFkZHIgPSB7CgkJ
LnNpbl9mYW1pbHkgPSBBRl9JTkVULAoJCS5zaW5fYWRkci5zX2FkZHIgPSBodG9ubChJTkFERFJf
TE9PUEJBQ0spLAoJCS5zaW5fcG9ydCA9IDAsCgl9OwoJc29ja2xlbl90IGFkZHJsZW4gPSBzaXpl
b2YoYWRkcik7CglpbnQgc2VuZGVyOwoJaW50IHByaW9yaXR5ID0gQ0xBU1NfSEFORExFOwoKCSpy
ZWNlaXZlciA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsKCWlmICgqcmVjZWl2ZXIg
PCAwKQoJCWRpZSgicmVjZWl2ZXIgc29ja2V0Iik7CglpZiAoYmluZCgqcmVjZWl2ZXIsIChzdHJ1
Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKSA8IDApCgkJZGllKCJyZWNlaXZlciBi
aW5kIik7CglpZiAoZ2V0c29ja25hbWUoKnJlY2VpdmVyLCAoc3RydWN0IHNvY2thZGRyICopJmFk
ZHIsICZhZGRybGVuKSA8IDApCgkJZGllKCJyZWNlaXZlciBnZXRzb2NrbmFtZSIpOwoKCXNlbmRl
ciA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsKCWlmIChzZW5kZXIgPCAwKQoJCWRp
ZSgic2VuZGVyIHNvY2tldCIpOwoJaWYgKHNldHNvY2tvcHQoc2VuZGVyLCBTT0xfU09DS0VULCBT
T19QUklPUklUWSwgJnByaW9yaXR5LAoJCSAgICAgICBzaXplb2YocHJpb3JpdHkpKSA8IDApCgkJ
ZGllKCJTT19QUklPUklUWSIpOwoJaWYgKGNvbm5lY3Qoc2VuZGVyLCAoc3RydWN0IHNvY2thZGRy
ICopJmFkZHIsIHNpemVvZihhZGRyKSkgPCAwKQoJCWRpZSgic2VuZGVyIGNvbm5lY3QiKTsKCXJl
dHVybiBzZW5kZXI7Cn0KCnN0YXRpYyB2b2lkIHBpbl9jcHUoaW50IGNwdSkKewoJY3B1X3NldF90
IHNldDsKCglDUFVfWkVSTygmc2V0KTsKCUNQVV9TRVQoY3B1LCAmc2V0KTsKCWlmIChzY2hlZF9z
ZXRhZmZpbml0eSgwLCBzaXplb2Yoc2V0KSwgJnNldCkgPCAwKQoJCWRpZSgic2NoZWRfc2V0YWZm
aW5pdHkiKTsKfQoKc3RhdGljIHZvaWQgc3Bpbl9kZWxheSh1bnNpZ25lZCBpbnQgY291bnQpCnsK
CXdoaWxlIChjb3VudC0tKQoJCWFzbSB2b2xhdGlsZSgicGF1c2UiIDo6OiAibWVtb3J5Iik7Cn0K
CnN0YXRpYyB2b2lkICpzZW5kZXJfdGhyZWFkKHZvaWQgKmFyZykKewoJc3RydWN0IHJhY2VfY3R4
ICpjdHggPSBhcmc7Cgl1bnNpZ25lZCBpbnQgaTsKCglwaW5fY3B1KDEpOwoJZm9yIChpID0gMTsg
aSA8PSBJVEVSQVRJT05TOyBpKyspIHsKCQljaGFyIGRyYWluWzIwNDhdOwoKCQl3aGlsZSAoYXRv
bWljX2xvYWRfZXhwbGljaXQoJmN0eC0+Z28sIG1lbW9yeV9vcmRlcl9hY3F1aXJlKSAhPSBpKQoJ
CQlhc20gdm9sYXRpbGUoInBhdXNlIiA6OjogIm1lbW9yeSIpOwoJCXNwaW5fZGVsYXkoaSAlIE1B
WF9ERUxBWSk7CgkJaWYgKHNlbmQoY3R4LT5zZW5kZXIsIGN0eC0+cGFja2V0LCBzaXplb2YoY3R4
LT5wYWNrZXQpLCAwKSA8IDApCgkJCWRpZSgic2VuZCIpOwoJCXdoaWxlIChyZWN2KGN0eC0+cmVj
ZWl2ZXIsIGRyYWluLCBzaXplb2YoZHJhaW4pLCBNU0dfRE9OVFdBSVQpID4gMCkKCQkJOwoJCWF0
b21pY19zdG9yZV9leHBsaWNpdCgmY3R4LT5kb25lLCBpLCBtZW1vcnlfb3JkZXJfcmVsZWFzZSk7
Cgl9CglyZXR1cm4gTlVMTDsKfQoKaW50IG1haW4odm9pZCkKewoJc3RydWN0IHJhY2VfY3R4IGN0
eDsKCXB0aHJlYWRfdCB0aHJlYWQ7CglpbnQgbmw7CglpbnQgaWZpbmRleDsKCWludCByZXQ7Cglp
bnQgdGhyZWFkX3JldDsKCXVuc2lnbmVkIGludCBpOwoKCW1lbXNldCgmY3R4LCAwLCBzaXplb2Yo
Y3R4KSk7CgltZW1zZXQoY3R4LnBhY2tldCwgJ0EnLCBzaXplb2YoY3R4LnBhY2tldCkpOwoJc2V0
dXBfbmFtZXNwYWNlKCk7CglpZmluZGV4ID0gc2V0dXBfbG9vcGJhY2soKTsKCW5sID0gbmxfb3Bl
bigpOwoJZXhwZWN0X29rKHFkaXNjX2FkZChubCwgaWZpbmRleCksICJhZGQgcWZxIHFkaXNjIik7
CglleHBlY3Rfb2soY2xhc3NfY2hhbmdlKG5sLCBpZmluZGV4LCA1MTIsIHRydWUsIGZhbHNlKSwK
CQkgICJjcmVhdGUgcWZxIGNsYXNzIik7CgljdHguc2VuZGVyID0gc2V0dXBfdWRwKCZjdHgucmVj
ZWl2ZXIpOwoKCXBpbl9jcHUoMCk7Cgl0aHJlYWRfcmV0ID0gcHRocmVhZF9jcmVhdGUoJnRocmVh
ZCwgTlVMTCwgc2VuZGVyX3RocmVhZCwgJmN0eCk7CglpZiAodGhyZWFkX3JldCAhPSAwKSB7CgkJ
ZXJybm8gPSB0aHJlYWRfcmV0OwoJCWRpZSgicHRocmVhZF9jcmVhdGUiKTsKCX0KCgkvKgoJICog
VGhlIGVzdGltYXRvciBhdHRyaWJ1dGUgbWFrZXMgdGhlIHBvc3Qtc25hcHNob3QgcGFydCBvZgoJ
ICogcWZxX2NoYW5nZV9jbGFzcygpIGxvbmcgZW5vdWdoIGZvciB0aGUgcGFja2V0IGVucXVldWUg
b24gQ1BVIDEgdG8KCSAqIG1pZ3JhdGUgdGhlIGNsYXNzIHRvIHRoZSByZXF1ZXN0ZWQgKHdlaWdo
dD0xLCBsbWF4PTE1MDApIGFnZ3JlZ2F0ZS4KCSAqLwoJZm9yIChpID0gMTsgaSA8PSBJVEVSQVRJ
T05TOyBpKyspIHsKCQlleHBlY3Rfb2soY2xhc3NfY2hhbmdlKG5sLCBpZmluZGV4LCA1MTIsIGZh
bHNlLCBmYWxzZSksCgkJCSAgInJlc2V0IHFmcSBjbGFzcyIpOwoJCWF0b21pY19zdG9yZV9leHBs
aWNpdCgmY3R4LmdvLCBpLCBtZW1vcnlfb3JkZXJfcmVsZWFzZSk7CgkJcmV0ID0gY2xhc3NfY2hh
bmdlKG5sLCBpZmluZGV4LCBUQVJHRVRfTE1BWCwgZmFsc2UsIHRydWUpOwoJCWV4cGVjdF9vayhy
ZXQsICJjaGFuZ2UgcWZxIGNsYXNzIik7CgkJd2hpbGUgKGF0b21pY19sb2FkX2V4cGxpY2l0KCZj
dHguZG9uZSwgbWVtb3J5X29yZGVyX2FjcXVpcmUpICE9IGkpCgkJCWFzbSB2b2xhdGlsZSgicGF1
c2UiIDo6OiAibWVtb3J5Iik7Cgl9CgoJcHRocmVhZF9qb2luKHRocmVhZCwgTlVMTCk7CgljbG9z
ZShjdHguc2VuZGVyKTsKCWNsb3NlKGN0eC5yZWNlaXZlcik7CgljbG9zZShubCk7CglyZXR1cm4g
MDsKfQo=
--0000000000007984980658b36d2a--
