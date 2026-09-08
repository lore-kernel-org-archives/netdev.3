Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D74EE842
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862156; cv=none; b=jqHV+ClhRpASbc2nqUcESgYsJWNPS+PhdFEGPr75phk0/VIGjpEf5jUxSnH7/rRXSzXwGTwww1xxHuxfk0whWSyx5Y58NFMSgjTCBKCd486gnuqgLaw7jgcMZpk5M2UHuJznjE/7Qc60QxSSkENFRL3PoyK/rgUJxcBsbsP7oPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862156; c=relaxed/simple;
	bh=vu8uHdj7nGJNkjCMbhAJ8R9gkQ1pgVOjKZdOrHYbGr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJTIy+RrHBPA/yiAkoF28k308QnyPljfR4OjnWO3HwPD3w1Ugr566Sy04rvHE9Juc5wOagHiqreCWRUUf88yW5+N+En1bZI4/OlWdsb90/JGPjlVIDWn/G+8xBDBDRWn1yHbS+cDLVo6TKkwbVJCfaC/AiMybWonJaPehWPlRdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkHL2Dy0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRzTo1i/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkHL2Dy0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRzTo1i/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788862152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGDU6GWxMUL0CFjsvd8LYV1oalF2ewt2sL1+YHssegc=;
	b=XkHL2Dy0q5REv3UI+gZl/6b1yncuetTmGHobLA8OtYHLYHO4XGg7YREDoGNvqR69ScTZ+2
	cn57GEMO5h9TSi+bVY+fQvuZqovp9wogTQEdCsLN1c9QL5QRrXHKB8ogn16l75Oq1q7dgp
	L4M2sUeMdCUPXpqdXeEymXPucRwHYc4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-SzD23-z9NniJLb-YSEMhkA-1; Tue, 08 Sep 2026 06:09:11 -0400
X-MC-Unique: SzD23-z9NniJLb-YSEMhkA-1
X-Mimecast-MFC-AGG-ID: SzD23-z9NniJLb-YSEMhkA_1788862150
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482e05af072so3309894f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 03:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788862150; x=1789466950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGDU6GWxMUL0CFjsvd8LYV1oalF2ewt2sL1+YHssegc=;
        b=IRzTo1i/0qhW0wWlhcmmlmPfcMHpRMboIyBaajW7vfUovtHXIRg6mK43W0OQ1B0JGL
         CzbrNttLsmxiFALd9RgwrPw+Q9F/kZO14900RCiiNFGvGavIexL63tylmNj2wCppBtGU
         XZ2EKH+W9gOJdtrpzYMu11s9U/nTX8WBa7UB1ESp6NbwFJmiV/ewW+K7I0P8NVS66S2j
         rw9hbpueYT1WO8dOClwDKJE0PwS0WHSLIlwstiWeH9spLc9Amd276k9F9fluZrstYpyk
         +fyhByUUxd7+8/5qm4LLk6ZHX6K1DVa+onI3+9gQpGoNObuhHLsILAMNLVKBKMbet+Eh
         +vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862150; x=1789466950;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TGDU6GWxMUL0CFjsvd8LYV1oalF2ewt2sL1+YHssegc=;
        b=VG3O4HpQQJBRUL6z6jSNrbF50+cYBKP+swtQN/u8KuqFBlJEtOltIwbighkJ+C9xTO
         5OvabFvR7U4kP+vBB2HH5RyGR84uWBiy4AhSzUfxOJBCwl+frzaBELouIVYi/XsNSSAN
         CZS4YxmpzeKlmDjCh/PYiiTN9p8f0qYiqgLbO4RFqjcSXWk7LXzT5OevxiaZQsbBJOuc
         kmQ39URPIyVsEJlOkOap6gu3vdwixfV0o2RcKFKDGzkGh+WIXad3Qh6aYWMH31lMP8rg
         OsK8HBh7lSqnFrAyy077hlCddnq6EJc459zG7ZLc4lZaXwjQ0Ezj3052ZrnMpunFnE3H
         DneA==
