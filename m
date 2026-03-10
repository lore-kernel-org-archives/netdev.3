Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55E436379
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132764; cv=pass; b=rdy21/GH9NGc5EKzP5MePj5b4EjNqemCEUPMF5gVPga5FadgJ5zVwQqYouogEeftm28jdV0SGRSkbDsJOnRG7+XPKFDX0qw08mVM82B+UAmMSJQFc5JeyhbZQpFgCpMfuagS4CrfILslHarviYootDy5Fy8S2LHdJYipIUiGD40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132764; c=relaxed/simple;
	bh=GWZ/M5s5NCER/oau2EA9WTqeml+PkjCSZzT7Gq/KoYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taiiAevfVFT5ctjIjYT7knLpWAByTZgJ/5Nv+J464+wfKpriUL8VXRaIdpSneJ71Ce7ZSyJhPtyU4oDn3VRSQnuT8bLaAhhFDW4xXfRodKfn1lxDPmShJiuZ1FDudn0n5RGXaSuMfQNAPUf8tkqzOr1I+6w7qb70ZrPMKw2q3aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uArXlFKp; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uArXlFKp"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89a14be4733so96192056d6.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773132761; cv=none;
        d=google.com; s=arc-20240605;
        b=cJ6eGh4AqDs5y1XqdT22KVJo9f1NKjuqYDY7TYu2Qv1U7wodtY4WVLrz+6eOrSk9Ka
         6sBbmSx/BJEiPOEQdDisBDQMNeSYjQKyGl37ig/4l4b5jxJOk3OYw9JWDEEyqs+6TVJM
         pGEEUeuUW4kW3oV2RUOoNIBNTK6ka4z82sWD+qv4KWhQTRqg3dO476F71QOSBeYcySfU
         /GBIAcEzZGptphpUIt7Kh2iVBlERTB3YQFC3Hsb12XPTs3J1lzu5pRy/BHI/8SvmnAju
         UJgb/220xkFwMrC0w6RGgu0GaBqeosB7IQ3fetORvR6Xw52i7aQAIoSexwFfq22iT/mX
         NZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GWZ/M5s5NCER/oau2EA9WTqeml+PkjCSZzT7Gq/KoYs=;
        fh=bJe64OutqgYDYOe/WVYqxz7j8//bG4DHn0fe7gf+Aa8=;
        b=HKAoDtrN7JngIG84IF80Kry9SS47csAXOt+UjLlTfhb+9cd5WdszYYormRC5WqWrAz
         SMUWbSgnDb8Add6ArbctPxw/tiuV616ztM6vXUAN0HVVpTQxH2wjacmoeuDbnlUPwmMP
         1mTHmYThDE9khKXjCH8l/IczEFOqWHKTXiSXbmRFTSPrtnJp82rdKhtSRu74HpQw5Lca
         kcpoB/8nvO2gQL+zN/CiNISzCJXm6chR3ZQIerawnvME2NVmCkw3TNX5L6AziBgbW2bN
         Bz3UimQjQyxWi8FKpTlMtVdTv+zgR1S0gC0ghy8hnv3LZaEHcXoANRGon5JxTwt2Kek3
         YYeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773132761; x=1773737561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWZ/M5s5NCER/oau2EA9WTqeml+PkjCSZzT7Gq/KoYs=;
        b=uArXlFKpdXlqKPjE09U/NpdesuwQWpbUrVISvbyzCV4L1AsHSXzQj0MCjt+cEt0VVj
         aqllWlGYfzBJMDKNsx8vLDQIK3/6XdLfDKM7ZKU2Djjt38uerxPm3YWuj6a686q4OB3Z
         0rDYPe0yCHGSq7E6y/cvMiET3Iguvl3FjTULft16Jd3SY/LyFUSkuVzXHIQ5odvTVV9g
         HUk5FbFqsZMD4uXraYuht1pWk40p6xhEroXzSuOUOT6y2liU0wRgbznY2/UznsuQ8W0j
         AizbepEM1kyGcW2r7d2sGynwX05yn9UhQFqz1tciVFGjYc54X59UA2Ai02fQySDhRtSz
         J1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132761; x=1773737561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWZ/M5s5NCER/oau2EA9WTqeml+PkjCSZzT7Gq/KoYs=;
        b=C7+Y6a865S9U78aQsmo/0icrvgYUkGb/g24uz8Tvc+Jcsq1cLPU6Oz3QZoUNkXV9fc
         9BzRVpMe9uFfACDBFDHRP8VLmBS1eNBm61g7jBSQUqy8qeIOgJsyEjb9jFvjWdsd1oZg
         RfzPLg9dDYeQIkO7/zGzVTSsF+dxgHfHfK7Dyz/74yGjFmoEdwtHSDYWd+OGSH7JNFCP
         tDwUWHCIF8dluJByeGae6Y8ney94jr1qu8dKwVAIt9jlA60yDZDTQHAbbhrnxe04TJgG
         yc/I6VL7iy8+9Y4E1yxz0wzD7n32dC/uYfB+QRsj6uXNRCbW0VtKvJmdg6mp0m/WX/gd
         hdLw==
X-Forwarded-Encrypted: i=1; AJvYcCVTJL5S2UXc/wJn4zIZfezLu/Uu/jascLXTjnLi0M7B2Qu/BSsn25mrDjiuQnVTSJqlflFnEMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjiheKcXewwqjDl0aKLcLFJCmYoXES7T0aM8IAUCAdH3J7x1p
	hDMqFNiF4deTeMm0r/Khw5IScs3tP1Jri1WwFXZIIkR6PKux9MntGu1NOSE3JQNB3GCuL3+ujRv
	jS5+jky7k5tIfyGBvwCHj7O+pgkMxa0Ym6zymLZ8l
X-Gm-Gg: ATEYQzylgwyf4tub97hhHv7ZcAW6nSdbihUrPUUdnPsVj+D9pirH4XUxKdzLCBQ5hXB
	QysaloL/YHn54oc5A3E3Ze74OfpJDXYKdtnwanmucTWGJsK8eZyuxfVrn3ZoqFTVg6vjrrwkdqD
	zjP+RjKUn/nHUoxxZvcmvtJv2Cr003bxGZWks+sX7cmYdlikwyV9FJ8ng85fem502edFT2+K2dj
	vZdN9KDJXNvAZvDSXmGLYx3wml7j2oIeVWl56XrEZPG+jKKBwGZIrissfFNE9P1k7KqJeyEvQm1
	/WXvihs=
X-Received: by 2002:a05:622a:1495:b0:509:f36:496d with SMTP id
 d75a77b69052e-5090f364cfemr113018421cf.33.1773132761084; Tue, 10 Mar 2026
 01:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-5-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-5-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 09:52:29 +0100
X-Gm-Features: AaiRm53cOsmiV2tykYX4dD4wvI_-2esZ5FOIQTDvQaaas49mugfLK5wzrAfT4QA
Message-ID: <CANn89iJCR+nO6ZdggkCGACfQ-Tbru1nq3_q8q4QTp93faoCPug@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/6] selftests/net: packetdrill: add tcp_rcv_wnd_shrink_allowed.pkt
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 9:03=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> This test verifies the sequence number checks using the maximum
> advertised window sequence number when net.ipv4.tcp_shrink_window
> is enabled.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
