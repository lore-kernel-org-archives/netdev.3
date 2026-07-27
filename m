Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F33F6600
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150343; cv=none; b=rL8clF9ZXVTfGAvQl5hZstISnhTtDVCIUasH/kEnA9KFJMKWrVSPiG2DwrBrKUTwSZ14lq/9eyh/w0Tkq/V8/4g9Hmtuyg3Gw8WUiQMNjQ4+0kWXVbVupbahQWtudMpmHcKtwpOAp1Y9oJ3JCuK/UrtLDZiOel3ZTFU509hVgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150343; c=relaxed/simple;
	bh=lBLZ1tsh4f74pQ3mA5Xm/Qr25AJkIJe2nRw9srQyT9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0deHrawSeQ2yUlkbCfDtZRjGUGX2OaQaBghMQ+3bbwgzqgZK6hBw78doGTTEG1Yx5i9LTwtylw+xB9krb5/X6ZGz9ZHCCJm027XD5fJ9iw0ja4UUVWeFtIA61LHn/+lDIW8ooNuC4zD2G5UPU667aLT3odh0gy5NMnP3hjcXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFT6CNPr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFT6CNPr"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1600d040e4so357001766b.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785150340; x=1785755140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hYFROhFKEY3a6ZuQeJdM1K/C2vH7YwA+8ys4N7LWz7M=;
        b=WFT6CNPr9ct7J5fG6TzCr28+DmAlAXSyVXuaF7P2NiBOw6T5rhFcI+xceaaxKF/rXT
         L7dkT0dNzNYvYYhgrjQbZREvQVKYcfqH/QnoiQqeHxrpkaw+6v2Ky1bR1cgjbQlH9wsP
         EZS+jdkUcEu/ZGWRi6ol3r6b4StaNyr82A4TvjT9SB0eTtzullTQZexUXTRVUjGytKd/
         V1JVR9gaGZ/n4GBKGpx3pHymenV6t9T5M7wE0V2VGmANVHB1XnjSIInpsLovy7WOn1Ie
         XOC0WwOJ+0e8JbSWBTDXHpcSB4046hJuBXUEw6C3EV05tZBb0lHzRAxPip/z0CQT7okT
         kDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785150340; x=1785755140;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hYFROhFKEY3a6ZuQeJdM1K/C2vH7YwA+8ys4N7LWz7M=;
        b=U/yRxQu7yerAWzCEkAx7ov//hx0/Rb4HIy4zRXgNIr/wskCLQ1hV6nX6gxGScSI+Zy
         8JabKVI6ehxPDX9mA07SFZ/HBeOlVOAypAQfM885O9yeoc+wnOWApgyJlqqonljPt12L
         o5amVk9bXQP/6od6k9Fj+q+6/QGp50dwSgfoGgBELyJTNn8fMsNlHIGlbWuqBjUeicFQ
         9hClgxeWclvATcHZxY8Nxoz10fGCoH7ll9m3ScyIFeV58rS06v3BmCCQp5va/JZREymQ
         ho9z8yJhQfjou88ZRfgiK7pCF1bknTs1ptM7CfHE6Q55k6MjCXfK9AF7QRLQhSSBhGvo
         nyUQ==
X-Forwarded-Encrypted: i=1; AHgh+RolsivasbYsdIE0fQCdWPNkSZAma7faSH8u85W0ixFfe4K6umt6s/5zS3bGkp4kzYHZoLFHLII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JIeQPWKNLB323/bBeHQhd0qEaqvFit21cTwAPD1YI1HPydCR
	f9R1xxodEmxB8krLfVmCC0lQlpxQMPJpK9ezsXDL7nqhsZ9FPU49Z/XU
