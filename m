Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34041391845
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368054; cv=pass; b=M0jx/f4ZH1UgX1IMShof4SXOm9ulI1qOJk5UYW0FHfX3FB1P/0O2k99ExMris5Jjq8cd8urqFxANBtQmsPwyyLx8VGD/EFKMiGSCEAsn7bVckmJgcJXSwSnZVwnBqaWcd56mNlziuaIFCJWuy3nAyxN+uKnaHcBwaYvH04S4I7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368054; c=relaxed/simple;
	bh=WsuaFOJA3QfGOIybaFoCOFur8n07QvAggdyEOm1UsEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akfYDbVf/S5pdqzhrQLzZEaKqvMcsZtv841QReT3UfYmcmuziMZVs9iOw8gZ2YbWRdbIpBL1trZg0s4QBajqBnnCSma6evdiuRyFpMcBpGr2hjDXtWm7MqKWL1wbjLkE+g8QdfqP9UGeTVnqd6oT3EVfOEfmQZzuzYx2LyYsHgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=c7/HPRmv; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="c7/HPRmv"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc7cc8aafe6so777377a12.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 03:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791368044; cv=none;
        d=google.com; s=arc-20260327;
        b=dCAD4Thc8ovn+Xk+d6MwjSv9yYoz2rn4BYtGfrIXo4Nw9AWODSQ5VCmb0G3YJPWMpB
         h5wBD3qTznT9NJkN16OzmcWJ7TlCyGBPRhf4fN8zlw29BAMcA71i55RrT2LyIgGs0Mgs
         cbLDoPPm4YI/36027sVdiH7Ut8VHZwd3fqZUKTrZCQjVfTyD/+NJvwwl58llr/vqiuUB
         /TgqxKMeclxLgoOU5O5VADAAG7dVtG8nDv1pfU4qnPVa/dDSaNRU1fi9dSzQXYEKksy7
         AS9KY3nr1z9vJ3urQryqpUIrqbBa/TjKgzvCa+3f85fihE/TPN2pyUTRponJROEyn/z3
         WzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EDY5pGh9vkzmlGXT8oGSOIFOutoB19sXEcV1QjJMB6M=;
        fh=XrLiMricT4TXmfbU/Dyrksi4NfGUSUR3mvMxv7+E5fM=;
        b=CWtbrGm8Eha8TDrowdUfu+LKHsTRFS2KbBWPYWnuaRNdfmyinTq+vlHcH56OaNFvGe
         hjmJrZzvEPN4bCrnfzrJzjN3vshDgLt89kYCOXv+SGmTrc0bNMQi8EbLZjRu3bcpQbys
         0NKtKwM8Mo7nYGZ6z8FoD4hvHOquNRLs49HqJWZCf473ADyRzYNdI3h2tabR9eE/aPc6
         ryKDpfodyBS/EsUHMQW9UIZJWNg2yrDT5algo+5VPo4CLSR3igwXNJoDYj3Euw4Bos7D
         nYg1EQsUrG3dimdkDClRoi3+tYDosCK/lu6V73j0Cw6I+XuMMzeJOHyh60/FOqz7mOxU
         eunw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791368044; x=1791972844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EDY5pGh9vkzmlGXT8oGSOIFOutoB19sXEcV1QjJMB6M=;
        b=c7/HPRmvaFsgQ3nT9KveBgXEF0t2l53xsK/09iGalPxnJsZYTuFPZ9FfZjMXWP4xpP
         N5QEYRhMzbyhhytF77hTiOHjXPqpb3EsTXtzDhZe5Xeq4Ud60BhxklArrfNcCo9kxJVl
         4ssDG94LRn4kDjNJHcRtDmVv07O7jPTB2JwkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791368044; x=1791972844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDY5pGh9vkzmlGXT8oGSOIFOutoB19sXEcV1QjJMB6M=;
        b=CS/L5AOPu6r/99sjZ/pk+PQxXUFbwoAzDUCSyPtEY8mEOsvWhQc3n6KqNopwXhFsoV
         IPasTyeNuUrc1UYwZ6eO44Z+EyNuoC1LT/Ox3vkabYtmKwXESyFr2XXzoYxt7h8znAYR
         Ho6F61fRSdihhsyPKSwQjeNWP9caCKynOmFbONK5mFOqarYMDmzEWYsM9zs0WegFFKaR
         zxb0a84kx8CLQJ7AxvtM88UnB9e0gkUK5YmI/qKSlTPg++edSI0RKrbTIQmjn2/sZ1+t
         tKyL3y75fzw2KrzNoxjTP6fR0CJGIcOGqmGHUN4eqCnwGuuTJfmGgvJ0IV4QYnkDALwC
         VssA==
