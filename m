Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3504EA38E
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889156; cv=none; b=ncHWw7jOaALrEtWgO0tPJJj9T/XAVmH3N2qfynG5Gfk+WH2WOC5X7NZj8JZMU4e9mo8ScIV+zg04c2C0rZ8kAhRhRQs3O0IhAhu7wTPug6HlvWtRC+LmfMHiC7UsZQShXVc7+moWSd5NdnpYA8LA1ZIHTXIw2Edb6xbdcFzL/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889156; c=relaxed/simple;
	bh=eRm6FKELo9M4XlR0fATfvBgmA/dMHoFQ8Fsbf2LQeyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQ++pGnF8CLvSMDp8PlO77iE62mKx5BgF2GLXIeXAplRt2KoEykw/xrqw4S2B/EwQQAwM93oERS4wqEC1Yy5Luil7ER4V0IgZc+5QnDscTFFmZ41VkUqhCBjg6/t5ekVdlW02TssSLnuKwufKtIHkr6iYfeikdMBv9yZf/sPmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jw1ZPfCv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BR662ExJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jw1ZPfCv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BR662ExJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Te9KqrUPYFQaQoZuFS+h/tQhTt21Uk9KvdIkiSm9Hh4=;
	b=Jw1ZPfCvWk/zXl26+HmW0ayNxB1/iwhDUJ7+dJDjjajSdAe2fxdHPArceWMs1KwrGMsXTl
	zxU4Uy2zBL4m39lA0g5Zp789R9nqzlCwyXKwkg/lYPBSuS1XRXqetq61DnVD1cjUPcatRM
	O0+ktgTRdE2HWnwwJ3NWWusdMEHZ5Cg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-6P-eJeYcOXS8XULY0conGg-1; Tue, 13 Oct 2026 10:59:10 +0000
X-MC-Unique: 6P-eJeYcOXS8XULY0conGg-1
X-Mimecast-MFC-AGG-ID: 6P-eJeYcOXS8XULY0conGg_1791889149
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1813fea7dso44427985e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791889149; x=1792493949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Te9KqrUPYFQaQoZuFS+h/tQhTt21Uk9KvdIkiSm9Hh4=;
        b=BR662ExJsrx5esodjTtrkOZo9xEzjLjZB8l/oK2sd2g2iT0C4B2YB2rh8Cxi45Gwk5
         hi/dfujNrtHdHGEe01e9VZ6eWkeyWOqM8JZSTBQb84bRIy6jCpGA+qVRbURLxzI5Wgtt
         vifpirdlCIgkVTNkCzvqXh/UXfQD5+T1oRSVfgLDtOsxa/nAgtZQFu1TcIoobgZs5wNy
         xc9JEQ4xK5bgGiNkTrUOb6PcHdYKP69UynAeIeoJWFai9U1JmSas57uNxIK8c9pin8RC
         /1ya1jwlKj4wQ7FbI3iClo3jpIt1+hcV0+R6fdhvQOkXvvk/MTZ98mFVoxP6hvxR/mts
         kagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889149; x=1792493949;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Te9KqrUPYFQaQoZuFS+h/tQhTt21Uk9KvdIkiSm9Hh4=;
        b=AS6xF+rKQ/yXtaMOzHErstdviFuO229O/eBTgg3O9ZEs3KBJvgV1R3zzPcwHVYjuyd
         i/bapaxDYZNumDbE7v6Be84wZFfYAq9ZBWYurtvdON+UNy4HDs96Ybghwk5zKZIP11yY
         pto4eaKw5Gm7dFGrE59rg5MRsAN9Ne2z+SlzT6V/5QjpSoj8Ir4Ua+gKZv/7dEBikCOJ
         LC/aXloX7/g83baj1xt8KP4sXCvw/xtNjiLh9jOef1Oyf82s0g7uB6bUevHaPuNuN/RH
         +jmanIo+QXfQI03ctcgeGXuKLpDmHO38Q2/q06Xj7UvpdychHRfCQaEZtWxUH0lqyY7V
         kSNA==
X-Forwarded-Encrypted: i=1; AKwUvBya2upmPcLfG2m8DJ6r67d8oelJRkqiPzSO9lzwJU5nWdmlGKbKlPMklASJ/gNRxDLPMlmSqF4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLH5w0x5f/jxszzXwRb2hM8mTb+IXF7FSE0ALRFUvwSSidP/Ce3
	fNI3sSfj60kFxtZGkRr9GJZlT2bmzBS/tVNCIvQak1AZKExZCAtRGtYPLBY5kV2NxuNNh9G2HQl
	BGyrNiuAmQtRLuMs0+r1Cn4gKTJIBPX0r44viH1aGP5U+PjZfRi+yh+1SYw==
X-Gm-Gg: AYBFou3P7A8/iZhc1Y2ZTtl16a4XqiDb0bEIRk0ZmdSpNgD1d9AXi0tUkkM4DC6q9FZ
	/NPl+PYtyZuC1ygiT7xDjtqdAyKwH0uVyXKIBAUwiAbMKQJ2n2auRytiJWIB8fQJcNjUCmiTp6V
	a5R5PCWdMMtsBJG7CXtjhssoiG9OKp5pApCsQkTkuy4Sje9HgOlAmzTOvDDL4MjB2O8qfWpqaSq
	wXi8S6IXD3N7XJF3ylfghtfn1sc39GOOZRaDhZn8klhWu81yfyZe9MwN9xQOoPLI2bBVUblccxC
	M20XWlG62zvfAW8XoyE71kpltBhWelIjunK6ClmO2j6j4K894zdbICzmrgDeIC7hq8PNdo7CJ4c
	BzL+tkIzUuWQBdsXfcXR/IqjrKvMUeDb1nDmFPr1G+BGuiP0aseZBMjJlmYIu63yXVuBnBRep5w
	==
X-Received: by 2002:a05:600c:6097:b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-4a18e4b8885mr226247955e9.31.1791889149215;
        Tue, 13 Oct 2026 03:59:09 -0700 (PDT)
X-Received: by 2002:a05:600c:6097:b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-4a18e4b8885mr226247595e9.31.1791889148784;
        Tue, 13 Oct 2026 03:59:08 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf214a1sm406338615e9.7.2026.10.13.03.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 03:59:08 -0700 (PDT)
Message-ID: <0040948f-abdc-4967-ab76-02962e813dee@redhat.com>
Date: Tue, 13 Oct 2026 12:59:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] smsc911x: propagate reset GPIO errors
To: netdev-bot+sashiko@kernel.org, phucduc.bui@gmail.com
Cc: steve.glendinning@shawell.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007104731.507647-1-phucduc.bui@gmail.com>
 <179154290727.434549.17639920596465691112@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179154290727.434549.17639920596465691112@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/26 12:48, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] net: smsc911x: clock reference leak when regulator_bulk_get()
>    fails

The above is IMHO worth addressing.

/P

