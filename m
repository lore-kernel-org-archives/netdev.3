Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7028337B40C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619380; cv=none; b=HpKImKwRyDJGRrVnyctA3ipO8VG5VqnSyRaBsUySZ8q/NjMYarOkDA3ETx3N8xa0Bu1J4CJr+B1mm94lRSqQNioRuecYf5NBdwbxby69IpGAYHXCTvFPfCfMS+OYGRnWSMkrqrgzB7Y8RUThUcXdhLPrYhCfa/gYcdHWfZeUyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619380; c=relaxed/simple;
	bh=7vTTHLgjDLlLPdeQhoLdV3OKPsU5wVu1rrzkeJBO1WU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=i6IMDnxLBYv5uedBQY4MRVQX8eYD72JgKd9lYbEjF0OPodeSmntXC1kHyo6gw5baGiW2+sXGPz49N/DddCU1mc+3XqkuhXHCOMbf2/QwVgdCJDnxeBDs33y3tXQEglQ/NZTJh/+QtRD2Vmivpr12csum4ole9RmWzvYgYgPJlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjeXz0+e; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjeXz0+e"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505832so28495207b3.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619378; x=1791224178; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6+5QZjBHt7slhpA3khxfZMkWrPmM/EZL0JsZQiZlI8s=;
        b=XjeXz0+etdc+BAUrhRYq5qnNq6ODE+MlZG9z83EVCIeIY86f9o/shHRaNJteZUpFLb
         hOlQDXYVRiYIlWSwH7HHQH547xGz8Z/w+R59SaDQmUmiPXY2JSEnorVsjq1JWcKyDC3D
         s0lpAGVd6XhVmE40xfK5o7W4gXXbxnHVzWyz0ZBrt6cp0tERAX3EufA4RgDBSGvZPwuU
         2/DUmtmZvqeCxFu0qVth1DvuCg2n2uUHEcHdjqKEL7hrMMYEFcPCKCkSQVqzR2ezySvJ
         N0C2FzGedbMy6qeIb6ULm/Jdzi1dsqahheZj9aQUSk4aBMONsgw0j2f5PR8B4fvfBwtI
         SJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619378; x=1791224178;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+5QZjBHt7slhpA3khxfZMkWrPmM/EZL0JsZQiZlI8s=;
        b=Hfx7IXD5k7Pb/FQqLRUKB3ZMAJtcJTC714ITRkPPlaDE89N6Hj2BKIst5nYIKvPPiU
         0GaErZ7SF7xWheGPK8dia1L9DGo2rcawObjGyHk/mQMh1E2AiQNFVlweogEQzannvAeq
         VEeZBn4OToIKRYibjy4uYzyAvMwryqavZTldkX+WHjPGvHx+eX8PLnvHD+OOo59FzBjv
         whtO53eXoz4cSn9A2rpKml+iaOcw1DRD/GVM7mmutLW8LmQ4j6qfcobsPld+qDX1iDbK
         dVpPlVIUqYJP5xEU39HVZUj0Ye1uVUrPHDxoXGj5SWPqU+PilnKH1TydqkzIcHpWmuuI
         VOhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvmFyVpPvgx8KgEDlfWC7nUm5Ep/pdCHQMyWVvbkmlSLJ64uCPIv28bDhC1WliQNVxBMn2How=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5tPEptbT6pYPqRRZBN+4QHDGPX7pmbIMj/9xATjE9ysZvBfY0
	O008fdw9uE0vSQV9z0eku+vmxGpPp1P+MfzWGCqEF1T/0cDMi41QPkEP
X-Gm-Gg: AYBFou11WCTA4efNCVKht/izsNIhDXBf/cy3dxoLlZoxHfkDDGS2A2toMkeEmMi6MUL
	povUhrP4CwcYVUQJ7Ju+AD9z3vJRiumM4qcBOODvuz/vzfsqvkb4WFDm9L+GkK2ZJvb5FdR5sh1
	4ojl8Hq66z0zxVhx71W5THaKcA6fRsXJ0q1GT0L97ShpqCsLvAxXowY0H+Oa4LE1l7OLyKbz+fO
	lpmpJlt9+PtflooylYc8gwoXIp4jrJ3Fc8xvIZTuKLPFaQhr7CBUaVIvQoFH6W+V8NQnAhWZIRF
	DhuTpcvNcoaiAvItipZbVlyKyB1Z6TLdHTQGuI/wDgw0+zs7jlAf9FnoW3OEeAqILWpKiziM4bT
	FhbknIOLXCChUdFsb9uFdeFlAIZkQvbx1Wrok8FIcAgp1qLUEFJkb6qURdlGRqBAoY10f6tuaQU
	PkqPNRVdaog7/FRu4N6Nk1+XcYWH0X+d8p24f6vfzNUXaLRKwRTOuVfj6xjDewIJ+KjjiuXvLNk
	SuiLYWziCCXvw==
