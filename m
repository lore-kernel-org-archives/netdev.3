Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80613B584
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784982127; cv=pass; b=UJ+06P8VtNsIgF3gB+mjJhO39GbkDIHPj+p5+tXD5s+P2bG2PTrjx0gd1dD7hFR5IWjEqyAOFKIygy2E1i1hpXv8y+MitoM/4jAwkBAczM3CR0fW5HazYzOkIXfxSdAl+TK5ZdZkLICWwvxjEOao+O97INwg5ft27UYECJpy/Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784982127; c=relaxed/simple;
	bh=QfRpwHYYL0s2HTDt/HfsrgEG1YZR3fzEBH9JKGOocl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqxKs609NYQPFmCds09qwqwXVi1fR2vR35ABiZNMQ/eyzukxZ1nSxNPmQJ3D5jx+HyetG7b0wPVY7Ql1uNfTrAWbNdaHshKHdyGsW1iB5WA68tgnkFSVaJm8ICLdXsRHwUELn4AKFlQfurpOOSe0pJwUl8o7fwGXBqEp16FlI4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ZVQC1vm5; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ZVQC1vm5"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca80d708489so881780a12.1
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 05:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784982125; cv=none;
        d=google.com; s=arc-20260327;
        b=Im9SChNZ1k1r2KUpIE1tHZoG5EwYYpvXu39aeQKK/qHLzV/vHFGtQDTw2D2DxTiO/Q
         IuHTgmgqXBm6Fay0PpWlLvJbxlM/SR5zHmRc8h2Oh7pwO6d61kDRtqZYTle84YMBWjQ9
         Zy35zrV4bAfq7Oumqo4y+Ja9TPCVGYU6i3aN/cEoYDXM15h85S9lA/Z8jb90RbNKvUba
         qGIS0Vx7HufzsIENddcvEa78MgouP9m6WTBB3daUaEQ3PhR3pfkeisAyFeeGolCzux+6
         qYkFcgIW4Vlnu+jluhHMCdnAPG28kceAUcdKD7I4/v8Rnbho6tOKOuhu+9A/x5+OMAg5
         JMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zqWQ5xrOWiCz7/mjEBAcgSWqcR73yOIWZ6oHsh0uoPw=;
        fh=kDYCIY48lOO3Y9DSQQY5cInP+RUciqK4mMvVup+9WZ0=;
        b=h5VGws/13JeHddUE1ubg9L4rB7rVB13cS6EJtkcHhuEmcEGl1ye+lhjYbkTuLHouI/
         H/RIAryxYOpYJ6Au4mQtEymYRCxv47Aot+WeYFY4fEwlzHFNor3KoHlzig8iQ5H9SHyA
         WozpdZ03zpZSENeXhHiMBjASuVnw435rXo40zUx66/enAQS0KDFrfAtCfHOxf+pTuKxQ
         YjdMCOtX0awHNhh83ax4MMWkWSv7FS6osN77m3PaLQsnwGeMGF0NjFvMDECc8t5eH8tk
         PxdfKvSaUlGJnRj+/BB9M3G/lF/BijmjpT5Gdsqafu3uV3TX0cukzdPlwZau3HBdvHGB
         OZEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1784982125; x=1785586925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zqWQ5xrOWiCz7/mjEBAcgSWqcR73yOIWZ6oHsh0uoPw=;
        b=ZVQC1vm5RVBcNvjt/Jr4gMKN6ByhjTaVBis8LB2309SqnqbS2v7uBXSi6Krx/QOqUI
         bWU2imFMU09RRahJr55u3kGXvbFBO7QUbUQmIHu7eIarx2xqjhIBCcLa0TKsomSAZJSl
         ce6XM7Syjw9n8KZwPoSlwel8gx8LkKb1nSOBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784982125; x=1785586925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqWQ5xrOWiCz7/mjEBAcgSWqcR73yOIWZ6oHsh0uoPw=;
        b=nVfvhqwJh2/qN6Q1Vk3K/ZXJBc6wdY+5Fl92yYwLLj9wSLGyieC0oTm0+reUhrEIFk
         09qBz0BYfyke+bYlFraFAi5cXe6EUCkKmV62vuFXVpF1dTNfJSedR9Pz7i0HQDHBwuY/
         EY0yK/PgWGLdZOIC14blitUyt4dR70Hf70vkK7WCxPsOJUqSDREtWuWaFMsxadfdDgqL
         D1W9VDKuccAIwlBQL2ea/VD5fH8XvzaNDi41epRPhOFK5Y8B1iEnmJ/FdKgyW/lftVHE
         TJSm9+Zw/KbACQRLtP3KkNXltW/7WWcJBLvCd9PgwG1B8WXL7fI9wRnf6B7/GSbOxCMe
         fNlw==
