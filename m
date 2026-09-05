Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F9330B09
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788580626; cv=pass; b=N8x2aB1RncVFjr70D4o01uhmGaldGPMQGg8I1bBZeC9F1Mw0HyILSiHYwuGoKJx5uBRrE92HVRAju9leDFXVSCLEGfnHwEAUW4/f7RXOjHZ6C/ndQiWtvQY5+8Bff5tOnY3k+p0KyR62mI+i0zSSAp8gEZkzlYh7P/A59V1zPKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788580626; c=relaxed/simple;
	bh=I9LR/YOFTKqdgIxMctYxsuJb14CMUFkCc5k8rVoZSkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX4i2GSH74W8zHROIN9qvcfy8cvLOowXXKBMXpVTKIl9nsF+Zz7jRUZYwfbtToSPYHOed1te1roXcC1nr3tbjM5R4qNi50UnNZ1X8ijnTDdM3ud+ydYaXAiAas/qoAqIn3Bdn6MvctTRGr3+SwDzsTEpAcbnyGJ0uycBxDJv//4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9rqcmLn; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9rqcmLn"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2023800a12.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 20:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788580624; cv=none;
        d=google.com; s=arc-20260327;
        b=IGM/NqwFs78311uKp5YTfrOeg1++jug8kMS/jZc4ZtpE5FrtPkqJp8hmPdtF9NX5yz
         CdiqtClOZC0BrnOueyry8DqDf3X205BCKQSBs//VIZ++hUaZhcdfxBhdxyRMzPnyZaTR
         CGwat0jx5PIPVSfj8BLcG2ygM3Zg8t4d1iAO9Dq83Yerd8KI9IBzr4HNv4ocNe8QrMVR
         wKG0YpndbOhOi+kE0GAzCTBiSbwo9zT9kvWh6aelR2YDiqnz1iVaQBLdHOIeFyVU8cGQ
         0gO8v1jSHT6gRdxcW1+1YLDMdQaAibXPNyW5WJiTm9sUjXJXnQkQFLheahYSuvcRmJr/
         IEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g2SybOKfYwNLLqPuOlw67kWGnE97CPbyKtQUYXmDRnI=;
        fh=ZEqupx/e6ES1JdDVtwYYUbPu8nB3s+HueU8Gxq+C8wg=;
        b=VpQt3Mt8qb0i5nmmMdlz07NmwV+73Ar2iWuKE79BDomkvT2irm9uN0ycjRcP62T4LN
         jDBu53Hf+nVZPAVMpFCjHniSTOtPrIFatMC7kQC1GqEJ2Lns4IZzHBmlZqzOcSjWI5HN
         16rM2OdYgON3h/E3zLZt/tXspYxi/ZMx0WrexE1vY9hjs0cCS2kra0YyD5Y8Oi8FdJJW
         9t/a+S4dfXUHy0EaX5Uhn77LSLOLeEARPQpHhQu3o2SNXNnfe9bglHxzXG+CDnd6qxlC
         Ue46Q1BRy+zapjBpnU+ITTZIjKMHScxNII/TT6NYt7X5GQPIKQTUHNXRcolGcAP3RkEv
         auzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788580624; x=1789185424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g2SybOKfYwNLLqPuOlw67kWGnE97CPbyKtQUYXmDRnI=;
        b=s9rqcmLnJ1IYH2cShNFXKXA8bK+vfb5tUE4R8bFxTmPu1gyoqz5PgQGw3ZhpDurBm5
         QQBVtDiWE172PkeIJc5Jq75WKdhOE/TxU3lXYbZfCbbbKkTXZCcGeds3do2EkeSMMgud
         w1E7yfzpi2SN301VFjCKtRs1FeP0UxuAxJj8kl5oISL/Hweg67eLIrVx4yPXREC4F7G4
         hTWVH/eQPBazvtY+cFJq5sbhLTtFIb9r4xU7RsBp1WKXEtDoIfGvGPlQH1VSL9jcvGZw
         Ymf/wYRPSo00tCJqwHrwfYgvFN+eIUB7WOP9hjeeIg+HGu1u5/XXpep3le6+4MnBVOZ2
         486g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788580624; x=1789185424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2SybOKfYwNLLqPuOlw67kWGnE97CPbyKtQUYXmDRnI=;
        b=NoJ8yrODWjRRf5GsPcxtN1nC7d4wJRsZRi38x7tc1OyOPLZyqni6sfpqv2ar9TAnXg
         0JCdlsI+rAdKzAR12RzzaFlZD//77htVdzjkPzX+XQz9TTtW2q++yf80qq2CNPaZicGh
         aeGJ4aoZujo+EyShC4Et9cWc8YPh7WTWNGYNdaBXjBzx3wUOr7+m9Ds+E3VTkEYZ/Ht8
         pNIc/C3RwSuGQkakrz0yLkGsbP5WhLBimK+qg9EWU4i7sPE3AilwwQYuMc3bEGbT7V0h
         1zV7RBJSQePHJFryhjofwBikk3Yb4Oq1KBGGHL4TatMsnjqqiESklMAnuwN0kr2gLq0p
         kuGA==
