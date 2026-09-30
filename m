Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEC46C4BF
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767443; cv=pass; b=SmzpDC5SRSscQODyfAA3o0NpyKgWLGTaKvRJf7W5Z3honpqAik8UrzwSz3/Xg1UX5PwLPVyEwKR9G31OAhGPR9bupSH5UmU0DBOIpJxZyS7H+Nzm4Q/sEnPd9txZsWswRxV8tvQ7Ow4nnF1rqcxMZ5iItokJvzqKBIYVoGcLwpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767443; c=relaxed/simple;
	bh=UIBWMrR7o3WZIls8H40iqBJV61DfDMQSfoMTLyNGHtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hx1o3uGJe8r/Zb+OG3ch9yD3JCIgc4ENk5bg9ATzjMaSPtJs6R7LpWznrnTlej3zmYXWTLuUWp9WCROh/VXZ3tTkWmv+Q7WwFMs3DW2H0w5lokYevFeRe8xu58SHAgADKXrwQItPRehobtJ5Dwo5thFh1IX7eYEPeEHQCDBYVrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWqwqK10; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWqwqK10"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-533245fd18dso33958971cf.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790767441; cv=none;
        d=google.com; s=arc-20260327;
        b=IlbDheATwteS+dbzEUzC0E0FRJtsfEYFrIByKDjr0hhvQ90wPvnQ39r93RS0BQgL3G
         hUzEJJz+qN54XUZDYWbOHoz2UdN9/n5A2Ma/yjLDFfUlqW+h/mNyXCgszLbRSTqeE4DI
         QHIAOdhdd3+G/hedLdQhQ4pZGsSxsZJNqjSYDjIh8qvVS7zfsiAR7dWskcKc8ESzTsJZ
         fKvO5ODGw8QIri196EWf2jhvXAWC1THtZ5PijJdxMSUFSCwDuneW49UeeaeI0hsKaK58
         FpfPu5/rMxWxUR/GgJjetwtU6o+ZnT61uxkraFqAxxMNl5qD5Aq+bWV+RvexnIRcS4sF
         z7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UIBWMrR7o3WZIls8H40iqBJV61DfDMQSfoMTLyNGHtk=;
        fh=40mHkL57EZMdeqTU+P0ACfPleR8GBvgqJYwNcUbN//I=;
        b=iLLynIuJhRcrmVIK3TbIywhGkElTa/d75phcNC2TZfOp4FjGk3PMvAcIL3y3L8Qv20
         Rt6TI9rzUXGHuIh2vRl/RaFdt4P7vQ2UAdJhOX3a2WLrdb8VaeT/yRXUY9IFLLMEXFwb
         6J1/0lpqB0e5WI5S05Oj3uJM/OdkIPDqNUtVSH1+WRAGXBFfRlJrJhiYLdk2h83mJjqy
         0e0gluFhd0+FYGFB81HDV7HwUaydYjw9c5Ui89+DvSUW6fwDxL85YLXGtlI7uQbG/zd3
         ZItC6essnh9MQX0lzG0AYoSDVNe0qzD6NmLjbHMepFrOpz2EjW6mFa9E1uQ/vGbOxE4o
         yGgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790767441; x=1791372241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UIBWMrR7o3WZIls8H40iqBJV61DfDMQSfoMTLyNGHtk=;
        b=RWqwqK10UbRdnJxNTIrShEfhofEA2XfyDyLWiYgh2N7JE9A0rdasAsdbIHkmzv2NaA
         7AuTXG1q6RgjbmPJFX70TG7dXi7FG48mMOC9kb1GA0Fni7nQKp7wU5e/aetfrvCYMOr6
         2aXy5s6QohBL/LiO2u1ZwYBsgoV8vj2jeG9jp5PPVILxGLBmHbkc5p7i265VsDBUkT5H
         VeDg2e9PFpEqh3d/JqkkgpUa0Q4OZGqce7f/y+bIp53uuSyM52933ystGUJ5iBO6G580
         8xGnx7o/s5l8pKHgZuMN4290E/umeZODNwP85a70yNzO3dU+25PCeUCFM4VWsv66DU3E
         8Pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767441; x=1791372241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UIBWMrR7o3WZIls8H40iqBJV61DfDMQSfoMTLyNGHtk=;
        b=J75/38PpDmOdhTGWzUvXpI+52Xob6+7scK4x15Sj54ZqEVLQqgQkdlgBmj//jdBwwi
         a23CLSG/egzFBVVdaaml48q97aCpoNNy+yLggBUO/XLFbBdiMUBhZRzJ0LLW5SK6eCxZ
         e0b6NVQxg+ztecGMXLsnDiOoTZmRMv2CuD3joqs/hQOltFjXGQiK4ZHq1POL+Se3UYpa
         teAozf3vYRGH6WrF/A8/15HGh5C9IAzoucvdBmMf6ID1tEbDpskR388BY99z/5koPgth
         f9ewRYayENffFnGoJi+YYjTQZ8nQlerhi1jI6BUZByvi5mI7Xs9XSYjOHWPQuCukUayl
         G7aQ==
