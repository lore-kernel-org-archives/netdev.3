Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2E44C662
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775476; cv=none; b=P817QSk8i5eYILwyktfUNG7uKwnjYs19KBgYee2d4yjITSHKJKZt1BXe0U/inkmsUad7v2M9QUludaZyFw5Mus16iROJmWYeZq8jVSxkdMLlBhHqzxGhPFMlUwN2ppJTFmpaxhahsMF6Y3Sc/iXbPrpvAXamV1Akakcz1fKjQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775476; c=relaxed/simple;
	bh=+teQMwCb+3ZZG9SIk6U0vhcSKk05JushPOZp1ad66x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvB3cWcy8Fc1G2PWZnwlt0ZNQCSouS90c9vR+VVjPvmJ/V2yvUvsoTWMetWh2B+mKURJURpa95aquVATi8JJNXtXTj3rltvHLgVNEjylpJhy3UbSGmnBV4n98e7KbSpPtXQnM5BSviBe1y4yKDObW8snKoE+KYzJsz4wUf3cVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=FjGw9dPp; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="FjGw9dPp"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843178b1c8so273763f8f.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1788775473; x=1789380273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z4UX+NCi3U7FFNRq9NHFzEwnMAylxg+y0nqKeloswkI=;
        b=FjGw9dPpSELwDK/7wZ6R/PVxe/dTp9j71Zhzp5xzouyruPeTGSLzaVBTGCAYmuWNax
         +IaeZjZzRBkNHEptotxuZIVgeGHiT0mpIIrnQKckX+ChynoVWoIsioGZYTmz8d9ETL0u
         gDUzW+K4MiQtQg9ef08QqOmDRsHl9a8D7ZO9dTLc0pSLAlrNEsnMMPk8x+Hk2MopBGl/
         jjTQWCPZiYNy5kW+9E8fu9UzYzm7+aCVYbp7OSaPlrDFxarwKuixVjqnMvluy9e1u1fx
         lznAiWWbeyCYDTCnS/VUlYvEu/mfq1N8VuIuiobxmqZ1tmsvozClLyFTbICHi843Sg8+
         6+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788775473; x=1789380273;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z4UX+NCi3U7FFNRq9NHFzEwnMAylxg+y0nqKeloswkI=;
        b=JZ0+uTBAa8mllo3+9xwk6WNKBxZYzimuWGrmXz/K7sSeACi+QHW4dHJs0LHrkzoafU
         5m1vpfNzYyys+DXvGKerUYw7fpEBNnXrsP3DtKmPLF3Hm8m+l+ZEwrPyhZIGnsm0+iy8
         2qVgQwbJoUhfPCYyPRgHBRo4bQfDrqomRdg0w3gCE/z3ChOg+vhkXPmjnC3Jt7/Z8pcv
         V8Z9VfIXA0g4yoF+r2NxpRdG04Wc7skTqVev09NUEVJ2dbQHgHj2wDvpWnLGeyYNfPlN
         XF6FgFPQpA18mLmCJuBOo8swktQpeyP51b/zaZwTnRiJpnz/3kYeK990nR/EoE/4+dRP
         2Gag==
X-Gm-Message-State: AFuF++kVBQfcJTEQpN6b0E6ADvgKVF6ftTExwnWBudqnOeiI8lgOc0RD
	6zK49Q6FWygypQDvPky4qOY4lHu/VSlF5VgHOf2pctiYJfxIzbkVC0MkFFCFRjkdrzE=
X-Gm-Gg: AYBFou1yoqBi5NvonIS/XnH1QqxdMmI6unKafLgjBTm4VH9Hf98Nkh51pTECvtElXmL
	QyKMPe7iqD1u9JlxeT0Cvm2pUkNCMBZh6LYYblGBPmLZEZ6r15sciq/TJ64jaLGqKAv40kve4Hx
	qtwXyIXl1Fza5EnzhpcTi1G5WOl/jetEFhYo8K4uGUeZlzHQ2xtRxLIgGYJmBejlq+gaEFAM83z
	vy0FCaQPmdLTwmz64am7VEnBbqXHy3WE3Kjk5WiZUcHj7lChAhuRFxRVEJQ8FEPRun4475woiXq
	2UvGVt2kLjivw+raMv3sKcPyhT8C0NB3W6D9dMQ+CZ+nYCF6igpFW/iWQ+LaGznyhVqmqIfq1Id
	pprpix63FkxfBNuzCQp9tejXwIu8YOZAKdLLd+w+a8VL8EHg8eBO1QduQYlvNQOwS65UJJmlFZ2
	NN9FeOXX2WyEH3ROCvz8pzCIGuYDKAqzTPOW4KpaOQEoiOedjesXDkFUBzKvOHn+hJrUQu0APF8
	/m8aE5uhiWoqAB246cjqQHsfqBlqdi4zy3GzAtGCQ==
X-Received: by 2002:a05:6000:2501:b0:482:f930:95be with SMTP id ffacd0b85a97d-485907aaad6mr12731705f8f.2.1788775472828;
        Mon, 07 Sep 2026 03:04:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9b49sm23308319f8f.17.2026.09.07.03.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 03:04:32 -0700 (PDT)
Message-ID: <572c628f-b297-4b60-ae17-3c39346331d8@6wind.com>
Date: Mon, 7 Sep 2026 12:04:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 1/3] netlink: specs: fou: add af to the shared
 attribute list
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 kuniyu@google.com
References: <20260904191412.3872344-1-kuba@kernel.org>
 <20260904191412.3872344-2-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260904191412.3872344-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/09/2026 à 21:14, Jakub Kicinski a écrit :
> parse_nl_config() is the only place the address family is chosen: it
> defaults cfg->udp_config.family to AF_INET and only switches to
> AF_INET6 when FOU_ATTR_AF is present. The &all_attrs anchor - the add
> request, and the get do and dump reply - does not list af, so a ynl
> generated client has no fou_add_req_set_af() and can never create an
> IPv6 FOU port; the local-v6 / peer-v6 attributes it does list are read
> by nothing. On the reply side fou_fill_info() puts FOU_ATTR_AF
> unconditionally, and struct fou_get_rsp has no member for it.
> 
> kernel-policy is global, so fou_nl_ops[] carries no per-op attribute
> list and af is already in fou_nl_policy through &select_attrs - only
> the user space codegen and the rendered docs change, ynl-regen.sh
> produces no diff.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