X-Forwarded-Encrypted: i=1; AKwUvBx0iz2QF6qBzJSeCG7q+FPQpCpuyzLQXqpcCWRK4PD5OEjpKoTTlgMxrkF9R0gdJddavLgIj3c=@vger.kernel.org
X-Gm-Message-State: AFuF++mEsbxhBRFcsBxpzbgevlxCY7PgqyG0pDjU7J5r4jFW1MCBaySr
	9avfTa9pDlN63/TJnysoBPDwNz7UnJSQw5OExjcGdgJ1QJ7IN8ylwUMGNZiJrBO8lq3gXXwThuK
	MKcSrc82tS0x8VsvvGTvHRtJ1MD4qCJcSOuuXtz4Y
X-Gm-Gg: AYBFou1X76azApEvt6QzOzIRmg/ju65qwmDWQMtPbowVWZ0h0Ljv6ZuemlpvARYk+nq
	L6Em7GB7mR6tSj+igtMc8pf67x1u03fvPrwOm2WS3CaKRPwGNZ4INMsncVO0nXiWJmNuwd8CqFx
	0ubbHgjNqe+oXUdxM8n2463wahZZM+Ik3lKmN5/INv4fH8cKk3z1Q+4FqFc9CANl/uMl4ylN0XE
	z19hLqUSDsaSP11ywnL0gMV8f0hv/5d4SgUw/bDcJq3t4SnPKZ44IQzxI7QZmRXdFqDHfH0pamg
	Ef2U3pJoGClVpyfPHG+iw0aWEljVVaQby+tWk8LVQ8NYA4os6Ijb1Q8gvDun+eKG0VopdJS3F+i
	UmYTa9Ab0tlxeg29eSJ2Qx3dJe10Mw3YH8kipeMBGxgE2/+c2naNGIG+H8kpt4QfkNWX+Fb0401
	/lr2GXoInaBIJe
X-Received: by 2002:a17:90b:518c:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-39b0865357bmr18884715a91.15.1788580623576; Fri, 04 Sep 2026
 20:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com> <20260903120840.1024153-4-edumazet@google.com>
In-Reply-To: <20260903120840.1024153-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 20:56:52 -0700
X-Gm-Features: AcwNN1UjlWWh4hKXuEXNwBV0-YkSlLAsCnV4A9HUGl938p3sp2PBr6g4EJROwa8
Message-ID: <CAAVpQUBwW04hBPFeScVpfU6pbBdQrHiRXZ4A2xUSuLswS_8MsQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/9] vxlan: vnifilter: use list_for_each_entry_rcu()
 in vxlan_vnifilter_dump_dev()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> vxlan_vnifilter_dump_dev() runs under rcu_read_lock() without RTNL when
> dumping VNI filter entries via RTM_GETTUNNEL.
>
> 1) Currently it traverses vg->vni_list using list_for_each_entry_safe(),
>    which performs raw pointer accesses without RCU dereference barriers.
>    Since concurrent RTNL writers modify vg->vni_list using list_add_rcu()
>    and list_del_rcu(), use list_for_each_entry_rcu() instead.
>
> 2) If vxlan_vnifilter_dump_dev() returns early because VXLAN_F_VNIFILTER
>    is not set or vg has no VNIs, cb->args[1] was not cleared. If a
>    paginated dump was in progress, this leaked a non-zero cb->args[1]
>    to the next device in vxlan_vnifilter_dump(), silently skipping its
>    first N VNIs. Clear cb->args[1] on early returns.
>
> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata de=
vice")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
