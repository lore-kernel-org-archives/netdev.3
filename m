Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8BA5A79B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802697; cv=none; b=A02O+q9qrzye463ayP784C7H7CumuwJNP1HVHBKuVWDTqUayYSQ6cRuKHk71F6bEE+F+34Tvlh/S9Ak8+riQ8O0DyI7WZAdXfgfL3M9YY2tLXUDKFMvK9k9eeRVxDOjvORmnPp5aq72sQDL6XbSLP8rpfALbvqOsQpa7CoHObWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802697; c=relaxed/simple;
	bh=mYlrlJgFeVCHozLO0+MQdb2+PCAxLjm+lI3W+/LM7Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThfMXoJWdorsHb3NsQKCplanhbVAiJVPdGBWXgRWyGKgswLTnjEENPGrJY5Spx2GSx+XW8pHQhrTl6yr4sZxCblZIgkl+d8QCAqSmS43rsm6gTVaJwqfuiNSrRQbZj6BMQFpUin32JMAqoFNmGPclQgsaJhtsKgc/jnX34N391o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjglatXH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pLviPd27; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjglatXH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pLviPd27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791802694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUuiHbXQnWICSpkBTJy4/s1c90Jor1+ZUUNEm83yB2E=;
	b=JjglatXHwL98YOlDIShVy24XsdZzFqjPiKMSmi3ovUyGfg8pVR+gjQ4WSGfn3lwBhkz+rP
	Fmz/+0egecFRnR6MXVEpQuCMz5YnIMroOBUDZfbtIY2JY2NsDm5Ss3cCU5yYIYTjjVtE5Y
	dYeMogttpzDuuegSfyLRsJ/l1RZ5Uy8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-UroIo1deNUOQioglbzjdCA-1; Mon, 12 Oct 2026 10:58:13 +0000
X-MC-Unique: UroIo1deNUOQioglbzjdCA-1
X-Mimecast-MFC-AGG-ID: UroIo1deNUOQioglbzjdCA_1791802692
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a021b1b561so14110135e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791802692; x=1792407492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eUuiHbXQnWICSpkBTJy4/s1c90Jor1+ZUUNEm83yB2E=;
        b=pLviPd27qxZpTKxz9qc4sQVTr5cxB/CPL/ffFTofkH6y5srfQvcZpg/MjbhsfGkrWm
         ypOdx/JVjlCmdlMMQiriQFzy3mNEs2T+SLyrmn6Rps9Y/FwXrMhMLHo7so/9SgxshVYl
         rBv4xJd0xgVmrkrzJq+2Ws05Or5vAJtYaGroStkElJbYYBQJc6mraYNYKbMVB+RKkJSP
         dGybjNKw81UV251U1ndCAZY9BqZpmnhf0JxB/Hc4zScaSTLfTAdBkinq0JywKPID8tSm
         kdJVTH+xjbQAPFdFoORSrsxIVs1m9QvHuLHuU2t1JCv+4IGOXmnxMdx7n/d6slPp43Pq
         2hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791802692; x=1792407492;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUuiHbXQnWICSpkBTJy4/s1c90Jor1+ZUUNEm83yB2E=;
        b=GB92seB9ASxzk8bciEvNxOokiZ1CFv+SotWB+8b3CAzJAdcSM/tGoBhiCtSUU0U1hd
         56b5i8TaEk19SgM5bBS1n6hQqg7d0a9bGs5wK/zYo7DDhDLl1oZw9cgrta1Be/HiSkbS
         Wao+CtO/9VMFN5a5H4SrAjuugUfOgXeOBWJEaMz14iujXZe0PeT4S6wc3RsQfG6S7PeP
         gCg8pJHoHVEX8acZAxZutxtXieIHQklXlpSAPMmI5ICXVF+xsPVogTYkmO2Cfqm9pAkF
         vWzXVtFJcRnmNQOIVtGDRXmjWQ80U99zdy2HF6j6B89mMfPHgaBGzUSbDLwbT/S1ly6s
         sQSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJb/CAvRYrGqFsoAoib/OB3XAIApmJIbeJ1p/iceVt1tYJIVYgOdf0aEa62m4RLocRRyE+3yg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI81q9FE3MCvn4y7rfAhqqjO/WQcYN4TSu2E0XuB5mF4y6FU/+z
	YSc6olIVJrqFCRjDuOeviEVY97Mrx9gciSmnUH4C5gjbcy/16crKVJA0eP1o3KyBeafi08kEfmR
	cwwqR5EdH8eB2RXvXKqhluqwDlAIAoRuFM4FywlalrYH4Q07G6Z466bF3jLRD5VJuVQ==
