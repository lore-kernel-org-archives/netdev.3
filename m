Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FFF3148D0
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777657854; cv=none; b=AycSnj7aJZ4YEC/sxZbgznA3+CmyKIdBa7PHKk4X4+elX73TzN45gl0IosuGZN8YXFmyEcp3KHgjS3fZSmb9ZCgl+j2Pd/i9pz7w89IPrH+6kK+NMRbPkSTBGdUdgejJh4Fp2HoJsqpKmmvov0wx/vaUvBYVVzTJBNl1Hn0xro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777657854; c=relaxed/simple;
	bh=Tm7Ki/8gPhBbQKXRdFQiWtgv4Jc4UPbBLpslramC06o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCh/Q9Ts5KBXSxsF4pWLNEKdtG02PYIluviIjgzOTFUgsu6VZeffKOE+iZuvNdr6E6ZaXxmMtrDYBA/b07AnCBja0N+pUoZOHVoLjkNAF4VsntXPPtcR1eArBSWsfxQjR9TIR14dAeJm7Outvs/kBGPUaXln6qbMZCwOIs6zdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtXPQ0wE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtXPQ0wE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE1EC2BCB4;
	Fri,  1 May 2026 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777657853;
	bh=Tm7Ki/8gPhBbQKXRdFQiWtgv4Jc4UPbBLpslramC06o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rtXPQ0wEvMnk/j9iO2/YLfwZ5oUZOdbYyFxivCa60E/uZ0QBoiaB8jetk0z/rpNL9
	 ab9owfsML+KR4mekgP3GrniulpPia4l/F77Iy7jjNEqyhCPW3bvuE/5pveHpP50+yp
	 sV+pDY4rvYg7KL2oriLfkoMji+e0AnyjoFrZo+BG0OBSRopQ4kByrEZilcRdmWvlaC
	 Xf1JNFPJxDUShAhFYBFmS2I/P/5MxYLRQ5GYDjSfOv8hWduZX+S/5qdjCZeyFH0eT+
	 8io4UicqGYMBSBQIchOMoCDPg2pS8dlW5HPxj0LoYWfL8+xFwL8QfksjvkXkwKt9bu
	 5HphXgpiKUroA==
Message-ID: <3af3dd7f-bd51-499a-a484-5fcd9c7e4304@kernel.org>
Date: Fri, 1 May 2026 11:50:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/5] netshaper: Add bw-min and weight
 parameter support
Content-Language: en-US
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, pabeni@redhat.com, kuba@kernel.org,
 ernis@linux.microsoft.com
References: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
 <20260501011611.3533573-3-mohsin.bashr@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260501011611.3533573-3-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 7:16 PM, Mohsin Bashir wrote:
> diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
> index 1603e6e5..4ee30525 100644
> --- a/netshaper/netshaper.c
> +++ b/netshaper/netshaper.c
> @@ -33,11 +33,12 @@ static void usage(void)
>  		"OPTIONS := { -V[ersion] | -c[olor] | -help }\n"
>  		"COMMAND := { set | get | delete } dev DEVNAME\n"
>  		"	    handle scope HANDLE_SCOPE [id HANDLE_ID]\n"
> -		"	    [bw-max BW_MAX]\n"
> +		"	    [bw-max BW_MAX] [bw-min BW_MIN] [weight WEIGHT]\n"

natural order is min then max

>  		"Where: DEVNAME         := STRING\n"
>  		"       HANDLE_SCOPE    := { netdev | queue | node }\n"
>  		"       HANDLE_ID       := UINT (required for queue/node, optional for netdev)\n"
> -		"       BW_MAX          := UINT{ kbit | mbit | gbit }\n");
> +		"       BW_MAX/BW_MIN   := UINT{ kbit | mbit | gbit }\n"
> +		"       WEIGHT          := UINT\n");
>  }
>  
>  static const char *net_shaper_scope_names[NET_SHAPER_SCOPE_MAX + 1] = {
> @@ -125,13 +126,13 @@ static int do_cmd(int argc, char **argv, int cmd)
>  	GENL_REQUEST(req, 1024, genl_family, 0, NET_SHAPER_FAMILY_VERSION, cmd,
>  		     NLM_F_REQUEST | NLM_F_ACK);
>  
> -	struct nlmsghdr *answer;
> -	__u64 bw_max_bps = 0;
> -	int ifindex = -1;
> +	bool has_bw_max = false, has_bw_min = false, has_weight = false;

can `bw_{max,min}_bps != 0` be used instead of a separate bool?
similarly for weight

