Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43302BEFFD
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021714; cv=none; b=bcjky2/Qf3HaBTUIpdSNos78tr4BpB0pAQzzRrJiJ/BaNE/tFwotkaXggTyJ9Oq/gImwYhvrcpiHXc6laIrEOsWDIM9IS6y2j7/2OlNL7bid1b6tqawbPhOMBZKWp1bwBPUQir9lEGHSU9L2Y6+yRL09R904OC4xYuB2A2id0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021714; c=relaxed/simple;
	bh=OKBgE1zco51TS+bnUGKw3JCA3xNVFMZtwavXxzMaGl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeBnsJKFmJnJwHxTjLlE4a36kkaaBspjg+dSg5uFnG9c6947w0inU5NQZ+FKq8jrglXeLY1UkxE0Y25sZUOCytvgR2cdOr4HxeYjrRVY0+pzgXD2mcI167/xkkUfZYhVw1L2Ce6M/7mzQeAyjXrOyBmHnTp/RIUK6y+mdGTCRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUHM02ss; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4lpL5Xz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUHM02ss";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4lpL5Xz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786021711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Loby3/i2NagUTDWGI/ZUcbVav8fDPEU/GK5BwQZ1+vs=;
	b=VUHM02ssyl7xA9RuAxSUr4UQNfbqd9er26eC4J9Kz9ITFMIY4QuhJ+D3TLQ2MoUt0u5qHh
	oXQ2jkcfiysIihJJOF+wJ4xSYlq3cZaZhOKk5DC8pe37/she76CVVakXOxU5TFCTnDJoOA
	VPvYgSOewptYpzYJE1XPYfS2Ha3fPAE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-vFnPo7MGMm6Bghilwsa29Q-1; Thu, 06 Aug 2026 09:08:25 -0400
X-MC-Unique: vFnPo7MGMm6Bghilwsa29Q-1
X-Mimecast-MFC-AGG-ID: vFnPo7MGMm6Bghilwsa29Q_1786021704
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f810c8aebso1242808f8f.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786021704; x=1786626504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Loby3/i2NagUTDWGI/ZUcbVav8fDPEU/GK5BwQZ1+vs=;
        b=E4lpL5Xzu8YIsdVRAQHN/gGqRTZZbhJZp4rDRzoeEzUgCoRNm+DsxYL8SA50uucKJg
         /7GpxX/UKu0TcOc1pLSRsLHD6OEuk4psPKx14kRE/425G+XfcoZJQTwqDmiSwEnAtpWF
         NPbt86QQrePGD+BjqW2zcF3zwDM/hxyBjP4ctNwRHo2d9bxDN5YHXR//1XitT3RZTf17
         Z9B/jkva6ri8senk7xgljhPPEkB9UV+LAY+h1fksjQ2KFIvsQgMiBzZDnz9KebDeBy08
         N9GFfFtB5q4O0ZfelQ7FrIFWuZOrO8N5Z+67eKC+m6X7ZJuILSvHfxJ/CGyABnM5/Vi5
         9V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786021704; x=1786626504;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Loby3/i2NagUTDWGI/ZUcbVav8fDPEU/GK5BwQZ1+vs=;
        b=UyzHwOCMN3rkGQt4WDdg2JvP0BefTyTXSvFjHJT1ARFipJODDfTWSaszcFhm3C7rjc
         vySwoI/Hmf0Mc9jg58TjWwTuasdbo9L7snxzDWlBAgV0Kl0wZfVUn4tQQOEZ0jT/m09S
         /hjHFJFU1/uNWFHfZzAogZSDpRxRVr0RJ2eDVVcmAmrFaaV8CQYec4takh43XucNj00o
         21GuLGC30Nn+t4CYmzwDG1GTd0idpJdOmPfTdEFEMau5num79GT8AnHXUC1w0pIAigHj
         R/F9+feX9Z+jfZJMtv2IMqx0q8D3HSHSPw2S/IAQsaLBPkx9/Iqo5jYK/pOZDwxFltXx
         QUeA==
X-Forwarded-Encrypted: i=1; AHgh+RoamYPJC38uFCraQKL8o4Qc6SQGN0tf00H25LPCGZ4E/FliHbByD7H8VFljcGqlUIGBzZ3/VL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZJ4kl6wqF7ImaI0Omil5Vv/OGxlKyFPQeaSyBe0jGMZ2gw6j
	m//6UJuNQZZ/1BmhEHPm8Beqy56h0Q2GMHphW0oNXbNZ3weFLYdHUuoRF6I8C/siVwEdtZ5RUQk
	fHSyn0Btw5LHY0XvFZ1GTxrh1Zr/VdoZpo3BPFUoohpzSyy8A0EHO+ibvNw==
X-Gm-Gg: AR+sD13/JQDMzC3d8691BhEMjWFGMyco7z+Iw1+PMngkBiQebhS655gjpHkhkAXnp/+
	ehQoBpDmhuq6goiNlRte3uOAQfP8XSkfkdWkdESJ7npuGiSMcvCPuhT7wmJIa3LeqU70GCLTXSx
	XkQiE8mNtU0muPDFo6pRZTbpU4KyLcLL2KySnTYNovbCn3krhSXN0cX/0MXMQ7upToLZR9VNx+b
	1Pp9CiwksLHGRXAKcDzZ2CGJPG0LPxB6ZGqdXb+CvGnvSOMe55aXUu5it0WfxdQwO+KpxNOFYrE
	oHw3ZF97RSJtNeKriwZdfE96Ciz0ndNMznA7IZswFfE1N2kkERXVEWFCmd6Tm97yC5HfN9VbeUA
	Ht/f2lgBPvx9Jdxcr6xCtdqroJ/G6dR2blvZISCNVInuU/LGL6q2orxcP89T29Yt2G/8G4/rPk0
	k=
