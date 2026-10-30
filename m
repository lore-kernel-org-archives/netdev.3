Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391179;
	b=lEtUJcY76zXXBfEUVbDWgg5yWhs23lIAxyIP1hua7616RinqyGm/CSLCS38Ev3svwFU3
	 2HDAODSCejeo8p0nDJE6EKOES5aWbzzHTZcGN6PawUsLcw7jHgn6e+GbFt4bQ6Z0uTxRF
	 vBtDttrIemy9iW1d/BEjRslJpSoHPbwmhiaq3vtjuwLbqU4ow3pqCXL80GzwP4sUjhytn
	 awY8nHyptxZs4K+aIo061TL8GB16LeUhaNosiyL+++MGbK7JzYkrJ5eoTLrQIPqqP3yCz
	 39iMRMpeY+BtNhgD5xIcv2ohV/3c7FVUmdRkB4XQTuJ/63hTiM2p3qqaVDrqS+qRU4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+uEj7dkzggUb6lkggRktE0fOB+YC39Gh7yxfAZ3lKo4=;
	b=V3QMutaaV0z6Lg287JOhdsRrYexcRrwhjoxyslyWFtAFoWUl89+zfRaTxO1VseVCaMYx
	 omNdTQ66Hz8bA8HSd94s12C7TiX7W7prFeqbS2U6ZDeK0xEQx5ERb150Q4R7pEBumdyRF
	 FpeVy7Imh3xHljss1DhB/BOPgrVEWrCE2LLf9thXMb4kIcv/ln6PoLlMCSE2BbGSTP9oS
	 VFEtvjWPTqmGhnSTjKxeUeRbHBGT0rMGgBOlJus+qos7op7I566lDjk0cUTn77ZCepSxd
	 CypA8WcHxfoHbEGuy29Rsb32Y4fCuB1SBmtgWhEVg/wGbzaBg6Qf+neXLdIIjZkLDow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbdZiQoN;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46649606A32F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 20:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46649606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbdZiQoN
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a24f47293so634813eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793391178; x=1793995978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+uEj7dkzggUb6lkggRktE0fOB+YC39Gh7yxfAZ3lKo4=;
        b=SbdZiQoNd9v8nZxQuOMNPRPAe3YN2K/2lS+7X9Bn5BxLITOLrcB/hcYjzkI20WWS4y
         fQtDhN+STPp2Dp0/8jJwHW/ofizMr/sz7JyYnt0QKsCias2AT1scQyiu3EUysCy2pkMm
         5+8smIXAqprspCMZSCaCNLCvO9EIOEqYqVaFzDA4ea+YmKxbDNbpYljFke/oD5wDjtz7
         KVbwuTxXV9dDsWLdse7wjZIq7JVItQopjnOPpBeL6CnpdEAh51fr4V/62fxwkrOom3al
         rq9la/RooBlB1Fx85WhoLa0CIdH4Nn6lEELyrTkCoIaEivYuHKS1p/GFeD36Mx+YqvSp
         eTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793391178; x=1793995978;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uEj7dkzggUb6lkggRktE0fOB+YC39Gh7yxfAZ3lKo4=;
        b=ThW4YgnL76u2eUzOJguCxKvuut+ETKvjTph0bbXbxrzpchjne0pqkh8wijhmlckKkL
         /3me6sATd/sZNhauND8dNQoNXtrluTBeMCgGL4ky0ds5Zr1WPmzMciGDwtX9GnvqQy1p
         EPNeOiuq+C3P1zwp6h/vLM8VyvXZ44kb5MN/mg19GFhfIPrxAzhYsYtbVcQ0fzpV+Rn/
         pF3oSgoJW/6Jwv5Tivz35O4ZJ7UyLAB3IH0AgDnePey1LNImryoYeTqSsdKF9FCWU9pi
         4tDRbeoURPnc/bW0piiuNNu7MxrUhMORUrXcH7YAG6q8q1zYB6sw8m5KAAAPBdf5TzHW
         ZC0A==
X-Gm-Message-State: AFq9FYL5bP1eQBPfrcDz7RzXKK2uN7AU53HDec8uqLN1Avg896IVTlbc
	MARRS3H4MW76piy2xUaR9qd1J4U3R+QO8NhaWAiTbvQaWPBhXP3SQaDQ
X-Gm-Gg: AYBFou3bCgi2N54+9bp0ACS6geSy9reIbJ8GJuyyGT3VwBbVSJtPHJjRA5pDV2Bd0A4
	N4z7dD6tUZo7U8IvPIISIuWTJiAwLpy/1m4dVl/N1Pv27wWmzIKewZzkFxueqZ4DlsRHTctHGQM
	BgQFC/vJltqMED8Ci4ETg3XZj4vZH3U09m2pY+oVOqBG+/beHE4nUCmK+Pfty18jIsrO1qwUIro
	BYFveRPp8mthe93iIIUrsnxIFeIwKVRcAVtxqZtXKrYuj98wIycde5c444h023x+VNb68t1JIbZ
	4G2yfNiLkG3oHUKDQMFFIbbMYvyLgTVvFWiizhlmaTFcwNEHLp5vSC1wvlDon52iLQeGvdliqGe
	pn5rFdPpNSHjv/RYNSywJsaPYnlFcxFVYRBz+q4iOhta8Sk0pVnU9d5RsGFQWXyEwrtTqCalg62
	UqcfspaD9CTWpTNOhARyDonsX8igENOoxc18ylzZF7VipJITyU3Wc6owDLrf4l4+Tf4PSVlLw91
	7oFYF6UldbYbzsg87MjC51w4XL8XAp/SepsGs6FR30am24qLtRm7JQ80mspq/F9yFJRx6BTsoU4
	zKP1AXd/iLlVmVHPHnkRGY0=
X-Received: by 2002:a05:7300:e9c5:10b0:367:3d68:8480 with SMTP id 5a478bee46e88-36a4206d82emr5086488eec.0.1793391178247;
        Fri, 30 Oct 2026 13:12:58 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm9450626eec.19.2026.10.30.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:12:57 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:12:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX
 software checksum
Message-ID: <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
 <20261030023248.78802-3-testwrzwrz@gmail.com>
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
In-Reply-To: <20261030023248.78802-3-testwrzwrz@gmail.com>

On 10/30, Rongzheng Wang wrote:
> Extend test_xdp_metadata to send the same UDP packet using every descriptor
> count from 1 through MAX_TX_DESCS (MAX_SKB_FRAGS + 1), and to run the
> existing metadata and checksum verification for each case.
> 
> Build the packet once and write it into the TX descriptors in a loop
> instead of using a flat two-descriptor layout. Keep the first descriptor
> large enough to cover the checksum offset; the remaining payload is split
> across the continuation descriptors, with the last descriptor taking the
> remaining length.
> 
> Reuse the existing AF_XDP setup, packet generation, completion, and receive
> helpers in xdp_metadata.c instead of adding a separate test harness.
> 
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 147 +++++++++++-------
>  1 file changed, 92 insertions(+), 55 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 5c31054ad4a4..17da0a145666 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -18,12 +18,15 @@
>  #define TX_NAME "veTX"
>  #define RX_NAME "veRX"
>  
> -#define UDP_PAYLOAD_BYTES 4
> +#define UDP_PAYLOAD_BYTES 32
> +

[..]

> +#define MAX_SKB_FRAGS 17 /* minimum CONFIG_MAX_SKB_FRAGS */

Any reason you're not reading the real value from
/proc/sys/net/core/max_skb_frags ? 
