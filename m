Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213267;
	b=SE+pJsYCH8PWex7QDAxQCH3h9NdVvTGR3GjfojhwMdWOnF5S10TPMECJMsDpm8QmHN8G
	 w0lTV5jQHFRwW+K3dGYlaNIgNn444CyJY3ko+SEctuzF+91WHF275s0/ghpop5nwRbvho
	 3Yli39Wv6Qg8Ax+TbSmiTQ6VPycF6rs+RF9K6tnQaVlYm5D7fb2V5OLFLzzH45EejWfja
	 6GYnNf/NYWsnUwuQOCFSvuNhCTD3wkJZoqrnuZYVd6XPSfqOXQQbY6NLWN0j3YsoJ3F2g
	 3UE8DcirwKUUee4cCh74qQ9cqKxcqtpyZafeShaAn7k8bPvy8QjhhUGW9Vj+qsY1Quw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0VJjp0Yd9E1hslhB48A2qpjBkuVbx4yz5XzIE+9Cd0A=;
	b=zZac6BXGrBcY6msy4d6lMbH/lTRM4GDYJ9MEeDpitIuvcdQo8tcgEindooTRLDoxAyjA
	 bMlQfYdl2s9TkeVV/GolT9NEk4VmMUAnCfOCJQ7ntrJ974RMjw10RYuCxFctxtz+aXFPk
	 g2aQ5YQMwwKeeY9aBmBT9IsHuZJDiFPDI9lXF08bT40DslWPZcR9wKV2qh8cSJKQ+prCH
	 +p7PuMmnSCHm8MqiaCY7Tcm/nvt157dkYB5JH4XKQ1fWgYIFPgxsBHEXKDTvoIr0sATFU
	 VOklY5C7KaoF0rv/aGE8VbkAGhiWOYv2HFD8+Zcbc0O0N+emHwRMky+Xx8KLmhfqxwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxASVbqK;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E84606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 18:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14E84606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxASVbqK
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-679a2297c55so1599309d50.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793213266; x=1793818066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0VJjp0Yd9E1hslhB48A2qpjBkuVbx4yz5XzIE+9Cd0A=;
        b=XxASVbqKrfkGzLbOIsdd5WJ7B4uFlWZIN3QwO7ecCrTSK8F8HfC3Ct+49DU2Ldzeb2
         zZGAZvpELJtGhPnlkukpFSJmZrjQMvffaA6dI3ZrOgl5z+eUBb2vIi+A8s6tgiptqoEv
         NUNzSBpGerZn6aXtY88hgUXfca7H1MNPPjWQYrfKc6zkUqnRNw/Jsbciyn/qg+VMJpH/
         2CtWvQimfVfsQlyWBpxYwkOzl/LWgSIExJKmEvQFe4EzYg/pUZmX+BzadlLjpwSOW9aP
         A0t3blPnotgtT9O8R5dG3xd4HDF+0/2LO7ibR1QKDZSqUeqe7WSwHqXdu8WeyvjYYXKg
         YMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213266; x=1793818066;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0VJjp0Yd9E1hslhB48A2qpjBkuVbx4yz5XzIE+9Cd0A=;
        b=vwDcC+frm/6/T/LDL5sE1EjTt4N+WzciP8HoeUgHwmwsIEkwP1Ib/ahA3yodaRV/w4
         Njh7PYvOqybx4smlYpQ8qOemAsensBO2ZqpqZKk9HPllz+7xD/6hLUJjy7Dv80bTGZxY
         vlSvZ8RJNqDu1B2xZU2rjJ2qYvFKah/Hnr6fWfupDJk5c0LyYBZK2zyZ6eJC7M0/v3/I
         44D7Rf2ZERqAQ83F67xrbU4t3xV1kEnTHs9IXsJCB9fsYslvxaUrZ1akN08mEsuO1XiT
         UBQKTKmMWn9cXv7OwwrqeiZSmyaK0BdpWO735t9573/T++vEM1mQ10mnABeCaS8051yI
         DxCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzI2yBnHS7S0I6qJM0OIk1/KNXX/0pXywB1o6TYTfoREHW2AObiCq6thmIVeWr7nhzMuVsH36w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvVLY1u4w+NPoXwVxqR3P9Ir+lzMOjkYvoM+jSYew5uNbW6xuM
	AWHR8rD4EMsDUQJvX11ISeV4ZTOdNpOo+4Buh1OQmCw0j8CaLoEjEDlb
