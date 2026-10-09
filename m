Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4404E50D2
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553426; cv=pass; b=OufST6DQ/lleMnwdck3BMbJHneyqolDwedQSHILYJKNhdMspw9ZG5kUHWAWw8TVTgNGx2Gvfj2KXWIyxlGvw1Wp9Nd5mfUsy7PB+rT1Ori6j4+X9zJxhR2QFtEZuPEEAtjHeynmbsd33nso9AMrGUaNdpvPtDRHINCC2q+eKvlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553426; c=relaxed/simple;
	bh=LQYO10lBY8YucsXcJTd6r+9tll/gYfDwC9yXCQh2QM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEAHMTyDca/3kJz6sauXFF7bdheUeQL0khFNUh06ImxoKznyH/TMc5cYfW3tpF3C501HCnp4S2dcBoHRREaRu0XKgHq7YzaU74uujfk7Gmu2qyAfca2QoNbqiPNNv1kqPBgiLeX0tL9IiWjtLFGRaccNKkjtR3HWjPCoZZGtH10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=KK/LlfF5; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="KK/LlfF5"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-353804b591eso1099239eec.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 06:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791553423; cv=none;
        d=google.com; s=arc-20260327;
        b=hDluwWheC/iCwIzlCg4XIzz74D7NcMAbDUZnkal/tGYfNeHd+sOFLTYLjle5tGAbLE
         zoDQo7of9KeyX/7SY35igM7BQuxUUC/d2jVOnc3A+4V6DV2EkMYmyJw8ovpcBBWX1MH4
         lU26QH+RqBt9dToRRtr5O1idosHE5spA6f0m76/4PqPsix2xT++t40e2mgUPdij5nuML
         AhO6YuBFp17ts9gAV0qjnL/3/Tjviuf73eHUi42yYC+5/NrixZ8o/q4GFwjv+/jD2mo4
         d012wKoOVaQ3xxNhmhU6wcQeit90gH4ewnPdppKwWlcUpMm8LPNC6V4AAGqDIrIzeopZ
         n+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cr53QXzLPPnzzAYL9+Ow9RuREkmHHvveZLDzlgyx6as=;
        fh=BeIGK70QjDhU13JTUHDW5XR2hTrjzUjs+ndovzSOsDA=;
        b=p6jMoMZ9oqbcXR1InS1S8wJTOWuUbffD3v7QD+cxDbaGW7s5HL6XeVISUtH5S5KXL8
         c2neBZIRZvzuJ4Lu5EVu+qChw51D4HyIbS5oUsKQtsK26rbCRn0dB09mdsQLRMn/IjC+
         6afy9TW74Pvo8mRcy+/oo7CKILdkm9IYOzbaBF8EIps6FORJYA3FNfFV4QW/oy5a85Ol
         XeMlYfDrsUvOI30flMrfFgbxR/kU59K16zEBhCO/zG4kowa4eytumqLGwh5/zZ0Enbgq
         D99UVy6k8L13Kox9XaAxUvy3FUiGyGXNFGDojgrFuxGz1tLvxsOsKtQS6jXN8xmpnYi+
         aULQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791553423; x=1792158223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cr53QXzLPPnzzAYL9+Ow9RuREkmHHvveZLDzlgyx6as=;
        b=KK/LlfF500M9HKvvEgwUZaMtwopK0KJsc7zlInv3lmgORbkZwrgh1WDGJoxJHLO40o
         pHVo62d91gMPpJ3soaq1BiMrYr0AizMjjPyqCIBkIC4w7gjHvTfLXybRAUnI5Po67+ie
         n137UHeoo/KUHK5CaLCeN98pBwDFobrzY5qzA/8N0CnbljkinGekpq6jiakTio/VeKRu
         uZQBtUFGx4xjW+G3Qg29Fz00i5EgI3yHysYnN5n5UAl/a272zYo6fcBrghJk14YL9/ot
         Spbh2FcFdSnRMUlw5oad4QAPXxpc2UICU9dzngX3csn5Koj5Xd9VcWaEv6Qq+EplAiAf
         BntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553423; x=1792158223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cr53QXzLPPnzzAYL9+Ow9RuREkmHHvveZLDzlgyx6as=;
        b=bjh7QAWc2/9KJacDQu4cPuk462D6ZzYcSbAoSqXsSSgz9LHWADsUBY9HS1nufV1l2k
         Ay7vBO4KiM+l6k6MFw9pbKl0W04zgXRNkwiw9hhst+eQyZkvENujEqUgiDcJi7xHBXsH
         nIFsU5JNpjq00A7aJieAa+48zXMC3OkAZEOHbISc7MRHYph0UG4C6M1EweEnqPOTr82D
         pjvZ8pZijmbLQqqk7zYxhwRRprxtVzbjNE3ySUIZvCl95yBjOBrf7EcVQ3isVcbV3VK0
         BvvTR/I8PKluMjily79iXYAAIVEAg9w3EuQ4KQVFETovPVK8Xy1v7l+MSU2XXCsj9gmr
         xGjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKCO3lcAiWB05ajSzSE6NMZJsRGqkTHVooZ4oIlqAD8O/8BcCiuFn0QKKPyTKFspzHc2ZGng8=@vger.kernel.org
