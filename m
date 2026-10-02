Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84824E3259
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957782; cv=none; b=mAE42TniJKSPoK2cRIJtUU8DrodM+63lcPBKSN4N4SbY+f0a1f8dboH+MPz0AVjeqIZEHY8ABkdt6qO4ldAm3JLS97+QsyOi8dgFp6KwEm1dMMV4zdDQsIqQ+Eb1C3ewhf/11ezFP3kOrAl3c6WrMLXSmt70oKF4s4mpm49mZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957782; c=relaxed/simple;
	bh=6nGKnyBrzzJL9LigkABHfP7kULW7RYBcQouHxJie/c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7jrPCGz8xWtztHBWZTJ5KnxoRfMOThUT3KfgZNj0EWUcpudBsv5fFwTyB3Vrkk2y8I7vOlNSUf2CcC13oAbDQPOA8YN+ZqOZ/qx6MQOLXFicY8SDcxrUfcMfn+YoAyojN1K2L2kRcjUb7wrQ18hDe+2Ze6aygMIqg+1ASJmE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d508VeH0; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d508VeH0"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3a706146559so17224a91.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 09:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957780; x=1791562580;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fbFbwJWSRdXCauruDvE+JJbqjrPsHa6vNYR+DZY726g=;
        b=uRkebFdgF1Sw5vuwAygShD+g+sumDM9k57EZmH46uIhbyR3Vgp2tmh4pcZYlYintm0
         ETTZxbH52fNhFtAh1fg+eFxKohI7bOqrm/O2ijXL6N1rKd4VuobdshHI3kmz3wWe3L51
         A5Sjz6Z4StOZayU+feH3GDk+WDCfZQbLN74hLFLC4ecj9E0JsLz/0X6R5crn2PGUB0Xn
         gPOsNV1u2m9kriOoS535pttW4biitK9QS6RpVt465pSOdaCybX4LDggZSuGre/ark17N
         H0h60Al2Rt4d6krVGGHvdKmWSQLPHzU6FhsBtakOpza+6dwM3HPWWHSI9fbgqtfSKMuM
         SHIA==
X-Gm-Message-State: AFq9FYJTz2jQg7KrZdivi8ol+4FCl6OFV2TVGcZDH/dKhbvrMap155Pm
	2Ro0m+E+98thiCNRnEa1xuCdxPS/c8qG5DzqAwSVc05PrgO4YibW2c1GmFpy41YJySQ5pSOUXa0
	OyXrmp5l7i0X221xHaraq1S3Dq8NTBJuMpGavoCQfDZMeftQ2qsUwH5vbV/qa/EtBCWGZ3YwfzY
	O2UNtaqUmc5ElPjUt0NEh3XMJlPCjQz4R+r8AmMZPZ6mqv2epkXp4lQu4QtzCLXK5Knbq6aZOmR
	iY2FPw9bQ==
X-Gm-Gg: AYBFou0A0yRdpmjn7m2kxahR8TOCcIST/b2qw7MYJ1OfTaovkIto042cJgG8d5vKjSH
	J3772k4ed3EAwej/mFYw5y0szSX8UR0zgA/8IwZ1PlAgJ0ds8w4Npu4kwMuE5ItGNuFVUX7XN4k
	C3AupOc/SMpygk0lxWo1bM0/IYd/DeEIy+cKqTdjLxQBY6pnMKQK6h9OUVWiL8R8MMEwd4vI1GS
	Jhuy3eo1UksEU1gUKL45wkKVmCyhaEl+TejT8a4jh22vUqByrWN6zMIkb7GThnxJItbDzskht1j
	xGZ6PArByKn0TP8EZ2YN8FKdRzlypcYGOFOEqEFVtDb1BftZuOEfz7OpN23Y4jx/OajmR+9qLgN
	p//qJNelVmVPoJVpIeiscREGZ8BXceb6ew50TboDpYAUFoeqRs17ycPGtoynwHyITysUZTCHPC8
	M9NHnHBtikn2oMznoPtFhnKj+E7uGynEsiveJd
X-Received: by 2002:a17:90b:1cce:b0:3a4:c946:9f4e with SMTP id 98e67ed59e1d1-3a6ce9833f3mr2937610a91.58.1790957779988;
        Fri, 02 Oct 2026 09:16:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a6fec001dbsm594956a91.4.2026.10.02.09.16.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2026 09:16:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-675d5613a31so220696d50.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790957779; x=1791562579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fbFbwJWSRdXCauruDvE+JJbqjrPsHa6vNYR+DZY726g=;
        b=d508VeH08crBsFeJcM/vkxX50pCfQMD5mbU2Rv6qOTH3pnVYxDobdqtvF1vtjZ5mwe
         ZmmHGZRQt9pb4u8XUxeTQLl3tXAC6cvjcW2SlcQSNnu7bKAYOL6AM0Fw6O+UOY05Rwhn
         +ein8SM/T7wFQxSQmampf1Ocb/vQvLZbr7KtI=
X-Received: by 2002:a05:690e:4cc:b0:675:43e1:45a1 with SMTP id 956f58d0204a3-677abdeef34mr808522d50.4.1790957778452;
        Fri, 02 Oct 2026 09:16:18 -0700 (PDT)
X-Received: by 2002:a05:690e:4cc:b0:675:43e1:45a1 with SMTP id 956f58d0204a3-677abdeef34mr808507d50.4.1790957777854;
        Fri, 02 Oct 2026 09:16:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:3f50:2990:5d86:62f0:dca0:5297? ([2600:1700:3f50:2990:5d86:62f0:dca0:5297])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677ac56dac6sm1135050d50.9.2026.10.02.09.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 09:16:17 -0700 (PDT)
Message-ID: <897ffc5a-48ad-4516-89f2-0cdac082d7a8@broadcom.com>
Date: Fri, 2 Oct 2026 09:16:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bcmgenet: if UMAC was suspended in SW_RESET,
 restore it to SW_RESET
To: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@kernel.org,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, nb@tipi-net.de,
 florian.fainelli@broadcom.com, opendmb@gmail.com
References: <20260930230634.3132729-1-justin.chen@broadcom.com>
 <179080972360.31693.266631430009737406@kernel.org>
 <20261001184130.2b7ab18a@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20261001184130.2b7ab18a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/1/2026 6:41 PM, Jakub Kicinski wrote:
> On Wed, 30 Sep 2026 23:08:43 +0000 netdev-bot+sinfo@kernel.org wrote:
>> Hi!
>>
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>   - How the issue was discovered, e.g. hit in production, hit during
>>     development, syzbot report, manual code inspection, LLM or static
>>     analysis tool scan.
>>
>>   - Whether the issue was actually triggered, or is only theoretical
>>     (e.g. found by code inspection). If it was triggered please include
>>     the symptoms, like the stack trace or error messages.
>>
>>   - What hardware the change was tested on. For driver fixes please
>>     mention the device (and if relevant firmware version) used for
>>     testing, or say that the change was not tested on real hardware.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.
>>
>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
> 
> please respond to this

The issue was hit in production and I verified the sequence keeps the TX 
disabled in my standalone test. I tested on an internal development 
board with bcm77122, but should be reproducible on any genet HW that 
supports power management.

Thanks,
Justin
