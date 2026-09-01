Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F363515CE
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252043; cv=none; b=oj4Osz05WG1gQ7TKyyJulOuN0pxpRWhaY/x44gNMgzXCZZNYHvVUEst8aOrZByiMcxV0kVrcy5s8VB2Ti0YlDySd9MGAgdPqoTqpw+J/b3FbH+OtyovqkihgkkzghJiHGWpCxYlZrg2qDaVpY0NmeaIft3fsj7vP4WIitKH1waY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252043; c=relaxed/simple;
	bh=rTaBtC2Ab9kL3a8HvVSj7rD6WzTL3wiZAMIiWKZuQJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaAyqjNW4QdFlmKJj2VWo+FUPADYRq/WVErN5wCaGfS/TMzgOvViRIu1pnqcMYlNO0M6ITpfUmbKf/RgVSVltcF5ZOjV7UPpiK5fIGWEWBFKDjs56TzTlu8iXA3yUUQw0+WAQuPFXa7Nw/1YwY+mziDulP0DXFL/hfGnUSmS82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlPmhiF0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsTqE3ga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlPmhiF0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsTqE3ga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788252040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHSbqtb63+WVJXZL+2bipMbSfoPG86BNGlDDfyVTiGE=;
	b=PlPmhiF0POGxr4djRzH6YbEjjLf5xeoH5ERAi/ZQHoBOPH/IRZSmiAqC1wN5m0sx5wyVce
	mHzQHx0rhkD51BTdYeHYmDDR/p/dcH+QbStqR5hI0kyCjqZaxQt1x+iDkJaUmP8nOD2LCp
	FRRJScC45Dujz06vtvT3Tl2g9SgCGqk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-W8XqieDxOvOAswIQAHYFEg-1; Tue, 01 Sept 2026 04:40:39 -0400
X-MC-Unique: W8XqieDxOvOAswIQAHYFEg-1
X-Mimecast-MFC-AGG-ID: W8XqieDxOvOAswIQAHYFEg_1788252038
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso5710015e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788252038; x=1788856838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xHSbqtb63+WVJXZL+2bipMbSfoPG86BNGlDDfyVTiGE=;
        b=JsTqE3gaUUt7s1CFAMLzhXrU1ce/PFWKDjWpU0siKAaYrRt9oEFPJZbFGpOZs5AD+s
         zcR/Evqm0ZS1Tn6n2nYOkB3HttO2BEBhzSac1mP2Qrc9BBAVKUq+X1TTWdzb8b0kUzOF
         7kjhDTvMYf0LnleQLnC2FDeojpLJW482jwtzu9vLVs+No/wpTFXT+VZwXrze2L8sGFEt
         JSOvVckYZbOxQCEzxUgJN27/2AUC2MqRhBajKs7ygmAP3jOvPsjnBG18sHNlemkf4Vij
         IKkj/bf+1Ug1/A5/JGzC4c/TNlSNo9zNsvaR1MZ8FgKb3qZgPBCTM1W7i5znCXku0ZRP
         lKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252038; x=1788856838;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xHSbqtb63+WVJXZL+2bipMbSfoPG86BNGlDDfyVTiGE=;
        b=DbNyZpL4Dv4mveokOnKVnkaqTqyaQGcy/FxXVkraBPHxV4ZZPXiuKPOHDg3F+xYvQR
         K9EBvrS/JQlLfwYFM5c9dHTWDVXS5QD//e+aQiR28xBJMIY8yL6HyWH2NEia0849FsCv
         G6nW+dRCq8FeOuyBNmhUhhnY1RpSo69ahSb87VMfSeGZUw+CjEup0/CZubZhaWXUf0+x
         vUPMClk+vfmqi0TsKjxAc095ZeHYFR4sR2LBJeNk4nZbBhRdPAHWmMu08P59bjkXn/QU
         SqRiN1uC78UG4gXTmj8zGKjPT/b4ELRClAhB9h1B0801nhvfIrXJ/2BSs/YJhVIRzkEa
         lr6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp26XKP1aDJmdyqGnYYI5MLkxBJg6mUXCzP46xWScHIeWgujKe1ByZFz38KEyziKP0OdA3xPtU=@vger.kernel.org
X-Gm-Message-State: AFuF++nxf5J3uOS6pOfCYxN9QGCBrXMWcOyTMOUYzUZJXcnVS+hJ0AiB
	DKN7MJUNDbGCjqzja2ETn+Y7Jjp41JVz+ooB8nYXxFFjKzIpH97a8Qi8YPQhTdYwdAQpdtF0Sfg
	HAeB7rzJ/q9R+pbqZbB/y3KlgPsxz7JuDF6KdCA0DxUrYIIqRrA0gzls9cw==
