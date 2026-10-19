Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A524F85B2
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417211; cv=none; b=bUhHpsPx3wgx7XixGtX+RyX65gBeSR2PDwcX5/4Rgm6JvkYQu8l+DQF+eWCTEmM1rILFgQsajgCKRTC0Na9xkRpAdFauffTUekbs3NS3HlMV3PBGI1iNeQ9PCODgo5DtZQEscv1A0onJzUADCJGr2rQkYwXgoiGe2kSVTWj1JIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417211; c=relaxed/simple;
	bh=wZv3qit3PqVwPOCxbvA9JQOzFYusdtSCHyQzH3LGaxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IR0MeYXX2sXiKMidKfOlk7d0Ibo5KcKAcovUg9w+vgA6R+GyXtPfqIFhBKOK4F5VqkrbZ/+gIFOXt5sEGHxl8sM/xfEaHNPvAOsMK3soVmTUWFyPB+K6jd6L2eIfKY1H7MhG9tni4s7Ue+Rh44YeJfWBMuocxElz5EIhxD+hz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBYGnMuD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCqandS4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBYGnMuD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCqandS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792417208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzIEK6Y3mdF98EhIAvT8i3Drct8km1nTgvw7YT+e73M=;
	b=WBYGnMuDXe0YXcHOP3tWfg+rCV2T0v3rncIUPUNzmZWr49ShZ6wf2mUU8dYM9sbDWIN7kZ
	dZbe8aMpeNIpBsmsB0qmmkRtsvzx13JZT95stGUz1lAgqds2EPMEBiVimybTgGl9eyncgf
	/+YS1tnhGe9zaMqiQ4dLf41tsyBJz94=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-6UdEAI2oMvKD9pButL1rGQ-1; Mon, 19 Oct 2026 13:40:07 +0000
X-MC-Unique: 6UdEAI2oMvKD9pButL1rGQ-1
X-Mimecast-MFC-AGG-ID: 6UdEAI2oMvKD9pButL1rGQ_1792417206
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e17d30a79so597664f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792417206; x=1793022006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zzIEK6Y3mdF98EhIAvT8i3Drct8km1nTgvw7YT+e73M=;
        b=KCqandS4MNYZHpEpTmowN+qdQLF1xtP/5bsTOX/MNIG8mzF5KqY8fZCtUizWr/8Jlz
         V6KL2LIs7UR0LEKdSxHel2LzjZqfsCz7U7wQjYO/L+hhF/IxPiEfnn0xQEAR6I8Ekx68
         B2mjAVXbdeeY5MS+gS5o7ISU4+ZSgwbKUYmiCjZdhkerotOk0zJFNatQWjrQLu2h80x+
         +u2PpLx1G953NPtDkyHvJtiAfvr6ENcmviaiQa0Wv/6IgCw72h9DzOau+ofaxaJ6wv3n
         UMdi7dD/I51+ndjRPMXnqGcEaIGgbvL91JvaQ4XnENPoEMb9VALI4r9ZECHLugEJLXO7
         MC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417206; x=1793022006;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zzIEK6Y3mdF98EhIAvT8i3Drct8km1nTgvw7YT+e73M=;
        b=IdAk7XbidsSAVNb7N6ZQwKhXoLPQEkIBIjn3vJitfNA5k8GxQJwh6Iw4U4uoDnSMqL
         wYeMWRJTllpusY/YA0puoI55pnKWd5QtLXS0OrPw0SMPFKh2ZSdRva2u8EqcFPHkmsts
         uw21xx6kuuV+ZKiZohU5WrgCr8nT1JCAc9tWGz3dk1kpL136W2uuARBwuTOVRut8t69M
         HdxROv9SD9Y4Nhv4SpltUBXlY637igrcix8WBOQ9Xu6BrWXrhps3J8z9NqkSTWf0jtwr
         RHQK1cb06mSbJ0ECTM9UV5E4ltNI+E/hXn0hytn/lTmOoLX+horoZ4gwLNoVsyBbX20w
         91Og==
