Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460539;
	b=kfWbsmFutf+0zDGOjl9w74FOKM472tSS0dN75033uW+kbtds8pDIc/sZ/pQ+qgrDNRg3
	 jQ04ujHRUKIi+GNnKraFUoa5X6JHCN+oopiAyy+4r7Jn1NCVL9EH1Y0D8Cy2wfAaDquEc
	 9eBQJfk+/X1mzpJTFnPEYmFd3jzb4aw5D6eY+WEIeWRgyH0S2UeuQIasUHAseIuZwxncw
	 0nG0nT8QzM/BHkVAzQxpdRXIGEMG0RByStRlNRYRHZAglkSpX6dkbeoNuEkPWgRw3quZV
	 MYUoXVAND/8F+ADyysCp4r7IZfFHgTHHAiX2pOT/HSrA149O2/+ZCnRZcFT+nF6MGSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460539;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IeEKsGdSAXVlfMgTQC5uSxgWQuW4+3P1rJoZ7NuBRg4=;
	b=GalSAqITsUdElirWqzkMRO9qD2kxKwWMG+93pAOBjBPNNUYRYPHFBOd2p01h7lpiXeUO
	 xq5n8gYDXH7z4b/tFhDE/nWcTALqDGH6X9tAAqd/WDQA+kXyoMBDRbINUOx9stPdz/Ic4
	 Lw1YEjHMUx8c4EmlFIXSINTopMLMGP2bmBu2VZ66Qox+OqPOCz18c238hhtLCS6OpM9S/
	 2QlU16wYW2B6d+bVmAnLhGzcjaFvl3sV9ZvrFHZeCbi1C7/5eCt21GPDvMqq9L0pXzV9j
	 hCyUB2SmwR8goycEkk2Ln1Z1FC2l472wuI6wYuLGVWGrufAg2C27i1QRPxgS+h+p+WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIsGx+yo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F16606A31A;
	Tue, 20 Oct 2026 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIsGx+yo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80381F000C4;
	Tue, 20 Oct 2026 01:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460539;
	bh=IeEKsGdSAXVlfMgTQC5uSxgWQuW4+3P1rJoZ7NuBRg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LIsGx+yongxSxhGoX75x0Lbgj5bixGtW6gpY8I6F7nxNVFVRQLAQNbgZzC1/K9rUz
	 sU/xzd1pJw9AewhrRYyZBYkrS11T9bmpllLBdkoqorsCMgdcmbAbDHGAFeV4X8QuqR
	 GeOWfUpPncwj7qBq9RJ0pr9c3pR0RlusHfli9H/tElLtcT5JONisdEpF0div3Z4UUX
	 VhE0pvP8Z+BflqVVXvPwZjqEqJQWol5oB11edhACz2PMJrUZEj+HJ5Sxu7P1Q+BZi+
	 LSSOzo8ZHecrb1cnzQhl/iDIiy8pHWQn4wLYAF/czxW91Ss/YR4eKTSy8BJIcPmJhc
	 xwRDXUVOnifcw==
Date: Mon, 19 Oct 2026 18:42:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Stanislav
 Fomichev <sdf.kernel@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Neal Cardwell
 <ncardwell@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11] net: reduce ARFS flow updates by checking
 LLC affinity
Message-ID: <20261019184218.14d6b8ad@kernel.org>
In-Reply-To: <20261012060152.2930-1-nashuiliang@gmail.com>
References: <20261012060152.2930-1-nashuiliang@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 14:01:08 +0800 Chuang Wang wrote:
> +		/*

nit: empty line not needed in networking, start with the "title":

	/* ARFS LLC Affinity Feature:

> +		 * ARFS LLC Affinity Feature:
> +		 * Reduce ARFS flow updates by checking LLC affinity.
> +		 *
> +		 * Frequent flow table updates can trigger constant hardware steering
> +		 * reconfigurations (e.g., ndo_rx_flow_steer), leading to significant
> +		 * contention on driver internal locks (like mlx5's arfs_lock).
> +		 *
> +		 * Skip the expensive hardware steering update if the flow's previous
> +		 * target CPU and the new one share the last level cache: cache locality
> +		 * for the application is preserved either way.
> +		 */

Honestly, I don't think this comment is needed at all. The check 
is pretty understandable to anyone with any system config experience.

> +		if (static_branch_unlikely(&arfs_llc_affinity) &&
> +		    old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
> +			cpus_share_cache(old_cpu, next_cpu))
> +			goto out;

The last line of the condition is mis-aligned 

> +	{
> +		.procname	= "arfs_llc_affinity",
> +		.data		= &arfs_llc_affinity.key,
> +		.maxlen		= sizeof(arfs_llc_affinity.key),
> +		.mode		= 0644,
> +		.proc_handler	= proc_do_static_key
> +	},

You're adding a uAPI / profcs knob. It needs to be documented
appropriately under Documentation/

Please note that net next is closed:
https://netdev.bots.linux.dev/net-next.html
-- 
pw-bot: cr
