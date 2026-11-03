Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699958;
	b=o0enxGtmmgHpLKnRTh6KVbMdBC1Y5JR58dGHw83eYSDONeX4kZBo0u90iv16KDdLXBvG
	 OV3awIvFsc6uSOvXjatCerW21gCAWUjZFt++3KzWnYfPKW4AqADGvbZq83w2Ms4x58Qmg
	 ad2HSzpQ/IzKT2adK67nEr4vSVy/+ec0Dv/GMrHedD/3DIxXv7U/5DAq4wRj0yzD2yg09
	 SU/or6OXWacw81tjBEAOVzqzzhuKw4AE/A4kix71E96IWkrwXQ5HokW1mjW6i8vnep+0V
	 aTTq1rYrfS5xoaLd3bE2Z6Cqe9F8ydFdSetbvQbs99enA3KpEuq8Wuymv811tEQBLXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699958;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=N7x70kmUR6LRrCIbey3KF9PRZhEhy/XncY0tpZUm8/Q=;
	b=VKeA/ymElaHYuDA7Ui3JA7jHLdj2puLpYtSa52C/McAGvpIFQohx/W2kNT0wHA8iVAmD
	 mOlo//IMpSku9xFKnW2HxcMCzJLCHzEpgmtsl6uLL4HxjEp5V4vSeC1aQ6aM3F3q1/ZJP
	 Nm2wYAuNYG2VrxbG+T5+Uzm3aASvkeGVEx+dXLMQchiiIn5Wbom2SugDqVxGcqf0QDo2y
	 LR2xR9ajJagO80nY2x0B1+llUsyCa8lCP01c9VmFn9wVPLreg8M6y1+TdB94GWlRY5jFS
	 wEK78esovBVFmReEhsg0EJM55qGvEFwDewLEHuOztw9IokroZhS5Lyo4K4dDccqdYrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A8VFKNkK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YJPL+Ig2;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA0606D831
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDA0606D831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A8VFKNkK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YJPL+Ig2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793699957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7x70kmUR6LRrCIbey3KF9PRZhEhy/XncY0tpZUm8/Q=;
	b=A8VFKNkKakjv68A1ZCmnPv9JRgz6g9PCGOsPmyWjkO+s/4Va+C/U7qUMP98mnxNLMmKGWI
	B3muq0MDPSGSn6nMIlCIkgipWPB1vrdKRJ+sGa/PAgasVJy3A/AZdOh48RIOmgIJrkMX3n
	iSb9O0OHOmwDMnFvzzd0Qobz7vH8yr0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-U2cGDCS8PMGtdWYjjRjkpA-1; Tue, 03 Nov 2026 04:59:16 -0500
X-MC-Unique: U2cGDCS8PMGtdWYjjRjkpA-1
X-Mimecast-MFC-AGG-ID: U2cGDCS8PMGtdWYjjRjkpA_1793699955
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e011829easo2732261f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 01:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793699955; x=1794304755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7x70kmUR6LRrCIbey3KF9PRZhEhy/XncY0tpZUm8/Q=;
        b=YJPL+Ig24D+saX4XI67JhdsAREZ7yClI20AJpEgPSpV+pWM+Wy6QtqHxg2CCY4x7Nl
         5BO50EP5MERfX3UdWB4jbWdanQeEy4yRl6XQAVsAhXQEb6h0eNV5DmhtNnqhhI5Q/vGp
         5elcPvaZLKO/sdaRyoCwNlMXUKgTDZY2uqzrdotXtwZLvJD6wvKiCtOP09mrYhgZjksv
         57zqDmRxrMrjCHKhGd79eIsX0ltzKDmRasKOiMWiAt7e9y+ZbJaPaltVt+6IaQZJOCxf
         4zpu2wUM7VN3e4ijbpkFskfxNh/PlSR7sjsGLlpwwhQCDMMJHfN9/aHdEIqFINPerLc6
         TLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699955; x=1794304755;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N7x70kmUR6LRrCIbey3KF9PRZhEhy/XncY0tpZUm8/Q=;
        b=DjvJQjpgGVIi10s6Zc6ufPACYsPb4DYiA4uL0hGDbnjRFPJgJOj5VN/u9cz+FE720A
         nCLCT5vKAst0atZ0xmxOG0p6Io5VOLRnJITXBsgmpZwveh19DISKzhH9olGYg44dsswu
         FjXSDaWks07RfiuQ3ESi05ScprFG72d0HrWrOqkJaAxPfWMb8tCZJZNEpwiaM3C67l5a
         6bt5jnQppK4ZKLmhWwD0u0UrICxqlwVyuHUEYvO5EixYjHz+OSnXaYGnLlUUcrLXwZYc
         PL8iR9k37Ocx1+lD2xoWUmSal5uL0K+mCTYytRj3RIXyrCLNQjqkTCOBB5JEAjIezEwu
         0IqQ==
