Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D33EB0E9
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594426; cv=pass; b=RLTnPEilRbKmdR4HyqWYC2NSQw8WZMXz3rjbeOG6UpsNRGOUCoGD9TH9LyBtYkCcBEX5ohjVeDSnc/yGoHPcC+/7a1OiI20aeACCWHxnjhUuVbZoAh8O0Ya0uN32uV+tRw/E6vuZPgh6lzVKP6Lk68NRnfYai9PdL2mCZHB0T74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594426; c=relaxed/simple;
	bh=NP4m/7FFeb4FM095XmhQvw1OvTgPqido2XDAs76IywY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz6VB2ggHds/aWwPki1YTRmYCtl5+ppLxhV/BM33KUavS6GEDk0IsixVXGFpLsxd3nzvF5W/I7EaP49fQWO0RphqiYZTAeW+mkcfzfQ8Vfzau5MCbEVzG42d55duCJBmUw+EvvZvSQxJDnDv4avw3oyrOi3SAbZPXSOn2wXJxP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfpwS/G8; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfpwS/G8"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-667971437d6so14272661d50.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 17:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784594424; cv=none;
        d=google.com; s=arc-20260327;
        b=gwM+MBK9S6UmPtF/MumtV183l/VjfBJbwXeHy6a+YzuwD00admYEWg75RLYWouARUF
         /wosNErxqvl9sux0tRgaV9lYE6EqM2jI6ydOpyRY5nnfKK2a8oBbjWobPoqGO22c/rIl
         4I5eSbOzVuOSkYge1Z6G0Rbv5/R0SIL3Wg7kkMxE71j0k3goeeccQAj+rRxkYTcZersV
         gdlwPxFaktfhIuLH+gcOgpR8teutPq09mbH73prEcbBZYf5rjgbKHUEG3baIH/kGCiuE
         Kq6V+AcJGCObpVEw7GAvFiTv3aef/aWWM6CXIMxuRWuwTcAD8Sft+e1+qGhFEq0s13h3
         14Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/PmhXiNkweZnLEwDItIiLzlyIxV8P+S1Yml54aMj6Y=;
        fh=rLeCZ3Lkb7ZM7/ym2kFfjbMzhjaITlZ0XFAuJRYikXc=;
        b=dggN2OGO2homJskaNu8tPKakLVJhoqooinLpZpBJ5+i3ic3zFCOKfxM9dnhIjii9a/
         NVL6Vy7XswgFZ3bTYVJezzzBAiaIBfe/pBtWZA2ciy0ROH2UjBab8JrRXwUFk6K5ItGa
         2+J4ucEqxeSq9DG2ydolXGHUCrkhJyjz6d2ocNXdaUiNrSZh0Sz6jnAHK2yOb+E6qjnc
         wBqyk25OnE6BoJYrg9jCCUVXRzeIGRYEOqeY324Lw5XbtzRAwvk6ZCd2pWQt9zL08pMy
         SeyLCRstGrG4q22OjYyqW9IKaMmDv3z9/+Hz2S7K4I5qYiZGKn+IQl7zM78zfp+TREaM
         IVxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784594424; x=1785199224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u/PmhXiNkweZnLEwDItIiLzlyIxV8P+S1Yml54aMj6Y=;
        b=jfpwS/G8k7N3hFHsUasjmad58pwaSVGiAud/NwZ9b+iAaNHyJQyUiXnL/xj4vpcPzZ
         GwvLLBxSsNhoWGT0JbINk9CCluGk05kaZw6RM+yA1UjePVtCaz4kpuppIwJ4QJru4zS9
         QD4msmAMUFiqpubkxWDYFv9n5lcYusLYRdnO0fjFDZjQsShekKXwyBif368AT6DVFBG/
         dE61Xge9k1k6PhTHlzJMYliCqJx0+34giBTpyPuNAm+BAvn23o+wQzkGc1vWt/rTHJiU
         kbgmxgdv/Z5xs+CHpBtU6bmEAqjugrRCa+D5aRUlMahYyKNSUtHMJQpAl2N+bwTxaNeu
         FIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784594424; x=1785199224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/PmhXiNkweZnLEwDItIiLzlyIxV8P+S1Yml54aMj6Y=;
        b=aN9V6melMPJ2e1+gZIEi8Ab9SLrVzD2wpUDDL9foFI2OQAZx7L1kJopvtOx59taWqE
         8Gyy3tH9LOdYhoDaDVx0oWYz6KolQq2H1KiuIxdUC+Ml+BrmXLkFvixYjGxwzU7wqFfQ
         Kgiqfpg/OzKOJwJQI4VoAxSjAPi2qcIZIGrzgQz+Qjl0yzZcvhWYBPZQwg0O4B48C55s
         GCj+46N5glZpfHioUGewHTmd2/w2fmF9n1hgf33STussRahnUly0t95Prv/5OoadLSib
         aWBk6jLtR/0D3PRAt8Tdi0vLzYInpNKnBBnjhYHxQznSi/LfUzWDlogNc8W2Qiv8/U4v
         bawg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4v23aaQwbYwsnahCidPZu1hmK+f3fYatGTNMbfS1+dcsebqM2Ntkba4pKNlG2Aez428/+e/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SbEiD95HC+S6KapITrs98MKO3dN0oUISon09Qizqbls2ygf6
	W6ytGhTfKv1nVgeY0RNFi0RBfagZ0kEaUQZZduembIfIhlFJMVtte87JXP74jiTFP18X7NsvicK
	hdSgaj+gurUkK+qudcccKJzwY+kRGKus=
X-Gm-Gg: AR+sD13yD1aKnXGm1rxWNpfeyzT6XxeWOsP4Iv8sBDDd80Pzk+SFybfE40oaiNN48+9
	a842TSCDn1nutFsoHUihQdMf81p7Q8UZGhkAQhCZq0yn4DHYzbZJyeUnl6jnyj3n5osRUcpREyZ
	0s8SjzjuiKZ9ju2h6h40Weyylg4K1B+XKj0ALo38A7JygB2Suhu1T5088om32x2KTGQj8hG9XPZ
	X61jKHPF5Hc1ym0HrJDPiWCeI9+wRv77nmgayLVUvhnXSUeRES8PfeEgO8FbV7abLmc8Gf0EMJQ
	BmuUlWtsrKTf5Sk8aouvw5oISA==
X-Received: by 2002:a05:690c:305:b0:81e:b7dc:3dce with SMTP id
 00721157ae682-81ef26c0dffmr49886907b3.63.1784594423836; Mon, 20 Jul 2026
 17:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711150628.2914205-1-michael.bommarito@gmail.com> <al6ABAMHeE76yldL@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <al6ABAMHeE76yldL@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 20 Jul 2026 20:40:11 -0400
X-Gm-Features: AUfX_mw36s0y2ormAOkosI4vBsNzUhY8gfCuww9ShBgf2r8MUtPCtf_7IW_q48E
Message-ID: <CAJJ9bXzMNRvPKDUMBrryaWAjF1WqHS2vS1qwOqOOm--5+YSSqg@mail.gmail.com>
Subject: Re: [PATCH] net: mana: cap HWC init max message size to HW_CHANNEL_MAX_REQUEST_SIZE
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 4:07=E2=80=AFPM Erni Sri Satya Vennela
<ernis@linux.microsoft.com> wrote:
> I don't think the described data flow actually
> exists in the current tree, so the security framing looks inaccurate.
> Please check the comment below.

Agreed, I got mixed up on that.  Sorry for the noise

Thanks,
Mike
