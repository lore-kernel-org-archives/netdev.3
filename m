Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655A2F8EAC
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839221; cv=none; b=faTitomOGlWRbJlJCtefW5gnMGoRgHq85q6jB48Qqc9BJkQCPjBBrJsPyvGqqDr9DihgxfP4N/DGt2SpDAUEl12L1vDqHLqK1HScGYRRG7drreH5V+0B9DcKFIC0JaxTOasKQx7kj0k0JoJoPqy4L7F+mgaK+RD3/+p6PXwvsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839221; c=relaxed/simple;
	bh=aBGBLgCGB587vF8g3mIqqyaoW8zhA4PEgPUvJHHmO4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPWNqMo0grwzS6WLNE0sAaMRP9d1azcYC5RM7drQ3tCNh606Hansv8i5mPn2mfRSlbTNXHXpxHDwVg9oqgQWaCmsdAWZUhcVYsnYeN0FrSmRz/NHH2vOSZm+Gdwpk5PGClrgsXrGp0aO+qLIxI84v9GFiM9LPKrPKUtmRGXOrIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9zO25i2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHa7rKIt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9zO25i2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHa7rKIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785839218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSlcnJs6QXfidthLOj9LPRJMkDf7swhe2TuIsQUNGJ4=;
	b=d9zO25i2uWcJlIk2NbkFghSgIMPkuovRYuw4PZkWm/qKMjpxwC0CWDbvsw04lmqloJx7G0
	1r083+0I2UB4t+Z8sEW7dVEK3N7btzQ31Bo6JFZc1cFlNZm9whUUj7vWGKexd6fVyBXW5T
	A8jwMK60Xg3aOnHV/TPsljMIljMVsYI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-YNFp9VHtNzaQhB0GGwUXpA-1; Tue, 04 Aug 2026 06:26:57 -0400
X-MC-Unique: YNFp9VHtNzaQhB0GGwUXpA-1
X-Mimecast-MFC-AGG-ID: YNFp9VHtNzaQhB0GGwUXpA_1785839216
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso22804255e9.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785839216; x=1786444016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zSlcnJs6QXfidthLOj9LPRJMkDf7swhe2TuIsQUNGJ4=;
        b=eHa7rKIt94fg/oFxIDtFTtXDMaHbXqtCuaroWpDGK4Ze3fTVVND/VOIqbRI7swvA4k
         xQUeOXqZl9uvCxYqdpMcpAGt1k5SnG02EMwNOcTiAlOIajVHcsOcKifKioWpUlwoa3IA
         qm0l3c5SDiNmotGhaKVA14r1NInT/4Ct7p9ZWITEmk4fXel0+sngkjUX/tKtNovit5A7
         viPv/D1PQA//K7Yl3lbmetH/WT3PprQ5pBE/rnPg4hh0qrEm8ohDjfJdQ1L18ucjwSQ+
         5sXrXQCh0mjKMbhymETczhuIi57LQ2414y2W0wXc2rsYZwF6ZiraMic9CBJqVO0BU76P
         /J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785839216; x=1786444016;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zSlcnJs6QXfidthLOj9LPRJMkDf7swhe2TuIsQUNGJ4=;
        b=kKhZXzhAKPAyQM2jM6R/sBhAFxfuus+kyoCnqqkQhoCMc/nSWQdKIvODf/pq64c+DX
         4gQeG3c/4wyvQimC3OteyRPLHvuOvWGD2sgN/TieBRMhWgQan+VpgS58qqjwxndDyNlp
         aL1ceF454cwTes5gXka7U9Jo27mmHxFLklDjK/uc1soxDZod8RkvObFnA7HxDyfgps3d
         ifHJmBiJHcP/Fzi2TezDhM5kXWcfMjuCd5obXT7oy1q1cPb+BGKJIZSmPtY/gwFGWesV
         WOX0v5gSRKsq01VSHmDpOXO8Hj0AkNxCFO+QcyauB0a3nrpx/38GV2ONJrQDGWggIW/o
         OJAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rre7Je6rLhO93KrHw6tbY5mCqetf6Jbgyqwama3VD3mFFGVByVBf4RUeverUp6/4dOcIOyQWH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXoEYbNYUV3H13EQ5LHY5KucjyKZwmkab2cefRoluNrQBIMyg
	7asFPqIlTMseYnlqmKFRZ4zJyaN++P+gh/BTSW08t5M9klTrUzAmAXszu6uok2N+dxPAEWnoBO1
	xrvoESmGrKvcFllpI1srZVlDHA+OWdyh9nWdK8Ea4yxlA6h+WvY7t7Bf3aA==
