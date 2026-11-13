Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562504;
	b=3zOFLvurR86j2aJSAYkgC0gbgqh8pLf/F6MsxGlmEoXtVN45L+FkjYnx5W5tQ7rKY2wN
	 FizNWLaIpCWa2kU3N/0ONFJacTjZceJk+hD4LkvwN5EC4YMSSjegIfpUeL+ZJHXi7kR9F
	 6GExOdWottp6Gip5byWv7yq5F+6UuJ2Rtkg3uGxpk9Nbdum9QnJvevfWQF4mq05NAoSE9
	 v+ScdA7QnylzRNGOvj/sUqS/KdiqXE4dIQV7qlBsyFtBq8O+bDwrjDb+VRInNxiLvliGO
	 MeLvqUMc8801ZqvwjQujpBIdp0YSfD68tRzUiqnJOVpe4eJyTRDZT/QDo9JuSqpw3Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HLpFxFV2+DeYoeNo+2l0S5ig7yzJj+j2CLA0UDSJuRk=;
	b=S+mkPXOEJGLhS3FI50yQLp2xqFyDMLlG4lYI3LIzsxo1esU6yvJtdpVilCPdjMot0uAS
	 Le/Ih6H95WOh2gXGumMNOcUAHJnqN8z/AcSxdO8CYwfPSDD2+3A/qpRRdpAmi8xgrEMsE
	 FYS0WIfy5pKJwgicXDFZDJdibpNM7D7rSZVHMzLE4soy4To4nKQXlwU7/Dsz5dmYaNOcJ
	 9gdMaNoLsojWW21FBKeMfvRNIl6hiJTIXjyBuh9Br9oKOxO7qgTLSKy7+HZD2ITvcR7lz
	 epR/4ExCvqt5gL+0OCoGcylUFejiXuwd82ghHXiPMD8IziYJZgxuCtOESZHpPdRVZLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=NGZWA2tK;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B2606A321
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 326B2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=NGZWA2tK
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b467581b98so5267185e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1794562502; x=1795167302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLpFxFV2+DeYoeNo+2l0S5ig7yzJj+j2CLA0UDSJuRk=;
        b=NGZWA2tKwva4j+AVvbkJVVz1t8koSkfEsI3+OknrUtp00Mk74/XUXZ/MP7cX8zO8Jm
         qGSlO/T8oiQN4q+xlv4Fukt/2eA8DFfksqPbWKf4VWIpegjZnTwjuSBWZMi1kkkYenuW
         cLO561d2+crsPusUQSBQetTYYh9LCw2jnmB3F13R9bJOk9IS28VNUcSjl2SNIdYYSSpY
         byXuUOaSDP5ZU0p2O6HJESMjlQTQq4BHqzgR0NR0LwmUURBQDD2rPdxQ6eGbQhZr/soh
         1BXfF6ZnNuJtxmG9E81DOY04wAGdJIfcwSb04hejcFfOiqTBSPGdHphQ/RkzFVi/Q3oj
         IISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562502; x=1795167302;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLpFxFV2+DeYoeNo+2l0S5ig7yzJj+j2CLA0UDSJuRk=;
        b=QX7HvVWXKDNR2L5Nr9IsvVLUCoWXyt/KBZuvrGhladhIvJAgf20LvbgIeTz6uQTlQ1
         0VrbCzgw8c6urNtM19WWLVMijQ1ZCMZG6g+/JmIv29DD6uVoBLYvfXvvriDrMwr+fi+T
         d6g+lgxp0kOyvjstBtRFL7C/G/XihP/iaH8rO6bHzCtMDZKe04LJ1oH3FWKIM5uZOMNK
         ILqmrzidW8YXyeBYeMz6CfqxEGeI6JB2pO+0X3tjY6cuuIUnPxL5KX/z/a6lh5I0WWFu
         5tdKvQN/OxoUFFTFjl+kpzgUgI4mk83AHLGrjWgaJ6sLGtQtaa6+hJqZH4vGwg7oCU50
         cY/w==
