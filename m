Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC29E3AE190
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179946; cv=none; b=hd1LKhp1q2tevHHdY5jIhQRGrHcDhCs7hwaf9TZkYJMvhqNVK09m/v/VRBA0OelJb6svn2w5B+XI14eCAJKelytYWdbYyt0S+/tIGZ2mEKwcNUtQySGBOjzfLvD1Ufltqr/okTD84RKjZWdGYiMzEPERlDRGCbmVkXyq3w99Rl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179946; c=relaxed/simple;
	bh=5DqBNLMOOhVw3otEoFEcM4M1Ey6p4hwag4dan9Itugs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEjaHXSidlTvOWy0lJAea7kjN+R8yvZSgHICvPpuKQ5IdUgKY49oKBWlauW7GzX4q+fhKSePIizKvwGEsUd4QFIYlypWlNUkQ/OlKuEsVRUi7MCZaIfFY8HEoQx0e/2P67/1yCbq90aCPK2kl1M0dIh3hdJFn6JUpEN1rq+Ulss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HAuTlaue; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HAuTlaue"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso27684675e9.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788179942; x=1788784742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AkG8VPrukE/xSkp0kXQNI9brii0c48I3Kehqjf8BMN4=;
        b=HAuTlauehJCJCRSQ2LilWSnU2H33k81upP93F1/E30MhgZxbWWyVKpayF8LaMHFklF
         KLRRNd6oY2XM4IemYpdGUaUaZUaNXFoK6EWpBLYGo6/LSuwYTRHw1zd6Xwbr2LNwWjyr
         GHt/LzTn2HNwOXJTUqClZwaH2/Prd8vR+tLulOEmH2Twp3cc1uKV8TTl2iB/5GtEQXnH
         pj5NtPz7iknR5JkZTi6MZsR+sFCjn6GCw41kdJxVEEsDrjYD6eK1wmZavF0WbjBpFj2I
         r7QqwWuT1/7zyd6P7GbqYtZRobR6USeo5QCRzWHr/qT2q5umZzwAgmdFzzuTJdQAh8Vj
         Shrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179942; x=1788784742;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkG8VPrukE/xSkp0kXQNI9brii0c48I3Kehqjf8BMN4=;
        b=QWXQuJSBylPYcO+RzJ5w4tmOGoZv9X+SCMQmD/41a8Gxu0dfJ/aFckJqbjRyk5UKHM
         26J605Yy1aQt2bIX36Wpp2FXsKuKeNt2GfNhxFvTOR4AzR/kjYNyML7ilsNyfJZLXkdE
         Ocxkh2dQSEYzLZf8WTTtjRhYrskrzF8lu0ZpUyGrcxKly4lZK6Uq7K2Tl4G+TgsJ5KB1
         /yH3HZAITlGnOx2xtE99dvzL2bxijyO3cgYH5vBCBmrHyFrPV1X64fPXM1N16RPyAngy
         Jbv9Uv8vn+fMVPn+PWfCSNZWNFRw3/228aG92El41hNN6rPgxadbIT9Nio8VBsoQOmGX
         DZGw==
X-Gm-Message-State: AFuF++kCUfebiNP8enyEYDQxscPHX5lCMNLkshFnalx4ow1R8YGB8oKC
	3z9xMlzkI9U5JR90G1c8MAEAT96OWk85g9IsfPagoxfNEzRuZ3N1TuFG+m+c3jZsfhI=
X-Gm-Gg: AR+sD118SL21NQOIGTtCBAKGdZ84pmI3LMMoBjTMW0XnlM62HiTVxYmob10epMPtMOz
	xwBFK+9sxcwz75E5D17ti1cyIAOqicgus8/E/Mv1V4OJ+r1vPoBFCb6ZAt57NsEdETlv+HjGsCI
	NHBHUtWOCY+jkdodfWC+abS4sNX+ZsZpM9GmIUR8WQYmBnoDI6SiYlxs1oNx9sekdxV/O36dG3r
	dPc2t9/fYMHM1P4L/F9WL4y7gvVQF+cLsDJISI1P5KcVAvE66DC56ka2nPU0VYPIVCd1DIuDGtS
	lypyKF+0DobswP6Ee2NO9g0UDYu4z4ISlSHoXZ4SDkZyVN12FFBamLk/6F1DV7C9liBa30R3ZuM
	ZKFCIkWTQB8rSTUzSNCRuNMbjl+ztS0PlbqWVvmUxzG+ThlaoTsTdd9Qyhy9o2i8Hfc7c0qiJM5
	iO5hp6dLHudND8KJ6jBc5Ok2uU3qKc0G0kFZsOwknSftBuCLIMDjKiDHI5Ymy045IQX0pmElO2L
	q/jWQ3NgobNpdiSQt7a9VQMqS09rgA=
X-Received: by 2002:a05:600c:8b63:b0:49c:ced9:ab7f with SMTP id 5b1f17b1804b1-49cd53c438bmr127531665e9.8.1788179941262;
        Mon, 31 Aug 2026 05:39:01 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cda123ac8sm26494115e9.5.2026.08.31.05.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:39:00 -0700 (PDT)
Message-ID: <6f0a65d0-9eb4-406c-b131-4b1a6e8ec6ed@blackwall.org>
Date: Mon, 31 Aug 2026 15:38:59 +0300
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
To: Ido Schimmel <idosch@nvidia.com>, Zhao ShiRong <shxzhaosr@163.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
References: <20260831113051.13072-1-shxzhaosr@163.com>
 <20260831122534.GA3247474@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260831122534.GA3247474@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 15:25, Ido Schimmel wrote:
> On Mon, Aug 31, 2026 at 07:30:51PM +0800, Zhao ShiRong wrote:
>> Packets locally delivered by the bridge are re-injected into the
>> receive path via br_pass_frame_up() -> br_netif_receive_skb() ->
>> netif_receive_skb() with skb->dev set to the bridge device.  If the
>> bridge device has an XDP program attached, __netif_receive_skb_core()
>> runs do_xdp_generic() a second time on such packets.
>>
>> A locally-delivered packet that was allocated on the TX path (e.g. an
>> MLD packet built by mld_newpack()) does not carry the
>> XDP_PACKET_HEADROOM that generic XDP requires, so
>> netif_skb_check_for_xdp() calls pskb_expand_head() and reallocates the
>> skb head buffer.  This frees the head that the bridge rx path
>> (br_handle_frame() / br_handle_frame_finish()) is still using, leading
>> to a use-after-free read in br_handle_frame():
>>
>>    BUG: KASAN: slab-use-after-free in is_multicast_ether_addr [inline]
>>    BUG: KASAN: slab-use-after-free in is_valid_ether_addr [inline]
>>    BUG: KASAN: slab-use-after-free in br_handle_frame+0xcfb/0x1510 net/bridge/br_input.c:349
>>
>> netif_receive_generic_xdp() already refuses to run generic XDP on
>> reinjected packets by checking skb_is_redirected().  Reuse that marker:
>> set it right before the bridge re-injects the packet, so generic XDP is
>> skipped and the head buffer is left intact.
>>
>> Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
>> Link: https://lore.kernel.org/all/6a6d4406.2d659fcc.1d46f5.01ad.GAE@google.com/T/
>> Signed-off-by: Zhao ShiRong <shxzhaosr@163.com>
> 
> Eric sent a fix for this issue earlier today:
> 
> https://lore.kernel.org/netdev/20260831095952.3385596-1-edumazet@google.com/

Oh I missed that patch, it fixes the root cause and we don't have to do anything in
the bridge. Good thing :)

Thanks,
  Nik