X-Gm-Message-State: AOJu0YycU2FgkTAHSER6y7h86Y3u92KDWjKwQFJzXR3FSxjxo6LS3v+J
	2BJGIF4VwfHxlpIFqgNZRBaAXuTElv78Z8WrZnNJ8gcL9FRMaFtFdjc9Rq+bj7P8VFra+HDaMn1
	CppWElys9t1AVFe0zBccX8Aw2vIrdOO6N3dcCcF03
X-Gm-Gg: AR+sD112qu8wNTS32yYVhgMeJvqKpW/oPfqTKncp9cj7NgoyXITR+L51toM27Kj4tjr
	yDvuIK37vRTemGg3yNsCcvH/Eh6MKRpYaMGnn/GeKQ+4rNNrKr65JMHEgS0vwVNC7rInUKIqo0H
	HedjejyBopWuIc2KvFWgo1zFZEH2DcOt0233C9WgGHlJDDIkvbOJ6liYgIrIR9YXX+ixCdNor/r
	B9mDUQ5rnIRI+e4zrTHgFoG+U7R18VgPsheUo5k5GgDz1Hqea4zhjRU+0uEGeE=
X-Received: by 2002:a05:6a20:e290:b0:3bf:9bd9:cf54 with SMTP id
 adf61e73a8af0-3c67236de41mr4194774637.8.1784982124799; Sat, 25 Jul 2026
 05:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784709375.git.bronzed_45_vested@icloud.com> <CAM0EoMm8HGCcmGB5btFfWKA7-7sGQyhYB_FvxQu7POhZ+W=dsw@mail.gmail.com>
In-Reply-To: <CAM0EoMm8HGCcmGB5btFfWKA7-7sGQyhYB_FvxQu7POhZ+W=dsw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 25 Jul 2026 08:21:52 -0400
X-Gm-Features: AUfX_mz4jpmr4SvgH6gGnCP6dKAPA7jxsutfDdKg7Zk69ey8MqSZIw7unZsfKNc
Message-ID: <CAM0EoMkTr8y1KBXTqU6MyJOVezGknZg5u6BYE7WBzdVyqaPm6g@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net/sched: act_vlan: pop_eth can strip
 non-Ethernet skbs and panic loopback
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, gnault@redhat.com, 
	vega@nebusec.ai, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 6:46=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Jul 23, 2026 at 1:54=E2=80=AFPM Ren Wei <enjou1224z@gmail.com> wr=
ote:
> >
> > From: Wyatt Feng <bronzed_45_vested@icloud.com>
> >
> > Hi Linux kernel maintainers,
> >
> > We found an issue in net/sched/act_vlan.c.
> > The bug is reachable by an unprivileged user using private user and net=
work namespaces.
> > The relevant details are provided below.
> >
>
> Please remove bouncing @bytedance emails from the CC list.
>
> You did not address the discussion we had earlier, which is a very
> good example of an issue Yuan brought up at the bof - "fixing the root
> cause".
> Attaching the last email from Guillaume since this was not on a public li=
st.
> I had argued you only need patch 2 (and to be safe handle both pop and
> push) and Guillaume argued that would not fix the root cause and there
> is potential the bug could still happen and patch 1 would be needed.
> His exact wording is:
> "
> So, if patch 1 isn't needed, that means we must guarantee all skbs
> reaching an ARPHRD_ETHER device to have at least ETH_HLEN bytes of
> headroom.
> "
> after some back and forth we steered into drivers and pskb_may_pull()
> invocation.
>
> In any case it would be a good idea for you to review and consider the
> discussion and infact test with suggested vrf device (which doesnt
> pskb_may_pull())
>

After some coffee, _my view_:
The root cause is the missing pskb_may_pull(skb, ETH_HLEN) in
loopback_xmit() and vrf_local_xmit() (thats why i was asking to repro
with vrf).
The proper fix belongs in those drivers, not in the tc action.
Guillaume's point is valid: limiting POP_ETH to ARPHRD_ETHER devices
doesn't fix the  problem, it just makes the existing reproducer stop
crashing while leaving the underlying  driver defect exploitable
through other paths.

That said, another stack or code path might lead to vlan/skbmod so
fixing the actions might make sense as a follow-up.

cheers,
jamal
