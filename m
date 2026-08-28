Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53C3BE146
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901968; cv=none; b=uI/AU7VXut6jFJTB2PSNOEx8dn4ZkwiMfrhktS+85haQpt53ljpTKDBiOaoxFX7OJQBqeqxPgM036OzdB+r18APRUgN9BvcAy4Ts2D8WAxX8S/qkAe4hH4GnDxpU6QWeA0I2p/qeBZUzcR3o0AYao2UvNWLO/RQG4fPITD72b6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901968; c=relaxed/simple;
	bh=pjp4l55TcSvtQ0qk1M8HaIkpbfVrhCBR046DcCeU/U4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=W7ax24N8IamZJDbr3xCndeiM6ejmJbuodlTvSCTpUwUQs8Bn4Tx82rYEFmOqfbvrFAHWlUXi6ghoHW9Z/Mg9mxeaQVQs1L0lPCAg8sQfCOEi5L1DLO/U9AUdWaCTHX9IfBJJvuwbqMizPT/7zqJLfcINRMRIc9p0rYiWeUG91YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=I+SYkX0B; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="I+SYkX0B"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c255acff671so67262466b.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1787901964; x=1788506764; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/zT7X/XiN8cWELBs01ki64OmNK2wItsswFcyj5x5QOQ=;
        b=I+SYkX0BBTu0luCT2xd+fEbQw66drIePy8DC415z35QxHhV3ItAx7fWIzpUIli06GL
         euChHQtGcW1+M/8hEGGzbfOqdhGbr/wZ6Zj+igukZS0w0XZOlnXA3Kaj20S2/nImHVe1
         idfy27Wg1LXZFAOXnnsGuiOsyO9PU6JxdgfCqTyFlBCyW5BnIq5ql7JJDK6IkHzTEcF+
         Y1SbRAe2ot7BwRD747CRHxX389f+t4X6JJf5U1MyrfkZviEIy9lRX7zlA9ZgKlgQJQpr
         2GJ8cTrrbCixjbUhENtP8uWmqL/VoQp37ujMnbodA9ZEK0nIyqdRw83Nwtp2CR9vttma
         ldmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787901964; x=1788506764;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/zT7X/XiN8cWELBs01ki64OmNK2wItsswFcyj5x5QOQ=;
        b=H9yn4mj4kxxlZLlTi9UEockeQMa/uCnemR7tknp8KJkJfAHTHDy3WT/h+J/mljd1ax
         gxcrJCzC4PZ6c9OthjyOTbUhukVmI0c4YaqWNOGzJGSsZvpuUD2Cf538uhm6IWp5rYBt
         VAYKlB8uzugzIA7YWzW31mXFqebSSoXn/hc8+2bB4UcutaFruMRSLYzikx7s6dgZBVVF
         N5RZPyckELox/+lgSsIyt29Ut5uGBaNBFfwWhfe71b2rb1pxAeID8nP1T+t97TSMrF34
         n4W+NNZgi1fbpSG3tME5VJ/HL7vN3Vm8GgnNVz8+j1Xu4qF9wU8YKvx8xMtauKd0ZN+7
         UfNg==
X-Forwarded-Encrypted: i=1; AHgh+Rqa4JvmuViUtrG7MbbKbBcPvkV9w5G6mQH/CJci2EXiAsG7+FHbE92POQbM88u/il6yzJJc/J0=@vger.kernel.org
X-Gm-Message-State: AFuF++keTOsH0gfXUlUDW0eCw9dkcwvLsB+GmO1ZDz7eAl49uP0HYBir
	IQM24fbLxKoRsZy6V5fK8q3sARyC/sQclyk/XXBrqXkvDQre/W+5Sw8HrToshpARIjb3XYTlR+w
	zRoMP/480rQ==
