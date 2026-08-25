Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53F3FF8BA
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657971; cv=pass; b=UbNytndA0zUHupY/sFT4TKrrAHsBOWi6uRsIGTMC2o2VpZr7aWypdF0GINuXJsu6UCw7iJzAe056Z+R/Y5o3ZU5/ML2q7HYw/xNYhUxYIiodtfZgT2Tux8osd9+EzQMZ8aP2+g+JTbMHWK2pPfQdTfiSsMG060vLimZDjsPPeRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657971; c=relaxed/simple;
	bh=BeLdhDF9y5Q5SXx19u1tkJ61xmtxMDfJUSUet9PV9+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlrxujWFXY+GGs+qdNU6OQgciofI8p5voDfk1HbM/13syqUbyC17DIDJwPGIGFOIWoWqKaCHthbqhlyptN8ENfjypHMh91+s159Mzi5RP3QR8MQIlqb6uNA2hPvFdz/48x7oqcuGpd2cMAMJuUbsiwOe8dXodKDccgjhddxnbs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoK2SJnA; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoK2SJnA"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a1f628b0afso1806061fa.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 04:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787657966; cv=none;
        d=google.com; s=arc-20260327;
        b=kztGS/CPeVck2q+EDr9p9f1PmYyUfqiVsoLLjTFelvffCqKyfFTTBbX+FmnBox2cdy
         6fy+HrTeljhjDq9jjRyxevghBOVhz/nphlT7esL8cVwcp0n5B0oXFgWcG4y3LifLpdvo
         oOCn18x11uv9KS1WduvBrvcCMnayZNTbZqUQbB3FIKBcA/SpgNqDvJ5ibvu2oSoOrA3K
         h02fLJG13jpeUzZ3foMYLQdrq5H/9x9kdkT5PDDTkYQz8pwytqiqbBqIcodpokssUPTK
         vcfaNGwivZIIxqkrps8IZc3BoC6XWQr39LDMl3r8dGap12X1JwkbE2cPAlv6JHynGTyH
         IVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWG+md4j2PNcfHubRAWpkT3PHkqwBg1+dLd3rsTqY4Y=;
        fh=kRmstzpE1HZOOeRU0Sb6lZE70+QDyja+B3OQzWMdruA=;
        b=LuooBrHoQvBXX03wBWYrmxYdy/ZPy0CHUrFSIz1bAKXPj4jK+cAG/coj8EolvKq8S0
         Qtup2S6sslev0ztaIjJqLyslOBuROiGp+8X/v7NpnE+SEkiL807i6fx61NM8j4t0Vzcr
         9uXUond0d8btCWz3DVipQhRxfy6QGVc2jkUUT8nPYLaLIB1D70JShEaWHcVy4Zs16QgW
         sj5Wx2udz8yWqSrp/ULOIDb7yyj1daubVLtb4+kT5uWw7aZ7KNi28wcRfsjODUOmbftI
         3EXmBpVWg0tHHho423gyVW3ohNqduEjLU0Z9ifRAAnefhqYpenZFPcgwg+SamP1XaiJA
         SHbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787657966; x=1788262766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zWG+md4j2PNcfHubRAWpkT3PHkqwBg1+dLd3rsTqY4Y=;
        b=PoK2SJnA4H4PrKFogJeWbClORhi22fcfiBs0m+alBjP/si1st1UvgHO19hZ+9mZrd6
         luz7q4GTUJppxU19RnHeqSeWWXQP1HkJARdpqWbOUeiejhvf5PiG8zIoLyJu3UbtzoJR
         OZT4fKSwT5M6Ma1qGY68vvXQCl5sanU1XpchVHpU+nVlQQyHxvL3LYvGtEOhPcromEAT
         4aiVYzAUKNTGLKAfS0fU+SMzQr4h0ncGxAVUEbopvJAD6pSDKhH5LV2z6g57Bv74ozrq
         4FON4hlddPzA22PeIX8u2wCbD5/bTQDdo1YhTh+0JBgha5aWJSVPgZN0x6KjF2SkFY9J
         KJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787657966; x=1788262766;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zWG+md4j2PNcfHubRAWpkT3PHkqwBg1+dLd3rsTqY4Y=;
        b=LWU6pik7fGWg9OVWlv2+0uX/f3+7ZoGBHqQju9dESlQU+WXwRW3hcXswN7tKpYyyCX
         lrGPTRdvbQp0JNrMsSeR1Xerjoi7j5sxcLM+V3+s83/zRxMbUpBThrDE9O3K/p1MkGWp
         1/k6mpPDBIegS9oroWwyBCvGJPBBA2hcl0NnWrQEq8KqNBdEHfK8dCQLiq9Q+uhrb6SM
         VWVFnA2JLztTky0zvzWreCFZ/KGe+oXi4LI0lM20jiUwUCFAPfGZ5nHEBqN5Ljorw8v9
         2yDeo65ZhijeIHj8i4a0PPZKgL9jgipbyyFvBDOQ+PsyEI5/mIQS+ts42PRfrgAeizDk
         /Y/g==
