Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48A420480
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797936; cv=none; b=m6PvjmhL8MF4hGx0XIYi2Hrh2MRe9Otj42czOgfFEqTUtdVUpSQSSY5hNhfE7T9d8DUBOqkdzjEdjIrR9M7qWitbsCl521BXBpdRbvAb6YH0VdgXy0jU3D8ZKPDdVryBUReh+kogOtpHWOW/tnOGk892yMRu8yypQYIiI6akqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797936; c=relaxed/simple;
	bh=RG9HiQy6J4QcwSsTtYxFAG820wshgofatVnI0DLLVSo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kPKwfi7eDEt/zeegA1juA6LjD735StsFOvunKnNEBAUvQPASrz/YCNmUbxcRjiD5N1y7sIMkNQOziIYnSetwOPRE9lVNgbmYFrH9sGL8b4zjMtsOZzsl6XeOTsiPvXM/AZYBYHnpk8WwJWlVI88eRZFy57HmZWIOyqiEX9l7PBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aseM7p8m; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aseM7p8m"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66f7f72a284so5914658d50.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790797931; x=1791402731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Auk5W/wWOy9B17as+NabkL4cK70QCRU36zeViRJLAww=;
        b=aseM7p8mm/Nb+JERVCtks1R5aiObUlUMalvcUJDcI8lhvsomNUWSo0iIxX1zbU4ZPq
         tL5uGM4egK0SWghXj/FpkuW9zktSItGGO6fwloEHaTAI70t88ZUqUeISh8nSzeYYNSwT
         IMzzcQFZomimgrwzjx+Gx4eJdwhLWO/1H2LTSvT+aDw/R15URN1QRAgL0X1y4R1GhnS3
         mTW7kLG/AWJI1vtIppQ/qZw7kl9uPHRRTWxqXixoBtIXSQPt6AE2lGqqSOxwBuhav9dE
         FbIBSq3WkyGWPj/CQZC/rHnk6tK1EPhHoXNkEMjI+LK+1Sg7tTs8yR8xy6F6XrwYsj/Z
         sLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797931; x=1791402731;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Auk5W/wWOy9B17as+NabkL4cK70QCRU36zeViRJLAww=;
        b=Jop1r8SY55Ox4/+6NVTexacqlVKlOIdDUFsWAzTPBWHvVOk6b8rr2eSTFiptgDC49F
         wTQD4Evn7rEFanU9zJXUYlBl5Dz5goG8/L4S7a+wvfSIR40vZHBZjRJIvoyKdG/rOepS
         2HGuHFtigw7s8b8sfv5ZuV8XO3Uh9UAw58S/knz5bGQAwpYjKvyDv/8L5cMlof/jqYF7
         Itnj5jF2smZIT/kqVmgVEBy9bPD/pDka/9EMCnMSskHjewTfVU2WJZq+cx+q8L5mxdN6
         Lwpi+nYVVbAwv7vDDZEcw0RFNeTOAwrD1mEfBWOxENf4qHE7SQHFbpibrToddkNo0KRa
         Fi1w==
X-Forwarded-Encrypted: i=1; AKwUvBzlk8pekolDT3b0ev7J3hJoZo7X8GXHEdeLkrQWGwHtqJBoyR5G7NtKHi2FliAyOfLNz9GyqkY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSVNc95F258Ab9x+9PuRxgzp7PIkEEbW3bNIWJvBeJJYYvqxu5
	r9/yVYEIZHn8L7vfq2Cz+x2uw5YkUbxhn8xRtCGDP8MVFOFTS6p9vxrU
X-Gm-Gg: AYBFou0Eo5o5xVOBcttWERH3bIKXUtngSgaUayr/CQlyybanKRT18yev3/kTH8IYwuG
	1vqNMX/S1BNVlaquPVO0sQ+3OZGGF5+Jvmh4bNDViE8TW/GDQHhTkYp7mMPMfKtPU3WCPfiyj43
	4U8w+wvzCRwXkgGpsQtPZUW1Pkd7+kXP3B5YL0LNqVzVWKI4PgbtGX7o0anhLDFa8lC94oXCO+B
	ZZdU2SKivPLbE+l9GL12aGCGV55OhzULzu0kvgsYr/Ptv/k9eGkqcACoWaLgu0hGf5Nn6S5G2Ri
	U6GYCawCWzc0m//1+jNwvd1Ze2hkrWSVUnDpsuFSVrkcelcenx1WxnePbuTK7tJb3NYqKl4B6Ju
	7uW1q7e4i3lZnLenxPAwrcLxePGCamLayl/qAznS3MlTJmzyEfPB6BAbyPuGzqypwL6sRl5P3Wf
	Shjj9WHN9iCtC/kTsjy2RWnDCrGNGjvcuNyuOIm8JKU2y0DGgpLwby7k8nh8eMEUFGmkAeTiM32
	W8gHdjyxSnLodiBOwbvK6hGPbPnUflvBS1SeR1s0g/YrelctJ01T0z+yzqyqys=
