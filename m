Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8574D6C57
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646897; cv=none; b=JbhUhUASvyFAgUkJvM3PAq2EFh8k+44VdN/zTW7HG3SjgKeEwgJbK4f9d/Crn+ACjwO59rGjTlaTZOX52C/JflGLWbPNnlKrXHk4t6XMYXeTeKO8kW56rX8n32BRYTu2NdbcH0IOS3MXvtf49C56t2lip6Cu+1Pald94/cYZRCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646897; c=relaxed/simple;
	bh=qGEEwGPLJZyTx9/fJ99JJxZZqNqLvVtpP+tTRW/DsX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDTvCnWNQidTqPmZyYhDWHZNxliRHO4skSXiZMikSmP8IM/i/AWGAElSlZerO7lEcu33L2i2WhRwfsZAwSsu9mKsmEH1DlhudDDcJNgntXBlOMKSEaawZeCrRn0K8thh+xLbB5zZLAA8wFv23QkG5N5XwIO8a+9rxOT3iaadHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EauUUTBn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ipj2Ybuf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EauUUTBn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ipj2Ybuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789646880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zYSbCs0dChsICRMByZbNTA3bHhmkFa+zStPmUptq2c=;
	b=EauUUTBn44hNi/LHdWhLjOc7PaT46V7F5pCAhfBNgwmw/IJm04YVELJ0jOfgelkWaiUMw+
	O1roEtigdDDBmW4NeV8OPBAo2vg2ELGkXufO7U4Ck7wcG+BxeVlSouITiaiuSBeaseNrzK
	ZdSEY4SQggVtSBnmqCmrGQVA4Bof5iU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-D_4-nOYtOL215nb084QDXQ-1; Thu, 17 Sep 2026 08:07:59 -0400
X-MC-Unique: D_4-nOYtOL215nb084QDXQ-1
X-Mimecast-MFC-AGG-ID: D_4-nOYtOL215nb084QDXQ_1789646878
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e735659b7so5962575e9.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789646878; x=1790251678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zYSbCs0dChsICRMByZbNTA3bHhmkFa+zStPmUptq2c=;
        b=Ipj2YbufbpYeje5gOy4kugDcqzh5jXVZw5pc9fe1Ym3aBM0r2kwbkuaeCt/K9pwhT3
         MT871EwI/ngKfzchZecX8CYib2mFrwC0SaVSNyK/T92bHAzqI0WnGgtQhUf0pHlVDvsO
         VRNaXN96VV4vs9OY0On5vOBvBYy821W6ucppUqvs5/ICU9p/uecNnvyIsItt3U8q2plC
         ksX6h4woji3LYBDOW6zjQU4B11y1H2Jlq/rvpZ+SAic+qzpuA2K5q8paNcXMpJHBlJBZ
         KUpAOU6e03INqfT2nJHbWajPUzufFs+SeOnreIiFpjsVjC9XKDpm1bHVTstzHxQRU8tw
         WW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789646878; x=1790251678;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zYSbCs0dChsICRMByZbNTA3bHhmkFa+zStPmUptq2c=;
        b=JC9VDru0pP27j/kgUFKPwAdw6SXeWYqSz8ce72aBuI52bapdbDmgLYGpqTdujoK6v7
         eLY6NBrr4CtMd57mVW6jjapg3vQdKfEXngAOFNRzi6xDZ3b7IDH4o6rTHq7PvWKBKVaC
         1Nh1gHROCm87NGPwaLVU2uMT1hIikLUa6s7SCF2DO2ng/prgLppTNzgVjudrToGIrhn6
         rmSLri4Eh+Z18PKvgcTtfVQO71aUeMskn0G6tAP0Au7lMq2gghUGgZ/wgHXThFJewAqH
         1j3ZNMq+oI4p8nPoH9TH93lA8as+R3BMOXDZ5neoxmLnqe4JMBfqsahPOapH3HhwGnaL
         ezjQ==
X-Forwarded-Encrypted: i=1; AKwUvBweYvMp+yVqtsTnjnNil5GIBH9D8D8uF4OTcmSQZQvIiUxBzTHZf1Qw2RAaUNuBen9zTFR5eSY=@vger.kernel.org
X-Gm-Message-State: AFuF++lLSHv+hCdGliEaT5JG1bsfr7E7q9SYZzCF1dHHnudiTn6s4WDr
	0AAa50zsVM0FB6WlN1W4lSyZXteBhqo4nL6LkRFFoYAR90iND/kPwb1NX7cZ06wRC47xJ0J/w2d
	K2xLpmQ3nokIPu3UTAQ0CLq+E3uzhwxMEARefhYHwa8JjhF7Xox6cKdCUgA==