X-Gm-Message-State: AFuF++npgBed8dm2uI9CSQ5zEe4ToeMtgcM2LaqiXqEIg0Bhcl0MKpTO
	UI5XFng954M59CoSutL2UjLFH8AwOSy4OHiX3xtfLTNMufkFQf+nnbgfoL5WvxtoxAmvSZHQqnk
	3uRZczijSjr80qTpb/aK3gxcjZ3bO9enmffZvpb7T
X-Gm-Gg: AYBFou2VB7F4N3pyqwtE/mhkzEhigQsdTzw91b0Xu3VGH+tNE5P3ETxQEu6RYuegSKp
	LWa67Zprq4xs5FJSvfrq+a48iwGoVDhxjAVLrOP260yOkOGDgllESnUcAMS4r5Okts4Z3mC43q0
	2NbQisfQmZyP3s2vqwc7K/SgQw8Sh58GvLkUjALkniKPl5D7nmjHVQeXQaBDDr8qfA2ypqRIAbz
	ZG5H6N0D6ynGqW2O9Ov3bGgY3B8HnYmgKM4dfQSCpRq2jc1JCYT4RPG8k4mLFudLMUDs0wRp1tA
	gV1AMIVPt7i1fXtw+Z4d3F/Uc+0tLHuXiva79y3FPk5i/ej9RN6x0UY8unlpzPo9rxWUvNKnZ0w
	Lu+VylQdhKS8k09Vm+NgFJy0pmFf1rQ7QmsHjIZi26F2CjvmYJU9h5Qpt1LeQetiRY2UF
X-Received: by 2002:ac8:7fc7:0:b0:533:3e09:22b9 with SMTP id
 d75a77b69052e-5337424db09mr20540581cf.11.1790767440497; Wed, 30 Sep 2026
 04:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930100937.206377-1-jiayuan.chen@linux.dev> <20260930100937.206377-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260930100937.206377-3-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Sep 2026 13:23:47 +0200
X-Gm-Features: AclHuK9808Jpl2m0jf0JxvvJwCZd-4x4ToXvGi2OJWvz_yrBHOETOrC_Jxm9R5A
Message-ID: <CANn89iLYyttK9bXFJ1yXYti3YGpqNCz2J97XA1Mgrs36-OPN8Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] tcp_hybla: fix divide by zero on rtt0 == 0
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, VEGA <vega@nebusec.ai>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 12:10=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> rtt0 is the reference RTT in ms, so 0 makes no sense, and
> hybla_recalc_param() divides by it right from hybla_init().
>
> Reject values below 1 when the parameter is written. Also cap it at
> U32_MAX / USEC_PER_MSEC, since rtt0 * USEC_PER_MSEC can wrap to 0 on
> 32-bit. An rtt0 above that (about 71 minutes) makes no sense anyway.
>
> Fixes: 835b3f0c0d7e ("[TCP]: Add TCP Hybla congestion control module.")
> Fixes: 740b0f1841f6 ("tcp: switch rtt estimations to usec resolution")
> Reported-by: VEGA <vega@nebusec.ai>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
