Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6160426437
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170256; cv=none; b=iqUu9y7obL1QNDsMJrUf9O46+Q0812rwQjY9TrJ4auBRGk+zOJGCXyG1oAiOi/QbcaQSIqS4wgUHXcEvkV2/pRD++Q4Sye/Qm382QA1TIdfVgvsa9D6+Hp+r7vDfl6nYx4PzKqEBZURpsnX/vG06DS9+4nPsDuQ7rDMcWqONTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170256; c=relaxed/simple;
	bh=Je5rToflP6HDFUwILHyTwGD80qHDZtt3u766+IEEhbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaPTBD3W7C0kw7ueR7czc1XRkW3WBhu8Z8DPT/ae60ioQMpSKD3Sq9nHswVEwZ6g/ciLJPXjzphIoRlUOsv9CTs+IABU60CEtcZreFS8p5Ug/W6osx9EVoz0j73Uk90W5x5JAtaeKUNJTjLUlM99yBfwYwSrXC5n/OwsMV16nXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/mzTCgG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/mzTCgG"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-382ef647e20so2992825a91.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785170251; x=1785775051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNfPUvmh9SATlz6mHMfXelOb20yzwkWrtvzrS+ab4jI=;
        b=l/mzTCgGLY9QQPJuLopMuGDUmXew7tTcMj+24iIXk1wWoDJZrl9X57G6yDXO6apXeq
         oh+lvvK5PNpayIw53/1RJCgb/+UFoyJ2M0aKlDoLPK+kt7Wg63e8v10zAHmZiEWYKSAr
         B4WiRe1GxcX/os/aKRHKCtZihbiDBcijWtsVdtv3/YuZd1iX5sbg8Xbn2+ztAr3oxG8y
         wm8P6VUjPWB1avjRzdm9eT4lN/Idd08l1bcm6ig3sKadkNgEDFTbN+C357vtsvmQo8DD
         O+wg3mAmINtvw2Rqx6mfLY1poMt9MKNkTLLLXdj4IhLjHxfEvIF9OtU2/CawqN8SD+GC
         MSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170251; x=1785775051;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNfPUvmh9SATlz6mHMfXelOb20yzwkWrtvzrS+ab4jI=;
        b=C2YvWhtRtUX5l2iIJmT0u7d5Nn4ygaFn2xGCK1qMDhOCq8gMZVFgZmdWseFaZWq4dE
         AoeShpKYZ0Iwh0aYAPtDqpanCyKXC7N15G5XqU0B2zLdgPBzQvTQkUxP8B2BpYdLNzaH
         uxaI3jOheHlz9imRb+F8pgriiTqGQg13hEMzfPVBRg9t9YSAoo5vYnVPd+VlnPc3sanD
         Kjvi62lGMltlUfUl+HPU+ZNA4U+TzQMeQ9qxBT9WgbckSclKam+268huHd7CSdH2fuo9
         o0I48rzGamw5AGmAEH1/8qBv4zypd7SpiezlFegtFc4OZCOOIsNT1HxNu4ez1Av7CzeG
         5T+g==
X-Forwarded-Encrypted: i=1; AHgh+RpR74B1xF9MO1542AHD5Ub6iHd5SEqOYcu2Am8fRa4BN/5BwfwJtEonqC0ixPoC5kG+vvVAc8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMpF6A/Oela+Y8h79sWOllmEeulB5fps+1FL39NjoG3CBSCWG
	nJPk0pxf1f9/U6q10atJQU8nFkpN2OhRXRDvfLLUnIW93g+aT+VeJRYj
X-Gm-Gg: AR+sD12P0Q9SKBfeRT4yXusW70qIS0LDA+6m688CsSBrhFBHEyty5hp2vOEhSRAyc+M
	0u6eNjeGv4IIBNySp0iI5TnD8LfvYMXr7WyLqBCU+rA+c37PH6EM40E+qI4DANMtIhWRLRBfWSX
	u/Zn+C8o5g+SqsIt+/RIMG9i66VdMuDPi198rEQbGunsBBAGIgLSTA2bLC9cDAtWXAGxELaxH8o
	UMpr0CKS2xD+ii05Ttc+z5B7/uG5DJYuyL7dOCv6f3ybiWGdrJq+fiIL4/8qr5Rvtc5aJs4Qerc
	BqyJcJgU5YKMITgg/nZBHm/XdC8X+8FxcusDuXf2bi0pjp3bGOO63B7OSu1E1kvd+obfgn03yTD
	/pYpqhdo+3JdnN3F3CV+X0AJmHMw96exGQ+zVI0CrUSZK/JsI5aNXV9YcfVl93tYTNaSiqoI+MY
	z0pzj5eBhKl8EQwaDTZ1+wdJ4FO630
X-Received: by 2002:a17:90b:1fc8:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-38f293cd148mr7722475a91.2.1785170251220;
        Mon, 27 Jul 2026 09:37:31 -0700 (PDT)
Received: from [172.24.233.249] ([163.114.132.133])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e6054598asm14951111c88.1.2026.07.27.09.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 09:37:30 -0700 (PDT)
Message-ID: <13ebe4e4-d744-4473-bc6e-2742ac0af492@gmail.com>
Date: Mon, 27 Jul 2026 09:37:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 2/8] hinic3: Fix loose success check in rx
 buffer filling
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>,
 Teng Peisen <tengpeisen@huawei.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Chen Anwen <chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Zheng Jiezhen
 <zhengjiezhen@h-partners.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <cover.1785120952.git.root@localhost.localdomain>
 <9463522667ee175211c12e8ecd7c81a0a55256b6.1785120952.git.root@localhost.localdomain>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <9463522667ee175211c12e8ecd7c81a0a55256b6.1785120952.git.root@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/26/26 11:54 PM, Fan Gong wrote:
>    Tightens the success criterion for hinic3_rx_fill_buffers() in
> hinic3_configure_rxqs().
> 
> Co-developed-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Wu Di <wudi234@huawei.com>
> Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   drivers/net/ethernet/huawei/hinic3/hinic3_rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> index 309ab5901379..389b1c2158be 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> @@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
>   		rq_associate_cqes(rxq);
>   
>   		pkts = hinic3_rx_fill_buffers(rxq);
> -		if (!pkts) {
> +		if (pkts < rxq->q_mask) {
>   			netdev_err(netdev, "Failed to fill Rx buffer\n");
>   			return -ENOMEM;
>   		}

Given the subject, curious if a partially populated ring result in any 
functional failure? if so, then perhaps failure mode can be explained 
and this specific change be sent to net tree?