X-Forwarded-Encrypted: i=1; AKwUvByJ9ud9/VSj+FQnujI9FGKYJ2qP6wnG1s6PNAY1a7iybIk4QaTvh2V6dUe0OHhp4WEgbnl/JdI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bQW6L/evOn4eRDsjWbrCPkjAbCAm7oiiQNVgvjQfwRqvGAXPQ
	IuToaYvkIZGR5nZlZTNINZN2TCOIinhITKkxmvR/pPS8oJ1dOJL7qNEaha55SVxCMfwbnG9jzHO
	Rejl8dXX3WTB+nKj+dpZ73L7qcEhuzDzN/BZ2Y4KB4S+EiLfeJOt5VyOWHw==
X-Gm-Gg: AYBFou0x/gdeHE96Fc/u8bKTDTlz4pkc6znDLccPomX3BZKxz0UiRXVL/4xhUXcqxbe
	OMLKh580Uqx32HXDtSX1Z8cMMnuuHs/ZMrlfrcXSccZCHDjTEoTivK2HYstHbXcKFeZ8miZvtoC
	G90OCZ+laSR/NqQg1DX8qvjYW5gitJECr4Wu19eHfQCi6mU8q8CFQ6SFz0TprR8gcXsIS1JIBNY
	ZarnoFdkVSXQPukqr05yjjjptsFK96Qko1KDMXTWtLs86fcsyVYPcPjUUepY+9I+1I1cdqQasHS
	/HEjUpnYqjNIwjqZgy3bQyxh/iP034VFCVDn1V/+q7Fl9wYWZeA8Y1Q1FDlmzB7sa2MsybwJXHE
	+WCA8o624/+8mVg/fmFOVx32n541vw5tMnzORhdQB7F9f4e7XQ0v+G4kj/nBVfRUrmKi7vDSS1i
	8O5lzYvs7Czreoun/3Hyr4W+XIvBw7/M3hEktd1MVeVjk=
X-Received: by 2002:a05:6000:4a07:b0:48e:68d5:81a6 with SMTP id ffacd0b85a97d-48e6e4f53fbmr32114660f8f.34.1793699954830;
        Tue, 03 Nov 2026 01:59:14 -0800 (PST)
X-Received: by 2002:a05:6000:4a07:b0:48e:68d5:81a6 with SMTP id ffacd0b85a97d-48e6e4f53fbmr32114629f8f.34.1793699954418;
        Tue, 03 Nov 2026 01:59:14 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm23904456f8f.46.2026.11.03.01.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 01:59:13 -0800 (PST)
Message-ID: <585c717f-01fc-445e-802c-15b44b150ffc@redhat.com>
Date: Tue, 3 Nov 2026 10:59:12 +0100
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
Subject: Re: [PATCH net] xfrm: iptfs: fix skb leak on error in
 __input_process_payload()
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20261030083358.2653599-1-edumazet@kernel.org>
 <a555f856-0e74-4579-b35f-9e9c3ed5e8eb@redhat.com> <aum8sFQdO_kGUWxX@gauss4>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aum8sFQdO_kGUWxX@gauss4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

re-sending to the ML, I unintentionally stripped all the CC with my previous reply
@Steffen, I'm sorry for the duplicate.

On 11/3/26 11:51, Steffen Klassert wrote:
> On Tue, Nov 03, 2026 at 09:45:28AM +0100, Paolo Abeni wrote:
>> @Steffen, do you prefer to take this one via your tree? Otherwise, would you mind
>> acking it?
> 
> I have a pending pull request for the ipsec tree, my plan
> was to apply it once the PR is merged. But since the
> ipsec tree is empty after the PR is merge, I could
> also ack it if you prefer that.
The latter option is more straight-forward, I think, thanks!

Paolo

