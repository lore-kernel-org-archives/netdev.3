Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBB407CDC
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576263; cv=pass; b=bBTjkRmIr/4nWI5v5DdisMLvnBmySwsuaYzGIufK8AKh/shjAJf/O+76MtNrFOID/OtK/HmDx8ur4VOf9evzrw8uduK/wT55UMox3hgenuzRYDnvgfpgY3AcM/Ef9gY/IWpIdToUS9SmvUhHGlbToQWoH4UUiHYM5rsGkT8TlYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576263; c=relaxed/simple;
	bh=PtqAQ0oKoVej2Nq1Y6XtgQFR5Sb6c6MUNC/WW8KJ0pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMQc1BuAiNraWJtqm3hNRMXX82XuMVzqWImMSXSYzk1Y/I1rQCOrH1iHSONpYcM0TfD3H7x2RGn2sqzPQFACefBT6IO66tbddML71ljkG5wl4S4+U0yFNDD4s7LU469C9Ka2BwfyyvByZ3NWRp2av7Q/gHQVu7XI/2urlQym8Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=D3RtHGId; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="D3RtHGId"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso2418056b3a.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787576261; cv=none;
        d=google.com; s=arc-20260327;
        b=VjFAC7DnOorsbHQOzOdvetJtWRwDahUSyNAIDT20g4AldcxeFQvZVUK1k2Mm2GGyjA
         h+SQsGTVearnCEL4KfDEfQtEJXIBvoz4/AJHKpxXjGcBeyJ1dZRUSe2GIESX7WXsUhd7
         zMVWmeviSebZxw8vdg/4KTVcLDb4Tn+zr8bK8ot+MtiYLz3m1WW6vBWd5RIdlNLCOrj1
         dQoK6dUj7a8ZyNMbBHdomGGrT1BQlasbjw32hlvw4VFZovWhwbRPUdJC8OWzVNeq8Z18
         lHKCvyTq6SCuyXbtGJZNAhVbMDtcb90xKrj7hsXXC6gYceN66eOlXDBWqH0fBuCGYngg
         WraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YpwkJEWwZwrB+c2PMPM+cq9bGt/UFtX7BOe5WyFbdRE=;
        fh=aoCn4lVrTMSu00EDwgwGiiC/HdVNsNDiJtcpnMwVihY=;
        b=Yl/53xaNDyfkwsUoKcNqrwaAsMhR3WmzyZ3hKHQkCeYsdfAYPafdyG3l5eQh15eeS/
         bkfe1Ji+uI7jxD9YxNXFutEFHZHi3zhduu8t91znjNEGY329TYx2dMQCJZit9KL0O7WC
         me1q/dPklBUiiSMlWUBbnzgEPvntvj0nQsFAN/G/pOp0HZVURzaOjVvWhXlrGT+q1g/G
         eXc4aILjwSVxtUCHix29caRsIimFnqUrHyi2WrMWZNgmQrGkp5zC7A9eydPL1FYOVadZ
         rSt/kE+hoIJ+YRjMRu4yTA8ujbIFXT/G3FRkKRinIRd5Kk28ozjewyssyIhAxS91y/wb
         XXzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787576261; x=1788181061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YpwkJEWwZwrB+c2PMPM+cq9bGt/UFtX7BOe5WyFbdRE=;
        b=D3RtHGIduQBPOBKMh8uXvc853fZjzaFzAZo7SyarK1qssUsV9lQjM+igOs73GTzbW3
         vtF+0C0pYiVxJTiupEPOmyCTUv7CGtCzIdPGsJG6zZ2Qo3Ib/oLNzfup0KCphjh5WfQL
         8PX78IxiNoZs7Y/xTAyNvkWrQn4q/xLD0aLtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576261; x=1788181061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpwkJEWwZwrB+c2PMPM+cq9bGt/UFtX7BOe5WyFbdRE=;
        b=DsIUHlYCUQ8+CazDEzZCRW9T0PFeqJHHf8zI/viB5Y0iDlRolRHaQwEKMc0sk7b526
         sNvmNqugoRD/wf/d+13aFRoKmIE0MIPphlPqh4kbMyAJWgX8Bgb1YxzbyDwyagX9Or7E
         dL0If0Lw0RErN8ONE7vo3rv7EJvM9UMml0l2hFEQNaXHEgsZ/e+Fu/XaDpwWghUjVR+2
         XESev/HmBn+CMdVXodkOtyz0AWTCw2Yz1QXSscTiTkF30M+fAGQon4VkxTuDgDkajk6P
         9SX+MNGFRc5kMGCY2JcPrVbommHVAzPUutOc7eUAleRlmsxuADCmPsgVQvWW67iWIrda
         riTQ==
