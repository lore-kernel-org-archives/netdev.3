Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCCB3ABDB3
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071220; cv=none; b=OjKrSaGCmGWbwt35rCmurB/vfGOpv9sBmNPdThg12D5us0mRGFqkoVb2r4L+96Cl70ln1TdhCJjczZTmCZozsiJwzdM1L5XZEcEHI85vWagTBsaDR4Any4kT91jSMjVv/zB+YG7AIXODTjZ35syKicQJ1JR5qNWIM+vOmV2uSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071220; c=relaxed/simple;
	bh=gTY+h/NuzpesmGErL1qEJZmI24+CMD4bb6jK5BtcFDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbD8Ge12M92ZEJjYDqYw/92nD1IjqOxflaa9i+GKdCabURf/E3QvDf/LXqxM7zZ6WcD2nRkCdIxofPVYIokuB0wXnv4j7Ts+AMxg845nd8wJUbhigI7kdPA3oNnJX0XxGmLyB3o7ftbupxqO2tgfJOzY7/M2u9MCv53rjelEnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfG96hux; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxXJU9z+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfG96hux";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxXJU9z+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787071217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrmIobcbrx92GsvO+nwW8lBGJJA3WTKLpLDzWnDMpwU=;
	b=gfG96huxnxjkmVCT9ciKVSlHwQQFl9SlWTaOqTDONneunRKD+9sX6yPV/VzSogXcQB7OH9
	IFj8W7FEh1zhWqL2pbYzMM1v6LjjuH3nI/Dg42UiyFwu5uyjWx7wQwoFHTeuf9sB1E2LXY
	Sh4D/a9quhcu8uS9RRJLnVQgB5dQToo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-ggJnQVpKPZqcoi_CKj95Mw-1; Tue, 18 Aug 2026 12:40:16 -0400
X-MC-Unique: ggJnQVpKPZqcoi_CKj95Mw-1
X-Mimecast-MFC-AGG-ID: ggJnQVpKPZqcoi_CKj95Mw_1787071215
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47faa02f707so938863f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787071215; x=1787676015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrmIobcbrx92GsvO+nwW8lBGJJA3WTKLpLDzWnDMpwU=;
        b=AxXJU9z+LZYur1z1S6Npo+UdANoHlgCWVFWZRJJ28C/BZ/xHoey0ncTkceNN2G5Dgn
         yFHEy4Z+7Z1s0VCvBY1jnkDoZl6SrDtlDhVFm3gq6BU72Du9aXJK3MkOygUZQLCEeeV4
         Tsj5Gfik+1z+ecrnV0MaDvYQONiXD4d2d7MiAmnDTrDmK4U9jcNpjlBQyek8UvERiwgj
         i3oLiHGiABinRxaF/0JZKWrMdMErR8yOtfE3jRc8GdEQ1UHoL1jMOEhvxnvtyjk41ZYN
         ZmADIwxVInVaXKwUl01zZLwVDFbxm/0s5BKHvtk/Vj19f9BQj74BmXj3NGlJWnFsQUg+
         8jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787071215; x=1787676015;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xrmIobcbrx92GsvO+nwW8lBGJJA3WTKLpLDzWnDMpwU=;
        b=bWpl21as0bjtWxinkxHVwOWhfYnCstGILRq8/jh0WColC72GaFiEOnvV/oZFxmvaUQ
         6X7i6XLbSoiPD9Pr7KJHTLzcvAQxXAbUF2keYGQZIr5neIwGjVyElc5hfKBfV1nczwHx
         EOWaSIAywd3oSr0pgGgACKEvJXg8tNX8yX14R7Nyynx34vIeTn8ssUV2tioPC4sIb0my
         v5Js70j8633SL+FCyWRJKaGRhWTDscQrydFTKVU0NVuT+vHpi2SN0NRfUWzHplqEYx0T
         Mv+HS6wYXWKs9s0DeknUm0mcI0PdSBFId6JTI9TkfonlkU7ampkLoy4ly8I6t8Or7fR/
         qAcg==
