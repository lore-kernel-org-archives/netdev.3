Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D8E43E07D
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654333; cv=none; b=Q/JGjdKZsoYwrCxoEkunpf3kgn0kL34tN7JltkGIOsos/8c4zmTYBXTXJcRt7uFlqdDaK88+jxDz+3iCwfpELgmNPfTr2Rm+BE5haEuqWroYWhgUngaAnuhG2CkKq31mI5rbWQ+7Xolb0Zme1S5H24v7UviYWU5x4Xqe++2xawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654333; c=relaxed/simple;
	bh=53B4c0DZtx8nUZtpj4yqLMGXQZfby7ftFu+nqrtj3gw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KQB4ytWh75d0j6tDbGsFP3TcbkBmieH9aZb5XIqADKH41GtrbE8772G2elpbJgR6S+S/Qse2t5HqgU5R7VrF2j87EZn5JL4xwzaq3uEQpxYegsIv6mJeCcJWKDlNjXu6ZMq+cqLV9coewTV7DtiuwKNyDOKENLUv7sBIknUs4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmFW2hwJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAWl3iki; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmFW2hwJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAWl3iki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786654325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53B4c0DZtx8nUZtpj4yqLMGXQZfby7ftFu+nqrtj3gw=;
	b=fmFW2hwJl2B4QL+STti+3fO6VVHQmCuLKFGy5eZNlfc+2nSroTiiyl5/zofbdNj/iuRPWH
	IByGlvQnXJm3F73Puwfb3NpI5JAjzfz+zuZ3Y+B7B2UpaOzOH8GRUqi89/RsrfKd7UxBUV
	cz5FueUpfca2JjlW47AAB8L+P/JZQ/g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-teetapRQPp2h0bIAGUywbg-1; Thu, 13 Aug 2026 16:52:03 -0400
X-MC-Unique: teetapRQPp2h0bIAGUywbg-1
X-Mimecast-MFC-AGG-ID: teetapRQPp2h0bIAGUywbg_1786654323
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47feac2021eso142401f8f.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786654323; x=1787259123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=53B4c0DZtx8nUZtpj4yqLMGXQZfby7ftFu+nqrtj3gw=;
        b=DAWl3ikipTgTjGudQP1M3vDk64nXgy7i73rELyBEeSysuzS2RXFkSAMfi8O68e+cgE
         Qaza7I2Iu0ALjC1qqRFuPRPBX7yDiHXvHwzjXt0nARap0mYVslhQ12Wznp36Rclxuro5
         2yttswoCs20m+GdLXpZNr98Q8HAhpXumVvcv4o6Qyh8IZA6Gx5cSZrsFd2uz7A2lrlw5
         0ok+UVE563GxCUVv07dRvGu1E/2ewsIR4/vCCnErF85D6Hd/5hHKENBlUoKHkJsevQ32
         NbiSHT3BoHIzHrF5fMZX9rAwPt3XulfjesDRrx0z2X3kbwGARPtA9WHAXu1fbgun85OM
         60TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654323; x=1787259123;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=53B4c0DZtx8nUZtpj4yqLMGXQZfby7ftFu+nqrtj3gw=;
        b=Pl+dXVgYA2HPQIwg8X8mb20TN4jZt8cdA3gcSaotqhjHPSqrlnR9txQM0ndD4N20Db
         JzRF3GhlyfJ4NXCQCSP56/+kxQqeWJRpggFm2psho50EkIHgqllWOatwb51C6fsLPajo
         CfyzkDrNdkz5HKnATDE55UFtWMlXRizEbDsgX5/1TY0OTVWRryaz5hfweTS4IwNHOJig
         DXSP6+Yc0ojqg9BCam4ISjmmVQ/k88O5cLZ9JM0T1vCT1h447ZZMYFQK2ugSF3S9E82W
         ZoLDiDMYm1xRxE5MbU1Klbl5/8Jd/TWKD8M336GZkGx/mpbkkarEsu50XBMOLMvl3s8I
         CO0A==
