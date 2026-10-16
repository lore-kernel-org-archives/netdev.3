Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52278321F5E
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138536; cv=none; b=pSFdAaw20RRTF0WYC89RchkasZEdzAHJQkDRbkxUJ0FS/8OcS1L80vdKk9JuAnA7vSZKVwcMSWNMMVdXkNe5xSt9r21kkdHBQzOnj6aymcq11SMFabnIVFqca3o6WLk2mvuKsUhLf8K13+dwNH0W2OSORqssGHVEwJtzo8Os1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138536; c=relaxed/simple;
	bh=Y549rUx82KGZkIt3qwDBp9IS8fAoR7mGvTJsFiDdNL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A66FScx6RcfOC4HxLFU7tkVbi0Da7Bng6CB4Q3yYggQ1ISfhMQjT3ajzS0e60Wg7h2ZlgRUtUnB50/7meFpMigmKyqVDD5PBFe0LvOHVbE1BrbOevYCKFVmqNc5LBBc/f6RRtEkFQVOH7vLBDMDX0dnAQxofIRIQtEeyCtqGE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGdauhf+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9rkJ+tS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGdauhf+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9rkJ+tS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792138534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y549rUx82KGZkIt3qwDBp9IS8fAoR7mGvTJsFiDdNL0=;
	b=hGdauhf+WDsolVyOsZ8uigkkz/FyXZqjV8ZDagM3i3ApfZRw6Zq9gQjVmKRxpDLa9il3W+
	v+kMvPr+0tSzrwZ4vlRWorUSVOJq06XqBWn/aFblubMtgGpdtu5+hOW7/3+lgDrDBJND2O
	qUAWJ5uOulEqtehusWGqeCSQNeRTCAs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-bAavuR8fM5iWnyEP_iKocw-1; Fri, 16 Oct 2026 08:15:32 +0000
X-MC-Unique: bAavuR8fM5iWnyEP_iKocw-1
X-Mimecast-MFC-AGG-ID: bAavuR8fM5iWnyEP_iKocw_1792138531
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df02b91f9so436216f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792138531; x=1792743331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y549rUx82KGZkIt3qwDBp9IS8fAoR7mGvTJsFiDdNL0=;
        b=A9rkJ+tSYKGpUFvPNTmhlzORUFAlukNM0r8SR7NtoSYCBe8+5LLOPnrLix4Id536va
         NrS9dGQCMVQW3E+upW2sK39arNviDa6RAFCP9tQg9XLfwTiOi62VvPs2dTCYf50ksNqy
         lZArJqDz24yWhIeOxBAQQOWNosNdV4hCQXdkyaDW1JUNQr09gskSSr+IxELu1869ekJF
         ajeYWW9Z8M2VfawKLFIDlRHBEvYVZpRGCUuK+liJRisSj/5MhWfnsXwkRAu0nkb3CqP9
         mmWrsu/6orC8+RPVbDF0epYU4xgzyIXPTtUYddC3wsk/klKXcXovUJDA1It6uuAHMnhm
         NODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792138531; x=1792743331;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y549rUx82KGZkIt3qwDBp9IS8fAoR7mGvTJsFiDdNL0=;
        b=pc1L7pl4CN6sjkrMQ800LfOzEYqVPGUPXR4AKewxmyNY50Ldl+78/zv8lKTwwjYWCh
         EE49qWKWBFZWKwFe66G4Mm5NC/rg3LfV3IHHiGdcInhnxlgJYjiHDqN2INDO6FzTbuRG
         8chf4o5KXP218+TE6J8J9DpeAw//8+TJ/yxpf2Xo75Kak97PnLTS9QFtgTVh5fPO/Gyc
         +tamCXDLQkL6iVVBaZsy3DtujyUCfs7ls/kXN8kAXEA9V1fRiaT6hwZ95am7jZQESYVl
         5bcBgprpBX50LWK4A8KW/OrKhIDv8VlF+IDQBP8mCAtVKzwRmLP5QegGuFMTnXUDrWDI
         RpGQ==
X-Gm-Message-State: AFq9FYL3QW3V/kJbiS9CLILduokjmiFxpQKRhMiMtvRGv7kWsVsrOctu
	0ouk/J/EmK4Nhfsfd+G9ZSSn/9RyEnUfumcILQMN5hr6tr4+jipC1OgcZDARiRKWNgUkvqf+OgI
	KAdUqloE8UmFK2hzAhxiLzf9eT/fbdtrBnHgrv/uLmBaDBwYfyOsuCsrv8A==
X-Gm-Gg: AYBFou1S/DAQpxAcSi7Rqgn4paISvVo6oWupQa5etDvyQWc7XDFi2Xn78Hb3cj3qIOp
	/AVAu70n2lCGhjB2il8X7whYEIkJpPy8stQ8bkf4xqtBnvObh8nr7vbjjlD14UuhAEy+ctjgCIj
	F5e0jSqZiTjCckbNaVMnmo16B+Md9wDJAua0Rhe2lX+DRTiCtMf3sKsLKIE98jc8BaF/kSswQYH
	AYpi5cNdBdVoBwu3GWdTCrF3WiaqUJt+8WGeEqYyCFS+lhLmNq9/tPjFDo0deOaX0PX1dCwqx2+
	dwxfgpGnn7+wG+CpEm1sqN6Fv600xNOejMDvt1W+6AKaJo5s35GascvuNZhf4pq1Pr6NCeVfhbV
	W5l8J
X-Received: by 2002:a05:6000:4549:b0:48d:ed0e:6bb4 with SMTP id ffacd0b85a97d-48dfadf34c1mr4227595f8f.4.1792138531311;
        Fri, 16 Oct 2026 01:15:31 -0700 (PDT)
X-Received: by 2002:a05:6000:4549:b0:48d:ed0e:6bb4 with SMTP id ffacd0b85a97d-48dfadf34c1mr4227528f8f.4.1792138530803;
        Fri, 16 Oct 2026 01:15:30 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.137.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c0894sm3190609f8f.12.2026.10.16.01.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:15:29 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:15:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] vsock/test: cover SO_INQ
Message-ID: <atHdAlIdUqNIoDNn@sgarzare-redhat>
References: <20261015154334.3217358-1-devnexen@gmail.com>
 <20261015154334.3217358-3-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261015154334.3217358-3-devnexen@gmail.com>

On Thu, Oct 15, 2026 at 04:43:34PM +0100, David Carlier wrote:
>Check the SCM_INQ value after a partial receive, after draining the
>queue and at EOF, that no cmsg is sent while the option is off, that
>accepted sockets inherit it from the listener, and that out of range
>values and SOCK_SEQPACKET are rejected.
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> tools/testing/vsock/vsock_test.c | 279 +++++++++++++++++++++++++++++++
> 1 file changed, 279 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

