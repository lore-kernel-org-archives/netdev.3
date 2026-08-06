Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43423E8660
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009420; cv=none; b=dxifi5Ep5TYAouhkoBokKHIKB6yrfa/zK521GcHothPUngbt+qXQ5wLyrgFhwZbdSKuc6mMbjqy+JxNbLeRHDGSz5HJahaTKO9mz5dyMIyp8Pegfms8zdctL2n5jFBN4ZZNn+fMX3+I0tz0hsaVQ5aA+orFBM8jJS2ny4QnhQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009420; c=relaxed/simple;
	bh=WVi85fuC71r0jKgAHBS0YIyZtQl9l/ZOYkxrtk/VwBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5u9IRlHB6nZoXHm16Wb393jBXqKT4eYpQuxF76JfYeI4HJM42s8imIVQ2jFGMUuZc6LFVQYyh167jXIKT4nk+rVXnatlw63U7fVYKXPyROeYKPaDRR3vmA6HT3DclkuxA2FxoGAPV2YE/jt6VOkFR43s+79CF8wu2GC1xMRbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=baQhfcta; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="baQhfcta"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f71156e1aso923751f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786009416; x=1786614216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YCF0Jz2r7gKU8D2KAM2NRAKBbkkVR2iG2fITg02HPl4=;
        b=baQhfctahSmAlIjDc42GhX2oYjet1MaYUpTpid5Gall2u5PHfeL5qHnCfoWmSl1Hel
         Gji0d22FBiV4SXPIn6btWrE+xViWVbFh8VbbaCpOE+8bjwBXgMFvy/XYQkR+/2kkouMc
         5VrwTDHcovymh3DGzKOqF54wP/8hzzJJOhKm2RPAhgG6DWbEwpjrcv4vwAE0j8bVdx5t
         qwv0/5+T6IlWITgcj186FwFA0G9m4LyaHDNVlxwDe6DSkMgwKKPWioWD6EE8rNIwAvg/
         zgSC24VrZQAa6EhuySIQBbpVfeusWx6yxnj5RyOGhZIGoPChqu20Ba7tY5xYkmi3LsQ7
         ADxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009416; x=1786614216;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YCF0Jz2r7gKU8D2KAM2NRAKBbkkVR2iG2fITg02HPl4=;
        b=T0WR6R5sDfmxFiXK/QXHMadwjcGiZ1YpJml2mB77jBdnxo1TbTE9Z4cU3RShop/H55
         bmTUmH/ZDdkX7rU5cNw9GWteqPRqtYY5hXSxjTFDM2mJ36d2+xs+XyDxkEBtLBncs6ln
         660X43KFn1WHKqnW5NHR6Pk8/bsUgAzDe/kXRZvBJlenb2icOc236j/KzJi8ttCDjo1j
         eXE2vIrsHCEE0N8JJwiXhEVQw88dTZUgWfK2kEUBusRODqalmwo1oQ0hsVNdtK+TQtBi
         Nr9x07AYAjG58C7m8IC3vVvzVB3NdbRVN5DNfB5a7JPj2C3nBYgOeAVEhJZ3A69KeX4S
         C5jQ==
X-Gm-Message-State: AOJu0YzEyEeLeKeAKglta7Kh7eMzKrBpVdn0LhFxA9ero0aYjCT+uQAQ
	m6P0zP0ijGqXsJGsKsmd6PBSuz6cirVMXz8wMkBDX/85hg6ZtGXv1IYWWoG4XB+gl2evhCR3N2a
	uE0ENwBc8KarYhsXDM6ABlpijALMZwbNnLq4r4mNhwsNXOZbPbpsuoZGLfJ684hqu
X-Gm-Gg: AR+sD10+BaD8TwJ7s4mErkjzJCXiTj7+EJkjk2qe6iUhG8I7XALHls89cIxkIKYYZQS
	y9seQ/Pn1lNd3rDeO/ZlobV1Uwgap8POzLduGrU7vxe0lAa8kROElZR1L1V/ucaQw/3+ooS67KF
	KX4KeDtLgQ2VPUPJAfu5tkYFdhQaDZO65zTpv5GnFsuNsVAin3X7MkFLq1yJKDqWjbZbbxKHOPo
	DIZNThRmRvW3UjGRTkEn5Qo/mYVTYN+AhlnMuY2p1WIjMZ0Hvtq8q70rMTZy7NQX+woVHdUq/JS
	xzOmsvjymtMoAEiRshtUCGNw0qRQ22sXxNxWIP7fJSPHtw7hH1BDKAbH2nMc5hlkZyyO3lVlR77
	17sKZ4+MbrrnzoFyJ6AxDax6msb1YmP+QPipWQr25GCEj74qVD7vXwwwXUkxWlwOjX8vrdSYhYr
	57yGEpIMEC7APlmbI9U+abutAgQFstm2vTbmtRLasYvvYZ7u76Yj8G1jYQIO3HH31NJ/t6P1dD4
	oiyxIQ=
X-Received: by 2002:adf:e005:0:10b0:47f:8b9e:f44e with SMTP id ffacd0b85a97d-47fec52828bmr18038588f8f.12.1786009416105;
        Thu, 06 Aug 2026 02:43:36 -0700 (PDT)
Received: from [192.168.182.19] ([185.242.181.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79a718bsm5269469f8f.5.2026.08.06.02.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:43:35 -0700 (PDT)
Message-ID: <351ceff4-658f-45b1-a46c-2c1b3ff142c0@openvpn.net>
Date: Thu, 6 Aug 2026 11:43:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ovpn: don't deref NULL key slot in
 ovpn_crypto_kill_key()
To: moonafterrain@outlook.com, Sabrina Dubroca <sd@queasysnail.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <20260805-ovpn-fixes-v1-0-763f8c237fb9@outlook.com>
 <20260805-ovpn-fixes-v1-1-763f8c237fb9@outlook.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <20260805-ovpn-fixes-v1-1-763f8c237fb9@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junrui,

On 05/08/2026 15:29, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> ovpn_crypto_kill_key() is reached from ovpn_encrypt_post() when the
> packet ID space of the key in use has been exhausted and
> ovpn_pktid_xmit_next() returns -ERANGE. It locates the slot holding the
> given key ID by reading cs->slots[0] and cs->slots[1] and comparing
> ->key_id, but it dereferences both pointers without first checking them
> for NULL.
> 
> An empty key slot is a perfectly normal state. Both
> ovpn_crypto_key_slot_delete() and ovpn_crypto_state_release() install
> NULL, and the ordinary rekeying sequence - install a new key in the
> secondary slot, swap, then delete the retired one - leaves primary_idx
> at 1 with slots[0] empty. In that state the very first comparison
> dereferences NULL. key_id sits at offset 0 of struct
> ovpn_crypto_key_slot, so this faults on a read of address 0.
> 
> Every other slot accessor in this file already guards the pointer before
> touching it, e.g. ovpn_crypto_key_id_to_slot():
> 
> 	ks = rcu_dereference(cs->slots[idx]);
> 	if (ks && ks->key_id == key_id)
> 
> Use the same NULL-safe form here.
> 
> Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

A patch fixing this issue was already sent over the openvpn-devel 
mailing list:

https://patchwork.openvpn.net/project/ovpn/patch/da59b0f39ad7eb59174bd1ffdc2b5ab5e2499e08.1785318038.git.ralf@mandelbit.com/

and it will be sent to net soonish.

Feel Free to test/review that patch if you want.

Thanks!



-- 
Antonio Quartulli
OpenVPN Inc.

