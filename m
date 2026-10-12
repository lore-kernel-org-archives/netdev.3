Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5F489871
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805720; cv=pass; b=BWohdoTthKrrkc954wlHOKn7OVe5mq+/u1PCOk2vE+LvAfvTPURTtgGKsI2DUy6PplK4NRnzFfd7vWTvSwxGP+ZxwcapXGHHEXO+BIiK9xq4EAcjkgQjE4Y3kS2lon0xJdkqr4ugtSEZpzCBxucmp6x+PjTznmJuSyiT17HolhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805720; c=relaxed/simple;
	bh=25MaDiCijQjJi5Nq/OZhHLCoLB3Tp+j19xb/65bo4dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXVydSTvl3NqNK3xITqCHknrRNCSdS/Ghg2kPM+Y5ns5uTXqHNYs6h05LcB+ywR37Sy/tDFp5kNpur5K092WN0fRwBUi6Lk+RTaEP55a0rpJkzOlSp4WUnLw+PxoY8C0gNSIMB1kKFcBMsySyKLTl5OroYtSpTKiL0O5PQf/aYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=JWVp32Og; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="JWVp32Og"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8875d220446so796201b3a.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791805717; cv=none;
        d=google.com; s=arc-20260327;
        b=DzpY8rUlbmhVpeOS4brRDyyp2PycQs6XqywYBK6/ChQ3aExYjPxQGHdT3grp9uGXnQ
         Wy0w8QaCwRjrVOAjC8I5CREclY46jKX3Np40szStWihAfplm4bvv+IbWRbZRMVjD7Ck9
         Qc9KkSq1VCnuFFV0QtDuVr5ccAiPeDl9ClH2jeHUP6vEsXnWjEeayelM/bXAAPDgfgUR
         3Aixd/LD9QnVCIp2vfkzYicB6y5nHRnO67JnCyShuTnfslHGqwad3CNsTUbhdn3xJv9i
         z40JToVk5mjbmd8+F2dingAoI9+XgwGu5uUnTOxe4AyhZzHQY6RBmTbl/kLcA4FPYYer
         8mJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wMeYWEYN8KzEQPXP0L4WoCWffnxhef4oKwkPCI3RFi8=;
        fh=6WfP1UAkmRj8pC2UUxW5SkHQeXKejxeoK9yB8bY2J/I=;
        b=nUSl19KCd9lAblstJBSgbQoFQ0bbnOXCoV1MMmY/LpgBNOXYypaVl4/oRpD4pkdcKb
         Jf5V1PAQnsc9CewrbP5Hp7uIXWJgSbejtRA2k0F7R83osAAfmV8zirJhdA5jXHanp1cY
         mFLRdgZyHn0Fa4pxLvK+gO/G0oU6IGQRSnzdGGjBf9L8+AH/5sMmZwutFX/4VIy51h3J
         eJ5C/xDva+qKHwXMqfSZq8ZmVO3ttt1PDN+t47RWTRqpBcR06pVKP1yeksbniKIFO6jP
         R7HNMBoYNU1NqG5GR8WnhG0KC57pIu+KVMdVs7/bYyKJelGlE7cZEXUnA0s4e/lMj7px
         RFHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791805717; x=1792410517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wMeYWEYN8KzEQPXP0L4WoCWffnxhef4oKwkPCI3RFi8=;
        b=JWVp32OgD6iBmsrj3UDNZq1eOMkdQZyqQx+v5gjtCVaF83i+OfujHKCqlOYVDUr+Sq
         39o8bybOe+sDxPUCipUahUaSJb/eCQNFHilcuP7ZAbKKyBcnEtjHDT6P0m2ofluijwp3
         BwtussVqp7rNmnrSt88nL2Epe/7HEAeKDOvt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805717; x=1792410517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMeYWEYN8KzEQPXP0L4WoCWffnxhef4oKwkPCI3RFi8=;
        b=RojePUMfJCyaxPatnnPHN3TIMcJd2JKkkMLoe0hARe2X7Ov9NuBIblEjEFir7Ar1Vh
         zfn6e6W3H9cWmoj77YkSD4FaCwhx3dPhgkIXMeyFf1QJvDptTwVyMkWSPE/R0K/NSIQF
         ZdlIALMBhM1GQiQecyMKnhvmkzZ9CZfZ831xJx8xIO/+6MleDM7PouQ1XETVUTxHeVSL
         N8pIP6f/CMiV1b8XcSNsdNxYtownTKVTYETlp0BDN/osOA6TdYcLbRdJiv8e1BiGbf8L
         EKlkvo2bQBtP1QGKXGI/zeIGNAY3FGN78NFvtR+yZPo/oX8ZLWKrsuroB/hBMrvSEiDi
         r0ng==
X-Forwarded-Encrypted: i=1; AKwUvBzWpsiCD/aoukJW4aP7/H352QI+7u3LrRxAeNu8gIxjptPUh1FYp45e7jUZJHY3Dg6OWbAvOr0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMjIlL+BqujLLkZL/eNbB/bplWD74tzqdGTE4QLzONW5Ce47vA
	YPxk4KJLmXskAdAb582BsbusccLJQPTP2QTRiTfVEL00MqEzWNjLu/8XjaWBfERsCCzn9fMvYNH
	Uw7lxc+/LlmR0neg2asymO5pRmqlWhkCoW5x8Ov/u
