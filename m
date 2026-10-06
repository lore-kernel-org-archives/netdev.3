Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB5037C0EC
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325748; cv=none; b=drPrgWN8wvZZpl2fPzVqxOdciO+dltRqx2SBmtLy4woPlbcwAuNr6B2Z5xCpKK/0uLb7eveYEZ60IGvSpuV1s2nzGE9n4Q5xxZwLZCZUxcTOGxLUQ12H8rFnSKID383sr3FxeE3axTESH4l9Cw6vVN1cK+DLNtAXag8O+psiHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325748; c=relaxed/simple;
	bh=amfp7mHyqZabhxSL/hZCN5n9bHREuWRP+w6hFtOi2yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoxDOSeV73tEL67b6dYfYmfbSmskVAxmhkAaQCgBz+Skq++Fa7ltWHdLWwm4/GVIJb//wI1h3p4I4LzKokaAiGOTkRB/cIbonyPMG5EC8srtrNQgDek+WvQW/0obv7ZBObAF3BnzORmZE/adqPuJSqOCSCMWNPFxj0qpmqbs5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Th3DAJLz; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Th3DAJLz"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93e51d8d400so66749085a.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791325746; x=1791930546;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ynWpe9m3dsCzibYX37JKm5EyweyzYWy/5JJozPHK9Mw=;
        b=Hsj9OBGxH40h19SLG8/7PvyhhxIMUH6aNIq8dQ1z75fFVvoWMuqQ1xgfNpvVceeiG/
         uDKjEU+kNL3tU2ONVaL9CNGmEYZb/pu0RwOtfPscZ47x1DQ8RjeED21oLw45ZP2Xsij7
         KesnvX7sDr07lKNoS1rbrH07BGAVmoLl5IdgL1+msdLkWDN2p4wh4HeFpCu05BkcneGQ
         eN3cTW6ASG5GOAQDKnIJ6m/VdCJ9J7UeQDGsTSFCUSj0QdwPJe+pFt21ZsNcmI5tVkwl
         4R3ZYdZc8kYKwoYExSLM5h+MEGm4jmAigM7PEocAVXo2rYks2S0iOy0PA5EvKHIgMvb/
         9lNA==
X-Forwarded-Encrypted: i=1; AKwUvBz/+FZttK5a84Qf/zVj5ZkcBDN9GYzoUqNgLtNP5nikeg2ZgOUYpoyAl3y3djZcsABw8j0hWZo=@vger.kernel.org
X-Gm-Message-State: AFuF++kPW0X7RoEM1JxpM+Cq4dfleNT5pbJr4sJurS4s08G/Qc5dLv7+
	R89w+kvUX+O+C6e6IdU1rh28d2DC/dJNRYUsK06EDifvFW5a1Awn8MdOW4+YpCqxjl4NJEq05eH
	L8uc/5LarkGQw/wFjx47VEIS5k90kA07bzD9D8LAOC5pstGJewGjDUbXr7EBWaK62ACor5/Vtuc
	gh79zltuflzTIycOOKyp9JrDEs7/FY9j5ptNBnYwUpWeADd9tCGwNYGVKsF4W38bFYB2ALakF+t
	H1UiDVD/A==
X-Gm-Gg: AYBFou0bO0F3eYrSbq5/Z/4hiFfoieuYpE7kAmjb0vEujo55a7lpbZyUGTzHuO1R4a9
	TfJJtVpCxy2+8YetCOzQ8tQm3WHJPFZ2HYnIWpJPy5pe/d9n3CRMuDMX/H0DOEu8nF82n4e3gwP
	BWvkqr0JrtbJ4XviH+PqjVll4AaPBTv1E7/FGX91TVyfBsm26mbSIzMAegpoAoiHwQ3jAPIAZtD
	3aELWOhZhA3asnE9I1yo+0Ig4z42OxyCORZUik+sl/fJLbroqS/tE3y7WXU11i7QxsxZcuAcaby
	th/wPc4OB2RgCqE37hPvW3KkbC8bkv9F4iaMnNZV0J8trIC17X7ycye0yS7V9q6lylYwwLILhqO
	W7rVaUcxOLLxSWTSLw6GjUJknUXzL7SaObzuJxMfH5/qGyRXbJf4Yn6ArOKXgmln0k7kevx9r4N
	AfgdYIDVzbYRWoKi5C28v/Ooi7XbgK56fZ/VWm
