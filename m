Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954D495045
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639402; cv=none; b=AT8lfO6UI3xFUD5Wum9ka9cy4xywpJBsApBHLEuyyi7oDgqhLQTSFUZ2u5f4q+rT8zKha3/TQ3EBtXcQ5nsgweM/yjLgxboVD+pj3VXI3nlRKsF5IMsYa+uw4mK8KPfAMoJOrHByQ8PwhAYlMJ0LvBTcfB+/tiSXnwdcr2X3MYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639402; c=relaxed/simple;
	bh=Z4dprotIJMq6+9Z0UZMRMrF+UHlBEM8UAFfkVHv5Zqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szU0dX54KkNQWE+hIZhn8vVkwi8k6Asuq4u3X/Rhm1yFzYWydZwDhGcpSLyQprRz+k4saLVlDbOwkUJi0IZxW/MZ3rJ3dgLGbq+iwz3f0gaNIAV87NyFlEUh0ybfQYxhN6UD0fYTC26ZVso0WQo9rjv8zCu3oaLZ8wGmfVjH+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VOV6EreE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VOV6EreE"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2055573c8cso20398966b.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1786639382; x=1787244182; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fzA98pBfjBd0SIPCwV8nrFJIH+ZnLQqCApnyFDxYxI=;
        b=VOV6EreE0RnnbFS6n+ZbLyGDTxCppZrzBoaBa4mvyAYe8Uf1sB00cg5uLMO/U///+U
         Co/MfymZMTcga426N/+LmnuA9UzaItdmAjtdQzwYieLhr78ob+I0TyoAjhPpIN9fxxG/
         0BQfm9jZgP21ytGQa1csPYdUJfR1KEHgJse84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786639382; x=1787244182;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6fzA98pBfjBd0SIPCwV8nrFJIH+ZnLQqCApnyFDxYxI=;
        b=A5L9pZ/2o4sLCXEszI+uXlp2HkVhPHpIOW0NoBSBGo7m+2TCDdTlP2Bn34GDCLvmzx
         lxODgZ5s/yS8i3WUeoUXKq63XQMI4pIJ5bUcVtVYSV6vG3F1wcrZqYIU6TZLIJAG0EEl
         O381WNQYQmpm26NsZPF9UshOBfuQIBh0FWU9/OZgtFWkyuaJzcJ1S8SqogMGSshKCUTy
         8TVaHx2Tn1iWTM0UnH6i3gnNADpWuudWF9NBiwplpXKDT6zaZOnpGV4lxVfzy0irwHO9
         Xyvbg61FUPDA9KHb3ry3jX6UNfaG/o8hJwmvqUwALPqdvqTpFfOYC8rcmMLXj8m5myjk
         yDgA==
X-Forwarded-Encrypted: i=1; AHgh+RoDJxVZZDCu9Cf0z8p/RU0GrK43zHweMpl/EFQ4lsq/GbtI4ccdPQGaK9KGYWsTTYce237HSn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9QQmlgWSuhup0F1fQPMPNRUAy0WX1BIbuOr+yhsRuvOmUHd8
	89w2pdATLS0qjP1tyCihUPkK7Rd1NWW5N6iVMI5nH8uXIJv6JHFASJkPD7r0i5ud+eWOlBV3lBh
	oQeOcXfs=
X-Gm-Gg: AR+sD128z1cXjk9U+hfdWt8IQ9ZcBvxiN7zj8jbRMH3DuFUo+PXu/AqUmzYrPHT4NS/
	Mt8+WdQes3g76vGp6q3M68mprQ7KPSBaLxUdFh9Ab60NOwTnurRsq6HV+hvrVqrVt2dZzHy1Z3P
	7s2IJ8bPD8U4EudThTzdjEiYdmlyzJgUcOBGvtmxfSciiwNEzbTRTO+WiIMS2dlKBL5VY8jDQrY
	cYNW1AexL32FxwKsak/Pwkql2r0V1BJgO39dQdewSi/PSNe/6JgBxkQf5ssUJlZqYWq9PuknX0A
	0M2iMsQcmUKiYKGsWhvbeggXUIA2fX9/cdnhRj3oevmeS8NoJqcd+v8y8XQAuXqSiz1xJFFq2e3
	132Nch2KkA0YFVPwnSq+wo8Q+7zzgaOXoNVQrwPYfV1VkwgIkpdtYxSGD7bn20UZ4B+LDmV51wV
	pemAckfmjQ3vUG3e2e7Kyp0I8jWfYmQven760z+b3VsefP2SKPhimweYRASFLvI2BwMwOEc+jI/
	yi818pbeFgNAw2CCfT3p/uRUBVQd/vCX7wcwcY=
X-Received: by 2002:a17:906:4fd4:b0:c12:9b93:61fd with SMTP id a640c23a62f3a-c2108e70e50mr347482766b.6.1786639382119;
        Thu, 13 Aug 2026 09:43:02 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2123821faesm10566266b.52.2026.08.13.09.43.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 09:43:02 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2055573c8cso20396066b.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:43:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpTL+EGd9UBPHEcviAgQ6YjRK2EAksDpd9ApKX1lMjSAB5olgiX2RCHniuL6v0nqsTtz75T2iA=@vger.kernel.org
X-Received: by 2002:a17:906:8d8b:b0:c1c:4d59:2b03 with SMTP id
 a640c23a62f3a-c2108e706aamr386933366b.3.1786639381502; Thu, 13 Aug 2026
 09:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813152104.256382-1-pabeni@redhat.com> <e5a958af-4144-46ab-915a-84fd2075d383@redhat.com>
In-Reply-To: <e5a958af-4144-46ab-915a-84fd2075d383@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Aug 2026 09:42:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhignRFf-8CJ4PTw74dX6rr9N+X-j37rcM6oUB-ZcZ1g@mail.gmail.com>
X-Gm-Features: AUfX_mzc72MZtG9u2kSEPm3ATTRJLprJlf57YPH91TMhLks3sT9BOTJ038nCuCg
Message-ID: <CAHk-=whhignRFf-8CJ4PTw74dX6rr9N+X-j37rcM6oUB-ZcZ1g@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v7.2-rc8
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Aug 2026 at 08:32, Paolo Abeni <pabeni@redhat.com> wrote:
>
> A revert for the blamed commit available here:

I took the pull and then applied the revert directly - I assume that
was your expectation.

             Linus
