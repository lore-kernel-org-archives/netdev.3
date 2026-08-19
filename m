Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0347884A
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149582; cv=pass; b=rqKm8V7JcW95Kx8HzOf3eG3depu8HuOdy56gfEAyc9ZgrCAVAPSx6U72gq0Puz5iRJit16Lt2VX7txdgmXmO5abQBDjBPCSYTw7Z0+/uQ6o0g5wVSlJnhQqYTMDgc4b91vsjmO4nlmECr6g7mlH4S+h58YVXr8XSTjOr5CYdEGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149582; c=relaxed/simple;
	bh=mtLHmPpOiePeRFfAyGUsz76wlHeLqchwFt029X15pLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGDQ0jMOwUkpJSCyaoitC/MGjvCqadsDi1wNiIKmQITYkVnZ4hf5THP/rlxrwVP9csUMmAvW3uwWdpWk3aSnp+pwKYWxa1n/9gU+2WJaNA925R8HLBWs4LeBouxTO+5d6+YXemfOw0aBLvb6GXs25mwTxyjG8XrbCLCmAHfrGXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl2AX37l; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl2AX37l"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ead34361b5so193078a34.3
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787149573; cv=none;
        d=google.com; s=arc-20260327;
        b=BJ2woErv4ecnt9c+8fsDH0frDShC5iSvcgC1lD7sJ0oYvjOqWMJ5qbWTNkLbKetKUN
         kMIsqhRnLJcOXQXeM/hDka1q66Q4FXf1G+GmWQYX/QCL/ggNZeEWoOcGOmcBuqJoKkQz
         9OH8lBoctwpxDTWUbyemNCW3pZdWJU3UWcdQ1xW30dL7GX6KHxTBNU0LdAEt3Isv7bUP
         xyq03gyjb3fQ+w2oC+aJoiQ8EbcpUc/f7Akcxi5rKpsWcS1vF05z3qs0APfJcXId4HZi
         cvuuQxZsng+yuw3tapSKnH4w9IHfHHIFwoGNMTJcgknXvJfyRBZbuQbzXhcBcOpiu7B5
         3V1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mtLHmPpOiePeRFfAyGUsz76wlHeLqchwFt029X15pLE=;
        fh=BrUg+AYHh4ktgPs60C2/uzb5A9xBqRhJmg+Fia78mio=;
        b=poURCOYJnVvffOQz9/gQUwcQNZrm6/9h93SeZU2ayUqWRs7pBoti5IrN96Hi6pWPVn
         rZI+sxq62AnQI87EJnlwQbQW+tQtW/K28RkQFaYO7JMrZ++mzWnKyrKuo+Sz2AKZqpmS
         NMrelwlzMnO52sMHnx7MZEgONhXVBj0rH446MALg6XCtQrGKPAxPorekHxKmFXmT4fER
         It9FvwG18yNGZfMdymWkEDX/CU8Slrvz00KkQ0JmVgtsSzUN71DWSYsiorQIzVMdEwis
         n4JTanf8GcOhvZm0JpsRcOejwrPJ3spjlHYBTotZzLjmpS6jOtuNiF4Qn6eGRzWsu6Ls
         BYTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787149573; x=1787754373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtLHmPpOiePeRFfAyGUsz76wlHeLqchwFt029X15pLE=;
        b=gl2AX37lK5/bpSpoABYA4jl9JrAnrb71JDrAxNLuqB7NC53x8BNZJ9yZpga/Kg/LPX
         eSwi60UKCJk8JJg5cUYDLKr0gemVlQa5BMs7iNsJS/6sPMUmgvQzLLOusvDANcwi8WCq
         lair9RIv2lwYsrsV5kzw3cITRFUlED+d7pClXb8EVf1WfeSTn6iMCs0svNsZ2repBF48
         p5U87gBnbvT56gPXaZ3W7Eod4fODK4DvWmT8W9RgIqS0daFeSjQhET1f79VjttWG/w1Q
         +4uH4UhQ0nj519TNPkNU7a4THLQo/bBDbYgHLook9paV7YQvYWH5Sr4i7dgqd3rsvqY9
         TxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787149573; x=1787754373;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtLHmPpOiePeRFfAyGUsz76wlHeLqchwFt029X15pLE=;
        b=jql0ZJO1DmUVSdBIeINEFKBQr3talwg7HbfNdljCOt50NffVa9OVqvRUt4+8qS2L04
         miGMuhB2UpKR7lzm6+YmiULIjnKX4CtcDa9YZRIo15ET1U2qWqwe6D+bTVbASBzJjcph
         PfSPf9V71f7MCc0nqz+w0Cc5GXDNNWgkoyjf+TAQuZHodHDiT6rSfcj7m8/iYC6DLJ/d
         SE6AClYUcjzA+ar0g+FcQn2CgHZDI0GbloowQS/DBGutTJkGIrvFpC9SlxWx5zZqDMta
         Mi214oiU3hqyT2PZ5RcudZnvqvQIh5pmrJTDAQYAX4R77Q7rDN+7esr1TgFlj9SydKmX
         30Ew==
