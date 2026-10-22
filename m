Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645200;
	b=eePlo1mz3AUDBj7cIH7nmNSXeyLzhxlWWMDBMVUPuEPP4SFCk5u1V+lUQpA4gV62n9ip
	 jHciwsnkYpojlmkeEkYpNUD/COwkqEFyD2fRL/xPhgj4k6dgcY4ny/17lgFJ6Tnqr4r30
	 FxRs7QcjRYOHg7cH9W9+c+1Vp2XWz5DnTem11ZdJJUZTR4gHqpWZvFJ1Y82RfeZJGp5Dl
	 sIS17nfEZbh0Z79m8EKJ8Znaif/8bYykD/i7ZK0/fZ/a5BdyarY+UDb0I8qVAiVpCYPeW
	 Pc9aZh4Pl0d4zVoWp/Odpg3ZOOVpz7LQ1jNYmsDtOxmrgFnktGlXcyH8tlqCPR7UT0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=mXOPLkCq7ZEBM7fN1+M34aOvLAaufrn8cAGu232pIRM=;
	b=DOF7CciLjOGwWYsTd73Bz9uC3USJOzeb0A/yq2h857oj6WajjGxxSDOgVQCZhBvaHyI6
	 ifgowQEkFn5jpfL+TSEz0LgYmzRMGKTPzqsQnv7aMy9yvdcLUsKJbiDy/bf9I6q79OsEe
	 eA3F94RWIZ5iLALu9LNQ/VTBmJbORlTcWutUogk6A2KOsigXPscYC3SoCpev+oFzWOK0B
	 /6pJyH1pUuymYy49vnxhuKWPYPbCRKXH3yFnIQVHrBLeBqolsm0whRm5PXzQNCG71vRzF
	 am6qAigb1NDTv3E+fTREo78CN2mKBL0nlRa+4FhI2YQrM3igX98KLSAC8gm2GXMIeSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JrBlAJWx;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC1606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55DC1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JrBlAJWx
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-878b44611ffso856842b3a.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645200; x=1793250000; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mXOPLkCq7ZEBM7fN1+M34aOvLAaufrn8cAGu232pIRM=;
        b=JrBlAJWxwwNyUxTFEkX5wczZKR8kR4LaDS5yCli4KqlDD5+rg3JUInRx2bZifDhPnD
         gBJawZZrQpRUmFudSh52bs9IDjBDTDPZnsquYFP+IGd/FP/OMtmccNXmceUoOkdkXKFb
         8n7zrMZZkroDXlgdghKS7EN2T4DJZazNzDomBccJMzbPZfGMGqPO0e81EcJpMz/tYR8F
         Lw34Yw5p4teatdSZU/yFWJDwmbDR9819jvJsRDn3DVAH1Qc0eZGWJ5XmzGDTbYgLvPaB
         S1V/0PjRiEHlRuWrOk7gPC9epw9TjS99lS/hDh1HD2jgOqas3IVRUyLUHE5VOlsITpAd
         e1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645200; x=1793250000;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mXOPLkCq7ZEBM7fN1+M34aOvLAaufrn8cAGu232pIRM=;
        b=avXZ8jPUZKvx5TkJPgUCBMJMY4WMftKnLYfDweicXFXcn3W2q82wKrj2o5oyZHu2XV
         yvMcGm2k9q0uqc7I+CF7cDouQ6LtZkQSoTz/HUxUxb/uEqzdeZOdVYkeqplq9DMsq8Ue
         rmT8sioW6ck0TRB2FUJGpFIb9iu9bydOHbqHXw6FRq0evIys2XS10x5AP6YO1CVcToSJ
         VvAva6cC939Z9wlbl3A9DpAs3U7d5x6eKgRDoJTn0XAFSF/s83DYBj7+Ykqq6ly5a+FX
         A5eL4lT5LGc3TkNteV12VOtfe53tfDcQ5oU++uYUnYtukh0tvKTW5UY7hyZ3NN9ku1wZ
         zDbA==
