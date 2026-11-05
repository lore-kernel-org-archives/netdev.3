Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911427;
	b=pvjyUtyNLDMCAgK7Rfurc3jZTo9Yyc8srU8bhzJmPUyoxiSc9Y++SixrGlM0MSzQY9Hw
	 uY+LOXZ25jkBno+QotUOyDoO7DJR83Zc8NAiyq2/yB92OSKcsDgh1c8Mth7Om9qHsFe63
	 ZOIK4b4nYc50Bw75DYNlwfBaJvdSwde6XpGX76n3Ie6dVkr8lSNSR/l8yXfNNtpU7L7Fg
	 8mM965r8OdRLBY1Yz5flcW7/dOFWMF+Jy7SQKLFrJZxUPoFxRnLSxeP9j/A2Dy+KHajjJ
	 +SUgoIkX9l5OmjTUH89/oebCQ+LfVW6xRjcQQnpG1lcc0aOur2CLnLhwTkuKI40mFGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ZO0lbTyAXJ9HHsEghEBA7TDSpduDUgDR7hn4G1aE2mE=;
	b=SXykrHFRbGbfTbo/pIkF3Elx6gYQ2UtTuCuCMilKCo3i7IoE0yCxux6uzvpbb+fVnLOz
	 g8W+vfDhiD2ynsKUAsk8eefre3CpG/opEzKxCa+JRajYwEe0lzz9qqg2snDds0MhJRJ/A
	 v4nP6FxOKyooRMwuF8MbJtpecPzhohZPD/JXOSz/56lhINTTgIcQEaj2v4v00imd8PsV7
	 UHTGpMlX7MFhcSDv53sXw06ZRHIPPcDJpUinpWM4/3X4MeUEb3ccQXL4hIPEVuNvXJ643
	 8NQVn1anoDZia6S9lfCv2Nfn4Yk5BVmmhEgMLxhXJNYMLYqAqZIp08jmSe4PAr+V8ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jb3k82YL;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC10606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AC10606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jb3k82YL
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso1403109eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911426; x=1794516226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZO0lbTyAXJ9HHsEghEBA7TDSpduDUgDR7hn4G1aE2mE=;
        b=jb3k82YLQGrUO/jXd9XOcyZHKpx0mVDH63niIjZOL+7hDWYpQZ25ndPdJ37zfewjSj
         5vCFgyBQnyk1t0oBiU4Wc645iccqIQm2z1G3qXYTOA9s4wUlLbjSCd5QFBJ8HqhRQO91
         NJjJAWgfRZWW3AexIl/vzKOQjdZkh3/JCSeyftDY+pbTo9RF3/skmQnt8y3RcbIz/L7/
         YibxMzj1tTVB2Lfbg2pD/TArzJ9AHnUw2fS4SlhcKvel3QeQw34C4p1R/itXcURfghl/
         PE/0RwwjFGgwR17uR6gfq8d1fDeyN9iJpW7Q+1qYlZ9zCbBp8OVlklciseQLWpEV8xAu
         RDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911426; x=1794516226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZO0lbTyAXJ9HHsEghEBA7TDSpduDUgDR7hn4G1aE2mE=;
        b=yDpvy1qUzZ2s0VHLwldevR67AhULAp+XQfUIVbX+5nkT/cRjz0s/8X1mKdpaBosZhN
         mcCY1JxAvQCo42LYmNkuNxweaxTNJQTI9On+Ku0jlTZt/CSWABcSCWbdeoHTJ1tFjAQK
         ZiBXlKsDe3MN1X+TIMl9YFPQoJvr2pk1NJ0fm6DO6/aZzmdaNKzwScRCEnKQUitksibh
         WqGKpdy+QETeQJoKgba6yuGmrGK6uyIEBCVg/i+ExGTVLx3R0MmixvLf8wRoXRCpGyec
         T5ADyqIGbj1s7id4uD7ai+3dX7DaN2+/KZ9ubZpoLC6AyclwhOdQvh3+rMqQIugD8BsS
         ZxjQ==
X-Gm-Message-State: APuU4Z+uyp7hsDFD1UlziaeR8km0cEkwwUyfebMfmYqjvIKl9EQFPjV2
	yyHoF/bpZuCtZ9SqauP5RfMLu431MNfl7H8VxfXB6m+Ii/BncZEetUMm
