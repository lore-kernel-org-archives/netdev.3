Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA9E34DB56
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730387; cv=none; b=HvEeWB46UumYBUuBbdcgJdI/mGcXl/9MTlG697UfQI1CIt3G0b8bnUU+SDUUza1g9blAEhKly7pKY+G2MWfUMATa00m6PKiwZsd4TPX7lFYjQ5ApYh9x1fHfWGPw6HjgAVcFeFodKfuPfWhV0/t2GSJYCChN/zAkIDgNpSZDML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730387; c=relaxed/simple;
	bh=CNNkdusfY/lRrHKdVYeQhOpPtVwzV0xhn1DWQAe6z84=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Knwj01TT5b8kT/W89MSdGUbdO2mpxWR5Yj/m0T1unUvLc6nuUb8fL4+YWJfcQIQ4mhaz0G1xJI+Ll0AIQJS+XXbn71H1bHQM//Zi1/3qKmhaAzTlpFl4jCfygnqlJD0B52oxxWtlya0mopNHivhnfkM31zgQBRtph4WQiuuEOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2xsO7ic; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2xsO7ic"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81062fdeaf5so56150587b3.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784730385; x=1785335185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ez1wKXPVVz9CC787BtK9o5+3qHfULm35B2v6t/xxeM=;
        b=C2xsO7icbRp9nkCo0g2YfGZmMa/w86KbSL2jSJA1ay5Bz+dzGWCGQhvhjHQOjHG2TH
         sDP4u+CNPlkaLMDp0UFPHdxf3IDmIK0ptqO8trNw1YBUMm/BV77qA5d0h0ObDv4WoBqK
         n4dvxOTIpDa7oIe6sV+kCs2AgdMENBy0/T67tLUw4vBskg3MiFsN+0RzKBsgg6M1fI0t
         OCZri0kdE8V8IXfog+unTMpn4ifQi2NX+Jge+wIpMaPQPSXJ07kxDSQE+lj55Vi8ZaEt
         lPJY2GkuK33UpC/5DAXl+tuWSz9c76qMMQ2LdHrhu0AyUAabBfWgl1i/28MPpXYPNXy3
         V4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784730385; x=1785335185;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ez1wKXPVVz9CC787BtK9o5+3qHfULm35B2v6t/xxeM=;
        b=GuAS/45WxVobE3wbhcsLlVFZ9o9/LTZ7Q7NwB8qnAVUbKevoXZXAsDZ+Iu+EwkzVu7
         Xo2uUMha9B6ZieOKWwLXdfTOb6JaHlODRiKG4QAHqg5KWCuvWH3OkAHXYZGuM2nZNLNx
         SvGMl0TYUgCO9C/7vi0eU8aWRZRChmhoxMGaWzS2WuV7d1EHmgW7DTAsXyzYw/OpsbXN
         uFkTOhUJgje6xIMd3qLWkVCDbSL9/sVyzAVGscV+MqrrPMZQndrgNHmQ16vF5NgxucY0
         JTgMcKNhkVoLdTIXGb1xtJXatcQBigmBaYInPd0WODwZ/CizmkXhbYjVuAccvhmheNnW
         4i4g==
X-Forwarded-Encrypted: i=1; AHgh+RrUV5+NNJKAPXdYEe1gIUwp2p/OxtW/5VFtB57mCcoaZ9AKNIHorJmG41tdCnUP0hxBiAmFrJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsumTTBc7lzh4sY97TSXJy0Yy2OQRXKEet55DGk7+kcprrbVM
	UQCSRTBBgfYAK0oTMel/Tyn2MzWDT3UOvaM0LUdEF2dNdR8SyPBRP8Yi
X-Gm-Gg: AR+sD11iOEGY5eyu4CBiwNkuRHrBY7lJPyu96ZtZRM83TAUXpYnJZMnv8b4gesd8RE7
	lmrk7yF2QHumIoFZEcy1ayNydE+MtgOtdv5Ho7ho+vgj6E46kqfmRK2ej+2CJ2vVC1M5+zoIyj1
	dSOXK8NQBKdoU6Oy22UyEUteG37b/ZfUPD5hwnbULKRY1bqt4zTH4A0R55S4pR1vxuGCukjbQvt
	nxGhHOBitMl2qvmAi234e4+DMGJ6PyfK+OyWJOmsE1tG+xbJm0N9amKD5f3OugP3aNTwCyn4LJq
	0kD7/y+dQ5Sz3eKpI1zODf+L8gfFjF6z/P49d5xeqB7K/tADWZXOnd+vHKJevBMBCp1NyhpQoRW
	ObH4rpIB/ZSybPwtDs5XHXd8pAM7P8ySP2Eqt6jygqUG6WMKZTc98aucAC95E8+M5xq0DtnSDTu
	XQIU/4IWl4Co7TZ7Y/OKbQGHjwwpyFkXcJVCobbvS11UNoZfviykC9hAIvofcAiVBDuw==
X-Received: by 2002:a05:690c:c513:b0:81e:c38e:4bf3 with SMTP id 00721157ae682-81f33d34513mr11651637b3.26.1784730384744;
        Wed, 22 Jul 2026 07:26:24 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33ee52a0sm13947347b3.36.2026.07.22.07.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:26:23 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:26:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3e74e4fda69b@gmail.com>
In-Reply-To: <3e4b1552-57d4-42ad-a244-a91b74b8dae1@gmail.com>
References: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
 <3e4b1552-57d4-42ad-a244-a91b74b8dae1@gmail.com>
Subject: Re: [PATCH net] packet: use a consistent hard_header_len in send
 paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> 
> 
> On 7/21/26 4:49 AM, Qihang wrote:
> > packet_snd() and tpacket_snd() read dev->hard_header_len multiple times
> > while building an skb. Device reconfiguration can change this value
> > concurrently, for example through bonding device type changes.
> > 
> > For SOCK_RAW, packet_snd() stores the first value in reserve, later
> > allocates headroom using LL_RESERVED_SPACE(dev), and then subtracts
> > reserve from the skb headroom. If hard_header_len decreases between the
> > reads, the skb can be allocated with less headroom than reserve, moving
> > skb->data before skb->head. The subsequent skb_copy_datagram_from_iter()
> > can then attempt an out-of-bounds copy. Hardened usercopy catches this as
> > a kernel memory overwrite attempt.
> > 
> 
> Wouldn't there be a similar issue in the SOCK_DGRAM path with 
> dev_hard_header() calling skb_push() after packet_alloc_skb()?

Good point. this does not use hard_header_len directly, but e.g.,
eth_header() assumes ETH_HLEN is available to push.

Simply caching hard_header_len won't resolve this. dev->hard_header_len
and dev->header_ops (incl .create) are not updated atomically.

I missed this earlier, but besides packet_snd and tpacket_snd, the fix
is also needed by packet_sendmsg_spkt.

