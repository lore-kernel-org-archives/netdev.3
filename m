Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E453F6A3
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084559; cv=pass; b=QBKodUl2XOarO/3l0RrIDUC9sqF6yM2Rylw7cDyhsP5euucpJBNXaPptEM5onCylEgaSPAuk5wmow/ESKg08zEGoa1wFSPgICONzRV9mQnatRF/HuuUDroLE5zAchRdx8rWjUYaQkIgK26uNGmzcU5GrkWmaM+Q/nWOHuzDkVMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084559; c=relaxed/simple;
	bh=RWbJJQvfWAeHPWGm2VIAzQ4UpyfGNL/jTGHu/y+875c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evVXJ16mAdjrN1LwNMQp2Hvx+xUVQo8L59zDnxNmsY/j+5BtLSevk5XDbB0d3b953OysRb+QjMb+xvpfmZ43QwqrDnXREv9y5jY045JzoKsJI2nEsA7/nhgXGml88M9JaPCg4wsNJcL0K0aWdljV/P40qJBOg3wVColxCh/wm+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PVKFefBl; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVKFefBl"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so35583805e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790084555; cv=none;
        d=google.com; s=arc-20260327;
        b=m9DvYM4sNCFypLZC+NlVeBmOSSNwxXxps192UmPb9itXMC8/o2lkmP41pMPSk4DwmF
         SiAIkxIj9D7xHSeytkHbmEW/oGZl6puXWzrRIbKSv4ffH+3V2tPkbZrVQl3fPlXZPmJs
         0Vsdw++j6FeNdvUStFJBZ2UqoQltERW1Pn439iehZuQGf9L0lhtgaTjsyViI/cboMi0d
         Fk4nerTIB9YRrOzXA/RLSVXvUNSRu2Nt4/Qi/A/5P5KMB3wa45WCU6TvnaMEpq/Y9+d7
         RBPGym4reWEYX8iYZZCwgSnMYJ/G+LfBuOMrgVdCw/qH/E8/NRWYw7S0ghK1KT+OwEvS
         3VzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RWbJJQvfWAeHPWGm2VIAzQ4UpyfGNL/jTGHu/y+875c=;
        fh=d7+ahofc3YUHHGT3KDZ0k64Zpj1+vAuo8ZvBJ7wzrUU=;
        b=cEJXRMT9FRQR7VFVKQpUMdC4BnJfPKX8TAYg9yUNiZYNT7Y6ZU/wtjesAw8Q9L8P/0
         UHs1GoXXDpmVD8QwAvaFbqNYGEt4QieA8U1JgyCzrKjhmJOn54Ld4OZAk3NQAq4mcHar
         KDVFdyOcaW7iUNzYukxEn9OrCRJ89gLEw8K1KjRP77IFee5r5z+hiNJwCAZWVr3MsguU
         bJfurkXGqU2QjkUjTHdx9J2ddfYooGVcAK4dkJEh4b0+403U/D2KB1YZUZa/fiTB++ss
         btmk8+91c7FAch5MXyjBZspqG75noLMKrXJolx6Z1eZlg/ing9bY01mD8xury28Bxvww
         yY2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790084555; x=1790689355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RWbJJQvfWAeHPWGm2VIAzQ4UpyfGNL/jTGHu/y+875c=;
        b=PVKFefBlcFOCDKy1n0QN5lHjLSrft4fKCdSbgxb57Na/UU483SjKnCQj+x1SoySmrX
         d0TGW7wrANuRhC2Lst8Unmhk2M5iJvBJsHpJAp257cp6Xq1AwScABAaQIC9nGyB1n0aR
         JW3upfYBQ+7zT3+qwM7Jy3LOiMx4PbGPxt6v9tkscTS83kQUyqtsv76ADdC5Fkwp/gUZ
         pNHnSn0eKwflk/y5274BmEMeaj9dE9qNWLZ0Z6/Vel2sKDEBxs0qMmQLGEfvoKVtjv98
         1f0bZZpwVaGUYP0fxJmlWJSlC2bPV1fhUKBBicwjqHE68jHW1scrva2Pdd76SHH7M0tf
         ZH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084555; x=1790689355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RWbJJQvfWAeHPWGm2VIAzQ4UpyfGNL/jTGHu/y+875c=;
        b=zDblbT43BM7C78QpKLxuFRseou9u4AAfY94wJA1nW6a/XxmhNV9ezuqFtz+fIrD3ZN
         qpYhQnCmzAGapZoGkda2lre8dFdug4r29wbdxhnr6AmT+YdlbIC4rB2ci16jS0kGqVJ+
         i5Cn4uNLjT2cJq0rWK5/O+thdOR6syuiqElBMJL3cYiVzW56jQRh4vtw/495gLtEvo7Z
         0TCfhun5ZDcOouVe5kh4ZFIRMVfADHegGUZOGOa++qf2ptibLPq+cZuQ63e1ImrmC+CP
         rahZHU23IdUYMIWNq1KktVieusqXe5GFXCMKaKzEfcQAYY5lbueTxzxBMBSYOyWaamUP
         Gg+g==
