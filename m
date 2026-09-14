Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110C381B1A
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420573; cv=none; b=fztVotpqBgExqF2geu+oqzg/47/9NRsZ5JXb9SIVRptdd1FQCDmpLSyLMc97UIDgl91OYEn0d5iNorixbmKZrO30ujG23RZH1EYncIOdmBJ/YXBGeCrzeZcaiznWP5DVoojZ8Ynj4nALEWFW7TodA45pHyUTUrHzyJAjf4hv0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420573; c=relaxed/simple;
	bh=pRD7Z+wpknyhKIuXnCEHF98EZOGtUnAzkUsXHVDoKNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/x5aZS4qMlfRzw6UENrMAHy2IDzQhAPnLbWa3bkxo5JDvF3w1GFAll+9/wTISuXMhMJunAVhPJT9jagaHzOWNMnBSuacPHy8ZxmshkvecxcJv3BhsS6tMkUmunT3R8yPg0bM5GHQYJYloZB+e0acWp8pkI1K/GpocI0obohUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so13155705e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420570; x=1790025370;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6dMtwf3aknp/Biu8uAp4SRqlY9VPC/Qd7gqEXyJcSVQ=;
        b=qRjQJPAjas0hDEP5ygWPtTfhiFLjEXUnjXucTFwjkXy8rYGXH/JlbmNrSv5qwcOv//
         i5Dya76ZkkWrzJFU81urpqVQHKFUnoQW/FffC3BF3qZKsS6gueMs0zUg5Bdm+UiKevoI
         g/e2clmz08ms+tV/ZfCAp3YfktHrBa8J3v4p0IcCRuSNYx9HhqQdgwq/LzR7A5RX8kXf
         t11nEi0CpPsXNwRHN2oz/Yrftr6e2UJbt5oBmaJpWf1OviDpBehG0TWZsjhsmmeOwUqB
         HhE9lQYrUbyeeyoVtAXAmWxbL0xrruEvGO9l3uDdJs7UPq7xWXn6ox1XP6HqB01NGRmv
         IJew==
X-Forwarded-Encrypted: i=1; AKwUvBy2TPZTFWmamAhGMYHJWc1MsnuWigr3B+FGxne2u54qZrd0OhROxtWt4yznDCp0dDJ8VEiLw3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lbjlnjbFl/ZYXwLpnNOGVKAIdh6P2lGzieTSjyhRQ3GrdZwmKA
	05eCxonnkB/D11W4hVE92EN0i0ONLmTYBd9xsw/DvAdkVb5TTk221N6d
X-Gm-Gg: AYBFou2X3kpdOHJHEC8W5eW8XuzOSxQOtMq6RGtNcmwOR/JEUk8FYOnPev/SF5K/crX
	uPyN6n+K99OE9n+wyS8s/PRE5ic8MNGURIVrVDOcU8bI8RlEYECsi4sQgITyVOEOorWipYEYUGa
	45A61/Z6n0hHkxzBZ9oQD7mo/cW9f+X4b6/RX6/74rTYxS1wISQHV7ZxkijQ5YWv7ohCJ9eL891
	IVyc/AwmgdHJ5bs1Mi5J9ymUZf5/aH96x1yDTPw7oFzBl3kej2OHwU4zOFMZJ3AAFgA1qGv6qMN
	nErtpI5vIznHAUgU9Iba9uJ2+0SxExtkejG0cQLGdj+KciMf8JrOYqNWAtf7AbHSRjbK5lMva/j
	QWAVSObzwmLcqGwcINO2YIh3lks7gPNvX/4CjlB8F82y1abfZJs/rvA1ko2CorQh8qpj7jJ+5Sj
	fXdZ9MAlWI393VGHn/z4nTeVUcCHprMJlOMSNEb0gSHR8Mhkk7R0Na6Twha5gkeTKwM1xroOa47
	nZC8iljpUfGHgTX1/LuNY22drbL9Wt+qSVC
X-Received: by 2002:a05:600c:8b65:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-49e7a677411mr59224165e9.23.1789420570313;
        Mon, 14 Sep 2026 14:16:10 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d284a7bsm54326565e9.3.2026.09.14.14.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 14:16:09 -0700 (PDT)
Message-ID: <bceb850c-dfbd-4fbd-af85-e764bdacb6aa@ovn.org>
Date: Mon, 14 Sep 2026 23:16:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] openvswitch: raise internal port TSO limit
To: Wang Zhan <wang.zhan@smartx.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 Ilya Maximets <i.maximets@ovn.org>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, ovs dev <dev@openvswitch.org>
References: <20260910131635.780802-1-wang.zhan@smartx.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260910131635.780802-1-wang.zhan@smartx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 3:16 PM, Wang Zhan wrote:
> Set the internal port TSO limit to GSO_MAX_SIZE (512 KB), as for
> loopback and veth. This allows the admin/user to set a GSO limit up to
> this value, to use BIG TCP for traffic routed through the internal port.
> 
> Only the capability limit changes: the IPv4 and IPv6 GSO and GRO limits
> remain at 64 KiB until changed by the administrator.
> 
> Validation used a same-host test with a temporary OVS bridge, a veth pair,
> and a network namespace:
> 
>   TCP client -> OVS internal -> OVS bridge -> veth -> TCP server
> 
> The veth endpoints were BIG TCP capable throughout the test, and only the
> OVS internal port limits changed between 64 KiB and 524280 bytes. A single
> iperf3 3.19 TCP flow, run separately over IPv4 and IPv6 with six
> alternating runs per state (`-t 15 -O 5`, fixed CPU affinity and port
> tuple), increased throughput by 18.1% for IPv4 and 34.7% for IPv6:
> 
>   protocol  BIG TCP off  BIG TCP on   CV off / on
>   TCP/IPv4  65.567 Gbps  77.420 Gbps  1.12% / 0.37%
>   TCP/IPv6  55.355 Gbps  74.568 Gbps  1.20% / 0.68%
> 
> Assisted-by: LLM

This looks a bit strange.

> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> ---
>  net/openvswitch/vport-internal_dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
> index 125d310871e93..73f5184afba42 100644
> --- a/net/openvswitch/vport-internal_dev.c
> +++ b/net/openvswitch/vport-internal_dev.c
> @@ -116,6 +116,7 @@ static void do_setup(struct net_device *netdev)
>  	netdev->hw_enc_features = netdev->features;
>  	netdev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
>  	netdev->hw_features = netdev->features;

Please, add an empty line here, it looks awkward to glue the call
to the feature flags block.

> +	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
>  
>  	eth_hw_addr_random(netdev);
>  }
Otherwise, looks fine to me.  There is no reason to block BIG TCP
packets on the internal port when they can enter the datapath from
a veth.  And I don't see why BIG TCP wouldn't work in OVS at the
moment.  The packets will be segmented before sending to userspace
or ports that do not support BIG TCP and all the functions that
check the packet length supposed to use gso_size and not the raw
length.

But, please, CC all the maintainers while sending patches.

Best regards, Ilya Maximets.
