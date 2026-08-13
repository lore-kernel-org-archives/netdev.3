Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568A476CF1
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637006; cv=none; b=dAXD4QARZNPLJZcAtJMCoxe9CI//LkwGM8R31+EY/J0NqQgSSsYUKWiSYzGIVd1GpsHU7lE1jJiSNdEzHLcteUPuNXj+klS7m3Ym6563vDauteltxd9PXjOjquv58jdQUtGMsi8ZnLNzpfGm9n7fefjmBrMHxn0pgxoPE5c6JCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637006; c=relaxed/simple;
	bh=tGW8H0Bs4+on5IqD0IFRAmnYT9RMnIJA3AouDvKF1Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwMA0NRAA+o3lPExv/9SMRsXV+qpTwxn/F4rh/wh7qbPQAVRBBNhlrH+dk+lUCL4aEourR2N+NPONwCwjcjbYj/GIX95w3g1WcdXDBczr8kGQRT1GIX+VpfiuaV6X2V3NqkhlObDjKc9xkXBR++xcRp8TVUPXpqJaqWgXau5qJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=f8R6Esgv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="f8R6Esgv"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1271189f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786637003; x=1787241803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HcIVgqoIjG/Kysz8GTxN+rZ67417oOITTJ2c+FLUd5U=;
        b=f8R6Esgv9sLGkqh4etqsOgtRkxbWzUynkDmOqW/E7ROmm8v39vp/lXg45lSzd/5aW1
         ADvkZs67NQ4vBpAs2dMfbK52CSaGDFp1lBmrZjaavxoI/TzNkCL0TnJeCWWuBoaEG1EW
         iFgk+6R7OKlatmb3eak1cWwQ/ARJd8XCKKBUmgHD9Z3BU1McLQJYZD6RSemdiNtJz7gQ
         6YVUtjWywbzDIWJMpptzBpjE6YYgtu++IJPNNRPUIU/jD3ezn5W8K3XWXhK86i4VRl0B
         7PkptvT13fo1uaoZH0pZ1SrTOWAgMDT4IFfJgpbXg0b2udQ6TBzGW2ItO3lN7EA2XzIe
         TqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786637003; x=1787241803;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcIVgqoIjG/Kysz8GTxN+rZ67417oOITTJ2c+FLUd5U=;
        b=FlHaHXCfFe4zIjPJwfEouisN0VWFCf+FgziKOmml6ZyYLtmS6j6jRn1ncHlD5OnS7o
         96Kane5uu/aoX3/uDIEtwDQnUX1i9DKNd5qUhWQpdADzXb5FNoxx1YqojZCNKQS59Nei
         oQID7QmHufYxCc4LdzQ4vnkk7DfslwrkNJzj0E9se9ILk7kyga9K7qJivAOwOXphdGIY
         twlFOxHxseJS0KemZ1tZUUESjTQ1OSgdtAiOeW/t/Z+rHohCO1biiHrOA+MOAToy9YZ9
         HzhulMko05zhVJoyzh24wUT1NhQysm9qQ7v8mpCC2M3MvulPXlOVXTMD1gUtbpDgKWzI
         lkVg==
X-Forwarded-Encrypted: i=1; AHgh+Rom2AuMyTAAtcdLnkSjKrakzr/vB6xdWrW/f+8O2741jnINx+iaQ5qn9BzE0Z359t+1PSqRzSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlz3Fp8LlwpawfxjddAavWavHSMHkd8mb4+8flJMdZ3F8BuO+e
	ZPTK3NRnzSH+xgcHffs1wEawcb66jzKuszkJWxspRSE6lXFNOfwnJ3SPtj/teFbfsL8=
X-Gm-Gg: AR+sD122ECoeu6fMzMRtLMnAQQAG9l8cvbjxrsc8roo8M7ziyYs1VPZ4OpTQJXBXvtW
	o/yp7xEDALJdCgyxDpc8q8PcV1QnLmbE6r/DrpAX8P6YjNdzT/tfLWzxRuv00B7Ufn0xF+RLDcU
	opEuw4Uy0JJjqe4HIPAqWokbfHGFyMfxPhRydeWFmz5WnK0kDe/uk3cxu9h0RbGQ86qIt3qfDk0
	n7oHHVyF4s8vgNfinotWdas0Qej/FGgW3ibQfLTN3D6Qj7ifWDj4KRDh82QkIbuQ/XF63H0WlWx
	6U2rnNBIyZlCMuK2EX2EnrZQV6iZCWBnYLLb4lkiu+VEim3UGpAuecLnQ3Tfasl79+Y/HCcSLGm
	SAW+AM2ExhG5Nx83NeW52x1wFPgueajFUcQ0iHaQ1syQi6RXQYabsSKLFNHTOKmCOSBh7g6s2Z4
	fv6w3E/fNYPTNUPZSl7EnyXieIjXJBXCpnlTH16FnWiRVnarAkCjBIC1QS5GbmVS9S4QALyKeie
	LTNKOn/lLj6aB4ssaM=
X-Received: by 2002:a05:600c:8b16:b0:499:491e:4b0d with SMTP id 5b1f17b1804b1-499821ee720mr79051765e9.19.1786637002439;
        Thu, 13 Aug 2026 09:03:22 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b6abbcsm76682155e9.15.2026.08.13.09.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 09:03:21 -0700 (PDT)
Message-ID: <4b095542-6656-467a-93ce-4a39c6c80c46@blackwall.org>
Date: Thu, 13 Aug 2026 19:03:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: initialize err for empty target lists
Content-Language: en-US, bg
To: Ruoyu Wang <ruoyuw560@gmail.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20260813153126.3952893-1-ruoyuw560@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260813153126.3952893-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2026 18:31, Ruoyu Wang wrote:
> Empty NLA_NESTED attributes are valid, and bonding uses them to clear
> the ARP and NS target lists. When either target attribute is empty,
> nla_for_each_nested() does not execute, so err retains an uninitialized
> value before it is tested. The request can consequently return an
> unpredictable error after clearing the targets.
> 
> Initialize err to zero so an empty target list completes successfully.
> Non-empty lists still propagate errors from __bond_opt_set() unchanged.
> 
> This issue was found by a static analysis checker and confirmed by manual
> source review.
> 
> Fixes: 4fb0ef585eb2 ("bonding: convert arp_ip_target to use the new option API")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>   drivers/net/bonding/bond_netlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 4a11572f663d31..87d92d3cce4a88 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -220,7 +220,7 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
>   	struct bonding *bond = netdev_priv(bond_dev);
>   	struct bond_opt_value newval;
>   	int miimon = 0;
> -	int err;
> +	int err = 0;
>   
>   	if (!data)
>   		return 0;

Oh well, I've missed they can be empty. :)
By the way you haven't CCed the Fixes commit author (me).

Thanks,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