X-Forwarded-Encrypted: i=1; AL+hErFxKVDqPDK750rIvospx+T21SlNsZZP+yfI3M0dunRRg78pMM3gjCjIT1QWs6gcIE3H9Q6smAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZWtEUNJp+a8BQLv5JC+PXVnapKYquUEhncEF7rtUn0WnDDnPK
	Zkm+Rp1SY6xU+Yz9Fa5geYjx05KeQP8DymZMUC19ihlphXNEdVoAfCy++dKVDvUA9/U=
X-Gm-Gg: AYBFou24t+dQtdf1OR5T6sMV7PrqN4884tOKRJ2SezuKLTJDsVblW5JMy1pNI1hU5zN
	VmmKvuDnhgSSqopRFAQt2QE2LyIpI7hzKrcWDPiCEReiXUMLNaq2kugPTzoZfLw+qsM4HKdbTX8
	WEIleEj1nWoje0oHgKmlL6iITzT9BY3E3uKDvWaiBD9Pk0Gj47jau0vsCachQDXd+yGmlUvetU5
	MirlITizbHLanclx0oSzZa1PMhyp2XYIN81Zksj7tt7aDkdyCndmCBQ+jyNz86eY6UGqXiS8PxD
	9FZQrVTXiP57Bv1jTF3u1+dq+gPQePns1pVqOfdcGEP0R4tXvUoka9M4iAiJGUczfNP9ipmoNum
	SepyjJudxFkBk7h5CYlmrlSsMy+jf8H0MC/u266bIRPW/kkGHrbHogiQSfb6m34juAj/626u+jD
	rek8pRdkAHGjzUmggret3cYPss4xmZW9kDo8Zl8DvV66WgYR5+jxlpEsTPGY+Tx7XAhxCURhSg+
	5cQ3VKcvKGmji3Eoagukc1unDno/WASKObkTi5btTp7h5xUn/smICW2FGkZEUz5VkzNV02pmgoI
	A9XgeDFBVgG+CFau5WIZENlq86n3KK168yA05AfSo0qsCvgwnc8jq99HBak=
X-Received: by 2002:a05:600c:19d2:b0:4a1:a45a:88f with SMTP id 5b1f17b1804b1-4bb55ab27afmr33443265e9.20.1794562501867;
        Fri, 13 Nov 2026 01:35:01 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac1159sm44033605e9.4.2026.11.13.01.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 01:35:01 -0800 (PST)
Message-ID: <47d7b86f-3a82-41b8-a769-6d115f0aee00@blackwall.org>
Date: Fri, 13 Nov 2026 11:35:00 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] bonding: 3ad: Receive packets in COLLECTING
 state
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 aahila@google.com
References: <20261111171947.2816258-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261111171947.2816258-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2026 19:19, Ido Schimmel wrote:
> When coupled control is disabled, a port in COLLECTING state is supposed
> to receive packets, but it does not. The bond only delivers packets from
> slaves whose 'inactive' flag is cleared, whereas
> bond_set_slave_rx_enabled_flags() only clears 'rx_disabled'.
> 
> Fix by clearing 'inactive' as well.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>      Targeting at net-next since this never worked.
>      
>      Known issues that this patch does not address:
>      
>      1. Changing 'all_slaves_active' from 1 to 0 while a port is in
>         COLLECTING state sets its 'inactive' flag and the port stops
>         receiving until the next mux state transition. This is not new,
>         COLLECTING is a transient state and the option is off by default, so I
>         do not think it is worth handling.
>      
>      2. The 'inactive' flag shares a bitfield with other slave flags. The
>         802.3ad state machine writes them under the mode lock, while the
>         'all_slaves_active' handler writes 'inactive' under RTNL only. This is
>         not new.
> 
>   include/net/bonding.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 598d56b1bc97..cb89aff437f4 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -594,6 +594,7 @@ static inline void bond_set_slave_active_flags(struct slave *slave,
>   static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
>   					       bool notify)
>   {
> +	slave->inactive = 0;
>   	slave->rx_disabled = 0;
>   }
>   

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