X-Received: by 2002:a05:620a:1a27:b0:93e:512c:e7f4 with SMTP id af79cd13be357-93e9b7c673emr77157385a.62.1791325745799;
        Tue, 06 Oct 2026 15:29:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93e990cbfeasm21310085a.7.2026.10.06.15.29.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 15:29:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5339253dc3fso73373661cf.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791325745; x=1791930545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ynWpe9m3dsCzibYX37JKm5EyweyzYWy/5JJozPHK9Mw=;
        b=Th3DAJLzbKpKTXjBQEniPQrxjfwx1H9J17jQ8IANuAZqAlhtGey9vBP8ZVN9jJfCfZ
         kKVmoX6x9ffKeJgn2prVKnL3GYVKzcZWaV5Op0zL5agKcLVPwjlQmsOBsGItbwwk4E/R
         BQpIsKw/PZnNMc65xO3CS980Y1csbMMZxD7/I=
X-Forwarded-Encrypted: i=1; AKwUvBxbyyGr1zZQsagehznRH8CvtjXxW4/FYc9SILEGiZZbAyruAFR/mI9vCuS9M0ne3QNiZuuea1U=@vger.kernel.org
X-Received: by 2002:ac8:7e8e:0:b0:535:70c5:d3f with SMTP id d75a77b69052e-535756b7281mr4189311cf.68.1791325745127;
        Tue, 06 Oct 2026 15:29:05 -0700 (PDT)
X-Received: by 2002:ac8:7e8e:0:b0:535:70c5:d3f with SMTP id d75a77b69052e-535756b7281mr4189081cf.68.1791325744696;
        Tue, 06 Oct 2026 15:29:04 -0700 (PDT)
Received: from [10.14.4.255] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53572202defsm6081241cf.31.2026.10.06.15.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 15:29:03 -0700 (PDT)
Message-ID: <a1dc7c80-acef-479b-ad03-dc83164d77c2@broadcom.com>
Date: Tue, 6 Oct 2026 15:29:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bcmgenet: if UMAC was suspended in SW_RESET,
 restore it to SW_RESET
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, nb@tipi-net.de,
 florian.fainelli@broadcom.com, opendmb@gmail.com
References: <20260930230634.3132729-1-justin.chen@broadcom.com>
 <179080972360.31693.266631430009737406@kernel.org>
 <20261001184130.2b7ab18a@kernel.org>
 <897ffc5a-48ad-4516-89f2-0cdac082d7a8@broadcom.com>
 <20261005182721.776af8b8@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20261005182721.776af8b8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/5/26 6:27 PM, Jakub Kicinski wrote:
> On Fri, 2 Oct 2026 09:16:15 -0700 Justin Chen wrote:
>> On 10/1/2026 6:41 PM, Jakub Kicinski wrote:
>>> On Wed, 30 Sep 2026 23:08:43 +0000 netdev-bot+sinfo@kernel.org wrote:
>>>> Hi!
>>>>
>>>> This is an automated message. This series looks like a fix, but its
>>>> commit messages seem to be missing some information:
>>>>
>>>>    - How the issue was discovered, e.g. hit in production, hit during
>>>>      development, syzbot report, manual code inspection, LLM or static
>>>>      analysis tool scan.
>>>>
>>>>    - Whether the issue was actually triggered, or is only theoretical
>>>>      (e.g. found by code inspection). If it was triggered please include
>>>>      the symptoms, like the stack trace or error messages.
>>>>
>>>>    - What hardware the change was tested on. For driver fixes please
>>>>      mention the device (and if relevant firmware version) used for
>>>>      testing, or say that the change was not tested on real hardware.
>>>>
>>>> Please do not repost the series just to address the above. Instead,
>>>> reply to this email with the missing information, so that reviewers
>>>> can take it into account. If the series needs another revision for
>>>> other reasons, please include the information in the commit messages
>>>> then.
>>>>
>>>> The evaluation is done by an LLM so it may be wrong, if you think
>>>> that is the case please reply and explain.
>>>
>>> please respond to this
>>
>> The issue was hit in production and I verified the sequence keeps the TX
>> disabled in my standalone test. I tested on an internal development
>> board with bcm77122, but should be reproducible on any genet HW that
>> supports power management.
> 
> I obviously meant that you should respond to all the fix info requests.
> Not just this one in particular.

Sorry Jakub, I am not understanding what you are asking for. I believe I 
answered the questions above? Or am I missing something else?

Thanks,
Justin
