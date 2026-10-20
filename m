Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502416;
	b=Ut9RYsmbWXj61jei+VnYxLXlqp1fnxgnWR8pb5ue0JyWpDn4GaUdiyzJoxu8ySOPCMNu
	 2qwjS4G7eM1AEaU5hhiDA/Q3kzEXw1Vya/DwWe1Q+XUU5dRyxxwIpeMvqSUpTXm3tNPNB
	 sVBlf0x335T4/zmT9ZYTYELefbn3CgppJohLVlocmRUeIlWB2KGuFKInRWigPKEDD1xNp
	 g34lpdEw1n8R7OMKDL6luHrUSK36REg9WkJ08rDZLczLVBR67yDWeYMPsGiukR5dnC3K9
	 bfKgBxjBMi6Rsij9zqf0NkQKVzxokQrR3o+W13SqBp4wH/MXRALqCZXRuHSEcFqy1oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502416;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YGlVowyICXxSY3GmL0FDAbeqb2mzJ8MTPMKSU9lgtjA=;
	b=V6HgOLC6SfrPN40+UZgNHLVOElQdmVUrhsTWnp08IGs1w9SL/9+OeJvI0wfRZyJXRpaE
	 uxbBMQKpFoXFO5VsXNf/Vwbu7QnW/9jtXb4DrTXHAH0OYP8WAA7txt1eubsyWVnWjQkYL
	 IRZySxpW/lqOMjphKEP4uh0+H4c8jxueAknJ3+mz7YBqAikAEC3F8UTYykuHIgR4XrRLp
	 MxWotlEbocwm+U3trLmLMEH4HtiUAtQs/+Pn6tD4HRDfbGIItzJE7ErA0TMsG4zq+OpPJ
	 hJ2t05dxrnkdaVczuRhKMvnAic0b3cq3Ng4YunXogE83HViSzGp4a2AWcJG++0MUZEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gi7r4+qI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CJ59cd+V;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE3606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CBE3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gi7r4+qI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CJ59cd+V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792502415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGlVowyICXxSY3GmL0FDAbeqb2mzJ8MTPMKSU9lgtjA=;
	b=Gi7r4+qIZhoJJ54YhWU83/CMU1o4l285H/FydKpDlbqYrRkASW7nMY06Ncm3VZBZk2BlNU
	yGz/Ak9Mc2Ep0rjuc1wXLNZ1l7gkvoiTCEcVMg2x9sA2+KDNwOzC3SCpSf2jPf3uMTRkSr
	VVQHq2kFPyb1LkRB9xu6BcyxTaekgE8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-HFdudIUXPeW9hR1NSRz8rw-1; Tue, 20 Oct 2026 13:20:13 +0000
X-MC-Unique: HFdudIUXPeW9hR1NSRz8rw-1
X-Mimecast-MFC-AGG-ID: HFdudIUXPeW9hR1NSRz8rw_1792502413
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e17d30a79so1425071f8f.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792502412; x=1793107212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGlVowyICXxSY3GmL0FDAbeqb2mzJ8MTPMKSU9lgtjA=;
        b=CJ59cd+VPlwbLqW47CS7Kg/f5tTePdzmc2WgiXqrAxZ9j0Mi99G0huvrLpHleSdNMT
         6PZ7ZBfath98WdoYumYNuCAbWi9bhZnDdjcHBU5y+iMOf9KMa1tjB9Vmj6BF9NdrcW1w
         Lda2tyqpjuzhFSwR5N7h6TxzQG3QeOwnA6P7Ju85b8GtKuEvjVKCH7xWDe/Rpw90kYZg
         yIyGNk4rFww8NjBVPj1Vq4PcscattABHYM0Hp2/zhGJotRewZXJDlTAB3aEBBNdo7gPR
         lsmaXT999SBjtBmFJdjiJ7CkEQPT/Zvez3kTxdmN/dC+Rbgro0cmm6Iy7girIyhfaglW
         yecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502412; x=1793107212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGlVowyICXxSY3GmL0FDAbeqb2mzJ8MTPMKSU9lgtjA=;
        b=JPIXBKPBZ2pkpdZY2pQR5eFmdGBH8hSwPs77Ka3ZhPx5NK41VG+l87d5O3uVtoBfLU
         j/n+IrsJxxLYqzk8M7yzoIM+yTCOkUx/BN5N8bzk8pQTvPbfm+wXNjCQOd1A4jMI8b0S
         xJt+dE/WJSzdHj7Qtc+rNzD3W8ZPS9UXfzLF/nZkokCS6oN570I8eQ+2MfEdNgeOzr3X
         Dce5Mhe9pd+yogOUo88/5l1GHAfjKcGF6qTA/ez1arrTfUSjscy1N89X5K8EKv9dFvl9
         pJ7es4282rx/C6UFolGpLL8YQSZ90A3CANhtDRNtnWjjv9bI8z4qFTlULxbj9cFMgW1W
         4rfg==
