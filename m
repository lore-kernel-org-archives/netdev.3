Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788A4AE8C3
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931867; cv=none; b=cngBS2dweMAaYzJ2StlXm0WikE4AdLC/bKbuhaaWpbKLvrEVKfFbZUuSH6L0+EgrGa6rPTu0SCVzo4wXRTFSU6FYE4so3G+emI6ctiZ2aQRSw54DkGBQLceMPRxm13GyNkSNOAA2cFg4RqrGZh4+JNiBfNaZLnG6uypZUwuQyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931867; c=relaxed/simple;
	bh=ilYrMoTlsg1Y4InXOxpgZzEiE2/mJCDjKnkWIYMjQ0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdfUDFvlPTTGcgBVEd5GtGk8bozx1fu9b/D/kW7QZN/sdax635eSRMSKWq5ykM0N7svNLeY2HG85L8w2+HmmW0rNJdVWHNZRU3ThJt0ZhWS8O0ymzBsuVLHcnKmBybSwAZ82xptF2qNg0ZhhxCFgVwoeviZYqEQBFO2gIceiH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FxS5s9VD; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FxS5s9VD"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso1961779a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 15:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931866; x=1792536666;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=szv27faHJlz2tiNM/SyqJqxcXqx67aJHGdSyBn7hfgA=;
        b=dAj8+RC0vYKlvcTmCCs+ZQJgoqlDSgmO/ZWXZcmndlN0loJ6aSxHd9ZiDU3/PA8GBv
         iSsL45LfJKgH2h4UmJEnCnQc2dIuIfh5fyYxuQIKuY5lhUEYkmjFuLO7JCR+0CKLXuL2
         IOkpgWUaEURmrEKa/c6IXADPbWOqvSADNnsXQrd5sgtqEPRy8Cf41DSO26Bgn/zd1EPS
         lmL5AcGIoGDheb9IQzKuCYkr3yHthr1skrlj0pUiqDfxuZ7hlifqIpLoDV82Syl/4UgI
         t9joxgpLEY3ulu8fryhoXjvmQ8pxE2FDVBGE90oSME8rKpH2Gpl9IxbooaVw+SpPUO7Q
         HWeQ==
X-Gm-Message-State: AFq9FYLKF67a7R5iU0Xat26LP/44pllclMrQG9bm8UenCcPT+uLWKwZl
	tb1SsYppU+zGm16jd3h0yJMWnqGfSApkyt6pO6UEnjg6FT4CMvKly5+OUkUL9uxH+dd0+M1y5dC
	59kcrMkHAvZXB3htlNvDFBkU2kFeXEr5TlgUOkX1dU2HS/p+cdbBKAE8wE0I2kRZoSW4lFZCrjX
	Cc9sSNnZQtDCorbEjEu3q7EBFEtS7BcUYeAY9mjE7bzjm/wf6a11ZL5aEza1EwQ+XS8QNjSW4G9
	P9HhcqmX/ttGbOn
X-Gm-Gg: AYBFou3vDy2FnSEukxSSnXsromWZ6mM+EHYnigsxr3+vjDYNe6myrJJHp2sk74uQ6YG
	DPYmSc42EJsRewBGbt2oJBkBTpjmWuEgNm45Kirq72qwDpqi1PkS6DsY/4wd3+aPAkctEz4DGFA
	ZEkqXOdVzLvB4JfiCx97jGFfGcWtbqQ+qHjaj2WrW6wenArIFzTvkv7XB+kDGn1JK5OK3l+/AOt
	gCZbpjY7kXw1gc0OGUf7bnIaX4vdRxJszwwM2HO3jgCru9YC6hcLsdTl2umO44kNe4pM5l2uVRg
	6ktlwFRROZ6klEXJhrglemmuZUFOeQhZnpkBl7t94Kpm0DwfSESY9BRleXNdYC7AW+oUD8wt65k
	YbAF5YljBeCa+QM5ZC/XVeaD2SRQkFqORx+ngAp1kGA/m2lPOHS5r1NpUllsZZ5csw6JAZRP17T
	xwxxifW/LbiYkUPJGryMzZNSnuuiOcnR6MrjrrAmmpvME=
X-Received: by 2002:a17:90b:534f:b0:3ab:2d17:51d8 with SMTP id 98e67ed59e1d1-3ab3a99f162mr12185602a91.37.1791931865675;
        Tue, 13 Oct 2026 15:51:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac5f1a18f5sm512971a91.4.2026.10.13.15.51.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 15:51:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5350ec54bf6so73165111cf.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 15:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791931864; x=1792536664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=szv27faHJlz2tiNM/SyqJqxcXqx67aJHGdSyBn7hfgA=;
        b=FxS5s9VDMYqTPrRA4dvgx5h6tgSmwOD39t2o9gfw3XO/s+oreFrETMXhc2noBg2xHS
         i+7aAu7ohQPEsx/Tee0Pdgmt9sw34HIlwPxTnOKwXOfnoXzlUmjjB5tKui5ixpVyocdS
         ohkYyg3XC5JuTGOONnt2CpsACBkTodqLEJjKQ=
X-Received: by 2002:a05:622a:e155:20b0:533:3bd5:b6e0 with SMTP id d75a77b69052e-535fc0e45demr17287661cf.59.1791931864166;
        Tue, 13 Oct 2026 15:51:04 -0700 (PDT)
X-Received: by 2002:a05:622a:e155:20b0:533:3bd5:b6e0 with SMTP id d75a77b69052e-535fc0e45demr17287541cf.59.1791931863745;
        Tue, 13 Oct 2026 15:51:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b38700sm37093986d6.11.2026.10.13.15.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 15:51:03 -0700 (PDT)
Message-ID: <e0f1afe8-2470-4f76-b612-fa141a2d21e5@broadcom.com>
Date: Tue, 13 Oct 2026 15:51:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: unshare the skb before writing the
 control block
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/9/26 03:10, Nicolai Buchwitz wrote:
> bcmgenet stores first_cb, last_cb and bytes_sent in the skb control
> block and reads them back on completion to free the skb and credit BQL.
> ether_setup() leaves IFF_TX_SKB_SHARING set, so the stack can resubmit
> a shared skb that is still in the ring. The next transmit overwrites
> last_cb, so the earlier slots complete without crediting their bytes
> and BQL stalls the queue until the watchdog resets it.
> 
> Unshare the skb before writing the control block.
> 
> Reproduce with pktgen in clone_skb mode, which hands the driver the same
> skb while earlier copies are still in the ring:
> 
>    modprobe pktgen
>    pg=/proc/net/pktgen
>    echo "add_device eth0" > $pg/kpktgend_0
>    echo "dst_mac AA:BB:CC:DD:EE:FF" > $pg/eth0
>    echo "dst 192.0.2.1" > $pg/eth0
>    echo "clone_skb 8" > $pg/eth0
>    echo "count 0" > $pg/eth0
>    echo start > $pg/pgctrl &
>    sleep 5
>    echo stop > $pg/pgctrl
>    wait
>    cat /sys/class/net/eth0/queues/tx-0/byte_queue_limits/inflight
> 
> inflight stays nonzero on the now idle queue. clone_skb 0 leaves it at
> zero.
> 
> Fixes: f48bed16a756 ("net: bcmgenet: Free skb after last Tx frag")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