X-Gm-Gg: AYBFou2jbWEOUpMj+b5p0/GqmRExu/M9r/pTQHB0RYQRL7fVhyXHCxL/mpIxewY/FqT
	s3ictOxxftaEz1Uga7kMHE3kCklVOH29scETmvo+NDgLUWm5/ULglHNXghrSqXCxytFiBQbO7qD
	A1zgLBOxwugjKGnXR9Q+ayNDP1DYJHECpIJ1FJykvKVCFOp+5mQbMsvdcB1rTAew8JMZYa+S9KJ
	sIOFOeuu5yXpWKJo48mQ/QVSLRys9S+4FH8hx0Mfv1OdzYU5nLsFLKLlpsEhawoDgqAkvckHQ+x
	VXw5uazf5WGDBXQx0hQ5P3BfEyHhHktwwmJKtlhXG43gNA8JEDNaGiQcHvhY233WY/CcddChL9P
	re+zFZzyVkck4ksvduyt8T4ZhW+mobJqnUFIwWTI0vIbs
X-Received: by 2002:a05:6a00:2e86:b0:874:705d:f65d with SMTP id
 d2e1a72fcca58-897c6e18d04mr7892912b3a.43.1791805716900; Mon, 12 Oct 2026
 04:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMn6JoLVHdhX1GB1wBcw3fVZ42ePKXDqsWK-4STj87vEEQ@mail.gmail.com>
 <a3a68d65-9eca-41ee-a70a-0db8dbb0385c@redhat.com>
In-Reply-To: <a3a68d65-9eca-41ee-a70a-0db8dbb0385c@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 12 Oct 2026 07:48:25 -0400
X-Gm-Features: AclHuK__BYRLkYqIXx_xBjzjPUMQ2thzt1A5mfD6-zL7ObiOzWtLnP8OfIBIi04
Message-ID: <CAM0EoMmrrWhQigRLQLqhh+2jD1W_bboQGJspWdRhF66e4nspFA@mail.gmail.com>
Subject: Re: sashiko or lore confused?
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:58=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/12/26 02:00, Jamal Hadi Salim wrote:
> > Some threads seem stuck somewhere in the ether for sometime now. I
> > asking because i have a backlog and dont want to flood things..
> >
> > 1) Sashiko nipa review is missing on the act_api duplicate-index series
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The nipa sashiko never produced a review for this series: gemini
> > sahiko reviewed it ("No issues found").
> >
> >    Original posting (v1, 2026-09-22):
> >      https://lore.kernel.org/netdev/QDISC-K1TH.v1.20260922072206@mojata=
tu.com/
> >        [PATCH net 1/2] net/sched: act_api: reject duplicate actions in =
a batch
>
> We had a few PW outages recently, and that impacts directly clashiko. Als=
o the
> threading (new version in reply to the old one) tends to confuse PW.
>
> > 2) What is still left on these two?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > (a) act_api_delete_duplicate_index_refcount_uaf (links above). After th=
e
> >      2/2 delivery glitch and the two reposts, is anything still
> >      outstanding from the maintainer side, or is this only waiting on t=
he
> >      missing nipa review?
>
> PW still did not handle the repost correctly. I think you need to send ag=
ain the
> patches, and please send them in a new thread!
>
> > (b) teql_xmit_path_pre_existing_bugs -- series [PATCH net 0/2] QDISC-6H=
S9,
> >      sent 2026-09-29. Both Sashiko providers reviewed it: gemini "No
> >      issues found"; nipa one Medium (commit-message doc wording) plus a
> >      pre-existing, out-of-scope item (the consumed-skb UAF, tracked
> >      separately). We do not plan a respin for the doc wording. Is
> >      anything else outstanding before merge?
> >
> >      cover:  https://lore.kernel.org/netdev/QDISC-6HS9.v1.2026092806475=
4@mojatatu.com/
> >      1/2:    https://lore.kernel.org/netdev/QDISC-6HS9.v1.2026092806475=
4@mojatatu.com.1/
> >      2/2:    https://lore.kernel.org/netdev/QDISC-6HS9.v1.2026092806475=
4@mojatatu.com.2/
> >
> I'm unsure who set the above to changes requested. Your reply looks legit=
.
> I reset the series to 'new' status, but we have a long backlog, I'm unsur=
e
> I'll be able to process the above before PW will archive the post. In suc=
h
> a case a repost would be needed :(
>

Thanks for looking Paolo.

I can resend all 3. I probably screwed up the message ids and it ended
being threaded to the old posting.
How do i force it to "new"? Should i send the subject line? I already
added "repost3" on net/sched: act_api: reject duplicate actions in a
batch thread but it was still not reviewed.
If you are unsure - we can experiment: I will change both the message
id and add "repost4" on just that one it and see if it still good on
lore and sashiko can see it.

cheers,
jamal