X-Forwarded-Encrypted: i=1; AKwUvBwEl3w7jwLeNzEztcdFUxe65Cf5FTBtH+lgCgZCfyaYEmkk+VjkWLtzs5RrHHONOCSZSqxdtxQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6ciJPkS9IzfCa4qJZz1401RlRPG6OCc1gQ/3TJ6+BpTglRoSY
	YT1kmX/bG97GGzzOseV6dv8TPCVTi9s/8z8KSiwrr/9+eSnIAkgu/0kX3SygDAO1pE3dpg464G9
	cwFu4/+YfeEMCefTwTxzpthSP03vYpu/Wt8jL13TeffDDARCgSx0bqXTDuQ==
X-Gm-Gg: AYBFou0i1SkuDuyajzDsGVABAFiEx0uoad/S3XmgU1ANcqfSBvUiOlVClvvcOzHs0oB
	faaBQhfiUJh/BiptgNpwB/FGFe1ZgD1NjEjWaiImewXKukBcJ4kPGUQV1rMHyWaDv92xMlwnhX6
	8JvWdLlRRn2naLXAhla+weS+1qB1WaJ/bt0y7QUEdepiCSkjZnWOFrW0UK54ElwkrQ0rlle6hO+
	y4Fn0ASPslBHv5eWuVMyqrdWw8ZfzvvbzoQhBfI396R/CVpoR6jb6OXgkitETlSJzfcPA8xCEO9
	0VxTxa/2mbOOmWOsmlvz+yjatn77EpvdCi56I8IeyRr5PpCUr7Ml57KliNZ77KKEkaIptflL576
	GMNXTTNt23FK0Fd669uFjYh6ySXxB65GMO5DPdH+Wi0Ha2CGSe+Pul1OjQxKBGt/4j0IuQnSh6g
	==
X-Received: by 2002:a05:6000:2583:b0:48d:ee31:a07b with SMTP id ffacd0b85a97d-48e07f9adebmr25137924f8f.42.1792502412463;
        Tue, 20 Oct 2026 06:20:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2583:b0:48d:ee31:a07b with SMTP id ffacd0b85a97d-48e07f9adebmr25137177f8f.42.1792502406697;
        Tue, 20 Oct 2026 06:20:06 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8244e1sm5905840f8f.44.2026.10.20.06.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 06:20:05 -0700 (PDT)
Message-ID: <5a195aa8-eb68-400b-95ad-e51e0ac95545@redhat.com>
Date: Tue, 20 Oct 2026 15:20:04 +0200
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
Subject: Re: [PATCH net] net/mlx5e: Fix NULL deref in PTP TX timestamp
 recovery warn
To: Carolina Jubran <cjubran@nvidia.com>, netdev-bot+sinfo@kernel.org,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Alex Lazar <alazar@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Kees Cook <kees@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
References: <20261015080218.1102172-1-tariqt@nvidia.com>
 <179205178078.408196.12399315538524843906@kernel.org>
 <842aba00-2293-4fd8-bc17-dc109b16da56@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <842aba00-2293-4fd8-bc17-dc109b16da56@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/26 11:37, Carolina Jubran wrote:
> On 15/10/2026 11:09, netdev-bot+sinfo@kernel.org wrote:
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>   - How the issue was discovered, e.g. hit in production, hit during
>>     development, syzbot report, manual code inspection, LLM or static
>>     analysis tool scan.
>>
>>   - Whether the issue was actually triggered, or is only theoretical
>>     (e.g. found by code inspection). If it was triggered please include
>>     the symptoms, like the stack trace or error messages.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.
>>
>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
> 
> 
> Hi,
> 
> The issue was observed during our internal regression testing.
> 
> The kernel reported:
> 
> BUG: unable to handle page fault for address: 0000000000002ea8
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 1a9bfc067 P4D 1a9bfc067 PUD 1a9bfd067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           OE
> RIP: 0010:mlx5e_skb_cb_hwtstamp_handler+0x10c/0x140 [mlx5_core]
> RAX: 0000000000000000
> CR2: 0000000000002ea8
> Call Trace:
>    mlx5e_ptp_poll_ts_cq+0x228/0x5b0 [mlx5_core]
>    mlx5e_ptp_napi_poll+0xad/0x380 [mlx5_core]
>    ? mlx5e_napi_poll+0x750/0x7e0 [mlx5_core]
>    __napi_poll+0x30/0x200
>    net_rx_action+0x181/0x2e0
>    handle_softirqs+0xdb/0x340
>    __irq_exit_rcu+0xd9/0x100
>    irq_exit_rcu+0xe/0x20
>    common_interrupt+0xa4/0xb0
> 
> So far, the issue has only been observed during our regression testing,
> and I am still working on reproducing it reliably.
For future patches please include such kind of info (specifically: the
backtrace) in the commit message itself.

Thanks,

Paolo