X-Gm-Gg: AR+sD13FjJj3Yio/TJCtcJeNjcLAzth6Xfuu4xQ6ARetfF+ge9zbL9QHUW+K+5nEOPm
	DDl9UKjIwxCmACLzMRv0ELKrxqBvzIf7Pxj64OEv6h3VqujJE/Nxc++K2ID1zk2vPVew5TOdxmO
	g2r7FwaAo5y25+55YevvY5wwM6HA2+UgH74/0I6MvJDTdDaV4VxicVumz5191phvS1owIY2C8A/
	1hppecD3UukfjZKDMKK7VL28TQ6u2FKPyYEKERmEFe97p4/4Y/b1oBiEGEEzSUmnsz5Jqr8cS6k
	62/Hvfkq3A0EPUVjIXMM2q2F1T3fDOg8WZF0pYFEqnysUJ3kpvExtpuiFT9zRPspL7y3QiqNYiy
	/uukHwrKvdhjZ11HekqTChaifQcF9SHWbGAap+t0w/Zkns2JYViRC6Umu1C36B8bhD6XyoKLWSz
	UkSfKi8Zs8ko/Jw5wV89N/2GGHPEmaBLDd4L6n6FfnOk9AcH5saPiBRMG/fKntAHBDtKEG9R4G0
	Jk97T6TJohvVY1LCp6jqx1C/NfXWfBod0qr7g==
X-Received: by 2002:a17:907:7ba3:b0:c12:7f75:7900 with SMTP id a640c23a62f3a-c1f1fdf39b1mr352714466b.27.1785150339883;
        Mon, 27 Jul 2026 04:05:39 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:4f63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32c8f7a2sm639435466b.37.2026.07.27.04.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 04:05:39 -0700 (PDT)
Message-ID: <58a645d1-7e42-4b02-817e-78ab81ed1b6d@gmail.com>
Date: Mon, 27 Jul 2026 12:05:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
To: Mina Almasry <almasrymina@google.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>
 <amJOXKql1nbskGZJ@devvm29614.prn0.facebook.com>
 <CAHS8izOAgMX4wSbyUpSLGD_uo7G01cSqnMvrXP9KDdhrYrjNCw@mail.gmail.com>
 <CAHS8izOS9C63UMvVN=Z+enWkwFhPr9Aa69UZE4dkUOL_JyGUGQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izOS9C63UMvVN=Z+enWkwFhPr9Aa69UZE4dkUOL_JyGUGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/26 18:25, Mina Almasry wrote:
