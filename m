Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B92F7EF2
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443550; cv=none; b=NbaehTVboz16Bbi4Jc6zzU9Tke0lGvcKjtA0B5HpN/Eva1Y/MxqU3u0TpNrpiOaoDfQNlpCXeFtUzjnjnDdntjzK4lIkDcMVm2PR7zTwMra0t1sdrprK8am4jOjqcUFCj8iOsuCWY1hCg0GOEiNraq4Gh2fNKaLQH5sGFdGGfX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443550; c=relaxed/simple;
	bh=VXkYNjl9+2YJvcllG6mfSBJo2s6uv1fcnxkSOeYhSF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ht+q0TQXqHZ+YHr2sRNY39vFigEiB5zyZXsXbvGirCw+wn3+zVnXKRbFy2xSriX1rpjd9D+mrlx09tCrI0v6HFkfs8b3aSj9GEX5EuYAfu4/EvPvYVLN75+6XXbNvgNQU5jgyvgWDETA+oucHOW8P5VomZI5qgAn2up2VfLEg5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=No598WEe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdAVMo3o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="No598WEe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdAVMo3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781443548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjjP9j/j3vlNfXrualE9V8Hx1Zk0n0jUO8AZfa6TeAE=;
	b=No598WEeAjZ2wac8wruydVX29zhFYQQWegkozDnIM8Z3hATC0F9fnqDbiaQ8lsOpydf8k+
	p6hvCtWFgklnYtidDs52Mb5JyLeGmQA/AcDCSyRpZOH66Q5XAnKKZP17GU+jXTSBXwdJMz
	FECJdgjwX51m5zsUPgsNfPf/zB05Df0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-8LM7kqpeP0SHzwE1L7epww-1; Sun, 14 Jun 2026 09:25:46 -0400
X-MC-Unique: 8LM7kqpeP0SHzwE1L7epww-1
X-Mimecast-MFC-AGG-ID: 8LM7kqpeP0SHzwE1L7epww_1781443546
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460198535bcso1600566f8f.3
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781443545; x=1782048345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjjP9j/j3vlNfXrualE9V8Hx1Zk0n0jUO8AZfa6TeAE=;
        b=CdAVMo3oCcAGit16KvGb/u596dxNzCZk9PqhkNRic92Jy+NsdKFT24d5pS5hWjv/zA
         /5QY3GqB66IUy+jSA9OXcF6cNQv26hH5GtKJL7gMkccLHi/1Dkw5RrzPlDJW40ZKRQFg
         FaTUXYUtulGzST0m0p42wUNHQFPThtHwkAIt5YNySsFiEsN0iev+UOckpt7R5ci2cA/S
         Fh7b8upiIRl/OsywlnkDRLiRiYfiXHQhjIqTw/BLnkZ+7R87kVy7EgGlLHArhpgnhb6U
         NLg++4e/xcoMrR9+4beWXWVgOQmXhpNalXyMv5ANgswoef0etzhMEbVCzsbnY8TYPT2q
         mi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443545; x=1782048345;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjjP9j/j3vlNfXrualE9V8Hx1Zk0n0jUO8AZfa6TeAE=;
        b=XoANK25dCwwX/gJq0qQZBBaHuqSwJVlMVpuAmH0oCutaMWA57XApS2YEG0/UfpkaHy
         rfEZrABR/RT7jufg9U3XzzVpanaT11OupXyg7g55QNxCd3tyNMhfNa133BVexO8vw59G
         GTuPLGsDNwrdkEmYGgNO4MMRmKDYl53jbogoAKNXOu48EmcHr9OabxAYDU7A0R7pB5Zm
         YalmX2iFkei652WGUfSerjUgmlWvsyp2cVlmWfd/zTWa8HyFc3IVBsPPQW04Wbt6aKBf
         TEjDhKeSH3iVgw8BHydTpQrwRtPA9tws5N8TNmLbYL5DJOHm8d/JM33mwI3qDSGv2CMm
         apyg==
X-Forwarded-Encrypted: i=1; AFNElJ82vs6VNJGkqmzHTTD0FSlzzn5W3wdE7aO9qM+mkfZuss47aUv8iGP3FAbFXQXJbMz2gf3BxTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQY08PtPaZb6bUb07dPNRZwMdBbzkUOI1wPaPS2BrxR5Bwegb
	HqJI+Lj146L+Cs+jGpTiy1IYMIPZ1s/zq3x6e1Ue1gMwEebjLeyKj3VSL4xXlyEMu/BliM5OvDd
	ORBs/FjTnS8BwI8fnccxgmQRavPixYLu2lKlzZz5h6pDNBsvmPdNxBesK/g==
X-Gm-Gg: Acq92OFg4rt7HYFDXvHsQ+Wtp/S62qI+h+MT+DKbm1+ryghFDmkfXdP5dLPry1u0mjG
	3ES5HdOAKscoI7qeCTAw0HJtfMP9W2jrqPolKiDD8tnZlYhEbHFAUWU0xiMkyd6RVexs55ezou9
	jPojXnHU673vZwT/Rba//8/V/ie0+/OUOurVR73qiYIVweLBHJgi6N+JQa/kbVaL8IXIJ69h0Wy
	nJEzESijMYhKqxMEbFBGn1WkqcNQndoeIqeSC5SdqV7blzcfEhfxvULG3aZ5A1SH9eegJ0LQBG6
	0I01H7oLu0SW8hHukSROHijwcygGlaVP6j5vfM2sSIAJSvrOTQ4q6aCLoRLTR3JJUlvCf5G52zA
	EfT6GhGRrqbBp1aX0XWCOdjDvPFZ02EmoB/OUL12CLJ5xD8to60zzj3A=
X-Received: by 2002:adf:e002:0:20b0:45e:ec27:b4b0 with SMTP id ffacd0b85a97d-4606dba924bmr9255028f8f.18.1781443545537;
        Sun, 14 Jun 2026 06:25:45 -0700 (PDT)
X-Received: by 2002:adf:e002:0:20b0:45e:ec27:b4b0 with SMTP id ffacd0b85a97d-4606dba924bmr9254991f8f.18.1781443545116;
        Sun, 14 Jun 2026 06:25:45 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263923sm25159258f8f.2.2026.06.14.06.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 06:25:44 -0700 (PDT)
Message-ID: <80034a5a-d01e-46d9-9631-951e6c4735bc@redhat.com>
Date: Sun, 14 Jun 2026 15:25:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 02/11] geneve: Fix off-by-one comparing with
 GRO_LEGACY_MAX_SIZE
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
 <20260611192955.604661-3-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260611192955.604661-3-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/26 9:29 PM, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> GRO_LEGACY_MAX_SIZE = 65536; total_len being 65536 is too big to fit
> into a u16. As can be seen in skb_gro_receive, packets bigger or equal
> to gro_max_size (or GRO_LEGACY_MAX_SIZE) are dropped with -E2BIG. Apply
> the same boundary to geneve_post_decap_hint to avoid writing 65536 to a
> 16-bit iph->tot_len field with an overflow.
> 
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

This patch and the previous one are pretty much uncontroversial. Let me
apply them, so that the next iteration will be smaller.

/P

