Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F774A92F1
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552210; cv=none; b=NpGdeIXrJoObRpaRQz3zGuU6bSUP+A4IVygDPzqnxfb8NjRHanaeLrUVcC2ygTe9VjuruEM76aOBL1n7dyHj8jcyiQl8JK3EDxdb3/mCYy18dBJ1SVrfs/Xs6Iv3KJ5vXNAJ46OP8BB4akrxYgZ6w25sSX1IEwGndOjhs6UuFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552210; c=relaxed/simple;
	bh=wF2yTrqTzxU/LQoN8oIcGXye1s38p/VSNlZRvOUln+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSmdNgT0GwUO4iscKSK/hf4t3WD7hBLNyz5sO1tky0Z7Z/9PeinCYVVfyUoi2Nfud6Pj5RBz3hVFnd+7oATZegzy5meHDTQAgrbyaS9U6NoA1f9FRrWBoMu/ee+TSVG/T1UP1infdIDKmxlhMya02zZNEfOlk7ulY6VJqntBf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so11590685e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552200; x=1790157000;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QppppjvOhjpWoz6HH9Z7BHWIM6lRKbDqJqUaB9rOjSw=;
        b=ijAOmP8yn+LqYvv8JFgcKS6ihAACjOPe8fJwqhWQsZAPWSwXvuqUv6g5c5sA+eduOL
         WvmVj8KSOPlZOGOZJnLW7vdEbXnuRprclY63Mhx5kz3PLWjTVYb1b95anL0X7Y2uNbNg
         HK964F2yRq6/KuZSujxigK+UkaORiMQdGJ6sIUi01SMCr+2iO721oD193A85cljUNlA1
         d+EHsCvvqiiGWHbT7IE1TImFbke00Ym3pMBmGjuEUPRcxUORs3GqZdjomXZKbjy48qAp
         Z/2QZHy912ZMj30cIcXajm/T8Bx/s+0opXzI63Oq3a1jA+nyhEXn/H/fnTt9i03OKR4b
         m+ig==
X-Gm-Message-State: AFuF++m3k8ew1t8OrABzH0T2dTsNCcsF6ho8XMgFtq/GHS3F/kdrfzzt
	xKusD6tWvPAnS44mj0RFOLyTh4VHMGkO6NB9lW8sASCKdAptXnfJhLs2
X-Gm-Gg: AYBFou07/DVOwUsG/VC3LJIlOlhO6kZ/qv4kOp3+MznILLVb1oxGn7DPdYGO4iCkSIw
	Cu/b0VbdQPD/61twfR6NSIbVG9knOhDKybsaigvA85ChaQpi3IhfRGh8kz2WutPBbFnd4d30b6M
	XOmeAKZ4N9CWjf4pskoF78Oi0C6ZNQbxwthHyPnmU/3ZkWBIBnVod0IuNpPyrJJuGa2Dcl4s5BA
	q6mfmjlsrx+D0jM9D+r3UoczSEXleRdaKeCIYCSVjHBhtx2MWe98bTHoB8K+6SH9T2IAhKs8Kt5
	VArXMCb54nRvuw2etvhYtrZJFvdEeNFDLvr7DZrbuez2TGa/nIQGCmEOSDjcLaoD/b1gsL+WZQr
	zZnVGJSfKSDQohDpkqrUZ+SDPQKgN72+LtadzYtwVkqajqj3hKXLqXo52FuCDjvjbHvMsGEzYVc
	IdCPUSC3ddjOZpeyNW2cj6dZLwBmVjdkpiq4Qc0yW1VbAEgtcnUlAVujIpBDrG61gnNxEZgzG9+
	bMtHNtDMCWPkniP+n0mxK78aoMwEFBnRljsI0w=
X-Received: by 2002:a05:600c:c8f:b0:49c:fc6c:be15 with SMTP id 5b1f17b1804b1-49eb733c62dmr20974515e9.27.1789552199588;
        Wed, 16 Sep 2026 02:49:59 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83cc400asm66852305e9.0.2026.09.16.02.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 02:49:58 -0700 (PDT)
Message-ID: <d92e90d0-437a-45eb-9803-726bf7c088dc@ovn.org>
Date: Wed, 16 Sep 2026 11:49:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] openvswitch: raise internal port TSO limit
To: Eelco Chaudron <echaudro@redhat.com>, Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 Ilya Maximets <i.maximets@ovn.org>, Aaron Conole <aconole@redhat.com>,
 dev@openvswitch.org
References: <20260916065844.1380155-1-wang.zhan@smartx.com>
 <C381651A-DA84-442F-8F75-577946A0E437@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <C381651A-DA84-442F-8F75-577946A0E437@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/26 11:37 AM, Eelco Chaudron wrote:
> 
> 
> On 16 Sep 2026, at 8:58, Wang Zhan wrote:
> 
>> Set the internal port TSO limit to GSO_MAX_SIZE (512 KB), as for
>> loopback and veth. This allows the admin/user to set a GSO limit up to
>> this value, to use BIG TCP for traffic routed through the internal port.
>>
>> Only the capability limit changes: the IPv4 and IPv6 GSO and GRO limits
>> remain at 64 KiB until changed by the administrator.
>>
>> Validation used a same-host test with a temporary OVS bridge, a veth pair,
>> and a network namespace:
>>
>>   TCP client -> OVS internal -> OVS bridge -> veth -> TCP server
>>
>> The veth endpoints were BIG TCP capable throughout the test, and only the
>> OVS internal port limits changed between 64 KiB and 524280 bytes. A single
>> iperf3 3.19 TCP flow, run separately over IPv4 and IPv6 with six
>> alternating runs per state (`-t 15 -O 5`, fixed CPU affinity and port
>> tuple), increased throughput by 18.1% for IPv4 and 34.7% for IPv6:
>>
>>   protocol  BIG TCP off  BIG TCP on   CV off / on
>>   TCP/IPv4  65.567 Gbps  77.420 Gbps  1.12% / 0.37%
>>   TCP/IPv6  55.355 Gbps  74.568 Gbps  1.20% / 0.68%
>>
>> Assisted-by: LLM
> 
> I think Ilya already mentioned this earlier, but the LLM tag means you need to
> fill in the LLM model name you used.

It looks like the rules changed recently, see:
  816d9992d9ed ("coding-assistants: simplify attribution")

So that's just a new acceptable format, which is fine.

> 
> The rest looks good to me.
> 
> //Eelco
> 
>> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
>> ---
>>
>> v2:
>> - add an empty line before netif_set_tso_max_size()
>> - rebase net-next/main
>> - cc all the maintainers
>> v1: https://lore.kernel.org/20260910131635.780802-1-wang.zhan@smartx.com/
>>
>> ---
>>  net/openvswitch/vport-internal_dev.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
>> index 125d310871e93..77a16d5ebd543 100644
>> --- a/net/openvswitch/vport-internal_dev.c
>> +++ b/net/openvswitch/vport-internal_dev.c
>> @@ -117,6 +117,8 @@ static void do_setup(struct net_device *netdev)
>>  	netdev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
>>  	netdev->hw_features = netdev->features;
>>
>> +	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
>> +
>>  	eth_hw_addr_random(netdev);
>>  }
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
