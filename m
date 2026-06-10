Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754293EF0AC
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087060; cv=pass; b=WR8oKxgeZhDGecQJUB4VcJDjRiF8j9YkowJxSUNmoXB/vBRlvUamtnR0cdXaaPv++HHvL80m4RTd6ooF++0W3t5EuFr2tNEhS8y1Y2X+fyt0SYJQUxi7f6IvKXNIcNeUX2p9gHhl0Zav1iNZrO00yDVapmCdzcPrfP5qfCo2rog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087060; c=relaxed/simple;
	bh=RNTETXxBGztiW9SeIqkixJsC3INTTfvcVbOxx6w5wrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgjwqBl/YA+yxi3QgcpTNzINDvWDB4aESVGnBOkyanoWzYPE7wCszVPmx4zVbH/2z4wFLofAK//yz/GX8RDLhhhUf8mc0geYuOcyln0uib27QjhQ1fqCZnK1hWGmxAukSDC7Avc3+L8IiHr6HBNMjT83WCJj49tiyoDvQHWbVqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ei283nIp; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ei283nIp"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51761d27612so77144611cf.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781087055; cv=none;
        d=google.com; s=arc-20240605;
        b=i2sMXPrk2/lEw+mduvYCYPutfFy7DxiVxvrCiwxFooK6aeGAhZTC2sXm7INlwSDBOF
         2yshuPGP/8p5+zvjgwtd+kEu06gVtlk+iSq5+5qoTDV9mQHB7NKxiFsOpuGVXCh6ON7z
         tx4Xfu91JbqnZU+C2dKu+ecN1lY3rp3VHJ7uW1rIYKVQ8TUAKMWKEzFpnRC9SZSQUkjZ
         MRRTz5JK4pinVo04EWadgX/TqaHjCvUrOpPNyd5XM6RtpKxaIiNicG/Nyi4sevly1iz9
         x4I1/JobOODHwePFbqFJ0Vo6hfdNVAwnFEc8A35it4OK6GWmCzxPx/HW14ktG6x9UlbQ
         IkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RNTETXxBGztiW9SeIqkixJsC3INTTfvcVbOxx6w5wrs=;
        fh=QUr6gUe9m3F0v4u+dgMQ9zeunsbGoVbKaZcWA053nG8=;
        b=W8MGdOXZfULdVbFqjtV5Kc0iRiVKKqR8hHkTxUJds5KEqNJOckZUevob7vDM8WgVfh
         9ErCt31bpZJtxADrwtCAL8TIeA/zASBcks2EPdIfH6OlYaEcSHHWHFOgEwWyzooiJ9wL
         tAnCY+EUTv3zIyryCkNdoKdg+1BaLJl29f+F7msU9cJfVuENsj9mJgKT9D4NUkUjg7Y/
         R3KWpLHAGG+M7EzrinOj1t6C4YD5lyZx2WrvVEq9TWv0R202fRDFXig+5cbfOn0trmyT
         OXtn3r2AuMHhZAjXV/MhDM97rw58S/84M+2j8SKMEuaTDYUrcYcc0xzluoPt/5kM5KxE
         mW+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781087055; x=1781691855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNTETXxBGztiW9SeIqkixJsC3INTTfvcVbOxx6w5wrs=;
        b=ei283nIp+QHs3RT+vWaZYZtzV9GSm7ETAPm2F2QxHfc+LlTOfb9UhpnBfKRrQBY0Uz
         UDOGsMzpVo8c8KRCeLwKJ9DREl/Fx3CghYFmbMrNiyW6blfJg7hqtwCWWeNxhUEjEmv9
         iLwc+HO3imYIGRsqjGq4bUEn7Nv6ixMNJDrUpEVHbN3HGRKdb2/wjo6bct8rvQhr/4vl
         Dg+dOSqLKR7iSBVQrrsaO246Urg5Xa0I0F3tpXgzgwslkBbj+KVymLc+n3htFnQ64Or6
         OIVGN1BOsbvx9BXIumn07RcOSHsFVDUBtWR4HUg6V8d99o+gI89t+TLXVRRholpOzgvc
         yAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781087055; x=1781691855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNTETXxBGztiW9SeIqkixJsC3INTTfvcVbOxx6w5wrs=;
        b=f2XFFv3mXI9fOMgTNQTVQ+lTEP9tDi/OWTi4Jx9oxSdl4Lfx5hJG6dyWbDeMTHs5mW
         GbGMoJRVpNS67kKaR0g1YRhGJKPRplYEquwJRFnQ1uDig8Jbc/cdoaIAHecvbL08CXO7
         JhicaEO5jhkR0Ixg0Y4q2iHARXjvVSvSgCrj/UxCYgzUUeaSvjZ6eq2ltKF1sklswmW8
         HpGsM8KN73ok4qgWLh2Z2ftfVceGdvmBVafP9dldcbvMfj3S1CXaqPirQhOYt63VHRzQ
         2h93vusb0RTN8UH7oyRZeFlC5r336xrC9iX4FApc0y1fOmxaSPKQaDSbUv0D2sSxNyB4
         2NBg==