X-Forwarded-Encrypted: i=1; AHgh+RpwZYbqA4a3n7Xl86DzYU0hRjWJvWdVS5Wsn4/bvc7GJd52VQIlhjGlfMQMUZ9mcRFNMCGC0Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSYLrDVitWhKswDGqHiQ1riIFH4WSnf4V6bpAomNgYYyMOams
	Khanc/PrsT1s4/XCarTckXNDZXI8l7NVdt+krnupHfTf/+uIMhk0/Ggea5FuL9P4NKudcS5m21K
	qKYngirt6EEr1mMsyrqqiA0o0J5V4YPV+NtINtfiLcsuz8IprlexVaOb6sQ==
X-Gm-Gg: AR+sD13aKtaBsNAiMNgldakihqwKi+GzdQnjfASTfipazojI3Vbhr0KawpQZjl6uR0a
	S2k7Wa9CVoDzQ3yz7Mbuvj+nQxPI7RLJkgy104rH523GRijyYL154TPYF+fFTeQ6vOrhXS7iKQ5
	EG8mXuFsB6OB7iqhxNJnSWpUm7yGRwLypqrk7QszT1NX3uixN8JIuw+b7+ut7NMIDXxEoc/R/Oc
	huzuMAM4KWECdLdllFdDvsTc+hNQC536FekDavN/WwnO7fFUgiu75FCbmoxU9uBRz2xOOjE5C75
	guP7AbpzCIIvYdiOcHzvNl6S06wxWC1KbvGOVL2oGqh7MVgz0gejmr9lEsUWqu8mC2ViMNN8eA=
	=
X-Received: by 2002:a05:6000:1888:b0:47f:8cd3:4bed with SMTP id ffacd0b85a97d-482aaa695demr11693948f8f.5.1787071214618;
        Tue, 18 Aug 2026 09:40:14 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:47f:8cd3:4bed with SMTP id ffacd0b85a97d-482aaa695demr11693852f8f.5.1787071214158;
        Tue, 18 Aug 2026 09:40:14 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b77f41sm12399020f8f.27.2026.08.18.09.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 09:40:12 -0700 (PDT)
Message-ID: <f84733fe-72e4-40fa-ad6c-0915aca9e204@redhat.com>
Date: Tue, 18 Aug 2026 18:40:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To: Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Networking <netdev@vger.kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <aoR9YYY2P5--3x0N@sirena.org.uk>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <aoR9YYY2P5--3x0N@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/18/26 17:42, Mark Brown wrote:
> Hi all,
>
> Today's linux-next merge of the net-next tree got a conflict in:
>
>    drivers/dpll/dpll_netlink.c
>
> between commit:
>
>    33f016b23a219 ("dpll: fix NULL deref in dpll_device_ops() during teardown race")
>
> from the net tree and commit:
>
>    84e85c325e5ed ("dpll: use pin owner's dpll ref for pin-level attribute setting")
>
> from the net-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
Your resolution is correct, thanks for handling it.

Regards,

Petr