X-Gm-Message-State: AFuF++mQr+I741NWoWa2TfEdOvMPwC2rBTQq4WEdY3ttI3XK7THqphFH
	kQYhmYWt29C/yJHvpEeczp8Cl+vDLaNZwjLugA/IC5yUzVDq6EltYa9EnaetodFFzoF/OQmHcVk
	YwqYnFYCwA0L+8aatJiVh152Myu8OfUJ9nsNKi9puXA==
X-Gm-Gg: AYBFou24jbu1anTUMb3o2u1lE1OaCl9lnVv7h0VeGJwdPYXZwhOZdKZ2FURUs1HzWNn
	Bm4o+PqI+N888NqNODbBF9+AB3JJD+i445J9qGG79qt1QPyH2MyA1bG4Pik5vtoFulTpukis3X4
	1gR8yZolyJ1HE5r3MPkjCOavD90cUKBYu5HVPnqViJLKNo84132B9ONOeGmhOM6+aUX6oM465Pf
	uWCKUy9/Nls/DUgzg4V7XMwpBWTi7nprjdvaG3E8MThsOueO5sgTC11Vk1JlJC/pXRFLLwpoeN+
	UgCQyCRkksigH+qx/e4FgUXLAxryuOv02M6y8LM+CutYCt/4Zep+8+d1QB23pU2mJCjRC3TXpJm
	dy7iXtLLICClbSg==
X-Received: by 2002:a05:7301:6e98:b0:33c:e74:4624 with SMTP id
 5a478bee46e88-3537e112919mr2778982eec.27.1791553422908; Fri, 09 Oct 2026
 06:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008141131.0ac356dd@kernel.org>
In-Reply-To: <20261008141131.0ac356dd@kernel.org>
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 9 Oct 2026 09:43:31 -0400
X-Gm-Features: AclHuK9i2kH_QiKyGXflCaQStHSk6ronnlxME5kUtzkQ0rs0GpgdrjH4gnmAJRI
Message-ID: <CAEzrpqfgBrvwy0Q_AX8X1s3ogq3g1U=JmpqHAM8QUmMHAqWPsw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/10] net: stop calling __pskb_pull_tail()
 from drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Manish Chopra <manishc@marvell.com>, 
	Rahul Verma <rahulv@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Shahed Shaikh <shshaikh@marvell.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 5:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 08 Oct 2026 21:02:47 +0000 Josef Bacik wrote:
> > v1->v2:
> > - New 1/10: skb_drop_empty_frags(). xen-netfront, netxen and qlcnic
> >   relied on __pskb_pull_tail() releasing zero-length frags even when
> >   there's nothing to pull, which pskb_may_pull() doesn't do (Sashiko).
> > - xen-netfront, netxen, qlcnic: call skb_drop_empty_frags() after
> >   pskb_may_pull().
> > - skb_drop_empty_frags() checked with a boot-time test under KASAN and
> >   kmemleak, on cloned and uncloned skbs.
>
> Please keep in mind that we ask people to limit themselves to 15
> outstanding patches per tree. You have 18 right now.
> (200 active netdev contributors + an LLM) x 20 patches =3D=3D insanity :/

Eesh sorry Jakub, the skbuff BUG_ON() removal series is the more
important one, this series is the followup so I can finish that work.
By outstanding do you mean per-merge window or once I get
notifications for things being merged I'm good to send the next batch?
 Thanks,

Josef
