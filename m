Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90E4349B9
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123822; cv=pass; b=kXAs8UtrAnRw/l7PwxvAuKTO7l1a6qcM6hqjuiSVj3z5Fc+H/oaokoBalklBYP4FpvUZSlq3T082T6xiPryxWJ9h0JZk5F68X12F4Qxb67Kp+MtCElw2OK1RAIOTY5rfvtDjq4YXPM+VzMUdb/T5swut9fQ8XNJhf2qV3CGuZZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123822; c=relaxed/simple;
	bh=4pQW45rq8ce0SljkYL8YbelDyzZQu1ML/gJZFCwHnPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoTxxXlVhTf5AYZ25jcRjvKhfrZCjXbaajMeYTgrGADYlkAMppLyPfy01rqB3OM+/SD/596DRBZOZ3uF186I0ojWa54z9Zqyh7Df/KBkZWDbU4s9fQD/3XtM00hy4TLs15J018GZFNEiBzBcz9TL6ZGi03mUfNf0pPc1F32fJow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r02GL1gi; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r02GL1gi"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b5e907853eso741251e87.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789123816; cv=none;
        d=google.com; s=arc-20260327;
        b=aLlHg0tW387jWOkfLe5lx/isDTj8oYtSPJ/s91lOOI6cA7LNdsV3USqvJocQQDvvtS
         U/DkcVbuBk6lGBeap+jE68SRT8i3DYs+IHv7Ga1sAXAZOAie5vLRZSAi/Ej93TSQU72+
         ixmqc4kC6eiwE/AxqMZeE8P+WVquVeFq+IXlUw3RinEPwUDHUa1WyHugkBGH7yKeM6MG
         s2jHJQ4JQ6s7QvA0WxXTvf/GVgRFcdzV61QJp+EIC7ECLMwwb+YM+wNyN8YJlHwFrrKZ
         +qsxXFurtash/EPUTpTCi4P8NgCtPqh0uh/YoE9rlzAvKXGkGv2aQ2tqfTBLtmo/aNQB
         J5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4pQW45rq8ce0SljkYL8YbelDyzZQu1ML/gJZFCwHnPQ=;
        fh=gRXD4IFPiE6Yxtk5ZoCyTJgxkvNnUD0RdLN+z7R01+Y=;
        b=D2w3XX6jCAHEG4fFUiR2Vrw9CUTMe8SJIskxJWDEKgDaAgxAGD9Ndg2TS0UdtTUNGe
         WtJBr75zGmskEDZ+Zf671btvcUccxxfdTI+hwBI9k0wYur6LVO6/r2AAUGybJS7AAs7c
         fWtDAsl1zHmiKvlEcrLGfOCBa+Z5PM/keYK8fQji7RTtlmfJXi/CAFvunpcPti1PjKob
         Tw3uiXgwj3hP0SFraho114n5BzoVVWdFkht5E4lU9yEMYkGN5rfx/19DxKN50Rf/Rhun
         9Q5ySWcw03/0qKARw5PN/to5eF6IWSqA0NfMfWv9q1a8nq26BY29dNFBAmiKjMEsUtnb
         sdKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789123816; x=1789728616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4pQW45rq8ce0SljkYL8YbelDyzZQu1ML/gJZFCwHnPQ=;
        b=r02GL1gi3d79MIsNIxPtM6SHwb1mURzmrq4j+qSDDxO4qVEespU6hCNfZv8YJf23T2
         +Qbam0m1rVJDKUWE8SnGM4GMchL9FdoBpSIzlzxWQUKJlttIF0Kc6fQXkhk6S29CrkDb
         QUUFKUXeBsb8xTFZCPM/nTFRjL4MrhdJiCmhLEVZpfTWJHYCA0S9gYtC5TLDT4EMs7hQ
         uArHR8iQGxBBra7faG8koeprHsTy8jAtZcVMuJGZuv0oJzWjn7ptjLNPbFeDgRoQW+cT
         xIQJbxEX6NHnuD1lBt2uWiXf3mI8np984uavfbnqmypIQpFg5Cd3akXnCksFxPCNfiHI
         LY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789123816; x=1789728616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4pQW45rq8ce0SljkYL8YbelDyzZQu1ML/gJZFCwHnPQ=;
        b=olSUelElrAGC5M69od04ubnsnY5Hpd8uXp1Ap/HODP/rh9iMOpnbtwKJqGehwCAzO+
         xo8HzlwZ3FAkJ8JN5xgwaseKq7lSyiO03i6xUEykmZdYC5sy2OZOWs+FwU8ho97470Nn
         CcjZ1t6YAIDUyszZb5RoTmMN7kt+FEylrw/FbneDz7Cch0C7VLu8RHSw0Z+AVj6Du3L6
         abHthBbjnh7FFf+iunKV2iBGPV2YJB/e786VgO7CyMgzth/raukQZDKal5Tv4n9N0KxA
         lyIH30rNkv0XQGbxdUVbJQEWoMocpRl6yOXwBJa+Wa+ogYuVK3ygCLOLyZ7YjybCuMz9
         D3iA==
