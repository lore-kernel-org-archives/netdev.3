Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45521293C4E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170922; cv=none; b=OV4UkI+F9IC+zYx7TcpFXpABjf448ayPllc4+t1RgR3aY3PJwPBfQKegCRulE5r4imPHP0jf98pSbmcMuntSRO93i9R3pVktjn6BkOHVwX3+GF0pyjObOhN7Sws9qBiXPhzPebDtdoCl19028fBnJh3+xsDLm9f+Xc87Lp0SOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170922; c=relaxed/simple;
	bh=vob1+8i62fgnz/ZPtPuh8EZn1j5rr+AtcYWifEiZz/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOH/tDat1NC6B/4rt2DOiF8g4CgafCvI5TJFF7NpkOouwN0FG3nbSgVcXB3JSxe2krJyqsJ+zjDR9E8YsSFE41v5Whh9accN1iEnshCjqcp5mZRHiIWeeaNMPewuBIGtdscPG64z/WUwan8cgxsjQsazUEL5iDILsRjkTSx/T0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwycfudV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5K+A+Jw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwycfudV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5K+A+Jw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781170920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr0hD7XVU0wbZWKiqIjbBktqlOmfsvZ41wP4H3+JU7k=;
	b=NwycfudVEp4chF9Z6tlcIl2R1Jri4E5kBRmZVSWr/YJ9wImpGu21Q01l1SYW9nvSRIZOxC
	IgiHHypyjtyAffHbR1IFzDJ6nzs0bBQgBdtU/r2hkiSZHxRc//40gVp90AnXfYRhuB7Ekw
	Gd5lEiUVCgORbS2EPbsLh3ALqbrKi0k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-l5MkD1BCOimTbkp6zZhURw-1; Thu, 11 Jun 2026 05:41:58 -0400
X-MC-Unique: l5MkD1BCOimTbkp6zZhURw-1
X-Mimecast-MFC-AGG-ID: l5MkD1BCOimTbkp6zZhURw_1781170918
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef2bd566bso4392075f8f.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781170917; x=1781775717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr0hD7XVU0wbZWKiqIjbBktqlOmfsvZ41wP4H3+JU7k=;
        b=T5K+A+JwIEXPea1K+jGSt+gglrdCRQ6O19oX5GGm2iR4SjWUB43+DjWZVmxKGRTDsM
         8L5ttJLBJOioIbI3tDjskz/NC1A64DZgNMuY44sG43vDo2kHcaH55Js9h0gp06gOciEG
         FkY2LkTlel15trDB87V8uDFQpC6VIt7awa5DA3uxA9Jcmxo1rEfPuYqBacpo+G2Z2ilW
         eMIn1dzxxWEUCqJ2acoTvEEoF9ve58Xaz+0CdKXeuT3gw24/Bu3+5iFc+R1nEge9vNGf
         XhPf4Ayx/m43uKSquwBBrPB689jBlcvQWQy5/pJzL961xJZvnhWJ6TZYpN7kjY7Kr/1N
         BcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170917; x=1781775717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dr0hD7XVU0wbZWKiqIjbBktqlOmfsvZ41wP4H3+JU7k=;
        b=Suv0j+nPUTormA8uTQhrph5euDxgUy1BN3CrdxHGjY+32we4WCFLPTLhCn3WMfhv6K
         K4PZ5YoKD9OX7netwY4tgYOwEfrWtI98WthhSLwsvxhwUzGL28OMI9Lrd2W8+5NIGsCb
         ChNhtSlB/S/JGBvdL7tm2Q2rLKDvCcSSn24m17qBTSMUV+WhMCusyOD9rXDWOdv9zuAp
         rL8UF7g2dKrYpC13QfAxEbz642oIPifnHbr9ykXsaTtWiwOqJmUp2cYrgkRYm/Ysh042
         2hwrAfQOIDm43ADO3OwGhIfCd15ZJzd2IBhkZbhtMvPjwNyNKHifbNJxvA+CKhlklwJ5
         Wm7w==
X-Gm-Message-State: AOJu0YyMxSmiSNvBy48LG7aMr4rA2q9AtAtbvUQWqzzELFkEzZIO1GD6
	bqZZ5kc9aiOKt6qR69saco9UAwAeLHLkOKCzcO+G8A1pxqlgtPFYZwjATbozj05fsee1WoyPi68
	/PLZkldPAdzUCCewdPoro7LFXSp9Ush7N8vRCq+7Kw5/6SDb+B9icRj4mYQ==
X-Gm-Gg: Acq92OHQMqO72ZjWoRbfG8HwSue1/Bc/4lYjojPbgfZ/x5heAZrOCdsksMVTamAOu8f
	88cjPATjOoZKmME0fcIDmKxNuWfhjiphFHMoM0pZMaO0SSCVZGWmVR1ZMFObYXEshnhn+wYpB8e
	eOSVEe/Hi4aRjcUO4sT9bLoIdtxZKxhYWxSNOYtopCkcF5EBjbWSWi8zojF/K6bIYlboHv4T8/I
	zAl6bMf8839pLbpXpCK90NxhF+onSnCHyrad7mgG2HNnj+Ql2LNdW2ZM/JdIZa3OaDm3jcWxJlP
	UyOq6Of8tt7KqiH0vET/0jYbrA0LQCIOKJ9EwY1Lx0pyd/WTR+5RzIOIsxI5s7ok9++3hIZV7iI
	H7kYOCfxFoNzayqM0IM/6k7vhNaM1p8UJU6jzx9TnCqjr9MROG4h3Z9aXn3rpmjrYt1J0qqXKJd
	ZpkuXUkw==
X-Received: by 2002:a5d:5f81:0:b0:460:51ef:f81f with SMTP id ffacd0b85a97d-4606758d308mr2841364f8f.6.1781170917549;
        Thu, 11 Jun 2026 02:41:57 -0700 (PDT)
X-Received: by 2002:a5d:5f81:0:b0:460:51ef:f81f with SMTP id ffacd0b85a97d-4606758d308mr2841315f8f.6.1781170917121;
        Thu, 11 Jun 2026 02:41:57 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm80878148f8f.33.2026.06.11.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:41:56 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:41:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aiqCQCdPHw7Ja3tM@sgarzare-redhat>
References: <aiptrtQIC5ivKjem@sgarzare-redhat>
 <20260611085537.622665-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611085537.622665-1-rafdog35@gmail.com>

On Thu, Jun 11, 2026 at 08:55:37AM +0000, Raf Dickson wrote:
>On Thu, Jun 11, 2026 at 10:27:42AM +0200, Stefano Garzarella wrote:
>> Maybe adding a new function that moves a socket from the pending queue
>> to the accept queue avoiding also sock_put/sock_hold dance and
>> sk_acceptq_removed()/sk_acceptq_added().
>>
>> To be called in vmci_transport_recv_connecting_server().
>>
>> So can we move sk_acceptq_added() also in vsock_add_pending()?
>
>I like the vsock_pending_to_accept() approach, it makes the vmci
>path clean without the double-accounting issue. Will send a v3 series
>with that as patch 1, followed by folding sk_acceptq_added() into
>vsock_add_pending() and sk_acceptq_removed() into vsock_remove_pending()
>as separate patches.

Okay, but VMCI still need to call vsock_add_pending() and 
sk_acceptq_added() in vmci_transport_recv_listen(), no?

>
>Any preference on the name xd? vsock_pending_to_accept() works for me.

Also for me :-)

Stefano

