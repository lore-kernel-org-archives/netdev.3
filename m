Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D543A83A9
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028791; cv=none; b=EwpNL+yi2V9Xn5CWMYvlYDD/+NvtXxcyL/YSRjpSQbRhywizry7sWDnaTMVfZL4j/OxNfOHcDoxCxUc1bVvs4Af20Cf2EKkP+/gcohhx1hmAP+2+yvgEuSLghRc3YXU8KYzPROh9PQLxgV11cgEABrzSRBWqB1gn0gTz84OsloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028791; c=relaxed/simple;
	bh=9561b7niqn0AoK8vxNZecvDmZ7DoOcHXsP3+5ybV3/E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gk95TwhNq3VxCJUpoZyU6atNyBZCuO/FD6wRf+puogAiOGmqAfRJawplox9j8wmCB63gr+GE1xFH1e+1f/vrLSyFzJ4J3hT4gB8qvfpNQErIEIFovOOFQA1mM8d2/1IxyEC87SER4EnVVgvRd3iIC3pGtWDKtONjuSpsUko8OjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pe5O1bfT; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe5O1bfT"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6681e7911b0so3355602d50.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786028788; x=1786633588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ja1PiQAYHhNbzA9wF5bI95C14lIdSvb5kNTNlBGbiZM=;
        b=pe5O1bfTyyUKSD8Elibq72CFxIdFah3qAQuSOEg5iJRRqZyL+V9lgTmlruhALjr6sq
         BFFY5ph6gtA7OoK4hLygave0fPZoYveoVYUMwMTCU2Y8Mpd1hFmHWr69H0SweXfPk3Cc
         CK3yaKfcsyV5alr2n9i4moHDw+mUnz6d8mzvdm8aJMW1rzGmHWjcmUu46xHUPSdwjivR
         VD+POnESKFTeZcpqhvcHXRveGTjhxVRxwyfpjSAAkAKMXWQW8zuUUdC+JfN0Qf6hSul2
         Dsb8pocVBO8fclIfvQHERqtlVWAmWVyyoxhxY/JxzevlZcDqwboxkqUwZvVSS2RlfxEb
         xVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028788; x=1786633588;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ja1PiQAYHhNbzA9wF5bI95C14lIdSvb5kNTNlBGbiZM=;
        b=OTPQ7hABwMJrKQQKMsFvwV9lDyGzmovIJoiEmTTff6Viaz8Z8qqen9i4A/SxpzSFph
         t6i2PVgwnRyYubOs/v87Zy6dEHQA+rIWXu/u12He7y1rskCwoZaS4l2KaV20Nohi/88y
         XOv0lVbE3Uylp0QBTcEWl6vkdeWIrAu7eTELaVM8QodVYXbrqDWWGl69sG0YmGkJqTlh
         89sU244VTu8Oh2WVI3ozPJ73VH2OrpuXIUjVPc4G+MdSa3XMDObO06mdV9n+P/8W85Kx
         1kBXDL1jZ4mVhi0jPbtuyJjJ2wq47ZH7EpD+W+5uU20zycIwhdcw6y2gEFHDPv2l6C+P
         fsTg==
X-Forwarded-Encrypted: i=1; AHgh+RrZSzzczhZarDRNSfHrmztQKgcy6y+I0SNLUd39VmFyy6cwj7nygtzkyRm8XlNk8d8VoemfP0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0XoNGSwb+fsf+1wiiKppO3juUoaVeabe2V67ouP272gfYe0qW
	BLR2ZG002E8WB6B2wsM6DyZqI32tRm/VU9iNM7DLlRNrRrRVee8W1SL1
X-Gm-Gg: AR+sD10hff7hU3HY2K1UPO/HeSjiOtPpvVqKntzQ/2i7AbZ7L9Jv4u8I3Bq5k0lfjiy
	7TKWX5BsxYus70g/tXlFYw66/VRQCSwdiSwMUe17AJ31ewJ5Rkpky5qoPtF0gFpXIEX9/KJrRQE
	VzuZj1VOhrE2XPdfZH6qGDH+XZrL91UtfbGrSdC4YTfHYh+Cq0EzoZka/bfPQfoI8xSL5skld3k
	Ehzw7heN55P7bfyKaaA86jLTx83V0b8M7o1mp/8lDEfaYQahSF2AlDacab9Ups+dzGQ2hehbtPF
	dxESTjfdXkOsawqk+NGTsde68wVVSnQLaz+km22FNbgguxaXgf5r5Mfqoc4CzU3sJ9hI4/OZrA7
	Cdwuo0VzsZC78oSXi+kOMxvUklJz/Fzt1pC5Oyy5w9Zcq9xOmu2jSHPVTOERI7r8QWzWsIB3uRk
	RNzOP+KxxNXSPaVwQxOM3+JU9sUoYx+3mq05nfTJUx9TC6O7wnWGDnY4gwOBn3Yp0WBtRuqAi/a
	MIy7h1RvdwkQl8ML0JyQA/MJ7feN/VrjjXY
X-Received: by 2002:a05:690e:11cd:b0:668:96a9:e70 with SMTP id 956f58d0204a3-6699ac8dd0cmr8435506d50.51.1786028788355;
        Thu, 06 Aug 2026 08:06:28 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669913aeb1csm5180549d50.5.2026.08.06.08.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:06:27 -0700 (PDT)
