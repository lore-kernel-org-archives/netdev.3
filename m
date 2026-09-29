Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4749539791
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702362; cv=pass; b=RetDBsGyOe/vCpaY+7OK1u184wxQQBGvvPI7dFd6llX1iWgFwUmy6CT2jaO8ow+LG8lU0hKsxNW/vGelCosHjPFaj19jbCh3s48unMDge5WyH8mF80ykWOD+lpfZW+P9PfxieiIFAd8U2cKOzU/oUigjG+cpwXui+Q7bJ1+7C7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702362; c=relaxed/simple;
	bh=XLoH+W4btvpwkIbumWh1h9mdDqao5jnwEcNs8ugGZcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkIJcqvwAxqdwOug0h1QIynYZYdhE5AfIq3xXyHoSyA1xSpEHaMfiFjcS0G6LKpvkgp4KfM9qgPEC+GeMUxxR0Zs+9PeWeuV/wrAevQLVJMfxbLy+/jpBTDlxn1DPrLS6xsMU0xG5cCdU1E34RHrJutCHyBqcqq4qRslOMB6YNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=hVF0yGL4; arc=pass smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="hVF0yGL4"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2dd05994cso29525ad.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790702360; cv=none;
        d=google.com; s=arc-20260327;
        b=LzcfFudgdRH/rasTDmlCw+4J2GVupXKvBNGGyAc60tRczQD90QN9XnTI8/ANatzSVc
         M19JKDGzyVcJ+zfvwubNZiIGTyeOg4My8KORF5xSSGP1Gv+KtCSuGuQuYcbULkJwPJdy
         dwi3c0DJ/y3YnLbXjfi0M/R3TCMAACmjMukGGvnHS+L5YR9DpW85KuecWmKd494z/P+y
         NZxByk48/DceWD2yKXJaNaygPPODuIVp6P/uDWx0McScXF71Ko1/4xRq5BXAOquLmshQ
         FOYGMEakzdyxNAYLso7FiEZhBnvRIdodDwztbBMfxEwVCes+AOeAeo5JKOa+imQ6YAUN
         ZoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLoH+W4btvpwkIbumWh1h9mdDqao5jnwEcNs8ugGZcI=;
        fh=iXVST51UQsyoWEgpvzd0Gk/Yt8RXbbGH16YEciW5X5c=;
        b=J9NFK0ISqRnL5ZOhyXtN5n5IFnjLHBdqsiXJwraMqYDSsrF2WlfFKu7nL1sBRROCn2
         U7lhfdo8WqjOpM2SQj6WLlNfP4XGQChB6a+KI5cYfcMrPcr3chnslH/dzNEi0Nde/LVe
         MXML735pceBmC6g6ZgihrP+/uhdZ01npiI3U9khrks05A/pQnTvUFhG6vZSZLqCMnBvS
         8FFJIiXProgSCvUvSIDcfI496STlB9UmrqHqzNLGr9ieQ5X78c/X3APHot4Sc2igA4/Z
         6JvSXfdAS90Jvy1U48abvYhUEpj2tTphfvqKuNTStX4netIoZGOfGb6Tcg3Z86spgpnS
         aADw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790702360; x=1791307160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XLoH+W4btvpwkIbumWh1h9mdDqao5jnwEcNs8ugGZcI=;
        b=hVF0yGL4prYdXN8XMDa/Cw8CcLbVOt1isdWvIdPjK0HTaEhhTwGZ6GkNNkGAWq6FxC
         XF2gfXtUcjBBWi26BYCXqtlCTRKOiWUuEZkB39cZdod6SHv7ntz1JjO9+kms/CeTepZJ
         mhgSmDia3pRWsOIkGgrdpQuu+ufy0sGQkvdO/AaSGEZYWeUOLn8PHKsVSjTTVTMOTe0e
         +eH3bJG2OZlQhoBrRvscy7Z5XMwCJKYPhl785GGc3q+ddaeBfnICCWGX9mnm7MB4ZdNz
         DgTo6dTwiM/8uoPTeOJ1cema2N64LMvrcest3C/WDUdkyx4ZKs8YzfWvUcgXg+RrwCTU
         0jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702360; x=1791307160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLoH+W4btvpwkIbumWh1h9mdDqao5jnwEcNs8ugGZcI=;
        b=KxH6Rr8NTBArdJ4nrL/I194uUkbe8bgx92NvrtQWHdx5DqipUOznFPACqOICLu7Ywp
         /rqCLA5RZg5/vRr/PP57SuwPft0ILFiDnf8CVVwhexBQ3UGhz5ha0GytVUZQ1QSX10ar
         Jb80Po8sSj6mmERZPCChn58ROHsiC2bu0vhg8buy5jjAcDi7DMgpnMnsoITUP8V5Yn7a
         3wBiyq/zGDk2C6FUofF5/JEf8FThRnqDPLyx9zQJBoQViVt9PTYonhli7rCWw/gkoFd3
         BuM6vrKKCbDYcjbGcL4iqFaiP5BUnfK4jSP0R5vLL2ej3Ij3AGxzvwN1+3FrUujknLCn
         IYyg==
