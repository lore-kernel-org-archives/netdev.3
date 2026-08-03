Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB440314F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757445; cv=none; b=S5NT47s+8LHXamslZWpvUxFXwdH45A0js6dMmTFi3p7A4CAly2zNb9a7Mrp1FurAVQWqFKl86eNQkx7wMF7HmZTYXCykxwKSMoRXT0PGKvsWXf05I8AYhup5DAEfu8n46ivVgjgsO2nuLcJGdmzktVYCqiTewYoNlXjeb4pRGXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757445; c=relaxed/simple;
	bh=Zl7GWTtdnB7+Y+NWolBUiZbYqRMoB/peJccGM09/X20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkTpRUvKIQqdSKQJNV91lemdx17cEMPI+/q1/3HdWfUuF9wvw93BKFvYIgCV3W8wfdipR0/5x9RZdAOZa7asWODYk8+8CfcBDbXksZmJm8xLJ/XM2wxhxEl7j4GgU5VGRZPaJXl1VbK6SNPNkK2bCZOkveSLUagBjj24REJH+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso7720585e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 04:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785757441; x=1786362241;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQnNMBk70iYPgZFUOLQMwigsxcXFPXeZPMCjYWq0Ziw=;
        b=iZaNrhOQtLIr/M2w7giHZvN0pAOlBWKyoslB9AUJOAF9GF/ATv6YbZ1z00V3Y9c3cs
         3F5HcyWja529wVsCuvjxTnQGOCBaDNrI/2JJzYhBij5/Vp4ZgJMSeMknVzndPRhllbQF
         i6OSWKliafOwcpLDC/cFumLqCn+IMzoPnSpeZkt1lVEJqDA9zvQ0JWSkr3m8Vz6EZCSQ
         jFTT6Qj4wtYDjDwhQtawmH37RE65AYY0Yw12D86GhoAuh11mkw6BJjKi6GQBd9vIjYdI
         KTnLaQbHJlRQ4gNYHA4kfM0wxEgJyKm3OW1HAlNR/lY1tctfFUb9V77dxBthapFh7tUO
         a+JQ==
X-Forwarded-Encrypted: i=1; AHgh+RpISyq4JJsRYFK/up+ss+EP2ATxbLh9NIqmyK/d2GhH4fpOrcTRwb1r2wQyJOVm/FsJJvaWmgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBg4yOFu8C5UavK3IaPZsBmskRDqgk+CAQGla5BVoBm2PIiKQ3
	Jdq5hy35p508MZRU6o5eIOHFyB1g6UCHsEBnmqqa6h6806yHFV+2UTaj
X-Gm-Gg: AR+sD12DZOxhOJthrC2wmUBhvJcSVTjEg0piR1JCb548vWBXuYowsY5KpELIDglpZCs
	+Oqglh+ZZdducxqFCnxogji58ISvYl9hAV8Ps5AbMTkQmIG5rqZJ18M+SSwQbdgxx7NJyuOxAQo
	lPBBja7ITg3xuse7j6FwgQwz4wJvx5Gc+BiAJxMV627ZCbsg6xIujgL2nrzB4OlGanweETj9Dkj
	3HJ8SPaAw7PvDWQDKhl54H+MdJPSzh2I3Ce2h7+6gKAwkPI6daV43aivDYd0JoehsHPaWGMrBoF
	OXHqCvNQEm2E6kveKYAu8rnW6tS834MYYHsjGPH/v8BB/IEPNPsDGDa7lpj6BMFP/x8nwJlIA1h
	WgmZGallV4q7vbyrYRNclKj2qnixp8vUb6X5gwshcEKsDKI5OKQ9gWtlKUUafhcxiVRN0NLwDRN
	rdnHYCNQzBHOEXB2JIsr5aXlINQNhZmXDRwA8qpmA89WkR2F2ETslkXtr9gWwP/s2+quEsb0dy6
	k+dser1zRA6O/3jdOyWiakouirTM1AcXt/L
X-Received: by 2002:a05:600c:4689:b0:498:162a:dbda with SMTP id 5b1f17b1804b1-498162adbdfmr87785705e9.5.1785757440856;
        Mon, 03 Aug 2026 04:44:00 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1240sm31124111f8f.36.2026.08.03.04.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 04:44:00 -0700 (PDT)
Message-ID: <612b806c-e096-48eb-a87d-52b4fe5e7e10@ovn.org>
Date: Mon, 3 Aug 2026 13:43:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/1] net: openvswitch: reallocate update replies
 for mismatched IDs
To: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org,
 dev@openvswitch.org, i.maximets@ovn.org
Cc: aconole@redhat.com, echaudro@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vega@nebusec.ai
References: <f7bbd3c30ce81a39156e226b3872d73abed21d2f.1785644623.git.zhilinz@nebusec.ai>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <f7bbd3c30ce81a39156e226b3872d73abed21d2f.1785644623.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 2:29 AM, Zhiling Zou wrote:
> ovs_flow_cmd_new() preallocates the optional reply skb before it takes
> ovs_mutex and before it knows which existing flow will be updated.
> 
> That is normally fine because the skb is sized from the request flow
> identifier.  That identifier also becomes the inserted flow's identifier.
> For updates, however, a request with a UFID may miss the UFID lookup and
> then fall back to the flow key lookup.  That lookup can legitimately find
> an existing key-identified flow.  UFIDs are optional and the flow key is
> the primary identifier.
> 
> For echoed replies, ovs_flow_cmd_fill_info() writes the matched flow's
> identifier, not the request identifier used for the preallocation.  A short
> request UFID can therefore leave too little room for the key identifier.
> The fill can then fail with -EMSGSIZE and hit the BUG_ON(error < 0) in the
> update path.
> 
> Once the update target has been resolved, reallocate the reply skb if the
> matched flow needs a larger reply than the request identifier allowed.  Do
> this before replacing the actions so the request can still fail cleanly if
> the rare extra allocation fails.
> 
> Fixes: 74ed7ab9264c ("openvswitch: Add support for unique flow IDs.")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v5:
> - Rename current and desired to cur and req to avoid the kernel current macro.
> - Split the ovs_flow_cmd_alloc_info() call so no added line exceeds 80 columns.
> - v4 Link: https://lore.kernel.org/all/3b76cbe50252a5650c3b69c789ed36481d0bbee4.1785583308.git.zhilinz@nebusec.ai/

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