X-Forwarded-Encrypted: i=1; AKwUvBwlU2RjcRJCB6AUj5k07KxwT154Jq6WCfCMbwTnPTs1p/5s7Fyy2bYxRU3Ug0jajLZ6CmeVD9c=@vger.kernel.org
X-Gm-Message-State: AFuF++k1FRunTpFblmXETLTX1DaZZ4cdfONYtpvC7G5u8eEucPjjLoMx
	LfeeixhHFf1sClaF6g2JD+zbjcDRsKAP1jjNaBm5PbSPMDq7sW6akRT/0uRh+wbgjnFm/+9epHy
	H3XXDrrhNPLrGivMvdB+pOi8b+vf0s6YfIamAxesl
X-Gm-Gg: AYBFou1/PTQ+vXK/Md/rSLTmffWVizEwYt5aO9XZqNE7AkCElyIizBnuiAzlPyjqfWX
	gZOr9zE3+z/qI677lKGPyTZj8enXz3aeMfQX8cSIXhvgzbDtymE64AH/+ML6kYasvDCYnuijjsu
	y9LXfeAlUcjKpfB/55E/oV+jhSvtZcwSQBzggdK6kfMrYmemGufmBFGJAuHUnoDZXivLP6ABenq
	m+TdKIdSLuYf+gNX3AfdtevCO66Dqlzc87tvg5xt5zkIBfprldUjoaaLKyhzPCGDepfdvntkaRm
	y9pE/mJ5AJ837k48CPVRfPxhL2mT9gVifXnV2+Kq/9YQSDUQPFjCSukDd7jf/W71LecYaZgjo51
	l+5xRgZQQlaFIsDa0qXZx6ojZhY73YiDfARnEclm1E2ID9p/YhaP6
X-Received: by 2002:a05:600c:3585:b0:49c:cee0:f383 with SMTP id
 5b1f17b1804b1-49fc5734ef6mr255037765e9.16.1790084554891; Tue, 22 Sep 2026
 06:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918100016.100988-1-sagartaunk@proton.me> <KZuCCqRjSSbylbLLVhoUD9-xyBpzD9jUB4vGC16N0_hIra8SNxFeh9lEJ6FIMYMgKqf41J_swYT_HVx3w13k0cSrYYkBljOF56suy3gpgAU=@proton.me>
 <164304b3-3324-45f1-8766-536767e7b9d7@redhat.com>
In-Reply-To: <164304b3-3324-45f1-8766-536767e7b9d7@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Sep 2026 15:42:22 +0200
X-Gm-Features: AclHuK_p5XqAJq4ss3l1aLkxA8gLh1Up43oHI9_Jc3xmArdkhL0aeV3XgEseFCc
Message-ID: <CAH5fLgjBC7o4wt0WPH6xEkQEkOvsjj0ymLq2xAGXoMwN-fZyBQ@mail.gmail.com>
Subject: Re: [PATCH net v3] rust: net: netlink: validate attribute length
 before casting to `c_int`
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sagar Taunk <sagartaunk@proton.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Matthew Maurer <mmaurer@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:36=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/22/26 04:31, Sagar Taunk wrote:
> > Hello, are there any updates for this?
> >
> > Also, I wanted to ask is it fine if I keep fixing stuff pointed out by =
sashiko for now ? (I.e pre-existing issues pointed out by it in other's pat=
ches or should I ask the original authors of it first ?)
> Does not apply cleanly to net. Since a repost is needed, you must
> also avoid empty lines in the tag area (i.e. after the fixes tag).
>
> WRT sashiko-reported issues, beyond be aware of false-positives,
> generally speaking net-next is the preferred target tree (i.e. no
> or very limited impact, very old issue, etc...) with no fixes tag.
>
> Focusing on high stakes changes would be appreciated.

From my perspective there's no issue in landing this through net-next
instead of net, as it's not urgent.

Alice
