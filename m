Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF43E5EEC
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652201; cv=none; b=bArIBDlGoe9O9/y5EY+L8BIOT7zt9VqQNd8pf97+2jI0sgL07KIH+f9qfmi/WKOYykuTGXH4uGz9+fIJ65GVQxXy+7gJJZnYNru9b8TEzeAmCkols/bFm4OWI6cRv8mjR/oodkm/qIo3R7v2W0QWEfEb3vP6N2/v24bfcMXNbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652201; c=relaxed/simple;
	bh=uhN4fxJ15enqo3k8CkDLZlRghvRaPv3HpnOP6VDNWkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQlblRmNgGJfrPKZV26HMzNYH9qaRpWJYBaEIdIkFsCzreZtq5Q28qqRNrcctJfZ6g+ksm3SB+/cHMkx3aGXFyQ3gywaFPcyDQuoKBMb7j2/q3cXjYbj8sDXy2l8DQFu/9EVxrKJ74urRpiAOLRpTzBw4TuJj5Segk5BSrI++w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CA4Tm3Lf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL0L4TEw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CA4Tm3Lf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL0L4TEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787652199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUhW54Gf8EXfhXYKN6isHtSeMLz3jtca0/EX8wxX+Ac=;
	b=CA4Tm3LfWYsZQNxcboRGXrkD0uYIs9045/KQPdFeXxWexH+7ClPuuq2S7xM/Xsxdc7KYrB
	Yndp57oyQlhU98GPJX1byJt6iLd3LcMsh9tWo/ze1otwZ2gJAA+krD40qC/mnOk/mPy85O
	ZFk8HW0bwl49cesBuw/H0ASxhAnK1xA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-Upki5GtYM_uY9lPBwI9GkQ-1; Tue, 25 Aug 2026 06:03:17 -0400
X-MC-Unique: Upki5GtYM_uY9lPBwI9GkQ-1
X-Mimecast-MFC-AGG-ID: Upki5GtYM_uY9lPBwI9GkQ_1787652196
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c24ae1a510cso356055166b.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787652196; x=1788256996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NUhW54Gf8EXfhXYKN6isHtSeMLz3jtca0/EX8wxX+Ac=;
        b=FL0L4TEwZPqy4XIQGN+cT+RT6R1kvMehXCRUH+tSyz0+a+iJHy6HGK7Bl+0aemusqQ
         U+HXqyuQ961m79bJu4KxkODXKz3Qu6FVQWU3H7zeuMyjBW5vYoCBjgXkazHiL2eP/ZNB
         zhVn7+PA0q4aqrQ6wskhgzGRsFXUA1Ds2jPR8MU+AJ4q+b+iTHw7Tz0Ly7Wq2Zixhf/s
         2yrsztm/IBKuGydIMie/mWwta0YhyLMh+l+qrd7PRKuUKDuoPe7+LIlzvXnVLyD+VGaF
         SUb7OjfyTBInEgYChYh4a0ORvBFFniX5K0p48+fj9JDyY/08TOKSpngw7ir7pWRM4RBC
         xMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652196; x=1788256996;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NUhW54Gf8EXfhXYKN6isHtSeMLz3jtca0/EX8wxX+Ac=;
        b=GGM6mmhQA8NIWqOAlzp+eg4Kk6zGKM+CZRQ3XuIMSuVDMIQ/8GT3w4FbGkYFgnCrEB
         9LmIGEeDvIHbW6FUBnS9cAHDvgCTbLv0H4f7S4nnqGy8OYghuoXKzBjb1U8E8F/Uw2OV
         K8CFrg6So83PulkhSglWWfgPeZ7qTXDIHmObNZYdF/cjR/um72HK43vzDiUEtTp6XHb5
         l48PiGgWqJBxrAtGAzAG6AUsT3AM/o6nfkEcen/t7yCWVwBcpEZK5eFSHijXieoZgWpg
         +qDNq0plI2sHsnpoIvtvps8fD+HZmflSA5TqoSqCiLRqsaK34mgLuS6mc7MiVwpO2oqn
         /e9A==
X-Forwarded-Encrypted: i=1; AHgh+RrrlniwIPm9VgUGi65mFqrXdCK/RjoRx6Q0NBp2KkX8azjyemoQd1o6qNccrYvl2ALk3qDHOYc=@vger.kernel.org
X-Gm-Message-State: AFuF++nrrfaXUNm0qGglwgM6eHXoZf7q06iYftyiGPMndMxAnKQoQDfW
	xk03xnrf3qQLQdbp1lmHfIenHIvWxNSF/NOUh/c9/axPy8bLdYMTJJrkez88ka1C16kJRXQY3I6
	VXlyquHuSP2iN+5AngLGyWUwxT08NLVFzIEGKZhOdSPJKGNtmNkQtFkaZyg==
X-Gm-Gg: AR+sD13RnUpUYLcGv4e4HkC6Tw8duwepD3Gq37OqRg7UEnoI9adW7mCEyEmw/mle99y
	xW4b5Dzr2gUX97KghuuhvdozbFWcYvse1d2GHlgdy/KTwSWHCdaFu2utv5KGOQk8SRH/komsvwY
	JZx92/UqiVkym9SsfFhSJTtU80rLvyDbPhVkX2uPwpAwCLmbJNmLjKfCbUx7w70GESTLem7L2q6
	1E0G0F9OoxcEyiLo9v5/F6wQ4x6Pv0o/8vs3fAiwf1BHn9hRvm7tZF8/ajsacxerXALvUe0PRsp
	DUG772ulIqQqz/KKxjGtLbHI2vEobCffM1oRz+h6h+KoeXE5cn/6byBxbptAWJ4u3Ijb4g2Vq5Y
	GWT9Ye4llRMNEhvonE3CSo4lYbQf8IzbHg1gKD0VWq3mqS+dS1m2NGv13mUhH30cD9akZPocL
X-Received: by 2002:a17:907:a089:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c24924b8000mr2757839266b.6.1787652195917;
        Tue, 25 Aug 2026 03:03:15 -0700 (PDT)
X-Received: by 2002:a17:907:a089:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c24924b8000mr2757831066b.6.1787652195293;
        Tue, 25 Aug 2026 03:03:15 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b683sm1843812966b.5.2026.08.25.03.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:03:13 -0700 (PDT)
Message-ID: <478bf88c-cb76-416d-831a-5fa7856d65ce@redhat.com>
Date: Tue, 25 Aug 2026 12:03:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: remove unreachable dead code in
 mana_bpf()
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
 <aoxThygUBWq0WqfS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <aoxThygUBWq0WqfS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 4:21 PM, Hamza Mahfooz wrote:
> On Mon, Aug 24, 2026 at 12:39:06PM +0530, Muhammad Falak R Wani wrote:
>> mana_bpf() declares an uninitialized 'ret' and falls through to a
>> trailing 'return ret;' after a switch statement whose every case
>> (XDP_SETUP_PROG and default) already returns unconditionally. This
>> statement is therefore unreachable dead code left over from an
>> earlier refactor, and it would return an uninitialized value if it
>> were ever reached.
>>
>> Drop the unused variable and the unreachable return.
>>
>> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
> 
> Fixes: ed5356b53f07 ("net: mana: Add XDP support")
> Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Please note that the current guidance is no fixes tag for net-next changes.

Also this specific change does not address any real issue, it's just
code cleanup.

/P