X-Gm-Gg: AYBFou23/S9Wz6eKtLRj3FxBn8uYu92/wmk6VHYQ0c/mU7QC4aiQX0uAESEcqDX4Q2z
	NhrryNA7yVq0UTPDf+0zHNbtHPD/x39uOnfXFZ+RsEMUjXHMNYizVANUaHYdHnXIgJCQE5emq6S
	K2bA5fCDwgDnUneuS7c5FCuo+TUmODz3GGK4Vcv56tWLbmABfEHkeqRaEDdjYLAb8i0dxhU0s9T
	2geb7d6tSEyOkjfBbNH3kOACenSnNJqfPMImJayTjJAE8nn8sQrKWlzvYtpzwsVDfZd7YlSk1j+
	kRNDlvsnDNDofkYA/uUE2Rtax3MT9YIcgsVnBecvSHbGWw8v2iuUOtGGZxR90xulJU5hJW6WYyy
	NM+RBfs17UzGPMGNDTlaic/xWMoPbDQZjst2rBNraRjrScCmiW2W61k2ajtU1iiY7dSMSSFsnPj
	Ux9jSnPmWaLPeIk9cLP9pv0pEhCCpEXxembBJWALhuAsLLQPEly+UDexArDn51xEm8G0NiJorQx
	IUMctNnC66oySX52Dydhhbs7tUPb0/58zyw0+7EGEqtepfQn+aMT493ZSehCvNyQflK04dhVqWt
	I+drYgWmcWXcBHJia/PfQA==
X-Received: by 2002:a05:7022:288:b0:15e:9126:c60f with SMTP id a92af1059eb24-1b25d35f3d1mr160621c88.29.1793911425862;
        Thu, 05 Nov 2026 12:43:45 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:64::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c30521sm20459016c88.13.2026.11.05.12.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:43:45 -0800 (PST)
Date: Thu, 5 Nov 2026 12:43:36 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com, 
	kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH net-next 0/4] selftests: move the AF_XDP test suite from
 bpf to net
Message-ID: <auzqcm1YLsTvUU7S@devvm16445.scu0.facebook.com>
References: <20261105134117.977655-1-maciej.fijalkowski@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105134117.977655-1-maciej.fijalkowski@intel.com>

On 11/05, Maciej Fijalkowski wrote:
> Hi,
> 
> As the maintainers asked, this series is the first step of moving the
> AF_XDP selftests from selftests/bpf to selftests/net: the code moves and
> builds from its new location, without changing what the tests do. The
> rework [0] posted as "selftests: net: migrate AF_XDP test suite over to
> net" (v4) will follow on top of this move.
> 
> Patch 1 drops the test_progs wrapper of the AF_XDP tests, patch 2 adds a
> generic BPF skeleton rule to net/bpf.mk, patch 3 moves xskxceiver, its
> library and test_xsk.sh to selftests/net, and patch 4 (new, not covered
> at [0]) moves xdp_hw_metadata, which is built from the same library.
> 
> The xdp_metadata test stays in test_progs: it covers BPF core
> behaviour, and moving it would mean rewriting it for the kselftest
> harness. It keeps using xsk.c from net/lib/xsk.
> 
> xskxceiver and xdp_hw_metadata are the first users of bpftool at build
> time in selftests/net. NIPA has bpftool, but 0-day and KernelCI build
> net without it, so both tools are skipped with a warning when bpftool
> is missing or does not run.
> 
> test_xsk.sh is installed but not run by run_tests, so NIPA does not pick
> it up: it runs every case, including flaky ones, and some cases leak
> page_pool pages after skb_pp_cow_data() in generic XDP mode on
> veth-based runs. Until a later step makes the suite fit for NIPA, no CI
> runs the AF_XDP tests. test_xsk.sh is being removed by [0] but it is
> kept here as there is no other feasible way to run the test suite (if
> needed) until we come up with an upstreamable Python runner.
> 
> Thanks,
> Maciej
> 
> [0]: https://lore.kernel.org/bpf/20261016174338.787135-1-maciej.fijalkowski@intel.com/
> 
> Maciej Fijalkowski (4):
>   selftests/bpf: drop the test_progs AF_XDP wrapper
>   selftests: net: add a generic rule for BPF skeletons
>   selftests: xsk: move the AF_XDP test suite to selftests/net
>   selftests: net: move xdp_hw_metadata from selftests/bpf

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
