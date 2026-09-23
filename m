Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2192C21DF
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167796; cv=pass; b=HFhzASdd07jbDi3/S9/PuY7TobOGCD2kqJ1XAdlqPTyqaU9FaAIvrM+XFTY8CRBLheYbK84CbHlowUFwBBZf9g84YZy4qMLpWhoXP/a1h/AilvONQztbczSkCkKE0s1sMuPUFWomcu9JvUvi4FasjHEaSf5IfgjSf/qpDfQ32JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167796; c=relaxed/simple;
	bh=WczYCDXqUgoVXGvzgCz68aujHcgv00ejLg+b56OK4Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nN3NvuHYmNHCgTbFGipfEAzU77r/xMUVWiWd13PjRhPZZ02XpD0V1AqHWmbotfnS1MGCO84LL6OnELZUly4BLatyoDZzQ0LlTn7C8dD+miT4lbfIL3i4CO8HCoP+1JsVl1iFVzEYzRkI2F1IjPk6GU4mZxFsn1tuimpQwH6TjlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9yeYGOZ; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9yeYGOZ"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so486164a12.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790167792; cv=none;
        d=google.com; s=arc-20260327;
        b=nEifH+HkVkqofU0UfeTPjRqI4KLv1na1+9OcAhrnMaAkXJJWSp47PH9xime30H5cz4
         xUnm5W2vMc4vmy1d+DsGnV6rNzZZWfYFAQgKwd53PByzYiIVzvdZaZl7GRIbeO1a/DhS
         UTIrbs8YCSNrrAB88qMPwbdfIukIDcpk3bnHSraxMFUScGG0yf3xi02izrDO7aPh0tlo
         SN5RN18UhZyIdLAOSp6z/Pj+uX+NCzkpIb6CV44MowzZt7t2ypN5vKo65m8uvWiSrlzb
         H9CRCimz00+v8WZMkrr2wiIhgkafAi7szNaNqzZgWT+CDl8t6M3FfAxt5ZHsa6O282NY
         nq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WczYCDXqUgoVXGvzgCz68aujHcgv00ejLg+b56OK4Wk=;
        fh=EyS/gdsIWEiCKzvBi8OmAp+Q0R0sohrrskAbKpbT73o=;
        b=a2XP1jBzm7Xkr2AcCE+ggcaX3TeXj8qve7NhYQKCSYorj0Ex72PGq8S0mHL+3icWhV
         I0UciQbQPBJj+tyC51MzMe3SP+i1HJem3N49jsMgj8e4bW8CwJ4DirdYNka2i5/KvjTh
         B5Fd4kNwysVJkncR3yU7tWb2r0FPIa9MoHtuAjPAK674/KFEnKlIaQ4WXXKW6o8Od2oN
         SCFRCmAHeUvRmq0AGO9aAYSWUIhpxj4Nr3wJL+wcWvgbg2mwcHBptjTzFziJ1ywtyIN4
         7OAUIZTdMQN7XZQOYI+03WsV9nu2zmvzX+d8SJ0YebiGyai0TPywRDGGyU6DUbnKiE+i
         +clQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790167792; x=1790772592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WczYCDXqUgoVXGvzgCz68aujHcgv00ejLg+b56OK4Wk=;
        b=k9yeYGOZIzqyP+uZIwcnCLW6uVKp7V8XIDsIJ1B4uedji9gIG5G7tecfoHTIwnYaNn
         /VeHneQIHSc8L716N2wtTbgB62wwW/3yeQIAt57zvdiNSNxFXYI+SBpVEyFs7Ayojt9x
         ZPHQOAnUXLuXdak6knyhHEl3FqqoTThqi6K0aIVnMmUej1A2Eh1FSv1r4Zmn2mPbS2ES
         joAPox33Flyv+oOqO3s2U3/UAmubUkLeiIG5MPsAAy9f1OhVxdiGHnJkjk1mKj8pQVbL
         91afOl/gB4A6takK9biJc8rIimf/hMndUnD1KL+608htzbxuGA3kN8HOqOrHwUdsve5K
         X2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167792; x=1790772592;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WczYCDXqUgoVXGvzgCz68aujHcgv00ejLg+b56OK4Wk=;
        b=s/k5DNghZrTw8DRNtq3xdsc8n8GvMX2axpS3yFa6iUIbVX53kgBuoG/+RIJW72OPd9
         jtGtFpRx+rDJ/M/orxWAZfaKEhdK56FfCAUZpITqB+3uTvohs3WpLt77gvspDzeQ5QGU
         krnWWLsqRccx8zbWdeAbaNJtBmaEktsXszNmZwS7LuzVRxLCXs5wTnQGUeXSocAgRpgZ
         tpBmHfwgZkwWSwVh1spD8EOXgHl3/T0UMA1EIuEXO4H1qIToPRT9+e1UGuYN41BP3fDA
         UVI0331kzUKESsJzLXtDtNsyS2iUvW8Z5YnJhW0TTQd4rDMv6rf2jk19B0e/wxpZ+nLJ
         YoHA==