X-Gm-Message-State: AFuF++nUclM67HOvsIhZpcgcEuVAZN8wur0jWXYyDP7wSj/6qbb7GgfR
	o1TuDXIjsOjEVVLnh4+pWyyUgQNBUioHV0NTz/8iHfErOcJWMHfkZmvMAj2bu7SWpw6AG3dPd0a
	3aiy6aMBGWejcEvXAoG+aCPpY5T8W4O1po15aIlzXOud39bqngWbs8g==
X-Gm-Gg: AR+sD13UaMvXEIc8/2XDvT5mt9goOYx7qqVdS8vngXtBI+0Tv5Ee9vloCxuhRV64z+9
	WtLeSVkwU+klTAJafwgNtfAYW6oOH+K93dKzrDOPUI3aw6l06Y9nnMpDGVFMNyiIGeMZblOmMFh
	kA0xODldWc0eO+AZ8dba9ZUoiuQs60JQZZKlJviIrXSgIWlQW3YDZqBNJvkfv1pO1HWKyErAGT8
	FNHeo/4zgn9+iaKbdsMFQKSE5K4YOOiCxA4GiWpg0TJaY2gYcF/UXRRwQMb7aa5Y2Vnv9RIjnTP
	hU+1ErIk3ykxJ1XU3g8auDJSUPs1ahyUZmcGGmjq/I8oWbhlOegoqlLR6nffDK2K
X-Received: by 2002:a05:6a00:4c98:b0:851:8baf:5b29 with SMTP id
 d2e1a72fcca58-851f9f7c38emr44269121b3a.10.1787576260866; Mon, 24 Aug 2026
 05:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822222049.114526-1-jhs@mojatatu.com> <20260822222049.114526-2-jhs@mojatatu.com>
In-Reply-To: <20260822222049.114526-2-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 24 Aug 2026 08:57:29 -0400
X-Gm-Features: AcwNN1Utz4tcFplZHyfRgUCEzjn3PgZ7e8RiXBTZQYdUytqeISWfRToi_xcC0fg
Message-ID: <CAM0EoMmMAJiM7m0V8kb_x_gzXBMwMvLv_6HvGH=VyuQJHVx5Uw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2 RESEND] selftests: tc-testing: add u32 node ID
 pool exhaustion test
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 6:21=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Add a tdc test case that fills the u32 node ID space with 4095
> auto-generated handles, then attempts to add a 4096th. On the fixed
> kernel the 4096th filter is rejected with ENOSPC (exit 2). On the
> unfixed kernel it silently succeeds with a duplicate handle.
>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

pw-bot: cr

cheers,
jamal

> ---
>  .../tc-testing/tc-tests/filters/u32.json      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json=
 b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> index b2ca9d4e991b..039bb8278a60 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> @@ -353,5 +353,29 @@
>          "teardown": [
>              "$TC qdisc del dev $DEV1 parent root drr"
>          ]
> +    },
> +    {
> +        "id": "934a",
> +        "name": "Add u32 filter when node ID pool is exhausted (4096th f=
ilter rejected)",
> +        "category": [
> +            "filter",
> +            "u32"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$TC qdisc add dev $DUMMY clsact",
> +            "bash -c 'yes \"filter add dev $DUMMY ingress prio 1 protoco=
l ip u32 match u8 0 0 at 0\" | head -n 4095 > /tmp/u32_batch.txt'",
> +            "bash -c '$TC -b /tmp/u32_batch.txt'"
> +        ],
> +        "cmdUnderTest": "$TC filter add dev $DUMMY ingress prio 1 protoc=
ol ip u32 match u8 0 0 at 0",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC -d filter show dev $DUMMY ingress",
> +        "matchPattern": "fh 800::",
> +        "matchCount": "4095",
> +        "teardown": [
> +            "$TC qdisc del dev $DUMMY clsact"
> +        ]
>      }
>  ]
> --
> 2.43.0
>
