Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A89468C22
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546090; cv=pass; b=Q3SLfe6y4QUCPYsvYiqEgQrygHCn/FptG8cGLf0ccu2TJivkT95CBFwRWHl2WS8Gy4NveR4mg9JxDt9Hh5T/bJP7XaeauMnVVpTvRRRGXUzVEglNRdzXpjGTfVhk+KNGk5xzqA4zSWSYb2qll4ql7DbnAi4FKZwo5V/lNyfLbo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546090; c=relaxed/simple;
	bh=KyRouPkzlT8rYZU1MroXIcZmKsT6ZyhKSTMgIpK8nEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aarj4xg7ZxWnWEBNuWjzFI/0spdfdtRAshQRsv15WJLKO2SHj6CW0KOmwgwexNK2IXFFGWYe+/7jxaiiqwDluPpJV9k+KXnz5xuT7HH90Gm3hBmmoZ+eGGA29TYSVkqbnNGLHIMqOROjeVwYsrB5/m+Cvrnl2ZcNVHX7QBd3PCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tOokjULn; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOokjULn"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1111227b3a.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786546080; cv=none;
        d=google.com; s=arc-20260327;
        b=Ux49fvpfUfOyCSfwI5xEDVEvh/mHLUQDKdd305tzjIFHpqPlF77o+RyZk0AVoGVQX2
         UDx9U6ipNkyIdpd9s1+Avzmitavxiow/3P6VZYBphyGCoqMa369NGc80Hdn/FNFC0zZC
         HImzPxPz+zteXYY9ArKxc+/8gA3TdTeA7VVCNe7qcTpmI36mBXipghuArSB7m6aKLKyr
         kYb+s2CGA8lory6XPDYGMmU91M4yf9M7hFgWxBnB4mJKFgBH8McE0QcV+NzCjzBPze4c
         yqk5mhV5/2FRtjnUcDCjLSb7jPaNEd05h0r6DDuKv8Ke2wBp2D8Bd0BoWtwJyxZ9lMH8
         JsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ly+eS6auCcsMiu+Z/Trwar5yfkD4ejbCJRhO7pUpTkI=;
        fh=zCkyhUWCzCwugBq0RdciNGO/YhJaUWE+vLe767UDg6k=;
        b=GzKC9Qa2dpawvfz13VJWK/kvuiOPToyet8C28EYRsFFKGeSqgxFyFE+wpv66IllcMW
         CNC5ArkR6lhM9DxnMylK1bEtGp856Ua85IvvLlp4JLGZ6vQIxyz/QI6vpY97oLQj4RsQ
         L6T5LX1vIxsGI5aVKPW3ECA1477OUUf9OJ3V/S6EQIxhOe+XZvH4iwIWyH+F993qVt/2
         cL1xD8YzKRrwaKWiJNmD6S5UXlolaXbhTNsAVSwBAl5xb2gtfa9K2Zt5/A7InNQKO2lz
         o5cdXwo3qgYsPp1MGl0NV18E1L4t1Oq5pjyJg7O/52Ub6x8IijOnWr+EVa+cGFXXWT13
         VOmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546080; x=1787150880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ly+eS6auCcsMiu+Z/Trwar5yfkD4ejbCJRhO7pUpTkI=;
        b=tOokjULnNcr4Ed9FT4AqazHaCobmqCpKd5jb+/xlhQf68+42WfQ8SK+knYK7S3TKer
         ZLLLI6e7uqaU5fJm8SXwZ8j0xToyb2H/lajOXV5xZ1kmrW8NjLDQ9EgCQsabyGA1KIwG
         Chs0jT43SwCUKpcN3Soooq2gkFWMBWEh7uc5RuXtH+6ueTY1ngB3KFKWgCsj23SE17A3
         /otOLJeoAIIRoHKa2XYECBkHRnnTIGwiopQmnmCFq1OSd+eXlnFziZmDXGR6sFVp7/xz
         f+nA5ZF/Jadkd/BYFDzbaUSM+ta6GoLT3x41B9w7Dqso3ogDM6U8dK3kOjSCLOU9gpHJ
         4rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546080; x=1787150880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ly+eS6auCcsMiu+Z/Trwar5yfkD4ejbCJRhO7pUpTkI=;
        b=e5WwsJtwQvwwvqaJZBnijVgQNdddRVCT80uangLlBn1Ub59DxYsljyWKGdFetVDyiT
         I3mTfs4v121sgBdLXcbo+h81ibLt8aF0e/0Yd41Lr7aIWVTuQ4GAzBOTmuqFXeAyRUyY
         Q6DJX5zk252Qq7S0m801WOXiGOCoTV4jqi4EzUwMBzREb3ntJC2/l7AeALzd4eLyY83u
         iFralXRBTz6ltSDFe+fx7vyxBMBGk4gbV/8vzbxLHDchJO/p63qbxafG4FgPv3JTd8pK
         QzffaN/kk14BCYCi+ysSO6jq1AzDCyGLvJvIMZedCc5w7V4+YPooxyy5UeBB02f2ekwt
         1InA==