X-Gm-Gg: AR+sD13KjKiEY1XCEbNFX5gucavIo+P/r+hkAUxOZDbcrJTwrIqqKxORecUJQUSu3K6
	0V2AecEMZ4y7aj2C7pha/EVY8B6gC/7CwNC0K/ZvlY4KabYKmvbStX2cLSyHgYT4X1VS9v+/O3B
	3Ytb7GMTJQBRQlsUgS8T32OMgnngd+BJJwUPptJyUTqTWZzzpUq3/ZTxjfF4kSym4FIx9FB6V5j
	Zmntr2A7Pq6vFY5NUrkiaHOHdRYVJmz6yUCNn+uygFA1vpb7I4fjkYeV+zLUYxpJQLbSC4a8iBY
	dVaFxFht3w24w8IOB4IqHEGegUWeQsyn052/9slSM10kl7l0xUYLwRRSSkpY2aEcDjNlw19uPzU
	diZ5yGJgP8Gp1EP9F8IcGIKsPGCLtZYZx3g8xvuqOHjz41EX9V9f3BD+5dTtQNPN4Deo39tl3jw
	==
X-Received: by 2002:a05:600c:1c13:b0:49c:df2b:15fc with SMTP id 5b1f17b1804b1-49cdf2b179amr60516815e9.8.1788252038373;
        Tue, 01 Sep 2026 01:40:38 -0700 (PDT)
X-Received: by 2002:a05:600c:1c13:b0:49c:df2b:15fc with SMTP id 5b1f17b1804b1-49cdf2b179amr60515525e9.8.1788252037895;
        Tue, 01 Sep 2026 01:40:37 -0700 (PDT)
Received: from [192.168.188.103] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce18dbae2sm6966555e9.13.2026.09.01.01.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 01:40:36 -0700 (PDT)
Message-ID: <d0e8bd80-1798-4840-b388-05206bb72fc6@redhat.com>
Date: Tue, 1 Sep 2026 10:40:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: dsa: mt7530: populate lpi_interfaces to
 fix EEE support
To: Aleksei Sviridkin <f@lex.la>, "Chester A . Unal"
 <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Qingfang Deng <dqfext@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260827211652.63504-1-f@lex.la>
 <20260827211652.63504-2-f@lex.la>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260827211652.63504-2-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/27/26 11:16 PM, Aleksei Sviridkin wrote:
> phylink_create() decides once and for all that a MAC supports managed
> EEE, and it requires the tx_lpi ops plus non-empty lpi_capabilities and
> lpi_interfaces. mt753x_phylink_get_caps() leaves lpi_interfaces empty.
> 
> So ever since the conversion to phylink managed EEE, ethtool has
> answered "Not supported" on every mt753x port, and phy_disable_eee()
> has locked userspace out of turning EEE on. That undoes what
> commit 06dfcd4098cf ("net: dsa: mt7530: fix enabling EEE on MT7531
> switch on all boards") arranged: EEE off by default, but reachable
> with ethtool.
> 
> Leave the speeds above 1 Gbps out of both bitmaps. PMCR folds
> SPEED_2500 and SPEED_10000 onto PMCR_FORCE_SPEED_1000, so
> PMCR_FORCE_EEE1G would govern LPI on such a link, and that is
> unvalidated rather than known unsupported: MediaTek's SDK driver sets
> the EEE force bits for 100 Mbps and 1 Gbps only, and the unit of the
> wakeup timers is undocumented with the port clock at 2.5 times the
> rate.
> 
> LPI stays off until userspace enables it, but the EEE advertisement of
> a PHY that advertises it out of reset comes back, since phylink stops
> force-clearing it.
> 
> Fixes: 9cf21773f535 ("net: dsa: mt7530: convert to phylink managed EEE")
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
> 
> Ports that support neither 100 Mbps nor 1 Gbps are skipped because on
> MT7988, EN7581 and AN7583 port 6 is 10 Gbps only and shares
> PHY_INTERFACE_MODE_INTERNAL with the user ports, so the interface mask
> alone cannot tell them apart. MT7531's internal PHYs keep the
> advertisement mt7531_setup() zeroed and EN7528 keeps both bitmaps
> empty, so EEE stays fully off there.
> 
> Two pre-existing things this patch makes live, neither addressed here:
> 
> - The unit of LPI_THRESH is still unspecified, as the comment above
>   lpi_timer_default says. ethtool now reports 30 for a switch port
>   against 1000 for the SoC MAC, which is a driver constant already in
>   microseconds, and mtk_eth_soc treats a structurally identical field
>   as milliseconds. Does anyone have the datasheet answer?

Clashiko complains about the above:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260827211652.63504-1-f%40lex.la

@Andrew: WDYT?

/P

