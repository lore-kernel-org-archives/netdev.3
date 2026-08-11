Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC21C5F27
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408408; cv=none; b=Mbx5F2OTa82QsEgfybz/JPf8WE+ixoR0Pk6hfcWX7Orvf5a4ARu5ga2fDxZ5vvR3B20wmiPxx8LXjD8jC8vy518pyVhPIGNvR7KWnfvxeUcAVA+EndHW428KFPvTrCNKjuysrIDzMWJuyhIWsNFL7kJGGQ4xOGjnVEQAMz1i8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408408; c=relaxed/simple;
	bh=2e5YNDU0jVS7U2IK/Ciy5noStkLUGiTVFAUNSy3HUMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXO7FYEPAE3Dn0R1kqQnP8hODcwuidIjtJ+gRBoM12lDmpazjt+EAUmn6jVedo5yPfRXtjCvhyaht/KYm7/Q50gqNLZWnIqFNtN8BZ8SkZt+Uu++rExnVNW6aaeK7x6TaZMqU7iDq7FctRI8L/zJwKsEy/6Vdp8tByXgEGVizx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4191C2u; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4191C2u"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so1016569a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786408406; x=1787013206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tyXmp+nyruHB5drxUnjhN/lNDgAHg9Jkey37bDFf6+0=;
        b=n4191C2uGkxkUGXwusO6Cx3lU/u/HLTzhcgWF0De61Gc6046gNlksVBAObex0BvORa
         NE6XoyMbvi5WYQ59VTpsjm300S9jsPUTIhyE2pGismpZI35LydKXmqqT4osJVZEvvgTo
         DfAlA7OeW8xuRd7q5Eva3CHB2eOzVIk/6FZmeOksTEZgLJKneSDloWhXhyg9jm/KDwQu
         E+a6cI4hrS/K4avkKlPttitz267Hty+S8qDbiK517EE0iFFzrGM7FRHvwN8iE+kGhWQN
         f7rklnkoSeuC++ob6B4ddTYEVSRwlOVijji6lofvzW1c3Eb4K7kd+9lhUD5Ynf3iOlb8
         baFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786408406; x=1787013206;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyXmp+nyruHB5drxUnjhN/lNDgAHg9Jkey37bDFf6+0=;
        b=m+mWHpRBfOxK2236G/iHyriQEz+aWi8SyFicXbMDdmIRng1RWSbm+y+ESq4ZxVz5cT
         cwsd8n+r/QpDYDCfB688kdHj34dN/S51Gf1ZesFT4VVAB9M28WM0NY1SExmA6SNntFv8
         6fv1oScaNxGljXUUpYa/QDsp4BwGy7fyt3SV+kSkaRnuaVPMZnNa/WQdgF7h9fnwrvRz
         S0+s3pZRop51+rjBs0540KUu8GuvB/2mpRWX+H50noZ5/6UxTBdZvWWu9+KALDqB3S8B
         jTg7AxtVxm47W3HVmLF6Hhst9hQEWFBGCbO19SzV+Btk0jlLYJnxL2GK8PhwQ6tof4lD
         PIcw==
X-Forwarded-Encrypted: i=1; AHgh+Ro89Fw77QRmdZDjA8FRdwsYYFRUa8ez1BWdlxt0LVYzxGirg8JKgTAJf3Z7kkz06GkmAOkPmeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpfzLV41dkxwOxCmb3VpJtzsWRmoHMDlE/jymmmsXSGB2X/3gS
	TO3gGdg90dklSKHCnCGpyOkTwN85Fj4lOGvMfYq0Kniqv8v0ex0kJlqn
X-Gm-Gg: AR+sD13UAnNCJl+FeD8+8Q1DbKO6rUIbSNsR/NveUdTUj1daX3zkbZ8Apz7xfTaA6/a
	OsVJkezteYKkqOdhHtPFvhY9rZKnqFIqt/zpM1KueTp3ksqYuqmiVHOjFdHDTnRumDHZE+DYNIA
	EJxNPv5Z/3pVakmMuTmevpDjk7/Xjj3pHsm7X4jm4IaqD3Yo0zkvPXFmpDccPhDsOyK5nluq3N3
	+XI83trqxTd31UXKA7ZTJ49Zn4ZNOAqcD5kSTXclJ55G9n1IqNHpipQmfkLc9zj8pUyhc/gNE0V
	x86CXXRULR/78ONzlCTuPnv3DNeQnL36x9jRwgCQLg9dzYDqfuXBECQLznIBUNGTYgw7UgTtRjj
	rgRT5kcyv1URijBIGARZEJA8hc0rX71XLwZ3UQeCWDCRo6Ut6k+6I59PSHG4A3U6liri6JfCWpL
	5Iu2p+s0J2fhiJIaRF9WExeQgnKphBpU0pcdn+vhXGux3xooiFMcSbHD9CR/PDOc1a
X-Received: by 2002:a17:90b:3847:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-3909d89bd69mr25756524a91.10.1786408406008;
        Mon, 10 Aug 2026 17:33:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d4050736sm1312465a91.4.2026.08.10.17.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:33:25 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:32:36 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Subject: Re: [PATCH v2 2/3] nvme-tcp: support IPv6 traffic class
Message-ID: <anptYps5IoeGDCnt@devvm7509.cco0.facebook.com>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
 <3f5e4c84d3fe41601b29468fa4128d4639d56685.1786171863.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f5e4c84d3fe41601b29468fa4128d4639d56685.1786171863.git.tanggeliang@kylinos.cn>

On 08/08, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The NVMe/TCP transport needs to configure the IPv6 traffic class on its
> queue sockets, but the fabrics option parser currently has no corresponding
> option.
> 
> Add the tclass option to the fabrics parser and store the validated value
> in struct nvmf_ctrl_options. Negative values are rejected, while values
> greater than 255 are clamped to 255, matching the valid range of the IPv6
> traffic class field.
> 
> Keep -1 as the default value to let the transport use its default traffic
> class.
> 
> The fabrics layer now supports parsing the tclass option, but the NVMe/TCP
> transport does not currently advertise or apply it.
> 
> Allow NVMe/TCP to use NVMF_OPT_TCLASS and set IPV6_TCLASS on each queue
> socket via ip6_sock_set_tclass() when a traffic class is specified, keeping
> the existing IPv4 TOS handling unchanged.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
>  drivers/nvme/host/fabrics.h |  3 +++
>  drivers/nvme/host/tcp.c     |  8 +++++++-
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ac3d4f400601..643c03dc7bcb 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -695,6 +695,7 @@ static const match_table_t opt_tokens = {
>  	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>  	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>  	{ NVMF_OPT_TOS,			"tos=%d"		},
> +	{ NVMF_OPT_TCLASS,		"tclass=%d"		},

Do you really need new UAPI for v6? Any reason not to apply existing
NVMF_OPT_TOS to ipv6 sockets?
