Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEE196C7C
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785675743; cv=none; b=SX9HwB1hct3a9+ZVxhdzK+eMw2E+Ceeyv3OwzapbjYWjN9F03lUTqXzv8XLS1EJO+IcM7KKi/by3NvLMPcYGWLvWawhn3i7HgsMx/7aAkS+w5e1KzjSSTrVM3rdyV+ZIaFILwsTt0e684iCSozJPGmHhOLBCoYTzuvqPNqQfvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785675743; c=relaxed/simple;
	bh=XNfkmazTZK+LgsmU6gMP30G+xgNpsMkLpz+x5Edx0OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pq9P1/qyaA8x45TXqYLiyQSndjXglzr9DAR/VfuVidH6q2tPzcXYTXB007dAHg7pVMfBNDDLAY2vNlTP1nDE6mmWuVLRkoSslGZfskP8sPOJwc7te2YX4kgdV6jwMYyggvLAPlZ0C1SoM3jQ7G6WhzSdXoKDWQCyPV2HS2wXcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTqySW0W; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTqySW0W"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-caf45fc5202so1655799a12.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785675741; x=1786280541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8iMyqX02UpaRW22lYJcpZBjOPaw1gu+3hlWoNXP5tP0=;
        b=iTqySW0WxUbMnjnesjh5q+kiSofcyVEzhf+krzM/qgA8U4Oy1Npxam0xsdCnyZy8tF
         G8A9Q32VlNJ98q1M93OitKCpimgPsNdC5Qv8SUyvzjeNDShV/FBACQh081Sr0QxB9Wyc
         VO7Xx6QfMRRMyYyuPrZWxSFlSvMkPBABPORzyxVCjewuztiQ8nP950Ok157vOJkaPtn6
         FDu4PlpATUXMpMsD+YFeyKxfwajDNFjTlnoIlvm6qL4i4wHrPo5XGiQ2pStMDiPMbRB/
         TLmLWDDwOglouiqEZGb0g1ml5YC5Zd3OyMBNftY0E5/BCaI7+8WWJQNk7FnosDkC1ZxH
         gtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785675741; x=1786280541;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iMyqX02UpaRW22lYJcpZBjOPaw1gu+3hlWoNXP5tP0=;
        b=ifznq0DlCALcDJ9et3DI9th1ePhy4CETxPXIuuA0XWk7DriD3r/BgD49DFT/KRqW5A
         rsbyWxSzbDEopH2RRQcM7jVO8+n9Hwh0/YoLn6j7rmYOVKZUvs4V+pXntTzR933xu0eE
         +jno9UDmfV3ywIonckqrDIX8+1kzuS167rx2HmALO4atTWpiYD+0bdxD/6RkaGs5n1DM
         qt0ULbpjNZI5qs5g9tb4xer9oQ5npo9hHFXLQ9zDaklyQrfX+weqF0aZNry2knfjeSTc
         cX8SgJC+JMHUFIAgyZgkWsAOrEX2de/mtmTVsVlAp7lMpKbZBW6DqPh5A5hvf5JaRAOB
         uTvg==
X-Forwarded-Encrypted: i=1; AHgh+RoVL8kfodvqsnSr7D/2GwC0COUQNZ/YYwjg6HbFYlKA3Wieb8kbO97ccN8rkslGMMQK0SIG4Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwId2MGon7OnbQsdgN7TzW5WRYHdxfKoUzZmJR17yzPvfvW8AZB
	cVU5H1k5PunMnSSL5yJ60yWCFqOCpHk1fO7o/XMfBkBxUnHg11+YDJzQ
X-Gm-Gg: AR+sD137sQpEIFYqPhLwBd38Do9O7991zMLmPSakjeZTACUbQA2Y0OnbJ7YvnlGRMMP
	LvIYIvhXs93+7H9wypuwP67DbPoSAU/sv3w0llAjsEdPcd75og2y2wMzfFOGR6PflBM9SnPcWkT
	zxtU60oh00CrirBawxW2v7YQBpcviLdl36/EgotO1uqi9QR3LVtLBeRFKNPHBhflV7PEqktMrcg
	5aK6SIBOCPzNDZtnjl7CYvKbXQW+y6Rc7CKyD32iic18UT+xaoCNMsKBRxNbsmKr3havTuobvhk
	l/vNrOF9mjS57CJxFHWHnb5dvSuL2xuAt+aaCKY5OtEKssu7d9yL9W5iTj+Sxd+qIp5QyZ3pacc
	LdjYzQ4NnVhDvjuj27csgNQ0Vu+pgqHtqA92ZnBYVv8lsZnOUFvy4ihhEzCR3/+Zup3+qvOHNvP
	kdPQVd6jMSYo070lnCvqwdoSzUvQ/Gp0p5IZ0ke9zVkhaC3yvzPCWif95L75x1jMqtii9IO+Ys7
	SLNvLI22nb3GfQuqUarZDIQUu/okTEX12kpwSXNh1X0Un1Z5bCCL5d4tMMOdNitCWLGVNMlZsy8
	a4Z4jot4S4j5+9+Nv86jvus0/mtXJVU=
X-Received: by 2002:a05:6300:624b:b0:3c0:9c18:d5ad with SMTP id adf61e73a8af0-3c92a8f32b7mr6361782637.74.1785675741018;
        Sun, 02 Aug 2026 06:02:21 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:b123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963ddc3sm2531160a12.7.2026.08.02.06.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 06:02:19 -0700 (PDT)
Message-ID: <7dfde9fc-63d0-4ff9-8c59-63af279cf85e@gmail.com>
Date: Sun, 2 Aug 2026 14:02:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v5 2/5] libeth: handle creating pools with
 unreadable buffers
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kohei Enju <kohei@enjuk.jp>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260505152923.1040589-1-aleksander.lobakin@intel.com>
 <20260505152923.1040589-3-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260505152923.1040589-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/26 16:29, Alexander Lobakin wrote:
> libeth uses netmems for quite some time already, so in order to
> support unreadable frags / memory providers, it only needs to set
> PP_FLAG_ALLOW_UNREADABLE_NETMEM when needed.
> Also add a couple sanity checks to make sure the driver didn't mess
> up the configuration options and, in case when an MP is installed,
> return the truesize always equal to PAGE_SIZE, so that
> libeth_rx_alloc() will never try to allocate frags. Memory providers
> manage buffers on their own and expect 1:1 buffer / HW Rx descriptor
> association.

Maybe I'm misreading it, but providers don't expect that. It's
fine to use page_pool_alloc_frag_netmem() and friends, just like
bnxt and other drivers do. net_iovs are refcounted in the same
way as normal pages. Hope it helps.

-- 
Pavel Begunkov