X-Forwarded-Encrypted: i=1; AKwUvBz335y5G9Mr1HPTYQ7y6QokxSfF5mpZKSr/77INy9hDsQCxpeI3fbFIohnuRSf9FOXv+i1o9cw=@vger.kernel.org
X-Gm-Message-State: AFuF++lmhho7MglnNSANp6bE/pVwTOFuLxs8OZ162l8TWCZUUvdnpEmo
	oy0dQcHoerwIV3YSWQwWPpA80jvLz6Nz+uCtFj8OBjHTvq0d4xmm2NR7LWmRsNnIvJuM5Q1Yzfb
	M7XMHgV2fUkfqtwFvUT+CUiQvIp/QZDE=
X-Gm-Gg: AYBFou0LGMdOGg7aqbylTIlLxS4+w9u6pXuyyBLpTxeActMIKfOaDfPgIVwt0fp/rBg
	Z7VqHO/WXJfs/ChcAMXsyyLaVnD2Hyr8wtB2RZ6bu2iconAAE6lwRlSuaiopGGWIvZo1UxmdvQW
	CEJGPVv0tJO33pTgsHFkwBBj101NRob+3P3o4OOWFE+OpsRGA8r/q02feQTNxSqoygaoRuuea1P
	byv82EFxQEoo452/dPTO6CVeLwts4L5wu5vieLlJyZSOfXwIR1Old0eczs5Y8B35w2itHR0RzlV
	dbULlvbkhrmOSJgzZJARq+hSKV3YPqMff9qcIzwMMS1DIOZE9VnlVqj23g2tL8y9bxnDBYglnMO
	r7VzbG1sv+NzGpGFfg+TrjCKQBt7Vg83dihoMUCa1FqxomE/dzFl78OtsDVIqDAsDcaq8QMqM3I
	hnFA==
X-Received: by 2002:a17:903:1a27:b0:2de:834b:b594 with SMTP id
 d9443c01a7336-2df69e1b831mr20044595ad.74.1790167791713; Wed, 23 Sep 2026
 05:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731120558.558957-1-david.lee@trailofbits.com> <20260923080440.83800-1-juny24602@gmail.com>
In-Reply-To: <20260923080440.83800-1-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 23 Sep 2026 08:49:39 -0400
X-Gm-Features: AclHuK8q-tKfIXpOtBC769X0FlyROJnLC1fznk8CJsvtBkQX8N7_kYK4qoM4O3o
Message-ID: <CADvbK_cYWhx5J2M86hE_PJdoS5-KMuMjO8s40=+Dfhx6bsHkOg@mail.gmail.com>
Subject: Re: [PATCH] sctp: hold shkey across socket migration
To: Jun Yang <juny24602@gmail.com>
Cc: David Lee <david.lee@trailofbits.com>, Kyle Zeng <kylebot@openai.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Dominik Czarnota <dominik.czarnota@trailofbits.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:04=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrot=
e:
>
> Hi David and Xin,
>
> My control-chunk migration fix [1] depends on this patch. Xin asked me
> to wait for it to land so the dependent patch would apply.
>
> Xin, would it be acceptable to send a v3 series carrying this patch as
> 1/2, without code changes, and my fix as 2/2? I would preserve David's
> authorship, fix the tag placement noted in your review, and add my
> sign-off.
Sure, sounds good to me.

Thanks.

>
> David, could you provide the missing Signed-off-by requested in the
> earlier review?
>
> Thanks,
> Jun
>
> [1] https://lore.kernel.org/netdev/20260804113705.45754-1-juny24602@gmail=
.com/
