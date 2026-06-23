Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CEA286D56
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183938; cv=pass; b=kKckZdj98Lll17Wn0gQjF3IrnRTXXFzFjpnaV326a5H2C8kjhFVQlBHGXll5U6ObEPtpRhG7nhfn0PKbvNcBN/myc4duoPm/ehDhmLLGqWXtMBuaD+nWZjBgHacfDrkNl6P/ZeWrUSfe9t2RCunV1fbPRTrkHicAW4C1qOzM77U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183938; c=relaxed/simple;
	bh=w9/v0IMArJXsg3aPDlsGrVv5CNYZymsURujfwxoItXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3HavFryKf2JQeuootgHjJAVCNMT9JGZ+V+8SI/dT/O9vMgAt5OAUa+wHJZspVqWc4gv9Fy+0NYDd0eqIE1uWs22l5BhD60iDHcnV3xzP2PIIbvRxjBRV13Oupzd9I9KmgYU0gm/cknDdC/qJEXHyg2P69XHJThLbZxKjhAe/V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhH7WvSJ; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhH7WvSJ"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so9744896eec.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 20:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782183936; cv=none;
        d=google.com; s=arc-20240605;
        b=ArAUuljFzvKh+TR3BmEwgrHoFqxX9K+ow3nfOo4GBmmwmDckxqPvyf7UHOnQqOcRkr
         NUGQWkL77jfoDuo9cpayLRRy6QADQR7Ul3fCC2C7Y5KcTitD4BTIPwe9Rqh9Pn7K1wEu
         20O/buLF3QGUQIxgXZpQJj3JFAEXXI+1I598DpwpZcHCR247OZRKswCK9rbQsJFAmI/1
         O103Io65Vq8VbP31xk7Zj1Fmwu9ed+oJhxQV3sPwWdabIKFQPUsn5jKd3SqC0BjWeobN
         60oSFTlmtXIHIMiugnVedPPCRhxgylTfFO3lSh7JFF5lbf//xm76AdjJkMI/Rj9QEAj0
         tcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=B7yoM5iad1WMYZcRdFgrdT/sj4g69jJf6JpPscil85Q=;
        fh=tsKwqqXqE3u6kb+ZcQKXomAXHMSBi05AOt6+wo3IUvU=;
        b=bTbx1vawXWLMadlB8PKjYZo09v6XmsHEO0GDdj5hcWRobs0ZadCixxeBN946otfAk8
         o1o5SmLUxnD22Q6nYXwkcnWnza79tIAS3SazKx5EzgAKeJuiyVl2sYaItraDd3R0KsZp
         oPyupW21clWuUo5J0DCSsYYj8lxjYK9wevOh9SPc6cdvS7FbbmxXHRKToBKmgYTumtDP
         7TLkeb6ssLhSP45BzZzT9EppZ+x5+AEPjKEMhaboeqV2evZJd+X5cNBWPql3SL7mOVaT
         Xn1lXlSs6xrv7TBWgymhG6I7ntXZEIjFMi93pl4lftsOCCQYqHtcWjFuqKsLznb7rQSt
         oKeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782183936; x=1782788736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B7yoM5iad1WMYZcRdFgrdT/sj4g69jJf6JpPscil85Q=;
        b=UhH7WvSJQVjJ4q2i2mbegaIUB1WacNZJYs0YqlVqGyfCISJh1XfUa7axdI8xV1GZ/d
         PlgAfF4K/2i4CE+8VbSKknmtHh/ZdbVbohvdujZ2e045q/usz/PHf/un8AtICAZdYmaa
         fV+1QerDFh0xiv7x4i8qMRk6K5bFF7SGDxJKb7UO04Y2mZO7qc+SZaee5lfFcGqrAoeq
         HXAasITWzKkmB/MfMhpeZaxGxEJfIvhYKqYrCgjRkVv2PhxflZbLyfsuLL51g09QiUdV
         ZnbGuxxp0FhruGRG4XktCTZOjz/Tj/MJ0LGxxKvXNiGxjtW1PpWNyr6TBie8y/TPklRj
         N8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782183936; x=1782788736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7yoM5iad1WMYZcRdFgrdT/sj4g69jJf6JpPscil85Q=;
        b=bPyj6vc0kZAUgaDMyxivny6E6b9EWwGvgON32o4SjIeTlvbT0EoQnP44b6beaJqT2a
         OiUhokwT9edUd7A+01su87bO3GsvgYcRC+sXJH5ujjovk/3kdYREcU+lToFvF0+Xlu5p
         BRySnk+dM10F1Qq4zgK8INy4B/5Wv4xNW1+B1DYhkNilaF0qIwBM3FXOzeuY7VZKWcqU
         0adQa40R+ueNOZQMJCWjOg3w6/uWfiY1OnPTD7QFRWT8K1oyx4ZF9+N0C/BWAuSkGuhX
         1COMor76V4fo0MxHk/LLKYV9NTsV2AxXBb+sB/1ABiZidoxw2HrQV0stDetgaleyuorX
         lU/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqITo3YUdl+pZ+RZMgVQBHGEZUeMOOrA5Jj9gRj/SEu8xNKdhna5Jk1vdK/7KtL6pAZVTf5ENM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYg+w3oQ+qTygGDvqdlLjAs8YBH7pbVINoVG2Q8NkOqa+c2FKI
	SkcTs6WKTBsP8vSnmqFH7FpeTk/3rA/v6eJlZP8Y6slc7nzHZSFxsg8/LBGBEGvuE4u+2WDXrrQ
	WATOGgvI2wvZqqhqOHOTamGg8Zt4zgEs=