X-Gm-Message-State: AOJu0YyVEdz7n+sxLvWL1jWEcuoA9S0p0W2Hjvz9JvoYHFqS2ZQBuG55
	1gt/ixJj371IZAQHs4jXw1qSRatqWDJUoy9zsRkdsKVWAZW2CipLCRv1iSQonF9/JJzthVxDNNg
	e1/9XAiDKEgdQHKv6RMfXEYmoXIoV7Lv0Oal+3QcM
X-Gm-Gg: Acq92OHBF8gMMvcWnHe0jC0MM+37/M5Yk9eudw0cSP5Hn+Lqyd36/L48Ot2+dR6TRT8
	iyq7p0jkKZpe6xKCZXPgYhALv0kXSUE920JbqtxQAx93C6P4q+pzb7QKof42Kpn15ojGEZsWMEZ
	sLOXO0lydGkYKPTfAYXQFrhnUlnrDMNnUhAqFx3de06+DeE5F3465cSqOd4fz76nvoOW+Bmpsnm
	UxxBv2/FYMQt6KPGCtrqFhg7GqkpbTu6hftvHJq4A1CB3uYgFPraiOC/abUTYHZbYikbMkaojoh
	GtSJ2eiEoyLuy7afND0in2e5zKhQ1CSOznQs45Px6oKrCkpHOrAUR1RAM8h1CyxtMVMCpZ1LX3S
	L5HX20Ziino0ZgWEcUnvkzBlr9PF25A==
X-Received: by 2002:a05:622a:53c7:b0:510:1325:58b9 with SMTP id
 d75a77b69052e-51795c56255mr367755921cf.41.1781087054772; Wed, 10 Jun 2026
 03:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610101839.14135-1-jhs@mojatatu.com>
In-Reply-To: <20260610101839.14135-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jun 2026 03:24:03 -0700
X-Gm-Features: AVVi8Cf251Ea_rFf8hJYPAfR31yJwCgsqIE3IE1us9aYknccYT_dL0Vw7oFA-c4
Message-ID: <CANn89iLf_kweBcio1_7Vg-JFn27R816Hnu+c118PD6EmYFJ-6w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: cls_flow: Dont expose folded kernel pointers
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, victor@mojatatu.com, 
	kylebot@openai.com, stable@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 3:18=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The flow classifier falls back to addr_fold() for fields that are missing
> from packet headers. In map mode, userspace controls mask, xor, rshift,
> addend and divisor, and can observe the resulting classid through class
> statistics. This allows a tc classifier in a user/network namespace to
> recover the 32-bit folded value of skb->sk, skb_dst() or skb_nfct().
>
> Align with standard kernel practices for pointer hashing and replace the
> XOR folding with a keyed siphash (which is cryptographically secure)
>
> Fixes: e5dfb815181f ("[NET_SCHED]: Add flow classifier")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Tested-by: Kyle Zeng <kylebot@openai.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
