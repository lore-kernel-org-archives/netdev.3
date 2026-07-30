Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D73E7625
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405350; cv=none; b=REx2aAg/rJQkKBZllZa0M1XcSJMbmQcIpV6Om4O6wpto92UWyTAG9xEAQogT1hZ2JutN/HZIxBgWP0XWRUoTyZQpzeXEH6FjXpAt9PrYaatDH+efn7POw3thhvJ/Epfo0taIIEaUxASxxLO+n8hta6sJys7NKawfb2k6F/UfP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405350; c=relaxed/simple;
	bh=B3SEkQ/hEbP5sv+W3Wk37AU3WK2ejG3sDo4XZLp4wFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WROX0ADJx2v4ekJctFVkXtZn+fVC3pQX0wm3NMkbdVqjH0goGeMgZobAtvVuk28IkWjgQUmc1t0QfcycqeEi1m+IzjNDVgsFvX6aOxu1s/wSJm7yw2BAqWbU1zKfFV4xJWFrPFqi5JR1ME6Zgio7h8fsnLnh6a9DvpPGVGlmcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7Wkbo6K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxxO12eZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7Wkbo6K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxxO12eZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785405347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Lz8IBXystSHPMs3Dd2XtqjCRsgWgqnaNeE680bLV7o=;
	b=I7Wkbo6KfUswNWQf9bZcmKRAWfhvqgLpEjaw24yHC1W2dZFUtheRUHYwKZNKd1cvjq0ibB
	K4wIN7xay2jBkY/H1OajB1VS6+gJWuGhgFZ3K4PjdcBcKmBRIwa6jlYe6IXOUKmmnCyGQm
	JR1xVpOTX1X9TranUkfYIF/QBOFzUGU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-H1uIL23LMJaJZKym_YkyBg-1; Thu, 30 Jul 2026 05:55:43 -0400
X-MC-Unique: H1uIL23LMJaJZKym_YkyBg-1
X-Mimecast-MFC-AGG-ID: H1uIL23LMJaJZKym_YkyBg_1785405343
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49545071724so21191755e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785405342; x=1786010142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Lz8IBXystSHPMs3Dd2XtqjCRsgWgqnaNeE680bLV7o=;
        b=HxxO12eZ0OpTyA6R2c6e8bK/fWbFfLhVgrrcUzif0tqtPEkAQjbXYCrCHKL6VQY07x
         z3nwnSSSIoF7tHE4ePm563RZpqeHiv2CCs0YN5sAvEyuKdt0x07eSCnXW7Mok3h52Tcx
         npxVhru08PR9A70VvLQmL+th8dtlMQFg1eyCm1h7Cx3myLwpA5e4lAsVWYBPVi4NcflE
         gd0x2VATBjM/PjGXWt3upemwWigWLCIdNfim146JAYJbJyBs0SEjkuRpm3bYjI0HisJF
         UpYTp7oPrZ95BemLcnE7Cw7gpDt9WPlKUxlWNmZks1kuFsYfmSHNnS1shjKXCR13i1EE
         UVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405342; x=1786010142;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Lz8IBXystSHPMs3Dd2XtqjCRsgWgqnaNeE680bLV7o=;
        b=IJjAI5pUW4K85I6vl+lnMEzNI2Qhy0gEadpicVomrbSRwZEsuKB2LTM8BHN8chWGgt
         tDFtWBNw6TcZ50TVFlbgFFPiToS8797k58XqRhnTNISyepa9Ka/XtpiaMVEmXsD8KW84
         EzhdTWc07ovePpYl65BH51iSwtL3sxOdpvTtiatYrqPMtmwZIJdKSTr8TZi5gwXB0jL+
         j4kiK0x1HRB2F+JhSMliketkgWWCQ4pG1ra5bEkfgmoRozUBy/CdsSw9SCFpEOx0YWLa
         VomsjvAQAW0SMBguTlBokbd5T2avYBV7+608r1e5HtungpgM/wQpSBSHQU8mGtT4/LLC
         qcsg==
X-Gm-Message-State: AOJu0Yy14znBq0FkxrQT9og2zeASjTYcnGsGwCJYsCgXfb4zwNn7VekP
	FPE8ASg8lKom3ia0YCqxCdQLCwc9dVdYzGmNW33nvBh7WxlBIMzWmgaBJ3BeyvCeHADQ8vmYULy
	tQXNw9kUwbbOztMbhbAT2miMvxbytrjWo1PGiGAfGacraDTmjQJ0SaW563g==
