Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C073515DA
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790537097; cv=none; b=o+AE5Hmq/rc67udmROq7uR5KkhwU6klzPe/Pb6ubSqmCVErUZRpVz+r4pGjlRCOqnzkcNC4gkLiUm5UibWilAeEHWhnTadUc2WX6xZKUCQGl1hTSM3pzrJb35TvtOtEGN4arpghG+SMg7DxoVL8rjA8zPEozk/GoSt39kUHPEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790537097; c=relaxed/simple;
	bh=Dp9wPswioURzkW8Va7C1UQ99bgvhuEcITSHusdYwQRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdpddjo+3IN7u3cM60XnHcPwxkfgnqi7NzOKsy977h6i6XiUl59bxdNT0OkyrjNLMwXzhV3ghVIWxlFeu24/5sz8nqJLX8vPwsnWN7ZDC0vgtMvXaVNfn5BwIMAz/4GRpA2H5MKawG2SGC43sqmXac6K/H2Q/6IU0PcDZnHWnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pphlVJ3x; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pphlVJ3x"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso1662188a91.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790537095; x=1791141895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2CQ2K8E2/A6WclAi3T5/0KLteh3oTlkJh6LPUhY74zY=;
        b=pphlVJ3x94rk7MeQmXBmLDsriV9OwMjCm7+Tah3CXT4S+WvbcWEROfAjiWyJmH9iqx
         GxfjPGfXqdqNqljlA2IYje4tWt1lUfDOXL7i4/R56GMypP08ZgVfBqJUEGdRBO65rdik
         Cro8l84mzXengCOi+tUvZ33zvFEK8ySqQuQrL1y1qeuV3RTRZSQkAfwsk2YKvhedsJL7
         4r7s5JcnYUe2gMmUCT8Wt59QR3rZq11Cvv4sfwPYIvhTk83UV8i33dDhL2uAI//6Hida
         23rRsRMqoAPsidtk+w7/7maAI8mpjt2ChLhEbz6g05ae4Q1vNFZbOJQzL2z7ESaBVCee
         qV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790537095; x=1791141895;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2CQ2K8E2/A6WclAi3T5/0KLteh3oTlkJh6LPUhY74zY=;
        b=LftVkPG5wEJeRRXnBLBgS1FHRrDm8AjnsklVZ27Ikh3Xsyf3ZXeXrERvbO2Ubrd6FV
         nm/CDdCAm5f/wlO2ivuJ3dp90llipHP8KId6X9DbngnHWiOFyMLdyta80ACRqwpJCjOt
         pM2Jl7N1jAVp4AhcZBvBDqmMIu0KdIpOLcr6wdktR/TI8OHQQ8ClT6eUUTWMouUuO/cc
         2pdBEDFs8+9msVoQxK9Ql2e/yf8s0BCmHHicdS1Kc2JKtE97q2eI1B37/V5my30mGYmQ
         E/W44a9OTDngk8DM4OQX1aGYkyp5FTsVUlltZmfa6ALl1hNE/5PjwYQXl/ZFxcPUZwRe
         EYtw==
X-Gm-Message-State: AFq9FYKQs63gXCvBfQj77C9b7HvSIeFvpcwrtlIMv1QGHF+himv6Tv3I
	aU7ha/AKtphuR1nUUIMtO7za2uNWDTn9tp1kRMeheBKhK5QNr87LWOIT
