Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320773218B3
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080917; cv=none; b=oawj/vunSxMtxN1C4relGVLxfekvqCKiQ490VocLqP2cwbTJvu6t21E5WBnTErR7A8WP8azGX/VLxsf0EvixDrJNDBkddicZEmp6ziWgxNNBT33d9/zBTmUojlVzHPp8BEC/MfHkbzYO6793gmVwV7A4GXYiIIj49/3gfL9DgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080917; c=relaxed/simple;
	bh=GFVg8/9cUAJSWmjbziLE8FfOqMK+JQxCJrHsXIJt/Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtBcDmQ2Hyw6qg71jbaCFK2bNz+oy5lvQr8uSxGKJXkX3urEL6XBZjXeZJ2Pi/wWIYapJNb1sU1dVgfmhpEcHIYcdS8gKL8UJoES8EBeaoQ/zHZAyPMKUQ9xNfWo4AoPgidmPMHjkAwIK+wS1sLD2EkZb7JSvx5a4Z0ar6wpNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=YXOrG8gy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="YXOrG8gy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d73422431so932495f8f.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1776080913; x=1776685713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0t/PovMpIgnGwUGYbYpIowv0ZhNrCZg5yAKqxRoCRU=;
        b=YXOrG8gykD6D1myRLXlvr/innTSDrT5iB04mJhEiZKeLc78WOF7rFI25qP5/7D93zF
         Hb3VNI+5DlCNdc3miWx3yEalu/GUsk7hFU8mr2hUdk5u8qSpjG242cDyeNJQ8ICHSaDY
         Tubitb+zxu7vuk5VlEf0LVwAqJi4R8ukFZQvVsa8XupsCqtcYUAbEoPg41T/o1W4IveN
         cpwEKRS3IkzljDLu0B6yF5sqsXS522GlydU9Z98NRG5XJW57ZZkv6srBQAji59+X/3BO
         fnoaootMVjU7CY0kq6ytNCjuoqHqEKM2lc00lofJsQTjWSeqrrRB3AAhXTLsxIJtJ2lg
         Xwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776080913; x=1776685713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0t/PovMpIgnGwUGYbYpIowv0ZhNrCZg5yAKqxRoCRU=;
        b=RkoNJlCRYbVcv5vUXyMluBGeqLSRjIabLeC7lPh3NsNjblb9jLQR6dkNvKCs+jDoem
         ri0AqA52pO/n3+RtagazsVy0TIolq/seQdO2dhAIosvr6FEnRv0WF+726e6u1r/Cj+iG
         Hf2Ok4nsXOCbGmqKWnp44rMG+Uul3koKqg5uXkQmpacwI46z8gaXUhss8KoBgwJHZ/WE
         gu1f0P9ppIQZ8o9x5F0Cv19nk40McCWXyKKkYikxdwob+JymV38bauTm0IpjRX8WSlps
         9M8hXLuSm+oDqnYlWpmMCbmWf1dOoXp7D1/0+plJdA7izJTcNFpR8iq3cz5GgpO4A+4I
         C+pg==
X-Forwarded-Encrypted: i=1; AFNElJ81KECX+2maj4GHEFieZ2fmRwLQzA0+elYbWkdU04xD7zyO0Pr2ioSp6ucjOQq/cJYBKSZwllM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAm58QknMYH9+1Xir4OXVCP4s0H5flQBxVWTY3gtu3CbAdN5x9
	srAQxed17z+u4xXWyKjy0CU2bUSFXx/faG0FV28xXXHtIZeGOWeMJs6I09FlykCNER0=
X-Gm-Gg: AeBDieuPU1DHNtDoHmxhtr2Sw5U2tXK4zzcv4FwWPwD1XW3OYKsmdpJtvMUrGO9ZcnB
	ufhAMncymnY7k4apTIQFeZ5ZpIv+wHtr2xw0FFuTV114b5YLRXGF4zhlSRcbqCgF8AM6upQHxqa
	8FSAWqsF/DtlEHhR6nt7hjfJuc01m6tbAvFESTtkUg8LaWwxSUxEyAzKzm42eOVjmGQ1ztzHTmT
	z2Uw6g6Ox6RUEJQnkdNBIxJRupRfkxFM/vAHDzBJQAw+aiHx+ob5mcySRECkbPcOQMf87bxTFUT
	yllUEzSzhHJSz0hwz8du5HZoJDN8YTxfUEJ8W1Z6m1y7GCfdBRD7Ni/7oW1eT1pWpR1TihIzvPj
	iBJpSq7ynPGWXwQw+XhQMZkfy2/hXasfsjDIfhKmSNCGbThomwaD3RrZMq5uww3MZDJKjCQgzbk
	JCty6sVuNtP2gzAm97Lez5dLRXmqaRQiRY+OwBXjM+latzGZttF709jtbfwJsZqO6Av5rb5QAOm
	aOsAA==
X-Received: by 2002:a05:6000:1788:b0:439:ccd7:cdb6 with SMTP id ffacd0b85a97d-43d642a4dd9mr20596625f8f.14.1776080913515;
        Mon, 13 Apr 2026 04:48:33 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm34224996f8f.27.2026.04.13.04.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:48:32 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:48:32 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <adzVUdf74CVk2DwJ@localhost.localdomain>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
 <20260407173356.873887-3-christoph.boehmwalder@linbit.com>
 <20260412125502.3f8ff576@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412125502.3f8ff576@kernel.org>

On Sun, Apr 12, 2026 at 12:55:02PM -0700, Jakub Kicinski wrote:
>On Tue,  7 Apr 2026 19:33:54 +0200 Christoph Böhmwalder wrote:
>> The new flags in the genetlink-legacy spec that are required for
>> existing consumers to keep working are:
>>
>>   "default": a literal value or C define that sets the default value
>>   for an attribute, consumed by set_defaults().
>>
>>   "required": if true, from_attrs() returns an error when this
>>   attribute is missing from the request message.
>>
>>   "nla-policy-type": can be used to override the NLA type used in
>>   policy arrays. This is needed when the semantic type differs from
>>   the wire type for backward compatibility: genl_magic maps s32 fields
>>   to NLA_U32/nla_get_u32, and existing userspace might depend on this
>>   encoding. The immediate motivation is DRBD, whose genl spec
>>   definition predates the addition of signed types in genl. However,
>>   this is a generic issue that potentially affects multiple families:
>>   for example, nftables has NFTA_HOOK_PRIORITY as s32 in the spec but
>>   NLA_U32 in the actual kernel policy.
>
>The series doesn't apply for me (neither to Linus's tree nor
>to networking trees), so I didn't experiment with this code.

It's based on for-7.1/block in Jens' tree because there are some
prerequisite commits on there that haven't made it to master yet.

If required, I can also send the net-specific patches based on another
tree, just thought it made sense to keep it all together to have the
whole context in one place.

>Are the new code gen additions purely for the kernel?

Yes. The DRBD userspace utilities re-use the kernel headers and manually
construct messages using libgenl, so we can just do the same for the
legacy family.

>Can we just commit the code they output and leave the YNL itself be?
>Every single legacy family has some weird quirks the point of YNL
>is to get rid of them, not support them all..

Fair enough, we could also do that. Though the question then becomes
whether we want to keep the YAML spec for the "drbd" family (patch 3 of
this series) in Documentation/.

I would argue it makes sense to keep it around somewhere so that the old
family is somehow documented, but obviously that yaml file won't work
with the unmodified generator.

Maybe keep it, but with a comment at the top that notes that
- this family is deprecated and "frozen",
- the spec is only for documentation purposes, and
- the spec doesn't work with the upstream parser?

Thoughts?
