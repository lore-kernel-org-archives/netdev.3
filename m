Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705033;
	b=mP060dqEVLNkGJJsX2qEzLdfJhOrfwAzS01cW8Zt+p9ZVlx2If2j2mg5y6pi0bTWQl6Z
	 N+eJNFR6AGAy8CkMedIPk8Jpp4ejQv+9fkzhU0dB/ipJEvhtfDSyVUYiQcJIpYR5LC6T4
	 hg6L0Zk1paPfjyxYFOO+h81teYdUIxrbNzhCL07YyC9stlRQj6+qaUwA/TrsgQ3Js0N5g
	 eotYiaLTx9moPyYgM4D9h8iRJdKaPCrA8bYsGFrO69X2tyVXzf/NwXrPUoT2mdU0mMwXt
	 rP6PkXBEBAP6YVwZZRLethds7Xmrg3RmOjfbo5tRXvkUH0vjOFO1Ju0fV4eTrzDzosg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705033;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=O0ydARdHpR5wmfKN3T0hTmGNcktwao6e7xy0q9wcayc=;
	b=FJCHBXJo3DJJYTlho1N6TDXFftGpFDtzG2NKdmSJDNEegLsEL8na8bM5FClrHF9+xTlZ
	 D8bPKZIT8wXe50HK1i9Q374S/3xxm2onUrMEZSHE3dNpv2cOVqzYkc0HVkgGbc4J8FrfV
	 dN1tsvzKVTV3PyIKPkbHhgIsh+SjKx9HS3cF0nZhTFgFkDxt+xOiPxFohpSLuPL4yemMa
	 7zVhCkumY3sqA2K2a5iQQEuEAr22TyjLpzzNOKjwsXlhBMTVoJdR06XMHr2Ru1rkrWJKE
	 Iyba3WcqadxMet22woBcpr34Ia9toL41OHGvlIYJHTaJTCbqov5Xjkp8nf5AQj4pzFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hLioOj8S;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MgB2phEo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158D606EE9F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F158D606EE9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hLioOj8S;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MgB2phEo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793705032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0ydARdHpR5wmfKN3T0hTmGNcktwao6e7xy0q9wcayc=;
	b=hLioOj8SzY/aSvISV5AeNm5Eqmhbpl467N7zvXP0tsUpV+XraWSkDk6G63uhad/HWd5+P4
	r20iF093M2dc72XwX2he6rx9CJNhRbOl8EmQ+pUK9+ZMeh4kOfTlPNQE7jpNmHElZzDiiK
	AqIejIctNk6VIrO8AiryQyp0C82uBek=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-RgNkdWWpMsWTr3TS4ppXfQ-1; Tue, 03 Nov 2026 06:23:48 -0500
X-MC-Unique: RgNkdWWpMsWTr3TS4ppXfQ-1
X-Mimecast-MFC-AGG-ID: RgNkdWWpMsWTr3TS4ppXfQ_1793705027
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dff112136so2648493f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 03:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793705027; x=1794309827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0ydARdHpR5wmfKN3T0hTmGNcktwao6e7xy0q9wcayc=;
        b=MgB2phEokuXFg7w39ty1l9ZFsZTBAX8R+dWoG5gvy617XkU0uZHoqTBopqqt3lRTLq
         blzokt4rnI0jci/wON4rBAyz3ymSjDPuYYvvgpRB+Z6f3HwFauHAnvmtOxYHvnbXYfLf
         63WfSnjAjH7yfLGVEf+/wmywvob7lgH30PjRClaVPkZaB46WIwT3CspJunPJI+Ie4ngg
         K6R66kMp5AVblJATine/TOyg2tYrJJJ3m+CbKfdD21IM/V5rrYjJxFryidZmjMqHNLx9
         MZDTr9SF/hTW/t0eqEh5AA5KtmrVZ6dhEqr6dORytMqwjf1mVHryp3dvKiE/IpaNz3Ac
         aIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705027; x=1794309827;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0ydARdHpR5wmfKN3T0hTmGNcktwao6e7xy0q9wcayc=;
        b=muxlsiaAJcxUPar7ZQt6H0dbUOYsM8ZcY96iEHXAF3ckdA8DhI3PInspzaplfvf6vH
         FfMZusx39/CAxUZSKSI5IvWcsZXzTjjt8/mOJ4fjXexZ5uXgqmVN73lX4fpS352+MMVz
         A8ubXueStURmIXuOAKwu0vPvrSRJruoizMqKJAWXxXdnMg/v9i2ySD3P+PVAOYtBcD3i
         FGePliBCY9igIv28tUHR9fMTxHBLT64LlMlHOlm9bJVTlMPU2TmyrtTUP5cvsSxkVx21
         UfjDKIRXYjm6GEQ1wieiqeAFJMwt9CfqSivUI5naonLEeA6f1MeGxEQrv1CFUe9O30gt
         qG1A==
