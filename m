Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660398;
	b=OSdyxBgxDT6T5HKxXxVRozdbx2u57DTHqVeD2CpjFCdU/1sVzG57+N+KgxhIC7opgPfR
	 7r/skxMNCI1GH1BlhbypFy/fld50prIR2v0pagqTO6jvTroAy9kbrWX68/JbEAkS1E9Zo
	 hrQkJlgjtpQy0bNJUFpCmeDlnSYVZss7nVVsRGM7pY8DF5TGpJV0QknafOGk9ePGuDGmm
	 CefBVhehwdaTG7Dsd6Sd42c380iu5CmyOg7Z5enNOdDV7fkHtMrbPHlLt9U2Ch2Q1aiP9
	 gj0M0QcSTMmeLYpXxreyKwIAJGyinhQcWXseNFpAy+VOYwdz3B2FcLva80w00YpRFKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660398;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KD0Mk8IG/3dFOFAhD+Ckq2+dMBysvVTIIo6/IjFXKDY=;
	b=hJMeh7iBIsin/57WVCO3qzCJdguz8GxrNjnkcZElgQhzZeiOZIAgEPV7z7yFLIQEPumn
	 RuW7DM1b9Gd5iQKvcDzM9wgJURmqY5J/K0UKiUmvgo0K4MjrfdogOPmH/bbYPSL1at+os
	 9YqMQLlhCMTdWU6Gys8ZwjW+ToS5K/8j+GkYd8um2X6y73A11adEjR7ygYev9wJttbgb7
	 iOeuUOxVpG4wdD9K1YTkHToQOiOYIxf+wHc2rFM+W3ByU8BQV7CgC0eddcGX6cy4zGZp7
	 px4RJA1KX+0/txZa3kmLpCMIpm7sce7o3n95zWKdLXI/1yFyoYBjgeRIzyBu/t4m40w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="PqXWks/j";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=s+a89Fs2;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3E606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81C3E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PqXWks/j;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=s+a89Fs2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792660396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KD0Mk8IG/3dFOFAhD+Ckq2+dMBysvVTIIo6/IjFXKDY=;
	b=PqXWks/jNZPdA3f3Tt3BZ3QgUtRu18mgpXEKiN3UNy7uS/tcdO6Y7mJ8t1zCxCcB1Bc12U
	78GnBu52goXDdZvq1kfsKIjCjmOahuwGjsgA4BFzMzCUk/NeCgPCn/FHiO2hkb8RPNg2fX
	rHn2coNvc2+hREcs2rjtUYNqpeWc+zo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-74dlVlXuP1eKIiqodBww4g-1; Thu, 22 Oct 2026 09:13:15 +0000
X-MC-Unique: 74dlVlXuP1eKIiqodBww4g-1
X-Mimecast-MFC-AGG-ID: 74dlVlXuP1eKIiqodBww4g_1792660394
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af4046a3bso1561722f8f.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792660394; x=1793265194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KD0Mk8IG/3dFOFAhD+Ckq2+dMBysvVTIIo6/IjFXKDY=;
        b=s+a89Fs2sAI+DM1tAxTcOEyWhzs9Gp86OktyAbiMwhKjc2y6JfBxMwHenNjRj4g/fW
         47vXpnWxeF43Gyj/1N5L/Qgrq66uL79psePeERo/vtoL6ZyYf3DCr29BhRWLekB4uHR4
         JIwjEm4ddoPDCHNlgD+v7Ztt2V7MOfmPxfBaiF7PRnaLkmvPMO4CKliR8BCq5AnoRtta
         0EtvV7XqIqmYALywf2ZK6GtPMMj1DMuIYKU+HPJIwImbrLhjHbSX2mkJeV/hqftsyWZ6
         rwWhoc8MpcEPLFcA13KPQPoTFWjNZYYDFGG1ucvGleHRufE2LpfwFoWdbObrNIFMohwV
         hTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660394; x=1793265194;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KD0Mk8IG/3dFOFAhD+Ckq2+dMBysvVTIIo6/IjFXKDY=;
        b=GgxFOu8+woqhFnusBBBqFWpHYrObrwsdEZLHdiLrSGgIqxkcw2EVrUgdjh6edwDh+d
         1W0Q/8hLTReb3HTvGUn1oF2a0nj53mMbVYngGnslCrFMuY4zHa57xGzD+LjDaHeMypn8
         0h0tE7Yel8cUP5p8GitFYsIhuQc02d/2S3/eAF5lUDd88y94w5CfXAL7M9458DA6nt1r
         cH1sNBzAHXJ2/w7nixSKSU+ExU2nV5/h4eJxDgNx46WgGVud8Wi+39QwdraLWKvDgit1
         gFwwThKJN+fJDLIg13t/yPmZrsjRReilZhcwPDTuTrKvJwmUr6Mqqtri46IOTYLCtp2x
         S37A==
