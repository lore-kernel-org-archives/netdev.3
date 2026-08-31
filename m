Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C23FF1AC
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179488; cv=none; b=pv33K3V+FtZhLYfd6eDzsX7pO85rHew0FeWYZMvpvFGHAhQqEF/Zlcq3uAjj3aH64qoq09/vAoGlApn7i0XuYB3P1/0flJpA+D4jf4yxZ9ZvpbT2W0gP3lJZY/Z50DKyxNlB3xxuQIHOT05ilOqEhASKM4klE8e0rjodOSGGwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179488; c=relaxed/simple;
	bh=Y0V/3uw6Dclec70rKLWcztfNr2TyqhPTDR3WmwbMJ+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7IZ/aGaPX/9JzhwkHrDPBJGcbRi1uvUg9amKXh5L5IgfiaKmqfFlkiWGnOpPMo7jdOvJB6/8n2T/Zl01SHcE5NLsqw9xqLAL8UW2VtEGLxC8HiJe29PbU2CZLUhOUlrzuCxLj4GBTifw6inIhHYteGPncbWWd361c5mZ3z7zZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=NNosl1Dz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="NNosl1Dz"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so1551645f8f.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788179483; x=1788784283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hMHSz/yOqpOw4BUuWyRgv2r2RwaD0GDIsQCXrSNiv3U=;
        b=NNosl1DzqGLpOlTDQe8D+BCccEx98axZJQvw+gF2veEU5PkZtU58TjmK08mvY9Z2wz
         /H2hdfaqMxsUcXjZN1uCaRUq4CRjBLWCDGj6Iwv8emX77/jThpxd+0OZWpsJh1XwYYwW
         wTqJQGl2NMoTh6i3FmA+eRaLPMnrZOBS1fOIWem+NClN4gfgLo6Eh2GjXwimSI2y6z7s
         Zxyr9OZCVzbe8TUFNDck2Cen4Txa7WZzXekYxB4OMPZEQUq0R6NulEl+elWeQkQ//jGW
         anvZbRHIsYHkayEBiXpOrebTVBaOVJ5HFMaesvWnWMi0d1GbiCNU50uKyamFQBYv/tp/
         kirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179483; x=1788784283;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hMHSz/yOqpOw4BUuWyRgv2r2RwaD0GDIsQCXrSNiv3U=;
        b=Pnv9ndYFHkRQ5cwymqX5spQA5vjXnSeBMAo+yvynqY6RL6oExamj+1+QdTN1dQPLvL
         aHLZtrQ5HoQY2Xk8P818JY9vNWysWUGUkh9fHlwCxJhPDgF27Oqq4Mk2rW1LUxucY14x
         O5EOlXpOTBSqZP5k8qubZlEJWLDBw56EYwiCWoFhC12/FqyZHjTSKONF2lJGsoCyyr3L
         oHKNsA98deWM/WuLKrGBgZCeVLlqoIhDOrInXXCuyyNJnUeXGk95VUAm7Jxf77xWhZga
         ygxjkLO+uiQmjZqcUHSkni0F+MVgrecOSrihLYNx1k7zRCimsZ+eRhSN3zu9hvwScsDx
         oTpw==
X-Forwarded-Encrypted: i=1; AHgh+RrvQ/iJE+aVIkbuWb584Wpr9aT8Hb8X5WFw1BSv00dS0mL/WUg+aT7ehdvq6Qrupnm3ihxY12Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lCl0+PjjuRUVL4ChxuvS/Gq0nTQksWgHzXPjGMg7JwANypP8vR
	rYYeVDb/bj3z1MqBGn6K+rNtLeSAOvg/x1YMyHHvrnYwg7IOsi5X79KpKPKGqfF05wU=