X-Gm-Gg: AR+sD10UlG66rSUlqa3IxC7EWLLr34i3coNJenlrmy1FYF09iG8fHD+cR8LszCfGtOM
	Do5lzBENp0nqwIQ4P1RyLZ1U5G3c/lWNZpFcvcLagu2fpNtkIw5OXEPAgNHu4kv+8QKu6mTZvwE
	MlSNq8gPWna0h4K5/Ff9n2W5M0HskiyNxd3WTTmsLULZjBCJvKoeKVQ5us82kS6Ba+6RBnQiC3i
	g1Jff8GdID2uITumGb/QSuBdQD0StjtF80xkT12R+fD0Bjx8pptfdtsx01BXAPO4yNUcDrWqOp+
	H4s/nV0K3Ya2DgSCrREoy7Okx7pXBJR5yhJPYT5xYifkA1mJzZ2+A6jp0cmq0gskE/w2Zf409dh
	N1e7ZzZyYYXs63rrBhC10Au/pUY7y3VwdWU1Wy9oTI+GftKb5DuvF0NRxTokn+nXuOKxjQq+fGb
	upJg==
X-Received: by 2002:a05:600c:a44:b0:495:3c6d:f294 with SMTP id 5b1f17b1804b1-49800ea1a08mr26153225e9.23.1785405342466;
        Thu, 30 Jul 2026 02:55:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a44:b0:495:3c6d:f294 with SMTP id 5b1f17b1804b1-49800ea1a08mr26152705e9.23.1785405342026;
        Thu, 30 Jul 2026 02:55:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011f4eb7sm45229285e9.6.2026.07.30.02.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 02:55:41 -0700 (PDT)
Message-ID: <c4fb41a2-4859-4f91-b65b-b1ca036185ed@redhat.com>
Date: Thu, 30 Jul 2026 11:55:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] rds: synchronize info callbacks with module
 unload
To: Chengfeng Ye <nicoyip.dev@gmail.com>,
 Allison Henderson <achender@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 Ka-Cheong Poon <ka-cheong.poon@oracle.com>, Dan Carpenter <error27@gmail.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20260720184955.3008978-1-nicoyip.dev@gmail.com>
 <20260727174826.135662-1-nicoyip.dev@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260727174826.135662-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 7:48 PM, Chengfeng Ye wrote:
> rds_info_getsockopt() reads a callback from rds_info_funcs and invokes it
> without protecting the callback's lifetime.  Transport modules register
> functions stored in this array.  For example, rds_tcp.ko registers
> rds_tcp_tc_info() for RDS_INFO_TCP_SOCKETS.
> 
> This permits the following interleaving:
> 
>   CPU0                             CPU1
>   rds_info_getsockopt()
>     func = rds_tcp_tc_info
>                                    rmmod rds_tcp
>                                      rds_tcp_exit()
>                                        rds_info_deregister_func()
>                                          rds_info_funcs[offset] = NULL
>                                      free rds_tcp module text
>     func()
> 
> The reader can therefore branch to an address in unloaded module text.
> 
> Protect callback invocation with SRCU.  Enter the SRCU read-side critical
> section before loading the callback and leave it only after the callback
> returns.  Clear the callback with release semantics and call
> synchronize_srcu() before deregistration returns, preventing module unload
> from freeing its text while an old reader is still executing it.  SRCU is
> required because callbacks such as RDS_INFO_COUNTERS can sleep.
> 
> Keep the callback array unannotated and use acquire and release operations
> for publication so sparse does not have to apply __rcu through the
> function-pointer typedef.  Replace the two callback-slot BUG_ON() checks
> with WARN_ON_ONCE() and return without changing the slot on mismatch.
> 
> Fixes: 70041088e3b9 ("RDS: Add TCP transport to RDS")
> Link: https://lore.kernel.org/netdev/20260720184955.3008978-1-nicoyip.dev@gmail.com/
> Suggested-by: Allison Henderson <achender@kernel.org>
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
@Alison: I understand you prefer this on net-next, and I'm fine with
such target, but the current guidance for net-next patches is no fixes
tag unless the buggy code is on net-next only.

I'm going to strip the fixes tag while applying this one.

Thanks,

Paolo

