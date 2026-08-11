Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB642C4F8
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443659; cv=none; b=ImnyXwJHc1un+psJYwjJl+NdUR36QYpeGNhcYfrnWJXuA1jFVDs7pS7CK6Cuzxqf8yX/Av1MKvYTxmcC0A3ePDMMbec36KYVmd5+/WVmCw413L70o7pyEWT4pYLuy2m0xyuCI1KoY9Vw1EnoYOQfbG1epRpbp5q112+zLegjIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443659; c=relaxed/simple;
	bh=/G7exXCz5i9dGHZkdoXv5gBEUahK/O5+dksE2ezDf7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxVe9H6zki5tFu4lyrPnN9JdFyj9Q+fD0ZICn0gbeXc91igEoEG8IdhmkEagmKCaELlKRpJvVQ8h00oV/31dzL2rvT1tzAQ9+gVDjTQA3PyfQuPYXAZ+L1F0JiIS7Ddf24ids3l7Lwrd8L6A6asOsPpl3HplrU7xvfeM0C981Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5nmgNu/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP9LCOy7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5nmgNu/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP9LCOy7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786443646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epcLinBtBWUDj92rnkkjjKzYesqtLRs7oPU8wi2dh+U=;
	b=D5nmgNu/QsQ3vLI6ZQuKNv9K73W1YE7jcLSPxBOJ8XHu81JE0Ezo9gY5L4MMu+i3db5D1i
	eLgC6B9YMF+TmQPxF9hZJYJCsy3BlCud4hTZf1CsSvp5Ky7Fbaugpxx82+YZcfEZkTpvj2
	GBCJtYVTJds/0siPKtuyk+w/Feeme6g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-rhGWlZGbNMexkeCrvn9tLA-1; Tue, 11 Aug 2026 06:20:43 -0400
X-MC-Unique: rhGWlZGbNMexkeCrvn9tLA-1
X-Mimecast-MFC-AGG-ID: rhGWlZGbNMexkeCrvn9tLA_1786443642
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496b61bd846so21769595e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786443642; x=1787048442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=epcLinBtBWUDj92rnkkjjKzYesqtLRs7oPU8wi2dh+U=;
        b=UP9LCOy7mn9AT047c2UaYfsLPsk2p+B/J+lL+y/xMnRIS6/ew/ZYrqGEXT8AsN5jFo
         LM5OFP3ZCDi5uPZkeiUFzKaJdwh+TBSUnKxCPJmauT0ynHvTITsAa4z5zQFQEgxoEzFz
         mXODg/hGED69iXsbk9qr11zmIxgeAuSRgzKOpJ8xNn1N0Hw8iWum883mkbZkDudD6iEo
         PkyVzTRlG4Lh4xNcSMAVS+OAjdXv8uHCRLHOMRHl5eUI2tiSNuOH9uYVCjgK1JegJGi1
         XJzdAcly00QoSF24qKG9pCHysz2FTjs8sRt0nf4/aH5RqXYnkbqj6bdXIZ6uGk60WkJA
         F71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443642; x=1787048442;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=epcLinBtBWUDj92rnkkjjKzYesqtLRs7oPU8wi2dh+U=;
        b=CJ/RW61jyV22EX9wox0vCI4HnmsbRAzVAmhE8Y2EImX/N1rNQ01KXvqqqFm+HJbFf3
         laK6AnlSD3lifCV9u/Weqqa1irirFonLrROhstfB3/exd7L1eYMVHYtDxSfwNz9dIlFI
         qy7lkcHJF/hS4zU0Xjcy3eSuHJ5IjEjBggMjgD1hZtfpOW5DH45+l0bZe97i23Jocbwx
         NAK1f1/w5GJ7NT0Y5RV/ZAPptmMxqSxAJADvpqKCw4kXhIUTEvzytEUoAXxrkuBLvS0t
         FShUG98zs4j3/aVhTqlMZ2s0Obi6+IxIDT0jfK3zHftHLecnO7G7PctZ/45uBPb1HY/z
         HLGg==