X-Gm-Gg: AR+sD11jdDyXTUKFpitNLvfhjEFpCHA6krE5scIlHDM/R9tO/jmF3vg12bzh/Dj7fYU
	orOxuukeXZssqALnrxGZAqifcMTH+gF9WWEloHDeB2mpT+B4GsmTUVMwrK8KQl56NbSJTUo/pKv
	IqqFwFUbX71Vyhcon8NYVPaUbd7ax2MfpC2C1Tp31VfzTlFRmAP5E9QtEatWxIIx9DnSsB/RKf+
	IBOxXWn5G8ZbIKJhlzjn5BzNrbilNHxaI/pr1/WsD5GQZ3koMwU3d4PTPS/VMdP1zoYlBrxvcE4
	WSD3sthUpgN2WkwTDHW4cDUoizrEw/7w1cHKWm5BYd458OFAHmfRoOHvR0KdiW8DlgfclNz50sp
	Y/FWDAylJFwOgfnW2Osj7Ap5EmNChkuN/Qmuh7w3scHZEYATGvVRLOg0mUhh1UI4K2iIYFRUAWQ
	XwS44b6fAIabAwVlVH8gduPT0iJxHq8/AveF/6Q8J8zk/A8G4K9rjWNQsJXq4tjvaYZFjbjG9Cy
	fV191N3Ggbv6E7fdzQ=
X-Received: by 2002:a05:600d:8498:20b0:499:dbae:86be with SMTP id 5b1f17b1804b1-49b91c4de9bmr308024275e9.14.1788179482535;
        Mon, 31 Aug 2026 05:31:22 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccae954f9sm216243985e9.13.2026.08.31.05.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:31:20 -0700 (PDT)
Message-ID: <b30a2594-b154-4f52-9afd-2db0f9d78bb3@blackwall.org>
Date: Mon, 31 Aug 2026 15:31:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: skip generic XDP on locally re-injected
 packets
Content-Language: en-US, bg
To: Zhao ShiRong <shxzhaosr@163.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bridge@lists.linux.dev, syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
References: <20260831113051.13072-1-shxzhaosr@163.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260831113051.13072-1-shxzhaosr@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 14:30, Zhao ShiRong wrote:
> Packets locally delivered by the bridge are re-injected into the
> receive path via br_pass_frame_up() -> br_netif_receive_skb() ->
> netif_receive_skb() with skb->dev set to the bridge device.  If the
> bridge device has an XDP program attached, __netif_receive_skb_core()
> runs do_xdp_generic() a second time on such packets.
> 
> A locally-delivered packet that was allocated on the TX path (e.g. an
> MLD packet built by mld_newpack()) does not carry the
> XDP_PACKET_HEADROOM that generic XDP requires, so
> netif_skb_check_for_xdp() calls pskb_expand_head() and reallocates the
> skb head buffer.  This frees the head that the bridge rx path
> (br_handle_frame() / br_handle_frame_finish()) is still using, leading
> to a use-after-free read in br_handle_frame():
> 
>    BUG: KASAN: slab-use-after-free in is_multicast_ether_addr [inline]
>    BUG: KASAN: slab-use-after-free in is_valid_ether_addr [inline]
>    BUG: KASAN: slab-use-after-free in br_handle_frame+0xcfb/0x1510 net/bridge/br_input.c:349
> 
> netif_receive_generic_xdp() already refuses to run generic XDP on
> reinjected packets by checking skb_is_redirected().  Reuse that marker:
> set it right before the bridge re-injects the packet, so generic XDP is
> skipped and the head buffer is left intact.
> 
> Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/6a6d4406.2d659fcc.1d46f5.01ad.GAE@google.com/T/
> Signed-off-by: Zhao ShiRong <shxzhaosr@163.com>
> ---
>   net/bridge/br_input.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -26,6 +26,12 @@ static int
>   br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
>   {
>   	br_drop_fake_rtable(skb);
> +
> +	/* Re-injected for local delivery: do not let generic XDP run on the
> +	 * bridge device a second time, it could reallocate the head via
> +	 * pskb_expand_head() and free a buffer still in use.
> +	 */
> +	skb_set_redirected_noclear(skb, false);
>   	return netif_receive_skb(skb);
>   }
>   
> --
> 2.43.0
> 

Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>

This is wrong on multiple levels, use your head for 2 seconds before blindly
sending AI crap. This was sent ~2 hours after the report was sent, did you
even test your patch or just hit send? Very disturbing practice anyway.

Perhaps we should clone the skb for passing it up to the bridge when a fwding
helper is using it (i.e. when there are actually clones).