X-Forwarded-Encrypted: i=1; AHgh+RrtHPbngE4VicZi+eehJq2Ntar1PWWG7avCY2j0wDyurB3IXJO4Ex6kU97ktJfY1m4cJOOhqd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqefRM6sfAKt4d/Q84K/0Sy0PaXMz14S4g0ZAlFCtOms/qCRlz
	AnI2O/IRWDGQjiD1zaWFdmZfdyB++2/uD2YnxZteRp3Rg3/Hb5mlMcXamE7ywKOmnT5aQAJn84P
	m67cx58kx/MbjIz1NGA75X1L4Mk2Dp6dshQMTLZUEv7jUf5PVvqVdtb96IA==
X-Gm-Gg: AR+sD13XHFQfXsnWvDA1GFILUJj5J1EasLbHrFPtlLaz9JnZ9YSMT6FUSaXCZzRDnUX
	VOp/53OdBzl1eWR8SN6UmZCKsG+NhzC5qlNkabY38U023uJMLT2/PWHvdZDmkqLAa/Tmw+dSCfR
	3vPJCcr3veCXVuopKasi4WoCrfGx8LHNkG8/5SkOeXql9LcS7yWkiLZvAjQJ8USMawsXmlbX3DK
	54vkfzE3KTQcY69MvzE78z3ru4OuoU3Tv5AeWFC+RvgJdmR/kK7EacC3NTsd+uXfcrBj98WKEQV
	p6IWCuO71qHi6fXKX0a6VGDk/Ho/S0uW5J8J1RHXsJrGXxajNElzeltJMy+1rkOaOT2v0roVYLz
	Uhokp1wct4uMuihcGtXRa2rMjtRB11+uo/+TMt1P4
X-Received: by 2002:adf:e00c:0:10b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-481606fbc37mr986341f8f.4.1786654322644;
        Thu, 13 Aug 2026 13:52:02 -0700 (PDT)
X-Received: by 2002:adf:e00c:0:10b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-481606fbc37mr986313f8f.4.1786654322240;
        Thu, 13 Aug 2026 13:52:02 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:6a92:8980:3189:ed3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f1fff25sm3451190f8f.3.2026.08.13.13.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 13:51:57 -0700 (PDT)
Date: Thu, 13 Aug 2026 22:51:55 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
CC: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Min Li <min.li@microchip.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v7_2/3=5D_dpll=3A_zl3073x=3A_a?=
 =?US-ASCII?Q?dd_channel_ToD=2C_phase_step_and_TIE_operations?=
User-Agent: Thunderbird for Android
In-Reply-To: <72681461-21c8-4a87-ba75-d281894aea1d@linux.dev>
References: <20260811134700.1211010-1-ivecera@redhat.com> <20260811134700.1211010-3-ivecera@redhat.com> <452e52d5-c80a-498b-b12a-ab539ed9a2db@redhat.com> <add0f48e-90a2-42c4-8445-754d85072e6e@linux.dev> <00e79095-fc1c-47f5-8e7f-4e976f4954c8@redhat.com> <72681461-21c8-4a87-ba75-d281894aea1d@linux.dev>
Message-ID: <51E4CAF3-6C37-411B-8143-0BB8E6F235A3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