X-Forwarded-Encrypted: i=1; AKwUvBwRvwNOnrxD/8IKa8UvbqeCWDAzRyrUxzsH0Xk7HlsBCnEN63k2BwONB2uvavXd2XQR+ZQoLac=@vger.kernel.org
X-Gm-Message-State: AFq9FYIb1WnEutzWq2fjOt58iicGOyJtqP6r4lNkm0oO0S8eQCMXB0Sd
	F61oA3iVgYVClIlrw5UX86HwjG8m2fssKx3U8AuxuNl4Ij9ah5GEW7vAIhuMeJDLI/a/PHXGe1T
	SjvzxAuc+dRL4IyhWq/h69aEQlWe1y6pbQuIRxgvK2Q==
X-Gm-Gg: AYBFou2F7yDE97hfCVgpzE9vME9837/Soikmb+I+vpSXzvPm0wjXYaGS5COsUcRyrVu
	2T9A+cKnBhvy08FSXkP33kQQHgbRDHqTzRUqge0mjf1B9dACuqvo5Y0/DW3Fys0b6HJbeucQddv
	V/qXZKKxPQ1IGQ/N9+Be+Qn+I6ZZSIAYPPLtgvN9/TQ0sXTookOEb2lIPmmd4/xOv6HqiU1hMdr
	ZBjEbxUktYQEOzdsf3MmHu9gw4ye9zHzWv7tdkOqxPrS/E4CGhLcVSNwEFTd2q2JdstYXO6uiUg
	cSttT1yWL/t+z6jfzjOroHtSBh3RnctnS0uMPSvixKY8jQJUNQ15bxGDO7P0pm9Ib5R4AsYye10
	J2gqFk1Q8GK/psQ7NDc6kU5jpiGLRETO2hWA=
X-Received: by 2002:a17:902:f541:b0:2dd:c0ff:e72b with SMTP id
 d9443c01a7336-2df7dff6a98mr129292205ad.61.1790702360116; Tue, 29 Sep 2026
 10:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-qrtr-multi-ep-v3-0-c00831e88957@oss.qualcomm.com>
 <20260922-qrtr-multi-ep-v3-2-c00831e88957@oss.qualcomm.com>
 <7aed969d-0868-4c9c-967e-7766dbba427e@oss.qualcomm.com> <13BFC5B0-77E6-48F2-B857-37686EA1DB2C@holtmann.org>
 <05e539f8-bb7c-4038-8a83-8ab0d1a5b917@app.fastmail.com>
In-Reply-To: <05e539f8-bb7c-4038-8a83-8ab0d1a5b917@app.fastmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 29 Sep 2026 19:19:09 +0200
X-Gm-Features: AclHuK-ToRBMZLSrRMx2mcPZtu0EDHFcdsd8teCC6hGeRk6_RwlD5j4V__Nj-zA
Message-ID: <CA+HBbNGS7sVROVN3mywPJEcRKn_+FzzxkijN4Uqv0CMLP-CEJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] net: qrtr: Assign unique node id for MHI endpoints
To: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Cc: Marcel Holtmann <marcel@holtmann.org>, Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, Bjorn Andersson <andersson@kernel.org>, 
	Chris Lew <christopher.lew@oss.qualcomm.com>, 
	Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 7:17=E2=80=AFPM Juha-Matti Tilli
<juha-matti.tilli@iki.fi> wrote:
>
> On Tue, Sep 29, 2026, at 20:05, Marcel Holtmann wrote:
> > >> +#define QRTR_NODE_HOST_BASE 0x10000u
> > >
> > > Can it be exposed with include/uapi/linux/qrtr.h also. There are user=
 space clients like modem manager
> > > which need to calculate modified node id to distinguish same service =
from multi modem over mhi.
> > > This is same as wlan use case.
> >
> > did anybody actually looked at the proposal that Denis and I came up wi=
th. It was exactly addressing this properly.
> >
> > It seems you guys came up with some hot fix and want to run with it. Af=
ter month and month of silence and not bothering to review the proposal, yo=
u are trying to push your thing?
> >
> > If you don=E2=80=99t support userspace, your proposal is broken. Plain =
and simple.
>
> I'm still willing to submit a new version of that patchset originally by
> Denis, if the kernel devs so decide that it's the way. For example, the
> "radix tree of radix trees" approach could be replaced with a hash
> table.
>
> There was also some criticism about a layering violation in storing the
> endpoint id to mhi controller. However, maybe that could be reduced by
> providing a correct abstraction around it, so that other code doesn't
> touch the mhi controller structure directly.
>
> Other criticism for that patchset by Denis was its overt complexity.
> Yes, it has more lines of code changed.
>
> This dual-card setup needs to be handled somehow, either by Denis's
> patchset or by Manivannan's patchset.

I second this, as in OpenWrt we have used a hack that worked only with
QCN9074 via its MHI debug
register in order to support boards that use AHB+PCI radios.

Regards,
Robert
>
> BR, Juha-Matti
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
