Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE446F4BB
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023641; cv=pass; b=SKN2D+CBRDBfOhmiUvteLjV1YV/5hON8WNOL00Gq6kKP4khIGhC1qtTNCIdL+iXBDN21tjNT5kVUl17xJVuoiC8Mi6yuAwf5ooxjmomaYGX2EPm/pjUWIxMg2iaqqLFoLtO08fEstCP3O81Cltwg9UKYFgtfGkZQQC7TDPo12bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023641; c=relaxed/simple;
	bh=ssmS0mOUy7lBmCTlXr3DwwCJK1VLRi2eovGUwRPIIFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoNO454YE2jdB7FDug2eNT6daVHFas2GDV1OWp0oth3FVfpppXk2THduzsGAKqz1Dg9qpzNJhdOO8dDEVPdbnlR2abCplASQnXx/dRx7ckt5rk/gn2cWxjOl2FkAnZZca3bevElqRsG/ILcRvdyjNV57L1/F1TPx/vL825ko4Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5cTTUxX; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5cTTUxX"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76c9deeso41175011cf.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790023639; cv=none;
        d=google.com; s=arc-20260327;
        b=TJIHnsREEXa/3tZmuGIN5iN5Ma43mDSbahvTA033bNSBIb3MWDB7mEhncxPFxbp3WO
         qef7RTTARWInzo5EBwq52whmaaMepcSEoXh3NYhrbxII7x7ETRCQdp2qr8ISlAbcc2r1
         +gkktBQWqABc8mGKpF5KOny+3Byky3myIRDwPlM0nNDVPNU4v9aZ2ADWurm0vw63RhnQ
         HadjIQQWeWRlEpV8aZxBO/OzXDg0fWxIWXQpbg6c2RMTbtfNlES5MAb5t+pk+4j1xEYY
         ll5gZAhk4spyZUBDIJfBJPOXSSRwmRX2MdefleRwD/Bx0tkLyxonlsXDT348emPHsmuJ
         LjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A97fPr5cHfhrxHhFHaQswuQHzeokCg5yObYEXJivLSE=;
        fh=2bG0Il6MbIaAFArkOuyJwGMQTHXjVb1WiPcyccSbl6I=;
        b=Y27GKu+9c6b4TcAmWMo0iONZpgAlM4bq7zJfgVC3FsPF8v5mvq1EhYDyWpaVhAA5pO
         mEGyUJdhgCSIkdBZ4Te8Ngi16AUmlKaz+TQpDW+CZhzu2aIFRZ3Q6Fra0umbfMcR65y/
         Y5zWlgoaxSYYFQOX3pZxHiWcJ9GqNCo2OlfaoPncpejfF3XEFP1yEwHmBHa3HGwn0ibq
         vV5auRAUi2WO3bzgsjU6PBAGeJ9rGl1b/OpuTwFG0ArssEbqBpzuvurvIsbhRjrNoCfT
         myPUGx+0cmIwieZNeNSgTX3JhYejvTFqhwK1tJE3WIkS4Z6mpt5kb8cKjl4y/PRpDMSl
         Ju8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790023639; x=1790628439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A97fPr5cHfhrxHhFHaQswuQHzeokCg5yObYEXJivLSE=;
        b=P5cTTUxX79iwIQhMi7z1z28iVXrdXeGYWPUHhEJ9SWn/mdbAlPbxDzK+OpCZF4MYk1
         390kiDWX5uv50WBOEqYuHMOtNQDV9payc48aCJxdCfrPqM49uH5m5Oda5SYt2R4hSQ6Q
         wFYnMyFcYOfiius5M6U4YRf/ay6sYf7dqdiwy9+JkJ0LxggkdCmG8FdUefDxfRrkDk2l
         0pQaV6tdE639D5JxHwLoUZWV62MexMwcCgLwzdO/R89aCIk922RtEVieBeXdPr7ePYxJ
         pwuwUazCNkfUBsee7OK6L66IIs+lP4zh1d2xryDvqGXkQGAmJiz6U8PZtk/oSkug8m51
         8ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023639; x=1790628439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A97fPr5cHfhrxHhFHaQswuQHzeokCg5yObYEXJivLSE=;
        b=A7Oqo+p7WqqI6qOJ3i1ie9T1ttD87Gby8qcrQZ13gvC0hOaz9P3SyZLiJenYsJMEZ2
         BSwm6G0z2C7eKk05MFo9qzq1mt3HgtWeTRE9pc4LWxdv8PLEyM4cdVWBGdt3+kLZBD9+
         srRewhTNKJ8bsTYjWOlYkc56uBJd4KzAlIcrFc1OIbq7HgIK5PRKn+H5s5Dz4vXD/0ex
         H2Gb8GuoITUh3a37J1/hJ2bjZdGEHEw1ZILR6o5FRbsnxjzedrfrrPj+VMEL3wp26tCE
         3Ku2zJMx7pry5GwoqMYgpL/4umUhttXcfoW9usfRfx7JjdKlKsllhyKbxSQYsataw9MX
         bT8w==