X-Gm-Gg: AYBFou0C5OncgygoqEh4C/qBGcrOEPOmvq6t28fDOjp4ld2LVq9YAbX3DHx2oaxHbt7
	m9Rcrt1SaOkovvgMpbuzWkv8KAtE9KIOHegyVwttl0Ch1MfyygTwp8minMOr4hBMvr3Byh+IVxg
	xsw3a5BSeUhoB2n24CTin3UuH4ESyyqzhLtPqywS5hmT/+3+uHBTdq69O2scFk14qEpUE800kBy
	+Axy/uc7fmroPssaXt5BMylFNSxwFDtefqb1Iwrjt+QXrYlo5KNXh+iccclRpaP82y16furGkHs
	J7+tVJbq1Snxg0RpvULmYPHGngq6X1qisKT4EJS0Wbc2PqySN4oaAp1vU1YfLjTEPJIigac/L10
	hPTlKFnfkf1kARdeuE/wmHLGhUc9o1p7KmeEYxCwIfDz4PnnJ7ndwiS2IiRo2twbycQu5BHvUK9
	nNoKJa/8PcXlGBHRCFibSG2+NKuVtvWMi3I6PNawIuIf3jH+W1q7qiufZn+YM7BaEKo5isjqZz5
	kFjjOF6TKz0Cji4f+7MP1l4en58SEF127nnJsePWv6aNOnJ96MCSAMN1Ykv1T3WerZvF6z6PSVf
	hxe+XSyUlcG8NXu7O9TU1nXJGzo6PSaqCBp3VbzRMkBs+427KCs5ibiRJvcT8MasduBtEp9JHkt
	hvIV5eEcL4kHz1mvGgsuYm8RLmESusdQPoYUmH19/Tzk7qFjX8riDbJ8Kci3tpkFzN7uW
X-Received: by 2002:a05:690e:13ce:b0:679:8c43:a140 with SMTP id 956f58d0204a3-67a7bbf9a0cmr2723125d50.31.1793213265901;
        Wed, 28 Oct 2026 11:47:45 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a19b1d8sm2196764d50.22.2026.10.28.11.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:47:44 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:47:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 edumazet@kernel.org, 
 Kyle Zeng <kylebot@openai.com>, 
 stable@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.139c2c63190ce@gmail.com>
In-Reply-To: <20261028181450.2221013-1-edumazet@kernel.org>
References: <20261028181450.2221013-1-edumazet@kernel.org>
Subject: Re: [PATCH net] net/packet: check TX_RING fragments before memory
 accounting
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> tpacket_fill_skb() adds the full non-linear payload length to
> skb->truesize and sk_wmem_alloc before checking MAX_SKB_FRAGS. With
> PACKET_VNET_HDR, userspace can submit a ring-sized frame even when it
> greatly exceeds the device MTU.
> 
> A near-INT_MAX frame can saturate sk_wmem_alloc before the fragment
> loop rejects it. A subsequent refcount_add(0x40000001) can temporarily
> turn REFCOUNT_SATURATED into 1. A concurrent TX completion can then
> drop that apparent last reference and free the still-live packet
> socket before refcount_warn_saturate() restores the counter.
> 
> Check that the remaining payload fits in MAX_SKB_FRAGS pages before
> accounting it. Include the initial page offset in the calculation,
> and move the existing -EFAULT handling out of the fragment loop.
> This preserves the accepted packet sizes and error code while
> preventing an invalid frame from injecting an oversized byte charge.
> 
> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> Cc: stable@vger.kernel.org
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> [edumazet: use net_warn_ratelimited() instead of pr_err(), add a Fixes: tag]
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