X-Gm-Message-State: APuU4Z8sZoUPcbhTQQRmeNUEhU+nnJc3ZqK965ZQUZIVw8NRQYJ0ZzGw
	MEyLMUB84cQE9gQSyK6+JBWWAorcUz66Pb+vBI5mtWbJNT5P9Ey7Ine7hVk4nPa4PxjyMYm9vu4
	7MMbaUpV3F+VkmBiFQTgurPacOYAB5uTW45vkkUMDdbsfiPk5weUKAKKqgA==
X-Gm-Gg: AYBFou2E7Mk+pV4Pz1psCQhiO06wQ7dU55o6lzimKedLV2EoMX/BN6tGVVLmNqDQ/CV
	rfLbMWaMReOJfvEBP/uvBpKiCxEZ8Dgw0QISmR5XJ8uMs+OATyGsRiAiMd+mRLagnuUFJURvCN7
	W2bHF2Y5XRrhDUPKO1iEjcI66JlsSsIHrsruQ+TZ3l9WC7opvPoOG7MUS1oWgeidzY6fOhVj1m+
	IQrACCQaGyhQtc85z/A/cjGumAzg5FaXMc163dp0DDSvj2AydU98gPgsQTYb3bN/ODnfJ1NqADf
	uveiniXMA3mRCcJC1aFABvFhOJnBqsQmyL6mp/5LWW3v40lbFCVIbQGz5VlEVR6vKUN4KSfel1J
	d1Fpro+n9FcooK6HTiqbaAvHKbo/MMRymdNh5hf3m8F1SwHABz4Gp5y6RV/gj0NNHaIJ8Ylpmjt
	KmP4wUMtGs+02basRMPezbKp0UpY+H16ciTvoSTbEplJY=
X-Received: by 2002:a05:6000:1aca:b0:48e:932:aefa with SMTP id ffacd0b85a97d-48e6e2f66b5mr28935386f8f.26.1793705027400;
        Tue, 03 Nov 2026 03:23:47 -0800 (PST)
X-Received: by 2002:a05:6000:1aca:b0:48e:932:aefa with SMTP id ffacd0b85a97d-48e6e2f66b5mr28935346f8f.26.1793705026929;
        Tue, 03 Nov 2026 03:23:46 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78c10sm24129554f8f.25.2026.11.03.03.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:23:46 -0800 (PST)
Message-ID: <dd92fa56-7c57-4a6e-9598-20d4363d0a66@redhat.com>
Date: Tue, 3 Nov 2026 12:23:45 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ti: cpts: drop the refclk mux node
 reference
To: Wentao Liang <vulab@iscas.ac.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261103102858.1340800-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261103102858.1340800-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 11:28, Wentao Liang wrote:
> cpts_of_mux_clk_setup() obtains refclk_np with of_get_child_by_name()
> and only drops that reference on the error path.  of_clk_add_hw_provider()
> takes its own reference through of_node_get(), which
> of_clk_del_provider() releases later, so the reference taken by
> of_get_child_by_name() is leaked when the mux clock is registered
> successfully.
> 
> Drop the caller's reference once the provider has been registered and
> its devm cleanup action is in place.
> 
> Fixes: a3047a81ba13 ("net: ethernet: ti: cpts: add support for ext rftclk selection")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Please have a look at:

https://elixir.bootlin.com/linux/v7.3/source/Documentation/process/maintainer-netdev.rst#L386

also please note that such limit refers to related patches within the same
series. It's highly discouraged to have more than an handful of unrelated
patches in-flight.

TL;DT: please stops sending new patches. Likely a very limited number of the
one you already submitted will be processed; you will have to wait a significant
amount of time for any new contribution.

It's not the first time you have been asked to comply with sanity limits.
Please respect them, I really would not like to be forced to blacklist @iscas.ac.cn.

Paolo