X-Forwarded-Encrypted: i=1; AKwUvBzgB7F/ryCv/QL+W/LkJ/7RVY9WX+85klzG5qsi+zaevNJkPC7G12JXTeoRheQo9UDls5Ik9Y8=@vger.kernel.org
X-Gm-Message-State: AFuF++kwJA+6vQRuhJ5qC9lQkXi5lP9xBFTsV7SLw0H+63I+snLDgpMh
	bvZOinV8b2zoFc80nkcYazug5/9XNTQ2xG6QScM/DM4XPuwX/XZd2QXKsVXoxrjHdOVEe5xAYXA
	D7aWXQkRpWg2PvDTIMKXJDuu9H9z9Nl4=
X-Gm-Gg: AYBFou3K1GTuZpkckgiRe/K5Ziu0Uah71ChPUvcX6nhPeKFHAK3PbmgA7DpCFhAVsn1
	pt1hNGkD6iG0hM62f/w2xU8faGDtAuxixD92JMDVX3RHrwz3mnAdaQJXHILma6Vr1y7DcjPqGCg
	fVPScWjNM+hal4EDzAr/GPTlZ0Czqh+3u/0K0WB6XSceF+vvuR3Q5pZIZjIkz1XS2zvEmtHEbYp
	W7oum5oy11VhGmrJECyb1ZWWwqSrFmFBxVTA6vJSgqtSncIXRW1PyKHuUmZHn6VFspDZngX2ugI
	TKLD3jD7zoD8fUDWM7KTZ0z5Fygc9Tl+e0O/8y17dUY9Mb1XKR5VVgEzWbnQQcZahcBSSWAMRQC
	ed4iJe7BiCxdwXKe9U/5VRw==
X-Received: by 2002:a05:6512:1052:b0:5b6:1a7c:59d1 with SMTP id
 2adb3069b0e04-5b8a030478cmr770802e87.43.1789123815958; Fri, 11 Sep 2026
 03:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909133247.113923-5-sigefriedhyy@gmail.com> <178904820373.219967.782013244688408761@kernel.org>
In-Reply-To: <178904820373.219967.782013244688408761@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Fri, 11 Sep 2026 19:50:04 +0900
X-Gm-Features: AcwNN1Ww5UgMVw4xzqsqwXvhT3lHEUGGRDbRe6Df1222qEUmMtSjFyZfIiHQZt4
Message-ID: <CA+7S2vJpy8Y7rqBYDdbW-T_2yaBrdb+Bye0wbCRAUhmrvt7NWw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] selftests: net: test AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, donald.hunter@gmail.com, 
	edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, pabeni@redhat.com, 
	sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 10:50=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:

> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260909133247.113923-1-sigefriedhyy%40gmail.com

Duplicated comment as well.