X-Received: by 2002:a05:690c:83:b0:87f:bf8d:3377 with SMTP id 00721157ae682-8a64e4b9525mr68069317b3.63.1790619378395;
        Mon, 28 Sep 2026 11:16:18 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c81425bf8sm207305285a.28.2026.09.28.11.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 11:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:16:16 -0400
Message-Id: <DLR5LDKR0ZN5.A3UPDC84TSQE@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/8] eth: mpnic: initial support for Meta
 Platforms NIC
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Daniel Zahka" <daniel.zahka@gmail.com>, "Alexander Duyck"
 <alexanderduyck@fb.com>, "Jakub Kicinski" <kuba@kernel.org>,
 <kernel-team@meta.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Dimitri Daskalakis"
 <dimitri.daskalakis1@gmail.com>, "Mohsin Bashir" <mohsin.bashr@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
In-Reply-To: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>

On Thu Sep 24, 2026 at 8:35 PM EDT, Daniel Zahka wrote:
> Meta Platforms NIC is the second-generation NIC from Meta. There are
> quite a few high-level similarities to fbnic, but all of the CSRs and
> descriptors have been reshuffled, and new features have been added.
> Since the device is sufficiently different from fbnic, and the design of
> our FW is minimal, we have decided a separate driver is appropriate.
>
> Major new features compared to fbnic will take a while to land. This
> series includes only the bare-bones Tx/Rx datapath.
>
> Our high-level patch sequence and plan for the upcoming series is:
>  1. Core datapath (this series)
>  2. Basic offloads, RSS, and counters
>  3. Firmware mailbox support
>  4. Base ethtool operations
>
> This patch series was prepared in part with these LLM prompts:
> https://github.com/kuba-moo/ai-prompts/blob/main/driver-upstreaming-promp=
ts.md
>
> The prompts were used to distill our fully-featured OOT driver into this
> minimal Tx/Rx capable upstream driver. We then performed human review on
> the output to create this posting. Jakub has made the prompts public in
> case people would like to take a look.=20
>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
> Changes in v2:
> - eth: mpnic: add register init for the device
>   - derive the TQS TXB credit limits from the TXB private credit config
>   - program the BMC to MAC XOFF threshold (TXB_THRESHOLDS_P0[16])
>     instead of the host to BMC one, and drop the now unused
>     MPNIC_TXB_BMC_THRESH
>   - drop L2_HLEN from the default TWD, it only matters for csum/LSO
> - eth: mpnic: implement Tx queue allocation and cleanup
>   - add mpnic_nv_irq_trigger()
> - eth: mpnic: add a netdevice and basic Tx handling
>   - trim the real Tx queue count before register_netdev()
> - eth: mpnic: implement Rx queue allocation and cleanup
>   - drop an inaccurate comment on mpnic_bdq_desc_unused()
>   - drop the unused data_truesize field from struct mpnic_pkt_ctxt
>   - trim the real Rx queue count before register_netdev() too
> - eth: mpnic: add basic Rx handling
>   - skip Rx cleaning and BDQ refill when polled with a budget of 0
>     (netpoll), page pool must not be used in that context
>   - keep struct mpnic_pkt_ctxt instead of replacing it with a bare
>     xdp_buff, and move add_frag_failed into it
>   - give each Rx queue only the NAPI budget left over by the previous
>     ones instead of the full budget
>   - sync Rx buffers for the CPU with page_pool_dma_sync_for_cpu() instead
>     of dma_sync_single_range_for_cpu()
> - Link to v1: https://lore.kernel.org/r/20260922-linux-mpnic-v1-0-236844f=
53072@gmail.com
>

Just so it doesn't get lost over all of back and forth with sashiko. My
view on the series is that I don't see any issues requiring a v3. Until
other feedback comes along, I will not post a v3.
