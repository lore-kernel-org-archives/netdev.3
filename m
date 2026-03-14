Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E22949E0
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773490087; cv=pass; b=BM+Wu3fda+4ybcJ0pvH/0/F6nN83DPw44y7QSPfJZHlooVZphcsIhhXYk5twQ+2mTg4rQ1HSANOsU+Cp0vsyELIS4WNjG3AYjhrgDoLkyBioKpmzmeaENfKfE5foDiM3dTVlsNemP2aB6SrIRYBOqukbTmUjG4x8bBxkuwR16Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773490087; c=relaxed/simple;
	bh=zL2dQTu69Efvp/BilKf6RultjR7FumoE3JGdsxXTrvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X69K4x2a8gKCcehJN47/7QSiovzDdjXUZ77tx7fZ4yf68WZeWSZLrQn2h+E10MuvcG6pwMSDvU+YfZE0Uz8IHU0QtPoc3jbd/Buavu8zZbWMTiSGkQWVZ4nnvQhZztNXS5QZc+SwPm2KvyBdebeArQywB9JFTdcjliKgDExWqZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgs1Aa8S; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgs1Aa8S"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506aa68065eso27154561cf.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 05:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773490085; cv=none;
        d=google.com; s=arc-20240605;
        b=ilOFnBVwR+nQpHiYIU1ce8dne0M0tZ93kPztk69A3gYkq5WBBXRpv4uDzPlggkoDwv
         gXnhqUv5kuib8dpxKlfISRzec0XYWKO/Pw1Kn3RXf6BzeDTtgpeoLxeyqjlXFaX/T2UO
         4Pxv3XAvrvzWIiL1tXLe8oJnpXAayDyPY9UkP07Vq5jdaS3FKIDKeetBbtfrTH3LI5j9
         baJaCLHuQ45FL2W17m4py5j2/WKqOYf4tjtHK6AZk/i+PD8q4IUSB6OQVSnwiz1eLvhd
         1tNww9qyK98712lK6Hr2s4WVc1C5OEsEXPF1E6v4pyOv0U/k9i04o0KZgtnN5bG4l8IG
         MZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zL2dQTu69Efvp/BilKf6RultjR7FumoE3JGdsxXTrvY=;
        fh=riAMOXQm7VrLzcOWa0wtnMzvxUmUXz4uKmRtbDrOOyI=;
        b=LY5UJR435YmL1L4B7GFIS6aNgjKm4/5lPRHzxizcPZ9Zl4m1jruuAJyTa/7kJIJJW5
         r+9+ICiFqyZhQ8qV+WwxNdpIFZ0bwE/xhd4euxuZJvqgNlBEHgZov9CXLxgyhvgaU1iM
         qu9iJX5OUHt//YFqVzbYe25FMxxXb/teHe7Q6tpCOEXK0CrZqegvLRBkVlSYoEizrsJ4
         0vPSDW9tVAKyjfATaNQkTL+UbDY1nxwgNEaiaWczbOsLPWQsdETCQxocvlxeLFgubJbE
         HE5yqrMJU9/TqUMsKGMw3TfKnSPR7tQkr6qHUz1matpQlpA6SVRA3LyYnL+dwYiWWRf8
         Oexg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773490085; x=1774094885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL2dQTu69Efvp/BilKf6RultjR7FumoE3JGdsxXTrvY=;
        b=cgs1Aa8SVs4rSz4t3kKcMBOaN4GwBm4Lp5L7LTCeGVkLHy5aWcP0pM+NecDDFvat4T
         9MOZ44jOyUnyevkpgmxCw6MKsoicoYX1Ib0icoUsSpuqkVWs09WRwhkz7nep3PAMLKA6
         vuU6siR4tFZLSDCMCQsH79qGzQ0w5t9cj8Q4DF5HtQLco0mqm4m5jQoHVlsXqsfJhOMw
         6riTyykaXNYc/QXW5bwRt7XilaVEFN4RqCL5usMZXGdiqgejU9JH4fhIPd+n12PMETPp
         E7+qK6xI6oLI/4GaMPMjaICjHs8FRbN2m6dF+/V/tYB8Vbq+R/d7yNlSiq3WMM5FULj9
         f3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773490085; x=1774094885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zL2dQTu69Efvp/BilKf6RultjR7FumoE3JGdsxXTrvY=;
        b=q2Ufp9Ymj8GTy5LmkN1Hxsna9Vq61R4N573P8IRZZOny7nwq4CWfG0TWv6z6ofxk/n
         ESUPwu0zo3OJV2EKlZnJKkTcJOh0UQdMA56DW7zl3i2tAREJ76JeB6WtUlj/SXKKmY8f
         +YCmWnH0NMffhppfkurbLGjHxOHGq0G0B9xZeqANgab44Tt+MRaw/PnrMazabwy6g9ly
         YMoW8M+0n64lRPzqeux9nfo3r6LHKPVNjTb0tu3CxIEUlQYhypj5Wy3u1EQIqB737RjF
         84EtHXv0NRhK9VbXq8wJK/mGnnmB76AZ0M1pwa4QE+BsbbGo05qJG8+U6omggb1jGPu7
         SPfw==
