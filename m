Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D135C690
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649920; cv=none; b=Nj5y/uYesopUa6fjf+MWzJpL1P4swzsag3Kph25MvS74Eas1n/ZjaEsMu8LbeP/M7ECBs1LtFzE773U7Y4/IbsSuRiptFUv5kmOT5DPok6eUiSQqML2nFL65Hgm/N6nfbvctc2Bvt/klQHahjn55tS8Ob7zkbS1KrevCZ22/c5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649920; c=relaxed/simple;
	bh=2VOaBUpATXZRwbhL/FrnLwVbT0d3UAjrcJ6WZRBSgT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih96b+CQq4syPhIpxAkN/TAuGDd60QDkH400JSFp/vfaJo66oiRiiTiLgEFFNDMBP+fZtPu1yc/7d9bAE22jiJdsR6rHLXJ6Mtsmv1rann1mhig5ghbE2xlMaKiTLbXh37CDon/Hl/qCg2ZEvcIU8V96ZD2hZeJ5gACNTlqd+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvaTZDJA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jZD9N59E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvaTZDJA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jZD9N59E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787649917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pizwoZrUNOGE4XnyAc+Px/F4HEZsDeJxYwjxqwe6X58=;
	b=NvaTZDJA/jOk9yUQh9v3+/Pf1NWX8aAh8qgo4TEIz0iJmYCyYmUMSEmaOiehJmmj9++IgM
	bhsBqWBV/FmMMGUWkOFA1+LdIqhljiyZ3WeAyTG1cO0cdBwwk3wKhhU7f+BYbxKkejEOfc
	qf2dQVcybzifUa8KElQ5bcrVWR6OqWk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-XtDXoa6rPUeIINW7wovkLA-1; Tue, 25 Aug 2026 05:25:16 -0400
X-MC-Unique: XtDXoa6rPUeIINW7wovkLA-1
X-Mimecast-MFC-AGG-ID: XtDXoa6rPUeIINW7wovkLA_1787649915
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15e82278cbso312997466b.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787649915; x=1788254715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pizwoZrUNOGE4XnyAc+Px/F4HEZsDeJxYwjxqwe6X58=;
        b=jZD9N59EBHOck+tetC8VRbaLQZRgsfa8RDr5oDRUyoPske9FKn2tsn5X82GpSj48Jk
         s9JOsIvzGv+id5f09Y7A/Rf+VRdhTkxs9wIV1bGwBhNKeUuDSYrYme0+9iGs9oi4LJqI
         osDzalymP8uE7oWWC47pVjouuVLwsUCQmQ2vhAJljqYNyJZOVsTjjF1Ga9dmepMPDbhs
         a1vgJKZ6Uq3QEHWgbkwb9yF40l8e/J/PCg2R9jcPxezOVACXOAqes57P8gZdHGJAvaA9
         FVYPo/dxGdvOguISLjM85WZVaS7LOwXoVGaf9XYu5iuN8tRJcsoIhOLkKl9TUTART+tR
         zg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649915; x=1788254715;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pizwoZrUNOGE4XnyAc+Px/F4HEZsDeJxYwjxqwe6X58=;
        b=PdMmuMagglQZiDiK42M1pTnJTd+Obs01KSwbrgAN1HoVHW3MD+6UMkJ0eZSo2OHKji
         8fUs/MhSSDAqe/sXYJpPSIrjoxTws+ByxUqziIbNsDmxXJGcFz9m/gYsMNQi7r7oIvvS
         fQZw+LBv9/qCUIRAt9wDI3RsVz9kwxeakMGM0OqVLZ5btIExEhGkEu4HJwvqpzhz1Oag
         IBpi4VrsWPDPsz43fXVbpmaPpleLhzRqLuhNgafzARRYZvHaToZAYot36j7b615vSicR
         nnPtSJLEUD/bJ+1nIjOyZzXGH3CmxW5X7bzPxlZF7HT9wNPKajmF9RkMhhyC33QCwBtg
         6HaA==
X-Forwarded-Encrypted: i=1; AHgh+RoXKQW/MDFxjV1PqIz2Ify9ZB33sAY5WQ5AoXR+wWIjOBdy7ZjDQXSZVF6TDTfSe+Y+zJVijKw=@vger.kernel.org
X-Gm-Message-State: AFuF++lrXPbm5g9/+nFZlOcMMDMHR3Wn6Yp2YRtgYzD8PNJNT5VHUlvB
	iabwIdDy6Ejf8UswI2VNFSipPouqf3WbdVHNWr5Ujei0BzZqDVacfzfjX8xKUTCWtaEu9lrfyU4
	AJkugdD9LhktebfjBxDHjKD3vvHRGgqXZObmojIP+VRTd5ZV1Ao5F8orm/w==
X-Gm-Gg: AR+sD12Fm0LICj/R97k8AQx1qMZ9ymks9UKJF1k55Fgj/OopjKVxz9zDzEEQSEpCkKW
	tZUYT33sOndHegzFg6p2GA6VBRKJXqIPlWVtAQqkRGTE05rtYrammRUOZqaSbkpGPHrUTqzJrM9
	8/PBhUiAb3VvWR/NHcT8Y1jaVWfVegqun4bpsFCNM1zthQBoqKBz/ApNmoO9/SGOD+gHUFyfjrY
	aRuK0cAE4x20wf8KwAwtDqKhQ6hbziPRULnMGwkf/xsSS1vW25gHB1U3OBB9cb0EcEHMMauUfL3
	xDnNNTSKBQqgRSqyO+Z8knAEHLzQBQrLI4n4s8dXoXib7yC5Pkkj5IiBykBruPDJ5iHpCM2lY+P
	DdpWOnLpQPrMWXs3XBWHI+0y4EH1xT+HOYM3rOP/xGXylbFdK25ll3nEUvFgZu5l0YpwOxNFX
X-Received: by 2002:a17:907:a703:b0:c16:13c3:b1ef with SMTP id a640c23a62f3a-c246a73b5b7mr3901012566b.24.1787649914648;
        Tue, 25 Aug 2026 02:25:14 -0700 (PDT)
X-Received: by 2002:a17:907:a703:b0:c16:13c3:b1ef with SMTP id a640c23a62f3a-c246a73b5b7mr3901002366b.24.1787649914109;
        Tue, 25 Aug 2026 02:25:14 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24968665e0sm1502866566b.53.2026.08.25.02.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 02:25:13 -0700 (PDT)
Message-ID: <e0a9ba12-dcbb-4266-bf1f-1e69b3e51b38@redhat.com>
Date: Tue, 25 Aug 2026 11:25:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/2] net: core: fix head-page leak in skb_zerocopy
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 Eric Dumazet <edumazet@google.com>, Zoltan Kiss <zoltan.kiss@citrix.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>
References: <20260823183602.1051453-1-almasrymina@google.com>
 <20260823183602.1051453-2-almasrymina@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260823183602.1051453-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/26 8:36 PM, Mina Almasry wrote:
> When skb_orphan_frags() throws -ENOMEM, skb_copy_ubufs() may have
> already reallocated and replaced 'from->head'. Accessing from->head to
> drop the old refcount leaks the original head page, and erroneously
> puts an unrelated new buffer. Use the local 'page' tracker variable
> instead to drop the reference properly.
> 
> Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
Note that there must be no empty lines in the tag area; no need to
repost, I'll fix it while applying.

/P

