Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737972F1FEF
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375941; cv=none; b=WWe5+JeaOi4oSfd57B3pnF+ahw/tJuCI7LBcRVMZbVJLkR7P3LqusNyGTS00Q+4c6+p4WWhbIT5QEC/Sf/QtkZa7OLAblcoI4fHaKI4VFBPCQP+BDFUpPpBoCjQclsdTXodEccgUz8yxA0oCILrILVIIxCNIt0su1UwgMqt1ZW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375941; c=relaxed/simple;
	bh=Xse++0WKOGWzNQ0Un0Vrv/SV8r+mXu51xVq8Pp5x+Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFfMrE6uGXGS3admGtIa2oQgnjARqG+6Pj0+uR2MldNqZhJWAlMmGuvBnFdXXxx+WwYhGFjeKQgaBaMSGdzOdXI/K7AQCWLIbApc//O4EsWa2ISv8C2a1EOQzqe9HT8RfUZxg6EzztmeWJJflBotyLDqjs7scK9sLXOvzPUJlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCsfQQxG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=swLtLrMN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCsfQQxG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="swLtLrMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777375938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJ1bmtlTWfKzrgrTM5W7n4oGO4POSVvJD8HcAKOOifw=;
	b=TCsfQQxG8sok1d7Qb/wyNozRD89Xk2CbNp9aIpkwVNzOU7l5HiN8jkH34NmzJmVKMsVvnF
	H9T+Qvp1aVNgBjfgb4bidxX+Lhzoh1SyEqkWH+xkGkDQMEb/PTh5uPqqlz1YsOQWwEfGys
	KlydleEOb5v0emaVp65w4Oer1E7Yljg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-eOp9AsvoNiqiQqBeIW95lQ-1; Tue, 28 Apr 2026 07:32:17 -0400
X-MC-Unique: eOp9AsvoNiqiQqBeIW95lQ-1
X-Mimecast-MFC-AGG-ID: eOp9AsvoNiqiQqBeIW95lQ_1777375936
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8ebe2c596c6so1676852985a.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777375936; x=1777980736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJ1bmtlTWfKzrgrTM5W7n4oGO4POSVvJD8HcAKOOifw=;
        b=swLtLrMNhAvV2JdAwIHVFMsBq8aYBMZWFl9Mm25i1EhR+zygQ+Hq2NZq/ZZOGUwrVy
         SgV6jQtrTru7WaiexdIEPhrZmZlwqQkQ4BXMeo7aj/fKqhvMQ6a3bLwV4r2EN9CTD1VO
         iGZUjWIqb6jYgHkV34vDUsoO6aZOD9xFmazm2m7z/znVzVc3c4PqOpflRZLleVZNRh8J
         14LgFYdJx18vxb3OXF1VMwdoSVnF889W/dl6TPax7opmeQdBj+lNWdPi2yI919o94t9y
         q116TrmLQO5aEvBxQHtsVgAl9H5JaxLqQYOyPpgZE1Gn0Tgm95emc/nVJt9LAKXEhvyA
         jF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375936; x=1777980736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJ1bmtlTWfKzrgrTM5W7n4oGO4POSVvJD8HcAKOOifw=;
        b=kYRySAMIQyaOFTM892X9w30JjizXHeLnOGzs5jyg+M0ggrjzsw448ntALvKr1moZcs
         hXQWDvdDRo1wCD36OGlaMrARGRXopHggqmM14emTgXJnwv/h+XDT/BgwccrjCZq0lXng
         oQU4gMDO2+URHiWpk+eKROycfbDd3IDSUMgap5JY/OPRhjiWJckg/alRTdEl56NevVCE
         R3gs3fqCVoYEJX0++pxCRwqkicFcG0gLNFKgMRZHLONSLk5xJzENUeHcPK8FK/ii4xpu
         vldAwayHcXcKN3Q3+4Y6P6iNJk3sr2nREW/7UGGewtMdTenvpv6CRwhCbJGWf2dlP/nE
         IiQg==
