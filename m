Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466111D63E4
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791054111; cv=none; b=e6nMRa9ZocHKLEFnpV0gKJt5gIKg0w0oVinbuVCiWDY+glxCFE3YUUEblttsB0zCiqUayi4VhW/PQWfxuBGDPQf/g/U9JBYnXTQ+D9B47D0c7YQ7N+t/0p9qfW/taSKHIVkgIsoj+Wbo840VTTsMt/vczVeP/oi1KbyUm/5EMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791054111; c=relaxed/simple;
	bh=48MhTw9wDTWEKEZw4bUxBTpp1TwSf7rxa59pL1W+mKg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kn5QrZ4eQk8m8MhtUPMXBIhqc9VrzMP8hwmIr0fHbzxZDSEdeZ8zDswzDA6VRrjSZvGPjgFl6INdUHykOa7wYfElpzQvFMQ7fIFBvxvtu/En8kH8qAppWoXVy2h/EOODQVbGxnjXiAj+I9te9syYcHHUhsv6Q3XHpuSn9fXvr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1hWPjWe; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1hWPjWe"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-67567ff2e77so443018d50.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791054109; x=1791658909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sXTMSYgeBEoDskD3IWbphONoA+AtnWoFnnYeCTTaSZw=;
        b=r1hWPjWegVV4xj+/IzTFcfoEwodLN/AlnoV/WfRmbA4Q5/6QclO9YxhXJUtX8FtJzI
         ysKSEX+wCY2WN+0MD1q43RgVSJbXJV8NydVIVuT/Mfk5jw3iivnwIVPHBkbsO+iFxfbi
         D6UdepomsJAnRsb2qC23dboqum5I/hN/5CkrTfPtqAFdWL3h6st/BW79NNVYmhWGlte2
         +cl+q2kD7HzyBofED7DBTCurxhoQaL/twpdRpijPnYnBYGrqssKexs5ArRs5fF6nU8XK
         7w4s5KJmB7jmE+2AaB8J3mRhCXtv/OrQBOM5gXFK/fvsvn/VIbnGQr4NSZbPRypSVh92
         Om6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791054109; x=1791658909;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXTMSYgeBEoDskD3IWbphONoA+AtnWoFnnYeCTTaSZw=;
        b=ZuWpvAflxQ+Qj8qvC7S7x6VW0mzY+2k7QyhCPcZ8yMDUl0CSbn1FuQbnKcM/uGd93C
         TCNsalK1/DPnhihJOruBd9SOKTXJLZY8hgIneroTcqTD4mD3rKKEfuM/4EoFgIqFdJWl
         dwRSWSwegtEwiHPhulizkrpLm1MBuG67tuWsEYhU6ks2mQKKeGRAQmBhMP3+ZXxiuycz
         Ws+8Y4r73RfnwJx6vgrIOxcuzByBCifJQ7H9+WAB4nd5cFQH80YUV1vHjiaGiZWIG5j5
         xP/O6pZvViBAsA9LQITohybZ4nDaS9/i7/nncGSGEbCeqfwWJmjm/msOj8KQK2WxgCFT
         is7w==
X-Forwarded-Encrypted: i=1; AKwUvByqfKlFHl//iIP2qN34SuENh2DUfZ7U93Lw7NqaAsHHwshk1ZEhFHbkdxi3fAIL/WthzAticjs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsMQCTc2300KvEodlPUn23JF9uYm6RSMOkRALRlwJl311MkDT/
	TNddW8ja+TH00TMivMX5jV/3H5Ss/C6XVvC8pbXEySDNcC1GMHiYQwEF
X-Gm-Gg: AYBFou0tNuCk/Q236ltcSCQY44OrBh8MXnbak2Y9GTeNLx6RLFPh9lD3KgAcwchPZ2J
	bedzEYCYu7rh+/0pcqTER9btYwSJ1TJs5iYf3VkV8+EWc4y5P9kkQTLZxnFB10WiDcRa+QjSdb7
	X2PwqpHCJ1RKW5H4NqQLvoTd1WlUpQjID63fDS0CHJ4Db34bXev1bPtqczuLdBiHkcRCsLgVMZo
	1yIsR5qVA+3/uYFPfhHp9oMp9sqM4ykuaTd1dnTUfX4E4FiYmXeLFT6Nx3P8SG/5lmxk/bUvdhN
	L2seNKJmIrbgnk1GuL9tx84ilMijS3o0F2useHxlnFXH6mq/Tll76638/WHlUHIXWjwUQVRaoL6
	CmsexlMTwUI4zjn0if85teo4ckvapCbGcHdTko8UPzbzW9wRNOSMNBs6G1xRyq2ckD6mrk5QC0d
	ltVdZwsgalDRqng0LuSzR8TIAouqrGlO3y+3MHwHF5+SrZ8gnZo5Akf4GcKyrtitB0lzlBnEejq
	j+GBA1I3tMOnUOL9yIuGrwfbqltneepk0rdsmGTMGB5cCFRRy2j
X-Received: by 2002:a53:ac8f:0:b0:677:ae5f:927f with SMTP id 956f58d0204a3-677ae5f941dmr2335560d50.106.1791054109124;
        Sat, 03 Oct 2026 12:01:49 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1bf368esm906480d50.20.2026.10.03.12.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:01:48 -0700 (PDT)
Date: Sat, 03 Oct 2026 15:01:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>, 
 netdev@vger.kernel.org
Cc: Martin Varghese <martin.varghese@nokia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Alice Mikityanska <alice.kernel@fastmail.im>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org, 
 Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Message-ID: <willemdebruijn.kernel.d7c5ac3be7fc@gmail.com>
In-Reply-To: <20261002153039.462663-1-yanhaishuang@cmss.chinamobile.com>
References: <20261002153039.462663-1-yanhaishuang@cmss.chinamobile.com>
Subject: Re: [PATCH net] bareudp: set the inner protocol to the protocol of
 the packet
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Haishuang Yan wrote:
> bareudp_xmit_skb() sets the inner protocol of the skb to the configured
> ethertype, and bareudp6_xmit_skb() does not set it at all. The inner
> protocol is used by skb_udp_tunnel_segment() to segment the inner packet
> when GSO has to be done in software, for instance when the lower device
> does not offload the checksum.
> 
> With multiproto, an IPv4 device also carries IPv6, so the IPv6 header
> is parsed as an IPv4 one. With IPv6 underlay, the inner protocol is
> whatever the skb had before. In both cases segmentation fails and the
> packets are dropped. With veth tx checksum offload disabled, iperf3 TCP
> over bareudp gets about 10 Mbit/s with thousands of retransmits instead
> of about 700 Mbit/s for IPv6 over IPv4 and for both families over IPv6,
> while IPv4 over IPv4 works.

(not for this fix patch)

optionally tools/testing/selftests/net/bareudp.sh could run a stream
test besides/alongside the ping test, to exercise this path (with
segmentation offload disabled).

> At this point skb->protocol is the protocol of the inner packet, which
> bareudp_xmit() has already checked against the configuration, so use it
> on both paths.
> 
> Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
> Fixes: 4b5f67232d95 ("net: Special handling for IP & MPLS.")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