X-Gm-Gg: AYBFou3+7Do6MaI5iR1Ruj2Ot1Q3FdHX+5KsFiT9iNQrfZHbeT8Y6U4GIHU+FJ0pc0W
	YxJirNLYOX3vlLxlucmKxfh8KgcJWPORck9M0znNHZQM+FiyrXHMPDQG+M+qQ2x1+0Jya7k7qrj
	IT9ToDaFyLcSRr71wjw/OzrxTlplL+zcm1for3KP80Mb0PQXXVS7oVUMF22Pzxy6PmbMM/W+sPQ
	0IT9ogq42hng5L+E1gXO8y/4X7RiSdPH+dYYdPb7bErmLlyXZuAtIM0PKlyPijaYbCDGHKK+v72
	KCe4Yde6T6/M0wc/EoSPQl6ORmggRPC+TF4heyDDucPwYWyesbDSLczEehQyLF/Uem/gQwEXtfO
	+u8w9G7guyhcbeCFBcjWgiXgHGxg/rBnBq5iNS7GyCB1xEaCzJ64z1gRmytAmG8xnD8sam3Iu0E
	ctvpoTQm1K/mm6MGMlw6P80cNQc380V/b4oVXIusZGc/DK59/Mr+HA3I/ZhxIVtG/urNmJ//c=
X-Received: by 2002:a17:90b:4406:b0:39e:261:4e0d with SMTP id 98e67ed59e1d1-3a098b4b1a6mr10272886a91.25.1790537095334;
        Sun, 27 Sep 2026 12:24:55 -0700 (PDT)
Received: from [172.18.0.1] ([104.28.240.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c719f86fsm13786632a91.7.2026.09.27.12.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 12:24:54 -0700 (PDT)
Message-ID: <b100f190-93fa-4ac7-a588-b95ff1d68ffd@gmail.com>
Date: Mon, 28 Sep 2026 03:24:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Gaoyang Wei <yhyxwgy@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
From: Ziyou Xu <xuziyougm@gmail.com>
In-Reply-To: <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gaoyang,

I agree that the transport and the control API should probably be
considered separately.

I am wondering whether we need a Generic Netlink interface at all at
this stage.

If the immediate userspace requirement is only transporting raw OMCI
PDUs, AF_PACKET already provides that abstraction.  Other PON state
may remain internal to the kernel or be exposed through existing
subsystems until we have a concrete operation which requires a new
xPON-specific UAPI.

The reason I still see value in a net_device is not to model OMCI as
Ethernet, but to provide the packet endpoint required by AF_PACKET.

With an ARPHRD_NONE device, the interface could carry only raw OMCI
PDUs, without Ethernet headers, addressing, ARP, or Ethernet bridge
semantics.

There is also a practical debugging advantage to this model.

A packet endpoint gives us a natural capture point for
tcpdump/libpcap/Wireshark without having to introduce a second
debugging interface.  There are already Wireshark dissectors for
OMCI, for example:

   https://github.com/0liv1er/omci-wireshark-dissector

This is particularly useful for interoperability work.

Although G.988 specifies OMCI, deployed networks are often less
uniform than the base standard suggests.  Vendors and operators use
private managed entities, profiles, and behavioral quirks.

One example is China Telecom's LOID authentication extension, which
uses the private OMCI ME class 65530 (0xfffa).  Debugging this kind of
interoperability issue is much easier when the raw OMCI exchange can
be captured and decoded directly.

Using a packet-like netdev for OMCI is also not unique to the current
AN7581/AN7583 implementation.  There is precedent for this model in
vendor SDK/BSP implementations as well; the older Airoha SDK, for
example, also exposed OMCI through a netdev-like userspace path.

I do not think vendor precedent by itself is a reason to standardize
such an ABI, but it suggests that representing OMCI as a packet
channel maps reasonably well to existing hardware and driver designs.

Without a packet endpoint, we would need to define equivalent RX/TX,
delivery, and probably observability semantics through another
interface such as Generic Netlink.

I am not yet sure that buys us much if the only thing crossing the
kernel/userspace boundary is an opaque OMCI PDU.

So perhaps there are two questions:

   1. Is using a minimal non-Ethernet net_device purely as an
      AF_PACKET endpoint itself considered undesirable?

   2. If it is, what would be the preferred Linux-native transport for
      raw OMCI PDUs while retaining packet-level observability?

I think we should avoid defining a broader xPON Generic Netlink UAPI
until we have a concrete control operation which cannot be represented
cleanly by an existing interface.

Thanks,
Ziyou Xu