X-Gm-Message-State: AFq9FYJFAhNcm8DKKaFfpq/0J2i6nGzwWgdsDzBBH4E2Q0elIfnMhHCI
	kVBWb0UC4ZYmC4ADw9NcgT4tnMKeutSIP2+B6NmlS/FfVF3AiJ2dW0g6alBkAlwpnFkY7uv6q/I
	ciXd2y4CwUrLdKddZJBXKvubZ8FMe5OLgscDyuQJmSOQV9yhn8ry/mtVNRw==
X-Gm-Gg: AYBFou10fy9zzcvuK0nkQM2L2tzHlrqvTkwA3ea8xhIO6vFZDzrL6yqKpCyLX8ucbZ8
	+nUp1DdXTOMNtbIBZIxKWsKe8d8MzLU3zFGxY2yFx9QpDvS+9IHLjs5cZCRsq9b3yK0DG09xdOX
	CXge7N1pNg14amWsmO0pn9gNxcnrZlQe62oDkX/EzZrGwwkGNliomqa3IizsI7zNN0SF8E79gSI
	xqxLbXMBr5zrxFulRo72PNBhpe++D/23NSDT065TNjWHUfdq/zzhde9JBM7MSjVfF3FZN9I8lus
	RfYKg9kE+EzDRI55B1+670O6TuURIumULSnVNyuglyU5rkAblj8+ii1ofOGT70+TT2mIKNUMe9d
	40/4KOA8w/lGLpqtogXXOjmw8i2FRe4UVocjb69j11JbHf4SqRf2gaFeimmnICZWaNNkZv0iwkA
	==
X-Received: by 2002:adf:e00b:0:10b0:48d:ff06:c626 with SMTP id ffacd0b85a97d-48e264c8146mr6814209f8f.35.1792660393969;
        Thu, 22 Oct 2026 02:13:13 -0700 (PDT)
X-Received: by 2002:adf:e00b:0:10b0:48d:ff06:c626 with SMTP id ffacd0b85a97d-48e264c8146mr6814173f8f.35.1792660393544;
        Thu, 22 Oct 2026 02:13:13 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835f46sm11063245f8f.38.2026.10.22.02.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 02:13:13 -0700 (PDT)
Message-ID: <54d3c327-ed58-4f06-9877-b5998ed8b92c@redhat.com>
Date: Thu, 22 Oct 2026 11:13:11 +0200
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
Subject: Re: [PATCH net v4 3/5] ptp: vclock: propagate physical clock sampling
 errors
To: netdev-bot+sashiko@kernel.org, james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, yangbo.lu@nxp.com, mlichvar@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
 vadim.fedorenko@linux.dev
References: <20261015-ptp-vclock-sampling-v4-3-cba6ffc8ceb6@gmail.com>
 <179245576913.3135.17393378308394380121@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179245576913.3135.17393378308394380121@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/26 02:22, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] ptp_vclock_refresh() (drivers/ptp/ptp_vclock.c) now returns
>    the fixed PTP_VCLOCK_RETRY_INTERVAL (msecs_to_jiffies(10)) whenever…
> 
Both the issue and the suggested fix look legit.

/P

