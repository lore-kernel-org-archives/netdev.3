Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109183DAADA
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261062; cv=pass; b=C/Q/nPYL+7kzzD369OozCnAN4Is8lC7cVKVK5lI2y0G4MEbRVS2aoE8SBBRbnEqDACqYU7ecksIyt+2rYPtQWRHakw5SmvNR/2iKPLYNk/jEhV+AGLMJP/Y/NBNozepVzBMDn2ljXNb6FzDhwQN3sd/ou/kh+uAosHRjpvZX1YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261062; c=relaxed/simple;
	bh=mY+mbX23BU/S+BJedpI1j39NElLhmHuqsUSkxkqu4Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/P7TQs2WvSrxtlMJdr9vlg9ChpN1q9cMg2A6tOKTQbdN6+MZ0aJA0EXB+maPJPeABdzoaUGZWTWHnhBd8Kuf5GaA870BiLUVyv8Rwilo/0Y6yjckgP0/ZBinsnRsFvu/ib23vK64EhOvTpspDKbPitlwL++x1LU2qPTozjE0+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTi2b2Qi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRH5bA18; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTi2b2Qi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRH5bA18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787261060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/QOaHZedAM+XJ1xU9m92bNG8scm/L5Pb5l9cZshtV8=;
	b=LTi2b2Qix9tV8BNjB2wdt+UJye2EqPUWla4pNO25Ssw/tNalVYvZv6Tl5NDk3qYoJc/Qks
	idTh9QP1ZgqJ+qgwijb8VeGRZqjPCRRblrcp8I3pxgU2BfQlaI2L092Aql6rP9FZxuwZYs
	V68CPXYvqjUYXzTTq0Wr80VuOzopGmQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-4SEFNVxnPkmvevNnHGfgVw-1; Thu, 20 Aug 2026 17:24:13 -0400
X-MC-Unique: 4SEFNVxnPkmvevNnHGfgVw-1
X-Mimecast-MFC-AGG-ID: 4SEFNVxnPkmvevNnHGfgVw_1787261053
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so239209a91.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 14:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787261052; cv=none;
        d=google.com; s=arc-20260327;
        b=rgdQ9+oBS/x+sH4gbtAU/+Gh2S4kWmB/MLeczXVZgSlb5z+xF9rQ7B7Hy+V6NpaqIv
         VwGfSnbRTvmZc2g6djjuNxqO0quI8r8Gnw4CUDab0I4JlfuVSTdnwNM7B6snHMwoZlPn
         yHi8ONRi9Tl0KXgutuRoU2A2eLW+h1lpm+wVc/FA9nyZieuSma7DM/+3UB78qkq3BII9
         rx0eS5zE60zqCgfuqXbAXKuSc7Rvax3hlhhXt4rkfu0xb1l59iJvz4WCAQoaThWbv0SP
         PAHp70/XXB1Tpj9ohVBRVwyraShPG1sFpJst1CPr3XtgWK5lNMh/p9uBLUstFNDMeXxB
         y67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L/QOaHZedAM+XJ1xU9m92bNG8scm/L5Pb5l9cZshtV8=;
        fh=P0vOmooPe/CZPu0ALdrg59RMtXr6pXFMLgVfH16YBtk=;
        b=HVjif35+RYvM4znfS8mJyd/S07jZySOH4cfJWIzVcDnvSzlbEO5Bi3Gn+CxBXHM4FB
         G+poQYOm62CpAIdm46S6LcO7FdjmpmRgFobyxMlZKAHOx0wMGL+O7SyIJOAjkbwif1O+
         IXtLpAJAP1AaQ1AwQsxFBysa7rLnHmykyye8uFdp3T9cxWrkdpG77KFfYcneGs1jsEzw
         Ovn058ItWRIxw8Yl4DzpQLENLmo057sp9cZ4wTB41xkXX6GFtramT7Dgii+zuNyvbYyY
         qTBStcHV/mlYnlomTaXE8HUwfRWcAbYOCVJxxASUvTsfQzE6h44KENOm9YUkOnRX/Fqo
         +u2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787261052; x=1787865852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L/QOaHZedAM+XJ1xU9m92bNG8scm/L5Pb5l9cZshtV8=;
        b=BRH5bA18ZljjODJ6qcP+efC0+Jt75QbS8L4tzPoaPV9PVfJl1aUW7GVcqqe9BxuRuM
         meHGp21NnRJWu2gHIw2SKA6XfVEYshTvUXLwlXe2TEg35NQf4z7ezDgYxC14fUTBtjuE
         HrRLurBLQpwnNfqofQNAEsvJBLuhWuXJmZPz0Q/5DoaJVG0YSPwdKKHogQ+keUB6m9BF
         Kr79tNVaiCGSJfrl/VmssS45i5exjT31Z7p+5/1tSgSz1nXsJZ3siZnHUc1oVcPrCGCV
         J1RwWpxxACwt/XMVSpa0KTs3QUlTx/8UQWwotuKAnH759Vd1Er4mO26GIDo6FIIttiJn
         erOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787261052; x=1787865852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/QOaHZedAM+XJ1xU9m92bNG8scm/L5Pb5l9cZshtV8=;
        b=FhmV3hyUn0KPWs/bvmCJjrBCP0HmQ3k+LblY04R8ijfRYG37GAwJ5axWDpcC97GBOl
         ROym3ydUcJJyfy2JKtTxOY3BNiZUmelpESJ++zZ40ysUe8ggjJAHcU7V2y01APFOYAH7
         m7iNV+qPlZW6ilNXiT/iRxuj/ePf2haq8k60otezpwPXSnnJuZ2OhHRXss+tw1v0WtDx
         tcV7eYpWNFDzIBpkNLdmZOEqUKHQ5h8+S4ByCCMsDbdbSfJj4az1z4CUegcUai9v6Xa+
         t/3WdZ+9lFnS9nM/cIXrIaC4jxseKzqwfgBBRm1wg3X05t6Ggu+TGQez7046TBT04tIK
         xIzA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0YXOAQxRsW3tEFpJppHPNVWd8P/9yt4Nt+HbYyxu51IykC+bKuwIxYhbTtmbD8HPASbflmRg=@vger.kernel.org
