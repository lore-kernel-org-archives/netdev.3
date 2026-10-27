Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793105102;
	b=ESldD91bq7SWFQgVwagLtsY7NgpqraroqXJfKSauofD33ZBhOASd0yBHbBZ2IMj8Jtd5
	 d39DsD1CHS2aj9wv/nE9636qWeK2uGtGPWYDbfjnKVxBGQQbJwrj4aj5wtMY+rElyWqx4
	 OR9brtOXXU6PByZaHFACewZJ+wRDddhRhKJ8VE3MxyHKXsADSjuxM4Lk0QoWln+RkSYSA
	 eZPag+fS88SVCxtfqt5KkaLiF08/PwI1O9ZvuoaPsfH5urYCanhgRikZK/6kMJmGALFL5
	 tR/C/Kla+3PcBS1TnY4K+1jd3PuuU+CcpM+pZb206b73HC0C0btNiTmbRH7bHJyz/Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=s3EYuBTTmVhTSEPj6dV6TX9HIoyvSVBfIfq2lIa11uI=;
	b=wuFRdWg/jQMYnCUWMO2waFkgK1mQ7JAPK0lzdpo3zHWW+XIFemfcVPIual/c5E1b5Kf3
	 ZHd4sRpDyPD6B5+c2xOTvSylisoZ+hHbjMumkWgK5e9QQb/1QW2/BFZ7SrxR77prLUhUe
	 p4ETXXjgP+h3H1Ho/8C4WdDmtBaS5aaIxriYaJAOK0TP/Gu0Loypeio6E5xBPhmUQT2YO
	 Fn2rP7QFG20SjhwQm/yv+ONo6cdGZ+xQzDKAmmB5KO+DNo5XtjDBOZc0y/ge3XRARqrlW
	 G+h39doP4PawAaF23kT8IRo25/4kMqebS3ikvUUy1B5V8lkC+BJ64b8b0AD97zc0QFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ZUOBzw/p";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8339606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8339606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZUOBzw/p
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8439fe796ebso2799706a34.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793105101; cv=none;
        d=google.com; s=arc-20260327;
        b=pxkd1B0ulbY5U7luSHxWQ80KzkNuDYHnmxcgJ4ACOM7UBT9kk7WcRyTXrFKituCCwG
         dldeLZX+bCPvwsUGSwwrClBw0XzOj4yoWYdOQIa9f5IN1/SJjy0Tv0qqy+P+O5QrxLrU
         OABV9bOrTUvobRAg1M6JEGioERmFJaLpKS+w9jsSduRrqdDCFAvEZodbxjfibwc1SwfA
         nkDcMR740OEEyW7XoK6bXzfPatMSBDI8IQFviQZl+8JGVuUrhEqUlv2Advchmb0HNhxg
         i5JYi9BPU3DDdz+O7aiAkEYBH9xShq6Tr5VW6v+ndZ6kR/0x4oBKNhDLdBRSofqBy3wI
         u7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=s3EYuBTTmVhTSEPj6dV6TX9HIoyvSVBfIfq2lIa11uI=;
        fh=akAjMMDLhRPyUVfY/AJ0GVkG4Nm0krDBGtl58dSHTOc=;
        b=k86qWACUNWtxoxdaQjjjsT4/EzGqrqnQ4XfcxDE+LxsWm7Ack1qwHXF1T2nKAiUwnc
         6Udu6ZaZpNLha2/V0rGi/k5TClmMvoEzRsr7I88lqxE763wsJGWTDOyEwAPmm0o3/1J2
         8kEwKaodsTSjrFPG/QmlLFZvvYsEc6Xw7RGbro/VejS2pW03ODq6RJfKdmyFP8vvs81e
         2h9q+5Wipja9yJZrAdMQKjHIOnZq4LBwpCFGU24OfF5+T/ItTlhV1kiIcdSZZBcyBznJ
         JoM9FLMLstUlJb4MVflPH7zhPf0eG8nZZPCldeVPob7+VPxjM8OVJAesNa/qEeSqzwqN
         odUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105101; x=1793709901; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3EYuBTTmVhTSEPj6dV6TX9HIoyvSVBfIfq2lIa11uI=;
        b=ZUOBzw/p7m8KeeHwXA3quTJfFdIULTmM3ehGFEBoTt0YEm9WBE///XebirB9K+GcjT
         X8AyRearg10v9L1140F/+9XhKxaoWZbyNCgCOek7RexPA2Jl6fe4vHkeaBZLZ5fPeVdk
         SPCF3DJCaDtrzgOE/xQQl1PEs/DwnGYx5P7km94wV5jKtF3xgEn+pkvrf+KON/rQyMgV
         wNEfYgR9EJPvqe2vwSxUEk3ChxmJ8hUGdkiQCudrvt+u2YHLkd4TTVXtq29eNT2T9MNZ
         U3zCLsfAioeNg4r4A5z7xASqQH4Ke6OwLCHlGPszXIXRZYpye7olhKWw6AHYQ2BqXU82
         7nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105101; x=1793709901;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s3EYuBTTmVhTSEPj6dV6TX9HIoyvSVBfIfq2lIa11uI=;
        b=njlZLyAPV8BsruFwsbPDFUgMponNg62EvVV5tWAyWOzQ3QbNb2aFwG3EPRf58zuf6f
         ZuaQKPT0+BaH5txeiSMvGSy5WOqR/B18bqFKY3p5H2fbVh4BFrnyq6UaMp7oX9n1TVhx
         mUokVjqIt63BXh25GgdMQx2A8qH0jPfcsmPBP71yQEV6INj7N7JWJEdWpg5kB17AdjQd
         XpM+0hv6Q8uoDkBasacxB/9dcAGq+O6QWafSMgdg8nwkrNeMj68hbbvXMU9WfkW6tASH
         2RMqkZcvjOBt50yOdvSNfAsF0NAYa/GFj0+odosLTbn/OHpafpleVb7myZYbF5uU3bkO
         PYYQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0UQVW2OnaisO+1ZS6zGAUFgvDvcQf11LAU95HgeHzzHMLWM2Xz6nlYzz3o5dYjSAYuEWnl0s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKceS6MryJY7IPTd1pEHOWcCThHTM+6MGMfRPA/dlneDDX15scc
	eGL3n/jnxw3XkB2yLfwymNXhbiEALjcoXhn6kZXY5pRfOdWWwWHNp594Y8Er86vhpd/7UrZj6+e
	61oDuGNHvPLfrMMlRfw5cLrdeqLtfOyQ=