X-Gm-Gg: AYBFou0G5nG1WZGZRVhnTUkIBTiC36ykVARsgfso+xTkEyEIHQYuUSPKxg8vQTGrC8D
	19dywsgvWQbDkw6/Fl3bX8HpgUjslOjwSBT2HJl99C7WtXunFh9kMBRHFDpr40Glf6D2ULFgV7n
	Iy7FjtDc6zJi2ukjkVMni7yrTWa5rV2T0897rh+YP2QSiINz9m+tYMBN3yJDJ1fMA9Dg2yKFQME
	5esEuIUr+3IC7mX/Va46e2MaO30YW3PMvuRBzP3j/Cvr6TQj31FhKNJr+c6NRpMPCNl+hXOe9lN
	lzMtarTbZy0JzcVPb2/8CZAhrHRbEkZLUmG3aI6Eg8Jq0MpUxKu8xpn6D8M7Cy85wREITkcJbu3
	E1vcgYcwI+vzvGv+f32fOOYBcmkyKw+5AhQ1iPY0BA6W15IH/+PSRcHusEGC2fbxf33bbBQgkbA
	==
X-Received: by 2002:a05:600c:630f:b0:4a1:9f59:ee7 with SMTP id 5b1f17b1804b1-4a19f5911f4mr43922035e9.0.1791802691888;
        Mon, 12 Oct 2026 03:58:11 -0700 (PDT)
X-Received: by 2002:a05:600c:630f:b0:4a1:9f59:ee7 with SMTP id 5b1f17b1804b1-4a19f5911f4mr43921625e9.0.1791802691322;
        Mon, 12 Oct 2026 03:58:11 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db94e530esm17905855f8f.13.2026.10.12.03.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 03:58:10 -0700 (PDT)
Message-ID: <a3a68d65-9eca-41ee-a70a-0db8dbb0385c@redhat.com>
Date: Mon, 12 Oct 2026 12:58:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sashiko or lore confused?
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <CAM0EoMn6JoLVHdhX1GB1wBcw3fVZ42ePKXDqsWK-4STj87vEEQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAM0EoMn6JoLVHdhX1GB1wBcw3fVZ42ePKXDqsWK-4STj87vEEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 02:00, Jamal Hadi Salim wrote:
> Some threads seem stuck somewhere in the ether for sometime now. I
> asking because i have a backlog and dont want to flood things..
> 
> 1) Sashiko nipa review is missing on the act_api duplicate-index series
> ========================================================================
> The nipa sashiko never produced a review for this series: gemini
> sahiko reviewed it ("No issues found").
> 
>    Original posting (v1, 2026-09-22):
>      https://lore.kernel.org/netdev/QDISC-K1TH.v1.20260922072206@mojatatu.com/
>        [PATCH net 1/2] net/sched: act_api: reject duplicate actions in a batch

We had a few PW outages recently, and that impacts directly clashiko. Also the
threading (new version in reply to the old one) tends to confuse PW.

> 2) What is still left on these two?
> ===================================
> (a) act_api_delete_duplicate_index_refcount_uaf (links above). After the
>      2/2 delivery glitch and the two reposts, is anything still
>      outstanding from the maintainer side, or is this only waiting on the
>      missing nipa review?

PW still did not handle the repost correctly. I think you need to send again the
patches, and please send them in a new thread!

> (b) teql_xmit_path_pre_existing_bugs -- series [PATCH net 0/2] QDISC-6HS9,
>      sent 2026-09-29. Both Sashiko providers reviewed it: gemini "No
>      issues found"; nipa one Medium (commit-message doc wording) plus a
>      pre-existing, out-of-scope item (the consumed-skb UAF, tracked
>      separately). We do not plan a respin for the doc wording. Is
>      anything else outstanding before merge?
> 
>      cover:  https://lore.kernel.org/netdev/QDISC-6HS9.v1.20260928064754@mojatatu.com/
>      1/2:    https://lore.kernel.org/netdev/QDISC-6HS9.v1.20260928064754@mojatatu.com.1/
>      2/2:    https://lore.kernel.org/netdev/QDISC-6HS9.v1.20260928064754@mojatatu.com.2/
> 
I'm unsure who set the above to changes requested. Your reply looks legit.
I reset the series to 'new' status, but we have a long backlog, I'm unsure
I'll be able to process the above before PW will archive the post. In such
a case a repost would be needed :(

/P