X-Forwarded-Encrypted: i=1; AJvYcCULFW9ClRmUjZXVjHH7eyCuBr3NhvPQHovpGNo+MN1kurmIaDA+pjwqxGELfsY86bC7vMiXR+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRoMVs8DT6ij2rRGg17FDDElk87yg6PtjrAiVPboV9UplkkCZj
	s1J+53Rb+xaM+/EL3mgO9zm/amjq0b1pKOddGJOFssqqmUN/46n2PdPhT5oKFJcVSdVrSTIjXUj
	BRHc1N0W4BQNn6raAjdBwWl2DYkt1DlR57A1EWdfn
X-Gm-Gg: ATEYQzynIxC3alVIoC6BUaup0lfROF2jQvI8rjrEiiPdShszV6oYIrkuxLbVZaGdH7e
	e2RNU2eFXkyZLuI9Zgp0X2JSnv1xX4VSfUDo7AfYjFHeD+4KTUHKtcaTmH60MLunUWjowcMUV55
	/rcWYRw2Xla3xgZKSrKqjxjwUvo0KdgUK4XiqtfAtL5rgFCx9MS2MNDYbVMfuMN4Yj3n1wW3TsY
	SuFDbI8EGKR+9mi57kKU3xOT6SjPNDXh6g/Q+Qz3acHjyYB5cTi02fyRYCTv+Wb75JqYoGJqQe3
	h18xnzg=
X-Received: by 2002:a05:622a:1182:b0:509:1924:3f6f with SMTP id
 d75a77b69052e-50957e5f73cmr90156191cf.63.1773490084837; Sat, 14 Mar 2026
 05:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314115650.3646361-1-edumazet@google.com> <03134b09-5bcd-4898-bb2d-d866e1acd97a@163.com>
In-Reply-To: <03134b09-5bcd-4898-bb2d-d866e1acd97a@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 13:07:53 +0100
X-Gm-Features: AaiRm53am-f0AcdP3f5S2OimOQonnnpjCxUBtvcET3pggY7M04gLF8wQV5eaT2U
Message-ID: <CANn89i+VuUEVzHr2rGeKBNv-QDB8Rzdwv5+djVvSq-FpfsPjEQ@mail.gmail.com>
Subject: Re: [PATCH net] bonding: prevent potential infinite loop in bond_header_parse()
To: Jiayuan Chen <mrpre@163.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 1:04=E2=80=AFPM Jiayuan Chen <mrpre@163.com> wrote:
>
>
> On 3/14/26 7:56 PM, Eric Dumazet wrote:
> > bond_header_parse() can loop if a stack of two bonding devices is setup=
,
> > because skb->dev always points to the hierarchy top.
> >
> > Add new "const struct net_device *dev" parameter to
> > (struct header_ops)->parse() method to make sure the recursion
> > is bounded, and that the final leaf parse method is called.
> >
> > Fixes: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slav=
e()")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Jiayuan Chen <jiayuan.chen@shopee.com>
> > Cc: Jay Vosburgh <jv@jvosburgh.net>
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> > ---
>

>
> My bad, I missed the recursion issue with stacked bonds.
>
> I reproduced it and verified the fix works correctly.
> And I will add a test to tools/testing/selftests.
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Tested-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Yeah, it is a bit strange that AI reviews did not catch this bug.