13=2E srpna 2026 22:38:55 SEL=C4=8C, Vadim Fedorenko <vadim=2Efedorenko@li=
nux=2Edev> napsal:
>On 12/08/2026 12:00, Ivan Vecera wrote:
>> On 8/12/26 12:04 PM, Vadim Fedorenko wrote:
>>> On 12/08/2026 07:57, Ivan Vecera wrote:
>>>> Sashiko findings=2E Replies inline=2E
>>>>=20
>>>> =C2=A0> Could a transient hardware error bring down the system here?
>>>> =C2=A0>
>>>> =C2=A0> If an I2C/SPI bus glitch causes the device to return 0xFF, th=
e SEM
>>>> =C2=A0> bit will be set and the CMD field will hit this default case=
=2E On
>>>> =C2=A0> systems with panic_on_warn, using WARN_ON for validating exte=
rnal
>>>> =C2=A0> hardware states turns recoverable bus errors into fatal kerne=
l panics=2E
>>>>=20
>>>> The SEM-first check already handles the most common bus glitch (0x00
>>>> return)=2E For 0xFF: the CMD field is only written by the driver, nev=
er
>>>> by firmware, so an unknown CMD with SEM set indicates either a bus
>>>> error or firmware misbehavior that warrants attention=2E The switch
>>>> structure with WARN_ON in the default case was requested by Vadim
>>>> in his v4 review=2E Systems that enable panic_on_warn accept this
>>>> trade-off=2E
>>>>=20
>>>> =C2=A0> Will this sleep-based polling loop destroy the timestamp's pr=
ecision?
>>>> =C2=A0>
>>>> =C2=A0> Should the postts be captured immediately after the trigger c=
ommand
>>>> =C2=A0> in zl3073x_chan_tod_ctrl() instead?
>>>>=20
>>>> The hardware latches the ToD value when it processes the command,
>>>> which completes when the semaphore clears=2E The post-timestamp must
>>>> be taken after the semaphore clears to guarantee the window contains
>>>> the actual latch event=2E Moving it before the wait would risk the
>>>> timestamp window not containing the latch moment=2E
>>>>=20
>>>> =C2=A0> Could this loop exhaust its retries and return -EBUSY prematu=
rely?
>>>> =C2=A0>
>>>> =C2=A0> The loop spins without an explicit wait [=2E=2E=2E] On fast S=
PI/I2C buses,
>>>> =C2=A0> it will execute all 20 reads in a few milliseconds
>>>>=20
>>>> Testing on I2C at both 100 kHz and 400 kHz bus speeds shows that a
>>>> single iteration of the loop body (two ToD reads, each involving a
>>>> ready-wait, command write, second ready-wait and data reads) takes
>>>> approximately 17-19 ms regardless of bus speed=2E The iteration time
>>>> is dominated by the device's internal processing, not bus transfer
>>>> time=2E With 20 retries the budget is 340-380 ms, well beyond the
>>>> 20 ms margin window=2E
>>>>=20
>>>> =C2=A0> Is it safe to use WARN_ON to validate user-controlled input?
>>>> =C2=A0>
>>>> =C2=A0> Since delta_ns originates from the clock_adjtime syscall's tx=
=2Eoffset
>>>> =C2=A0> (via the adjphase PTP callback) [=2E=2E=2E]
>>>>=20
>>>> The PTP core already validates the input via getmaxphase, which
>>>> returns NSEC_PER_SEC - 1, rejecting values with magnitude >=3D
>>>> NSEC_PER_SEC before the driver callback is invoked=2E The WARN_ON is
>>>> a defensive check for a condition that should never be reached
>>>> through normal code paths, not user input validation=2E
>>>=20
>>> AFAIR, the general rule is not to write defensive code in kernel if yo=
u know that the core has already validated inputs=2E
>>=20
>> Yes, but this low-level helper zl3073x_chan_tie_write() is called from
>> multiple places and current code-paths are OK=2E But in future, if anot=
her
>> caller will be introduced or existing code will be refactored this WARN
>> immediately detects potential bug=2E
>>=20
>> The same is also valid for WARN in zl3073x_chan_tod_ready_wait()=2E=2E=
=2E new
>> TOD command starts to be used but someone forget to update this functio=
n
>> accordingly=2E
>
>That's a little bit weak and goes against "trust internal APIs"=2E It's
>currently called from adjtime and adjphase callbacks, what do you expect
>to have in the future?
>

No idea=20
I will drop it=2E=2E=2E

Thanks,
Ivan