X-Gm-Message-State: AFuF++nZRrqwQnabQslAqXtC0S7HTBp+/X5uBXpHcxApONwf0KuIhAht
	nRieDEMRa52Et/K4cE8Tl0kwwSC9EFQAnN1gwSfDkl/2+pL8m+WdEiXhrs4K1Sgsmzy03g65sEM
	gei0xEP9CUCTOP9R1cWvoxm4Kzlj2mos+/7nlaWKR
X-Gm-Gg: AYBFou0YHF6J1/V7ULBB4ddNHwwkN/j9hW5e6S/an85VE/i9WDQC/mynV5mQzHnX4k2
	Gc9AK1PAyV5LpcaHvTSei6RIMpgVkNhNkM/KPO6x7MQOiA5w7X+VIv6GMUkmVbW5r38Ox50/zrJ
	e4yDeJ3bmJczgtme6NtPLj2+Vd3xkVUv1fYARirLpjw7uAi3h83gB2npMwCN7qDS7Lb5TgElqiX
	M8yoWoWcjsayipw2MQUE0JgjkV8TpLrYC/chaEIg2qaMVHgKCo56+YC607e2R5sGejhwDX4vDgP
	iM55rB7eTehs2Ee909yKRaTRcNg2RbpPYgRvsH10ARDzIEPdNLJ9K5/MF/4n0w4nQgBxZLSXasx
	hwpbA4JLryZXNyLR8dk8ToJftRgQhaJeaiA==
X-Received: by 2002:a05:6a00:4fc6:b0:881:d48e:7138 with SMTP id
 d2e1a72fcca58-891b1193567mr1317212b3a.4.1791368044277; Wed, 07 Oct 2026
 03:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v4.20261001193440@mojatatu.com> <20261006153043.GM83879@horms.kernel.org>
In-Reply-To: <20261006153043.GM83879@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 7 Oct 2026 06:13:52 -0400
X-Gm-Features: AclHuK-6LfpAyzZ2sADy3SuT_HqRXqU-iqNXOJEoXzvGEd9JTb0nrG_AEBvSCLU
Message-ID: <CAM0EoMk=RKMafa0tCUmcjFvm3_f=wGZoNAoy8q=i_r8zR2x_6w@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net/sched: cap the accounted backlog before
 it can wrap
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	moeller0@gmx.de, cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 11:30=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Oct 02, 2026 at 03:44:31AM -0400, Jamal Hadi Salim wrote:
>
> ...
>
> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
>
> ...
>
> > @@ -1712,18 +1738,24 @@ static struct cake_tin_data *cake_select_tin(st=
ruct Qdisc *sch,
> >       return &qd->tins[tin];
> >  }
> >
> > -static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
> > -                      struct sk_buff *skb, int flow_mode, int *qerr)
> > +/* Run the optional external classifier. Returns true when the packet =
was
> > + * consumed by a terminal TC action (reason in *qerr); else *flow/*hos=
t
>
> FYI:
>
> W=3D1 builds complain that the line above has a '/*' embedded in a commen=
t.
> This is likely why Sashiko NIPA didn't run for this series.

Thanks for catching this Simon. We don't run W=3D1 - already overwhelmed
as it is with the flood. Do you think we should?

cheers,
jamal

> ...
