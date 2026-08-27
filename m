Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12713AF66D
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830855; cv=none; b=OV9g0lQmDlzGgEH2tTwOxZT+/66O7ho29IS+HGMWYC9CvK/Yi2POS/46Amt1D1Cqtdkb9dkcBU7iIzdD9MTUBQJX6id15Ma3rLSschFkAJwZbaM6oH/tMBt0b/OK7V4HPb5IddgY4ANanfDMvHblXnt3N2eaAuGx/Th9flQY4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830855; c=relaxed/simple;
	bh=gwLrmytVYeMIfSF1eSLHQPJuoreaRYZhEn7gbBOrPv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZSC9rjafjGmHRY1Y5UFlByqY69/cyiw3deymzuNSuYLv7T88HMxQcRhg5hAp/btFMxnDybKJyteuMG/Au9/9R559FKHXicD3HI5OuaekDRCTYyuLdaigUGKMWb6r3OrBFFM2E3xXgbs9Q174dINTKxqKFVMU5Ujmm1r5XkDG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7EpjpVg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nP5Mi43A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7EpjpVg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nP5Mi43A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787830853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ2+HPBM4So6DB+Magsi+GAUKyjptnXMS5Wn1n3mvMM=;
	b=h7EpjpVgeNMoD2soCpS2EiHyYxFjPHp1YyTHqIwy3kA1fM+NDroZNMUEUP2elj1YoQzH0z
	4d4Q8VTE2Q7m4Avkj+R69xBP+YnuCdFurCgwtOHH/75xSfIzOkcqlWNpzlcPu83pZOoP5W
	BAUYY/MbBw6E1OaWefS+XWgHr5fD/jM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-fNPiWh9eNZ2RozG5_9iqtQ-1; Thu, 27 Aug 2026 07:40:51 -0400
X-MC-Unique: fNPiWh9eNZ2RozG5_9iqtQ-1
X-Mimecast-MFC-AGG-ID: fNPiWh9eNZ2RozG5_9iqtQ_1787830850
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f81362fb1so376791f8f.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787830850; x=1788435650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZ2+HPBM4So6DB+Magsi+GAUKyjptnXMS5Wn1n3mvMM=;
        b=nP5Mi43AP1ua5FBjOoFfFVzuERohs57d71LPdPbVtBZ4GgOYGBzSJApYOXLhOt94bY
         Gnau1WSUkrzKaRm1caB8lGQDWbagFBDsX8Vvu+nY/neBXHClLJFoWMhDXzXNK87orE/W
         m89nFr9iC4x47YIt+AGbX4+kB8DOKSGOGqKmrvDcjoS8lmGmzkhWDkujZe/bAs/xfHr8
         GEQXAo5DENoH7xri7WZyP65sZgEglFLB4aCv9eQO3/RXhjOaqkDJcLUr7QZOE29KwfJ7
         C7ZPaB9VZfn3ojwJCGe3niHE7EfcDg4PiuzlxI/VPm9ix1TzoxOajqpLwFkXrM4GCFOF
         lENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787830850; x=1788435650;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZ2+HPBM4So6DB+Magsi+GAUKyjptnXMS5Wn1n3mvMM=;
        b=qvAmWduHQp+8Z2sBGYPXa8WuNSHkTMEUoU4QVAEpRFFnGBMS8EBQoL5h8ubNoKuQk4
         QolbjnzssUDHspRGHjzit8IAO0rU477Vu29n/X0OLHJ0KgF8aNB4DBfMfZhynQThuBSP
         8TvHa4mapJgCTdSRC6WXZFqcnMOnqzVv5FATdfthAStq86GJnp6elNOukycngIOz/0AZ
         4NZO108Ns9+5ihmFayiG0kTO1Vftt7eBsCQervNrtWWwMvTIYS1D8hKkJPD/ytTxTKwj
         sgMjk3ohGxorhteP/sbHEcvyPh5ezBlrUcYFT4716igKY6SnrmFanxKsiz8kl2vpCiiY
         5XnA==