> On Thu, Jul 23, 2026 at 11:35 AM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Thu, Jul 23, 2026 at 10:24 AM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>>>
>>> On Wed, Jul 22, 2026 at 12:49:07PM -0700, Mina Almasry wrote:
>>>> On Wed, Jul 22, 2026 at 3:59 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>>
>>>>> We should either have net_iov or page backed frags in a single skb,
>>>>> otherwise it blows up down the stack. Don't allow mixing in
>>>>> zerocopy_fill_skb_from_devmem().
>>>>>
>>>>> Fixes: bd61848900bff ("net: devmem: Implement TX path")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>
>>>> It's true that we don't support mixing niov types and doing so would
>>>> blow up, but this is an unnecessary defensive check imo. The calling
>>>> code should not (and does not, I hope) have an edge case where it
>>>> tries to mix and match niov types.
>>>>
>>>> Maybe a DEBUG_NET_WARN_ON check to help catch bugs in the calling code
>>>> may be fine?
>>>>
>>>> Also we don't really support mixing different niov sub-types in an skb
>>>> (like IO_URING + DMABUF) afaict, so might as well go the extra mile
>>>> and check that it's all devmem niovs specifically.
>>>>
>>>> And might as well put the check in skb_add_rx_frag_netmem. It's the
>>>> same situation on RX, we don't support mixing there (and I hope no
>>>> code path leads to mixing today).
>>>
>>> Hey Mina and Pavel,
>>>
>>> I was able to confirm this mixing case does exist.
>>>
>>> It looks like in tcp_sendmsg_locked() when new message is non-devmem (zc
>>> == 0) and tcp_write_queue_tail is devmem, the skb collapsing is allowed
>>> (though same-frag merge is disallowed).
>>>
>>> Adding a mode to ncdevmem that sends mixed devmem and non-devmem
>>> messages, it can be caught hacking this in:
>>>
>>> /* DEBUG (DROP ME): detect a TX skb that mixes devmem (net_iov, unreadable)
>>>   * and non-devmem (page, readable) fragments. Such an skb must never exist.
>>>   */
>>> static bool tcp_dbg_skb_frags_mixed(const struct sk_buff *skb)
>>> {
>>>          bool readable = false, unreadable = false;
>>>          int i;
>>>
>>>          for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
>>>                  if (skb_frag_is_net_iov(&skb_shinfo(skb)->frags[i]))
>>>                          unreadable = true;
>>>                  else
>>>                          readable = true;
>>>          }
>>>          return readable && unreadable;
>>> }
>>>
>>> static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, ...)
>>> {
>>>          ...
>>>          BUG_ON(!skb || !tcp_skb_pcount(skb));
>>>
>>>          WARN_ONCE(tcp_dbg_skb_frags_mixed(skb),
>>>                    "DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=%u len=%u)\n",
>>>                    skb_shinfo(skb)->nr_frags, skb->len);
>>>          ...
>>> }
>>>
>>>
>>> Resulting in:
>>>
>>> [   85.908005] DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=2 len=24)
>>> [   85.908342] WARNING: net/ipv4/tcp_output.c:1570 at __tcp_transmit_skb+0x9bb/0x1030, CPU#2: ncdevmem/278
>>> [   85.910646] RIP: 0010:__tcp_transmit_skb+0x9c2/0x1030
>>>     ...
>>> [   85.915617]  tcp_write_xmit+0x47b/0x17d0
>>> [   85.915802]  __tcp_push_pending_frames+0x38/0x100
>>> [   85.916025]  tcp_sendmsg_locked+0xe51/0x1280
>>> [   85.916244]  tcp_sendmsg+0x2c/0x50
>>> [   85.916903]  do_syscall_64+0x11c/0x610
>>>
>>>
>>> My feeling is that we should guard against this when
>>> tcp_sendmsg_locked() is doing its "new segment or not" calculus.  In the
>>> zc == 0 case, I think we need to check if the queue tail is unreadable
>>> and 'goto new_segment' if it is?
>>>
>>> This is a different case than Pavel's patch addresses though, where the
>>> new sendmsg is devmem and write queue tail is readable.
>>>
>>
>> :( Yep looks like we have a couple of bugs in the TX mixing. Sorry
>> about that. We do indeed need to fix this ASAP.
>>
>> I don't think it's enough to check readable vs unreadable, no? Because
>> I think appending io_uring niovs to a devmem skb will still blow up
>> and vise versa, even though both are unreadable, right? Or is io_uring
>> saved from this somehow in both cases?
>>
>> If io_uring is vulnerable to this as well, then fixing this becomes a
>> bit more hairy because this is a TCP fast path. We don't have bits in
>> the skb header telling us exactly what the skb memtype is (only
>> readable vs not), so we'll have to check skb_frag_is_net_iov(frags[0])
>> and netmem_to_net_iov(frags[0]->netmem)->niov_type to check the exact
>> type of the skb memtype, and that may be a lot of cachelines to fetch
>> in the fast path. :(
>>
>>
> 
> Responding to my question here:
> 
> So AFAICT we can't actually have io_uring net_iovs in this path.
> IO_uring ZC deos not support TX, and (the LLM) thinks that if we

To be specific, io_uring doesn't support net_iov / device memory tx,
zc with normal pages has been around for a while.

> receive an io_uring zc rx packet and forward it, it's still not going
> to hit the tcp_sendmsg_locked path.

tcp_sendmsg_locked() only takes msghdr, there is no way to pass
net_iov into it directly. The only way I see it might be a problem
is if someone pushed io_uring zcrx skb into the write queue. I
don't think it's possible but might be wrong.

> So this seems sufficient to me, Reviewed-by: Mina Almasry
> <almasrymina@google.com>
-- 
Pavel Begunkov

