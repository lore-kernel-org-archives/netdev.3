Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00F4A4EFC
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000082; cv=none; b=W8ENtWo0bXtp5HEtApdCoK5Rtz/hVIbyB32pMhwAR7fickAFmxF9CdYFIAycuN0ZOmLQaYXyFoFXXiMcnVrKW/rrZyfoMQhrh7OjEpD31UcVIYGG76/u0xibtjQY0vlBWvKCF1296Q7qPg47z49nLyFK/f0rfJiau3SZB5G4XQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000082; c=relaxed/simple;
	bh=A3lMAoHzvdrIRHmu0U9O1DHYioyKBVDwytLfoEf9Ugk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjeS3cpYIRgSFGV8UrXQh9Ozrz07uS8iAFylj9nbPOlDPJ5q6cb18Gy8mjwrKycFNSIUXA36A6gBz/nM6NVjxJjk7Kmk8sezn71NMm0y3DSMQKy/SVLmAuYQSJxNjJA95q7r9BQSJRa/FaHStIJo9u7sPwU+I5WllTZp3n/R+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GBOj/dTt; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GBOj/dTt"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so17382125e9.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790000078; x=1790604878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+gnaVA0UVg6a41pLazpe1rvpHFpADsMibbWOKFLPcI8=;
        b=GBOj/dTt0Pnzf1RehLOSf+1dOdqVXbCtTPy/3WB+gLuPImY6+Eaf0qTsiS2vcjXk/Y
         x5Fqz7rK0U83YB880I53upchyDBUQakYuPGRO9MLHFS6KcopxaYkXKzhEjcQ6OMqs0vy
         NrlT3UmAOpPIXM2ql9eo4Lm2AopyEP829oDUSL7cZ93tUcI4GSGHuzWheXX8Dez78qnP
         8r+1UQOqP9xCle8mvaZWAzb3V7ebpEtCcVYpbCK8f8BwG1sppWESUQHWyTajoChF09qs
         fXnH0tgeF4nEWgzqvz9UYQUhUWliKiNexORApK2XSUs37DMCd0/7lNx9fAlTSjlTpnRp
         /H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000078; x=1790604878;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+gnaVA0UVg6a41pLazpe1rvpHFpADsMibbWOKFLPcI8=;
        b=W5hAsaZKccKf8bCPn0cjaqPMsjVHPjnrBixgTaDu4NiWb91xLBi4g5ztuD9jAU1PX4
         2iTT6T7WUpGRwrKRBtIvhpKeidhFAtNI3kl581QLwMGqGXd2BdyrVNlSvJjT0uTcQqwp
         zZFAs+zVTraweHuIMyf3KrSS0pA/DOQjvd0oCE8GJWt2Bgqw6Y0BR2ZvBVwB2JxNJiUm
         YhMVGOblemwiZthOaU6yWsJQV3/2vOPM2P6tc7YUtZd74C/3usF8iHXrdOTLoKGu7IxN
         iOwPrclPC60ePFE6O1P0TDTjH6Cjy3gz59D4DCfyrhl/rlzlzIHN4aEnH6GgW9VdEQ75
         Zp6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzsxwrZMe2b0xvUSFRNaRZk5NhLf6do6ZnZBtCRgqtPWKDMwOipUBispSRJVCH9orgLH1fhqng=@vger.kernel.org
X-Gm-Message-State: AFuF++nW7ZI97SnAih8qesb7qDx0Vg5+9EciLtCV2CumSyiyBqkbmtxY
	sa5HoaaZcEU06XyRlw2ZNmjDnn1hCruUYXXxQLvvUBgoIYprquQcR6VuCfB3Ju6R4U7vqleOOqS
	iR/lo
X-Gm-Gg: AYBFou3rJYV+S2rs5Yu6kYNiGO8U99zXkxpTyz1nJSeiDDdz8pZ6Qyg4khwHn5Qh/GH
	TPXFlYGm2lNbkUcdtF6uU5YsDkVBGhngSO9cR55Mpe2sEX005nsFW+jPfY5T5++pwo4r8r9iCcD
	HcVMnH2z7dyeZSv+7FpyYYdz7lS0cP7Ys7/H6n0S6D6F4n1NEh4mfaF3EZbAaKWxZHNkYmyt8ad
	tXNIUMIgL9brLxqFPdOR+6qo+MMllU+2B3TdEA45iOYasfRpwAFV9xx2M4aNQUPkyDjsbztXXM8
	onK6edZMwt3M2BWP3WomBtfiIGlpRxDpPMVZqjB/7Ui6zIH1kQWmKLrrZ6IhUvrQTUPElWuXWZD
	rt9zURvOXur4q/bg6Wsr7tiqt7yQ+KMVf2I6DXV9SKt8k4oYBRIdCMCLkqf+dy4V5ZAg+wUw8Wq
	VIDIFEGk6FBckxm85k/5MqW7Ao2sE0i3NM38zLDSZriXOPU4Xrsl7Zt+beFAAyjI+P3no06bz4z
	FgBIlGZOFXK29jR7w6+Wcm0DwCSJw==
X-Received: by 2002:a05:600c:3b8e:b0:49f:bc43:9e96 with SMTP id 5b1f17b1804b1-49fc57144aamr194759525e9.8.1790000078224;
        Mon, 21 Sep 2026 07:14:38 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487244229d5sm24216068f8f.2.2026.09.21.07.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 07:14:37 -0700 (PDT)
Message-ID: <ab670ef7-7650-4a39-9871-b5182725beb1@blackwall.org>
Date: Mon, 21 Sep 2026 17:14:35 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mdb: restart port group walk after
 deletion
Content-Language: en-US, bg
To: Fourie Zhang <littleddfu@gmail.com>, netdev@vger.kernel.org
Cc: TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Petr Machata <petrm@nvidia.com>, bridge@lists.linux.dev
References: <20260920110852.60293-1-fouriezhang@tencent.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260920110852.60293-1-fouriezhang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/09/2026 14:08, Fourie Zhang wrote:
> br_mdb_flush_pgs() keeps a pointer-to-pointer cursor while walking
> mp->ports. br_multicast_del_pg() can re-enter the same MDB entry through
> br_multicast_sg_del_exclude_ports() and unlink other port groups. If the
> cursor points into one of those groups, the next iteration dereferences a
> stale cursor and can leave mp->ports pointing at freed memory.
> 
> A following RTM_GETMDB exposes the dangling pointer:
> 
>    BUG: KASAN: slab-use-after-free in br_mdb_dump
>    Read of size 8
>      br_mdb_dump
>      rtnl_mdb_dump
>      rtnl_dumpit
>      netlink_dump
> 
> Reset the cursor to mp->ports after every deletion. The deletion removes at
> least the selected group, so the restarted walk always makes progress.
> 
> Fixes: a6acb535afb2 ("bridge: mdb: Add MDB bulk deletion support")
> Cc: stable@vger.kernel.org
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
> ---
> A reproducer for this issue is available if requested.
> 
>   net/bridge/br_mdb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index e0c7020b1..a01bd280c 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -1523,6 +1523,8 @@ static void br_mdb_flush_pgs(struct net_bridge *br,
>   		}
>   
>   		br_multicast_del_pg(mp, p, pp);
> +		/* br_multicast_del_pg() can remove other groups from this list. */
> +		pp = &mp->ports;
>   	}
>   }
>   

Yeah, this seems like the simplest fix for stable. I will post my conversion to
standard list primitives and will remove these issues altogether with it in
net-next.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