X-Forwarded-Encrypted: i=1; AFNElJ+SG2dOG5CIoHAfiyDwbS3Qm21N55iRcYjtxybq4Zy0H8LGVWNqmXuRZ5sQGAXX2m0jNbE3qTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22qpptz6uuGw5lGIjWpB6unZ9yjJGGDNf/mjS9WahYffXsCuO
	EQrInPN/5NLLab45RZixMCVYRL44rpRknOJ+q8D18/ZnaKyHxv4UI3UbVyOPm8Qbx4N90PYLpeo
	993fPkI/VlSszU4jf3j0TsoWe0EQHAtfsD+msCJ9qwlN+g87ePcFvWQDe8w==
X-Gm-Gg: AeBDievRv1LXaTVRBaXx1cJOqGviZMENqmxfjt229luFQG8Nfo0CprlwTWDdDXPj9+V
	hZVkRA6Pv3nRMKJZDfBlrjxWgQYa937Sg1s2Jqivjhf1pX8jSG2jtY81d7CkiqnxXA+cnQqcflg
	0KR8wRJV/juXgbcAqzjSBIktUAsxftns95BVfWJSjm8BLNp2D+LUZhGl7BGmuZusWz/4EybZr/D
	W1MpnaKYMzW51kOe9UiU0Q17DvJe0aMACO3ipjBToz7+Dcri2FYS4AmjpRVXhw9Y16KRnVgWpcz
	UN62Xim90W0RC1PpIy8mmW6gxCvSuWJvmAOTvN1NTnG/Uo8RAcGoxyTwPsWDECUerstgpFy32My
	HYx52i0K3XwYMKiTKB58VYmIIcNtQEUzEQRXiBlpDpWNvxuQCRlDAbtN9L/ntDptO7A==
X-Received: by 2002:a05:620a:7106:b0:8eb:610d:a56d with SMTP id af79cd13be357-8f7d7d17fbcmr325926585a.27.1777375936609;
        Tue, 28 Apr 2026 04:32:16 -0700 (PDT)
X-Received: by 2002:a05:620a:7106:b0:8eb:610d:a56d with SMTP id af79cd13be357-8f7d7d17fbcmr325920385a.27.1777375936033;
        Tue, 28 Apr 2026 04:32:16 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c19ae61bsm171070385a.0.2026.04.28.04.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 04:32:15 -0700 (PDT)
Message-ID: <f52c81bd-aae3-4d23-ae55-a0b3dd075f4d@redhat.com>
Date: Tue, 28 Apr 2026 13:32:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: usb: rtl8150: free skb on usb_submit_urb()
 failure in xmit
To: Morduan Zang <zhangdandan@uniontech.com>, Jakub Kicinski
 <kuba@kernel.org>, Petko Manolov <petkan@nucleusys.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
References: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
 <E7D3E1C013C5A859+20260424015517.9574-1-zhangdandan@uniontech.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <E7D3E1C013C5A859+20260424015517.9574-1-zhangdandan@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/26 3:55 AM, Morduan Zang wrote:
> When rtl8150_start_xmit() fails to submit the tx URB, the URB is never
> handed to the USB core and write_bulk_callback() will not run.  The
> driver returns NETDEV_TX_OK, which tells the networking stack that the
> skb has been consumed, but nothing actually frees the skb on this
> error path:
> 
>   dev->tx_skb = skb;
>   ...
>   if ((res = usb_submit_urb(dev->tx_urb, GFP_ATOMIC))) {
>           ...
>           /* no kfree_skb here */
>   }
>   return NETDEV_TX_OK;
> 
> This leaks the skb on every submit failure and also leaves dev->tx_skb
> pointing at memory that the driver itself may later free, which is
> fragile.
> 
> Free the skb with dev_kfree_skb_any() in the error path and clear
> dev->tx_skb so no stale pointer is left behind.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>

Applied (by Jakub, AFAICS the bot did not send out the notification for
some reason), thanks!

/P