X-Forwarded-Encrypted: i=1; AHgh+RpS6s+EgHyO87P85Yv1Hn1xDB1BscAoehbKpK8aqf1Ta/fxhlK6c0IJNri0b8mlpfIjxztNvE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4fyTSicVnyVHTj2QYrUbnDuua8XznhgN6kDhXXV3ma2bLEs2m
	B/3O2uDIIS6JV0CbMdeK4BPL5EOIRsY1by4sc7cHses9jxaPcOTBYG2ygQt/T13MuYCdCZU/ejO
	fQcdGIr9R2xKV+YFwJSBZXeuJQj76M+s=
X-Gm-Gg: AR+sD12MO9jUFf3y+2cRJ6E4YYzzUPhLK/flWJxYv5UIN5YhlwVvHZzIb3X18Xtlmcj
	YeOLNMyzXp0IdpXW7f39A8ehRcTZKivNWIGMl1bUb0EcwjSo5CWLI02YT2C9VWDLDdohCnzeepj
	RLnyM6xwFZIhnu81XDKul4FB/fOl76/KVo96tT2VjDmnZVehAhM3OsT3PvYCJSMZwuYfYcsP/5J
	sk8hzQlE/C7uNiAJkVHBB+0qCE3VGpfFnMkqe3QU1wPXVp7CV5EG83NGlFDJdV6aSUHOIwnuhgo
	5q1zGg5qsSD9zHpKIxCUIXZ5Zd5uwPhLCqatmB5AvC7YhYHEp5DVxip0Zgv/1NHbYQ==
X-Received: by 2002:a05:6808:4fce:b0:4a3:f036:f3bf with SMTP id
 5614622812f47-4b2bc8c1bdcmr2756929b6e.1.1787149572686; Wed, 19 Aug 2026
 07:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com> <20260818095103.7a7f4c51@kernel.org>
In-Reply-To: <20260818095103.7a7f4c51@kernel.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 19 Aug 2026 15:26:00 +0100
X-Gm-Features: AcwNN1WvWAT473hyfFIV9m1jLgdW_32ZW6vRQrZ00niDYYx8NpT_8AvwknomriA
Message-ID: <CAGSyskXAivuJ3=+3HgZeN_EUH1gw4A6+K=uLdr8Vc2q8swhW7A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/7] netconsole: validate a target's IP
 address configuration
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Aug 2026 20:28:51 +0100 Gustavo Luiz Duarte wrote:
> > This series adds two validations to the target configuration when the
> > user tries to enable it: first whether remote_ip was set, and second
> > whether local_ip and remote_ip address families match. Refuse to enable
> > the target if any of those validations fail.
> >
> > These validations are already done for the target passed on the
> > command-line, so this aligns dynamic targets with the command-line
> > behavior.
> >
> > The first two patches replace the per-target 'ipv6' flag with a
> > per-address 'family' field, which makes it easier to detect these error
> > conditions. Patches 3 and 4 implement the actual validations.
> >
> > Patches 5-7 are follow-ups from previous reviews: move inet_addr from
> > netpoll.h into netconsole.c, show an unset address as an empty string
> > rather than "0.0.0.0", document local_ip auto-selection.
>
> LGTM, but feels to risky to merge during the merge window.
> Since we're changing semantics we should let this sit in linux-next
> for at least a week. Please repost in Sept.

Sounds good.

>
> BTW please carefully review clashiko feedback:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6=
-v3-7-bc0915e8c75f@gmail.com
> It marked as preexisting the problem of IP versions diverging but
> I think it's relevant (patch 2)?

The issue of IP versions diverging is indeed a preexisting bug and it
is fixed by patch 4/7.
I deliberately kept the fix separate from the refactoring for clarity.

Another preexisting bug that sashiko called out (patch 5) is the lack
of locking on local_ip_show / remote_ip_show, which can lead to
printing a partially updated address.
But worse than that is local_mac_show (sashiko missed this one), which
can lead to UAF if the user reads local_mac concurrently with target
teardown.
I will send a separate patch set to fix these *_show callbacks with
proper locking.