Date: Thu, 06 Aug 2026 11:06:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>, 
 syzbot <syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com>, 
 vadim.fedorenko@linux.dev
Message-ID: <willemdebruijn.kernel.1472260eb7745@gmail.com>
In-Reply-To: <a2f88a4b-4105-40df-a46c-f1bc0f67af1f@app.fastmail.com>
References: <20260805205957.1652619-1-alice.kernel@fastmail.im>
 <willemdebruijn.kernel.220b53c78c5f4@gmail.com>
 <a2f88a4b-4105-40df-a46c-f1bc0f67af1f@app.fastmail.com>
Subject: Re: [PATCH net-next 4/4] net: Fix UDP length overflow with PMTU
 discover and big MTU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alice Mikityanska wrote:
> On Thu, Aug 6, 2026, at 06:26, Willem de Bruijn wrote:
> > Alice Mikityanska wrote:
> >> From: Alice Mikityanska <alice@isovalent.com>
> >> 
> >> This commit bounds cork->base.fragsize to IP(6)_MAX_MTU to avoid a
> >> possible overflow of UDP length that triggers a WARN in
> >> udp_set_len_short when setsockopt IP(V6)_MTU_DISCOVER is set to
> >> IPV6_PMTUDISC_DO or IP(V6)_PMTUDISC_PROBE, and a large packet is sent
> >> over a netdev with an unusually large MTU.
> >> 
> >> Steps to reproduce (included in the new selftest):
> >> 
> >> 1. Set device MTU bigger than IP6_MAX_MTU (or IP_MAX_MTU + 20).
> >>    cork->base.fragsize will be set to that MTU in ip(6)_setup_cork.
> >> 2. Set IP(V6)_MTU_DISCOVER to IP(V6)_PMTUDISC_PROBE or IPV6_PMTUDISC_DO.
> >>    It lets maxnonfragsize be set to device MTU (cork->fragsize) in
> >>    __ip(6)_append_data, rather than to IP(6)_MAX_MTU.

In __ip6_append_data I only see

        if (ip6_sk_ignore_df(sk))
                maxnonfragsize = sizeof(struct ipv6hdr) + IPV6_MAXPLEN;
        else
                maxnonfragsize = mtu;

> >> 3. Send 65528 bytes of payload (+8 bytes of UDP header, +20/40 bytes of
> >>    IPv4/IPv6 header). Device MTU allows it (it's only one byte bigger
> >>    than IP6_MAX_MTU or IP_MAX_MTU + IPv4 header, and the device MTU is
> >>    bigger than that).
> >> 4. The UDP length in the built packet is 65536, which overflows the
> >>    16-bit length field and triggers the WARN in udp_set_len_short.
> >
> > This is discovered thanks to udp_set_len_short, but is this a
> > preexisting bug and the fix go to net with a Fixes tag?
> 
> You're right, it's preexisting, it can go to net.
> 
> For the Fixes tag, I'm not sure about the first occurrence of this bug.
> It could even be as old as 1470ddf7f8ce ("inet: Remove explicit write
> references to sk/inet in ip_append_data"), but I can't compile this
> kernel with modern tools and check myself, unless I bring up some VM
> with an ancient distro from 2011. And I guess, it could be even older,
> as corking existed before. At the same time, something else might have
> prevented this bug back then.
> 
> If needed, I can try to do this archaeology.

I also suspect that this has been present for a long time, given that
your repro does not exercise anything particularly new.

Definitely no need to try to reproduce on an ancient system. We can
estimate the introduction based on code analysis.

In practice, most important is that the Fixes correcty identifies all
relevant active stable branches that could use the fix. If helpful, I
can also take a look.

Aside: I was not even aware that devices allow setting a device MTU
beyond ETH_MAX_MTU. But loopback indeed has no dev->max_mtu and
accepts up to INT32_MAX.
 
> >> Note: IP_PMTUDISC_DO with IPv4 is safe, because ip_dst_mtu_maybe_forward
> >> always clamps at IP_MAX_MTU, unlike ip6_dst_mtu_maybe_forward.
> >
> > That was introduced in commit 14972cbd34ff ("net: lwtunnel: Handle
> > fragmentation"), the message of which includes "This includes .. some
> > mtu fixes" without elaborating on those.
> >
> > That introduced the same clamp in ip6_mtu. Which was removed in
> > commit 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
> 
> Looks like it could be by accident, it's a refactoring commit. The
> similar change for IPv4 in commit ac6627a28dbf ("net: ipv4: Consolidate
> ipv4_mtu and ip_dst_mtu_maybe_forward") preserves the clamp.
> 
> > Tangential to this fix, but maybe that should be reinstated. I don't
> > immediately see why the two would diverge on this point.
> 
> I agree; even though the output case should be fixed by my patch, it
> might still be relevant for forwarding. Let's see if Vadim has any
> comment on the history of the above.
> 
> >> Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
> >> Closes: https://lore.kernel.org/netdev/6a6a966c.86abc875.e5c3d.0054.GAE@google.com/
> >> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> >> Assisted-by: Claude:claude-sonnet-4.6
> >> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> >
> > I only see this patch 4/4. Is there more that did not make it to the list?
> 
> Sorry, I sent it like this by accident, this is an only patch in this
> submission.

That explains. No worries.
