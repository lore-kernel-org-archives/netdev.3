Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B246390237
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329650; cv=none; b=DD/o/k6YFhzcgQX5Cl006Gq0Upx/gdln1CUzgOCnQc/1GSh5Hi23Gie/ui8HCCbZdgOEghX910Ma9WUorNNgZpHoGx1ZZcMRvlJrwrowwEC0kISsOoWjzUVu8Q0vDbB7mPt6GGdj3n7cSPY1f1jptYpYVdGTg9iMLLL4lUIm5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329650; c=relaxed/simple;
	bh=sm4I2Hl31H5nGMke3e3KSHNQ15vNEndFW2uafYVYfZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEl63CDMgW2wwTtMXncQNlajCAXEwJJvIXMlSUIXhwwCQxbFduiTI0Q8ilPsI5Tiva2pCuHZhEU87RqCo8aPDW3rOnJZbNglplgXkY6kIePRsSvU1yWICWX+UG76Oc1p6x/vxs5oHeHMdup8sKDyc+Jzxc1kYq/SDcQiAUGUMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qqq6QXNf; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qqq6QXNf"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-6790844c9b0so416386d50.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791329648; x=1791934448;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=F2DmhUISdKQAbFXD5qkjWmPX30Bizg+0d4WlbJukxn0=;
        b=btkj/jnSNAdyaiEsyvBsd8hbTe6he5urbYAl6CZRFrW76lSSpJNeUnN868mjDn9+Lb
         3xrEhu63gjh6djacbY+gmKPuGLdlwTjB3+vd3fEg8km0Hvo7gzwub2QSvxDoAS2rOQyY
         EFQj0hfWqV+iRRNsLgpFjz8mLj+haEAfxYXWkXneENsPSZb15pE41rO4X+l7SG/UBnZ8
         Q5Lp6SVqB7od8x6EQmx31FlZyIzcQaecxbAcRQp1pkfLbV9M3OjxNDM5DSwcsW9YO/K2
         mLB8V29xbKNOhNAw0sH7TDr4/A0EGS+Iwk9ULiHeXYRF7E+Ojkg/t+nWN9201ggy53Kd
         ldTA==
X-Gm-Message-State: AFq9FYIcmqk4qInu9qS3rnkdBIt3jkIgqUA5qHd0nMN2Z3fMBbIoB1x2
	eWb8sShYEM1hAvmyp4fOGbXIbd8kLHCiGc6pDc1UnQQDMvUou7se3W1njRVeyHoc+f/63HkTqHS
	TVtxrYzOiTK4DBTu6F0GXsEZ0eZajX1WJxGHn+qCTWq4SkpaOb3+5TcQuoAqU/YrpzhIWh4+Y24
	pxpPi5jv7EQ2tYkf1dmlTjPthdb0IEf3nbW7vnUoRW3FeG3FE/uI3O2nFMmU7ekggFwoVc25gW2
	siN8o/yZw==
X-Gm-Gg: AYBFou0JgfXbYyvq43RZKLadgLi8JPp0ndJi89oHjgvtH5zkwuzXNh/T+EfYb1Q54ge
	q4JfcNHfr5ukkUN+HograYZCR8XoY8dH/Q5Uh0hlNUJ5ga0GoAWqVJKUNuByv0RlKs6VeXN1usw
	23nxwFSBapL20vXcdrZ1Smb29FaJ3CjD0oUrK8Ljp0u337KloSuTdbFwr/x82BYqHMRIpdremxS
	rJsjyyCpZ6d/XAno7fmxI/4fJ+l3ocbxzKZ+h5WZ62TygUG4g0tBM2AnRvVV/wBj9YgMJGmLqWH
	+iy/PZrhoRIHjUsQiFpddkidrUw8cZUfsBtndM8IQXv+1eAXj34w5Eztk52IqXpXgwhMe0XDpFg
	9IRZhilI+K82l04uBEIKXpP65MZEZlTaJg6NAXY5JfXKACksqvLdFoch/HwqYkVIlJBATRriDth
	zcXMMz0iP/NLVvfkhO/18P6r8oUSUKjBVYLOUt
X-Received: by 2002:a05:690e:d42:b0:675:3dfb:4181 with SMTP id 956f58d0204a3-6790a2a4f29mr449772d50.100.1791329647437;
        Tue, 06 Oct 2026 16:34:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-679099d2dc1sm70448d50.39.2026.10.06.16.34.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:34:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917b8fe34afso59949526d6.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791329647; x=1791934447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2DmhUISdKQAbFXD5qkjWmPX30Bizg+0d4WlbJukxn0=;
        b=Qqq6QXNfW2CdZikzLaJAbqodizDesX7aupyeW4HjjPf8PgAR8i+akJiQv6pbA1Kqar
         mNqZOgsODnqvC44CNhVy5Vg9MHT1zlHjGraTxV5bmVYw3xjbA62p5Ienp8zlRBMmrbyV
         JpW9c2J3nN9GBU0GMkwjzVl60XfhZenSr1UNE=
X-Received: by 2002:ad4:5f0b:0:b0:914:15ce:ed88 with SMTP id 6a1803df08f44-919976b94a1mr12113306d6.3.1791329646704;
        Tue, 06 Oct 2026 16:34:06 -0700 (PDT)
X-Received: by 2002:ad4:5f0b:0:b0:914:15ce:ed88 with SMTP id 6a1803df08f44-919976b94a1mr12112986d6.3.1791329646310;
        Tue, 06 Oct 2026 16:34:06 -0700 (PDT)
Received: from [10.14.4.255] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996a40d41sm6427016d6.0.2026.10.06.16.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:34:05 -0700 (PDT)
Message-ID: <ae618d7b-02b8-4726-83ee-dba015dbff34@broadcom.com>
Date: Tue, 6 Oct 2026 16:34:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bcmasp: fix lost TX wakeup race with lockless
 queue API
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com,
 nb@tipi-net.de
References: <20260929203400.1588868-1-justin.chen@broadcom.com>
 <179071435534.31693.12141825512351760557@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <179071435534.31693.12141825512351760557@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/29/26 1:39 PM, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Apologies for ignoring these. Just found out they were landing in my 
spam box...

This issue was discovered using LLM and is only theoretical. I tested on 
a BCM74110 that no regressions were encountered.

Thanks,
Justin