X-Gm-Gg: AfdE7cnBWN26biZIYQYR+RemmOPfk9AJGgCQNUmUEyg1Mv/eZUH09pymeSKkX5FYg4W
	wlpeMBJATqkvreudKZsdUxolPqUq2/Fi2gpsdmD/hMBXHzog0khlzFoXQ/sYJ/r4ItuLuqu8JD3
	Q/8j7G0ECTxnUHFAlJ8lkRo3M1bmvvV5MFbXAVCsCcKd/S6iTc9THA9zFcYw/HtcV2gf0l7p/Fx
	8ck/+mkF7zfNBRHU9pyV071oXL2QDzIlJFqStYwyhB/OEc8lfQOt2q5nOv93djkJw+/+FjG7ep/
	OlFGwqKc3pRcK9+3tgLjGg2Okiz11WeeTVrqBwBC7YMk+azwD5dXl+eLh7LFS54dRQPYxhDGFHF
	mfRAEu32KZTq5EPrFqVrM8DaD2tvSAi4KYmgFA6PX/wh88E6cm4JzXBz/tIBcGOPEB0QsTlXwjq
	/cC84zdmw=
X-Received: by 2002:a05:7300:4356:b0:30b:ab02:9e52 with SMTP id
 5a478bee46e88-30c58c2dbffmr1059621eec.30.1782183936378; Mon, 22 Jun 2026
 20:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622185248.1717846-1-edumazet@google.com> <20260622185248.1717846-3-edumazet@google.com>
In-Reply-To: <20260622185248.1717846-3-edumazet@google.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 23 Jun 2026 04:05:25 +0100
X-Gm-Features: AVVi8Ceg5viBV4T4RGEeLzYzmGEkOoOjjo3CzjxCNpZPZLBd8ZoJE7Gkny-11Po
Message-ID: <CAJwJo6Zn3n6=B=ZMOiA=M2wH=BR7GL3oj=+fPiv1oxqMK1AG4Q@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests/net: Add TCP-AO key shadowing test
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Eric,

Thanks for adding a selftest,

On Mon, 22 Jun 2026 at 19:52, Eric Dumazet <edumazet@google.com> wrote:
>
> Add a new selftest shadowing.c to tools/testing/selftests/net/tcp_ao
> to verify that more specific keys are correctly preferred over less
> specific ones (shadowing prevention), regardless of their insertion order.
>
> The test configures a server with a specific host key, and a client with
> both a specific host key and a wildcard subnet key, inserted in the
> "wrong" order (wildcard last, which would shadow the specific one under
> the bug). It then verifies that the client can still successfully
> connect to the server, which only succeeds if the client correctly
> selects the more specific key for the outbound connection.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Assisted-by: Gemini:gemini-3.1-pro
> ---
[..]

> +static void *client_fn(void *arg)
> +{
> +       int sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
> +       union tcp_addr wildcard_addr = {};
> +
> +       if (sk < 0)
> +               test_error("socket()");
> +
> +       /* Client adds keys in the "wrong" order (wildcard last) to trigger shadowing.
> +        * 1. Specific key (Key B, ID 100)
> +        * 2. Wildcard key (Key A, ID 101)
> +        *
> +        * Without the fix, the wildcard key will be at the head of the list
> +        * and will shadow the specific key during outbound lookup, causing
> +        * the client to send a SYN with KeyID 101 (which the server doesn't have).
> +        */
> +
> +       /* 1. Add specific key */
> +       if (test_add_key(sk, "pass_specific", this_ip_dest, -1, 100, 100))
> +               test_error("setsockopt(TCP_AO_ADD_KEY) specific");
> +
> +       /* 2. Add wildcard key (any address, prefix 0) */
> +       if (test_add_key(sk, "pass_wildcard", wildcard_addr, 0, 101, 101))
> +               test_error("setsockopt(TCP_AO_ADD_KEY) wildcard");

Two notes here:
1. The two keys do not match, so I likely misunderstood your cover
letter. I thought you wanted to override more generic keys (longer
prefix; non-VRF-specific), but your goal is to choose between two
distinct keys, likely with different password-seeds.
2. This only changes behaviour on the initial connect() from a client,
where the client did not provide any priority of which keys to use on
SYN segment (by .set_current=1).

I think the patch is fine, yet it sounds like it's limited in
usefulness, if I didn't miss something obvious.

Thanks,
             Dmitry
