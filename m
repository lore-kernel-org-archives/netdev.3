Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E614189C5
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182833; cv=none; b=llBe0mDhdKNxQ7nHZ5buVJGG1RwKnNrzoYPLITY1dNkuymQeYYL4W5fs13Vn2xN8+NHH00ASxKVH5jugoLDZOvpznIRJ+obT1smhtipfGokBO60AmmeN+3Az0ZPPh9nKiwx26r3eFd8G3HULKa78YcJn8nyRNAXr8REYTLXm9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182833; c=relaxed/simple;
	bh=IL49NG86hmpfz8FoyuNmWr2L4LF6fI/1jpdmfWoBgdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nfx4zXbn7tB6UrmyHz+gX7vD9hZdyo7rOhxqKnOBpqKWHpg/1KVa2hTPeS8IROhjm4nzamcPUnjaD8P6X7JIxX8ZP1OxMzXy/TfwQLBBH7cDdVQUQ//FLXbO+zbroaHl0J+Brk1MUxhhgMC1LRRvKrWz9vx6xEJIpNv/H85bnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LQ8/cE6O; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LQ8/cE6O"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so10737655e9.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788182830; x=1788787630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9dJl19p/pVq6YV4fVMLMZrL500AfikOykyPbafsX3fM=;
        b=LQ8/cE6ODIOl50xgcmqVQbiXieHe63vFArtlgOw0ODWqbotYupC+39rjCZvnS0PkPK
         TUf3/rgD+qpgOqkD5a6s2kKs8OHPpaaEady3TO6cPu636201k9ox0wwpiVTxS9Iah6Df
         JaW9KpeiAUF94Qk9EjS1jxYoKKcG7pktWsh81RgJsoTiPnXqIHX4XAxraydaOR5O+zdO
         2Pkoc61yEPPFc905PLq43x5ay+8VNBpG6uRLMr6eobMGRRxWw1c5jLDpTxCFM4xHm1yx
         QNTpeu0p92QsynUxvZDlZ+3CZhfemZkoxbd6Zx3uyHlz9wuBXmkeQT6ljqR9heYGQUaD
         jatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788182830; x=1788787630;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9dJl19p/pVq6YV4fVMLMZrL500AfikOykyPbafsX3fM=;
        b=E50D34TrBkN53EqNBvwKQYF52byvKunmLopHb/w9TBv4N0IRGil0oJ4oGatXozdjw0
         S9RmudzPFvDamrZfiOm2jZP4ADtttVAwSp4S+kJvd4aPVgHIuCv6cq+Vt4/Tm8208Add
         ojR5ZW+6xdrjcI2+a9FzZwVHTrIg5yA4IGW+u/ly42Ib3J2NHlFDvtx1I082/wMEe1Tc
         XLk1NQwkttQqG9Aso7dRyrjSMSpjWrHU9rNtyLRCsRDeaNvi1mV32pqLaU7sx6Ll+iac
         iDVmFjpl/aNoBbpBC3qArEUl0J0G4s214SMq0IsJVmAUmD4hCBVTgQYUok4B3ZvT6AIn
         Whbg==
X-Forwarded-Encrypted: i=1; AHgh+RrGLrP/yJtzzYhU5nzhC3/71dfSw3Eg1ufsaqVey7jm8Fcr/iqe737kvFby3tWytinvNgKWCCM=@vger.kernel.org
X-Gm-Message-State: AFuF++li00Er8VvFO4PMUUzAT3+HdkAhhd+/tznjJeTPgPMYOrSXZ/cY
	67VC97qNgXHQqSel6TorY116hgyHlE6o6mVqvMKgnVonWKUc55twv+A84ak63X2hNUuQJ6wFZ25
	l5545DeU=
X-Gm-Gg: AR+sD11vvdPcis5zsL4/tuIRZqQiJaDz9gPKvtdB9+IDy8s9498zOoD9JDKS/roLacY
	mmc+etAC9/v3V7HwLc3u2R/JgxTFmvUu4FpKNUBTNMvjyfiJOhbk9zVWLi6d1Bo9359ChiKyQ+N
	veUXLCOPoF7i2NPm6UmK5WMZpa/Fzc8qNlIPVUbxnFLX/lXjmSnvX+AUe0KWV6yIh0nL+IvN0ek
	dYyHHoFP1wJ+27v9qSVCWFVlqAJYIRP3HtoNzHCO7amT8celggK2GWLPjIQwpUQJgs5Y2bk+LgZ
	yQEKC69kkq6DlvzOuO1mveXq7Fxf4anBxhWTakl4zJflYLOAd/ohGzSB9bMnsx1UKu/2nDhfLPe
	oI9FFddgVLhIqNAg/WyIz8wJRsdLtpaL4wbkd7KYL5NtJ9SdMGV9lCWmMVn+nboQJIEdSMksX8E
	yshIUmam+VLbjRDqRjHr6mEoeRZu9G/5vrYTkUeFXozViP4iVQnMtT3pSrHyXJRD/cwVS6P7RZo
	CEH494fcpSrZ8miRBQSdEBqFiDvu0c=
X-Received: by 2002:a05:600c:3511:b0:499:adb4:a922 with SMTP id 5b1f17b1804b1-49b91c4bab5mr295369375e9.12.1788182829769;
        Mon, 31 Aug 2026 06:27:09 -0700 (PDT)
Received: from ?IPV6:2a02:3033:283:b9b7:bec2:3dce:f757:ce06? ([2a02:3033:283:b9b7:bec2:3dce:f757:ce06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccea6b814sm176057695e9.0.2026.08.31.06.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 06:27:09 -0700 (PDT)
Message-ID: <ea165ff8-cda2-4fed-9354-1d14ac2d87ca@suse.com>
Date: Mon, 31 Aug 2026 15:27:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] USB: usbfs: replace __get_free_page() with kmalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Chas Williams <3chas3@gmail.com>, Duncan Sands <duncan.sands@free.fr>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 accessrunner-general@lists.sourceforge.net,
 linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org
References: <20260830-usb-v1-0-aa349c302246@kernel.org>
 <20260830-usb-v1-1-aa349c302246@kernel.org>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260830-usb-v1-1-aa349c302246@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.08.26 10:10, Mike Rapoport (Microsoft) wrote:
> do_proc_control() allocates a temporary buffer for the data stage of a
> control transfer issued from userspace.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.

You are breaking the calculation. A page has a size of exactly
PAGE_SIZE. A kmalloced object of PAGE_SIZE is larger. That is
a bad idea.

	Regards
		Oliver