X-Forwarded-Encrypted: i=1; AHgh+RoKHZYoIgKx0RG/uA28u6O80LcOq2ChLSlcn1iDBa4Lpptvh6iHpf/e5fygSXI9OwU0mfRolg8=@vger.kernel.org
X-Gm-Message-State: AFuF++kKOWWrqg64m/Iz2CvPalTLBVuYglZA3oYxc7qyJiKH0zSzUuFc
	tCrewkyMa/W2rSz2OJLmnabaB3i2r5Lmcv4ZgJVXyKOflIev8FH5J+jOiEeSPS5EorJIpkvL87D
	dawVdmIPzHf6n/DKrTJlP7VHo+gUKx3NWINkRt4wyEuQmvG6jX9+4bBfCRg==
X-Gm-Gg: AR+sD11kYZfeYvKPViHzMacgBO8tt8GVP8vP9+kXxZoTfevp1xTn4SgjT/1GQpzGQQH
	gISiLBPXWaCxyv3+MeCfKJQzfV/TgXnWQY3lGglADPL/dEmY9dLHMqc7f7lEQ5zb2c7B8TMGeyk
	GrDnVdZwSB9/W/F1G4ycbaFJe/40HEzO5t+sAQjmmSRIjgNMSpkWBpJ0/1q5Rk+FzgP14hZ0arp
	1bvhmyT9NZmfcCtH7/B/Cp7XitmBvPxicCsDVij2mF/Te/pu9PyTpdOjU9zuWDQBB4PUXU1dZeO
	KpoEOmEAaN+ZF5+C+JgcLHkdIKdkojcB1uZO9+6TkJfcaOyGH2C9YDO/Fknl0VnXda/FGozsbn/
	NU0qH66tAdDICEy6a2qeqz5iW0fFYw/Z7Zvgum/Tc5KTEmMyjZaNJelXLzNjnQbPm/xEbVNY=
X-Received: by 2002:a05:600c:1d0f:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-499dc6e419bmr149696745e9.1.1787830849814;
        Thu, 27 Aug 2026 04:40:49 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0f:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-499dc6e419bmr149696015e9.1.1787830849336;
        Thu, 27 Aug 2026 04:40:49 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e279e92csm8458879f8f.5.2026.08.27.04.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 04:40:48 -0700 (PDT)
Message-ID: <e60be557-7020-46fc-9b07-d8b32f99f103@redhat.com>
Date: Thu, 27 Aug 2026 13:40:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 6/6] net: phy: avoid double-free after LED trigger
 registration failure
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org,
 andrew@lunn.ch, maxime.chevallier@bootlin.com, kuba@kernel.org
Cc: hkallweit1@gmail.com, chleroy@kernel.org, qingfang.deng@siflower.com.cn,
 hao.guan@siflower.com.cn, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
 <20260823035600.188864-7-xuanqiang.luo@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260823035600.188864-7-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/26 5:56 AM, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> phy_led_triggers_register() frees phy_led_triggers when a speed trigger
> registration fails, but leaves the pointer set to the freed allocation
> before clearing phy_num_led_triggers.
> 
> phy_probe() ignores the registration error. If a later probe step fails,
> its error path calls phy_led_triggers_unregister(); normal teardown during
> an unbind or MDIO bus removal calls the same helper from phy_remove().
> In either case, the trigger count is zero, so the per-trigger unregister
> loop is skipped, but the dangling pointer is still freed unconditionally.
> 
> Clear the pointer when partial registration cleanup frees the array, and
> make phy_led_triggers_unregister() free the array only when its pointer is
> non-NULL.
> 
> Fixes: b7f0ee992adf ("net: phy: leds: fix memory leak")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
I think an explicit ack from phy experts is needed here: sashiko has
flagged a few pre-existing issues on this patch:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260823035600.188864-1-xuanqiang.luo%40linux.dev

that IMHO bortderline to be addresses in this same series.

/P