X-Forwarded-Encrypted: i=1; AHgh+RrNOAoW03XPlHK+bHWWSlwJBvRdx0lqBjCUsvJJKbdaSYZsw4T24ra3JBF8fecMboycpWtg6KQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nMYlNNB2uhipeCJTxhoCMcCv8v9tyCO5SO0UN9ien4xWtI4k9v
	UWUtMgRavh4tpHbD/QG33oGQKc0v5+jxwwS+Q7k+bEfmbom8WAM41d2Qb+HA0pL75JetVaPohtM
	tkSIXdjWS0PJ+Z+Z5exhp0ezUpBqVl7k=
X-Gm-Gg: AR+sD13CO5sVGLYdYMS1tOl/GN70Sw+Ctwz4yqNcvLBuxUE7RzkSmYDI7ADj6qMJIbD
	qUst+r2pXe1s/5B8a7Gc13pm546iRrdYLjen5b7ODXeDW9Ip7KfTSAveIbCTMA8WVW3SPiS3pTE
	YHzC08R37EGrYGat4YrGnRx8AV7O5z7W/dAsQk60ZnTT2Ogz6eCviETkhPvRGojiRVeMB/+BNza
	PeExrjRUMcBduLpE0X/nIBKsESoXFyEujEGqmIsCb5VCC0j4XVpCRaIOLTzT0O79N03uI/CPCER
	VNjrI9aM4/6il1RoXAjsJCzjvdmABpg+wiNXA+iNA/+7Hp0ZxDt9knLv2oY9EqFnLNgwZvvwJsp
	sewmlrdxA8TAUP+hyio9L7p6Q6nmnI52Pw8tWkhBjLa20CWShFBZQp30l0lQ=
X-Received: by 2002:a2e:be0c:0:b0:3a1:ee15:309a with SMTP id
 38308e7fff4ca-3a1ef375f45mr11041461fa.7.1787657965390; Tue, 25 Aug 2026
 04:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-trans_start-v2-1-286b4d6d70cb@debian.org>
In-Reply-To: <20260825-trans_start-v2-1-286b4d6d70cb@debian.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Aug 2026 19:38:47 +0800
X-Gm-Features: AcwNN1XjQjXxu_LWWSVa3JvUT2ke1vsS37UH-HzsyAnH1vl-dmsN4iUGVuJN_ak
Message-ID: <CAL+tcoDM1WD+Nbc_KXiOb-ZvfBT+bFjb+czDkGF6Nz81MS8paA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: fix spurious TX timeout after dev_activate()
To: Breno Leitao <leitao@debian.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org, 
	Nicolai Buchwitz <nb@tipi-net.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:56=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> While debugging another issue today, I found out that my TX queue is
> reported as stopped for 4294907392 ms (49.7 days), on a machine that
> had been up for four minutes.
>
>     bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 28: transmit queue 2=
3 timed out 4294907392 ms
>
> 4294907392 is not an elapsed time. It is the value of jiffies at that
> moment: INITIAL_JIFFIES is 4294667296, which leaves jiffies 59 seconds
> short of wrapping.
>
> dev_activate() runs transition_one_qdisc() over every TX queue, which
> resets trans_start to 0, and then stamps only queue 0 through
> netif_trans_update().
>
> Stamp jiffies instead. A queue stopped across dev_activate() now gets a
> full watchdog_timeo of grace, and is still reported if it is stopped
> that long.
>
> Fixes: 9b36627acecd ("net: remove dev->trans_start")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!
