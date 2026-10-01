Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37384766AB
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853549; cv=none; b=dHVaSC0XzLYE7JyD9iwQHXlUQJmN8Db76E/QeTfEMY6cjg+hCldow2DoeapQg/DLu5Rwuo4wwPXfhdZkv9HnMGnt+KCEXM2JkJTv1tTAGy5HRaApgqnQ/ZOS/KHRfEKMQKHSmmEkqnTxRsv/A/sIMbEp3X/eiiLjYH7O9UsDzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853549; c=relaxed/simple;
	bh=T5hkxiLK5QweA8xYY2b0kNgTq2KlMqL9lNVwKAsYRXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ggQ4j6ccxkwNSNOz7WC6O2crI2/vM3r5htU73HkUdA6U+qGJiaFQtEWxWdCpX6RfujUwkE16vrnvkyQs/LG+MWZs7tGMEqQPb/f8eNoUN+o7OO0TlNJTE3Wz6rHH5sDwlaBi5Eg94bnFmx005NN7sK9GISv+y4R8XruXvsoYfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1o6PgNA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Koa3pmFh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1o6PgNA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Koa3pmFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790853545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=isKKctMTOuNZ2ISnIkB2czFHAzW4g7b0r9h2VTPLIVw=;
	b=V1o6PgNA4zxy+F9XprzEF5YjbxwedLINpdiqwyGa1wuN6xQ/g8dZM7WzX8pvEbL/LC68OF
	C34X2cSzTMPxQuhc4xC4MxHBe5VpJtL+PnQ4MnBKI/3tfKhLkdGMNc8CvGf3+E7+s+71yu
	tZ9RD/qRRjEUnJtx08W/CgojpF2ZDsY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-7yNLfrV9OaiT4QnGk_oXOw-1; Thu, 01 Oct 2026 07:19:04 -0400
X-MC-Unique: 7yNLfrV9OaiT4QnGk_oXOw-1
X-Mimecast-MFC-AGG-ID: 7yNLfrV9OaiT4QnGk_oXOw_1790853543
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b00febba3so1109259f8f.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790853543; x=1791458343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=isKKctMTOuNZ2ISnIkB2czFHAzW4g7b0r9h2VTPLIVw=;
        b=Koa3pmFhE1Gum0+QcLYpzFxg2Bg/3ZrOIum9IBxWpCkguvnnmKOioaOtnueHF9dYua
         08AYuFsku+NRBYTGht1beMJyUb5HGc/h7LrGZrjQ86VK5xzN5GPR47SuPbFXozNWThDM
         CXq4Q3dpGhMJW9eHwETYIf0lrmGqyj4ZjGQ/cD0OtpRNvX4P6zQVpOlWRhg3fx59Ztck
         Z3i319GjpLRNOVOjrzQo3Pxingruj/FIs8hLia6+Cy/y7YG09BRV/tU2/uT31DeKsJNw
         DHxv2/Ak05hWgV3ZbGKT7HOOfwGo3nmJvp0zILCa5zvFbGwCaS1r4gxyZ6nUUee0CjIp
         Pg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790853543; x=1791458343;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=isKKctMTOuNZ2ISnIkB2czFHAzW4g7b0r9h2VTPLIVw=;
        b=f1F0mEDzTySP0evWXiJMkPCTYIroHA4PwFdU79CunYenu8+QmcAwReDB5A3Yshti8R
         76/AR+AzllLdvrJw9HwiiJrr7xU9VBissV17JXiINGEEafnMsUKyo5IgpnUO+ivbiiBN
         o4T5ZRgZDP1nIw/b5atXWF6jXfWAfm1W0drGmyQ8MZNfCHXP0Pa9alYhMkiCYIwSVMTu
         STu+zxKwxF2zLARB+c/pyYPk1DTvZGpTqbAjRDbHRY0UfUt0GA9cdCMXKMQVVg4pIDEA
         MEg0EKF8dnfidBZsKo6uw1b8tImH7uPFm5A7Xlre9UpIc+D+G2BlC2aOtnDUY8ZECgJF
         XS7w==
