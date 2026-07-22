Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519342DA4D
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751109; cv=none; b=nhWxSCFO3qdjKlZ6jPpai0DbR8avY0wxTQhOlXFaBU+zHUw1cwQCINaBvJTKANqaJq89jRu+GS1Hupnkx9hefOKf4ppezGdwLJRzZVXAvh1qGJWlu6FI9Up42//HiBw2UyPP3JPXimPVZdY9LajZ4MDhimWeOCKZSlYwzcyT244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751109; c=relaxed/simple;
	bh=to1qsBweEh9TsWu0DT+PyBTBcOAdZYUU23MhU95EDlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqpLDqqZ+I/I5LJI0h3P0Xg44elsSHfa6GUchOTiOL45VU4E5gLGJ9AqbN8eyNmGdnDmTUfYY6X5lO6HngKNaUTJ8rDyO1wlJGdiICnDRKNWFbb1wgs9H+JNQXibJTHk+j4MaGqsDu+KArTudz3aPZRYdSrQ7q7VRLodTUbUUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIXdQvQp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIXdQvQp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-472326ca506so9961430f8f.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784751107; x=1785355907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MwdcQPS90h/Tl/R38NZKhd3nVQaFTUyvpFn8BQXWGrA=;
        b=AIXdQvQp/wH08ZAHcdpXtxtCnIlDDAwMOs0aqd5MGd2il5ON1sl1kgcB2U6L40k/rh
         B7c9kwwcxNRl4TtA6zzPdIoUWdPpPwtU3GNfQ+JJwZGwXaPRuFy+RmlnepbIK9CC55u6
         ebvREHedkcXTEmbU05RF18YLoWWloLjfeOwdPAWIJfSSqbeiZaJLdj6klv1NRdpz4khm
         704H4Q7JsCoVVQnu+bQ2F1c85Ig/hd60xA+gsSdOnIMWBfCZojjTr09S69EPbR95nMi0
         lW4gFXXQT/SrHMWaBMcB66r5srlfjx16rs8Lnu/PWRWxSogEgnONXRLBsd/QdH6ZB1F7
         gZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784751107; x=1785355907;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwdcQPS90h/Tl/R38NZKhd3nVQaFTUyvpFn8BQXWGrA=;
        b=LztTyAjmD7Ew2LGKLuiNsJthOTTKefT90Ko3//myF8KC3GWDBd2YwMUom/2OEWgSSB
         CZ0k6iWgBvXbWZhDIiv4dT1Qyfsf0oJ8eQXJ8At5qxY+WNy1HfLQZ/Y1/Gf3W60tIj3u
         ZFMhr2PyZ+W6VijlSo8+qB25qN2KIkEhTuKsT8kX3nyJf96B01SNEe4F0xO4CAcUdDvK
         M3xmv0IgrHanh2r8iaYEo03QqaikuvZSnsvLYDBr+3JCHypdVMvYr8rYt1nKK6wbwhj7
         iZ9UZeiqN86e20Mzu9xDZtIxMKKoyY3VH6C+kgFt84Q5EbnL+shnvfGB3KaggUP8Xg8i
         tSUA==
X-Forwarded-Encrypted: i=1; AHgh+Rqigt5S1hlaJ7C8MFnG3V82ZaqGm+9YefW5BobTBziGk3rqKiJnxU0VCGA1nq5xZ9rrfjdTZqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7bToavNAcOsCBnK3Vk5BUcWU27xR+9QOFBPQVKGqrcyO3U5fV
	9+kbzSx1zf4Hl3NebuJWZfe8JKV8JrvPrF8hAEEhZcplb9cNoHvgBkKI
X-Gm-Gg: AR+sD131NOYVz7SvZ7ZLeSGKorygfZi4rTcyFmgYEmUElSCfBxt9H0F408Z7AvC32xr
	5/nszJF+RMaRpLlAr9ib6hLj9nZUjvmGJ0DzRqaNew0Euu/gsSX9FfZzn/XqnOirNqyV59faVtR
	h0aMnRLhoclR8OA3Ik++E/Ge2pomUk4SenlhIYdi4rXjybbgn1RcqHoobOLv8bKQYkVKhsDHXLR
	1q4d9rToSVO/Y2SceVDadUo78BMQuhc9xhsJCM/oh3foqMWavXtvtWFg3GrMvrbbv0kQUXdt95e
	TIxw+ZluEEjPUL9T1VoYxVLn5d45KJWtDFbsGTTr4xTrAMalfKhFpPSk4Ly01hMPjAmd7wi2nZZ
	tdCvDwKc2nTX8tLCK/71OjGt//iffJEzi6FYYukfYXPaWM6/u4NmPh48MmcLOujzbbYlcigfqaq
	QneGN0ldX41j2O5Vau2Uph1ma2SuiJmtMwUhe2M0tKURpwDStlDc/xUNf/rKRHFUInlou12E4RG
	ppk8JQAUfbdgmKAvDeR1QnPImOMdPPXlXLe6msA+Yp8it49EHl5A5LT
X-Received: by 2002:a05:6000:25c3:b0:475:f0f0:9ef6 with SMTP id ffacd0b85a97d-47f8d76f050mr368399f8f.59.1784751106271;
        Wed, 22 Jul 2026 13:11:46 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f8635c8d7sm7429248f8f.21.2026.07.22.13.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 13:11:45 -0700 (PDT)
Message-ID: <c3cf5d0e-103b-484f-956d-5f00c1e48be0@gmail.com>
Date: Wed, 22 Jul 2026 21:11:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.2 3/3] io_uring/zcrx: rename notif to event
To: Mina Almasry <almasrymina@google.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>
References: <cover.1784726895.git.asml.silence@gmail.com>
 <f95ca6717da3c8d3649a1a7f0d883a563f545052.1784726895.git.asml.silence@gmail.com>
 <CAHS8izOhJN0YzQ8ybYm57Hd-Mu8PMc2a-NZ-K-N504LzEeTpfQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izOhJN0YzQ8ybYm57Hd-Mu8PMc2a-NZ-K-N504LzEeTpfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/26 20:37, Mina Almasry wrote:
> On Wed, Jul 22, 2026 at 6:51 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> "Notification" is too long and the abbreviated version is used in
>> several places, which is inconsistent and more ambiguous for users.
>> Rename it to event, which is easier to keep consistent. To keep the
>> change small, only change uapi/ + do necessary fix ups, and the rest of
>> internals can be adjusted in the next release.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Probably a basic question, but isn't the stuff under uapi/ supposed to
> be a stable user api? Why is it not a concern that you're breaking
> current users with this change?

That's so only once it's released. It was done for 7.2, so it's
fine as long as it hits some 7.2-rc*.

-- 
Pavel Begunkov