X-Gm-Gg: AR+sD11PFFrVxI7A06S167qZGnavckpRpx3T4KbISqqD84s33Pe1tPqMvbYhA5Qv8cK
	l9uFBErLJPkyfO2njLp42EPNanNSBPuUofygOJGbNYnHYHYXlLO9CHbZbWc+ynTlgn92fClHeYy
	8fO6J5t2QlmzRmKGnlofOZjEFAVa8yzyb9sXt6bOo7Nc0NUc+kILHqqzZJqTeTjyfT5yKqhUS3z
	iFNaebgsF2zU4oZqT2llhGaMwQN44Eqz9nFijbFwfBLyM8m1NLLFrvSB2GG4PUGZeFP5VK6Wqlu
	6TEn7CfdU35s1XLSC4VfO5jTgNDDq2vVlDFaAvTgHjuMCMij9uZq6SfYZomSkqCMyFGDg+urJe8
	7v9xxJl6sLYHI04//CanfgSWp8QoxwuSB+ytuGKkaaiJy5zkD9NwW0yrHWm7tfOnfhbDmsurWE0
	E=
X-Received: by 2002:a05:600c:c3c1:10b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-4980c672b1cmr252467225e9.10.1785839216013;
        Tue, 04 Aug 2026 03:26:56 -0700 (PDT)
X-Received: by 2002:a05:600c:c3c1:10b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-4980c672b1cmr252466305e9.10.1785839215559;
        Tue, 04 Aug 2026 03:26:55 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc6f16sm135548865e9.2.2026.08.04.03.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 03:26:55 -0700 (PDT)
Message-ID: <917affb8-f750-4e11-aade-e4ebf13e96ce@redhat.com>
Date: Tue, 4 Aug 2026 12:26:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pds_core: fix cmd_regs access racing BAR unmap on
 reset
To: "Nikhil P. Rao" <nikhil.rao@amd.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, brett.creeley@amd.com, eric.joyner@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com
References: <20260729055258.1416225-1-nikhil.rao@amd.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260729055258.1416225-1-nikhil.rao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 7:52 AM, Nikhil P. Rao wrote:
> pdsc_reset_prepare() and pdsc_reset_done()'s pdsc_map_bars() error path
> clear/iounmap cmd_regs without devcmd_lock, and pdsc_firmware_update()'s
> download loop derefs cmd_regs after dropping and retaking the lock
> without re-checking. An FLR concurrent with a devlink flash can unmap
> cmd_regs under an in-flight devcmd, causing a NULL deref or a write to
> unmapped MMIO.
> 
> Take devcmd_lock across the BAR unmap/remap. Only the PF maps cmd_regs
> and runs devcmd, so guard the locking to the PF.
> 
> pdsc_unmap_bars() also clears info_regs, which has its own readers under
> config_lock (and a lockless debugfs reader); that teardown race is
> pre-existing and handled separately.
> 
> Fixes: e96094c1d11c ("pds_core: Clear BARs on reset")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260708212222.296202-1-nikhil.rao%40amd.com?part=3
> Assisted-by: Claude:claude-opus-4.8
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> ---
>  drivers/net/ethernet/amd/pds_core/fw.c   |  6 ++++++
>  drivers/net/ethernet/amd/pds_core/main.c | 10 +++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
> index fa626719e68d..cd7616ed9ef3 100644
> --- a/drivers/net/ethernet/amd/pds_core/fw.c
> +++ b/drivers/net/ethernet/amd/pds_core/fw.c
> @@ -134,6 +134,12 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
>  
>  		copy_sz = min_t(unsigned int, buf_sz, fw->size - offset);
>  		mutex_lock(&pdsc->devcmd_lock);
> +		if (!pdsc->cmd_regs) {

Sashiko notes this is still racy:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260729055258.1416225-1-nikhil.rao%40amd.com

The issue is marked as a pre-existing one, but IMHO is so strictly
related that deserve fixing in the same change.

/P