X-Received: by 2002:a05:690e:1502:b0:66e:61c8:33f2 with SMTP id 956f58d0204a3-67683481ba7mr1350879d50.18.1790797930464;
        Wed, 30 Sep 2026 12:52:10 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8acdacd0a2asm3031207b3.21.2026.09.30.12.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:52:09 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:52:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 Wang Zhan <wang.zhan@smartx.com>
Message-ID: <willemdebruijn.kernel.66e7c7b6f68b@gmail.com>
In-Reply-To: <20260930111526.2183107-5-wang.zhan@smartx.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com>
 <20260930111526.2183107-5-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v4 4/5] net: core: re-segment oversized TCP GSO
 skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> A GSO skb which exceeds an egress device limit loses its GSO feature mask
> and is segmented into individual packets.  This is unnecessarily expensive
> when the device can still offload smaller TCP GSO skbs, which is easy to
> hit once one hop of a BIG TCP path raises gso_max_size and the next one
> does not.
> 
> For an unencapsulated TCP GSO skb which exceeds gso_max_size or
> gso_max_segs, work out how many MSS segments each output skb may carry and
> re-segment the skb with that max_segs instead.  The bound is measured from
> the transport header, so an skb whose transport header is unset or stale
> keeps today's segmentation.
> 
> An encapsulated or frag-list skb, a GSO type the device cannot offload and
> a max_segs which leaves room for a single MSS all keep today's segmentation
> as well.  The GSO type test runs on the features without the limit checks,
> because gso_features_check() has already cleared the GSO bits of an skb
> which exceeds them.
> 
> This path emits a plain GSO skb, not a BIG TCP one: inet_gso_segment() and
> ipv6_gso_segment() write the whole length of each output into the 16-bit L3
> length field.  An egress limit above 64 KiB would give outputs whose length
> truncates, so the size limit is also capped at what that field can express.
> 
> The helper runs on the skb which is handed to the driver, after
> validate_xmit_vlan() and sk_validate_xmit_skb(), and only from the
> netif_needs_gso() branch: an skb which the device takes as it is pays
> nothing.  A skb which reaches that branch pays one device limit test, and
> an over-limit one pays the TCP header read and the features recomputation
> for max_segs, in exchange for keeping the output a GSO skb.
> 
> Measured on a veth -> bridge -> TAP -> guest virtio-net path, with BIG TCP
> enabled on the veth endpoints and left off in the guest, so the skbs which
> the veth hop accepts have to be segmented before the TAP device.  A single
> iperf3 TCP flow, six alternating runs per state (`-t 15 -O 5`, fixed CPU
> affinity and port tuple).  The middle column is the same tree with the
> re-segmentation disabled:
> 
>   protocol  no BIG TCP   mixed, no reseg  mixed, resegmented
>   TCP/IPv4  51.550 Gbps  15.850 Gbps      52.617 Gbps
>   TCP/IPv6  52.050 Gbps  15.783 Gbps      51.933 Gbps
> 
> Coefficient of variation for the two mixed columns was 0.48% and 0.82% for
> IPv4 and 0.44% and 0.44% for IPv6.  A BIG TCP hop which feeds a 64 KiB hop
> loses 69% of the throughput of a path which never enables BIG TCP at all;
> re-segmentation recovers it, 3.3x over the existing segmentation path and
> within noise of the no BIG TCP baseline.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> 
> ---
> v4:
> - drop the comment above the frag_list check
> - drop the mac header test, it is always set on this path
> - take the TCP header from the checksum start the GSO engine uses
> - test the transport header first, skb_transport_header() warns when unset
> - shorten the comment above the features lookup
> v3: https://lore.kernel.org/20260928044102.1004310-5-wang.zhan@smartx.com/
> v2: https://lore.kernel.org/20260918084651.3022878-4-wang.zhan@smartx.com/
> v1: https://lore.kernel.org/20260917063854.2011613-4-wang.zhan@smartx.com/

Reviewed-by: Willem de Bruijn <willemb@google.com>