X-Forwarded-Encrypted: i=1; AKwUvBzsmp8ti2uI58gweIXVQj9UvsDRNwMx/evrUBlQAMRfxP9rWX5qa4QAhMlfh0qcLo7a2cG/0Bk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3z5BqBT8U3rQpJsgxHLtPKVAb3573UaKj8FrvNgpjK3g6PbpE
	y6hqGJ+fLwJYoiZ6xvFjy29t9bJWx6M7j3fVdGvtfL0d/mlVReSntfY5
X-Gm-Gg: AYBFou06t50ilqLkm893MOgNZLNoVaM5hw8YfmKg2lnG5xjXfA4NB1jglxoDs0gNAyE
	y8s/giegkQIY2dAtLHfX3jl4tI5YFUMAlaSbvhctRnedSlZa66jiLRijaaCGwdABxsd5uGbdgJM
	4FAPK732I627cXqer+IFwec46OwenhCZG2xE7MVpE3UBa6hU1nbpYfP3iM1FN58C9Yh7ugZEipf
	hNW7UDVNEyda+wRa9S1o7Am/kGwnbDb9NwyaW8v2LAuak8wS/mCLcfnniHVmwaNSw3pDixC0noi
	ae8w9RLyi2EHEl2ws2TtLicJoHgU2My/r4lPoBxtcW547IZsJ1uSWiDd9PoiDQ10tr4YntdCppK
	sTmrHn5eQ+Y9BBxC5sENiMTg2tp/expJoSOD4YpGPXr15DDSKPsyGpEv6iQixK+7PuXlHHDsGsC
	dCpXFd7XEiesElQSBbu0WQK2CB0WQs2VSuDsPvyJ9jp3JIEz5/Kbj/59fc/1VMkbJO9MqPSKZCN
	02299fRKk3YA1P4RSkAi48bKm1Al8x/N7WRMiWBZVW36MB2WVbf2qmliCcgzjEawum0nDwIbu4L
	yDkJ2mZmPLUkMJY0bmk/WSKhYzwParVhiUc9nrDpcPyOVEUXOeWiyrY2XVzYPkNAY2rhPPhbvag
	pxzzscJGOB3GNtbXAgPY9
X-Received: by 2002:a05:6a00:139d:b0:886:9939:caa2 with SMTP id d2e1a72fcca58-8a089ed50f0mr3692072b3a.52.1792645199600;
        Wed, 21 Oct 2026 21:59:59 -0700 (PDT)
Received: from smtpclient.apple (ec2-43-199-181-133.ap-east-1.compute.amazonaws.com. [43.199.181.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b3749sm1597116b3a.15.2026.10.21.21.59.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 21:59:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH net] net/sched: taprio: unwind the netdevice notifier if
 register_qdisc() fails
From: phx <phx0fer@gmail.com>
In-Reply-To: <179259829934.3290.5380861866339404482@kernel.org>
Date: Thu, 22 Oct 2026 12:59:41 +0800
Cc: vinicius.gomes@intel.com,
 jhs@mojatatu.com,
 jiri@resnulli.us,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E594EF6-5635-44DD-91B5-D98A6FDDA49F@gmail.com>
References: <20261021155417.66254-1-phx0fer@gmail.com>
 <179259829934.3290.5380861866339404482@kernel.org>
To: netdev-bot+sinfo@kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Hi, The issue was found by LLM-assisted review of this code path (static =
analysis), not from a production hit or a syzbot report. I then wrote a =
reproducer and ran it on an arm64 QEMU guest under KASAN; it fired at =
the claimed sink (notifier_call_chain, vmalloc-out-of-bounds). The =
"Assisted-by: LLM" trailer reflects that assistance. Thanks.

> 2026=E5=B9=B410=E6=9C=8821=E6=97=A5 =
=E4=B8=8B=E5=8D=8811:58=EF=BC=8Cnetdev-bot+sinfo@kernel.org =E5=86=99=E9=81=
=93=EF=BC=9A
>=20
> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.
>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