X-Forwarded-Encrypted: i=1; AKwUvBwawjaRe+nxTBZnJOCh3UCIQaaLL6sIAOdJYmdolkDTd3bX68rUgh2EtiqMtjI7RBKQL8N2W+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++n8sdTwdWLzvHKE0iJblCL8UWd6NUfJpPK50MVhcJn6+sdyAXMs
	V49zvhRbVXH0ZZRM6calZ9Qaw1vaMk6lKUdFV22kqPG30EYQjX2WX4xqp9ctzlqjTTh+66X0DNN
	0C87lh6vO6UnedQv9g9vgn4ZVL8eGt9NkPTesXCaQJP2Iby87mCGfWdt0nA==
X-Gm-Gg: AYBFou2nNK59BsoO246SYxeXb1keHjGWQEi54O/IdYLUzL1ANKP4BXy+MJTUcoFtA2V
	OjgAoJVn++eBtJLdKDnE8nfnJe8Curw4rSamy71IyuXo2lbuDwnMTPc+Pe62IU+J+WhaIy4CzDu
	184WEMlFAyweAh0xThKgdouAado/JLwHS3eTm+cVwDxfeGFXk1Y6T6xVeAz/8qFYvH1a9KH8lKO
	eimnqSy0BgN0BG9VvPoJubbnSnCXCBeB36L+b/mc3bGuYpL6E5ywNQlprlZhsK8pDm/38s+EuN2
	XvJ3iTLDcYQ+OHntFINKOgyPFqy4IDa84ub1q+0yRTkgEte2McBdhV2eGVTT8rULNNsbw2vjacS
	jF9FQBU1UN0zx8rBhNmnLmgQG3foDBH3tZYFsnAPYKY4ijsRHmbvZxOKOZK3LwhAB8pTBQRq9Tg
	==
X-Received: by 2002:a05:600c:3ba5:b0:49c:dada:f581 with SMTP id 5b1f17b1804b1-49cf7f39c8bmr339374265e9.0.1788862150162;
        Tue, 08 Sep 2026 03:09:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba5:b0:49c:dada:f581 with SMTP id 5b1f17b1804b1-49cf7f39c8bmr339373475e9.0.1788862149680;
        Tue, 08 Sep 2026 03:09:09 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm328883195e9.14.2026.09.08.03.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 03:09:08 -0700 (PDT)
Message-ID: <923eefe9-141a-47b7-94c5-c91df94e66f6@redhat.com>
Date: Tue, 8 Sep 2026 12:09:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/12] gve: AdminQ mode related refactors
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 jordanrhee@google.com, willemb@google.com, nktgrg@google.com,
 maolson@google.com, thostet@google.com, jacob.e.keller@intel.com,
 debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, przemyslaw.kitszel@intel.com
References: <20260903215606.31633-1-hramamurthy@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260903215606.31633-1-hramamurthy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 11:55 PM, Harshitha Ramamurthy wrote:
> This series is preparing the driver for the addition of a new control
> plane mode(MailboxQ) by commonizing and reusing as much code as possible.
> MailboxQ is a new control plane infrastructure which uses mailbox queues.
> This is a new control plane to communicate with the device when the driver
> is running on bare-metal instances as well as newer versions of the device.
> 
> This series contains 2 main changes to the gve driver's existing control
> plane(AdminQ):
> 1) refactor some initialization/teardown path methods to make it work for
>    both control planes.
> 2) add gve_ctrl_ops structure to the driver for various control plane
>    operations
> 
> The refactors are mainly around the init, reset and recover paths so that
> functionalities could be moved into the control ops like 'set_num_queues',
> 'set_num_ntfy_blks' etc.
> 
> This patch series only sets the control ops for AdminQ mode. This is
> intended as a preparation for adding MailboxQ mode in upcoming series
> which will add the new control plane infrastructure and then introduce
> the corresponding control ops for MailboxQ mode.
> 
> The entire list of future patches can be found here for reference:
> https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/
Imho the 'medium' severity issues raised by clashiko on patches 1 should
be addressed in this same series.

Please note that you are supposed to act on sashiko reviews, see commit
c82ff94592fb68f529afe63ca7f5ddb7dae4ba83. Lacking such feedback, I'll
tend to err on the safe side - i.e. requesting a new revision.

/P