X-Gm-Gg: AR+sD11YZTN/UpMXi1SljI+EKkWfDdouqa4yJ6iEnf2g19/lGOt/r9evVb/1eonakFP
	TmYS++/uxkVDsCnGOSH1SmiUZNzIAT9oS59zc2yleiVqbNhuVk/KDJgA8xaT0wwZFRKVk5avvcT
	9TNSXZYpt3k2CGop7yq8gs1meUzLzd/OCpXO/Q9Vo2BWPujRGkmWBHR7BRataar8RkLyjvFJfnn
	SufzUwC+hBey2dd2Pk4TTuDPYyZHPbh4ENxa4vYKPkJlIIhZCkT/VqN6fKCf5IjjkmCNjALmsJB
	b/6f5/yNoQn9GYc7tbbJYDWrw/ZftO0UYnU7VPiC5mof2GtRsowOznCaTLs8akWO1xHd5B/hUf+
	d7JMyXzIUyOS9FNHu/l8wA0rlhioHVKgoEr+lhbBmaNOnuMQyIzGJ+lKnwAAyZLTfNLqw2OvK0C
	Orkmt/kQA63IvBhEyp+eYqJ+wtNh4EoctZMGz6rw2Tp1B9dwbdL63znzLYGzdzQc83hxa+iJ4wA
	n6AKx6fPEMAUJbRR5hh2rrrqCY6PiyH8A==
X-Received: by 2002:a17:907:c08c:b0:c1c:3b06:ed03 with SMTP id a640c23a62f3a-c2557423bfemr308843566b.23.1787901964423;
        Fri, 28 Aug 2026 00:26:04 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee09f4dsm50367266b.6.2026.08.28.00.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 00:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 09:26:03 +0200
Message-Id: <DL0ECN3CA1GR.3P0BIK580UYDV@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Kristian Brox" <isyourbrainfoss@proton.me>, "Luca Weiss"
 <luca.weiss@fairphone.com>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "David Heidelberg" <david@ixit.cz>,
 <oe-linux-nfc@lists.linux.dev>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] nfc: st-nci: Fairphone 5 NFC bring-up (ST21NFCD)
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f44d04@proton.me>
 <DKUIKHDS44LA.10CHEGZHLQSNS@fairphone.com>
 <20260823194152.501107-1-isyourbrainfoss@proton.me>
In-Reply-To: <20260823194152.501107-1-isyourbrainfoss@proton.me>

Hi Kristian,

On Sun Aug 23, 2026 at 9:42 PM CEST, Kristian Brox wrote:
> Hi Luca,
>
> On Fri, Aug 21, 2026 at 11:28:22 +0200, Luca Weiss wrote:
>> Can you please confirm how you tested this on your side, and if I'm
>> maybe missing some parts?
>
> Cover letter tests were postmarketOS, these changes as modules on
> 7.1.2: nfctool -d nfc0 -1 -p on an NTAG 215, then neard for NDEF.
> No extra firmware or userspace on top of the three patches.
>
> That 7.1.2 dmesg already had
>
>   nci_ntf_packet: unsupported ntf opcode 0xf02
>
> I treated a found tag as enough and did not mention it. I have a
> driver change so that NTF is handled; I'll send it in v4. The ndlc:
> dumps are debug prints.
>
> I also ran nfctool -d nfc0 -1 -p on a locally built 7.2.0 kernel
> (sc7280-mainline, with that handler): no 0xf02 line, a Type 2 tag
> in about 0.13 s, and Ctrl-C with no tag still left Powered: Yes.
>
> I have not reproduced an error after Ctrl-C with nfctool on that
> kernel. If you have the nfctool and dmesg lines from the second
> start, that would help.

I tried again a bit more yesterday and saw the same behavior. For a few
tag scans it appears fine (apart from the bunch of errors in dmesg), but
after playing around more, I again got the NFC stack into a state where
no further tag scans were possible.

I've scanned both a standard r/w NFC tag (ISO 14443-3A, NXP - NTAG216),
and sometimes my Android phone, which also got recognized as tag.

Looking forward to testing v4.

Regards
Luca

>
> Regards
> Kristian