X-Forwarded-Encrypted: i=1; AHgh+Rrz0t47cKcnZMhttCl44sBhdBXIr0+Lp3ipUpO9+Ic7HTkaeZ2X3JCuHskNUki5t7xGqRNwxCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXK7+7xGc6Ot9CVYcgYswbCejcz+hNjX6Ew2Ho7QYA2vIIc/O5
	oG9PKNr1lAKrgnwFEF9g6fcT8yghYLeFHASF6QrLIKFh9jNjp5/VWR2Leu5REm/lLJHAvODdEj7
	y7gDWgMS8vwLtVJfgf630h5udyrkdAO7zXDuQifH6x2hs+aVeGBPDhA3uRg==
X-Gm-Gg: AR+sD10jWKWRiyPGxrKn4G8xz3a3+er8gLFh2RG6K5JznUN6e1UOcEhhWK/j+cC5YvU
	IVCsH7xEZh4eNiZK3hRysE3C0Zzu4sj3nhZVhtngdfmr3osrqByRdTU/kky7thlXRQtZwg0Dns5
	kCJT4ch/3U7Q9i5Qn3kFhRTRubKzNdFZNyJffAFPjZ1U3JZ+l/qjKM7LZezkg4zPib/CsU9QctE
	25fY5Z8deT+hZ1wFK9kui1VtOqaTgcjJ56/3wIFPq+OJB2fOtzliId61cEWpQNA7q4aPWn3G1z7
	ctsmp0hCOrAZManPJTL4b9g/OV3gTrqNblVENaXsKnhW0D/Sx7lUHV1DRQ2+AS37kblG2RrgBUc
	1UiRRzAUK9XJiJ5ZgHZVOLx+eMLIRn3bDlTG4yJgKbInuEwGqXnnJkCq9x9RW2AwgYVwFvQ2P9a
	0=
X-Received: by 2002:a05:600c:6085:b0:493:c634:952 with SMTP id 5b1f17b1804b1-49978430a48mr34854045e9.7.1786443642201;
        Tue, 11 Aug 2026 03:20:42 -0700 (PDT)
X-Received: by 2002:a05:600c:6085:b0:493:c634:952 with SMTP id 5b1f17b1804b1-49978430a48mr34853285e9.7.1786443641701;
        Tue, 11 Aug 2026 03:20:41 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c2bcsm41386075e9.3.2026.08.11.03.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 03:20:40 -0700 (PDT)
Message-ID: <4821130f-2416-42f6-b3cc-c0cfc12ffaa0@redhat.com>
Date: Tue, 11 Aug 2026 12:20:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] l2tp: fix tunnel and session refcount leak on
 seq_file release
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com,
 James Chapman <jchapman@katalix.com>, Guillaume Nault <gnault@redhat.com>
References: <20260810141125.1176545-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260810141125.1176545-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/10/26 4:11 PM, Eric Dumazet wrote:
> @@ -1608,8 +1655,8 @@ static __net_init int pppol2tp_init_net(struct net *net)
>  	struct proc_dir_entry *pde;
>  	int err = 0;
>  
> -	pde = proc_create_net("pppol2tp", 0444, net->proc_net,
> -			      &pppol2tp_seq_ops, sizeof(struct pppol2tp_seq_data));
> +	pde = proc_create_data("pppol2tp", 0444, net->proc_net,
> +			       &pppol2tp_proc_ops, net);

It looks like the above does not build with CONFIG_PROC_FS=n:

net/l2tp/l2tp_ppp.c: In function ‘pppol2tp_init_net’:
net/l2tp/l2tp_ppp.c:1659:33: error: ‘pppol2tp_proc_ops’ undeclared (first use in this function); did you mean ‘pppol2tp_chan_ops’?
 1659 |                                &pppol2tp_proc_ops, net);
      |                                 ^~~~~~~~~~~~~~~~~
      |                                 pppol2tp_chan_ops

/P