X-Forwarded-Encrypted: i=1; AKwUvBzQMhO5xrsM1UrR9oAYZLvQDSjGZeOroXUladnvIVq56/jVQbNY7kJCannu6omO3C8LiHnpPjY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHifbBc9iFT+N1JtyKzY2srpOGtoipvXR6ONVnfHNMSE4nR/4J
	w4RAxzkEy+BwdEISZ6uXRDuvf3CG5I96yp/g1vfWq7/vd9fQLBsjWln1XdAH/3TXT8z1Nl9HPeP
	KCfIkBygNTpgGoODKYb9xFXO1XPFGHpyYZnmoZWub2ZBskWfVHWAsfPrPQA==
X-Gm-Gg: AYBFou0nAzdlr8sKQSbMDgmzRjsJU9r7KRxo0UPCH02X3018Ern9yKNGGumMJhvQxvO
	EHtk2zstGMfvW4K6Q0mFDHpOLpUO9o/rMBGdpUaWfWQpq2leKrlleAd/FXIL8H/F5idaSpxB80a
	O0itW1DdRVRf1OXrnyt3CEsj9JJ1koqGmg0SWMozNx2AzcRI46Rj8EGLIt9S+Wf+bXFl4VQ0WS/
	NwLUXyfhcGOqRbWjwZazdP6i3z6OWRctnK2asMIgLTPu+nKu5Xj932H3Dyqw60Q/OYmXwK4KRva
	hM/laid6N2GGwn8JbdzlXlePQp3PbO3FIWwU606hYl7+n4KIyPV/pD0YQDEaPYtB0nFBMfwIaHS
	G7+RhA0hIne1VinwnJXmX/N+5gypWTWdqVuIDYupTpeQ3caeI1OZJTGux/b+l/SWQYNHRfOgFWA
	==
X-Received: by 2002:a05:600c:19d2:b0:4a1:d10c:7170 with SMTP id 5b1f17b1804b1-4a1d76262e1mr160994805e9.31.1792417205119;
        Mon, 19 Oct 2026 06:40:05 -0700 (PDT)
X-Received: by 2002:a05:600c:19d2:b0:4a1:d10c:7170 with SMTP id 5b1f17b1804b1-4a1d76262e1mr160991705e9.31.1792417202770;
        Mon, 19 Oct 2026 06:40:02 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc8ee409sm292224555e9.13.2026.10.19.06.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:40:01 -0700 (PDT)
Message-ID: <de6dc65e-04bf-40b2-b5e6-d7035d2f9b7c@redhat.com>
Date: Mon, 19 Oct 2026 15:40:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: disable TX checksum offload for
 jumbo frames on bugged cores
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, boon.leong.ong@intel.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
 <179190522792.434549.2113659711683261245@kernel.org>
 <as5PVATLFOcTHbkV@lore-desk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <as5PVATLFOcTHbkV@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/26 17:33, Lorenzo Bianconi wrote:
>> Thank you for your contribution! Sashiko AI review found more severe
>> issue(s) in other patches of this series. This mail is only an FYI, in case
>> you want to address the nit picks below when you respin.
>>
>> Low priority / nit picks for your consideration:
>>
>> - [Low] The commit message's premise doesn't match the tree.
>>
>> Pre-existing issues:
>> - [Medium] This problem wasn't introduced by this patch, but
>>    stmmac_xdp_xmit_xdpf() never looks at priv->plat->tx_coe when deciding…
>>
>> --
>>
>> net: stmmac: disable TX checksum offload for jumbo frames on bugged cores
>>
>> This patch turns off TX checksum insertion in stmmac_xdp_xmit_xdpf() for
>> frames longer than ETH_FRAME_LEN on bugged_jumbo cores. It is meant to
>> match the stmmac_fix_features() workaround that the skb path already uses.
>>
>>> The XDP TX
>>> path bypasses that workaround, so once XDP is allowed at MTU >
>>> ETH_DATA_LEN, jumbo frames sent via XDP_TX or redirected into the
>>> device would leave the interface with a full checksum insertion enabled
>>> on those cores - exactly what the workaround is meant to avoid.
>>
>> [Severity: Low]
>> Can this scenario happen in the current tree? XDP still can't be used with
>> a jumbo MTU. stmmac_xdp_set_prog() refuses to attach a program when the MTU
>> is above ETH_DATA_LEN:
> 
> This is actually a preliminary fix needed to remove the MTU limitation when the
> device is running in XDP mode.
The point is that this patch does not address any issues, no it should not
include a fixes tag. I'll drop it while applying the series.

Also a more explicative cover letter would have helped.

No need to repost.

Thanks,

Paolo

