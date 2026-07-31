Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1040443A89
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512714; cv=none; b=nHHI1FXNRMyUmMOvXmGOt7MeE1vCLIa2ceX6r7MSOtvNRFe3Xhcc4xDjQHX483MFmd7+XJb33ZlMFdjjDug1j4UdfNR35zAUPE2w0QSF2+fBGwhs+7Ly5EquQCfXXr+dHSRnMt56OS2S91tYDleJbwC1Q6ndssRtYDQFVwTuI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512714; c=relaxed/simple;
	bh=QljyVPFlAv4h/ZzcE8C+5GE8/id8T+aE6aMhZzBAF/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lt765kq3fsF+q1eDyPnvAKvp3HDih87TntEgvS25JLLb3vx5wcqzTM4noE7ULxBG1gIK5TjV3v5kIKhYg10ir7yza/3zDYbhKJG2IvcP1yVIAVM2I1guGJGznfBrJEvsxKhdXMhAzgHzqttl0r1utc2RllKI5FLllXLK2GX08pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3QvJhLH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3QvJhLH"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so621050a12.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785512712; x=1786117512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTr+FVEJek8HJ3HeYCgl63RHoNH7nCzt1TWIIYAYrB0=;
        b=n3QvJhLHSax0EIgAg31zVsyiaA3GFTOThr/sKnIwk1AlNJYzy703rz1ByL5pGsEAAb
         KnZNUfLuX28RGcJq3klfQbDv+JPv7DUVp0L83hTf/3o992ceY4u/wQo3H5vOr0f2IH18
         G0h1/U7AIBhqotS6F2zMBzIhCCFUugoMc5L0S4uSBe6PPL6XReLHlCwndBE+21iXW4YZ
         SHaU3OnRa70Qfkcg/aadOPBOhtqOh6IBWEpKKM844v0RUR8DY81ig7B7mZqk4yeB0d5X
         hXGSY41kXXDS0RyvRvgEIV3pWLYXfsB4AAr79YNlqOTBYhAOxTzep2yj9yWU6Y9UFn8v
         w/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512712; x=1786117512;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tTr+FVEJek8HJ3HeYCgl63RHoNH7nCzt1TWIIYAYrB0=;
        b=tXqkxobulSDCJniYYL1KFKNLg8Mmp5Eo6iVTkj0Ir9bMsmTT6P8jsHnUQoVQQkRUDU
         A6N9Aid+0Wri9ZfG/zxzW8GFqzuKcLpruSHs27KgMIYzmOj55UAiBf/7OHENOtut/3Hf
         cfqISTZvwvZ95iY4sA2wwJkcQEE7NnBxwaG8/tv1TGp449NfMamrspYFwhV4xSFWulbn
         uhe5zYzWcDw3PR1iA6rIBtezAXLKN6lrP+VOWDZ4cibNlDUfXyomy2UqNdf97tKHhHrJ
         9HBVyu3gDrAvvSWz9bFq0EjzLr9HAkDXQfbe+L6g/b7PqI/vS4rCtJxiV4MwD5+82Smp
         ZGBQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRj+9z/dAWxQ7DpYIvk3ff8IXTl0+R/SJ8K8oR2wgNeWECjC9TAifDyI5E64rTYKF37Hrr+o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCrfPftBAty4dxcyqherPI9TWBChUu68jtaydgQS9QW7fWqzy
	3tKXHjvY77rqMQazRdEaEdU+MeXJmkMaK40gb8ljxbd/Aqz3GPVXgFIS
X-Gm-Gg: AR+sD11wqIgJc2qvvxpHnrXEcbL4lV/qLRbUQ33uNlpbpkflcVtnNYIDybUXMgM4ReH
	MISBBiJgHjEztBTaGdNedol/VZAAhYUJj2fqjbtiExngy/zsfXS7TL+FigN5d3PZBfe9FI/uU56
	L2voKsvmspQWWGA2TctxPJM/GFySADnG7+Uivl2rrdBs0BjEkZiNwEitwZCa44YC5mCWB9H8Hmr
	p21kzXzL414gUPJEPzL7dFgQvbkyNyOay2W9AvMWV7WELTVLrJR9NQAF1bTJvhyWue10Sl8+Hhl
	amFo2eheaZ5IUPyz+rejTJeCe7nU9AZ7I5ONHrd/imh42UiMiZ/KJzqpH5ZKp3HUrYKEzQeZLLy
	2Y+PXfqw2aqRxJf8NY/yL+BzcIO5pvlO/zxdeBK71mC3Ox3l5geQ+TrKvcxV9ZKLJj0O4dqJN2N
	N/xcYqGOmPG3RWJAkxZet0imFpmlMuWq+EQV1UQ7/6y+Ai9gO/t2s1/VLiwOjoqOnuDd+QtucoD
	2RS3rob8OO5f7wNna0y+O/JjTXjrOCVAeks/2Xl3JBzc8ok9Jb7n9V+vTg=
X-Received: by 2002:a05:6a20:6a21:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3c92a75b25cmr258440637.8.1785512711706;
        Fri, 31 Jul 2026 08:45:11 -0700 (PDT)
Received: from ?IPV6:2601:646:8f02:5350:ce4:701d:f6e3:3a6b? ([2601:646:8f02:5350:ce4:701d:f6e3:3a6b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e29a126sm7821146eec.31.2026.07.31.08.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:45:11 -0700 (PDT)
Message-ID: <6fe86a50-34ec-45aa-b2b4-52429a72369c@gmail.com>
Date: Fri, 31 Jul 2026 08:45:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: fix skb length accounting after generic
 XDP frag adjustment
To: Sun Jian <sun.jian.kdev@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Krishna Kumar <krikku@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 maciej.fijalkowski@intel.com, stable@vger.kernel.org
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-2-sun.jian.kdev@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260731032357.6114-2-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/26 8:23 PM, Sun Jian wrote:
> Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
> XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copies
> xdp_frags_size back to skb->data_len but leaves skb->len containing the
> old fragment contribution.
> 
> After a fragment shrink, this makes skb_headlen() larger than the actual
> linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> copied 1024 bytes past the actual linear tail to userspace, starting at
> struct skb_shared_info. The copied bytes included the affected skb's
> nr_frags, xdp_frags_size and a kernel pointer from
> skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> amount and truncated at the end.
> 
> Subtract the old data_len before replacing it and add the new data_len
> afterwards, keeping skb->len and skb->data_len synchronized.
> 
> A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
> 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> corrupted payloads. After the fix, all 10 runs matched the expected
> payload exactly.
> 
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>   net/core/dev.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5933c5dab09e..5c37cf6c4aa1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5517,12 +5517,16 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>   	}
>   
>   	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
> +	 * from skb->len before updating data_len, then add the new one back.
>   	 */
> -	if (xdp_buff_has_frags(xdp))
> +	skb->len -= skb->data_len;
> +	if (xdp_buff_has_frags(xdp)) {
>   		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
> -	else
> +		skb->len += skb->data_len;
> +	} else {
>   		skb->data_len = 0;
> +	}
>   
>   	/* check if XDP changed eth hdr such SKB needs update */
>   	eth = (struct ethhdr *)xdp->data;

Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