X-Gm-Gg: AYBFou1sgOpX+oIjCtt4CUVhsAWiq1RgUHgDmBdWmF6ghEzGslfiyuRkf1Fxg6InhKr
	0l3gkHbsN4k0zoj/VXtWcyljV7gAHQPupOFSaaokEjMk6LE9N71GRQaY26v7kIhVcQeaA4qCOwA
	OSs4i+1peqzN8iDqUMnJZ9zbP9TzYgsA9zV63q7/E+EM0uAyoe9I9QZeBXrmauttUbaQSYZBEzC
	P9sJhtl045mUnAqs1rRxSoF25O6/z/6aUW3qSYaT7vcZwBJ/vNGsHY8OctOO04xfBqzy+Qp+FNU
	xgc3FBtdBv2faYaDdpUvI4ySFFcNU0xpGHqNQqsCj6q8sLH0xAkRG9ALT9LuD/o2Ezxht1Fc1cJ
	NZcemdXhOpWiPz1n8zNFJchSwwytWoTZVn4K3K/eWScz1b5unobMj8JMQEvmCfqEF1YkvQ2nqcp
	kZEGCOYJIgushIee2LinueCEM=
X-Received: by 2002:a05:6808:4f07:b0:552:1042:5c35 with SMTP id
 5614622812f47-55c0032ba03mr6286078b6e.41.1793105100960; Tue, 27 Oct 2026
 05:45:00 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-netlink-dump-livelock-v1-1-478214a635d2@gmail.com> <179310175111.3134.9177648236285208856@kernel.org>
In-Reply-To: <179310175111.3134.9177648236285208856@kernel.org>
From: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
Date: Tue, 27 Oct 2026 13:44:50 +0100
X-Gm-Features: AclHuK8vtyo3SzVDHFGolZX6XEU8zK_Jh7QNOxyA31mgL6WcdQ5ELfLnY30XFg8
Message-ID: <CACgZWq4DV10PkksLhDNp+RxtTGNyuA1m1YmzTZJgkybb=MfOWQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] netlink: retry a dump skb that does not fit with
 the minimum size
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Oct 2026 11:49:11 +0000, netdev-bot+sashiko@kernel.org wrote:
> - [High] The fix is incomplete: the ENOBUFS livelock it targets is still
>   reachable whenever a minimum-size dump skb also does not fit.

Agreed. I can reproduce it with a small SO_RCVBUF, where the
minimum size skb is rejected as well.

v2 will rework the admission check for dump skbs instead of adding a
second allocation size, so that a dump continued from recvmsg() always
makes progress. It will also address the selftest comments on patch 2.

pw-bot: cr