>
> diff --cc drivers/dpll/dpll_netlink.c
> index 9e55745e33e4f,a909cd4451b00..0000000000000
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@@ -1109,20 -1089,8 +1108,8 @@@ dpll_pin_freq_set(struct dpll_pin *pin
>    		return -EINVAL;
>    	}
>    
> - 	xa_for_each(&pin->dpll_refs, i, ref) {
> - 		if (!dpll_device_registered(ref->dpll))
> - 			continue;
> - 		ops = dpll_pin_ops(ref);
> - 		if ((!ops->frequency_set || !ops->frequency_get) &&
> - 		    ref->dpll->module == pin->module &&
> - 		    ref->dpll->clock_id == pin->clock_id) {
> - 			NL_SET_ERR_MSG(extack,
> - 				       "frequency set not supported by the device");
> - 			return -EOPNOTSUPP;
> - 		}
> - 	}
>    	ref = dpll_pin_own_dpll_ref_first(pin);
>   -	if (!ref) {
>   +	if (!ref || !dpll_device_registered(ref->dpll)) {
>    		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
>    		return -ENODEV;
>    	}
> @@@ -1181,26 -1130,13 +1149,13 @@@ dpll_pin_esync_set(struct dpll_pin *pin
>    	const struct dpll_pin_ops *ops;
>    	struct dpll_pin_esync esync;
>    	u64 freq = nla_get_u64(a);
> + 	struct dpll_pin_ref *ref;
>    	struct dpll_device *dpll;
>    	bool supported = false;
> - 	unsigned long i;
> - 	int ret;
> + 	int ret, i;
>    
> - 	xa_for_each(&pin->dpll_refs, i, ref) {
> - 		if (!dpll_device_registered(ref->dpll))
> - 			continue;
> - 		ops = dpll_pin_ops(ref);
> - 		if ((!ops->esync_set || !ops->esync_get) &&
> - 		    ref->dpll->module == pin->module &&
> - 		    ref->dpll->clock_id == pin->clock_id) {
> - 			NL_SET_ERR_MSG(extack,
> - 				       "embedded sync feature is not supported by this device");
> - 			return -EOPNOTSUPP;
> - 		}
> - 	}
>    	ref = dpll_pin_own_dpll_ref_first(pin);
>   -	if (!ref) {
>   +	if (!ref || !dpll_device_registered(ref->dpll)) {
>    		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
>    		return -ENODEV;
>    	}
> @@@ -1313,24 -1221,16 +1240,15 @@@ dpll_pin_ref_sync_state_set(struct dpll
>    	}
>    	if (state == old_state)
>    		return 0;
> - 	xa_for_each(&pin->dpll_refs, i, ref) {
> - 		if (!dpll_device_registered(ref->dpll))
> - 			continue;
> - 		ops = dpll_pin_ops(ref);
> - 		if (!ops->ref_sync_set)
> - 			continue;
> - 		dpll = ref->dpll;
> - 		ret = ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
> - 					ref_sync_pin,
> - 					dpll_pin_on_dpll_priv(dpll,
> - 							      ref_sync_pin),
> - 					state, extack);
> - 		if (ret) {
> - 			failed = ref;
> - 			NL_SET_ERR_MSG_FMT(extack, "reference sync set failed for dpll_id:%u",
> - 					   dpll->id);
> - 			goto rollback;
> - 		}
>   -
> + 	ret = ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
> + 				ref_sync_pin,
> + 				dpll_pin_on_dpll_priv(dpll, ref_sync_pin),
> + 				state, extack);
> + 	if (ret) {
> + 		NL_SET_ERR_MSG_FMT(extack,
> + 				   "reference sync set failed for dpll_id:%u",
> + 				   dpll->id);
> + 		return ret;
>    	}
>    	__dpll_pin_change_ntf(pin);
>    
> @@@ -1534,19 -1415,8 +1433,8 @@@ dpll_pin_phase_adj_set(struct dpll_pin
>    		return -EINVAL;
>    	}
>    
> - 	xa_for_each(&pin->dpll_refs, i, ref) {
> - 		if (!dpll_device_registered(ref->dpll))
> - 			continue;
> - 		ops = dpll_pin_ops(ref);
> - 		if ((!ops->phase_adjust_set || !ops->phase_adjust_get) &&
> - 		    ref->dpll->module == pin->module &&
> - 		    ref->dpll->clock_id == pin->clock_id) {
> - 			NL_SET_ERR_MSG(extack, "phase adjust not supported");
> - 			return -EOPNOTSUPP;
> - 		}
> - 	}
>    	ref = dpll_pin_own_dpll_ref_first(pin);
>   -	if (!ref) {
>   +	if (!ref || !dpll_device_registered(ref->dpll)) {
>    		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
>    		return -ENODEV;
>    	}