X-Forwarded-Encrypted: i=1; AKwUvBysy15LyCwl4b21iqhjqFqmDRD/Q+bd9zMQoLEzlRgRk+WLCkt7lqymFLHoNX8rQqrvfh0i0hA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjWVufhRhCEnmRVg8ZdL9736WOCslDY68+KJexdCVCrgqKC4BC
	aPJoMgPljq3ZT2wijIeTxhEOkYqbP8KL0Ez1177TKpEY/DfQnjOM9zC4Qc2RQyZ1b8swVfcOetg
	O+aG9kS3HVQqo7K9AxKdvgDabLtQ3Yh2TOZf00s8pPXk9yFFgtiZHcRVlIA==
X-Gm-Gg: AYBFou1rPQvE9jlsiv5gOfAFJnWoL1Of17bZONP+8l7bremw40x9gSc0Cepd9eDU8SF
	d8y6zTJRGpJBBvRMzhNdGt0a6NKXKQHy+rNCJ6I1Ud4QLK4+yyevA4VewbKYYwNIb+w7u5l5OFk
	v/TTOhHk7ZuBwmXqvdXf5RxL8BMk7gEHbWkWXzaRT6r7eX5n6lkuLL+lsG84T/bkOHBy8lT5PUh
	86+5Maz99EVWzVJU4MKii5gm3XHTiu4a3lN2I/VIB3R51SlO/7SfmmqQog52i8hTp4MCzsnUiQp
	mmTiNiuJVvbiyTzmlADBECJ50r9scRBtVH2IdBI1W93raWmRipMUeEGAVm1rBWl/tEbftO9PQDB
	nEwGRKKbwbAuSn1AUPv5ySo9ckOqA0UB1MepO9LTNFe0VnFq1Qgf5A0AjEKkq4cAJ0AgOufKEeg
	==
X-Received: by 2002:a5d:5849:0:b0:487:27f6:a4e3 with SMTP id ffacd0b85a97d-48b0253d698mr7952009f8f.51.1790853543369;
        Thu, 01 Oct 2026 04:19:03 -0700 (PDT)
X-Received: by 2002:a5d:5849:0:b0:487:27f6:a4e3 with SMTP id ffacd0b85a97d-48b0253d698mr7951958f8f.51.1790853542917;
        Thu, 01 Oct 2026 04:19:02 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068ff96dsm5707719f8f.8.2026.10.01.04.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 04:19:02 -0700 (PDT)
Message-ID: <80fdcb30-be96-49da-8499-2c673e95b75b@redhat.com>
Date: Thu, 1 Oct 2026 13:19:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 0/6] net: dsa: mxl862xx: devlink flash and
 rescue
To: Daniel Golle <daniel@makrotopia.org>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev
References: <cover.1790426599.git.daniel@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cover.1790426599.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/26 15:48, Daniel Golle wrote:
> This series adds "devlink dev flash" and "devlink dev info" support to
> the MaxLinear MxL862xx DSA driver, and makes a switch stuck in its
> MCUboot loader recoverable through the same path.
> 
> The switch is flashed over the loader's clause-22 SMDIO download
> interface after the firmware API has rebooted it into MCUboot, and the
> driver reinitialises through a deferred detach and re-probe once the
> new image runs. A switch found in MCUboot at probe registers in a
> reduced rescue mode with firmware version 0.0.0, so the same flash flow
> recovers it; an interrupted download is drained in the background
> first. The deferred re-probe comes from a new driver-core helper,
> device_schedule_reprobe(), which the bound driver calls without a
> module reference; it also replaces the open-coded self-reprobe that
> iwlwifi, hci_h5 and btintel_pcie carry, whose work function frees its
> own module text from under a racing rmmod. fwupd's devlink plugin
> carries the matching quirks [17].
> 
> Patch 3 is a driver-core change and patch 4 does not link without it,
> so the series needs a driver-core ack before net-next can take it.
> 
> Tested on an MxL86252C switch of the BananaPi R4 Pro 8X: an upgrade
> through fwupd; an unbind and a reboot issued while a flash was running,
> which wait out the transfer and announce the wait; a host crash and a
> power cut mid-transfer, recovered by the background drain and by the
> rescue path on the next boot; and an unbind and a reboot issued while a
> background drain was running, which abort the drain at once and let it
> resume and complete on the rebind or reboot.
> 
> Changes since v17 [23]:

Out of sheer curiosity, what represent the number in the square brackets?

More feedback from clashiko. Requests about comments clarification
are IMHO mostly pedant and could be ignored, but AFAICS there are a
few actionable items on patches 3 and 4.

/P

