Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31124156CE
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182236; cv=none; b=F15k831q3DhXYeeAo9z3WwbCrnb1rRlcf3XTXOotI30t7FA1ygZU5AKcDvcIgEuqbejlumZjuyap4CakuZKuqFvXaJd3vh0lj7qBVm/0JI/dP12UAfpm8YR6G2cuKZ1OdbIkCm+RIl2zn6OI2DlV4/CzJMUBD00qGPpr2muGsgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182236; c=relaxed/simple;
	bh=UyZnsIW8vAQ+WpI1yUMqM7v4Uwx9lmTtE4b7qftADUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3frKERZtIUH1XFSJIiqCFKhVJmRYGq83HacLe0zKPu2qia3UbtESNmwL9546cG9Xrmg9w7gCT7RLbohSW331AbF3st23orCmtBBoPwBjfZxZUA73b6QZt7IuirbDUC474xhu/d2QC4dCjGv6ECDr2wYwaQiwQyju3iXVjkfzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=UiLuqJzZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="UiLuqJzZ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a5f1d0af69so5398798a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788182233; x=1788787033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=twiibvfC7nbZ6wF/nnuatbNAQXyxSSZLrA3DNRZ8L2c=;
        b=UiLuqJzZskEVFdORcy7falgLeEqlsRKgHTlholn52w2bNNZMIQff+NbDc8lT6s6/By
         xBpA2fw2ETNyaIqb9ZEGGRYYKpA6oAkaH0DULTSOf77cKLr+CzYC8FWTGCAU/7Tm2JbH
         +2YCdBqdGC6h3LPweTjNNjQD0bxD0MuDhvNse6NIJF1mcX2D6EHlZwXO4GFR/moV+LUr
         AHow+xXfVaZ9lh51+N7QM3oH6zDgcYC6vj9MsR7NRIpVe5ASInVHNcOZWfmGbyKlwPB4
         TBq+lhbhglBMgl3kP7QkGs40nItSgoYccb8t5GqZ9o7Q3VsIkjxK/Vqzi9itnOkF2qqi
         LFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788182233; x=1788787033;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twiibvfC7nbZ6wF/nnuatbNAQXyxSSZLrA3DNRZ8L2c=;
        b=Oc870ASutsffmliGmBWlC3Y5UZXSavbZnMBgw6jw+X9wepZ7ApgTRh0AE82/bWvzHe
         TkIXHcAPn2yK41djxHmgdfuYMfWhKIwQ6JOPlk6J1gevlI0RLHH++wlrr9sybnea3CDA
         GHIMnf2VauGgFpfI5SVT27y+z3ueX1Lmj5Nq3cV06hPGYTZ+dqRt++gZ7yKzXb9GZcFw
         gwFHDGARTT/zRtIZZTYaSg2FyX1W1vyFMgFoYTetjNc28P/WPkWNdajKDl4QKQ5+7jMf
         YD7ZIckSjLdegmsbWw9dUMNrqb89dqknyxs8wKQbs84KjZULOl4gU0mCEM3UUkd0jcHe
         Zpng==
X-Gm-Message-State: AFuF++mtgASm9vB7ClfbTZdfhXO03h8JCe1sanudUGE3/VdwScT/fcYH
	XtzfgWJFsyMlQ/PUmnIG/ew5Z082sqTua8C/6Ii3K6qXRK5Evh4bSQ6u/WchJKYvTSA=
X-Gm-Gg: AYBFou3CF3BqjIdUUcbpaghtP7F+3jTbgTR0m2YlTFJu7beywDBo7Oh84OdHGD1r7Dl
	wCEAmT7qBN1aUKsnQbiISfVb0Z4Fc8mJ79Q4RPzz2Mt6YnieyCS5ONBOYGWGJxsOl97vjkqRC5J
	8x44u7TUQIKYFP30XwANQL70AHNjMBF9/3Qtdcds7noCS/gsDEyVwEzVK0oG+/xFqyYwtMPPXU0
	5vBXXczppsVuxkDmzaoAUAkAbydFsoEVfd1oAbYPARS2xUL4ppqRMen/2QPpUvalOD3JIIzVQU8
	Z+KD1+c4o6CpCE6dnlqHz6sMagGvV8BSE67XyjKtrUtFzjvDe6x8aD96b1rfw/MU3J+dC2Lci3C
	jqBghiebZ4Qkr4GayzY/wb5Ztb+uGACbmnWhjI6hm3HilwWtrLPEaawHMWPT5ngsNQaEp68NEXa
	E0v1608baLZ1fLjShe5G6Dt0IFPsoCTACzXbxhGCe6BZ1WuuQutY3T1bni8o1+VavDONM7VNoUb
	jg8lwp+N9mlToq5aEU=
