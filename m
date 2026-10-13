Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569A280CD5;
	Tue, 13 Oct 2026 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896298; cv=none; b=SM4Hx6DYEM7H6t2wMyUr36kYGII8C2oD473eY4pfxK1mYCxbdCbbxycFDZL8zEM+l87EVGCZy1i8MhBHgXrEerQczZveBXFeFNv9BAWllc69VJhz/I+FUOiemTi2U+C4GWV5uUQZ+qV8JkiwneFdqyvlFAzP9i5FH/aQiJg9mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896298; c=relaxed/simple;
	bh=jiF6no4F8t6hxz5rhlj9HRuS6E94NlUNamRN9I2bz1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzZyabZ225BBBUr28kDIYVooGS3+tYYdEt1P3TOEhNi2EQeHwW6Aym0scZsGKNPGChiHFtn/Gh2AOviUR2g+F5YFnnDsXWxs87SNSLg06bvO9GRBTaMl4b6ZxSnAG2VZwfM4yDwvvDap55stc0KV0vmy0Yi2QVCDG3HulaS5w2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=iNaFolXx; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="iNaFolXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1791895903;
	bh=jiF6no4F8t6hxz5rhlj9HRuS6E94NlUNamRN9I2bz1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iNaFolXxIX1yN8TJFsIMjq8LcZxfq7Iregd4cbqq5CcUCRNzH6WkK7Rp6FJPX998Y
	 6o+/MmddYfTBGp+lFKEiKB8E/A4tJEtfV5LFQDFJS0U+sdpNmuJ0A9adNF63yEniTe
	 lLNq89WNtEsDFR5BwP54LoEMGXfarBlxdMS0r1AOmmDi1KHDUZbdsEUC+w3a8ETjzn
	 Hh3FTvmUHwVTL/ghIcblMWdZ2A4+vzySqxU8Bc4SjsbaoPXe/Gph0q6Rqu5x/vOc3l
	 o3rX7a5cgL58ngfsUAt9qAu2zbhwVYjjt7t7pU5xpLo3f9i4cHgsuPp1B1/naVT+hs
	 MNTIadbk84KaQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 02EF560075;
	Tue, 13 Oct 2026 12:51:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 9C783201085;
	Tue, 13 Oct 2026 12:50:52 +0000 (UTC)
Message-ID: <9189f66d-7ce5-4f79-a55b-f73776c7c0bc@fiberby.net>
Date: Tue, 13 Oct 2026 12:50:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: qede: initialize extack in
 qede_flow_spec_to_rule()
To: Anirudh Virdi <avirdi@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, kees@kernel.org, horms@kernel.org,
 linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
References: <20261013105451.201211-1-avirdi@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20261013105451.201211-1-avirdi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/26 10:54 AM, Anirudh Virdi wrote:
> qede_flow_spec_to_rule() declares a netlink_ext_ack on the stack
> without initializing it. qede_parse_flow_attr() and
> qede_flow_spec_validate() only set extack._msg on error paths via
> NL_SET_ERR_MSG_MOD(), so on a successful parse the err_out block
> reads an uninitialized pointer. If that garbage happens to be
> non-NULL, DP_NOTICE("%s", extack._msg) dereferences it inside
> vsnprintf, causing a page fault and kernel panic.
> 
> This manifests when configuring ethtool ntuple flow rules (ethtool -U
> flow-type tcp4/udp4) on kernels built with CONFIG_INIT_STACK_NONE=y.
> With CONFIG_INIT_STACK_ALL_ZERO=y the bug is masked because the
> compiler zero-initializes extack, making _msg NULL.
> 
> Reproduced on RHEL 9.8 (kernel-5.14.0-687.47.1.el9_8) and mainline
> (v7.3-rc6) with the following reproducer:
> 
>    IFACE=ens2f0
>    ip link set $IFACE up
>    ethtool -K $IFACE ntuple on
>    for i in $(seq 1 100); do
>      ethtool -U $IFACE flow-type udp4 src-ip 192.168.2.$i action -1
>    done
> 
> The loop panics reliably after 10-15 iterations with:
> 
>    BUG: unable to handle page fault
>    RIP: string+0x49/0xd0
>    Call Trace:
>     vsnprintf
>     qede_flow_spec_to_rule+0x2b6/0x4b0 [qede]
>     qede_add_cls_rule
>     ethtool_set_rxnfc
> 
> Zero-initialize extack so _msg is NULL unless explicitly set by an
> error path.
> 
> Fixes: eb705d734525 ("net: qede: use faked extack in qede_flow_spec_to_rule()")
> Signed-off-by: Anirudh Virdi <avirdi@redhat.com>

LGTM, thanks.

Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

CC Vadim and Ido:
As stated in the blamed commit message, my implementation was based on
mlxsw_env_linecard_modules_power_mode_apply() by commit 06a0fc43bb10
("mlxsw: core_env: Add interfaces for line card initialization and
de-initialization"), so likely that also needs to be fixed. I don't
have the hardware to prove/test that it can be triggered.
