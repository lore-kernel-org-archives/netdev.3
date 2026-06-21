Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D0238D52
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078684; cv=none; b=WUqrQd1Y1hZeAc+EMyyfVF7GGUi5PuG1GzocjqkXdJhYyIcE0qE7QJi2vG+UGFp/Raz/WBOPLES0yHjuZ0riHU0tozy0uwvsK4BShyl5ENFWn6D0u3/jkZHuBxKtMKcad0mqITIPrMXsF1FaxdRTXsa5ckOPzNzAqUswsFK9QHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078684; c=relaxed/simple;
	bh=6OFKaSFLclUwL5ixAOaGwu8QFfO/iSzqtIXdme8HfRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEABm014NXlehmdd9m8ycePkYhjzfoRU4TLET3zjy8iSMaklz+rPlq5k91VeufoTFP50MIh3aLNcXxNAzHKj4I1iSoNSvLZwGu470zYd/qKYf+1tUR3o1uIP5MjRQBCbglm1T7QuURdKgVcUILfsMk9FLh//3CCFQOa2ylKmvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwrEwe52; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwrEwe52"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cdae130cso17472795e9.0
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 14:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782078681; x=1782683481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQboYmdic1MZl2Wtn9ljsRej2sgjbirOSXK970xn+xI=;
        b=FwrEwe5231nHGTr1VuH1pPB6wAlW5nCTRMZMxg57uROgcTgvvzDa5Q2Z94gBDpgKvi
         z1cmol/iNKwwGiDKCF9jMxlVZs7isvTCvCpMwjFPgX4s/6kqPpXHlSEIALSIgPy1Opxn
         rveG/T8l7Mh68FBJGaY5cIJzRi522x00M/c0zlgMcwWevsmPgZhQYafsqXZzC+BXTOJw
         hrFkfnfdgJCsmRO0urEODR6aoBvTINznsq2amUH/I1nlLGrmS1onNmivfZnfBIs84AG9
         HLy3A9BGfB+LsdJH2ESFSk6rixZ6kQXcNtBjPp7LgFLAWq7zSl8a4T9NStx5JwoXXP8z
         OYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782078681; x=1782683481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQboYmdic1MZl2Wtn9ljsRej2sgjbirOSXK970xn+xI=;
        b=hFU3sr/m/twpHWWhUU09IkRoWEGn1WJF35sSkXLKMhiEzk0bcmeSeWIdnrSKSxTR06
         ofRFdcVLy96TLQMu1fk4DJRVbL5ExoA2DGl7bglLt7wvtl+/j1I7BxlmgI4DQ15V6WLN
         xcXcIHFIHzaHG++3RYiMWgkFYVTXUReIaE74sMWi0VZSExXqiRfOijNlYTjDGLK9MLJx
         056yl4uYGZ0Ud3I0k2v/8BIFMgTwIK6M4SdKwzzcvO8n3eB2KKmI3K9iqxEXD662PspZ
         OYtvPVzsLSbKiv58KOdIMNzPWmscfqflNCw/ONDiTLF04KETVd5e11Rq+H/ajciQ3/nh
         kE6A==
X-Gm-Message-State: AOJu0YxBtuRZHn52KSegVf6FciS2rIVvs7+6LM4+d/+1ju0Uh8oVjnNa
	2Mfk1MKt/3DmrtiboPyKC6md3JpTQEi3hdmjxlcuTlGjDD2XaiCBs9gS
X-Gm-Gg: AfdE7cmejFyVdZSfpFOzQJ+gJruxxYGSfvPQ+XUnwFzsZfi7wC7+Ic+g3NjS+EKc+jc
	GYjuXlRuXvTtVqVmCb4o1l9VAV5Pc9wHqFjAXTkrFbT4ay08I1sU0i2/bbhOzg/mlNxarqqY9X8
	DuhY+371FYtRrTVAc3G4AN2f+RUIq1MSh7HksfcER0W27CGoKE/iPMmlngUNeZFFqsfUJLpS/MG
	65fwkDCnck+e7bPMHOUD441U/yRtDTAoxBoJWWPqjSEXxraWYMT0cFCXfqw9COFEqRgtdowZObV
	mm5mfTC3/wfZz8usHEyUKiLIJH7zQtil5eCr8GYsZvvrp0Inq5VBSU3to53Bjy3fNkZLS/fP930
	hF5HvTnNS5TxglIS7FILGUbUnKmPK0AOZZFge5AJzSn1mEOZX89F9TxjeGm6VEThUIsyuDM8+qP
	2PnvwEUcAjmIvrKy6DX6m1Jsd4ln+gOuY1WyOoy9b9wmSLy195Nib0pzc=
X-Received: by 2002:a05:600c:83cd:b0:492:43d2:9e6e with SMTP id 5b1f17b1804b1-49243d29f5amr158027145e9.9.1782078681544;
        Sun, 21 Jun 2026 14:51:21 -0700 (PDT)
Received: from ?IPV6:2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4? ([2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240084928sm254327585e9.15.2026.06.21.14.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 14:51:21 -0700 (PDT)
Message-ID: <6ad62420-ba7d-4ea2-9e4a-fcda703fb647@gmail.com>
Date: Sun, 21 Jun 2026 22:51:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "ip help" output is an error
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
 <20260621082105.1196ef72@phoenix.local>
Content-Language: en-US
From: Dmitri Seletski <drjoms@gmail.com>
In-Reply-To: <20260621082105.1196ef72@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I never done C or github submit before, I hope I did it right way.

Regards

Dmitri Seletski

On 6/21/26 16:21, Stephen Hemminger wrote:
> On Sat, 20 Jun 2026 10:36:31 +0100
> Dmitri Seletski <drjoms@gmail.com> wrote:
>
>> Hello iproute2 maintainers,
>>
>> I am reporting an inconsistency regarding the exit status of the ip help
>> command.
>>
>> Current Behavior:
>> When running ip help, the command prints the help documentation to
>> stdout, but exits with a non-zero status (error). This causes issues in
>> shell scripts that rely on exit codes for control flow.
>>
>> Steps to reproduce:
>> bash
>>
>> # This returns "FAIL" because the exit code is non-zero
>> if ip help > /dev/null; then
>>       echo "SUCCESS"
>> else
>>       echo "FAIL"
>> fi
>>
>> Expected Behavior:
>> Since the command successfully performs the requested task (displaying
>> help information) and does not encounter a system error, it should
>> return an exit code of 0.
>>
>> Context:
>> This behavior breaks standard Bash logic for automation. For example:
>> ip help && echo "This will not execute"
>>
>> "ip help |grep br" - this will bring no result.
>>
>> Current version tested: iproute2-6.19.0
>>
>> Thank you for your time and for maintaining this tool.
>>
>> Regards,
>> Dmitri Seletski
>>
>>
> Yes iproute2 doesn't do a great job of handling error codes
> with usage vs help. Its a bug and no one has bothered to fix it.