X-Forwarded-Encrypted: i=1; AHgh+Ro605BVGJ53cu0aRV6P/mfFhMfKsiCKp7exTaByHUP9cSxxJKNpDTy2DDWMufmH4xH3NQW+SX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0VTsjgVIq4LIAKDo4T53LI78vgNHmUpmEX9vrjI4k394zxw2
	Gbu4GRVPwRRxbuoDP8F46JSmLORk7jfGwkTgBp5aUoWTPV2/25fz0kV97fV5urLamQ7rGQpnW42
	Yrf5RFifmA+udEMhvRlnwl8ZD/Hi2jZ0=
X-Gm-Gg: AR+sD12PHGTxVENkGbHXD7quX4hRENwZ4TYd+Uc++SaXz+WHWvkgh+bI//RpmdTba9F
	5E9oHp/lY4ii1FrQhQVLQLyuUuRe9R3fBXUcPbOdp/5QdNrc1Z1h/4h+MIT0XBMKZTU2qXweaeu
	TzhcwhcJZVtENFVGePtZH5iMTmFRDTvXq2ouAekR1FlTHyjIiKJ0pjsj3bTHnNuVrrS15pdqji1
	sv2enE7hBlq2kXPBEJpqCARoy/b2YRCOYIK2IYZ1bZtdzxu5RhoV5C8UsUEflaWZPE9OhYG3Qq8
	Xt+gBwUodw2Jh4XQuCCskOYiow+Yp7dGv3A4iqTWMMtbgWMRAF6qAF0Wn/0BxJfzWbJEWTuBT+H
	3eDELuM7gr77//K8HetUQ8Zr7tU5T95vt+6HkY5Sz4QKLEHEWk/4Vq41lSfXcUOcTq86x0fZ2Sk
	si
X-Received: by 2002:a05:6a00:ad8e:b0:837:f111:b70 with SMTP id
 d2e1a72fcca58-84faf9b9105mr10063380b3a.4.1786546080284; Wed, 12 Aug 2026
 07:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811152803.5629-1-a0yami@mailbox.org>
In-Reply-To: <20260811152803.5629-1-a0yami@mailbox.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 12 Aug 2026 10:47:48 -0400
X-Gm-Features: AUfX_mxOks_9sP1fncoI_F9OdQEsQZPYw2j_n0LrkRuaytrYSKObi2_mPZBuwv4
Message-ID: <CADvbK_cop11Jju3TBE58-tG5OhY4AsZMvCEFC8Neh=rjF-rTsw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: clear new_transport when removing a peer
To: Qing Ming <a0yami@mailbox.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Michio Honda <micchie@sfc.wide.ad.jp>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:28=E2=80=AFAM Qing Ming <a0yami@mailbox.org> wro=
te:
>
> sctp_process_asconf_param() stores a newly added peer transport in
> asoc->new_transport. After all parameters in the ASCONF chunk have been
> processed, sctp_sf_do_asconf() uses this pointer to send a HEARTBEAT to t=
he
> new transport.
>
> An authenticated ASCONF from a remote SCTP peer can add a transport and
> remove it again with a wildcard DEL-IP parameter in the same chunk. The
> wildcard deletion preserves the transport on which the ASCONF arrived, bu=
t
> removes the newly added transport through
> sctp_assoc_del_nonprimary_peers(). The removal does not clear
> asoc->new_transport, leaving it pointing to the removed transport.
>
> sctp_sf_do_asconf() then creates a HEARTBEAT whose chunk->transport point=
s
> to the removed transport without holding a transport reference. During
> local address replacement, src_out_of_asoc_ok keeps this HEARTBEAT on
> control_chunk_list. After the transport is freed by RCU, a successful
> ASCONF_ACK for the replacement address releases the queued HEARTBEAT and
> sctp_outq_select_transport() reads the freed transport's state.
>
> The issue was found during a static audit of SCTP objects. With an
> authenticated peer, the reproducer triggered the same KASAN report in 2
> of 2 unpatched runs on a KASAN-enabled netdev/main kernel:
>
>   BUG: KASAN: slab-use-after-free in sctp_outq_select_transport
>   Read of size 4 at addr ffff88800b9bd95c by task python3/197
>
>   Call Trace:
>    sctp_outq_select_transport+0x549/0x8b0 [sctp]
>    sctp_outq_flush+0x306/0x2c60 [sctp]
>    sctp_transport_immediate_rtx+0xaf/0x260 [sctp]
>    sctp_process_asconf_ack+0xa48/0xf70 [sctp]
>
>   Allocated by task 197:
>    sctp_transport_new+0x68/0x650 [sctp]
>    sctp_assoc_add_peer+0x258/0x12a0 [sctp]
>    sctp_process_asconf+0x5e9/0x1090 [sctp]
>
>   Last potentially related work creation:
>    __call_rcu_common.constprop.0+0x77/0xb70
>    sctp_assoc_del_nonprimary_peers+0x7c/0xd0 [sctp]
>    sctp_process_asconf+0xd9c/0x1090 [sctp]
>
> The first invalid access was a four-byte read of transport->state at
> net/sctp/outqueue.c:833. The same reproducer completed the full
> authenticated ASCONF and local-address replacement sequence with this
> change without a KASAN report or oops.
>
> Clear new_transport when its peer is removed, before it can be used to
> create the HEARTBEAT.
>
> Fixes: 6af29ccc223b ("sctp: Bundle HEAERTBEAT into ASCONF_ACK")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

Acked-by: Xin Long <lucien.xin@gmail.com>
