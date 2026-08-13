Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119F43F0AA
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615237; cv=none; b=VLSR0Ute7ld86SkQXYlujpV6ctz3BVGyj7N/z4x9dFtHW5TWKcaxDu1DTlGRgkUxMqUIcR1Xh7bR3icQigN4pR0yHTzawcbqohAmtTPF/6mzBivjSxs78wQjFh+xFyeXpx2ViUl6TB+zL0/w0zZdTme2q0gtfnyCi1ItLtVVHWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615237; c=relaxed/simple;
	bh=58Id8x4No3n679aPq5+FKQw8VwQFEBY/1zvhYhI6VOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stlfjEmECwUjMtiwHUH8Cv9ysOzbVZ0zP28vdxVUwTfO47jM/aUncTTB2dV5YSx9hMpc1neSsfDaVIHSG/6IqjIrudUIWtFjUUoV5n7Vi29Ehp1Ob+0o3kxiOPzvfMaVi2HdA171wWdszvvaja7htw0cW3JPStNcQ0m2wu86FYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15e0279316so79242766b.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786615234; x=1787220034;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awwxkxi9x+2S05Fh4flmiuD/sJwS76BaZjp2hDMpfec=;
        b=hx6aeA8Kz9+5qlVJ4d2Ds3cURJcmHOtQ+Efqc3m1ffeBg9xsym+CXGlQiF5JInj3Oq
         1CqCSfShFoLRJEp8u9jXgT/crIyDhR5618Wf31iZp0ZPSSe/ckCLA8go3Ww+8WJkvqzc
         1BzVoI+hpaFfrVDtlzyXYhoSZ0Q/6aYGKPlXVKVrPdA94X34G9sb4RpIwW4xL8cpai0n
         a2FKqhkCbGdYVgYSTNQwsVCH7lHhnZW9GJQRKIsHqa/v5NAXiv9U/MtTT3FkP+EezCTi
         718d4DHDv6soG/BjlDmrjVVAATFfRbmyB/4TEIwK2yRm2zAtCSHVA1kZOOueZeJ0KhJG
         Z8lg==
X-Forwarded-Encrypted: i=1; AHgh+RosWQNCuOXMOwVlqxcF0pt+Iv3EIj75V+IAIfflT+EOH3xZ0ExBojfRlnP9zkzqJnsuuhhsyjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXVuF64RfqQwPoej88zvyySCX65figy1OnnXS2i5cNv9gbA4O
	QmMiNk6qq8jZResLn5gvzScZ7IDqsS31pnp1JCPdzgr409kCG+rmbGRj
X-Gm-Gg: AR+sD11F4OhmI3VSUVVbkuTOW7yRFR50ucWUjrDvJaGzagTmNyJezsWur8me8HNn7MK
	ntUR4QjyX46Usw1kmC6qnJBlVRkBmK3NjY5r+DQ2oQUdoT0eAon1d5oN46lPkc5mKrF2Laa27UD
	9ad1fpQffMCjT57q1YfOTv0j6eSDHKDrtTmXba/qQEvr1F1iOV3dSif/g3kJtwXpZ3eL3QsfMg2
	3K2YknsVTePe2HavXdFdFn5GW6O1UJg1zrRd42cEeJSQ10Y3ayggCzMLO76a9uQuPi/ij43867U
	czJiTf0Pfuuv6y6Gj2mf/bNT1JRlkyb4YDexbVowLcUS/zrKjq9CtHfEhEOdOxuJ+UY0gADaUVH
	csMy9DaE29D81xCyewGhUwfIQzilTfVrVmayDLw4ntnE9K5VXOLdwwyYowMjpR1MBFZvqQk1ymO
	GRQ57XBE85B53WyTZedjX8F0TCBVrN6vzbcJ7UhsUXWmO2QWRlvrtP4657+FjYAoqkYDwvBJyDI
	Jo37Kt76Z1Fgnpm
X-Received: by 2002:a17:907:e00e:20b0:c21:1546:97e6 with SMTP id a640c23a62f3a-c2115469938mr44557866b.9.1786615233396;
        Thu, 13 Aug 2026 03:00:33 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c210848c8fcsm68328266b.25.2026.08.13.03.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 03:00:32 -0700 (PDT)
Message-ID: <b20650c2-1adb-4902-b2b1-9bca91b95dec@ovn.org>
Date: Thu, 13 Aug 2026 12:00:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] openvswitch: only skb_tx_error() a packet we are
 about to drop
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>, Zoltan Kiss <zoltan.kiss@citrix.com>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com>
 <C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 7:47 AM, Norbert Szetei wrote:
> queue_userspace_packet() borrows the packet skb -- it only copies it into
> a private netlink message (user_skb) and does not own it; on return
> do_execute_actions() keeps forwarding it through the flow's remaining
> actions. Its error path nevertheless calls skb_tx_error(skb), which via
> skb_zcopy_clear() does skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY,
> stripping SKBFL_SHARED_FRAG from that live skb (skb_tx_error()'s kerneldoc
> says "skb must be freed afterwards").
> 
> For a MSG_ZEROCOPY skb carrying page-cache frags, SKBFL_SHARED_FRAG is
> what makes esp_input() skb_cow_data() before in-place AEAD; once it is
> stripped a later local ESP-in-UDP delivery decrypts in place over pages
> the sender does not own -- an unprivileged page-cache write (the
> "Fragnesia" primitive).
> do_execute_actions() ignores output_userspace()'s return value, so any
> action after a failed USERSPACE upcall inherits the stripped skb.
> 
> Move the skb_tx_error() to the flow-miss drop path - the "default"
> branch of ovs_dp_process_packet()'s switch(error), before kfree_skb().
> 
> The call has been here since commit 36d5fe6a0007 ("core, nfqueue,
> openvswitch: Orphan frags in skb_zerocopy and handle errors") but was
> harmless until esp_input() began relying on SKBFL_SHARED_FRAG to gate
> in-place decrypt; only then did stripping it on a still-forwarded skb
> become a page-cache write primitive.
> 
> Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