X-Received: by 2002:a05:6402:304c:b0:6a5:f4cd:ae39 with SMTP id 4fb4d7f45d1cf-6a60d3905f7mr12657188a12.9.1788182232691;
        Mon, 31 Aug 2026 06:17:12 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a611b5c3f7sm3637726a12.6.2026.08.31.06.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 06:17:11 -0700 (PDT)
Message-ID: <8697e1c6-a401-4b62-b7e9-a3acaab272ec@blackwall.org>
Date: Mon, 31 Aug 2026 16:17:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTpSZTogW1BBVENIIG5ldF0gYnJpZGdlOiBza2lwIGdl?=
 =?UTF-8?Q?neric_XDP_on_locally_re-injected_packets?=
Content-Language: en-US, bg
To: =?UTF-8?B?6LW15LiW6I2j?= <shxzhaosr@163.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
References: <20260831113051.13072-1-shxzhaosr@163.com>
 <b30a2594-b154-4f52-9afd-2db0f9d78bb3@blackwall.org>
 <15142192.95bb.1a057e13984.Coremail.shxzhaosr@163.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <15142192.95bb.1a057e13984.Coremail.shxzhaosr@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/08/2026 15:52, 赵世荣 wrote:
> 
> Agreed, Eric's patch fixes the root cause properly. Please disregard
> my patch.
> 
> Apologies for the noise. I'll review the mailing list and verify the
> root cause before sending next time.
> 
> Thanks,
> Zhao ShiRong
> 
> 

Also don't top post on netdev@, reply below.

Thanks,
  Nik

> 
> 
> 
> At 2026-08-31 20:31:19, "Nikolay Aleksandrov" <razor@blackwall.org> wrote:
>>On 31/08/2026 14:30, Zhao ShiRong wrote:
>>> Packets locally delivered by the bridge are re-injected into the
>>> receive path via br_pass_frame_up() -> br_netif_receive_skb() ->
>>> netif_receive_skb() with skb->dev set to the bridge device.  If the
>>> bridge device has an XDP program attached, __netif_receive_skb_core()
>>> runs do_xdp_generic() a second time on such packets.
>>> 
>>> A locally-delivered packet that was allocated on the TX path (e.g. an
>>> MLD packet built by mld_newpack()) does not carry the
>>> XDP_PACKET_HEADROOM that generic XDP requires, so
>>> netif_skb_check_for_xdp() calls pskb_expand_head() and reallocates the
>>> skb head buffer.  This frees the head that the bridge rx path
>>> (br_handle_frame() / br_handle_frame_finish()) is still using, leading
>>> to a use-after-free read in br_handle_frame():
>>> 
>>>    BUG: KASAN: slab-use-after-free in is_multicast_ether_addr [inline]
>>>    BUG: KASAN: slab-use-after-free in is_valid_ether_addr [inline]
>>>    BUG: KASAN: slab-use-after-free in br_handle_frame+0xcfb/0x1510 net/bridge/br_input.c:349
>>> 
>>> netif_receive_generic_xdp() already refuses to run generic XDP on
>>> reinjected packets by checking skb_is_redirected().  Reuse that marker:
>>> set it right before the bridge re-injects the packet, so generic XDP is
>>> skipped and the head buffer is left intact.
>>> 
>>> Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
>>> Link: https://lore.kernel.org/all/6a6d4406.2d659fcc.1d46f5.01ad.GAE@google.com/T/
>>> Signed-off-by: Zhao ShiRong <shxzhaosr@163.com>
>>> ---
>>>   net/bridge/br_input.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>> 
>>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>>> --- a/net/bridge/br_input.c
>>> +++ b/net/bridge/br_input.c
>>> @@ -26,6 +26,12 @@ static int
>>>   br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
>>>   {
>>>   	br_drop_fake_rtable(skb);
>>> +
>>> +	/* Re-injected for local delivery: do not let generic XDP run on the
>>> +	 * bridge device a second time, it could reallocate the head via
>>> +	 * pskb_expand_head() and free a buffer still in use.
>>> +	 */
>>> +	skb_set_redirected_noclear(skb, false);
>>>   	return netif_receive_skb(skb);
>>>   }
>>>   
>>> --
>>> 2.43.0
>>> 
>>
>>Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
>>
>>This is wrong on multiple levels, use your head for 2 seconds before blindly
>>sending AI crap. This was sent ~2 hours after the report was sent, did you
>>even test your patch or just hit send? Very disturbing practice anyway.
>>
>>Perhaps we should clone the skb for passing it up to the bridge when a fwding
>>helper is using it (i.e. when there are actually clones).

