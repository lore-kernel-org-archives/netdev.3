Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A1525A8C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860705; cv=none; b=QSqNwqR9R3FQ6HZ7h8+xbTM+MKB3IdpKhejqiIEbA46pDyTx/KN4jI5y8KBatj5hr4g/R6H5ZBImns+rxp1DFOSS7C+rT0nLtw0ed+JqXRZeX5e+iIuAOKgQS3j07go0zyVYyi/4siNn/74WWgmIoHDg9ttiZTX2rkpwOf8lHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860705; c=relaxed/simple;
	bh=nPvXdXhz836eZhcoG7q2K7zxkrEoHotO4Jsb8CDlgGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3BLrjMhp8m0Yt3maCXWcGAtcewJYz2BRTiegPVUVlZFe+0952+6gTOByhQSdlJqM4EB5Fs8/gHxJ48RObVLb4FalN5SYswjFnmKirjjmmHVRg/LYYqXXVKx+VIUncm8IeGmsoTSM0AAkwKxhqRUvknA38YKIo41dHYnWq5KR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXEnZKFN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5MkPsei; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXEnZKFN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5MkPsei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788860702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTIsVmfyzlZlhmHy2qsI6PXTaULkG55278aDJtKP0tQ=;
	b=SXEnZKFN+H0sHYLqSEinsO9KSNecziR0wBd23sD4exXH6DFzhmDnWAfBRbJLZhV7sXtW6s
	jkD7zTmi9f0gdaXunA55G3V58wsekJbBD0Ut0dp3UkAsCaVFKWC0oG7RH1AUskNsnvTs2l
	gHVLtr2ZrhEzsyjiCtNr5hMvq+lJ4yg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-x0fu8tBEM5WNHDw8UDbF3Q-1; Tue, 08 Sep 2026 05:44:59 -0400
X-MC-Unique: x0fu8tBEM5WNHDw8UDbF3Q-1
X-Mimecast-MFC-AGG-ID: x0fu8tBEM5WNHDw8UDbF3Q_1788860698
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4843313047eso2703567f8f.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788860698; x=1789465498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTIsVmfyzlZlhmHy2qsI6PXTaULkG55278aDJtKP0tQ=;
        b=H5MkPseikTD+oxF4GZu+SpwGtdFGy6SgAKexbcXKWtX5tu1o7ApKvcg9HvS40RuJMX
         Iox/mQRW9F2AbpS8sQ32252/jECY2VkigzLl2Ry3PCL8WeeaodlV17Gjrqle4lCzwXTC
         QONrPpJorDTp2jdLAKma5fwoP3XGmFuzJBgnih8+BKNXR2sfX5ZfX7u2pX24hEgDdD1m
         LwOZ0Ax6cPZJRhISMqSpl0Q/igfqRFas4H2Xfgjctd3OIzwYwCmZJZkkZWLIZPcx2Nqo
         gTxAV2SuBbkakE2rwAGh2zavBMQMfR3ddf3F14esStTctzQhs5PXpZDXbjxD3N12WY5B
         PIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788860698; x=1789465498;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTIsVmfyzlZlhmHy2qsI6PXTaULkG55278aDJtKP0tQ=;
        b=GVuHx5GJ2OX6Uib+Ou5V5T1sWdfgd3AO1RDbAK5PbAQ13lLs9xWSfb9oAEi9kj/nOb
         JVPqi5WGkyQ1Es+Z088UQzz3AjjRNZ1OqlqcTBB4lLZfWoG+XYWuZIIal1stvYDG4tKY
         G8srJ9XGVuKTyElN07cMqig7rFRT8yyjfhIHcm1nBk+mZcIpjo6T/fvOFOVxDvatoSVX
         Sw7Wp3MSANZOERtCDI6wk0/QfJMfCZthCloU13Kobe2NopYJeG9eIy31qOxYRC7fJwNO
         BtYa5smMZuuixEDlBz91paE4AigPAZAswas0L4WNu7TOoZO8TJJuGajy8TYnKJI6pA6J
         ykyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCbqXX7pbGJPSzZzU/VPXSzxLZTqqFn5XmZKkE+8sh33rPsNnhNRD3ht6nzOARCuCkVdPYPlg=@vger.kernel.org
X-Gm-Message-State: AFuF++lUcs6aEmMuZnZYdZ4QDbBp/NiNGPotp3e3quEislZ/IWoAmOSN
	tX/5It8c6BQe5foP5BwXgFnAexw1/w9qkoOfabyWmumtH+L+w6geognsZ74AsStmxeeGNpn/Ux8
	9hBCxbSBHXKrxX9pySGmnyqO+CMXTiOd+x1YbPcD+2ZED5E/YsUnYj91DWQ==
X-Gm-Gg: AYBFou016EOMsJtbfKJ4hRV5IsuJwgWMntktScA6FS4bdne5Rrg950J0PsrEpFOtZZc
	ny3utitwz+j6dFFr87KSBVtqnFuaWtOSeFf8buJDZSMbOgpO6CcRUoUJzAyzadFLnvWJ5RusvxR
	I0U8FSI/+s3kNipkD2k67QQ1CJKtwj3CP1wOoGIGlDPxMD+XNB2K/1DVsZovq11rFdq6RLoWjz7
	acv+6gS5FM0BtCg9NktxS8OqAvUCjD5fZ/URDaPnfthuWGqXWIzmGvQPRQtofCwX3QSPV5fO7Od
	szUQ0AZf3WrivM6PnDHkhgFM/rs1iIZD19j9cFys0kOQKiUQC4RImDqD0OEaYe7DA5P1ZHZqyLx
	hWWdKbh8e9hT2xR1csAhjWnXVl7DTA3DHlmNXLf5syaP4v9zdZc2rYkuIVkwdBtojCbTln3OIMw
	==
X-Received: by 2002:a05:6000:2dc4:b0:485:8a47:5b8d with SMTP id ffacd0b85a97d-4858ddea668mr23106460f8f.42.1788860698303;
        Tue, 08 Sep 2026 02:44:58 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc4:b0:485:8a47:5b8d with SMTP id ffacd0b85a97d-4858ddea668mr23106420f8f.42.1788860697815;
        Tue, 08 Sep 2026 02:44:57 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b1320sm34149332f8f.27.2026.09.08.02.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:44:56 -0700 (PDT)
Message-ID: <6cfd72f7-b6da-45ef-886a-7703027a55f9@redhat.com>
Date: Tue, 8 Sep 2026 11:44:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: macb: zero the link settings taprio reads
 back
To: Aleksei Sviridkin <f@lex.la>, Thu00e9o Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903123652.23900-1-f@lex.la>
 <20260903123652.23900-2-f@lex.la>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260903123652.23900-2-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 2:36 PM, Aleksei Sviridkin wrote:
> macb_taprio_setup_replace() calls phylink_ethtool_ksettings_get() with
> an uninitialised kset, and kset is not only an out-parameter. On a
> fixed link, or an in-band link with no PHY, phylink writes speed and
> duplex only if kset->base.rate_matching already reads RATE_MATCH_NONE,
> a field it never writes itself; in PHY mode before the PHY is attached
> it writes port and supported and nothing more. Either way the speed
> read back afterwards can be stack garbage. The ethtool core zeroes the
> structure on every path into the op, which is why its callers never
> see this; taprio is the only in-kernel caller passing its own variable.
> 
> Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
> Assisted-by: LLM

Not blocking the series for this, but note that you should actually
specify the model you used.

/P