X-Forwarded-Encrypted: i=1; AKwUvBzF1lFe3LmQaalXiVjSCwG+Kf3jKk+Mgorrwn2niDJkwAsORuKIj45li0pErfYnOCJbSolvpuE=@vger.kernel.org
X-Gm-Message-State: AFuF++mrPY7TWbVfMWW53CIpPFttH4c8vPYWrpTpJMHhnC2gVQmB6XHA
	2VEM0kcT1WxxpPZWbE1JNYRn9HDJ5JwefjfxCn/MaP2KT0ITz3sVl9H4EhDkbIZ49HiHsYPWyIw
	uMBAS+ak3BWWrklUs3lGYWBEsFFme/5UFi6c2vDdZ
X-Gm-Gg: AYBFou2wUi980lrwVOLoBrvXg5e8MRr0Bm7bw53crSB2zlezmmx6DZjyumgqsbtNcgf
	SRDUTcR+dbLE69XtOae44XDx1S9tEd+TDwk0f6kd0bb5UDd18UlIBaTd0LL9ttadPCPu+uW+zYX
	mnk8NWMEQSKidtZYyhfm5A+OAWSrKyuffbmrQG1i+HA7XR3J81YNoswsx4MZ9COA1RgmMl5rx4w
	Lxqgry9Jf+ODDJQvX0JLwa/+fsMdK711HdmCYNcOQKlwnlZ2+83EikYtjvoYbm9WmsOpDAKzjTK
	29X/r6yVMna6mVRBhLkyX20rS0zbG/Oo3b1yExumViwuADM+X9dsDv2gfAaHPkB+cn8DnSQpvoC
	uQMDYd+JmSq5+c00OihOBzus+WaF61pvs3u/qNWBNLDC6bU3UpMFQUWq1RgpdiponTR7fkg==
X-Received: by 2002:a05:622a:98d:b0:532:c9be:7e52 with SMTP id
 d75a77b69052e-532d8d54ed9mr24541901cf.18.1790023638021; Mon, 21 Sep 2026
 13:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921183758.1812310-1-edumazet@google.com> <20260921183758.1812310-6-edumazet@google.com>
 <20260921130941.70ef8dee@kernel.org>
In-Reply-To: <20260921130941.70ef8dee@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Sep 2026 22:47:07 +0200
X-Gm-Features: AcwNN1UEcGJUI5NDFj0zjqWyXUbCW0oaFJRYXzM_E5fmjMQLXRsMwmtUKOeyvFU
Message-ID: <CANn89iLMERcEm35=gXdxMC0Ti2ukkeF-h1PCR1xP0Sbb-chorw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] selftests: drivers: net: check the RSS key a
 device uses
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 21 Sep 2026 18:37:58 +0000 Eric Dumazet wrote:
> > +++ b/tools/testing/selftests/drivers/net/hw/rss_key.py
>
> Let's fold the tests into one file under drivers/net/ (not hw)
> and add to netdevsim the reporting that let's us exercise what we need.

Ack, will add this in V2.

>
> Putting stuff in lib/ should be absolutely last resort.
>
> > +    for fl_type in FLOW_TYPES:
> > +        proc =3D cmd(f"ethtool -n {cfg.ifname} rx-flow-hash {fl_type}"=
,
> > +                   fail=3DFalse)
>
> netlink supports reporting hash config

Ack, thanks!
