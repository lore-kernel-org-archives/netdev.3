Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD2407596
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611990; cv=none; b=qMWYIJCV1iXtVg6F2pwVv48bpVv00P4Dc6WDfATy/LM8oqFeBbKHFyiI0I5KhSETkVKgDdeZIsBapWzlEpNtxov9dha3IEHc6HuSNKjR8W5rk0dIxGscQmw+WM8R8VBfUjuTpURZ2kyV5Fpyz6hF5FMm0MU3xKG3DG+bJOFav+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611990; c=relaxed/simple;
	bh=fZVaZ7TjMrKw7+i2lbImOkpXxSg4IUmytFvvhSuahqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDBYhPfYueYki452GZf1u95XgirsP4RZQcyGUf4asbM0RejFXsWsFavDboDN4LOHiR3qQ1zhf9XAOJFoOsG3W/UaGDh8OThN611nW5b/9xKvswzyTxSlkDrTvfuVpX8ZYtOR51aL8TtC8nay3NljiYd/SF90PPQFpYYHC5XP2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcGjmYme; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y25KmcrE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcGjmYme";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y25KmcrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786611987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N33LkksLPfNjIlTNbni8jbzLx2tB4hZrFzuYLnaQlE=;
	b=WcGjmYmeCpvCejdzjX7/vnYtkd2LQ47ZWrljQbzddI2Uir/CC/0KOGseER+x6l3/b3z2jz
	eTZnQLJNorfww58Rx4f4QkHpaX4re4m7EaCvy0OMZlqXWbiwD0+xkXg5eqtUvv2QxRGzFb
	FbyccHE4uiPYge3qIrVtZ857lMVJqPs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-35CEonZBNJanWHz_-Aau7A-1; Thu, 13 Aug 2026 05:06:26 -0400
X-MC-Unique: 35CEonZBNJanWHz_-Aau7A-1
X-Mimecast-MFC-AGG-ID: 35CEonZBNJanWHz_-Aau7A_1786611985
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f83450a8eso1398948f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786611985; x=1787216785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9N33LkksLPfNjIlTNbni8jbzLx2tB4hZrFzuYLnaQlE=;
        b=Y25KmcrEbPrKqaM41MtTogq9QEbFTjLISnEHcpgYhWx+5QXirB5IvxGrzXfxGNcLMM
         EaJDM8JX37dvRMT7gaqn2p5xQ2YI1Iaz0Q6T2NhTeVfJ+wXyZ0cyrghbtfkMUWYOsoTG
         epJS8LZ3RY34EwZ5G3o3XXjXGdQzM2EXI36AcNKzeQxuzg5lJSRzQS6khzWc1q/OA8vp
         9xe+0L5Nrk/bzeYRaZ+TnSec6cMDremv4yS6yBjfRr2wpJYjYyg1WEzK5ze9Y9Lf1mXK
         MPdrNXG1aPacmLzDaFZlUVaBTEO4n6xukCMuuzP8GK2b/fDF0YCZRN5YL9sAQs5d1++p
         r6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611985; x=1787216785;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9N33LkksLPfNjIlTNbni8jbzLx2tB4hZrFzuYLnaQlE=;
        b=VaPQdoBJA6O8RlZRu/CYJrEYP6QkCqeLLG53OXaFhaUSNpP5UA74IYkatqSFoph/LV
         y0rBkW90PsuOQW9ACrmuSF5SUVUEN86hLBbGBs7mOxuthEkb7ACV6qZUSW34XpvumCMO
         BT0PWO13PIMQxN3CNWPrcK9ztBDSdPNUGQCtDSpr6+niZ3OE958bci9bI8G9qRTnADLv
         M0rBoyQBo5x1YMOAaxCI0Fcx6daSJW5/H/AJ9yjhJgUrl1cd0wKBv1VHvDhtrBXS1RlI
         6WKpw8XL7jOf+EA6eoZeZRemijQrO7ysI5q/Zfsj8LnHplQaudKKDwZAeoIWOYBF1JYO
         HB6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rra9iUew7msr17uF2jm+ojmsBnaEogng7HU4LFTC+NqtcSFwujHTfqsgdnTbhRMCZQAk/mB1Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0gqgNg7zWBjIV6xvb4C07SBlw3NQ6hDciMjK8E7H1J8YRj1C
	KAxqMnkoyw4RsddD23mGrq+5jU7xb18no9ubC8Ik9boTTUHLZpx9SS8P1wAsGZBnqivJ4eJ9Hg7
	y96seFRsCvlP0pyLwLMRIXVOKJApL5o05Gzn6YiAhZOSQFuiTMSs4uSBqp5TpQUVTVA==
X-Gm-Gg: AR+sD12HYL7/AUvp9WXNP8j03H89+VRGh3wuwM1ZohheCoKKRHXZDzNxLZ+YA8/sP7a
	oJ9mt2EDqHCEv8ojvXkPzGD2tCDgzLNXJKl4R22nExk+rz5Ue9QzynBpTTluApZHrTnPEEZABba
	N/oXwlXEVW8Cf8UCWqATnuWC0No3hVW2PCq5bmfpuEvK7l+MJEvB71WLGTYjJwRiENGuwhWx7bc
	PLE2ck3Org1YRwJFm8IHWhD//kWs9H3FT1wwIvfON3f064MGEQPLWSvW3tAZx29em5ducm2yHpU
	1u6zXfx7Dz2AmmtXBntZNbQu2vLJEP8wzij61gzdQbTuv2w0bf0Jzfh73BFl4jsaZXCT/6sGgID
	4SzkvAI3DCb6H8XpKdlBUf7tO9CHZ23a+ogHl0uIvngfb2Rbkd1kI78FV+kWGeAjUP9bkkOpqQK
	U=
X-Received: by 2002:adf:e193:0:b0:474:18d9:8371 with SMTP id ffacd0b85a97d-4815a011050mr5799180f8f.28.1786611985356;
        Thu, 13 Aug 2026 02:06:25 -0700 (PDT)
X-Received: by 2002:adf:e193:0:b0:474:18d9:8371 with SMTP id ffacd0b85a97d-4815a011050mr5799073f8f.28.1786611984862;
        Thu, 13 Aug 2026 02:06:24 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5613e2sm6119566f8f.6.2026.08.13.02.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 02:06:24 -0700 (PDT)
Message-ID: <0c4e75f9-f7ce-41c9-aef9-a3b3b474c695@redhat.com>
Date: Thu, 13 Aug 2026 11:06:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a different device
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, vega@nebusec.ai,
 Victor Nogueira <victor@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>,
 Quentin Monnet <qmo@kernel.org>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, bpf@vger.kernel.org
References: <20260809094418.901607-1-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260809094418.901607-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/26 11:44 AM, Jamal Hadi Salim wrote:
> cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> bpf_prog_get_type_dev() but never verified that a device-bound (offloaded)
> program's bound netdev matches the TC netdev the classifier is being
> attached to. This let a program loaded with prog_ifindex for device A be
> attached via cls_bpf + skip_sw to device B; deleting device A then
> destroyed the program's offload state while it was still attached to
> device B, triggering a netdevsim WARN (panic with panic_on_warn=1).
> 
> Mirror the XDP attach path (net/core/dev.c) and reject the attach with
> -EINVAL when a dev-bound program's bound device does not match the
> target device.
> 
> Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for specific device")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
I understand that Jakub prefers going with this patch (with a correct
fixes tag), so waiting for such tag landing here ;)

/P