X-Received: by 2002:a05:6000:604:b0:47f:7526:598 with SMTP id ffacd0b85a97d-47fec5037eamr22742487f8f.12.1786021704008;
        Thu, 06 Aug 2026 06:08:24 -0700 (PDT)
X-Received: by 2002:a05:6000:604:b0:47f:7526:598 with SMTP id ffacd0b85a97d-47fec5037eamr22742391f8f.12.1786021703523;
        Thu, 06 Aug 2026 06:08:23 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b183b2sm6802661f8f.24.2026.08.06.06.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 06:08:22 -0700 (PDT)
Message-ID: <7dac738b-3ea2-430e-9513-2702c426a057@redhat.com>
Date: Thu, 6 Aug 2026 15:08:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] macvlan: require lower-netns admin for shared port
 settings
To: Doruk Tan Ozturk <doruk@0sec.ai>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: xmei5@asu.edu, thomas.karlsson@paneda.se, herbert@gondor.apana.org.au,
 daniel@iogearbox.net, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260802130137.98105-1-doruk@0sec.ai>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260802130137.98105-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/26 3:01 PM, Doruk Tan Ozturk wrote:
> struct macvlan_port is per lower device and is shared by every macvlan
> upper on it, including uppers that live in other network namespaces.
> Two of its fields are settable over rtnetlink by any upper on the port:
> port->bc_cutoff, written by IFLA_MACVLAN_BC_CUTOFF, and
> port->bc_queue_len_used, recomputed from IFLA_MACVLAN_BC_QUEUE_LEN.
> (port->flags and port->perm_addr are also rtnetlink-settable, but only
> in passthru mode, which requires port->count == 0 and so cannot be
> reached from a second upper.)
> 
> rtnetlink checks CAP_NET_ADMIN against the network namespace the
> configured device lives in and nothing else, so once a macvlan has been
> moved into a child network namespace, an administrator of that namespace
> alone reaches macvlan_changelink(), which applies both attributes
> without considering who owns the lower device.
> 
> The create path has the same gap. macvlan_common_newlink() resolves a
> lower device that is itself a macvlan to the real lower device:
> 
> 	if (netif_is_macvlan(lowerdev))
> 		lowerdev = macvlan_dev_real_dev(lowerdev);
> 
> That real device may sit in a network namespace that was never
> capability-checked. The new upper then joins its macvlan_port and runs
> update_port_bc_queue_len() on it, and, when IFLA_MACVLAN_BC_CUTOFF is
> present, update_port_bc_cutoff().
> 
> port->bc_cutoff is not a local tuning knob. update_port_bc_cutoff()
> recomputes port->bc_filter, which macvlan_handle_frame() tests to decide
> whether a multicast frame is deferred to the port broadcast work queue
> or flooded inline from the RX softirq, and a negative cutoff clears
> bc_filter outright. A namespace that administers none of the other
> uppers can therefore change how all of them receive multicast.
> 
> Reproduced on 6.8 with a dummy lower device and two macvlan uppers, one
> left in the initial namespace and one moved into a child user and
> network namespace. From the child, both a changelink and a nested
> newlink carrying IFLA_MACVLAN_BC_CUTOFF were accepted, and the value
> read back on the initial-namespace sibling followed them, changing from
> 1 to -7 and then to -42.
> 
> Require CAP_NET_ADMIN in the lower device network namespace before
> applying a shared port setting or creating a macvlan on a flattened
> lower device. rtnl_dev_link_net_capable() short-circuits when the lower
> device shares the macvlan network namespace, so an ordinary
> single-namespace configuration is unaffected, and per-upper settings
> such as mode and flags stay available to an administrator of the
> macvlan's own namespace. This is the model ipvlan has used since
> commit 7cc9f7003a96 ("ipvlan: disallow userns cap_net_admin to change
> global mode/flags").
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> The newlink gate is unconditional rather than keyed on a BC attribute
> being present, because joining another namespace's macvlan_port is
> itself a mutation of shared state; ipvlan gates ipvlan_link_new() the
> same way.
> 
> IFLA_MACVLAN_BC_QUEUE_LEN is gated here as well as by any magnitude
> check, because the two address different things: a magnitude check
> bounds how large a value any caller may request, while this bounds who
> may write the shared port at all. update_port_bc_queue_len() takes the
> maximum across uppers, so a cross-namespace lowering has no security
> effect and this over-rejects it; that is accepted in exchange for one
> rule covering every writer of the shared struct.
> 
> Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
> Fixes: 954d1fa1ac93 ("macvlan: Add netlink attribute for broadcast cutoff")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
I think that following ipvlan example is correct, but the behavior
change may break existing user; we don't want bad regression this late.
I think this is more suitable for net-next, with no fixes tag.

/P