X-Gm-Message-State: AFuF++n36Z+PK26pbgWFiphd6gXYyoDGS0ikPy69MUAvm4tyiIRTrlVg
	4run+uuwYQCn3EtXemG3AH2gzmOv2IrMIR3fCkTJ/tq6w+/nzTUloXsSGKdRf2wiS83La9Q+as/
	cENJXrRp4w2bY0yItclkZXOW3aeIf6W+ojiIDgSNANt+mPFzGSTaFAx3EOA76mgK5qmPs77jWs6
	PV6dt4q8DU1Ufx5Fy3pJ8AzpjIZE6ztnIJ
X-Gm-Gg: AR+sD13NDzLOE3Vu5DD4T1aLg7NjGiBqfzXVv4LqUtQREULY3/zyjxeDh/jJYGDNEVd
	askYgJzmRUyI7zfs6siEvU2sdA5pXMsMRajpmruxAyKGt5dbJjSEkHJQSJTBypP93LEqmi5HS7I
	GjfPKMlof3h8fn7elLmgPuDHH8j6C6C4c7PMmsJxjXj7kri7rE0W+ERbIWIHrg05ik8CEH51MFV
	x8Hkc7BxmDn1iF1pzA=
X-Received: by 2002:a17:90b:35ca:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-395c3a7c27emr2518464a91.16.1787261052551;
        Thu, 20 Aug 2026 14:24:12 -0700 (PDT)
X-Received: by 2002:a17:90b:35ca:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-395c3a7c27emr2518370a91.16.1787261052064; Thu, 20 Aug 2026
 14:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818141556.64303-1-thwalsh@redhat.com> <CALs4sv1zb7OemFcKRceoO49F8yPSOdZWSkomvU=mGmReR74=BA@mail.gmail.com>
 <20260820103950.5dfa2969@kernel.org> <CAD+aA83e_HP=Z0pXpcxW5j+TUXdgP3Dx8_LGxrMjdVwtERRCtg@mail.gmail.com>
 <20260820111557.49f658a4@kernel.org> <CAD+aA82ONaO+oNuX448ruJdLJ+ySvsnNwyCLYGGyDZfOA6U6cQ@mail.gmail.com>
 <CACKFLi=WPCW=G8nyFbZnRf2yFxrc6Qao4HnsQf3J10JG8rwQnw@mail.gmail.com>
 <CACKFLi=6Pcynd2MR7apH8tTN3UVnzCcR0YuP7B5tgGRgtO_ttQ@mail.gmail.com> <20260820141452.2ed9ac1b@kernel.org>
In-Reply-To: <20260820141452.2ed9ac1b@kernel.org>
From: Thomas Walsh <thwalsh@redhat.com>
Date: Thu, 20 Aug 2026 17:24:01 -0400
X-Gm-Features: AcwNN1VZQu96oRchdJXMfiGAxsPm2rxDpehGVxF5rcgkmG9PU0iuEqp0_gpPdhs
Message-ID: <CAD+aA824n6kO3Ek8n7K6fJWAaqHHPYLqmDaD94p9B8UtW7P4+A@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Gate TPH enablement behind
 BNXT_SUPPORTS_QUEUE_API check
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 20 Aug 2026 12:16:07 -0700 Michael Chan wrote:
> > On Thu, Aug 20, 2026 at 11:59=E2=80=AFAM Michael Chan <michael.chan@bro=
adcom.com> wrote:
> > >
> > > On Thu, Aug 20, 2026 at 11:30=E2=80=AFAM Thomas Walsh <thwalsh@redhat=
.com> wrote:
> > > > NIC is BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
> > > > [14e4:16d7]
> > > > FW version shared with us was 238.1.138.6 upgraded from 236.1.167.0
> > >
> > > This NIC does not support queue management.  I think it also doesn't
> > > support TPH, but I need to check and confirm.
> >
> > Confirmed.  Only Thor and newer (P5_PLUS) supports TPH.
> >
> > So the patch looks fine to me.  TPH requires queue management to
> > restart the queue.  And NICs that support queue management (with
> > updated FW) all support TPH.  Thanks.
> >
> > Reviewed-by: Michael Chan <michael.chan@broadcom.com>
>
> Thanks!
>
> Thomas, please update commit msg with the info from Michael, rebase on
> up-to-date net/main and repost.
> --
> pw-bot: cr
>

Thank you both!

I'll get the v2 out shortly.

