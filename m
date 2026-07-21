Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2342D763
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628174; cv=none; b=DdsfRYCtkxC0KVK6XEY3lU8yQKj7szxcUhoRq7URTksL7LP7TWjQ23z6ZtyKtRupyv8Dy6PhqMnyFWqmSC2HNnmQjTSGqrlNX2BrK6015Bl7Xq+M4fBmtOGjpWnx+MkAB2u2IKM8TGhGQuD2uG3HrWoOfbUpM3Vkbzl77ofKfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628174; c=relaxed/simple;
	bh=p61gCRXFIm0NiiY2OG0adIIyMTBhQAMC79Dsy1XTIxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TjgyFJp1Wm32wK/00juCdCK3t9PaYRKXtk6EfCD0ZQ3acKs7UH0iVT5bimqng7cTT3z63Lu4iQtNyvrXurHQNXoBlvdAzw9UIprjIVmKQiAbyzzBl9dVR4uuvJx/PJhg7nJV/qXLnE4dlx+22CpjUmLkYQxTJuupWJ4v8YI1LKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fy40yyLX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yk+y2m2V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy40yyLX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yk+y2m2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784628172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDdpB6ZYwZIlR+moMdqHy53xNfFlVy927sGzMiz2qu8=;
	b=Fy40yyLXiSyK8FdCLzP7qSELmxhKlTKj5BvhDpUH7wQFdYskwzXfxJyLnAYDOoj6+rclzN
	m1OvxA9fFUDx6oJz/YEJsW6CM+RiO33r3p39sGkWs0nTALkRMfn4/rsoQggKMrVmtiM982
	YDWO74QLE0cqHk7JZF0q9fqsSsas6J4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-2wzgXSYPP3uJJ0vKwadbUw-1; Tue, 21 Jul 2026 06:02:50 -0400
X-MC-Unique: 2wzgXSYPP3uJJ0vKwadbUw-1
X-Mimecast-MFC-AGG-ID: 2wzgXSYPP3uJJ0vKwadbUw_1784628170
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f5a972b0eso4166492f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784628169; x=1785232969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FDdpB6ZYwZIlR+moMdqHy53xNfFlVy927sGzMiz2qu8=;
        b=Yk+y2m2VTxisxxiK7KH6BYN8bIo5mb7/2ZWRb4ZgCKIeVNTdbFYpKh1kNMPhpT5hDM
         ZbMiVX6PkOybpBZZhBaFD+4pZpqQpSdsihd6udkVEvYRWxOj6271SXBQq0qOQpyW7Cb5
         He4TmGFyFp+/P9+wElnCgjx0IVKjYtPf+PL33wqmzTMF3MDt9dTiIdjpzBLMc5qSLUCN
         N4jVntQuhta1SBZtZLcjjP7zorKJiIRmD6trKG6HfFmG5zjwBtomzCMygpyk2AtE4E5K
         R6qYyYXCXWUd72BmOPjP2kRi9geOUBcO3/yFWRuXQToQfHMQuabAXwzn5fWjZCfN1AH7
         UFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628169; x=1785232969;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FDdpB6ZYwZIlR+moMdqHy53xNfFlVy927sGzMiz2qu8=;
        b=a0XezqmAT3gm6n+tAPhjQ2aFB1vxU/OnDcQ6CusHP3pZvhokBJnVMBvfJpezcNYl/H
         uejkurGKadVvRVQ3vyw3TWJDClrZbPawjoGflD59NkE73SXk2I/S8gmCUt2tVfxbVM++
         g/2QY79KvuIIlrsEaAL1PZusYtc1yUHgCNgp10W1Eqnpcbryje48AiXqWGEWJIRGz+YB
         JzBGQELjhmV/ci+Weq+EnWwbx1VcsrZJVrL0bN0AKanjhIiTGe1ewCyLx9uzo8+RSIbX
         /zJzZU1MsgbGd5aenHK507P5H4LfXdsggrwvsO/ss/yU89pJkEUAwcFSTOgRqeSfcMQ8
         /Tqw==
X-Forwarded-Encrypted: i=1; AHgh+RpaKWNl3z1wMbuvxz5rbOg+Gg7ZpABV/Z9I3EgUvVmThdmGdzbk+0Ai21PQPnk9MsYwkbWuOLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYPPJlBXNReYKfUbxI6zmSF9EJ1TEc1RMCsaWlEdSs9nZddv2
	G5hHJDISfSSzOvkSZ/8dta6mfwsJo8DHUFEAa1Ed0/+jMgq65J03a2/zEdPWgTpdi0Le2NKVUI0
	qmHmfL4dHJv2if8wM6TAgMwfBu9DaAeDTlqMffvk2nIO9lUjwAI7OHwTx2g==
X-Gm-Gg: AR+sD109IDY6wMuN6kFoM08AMqEjzYuZBMJNvcr9mzLsKwtk+Zh8DxvfGDozrNrLKh6
	LLQlfQ44mFv/iMBLlIjy9JBPmYPCEC2WDlWwE+l7LNLx6QKxK9hPOyuspa7uY2sWC/feo9oEp90
	PwpR9DuXjk9BWG0CHK5175u/wV7G30mzn2P5nwdzSYmQgl1GnWDJ88JLldZXMnpiGsf8OPLK1cJ
	tt4BM7NlxMYaJdbt/lttI4e1cQCFi0RL0QgJohb6k/NhRJ8SUUptNFUMgA4p1xVnb7NaGTkGnWv
	kY08NYJoCPaGgUOnapp4WUb6+6i1ofVaAf0hj6dM8OtAZ3IJ1Lw+vQX3pyreBjcYPjveETdzx/I
	Byb4bF6jeNpp8z4zBDyyn/1WPSv2B/0Occfh5J/WbGJc/r6dFDhZyhmIxyOdWM0zlDcbaUe2QzI
	y+Uw==
X-Received: by 2002:a5d:5848:0:b0:47f:71a6:79c5 with SMTP id ffacd0b85a97d-47f71a67a5amr12529388f8f.12.1784628169130;
        Tue, 21 Jul 2026 03:02:49 -0700 (PDT)
X-Received: by 2002:a5d:5848:0:b0:47f:71a6:79c5 with SMTP id ffacd0b85a97d-47f71a67a5amr12529309f8f.12.1784628168390;
        Tue, 21 Jul 2026 03:02:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ce4sm38099290f8f.8.2026.07.21.03.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 03:02:47 -0700 (PDT)
Message-ID: <7e12f83c-2449-4618-bf43-acc533df3a36@redhat.com>
Date: Tue, 21 Jul 2026 12:02:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net: phy: mediatek: add calibration logic
 for AN7581
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260708102341.53919-1-ansuelsmth@gmail.com>
 <20260708102341.53919-5-ansuelsmth@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260708102341.53919-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 12:23 PM, Christian Marangi wrote:
> +static int airoha_cal_cycle(struct phy_device *phydev, int devad,
> +			    u32 regnum, u16 mask, u16 cal_val)
> +{
> +	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
> +	struct phy_device *phydev_p0;
> +	int ret;
> +
> +	phydev_p0 = shared->phydev_p0;
> +
> +	phy_modify_mmd(phydev, devad, regnum, mask, cal_val);
> +
> +	ret = mtk_cal_cycle_wait(phydev_p0);

The above call causes a builder error at link time in allmodyes config:

ERROR: modpost: "mtk_cal_cycle_wait"
[drivers/net/phy/mediatek/airoha-ge-soc.ko] undefined!

Also sashiko gemini has a few points:

https://sashiko.dev/#/patchset/20260708102341.53919-1-ansuelsmth%40gmail.com

/P