X-Gm-Gg: AYBFou0cjJhtSGH/Vug4/pWVMXkWYrlY7mhfpD7p73f5n0DE9HXcUzNUJzRN/CZle7h
	PUm+IiEo0mRkbV450IhYrP8BVlOymTscEUyF8BJ5ypF0UNEzRb7aA/Szt6QWJoVk1aoug2RtfQ7
	4G/+3yByBYINk0CSmHhqGDdFXPNwxw48ydVKLWREwYnv3D7Asm4UqRli8Dxbfk2I5VBphfU4zqY
	zBclB3IeZOsZFcm3vd3tin1WzR5+0zqYR1cZfT4E1UBrrs/FhLj9L0JZsW/swtLQzLiZAcTOFst
	IrKqdwQQO2gRJjsckfeifmMTt+p9xjaP9pp7uH6/UzBGnm08OxTW5/lPKVIA1EWrPAjl+fsXIew
	TL9mciPC6ScjRfShQkrRzOrJTSeUS3XJL8zLle7rEgExvZ6LLx/god7reg+jrrT2kOLiDgEU8KA
	==
X-Received: by 2002:a05:600c:4691:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49eb733cb1amr79199955e9.25.1789646877647;
        Thu, 17 Sep 2026 05:07:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4691:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49eb733cb1amr79199445e9.25.1789646877231;
        Thu, 17 Sep 2026 05:07:57 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd226ef3sm71394955e9.1.2026.09.17.05.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:07:56 -0700 (PDT)
Message-ID: <c308f5b2-05bd-470e-bc60-bdf7038b8b65@redhat.com>
Date: Thu, 17 Sep 2026 14:07:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ch9200: return error on failed register writes in
 ch9200_bind()
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>, netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org
References: <20260914202503.52920-1-s.shtylyov@auroraos.dev>
 <178951445003.22033.8083675025384414442@kernel.org>
 <9fad10fc-dcd9-437e-b422-018638524632@auroraos.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9fad10fc-dcd9-437e-b422-018638524632@auroraos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/26 18:58, Sergey Shtylyov wrote:
> On 9/16/26 2:20 AM, netdev-bot+sashiko@kernel.org wrote:
> 
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider:
>>
>> Critical: 0 · High: 1 · Medium: 0 · Low: 0
>>
>> - [High] Ineffective fix: the six newly added `if (retval < 0) return
>>    retval;` checks in ch9200_bind() (drivers/net/usb/ch9200.c) cannot…
>>
>> --
>>
>> ch9200: return error on failed register writes in ch9200_bind()
>>
>> The patch adds error checks after the six control_write() calls in
>> ch9200_bind() so that a failed vendor register write aborts the bind
>> instead of being ignored.  It carries a Fixes tag for the original driver
>> commit 4a476bd6d1d9.
>>
>>> diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
>>> index a206ffa76f1b9..ab3cd3902ed72 100644
>>> --- a/drivers/net/usb/ch9200.c
>>> +++ b/drivers/net/usb/ch9200.c
>>> @@ -360,32 +360,44 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
>>>        data[1] = 0x0F;
>>>        retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
>>>                               0x02, CONTROL_TIMEOUT_MS);
>>> +     if (retval < 0)
>>> +             return retval;
>>
>> [Severity: High]
> 
>     But why? 8-)
> 
>> Can these new checks ever observe a failed register write?  control_write()
>> in the same file discards the USB transfer status on its normal path:
> 
>     By "failed register write" I meant any error in control_write(), including
> kmemdup() failure (which precludes the USB request from being sent at all)...
> 
>> drivers/net/usb/ch9200.c:control_write() {
>>          ...
>>          err = usb_control_msg(dev->udev,
>>                                usb_sndctrlpipe(dev->udev, 0),
>>                                request, request_type, value, index, buf, size,
>>                                timeout);
>>          if (err >= 0 && err < size)
>>                  err = -EINVAL;
>>          kfree(buf);
>>
>>          return 0;
>>
>> err_out:
>>          return err;
>> }
>>
>> The only return err; is at err_out:, which is reached solely from the
>> kmemdup() -ENOMEM branch.  All six patched call sites pass a non-NULL
>> 2-byte data buffer, so the only negative value the new checks can see is
>> -ENOMEM from that allocation.
> 
>     I kinda noticed. :-)
> 
> [...]
> 
>> The sibling helper control_read() already returns err on its normal path,
>> and ch9200_mdio_read() checks it with if (ret < 0), so the convention
>> control_write() is expected to follow already exists in this file.
> 
>     And I'm extending it to control_write(), but in another patch...
> 
>> Would it make more sense to change control_write() to return err after
>> kfree(buf) instead of (or in addition to) adding the caller-side checks?
>> As it stands the commit message claim that this makes the driver "bail out
>> of ch9200_bind() on failed writes" does not seem to hold for actual
>> transfer failures.
> 
>     I'm getting bored...
>     If any *human* maintainer insists that I merge the 2 patches, I surely
> will... Or maybe I should resubmit both against net.git (net-next.git?) as
> a series?
IMHO the patches are so strictly interconnected that should land into 
the same (net-next) series. No fixes tags in net-next patches.

Thanks,

Paolo

