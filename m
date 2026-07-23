Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6947ACD5
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822782; cv=pass; b=CZhy4sIjtaH0QQp2al/NMK13CbIT7YSfxUrIygP9rrPeOPxB/5PshIntgnIQn9I1oCuMHQxJC8297TSdBZWh3A/4c8ywwJLefNJBSGaFKJ2lRQyN6RrIH35RsDDlCJUQWGEZ9nCGc5JECxQKYjs+QTWTYgjinpPtH0hbB7e3sYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822782; c=relaxed/simple;
	bh=FvYIfRYCEjjbVjLfQARMk6BLucVnGSuIJy4RHzRK1z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/GgyPozPrD83cxVtmRYGa3YFjSh1G1p2bbjTEy2TLRMQY1uJOzbmxOKt0Ef4vDqp8LafA/PzCQvYJoS5h0+QbOUv7MBlHuQGEB8D0WOb1J+Vg8ISd1xKRI+LcyHBcd3+uypZg+PP4TzZ9q6gdMDs+KlIBfTNGsFjccYIDMJcGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUk2nRZj; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUk2nRZj"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51a868b6962so10322621cf.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822774; cv=none;
        d=google.com; s=arc-20260327;
        b=MjwfgYJsQXluRCoV8yLIFBhFTh846hakq3WUXGF6uYcjeDSCjNi6QK0mm9N/ewEecP
         kANDlX9Qz8zFGrMYNhYbrUdftQTV9r+gEzaqnrQCVT+IgCImH46RbX7SuGIdLid/EoE0
         RSkIHlz4J3Ng9YIm73sSFbOCkdQ25CgfC/UhbeTHyKanCvlgSHjj74Yk5oDjYN34VqMZ
         q2SPCiOduFPnZJF+5jwfk6x7drR+FBnctAegAvcgbfYplly6lCjnV9v2YnO4P1uQaBQ4
         jZhKjVaiIYDfXyixelzawaAZbeBe1iHeU1/xPOx14HcKD52MCMTaOlFl9cjdcOUmocGI
         78wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FvYIfRYCEjjbVjLfQARMk6BLucVnGSuIJy4RHzRK1z0=;
        fh=9EKsElgjhGFEL/argVlSQAgRjQKtsZUu6yTvqIbD+1g=;
        b=BojjaRJOscuF30m1B2WC+MF6uXUsXD1AlVTqKHnViTJUxjUSKXLe2bFBM1XOn8CHhj
         GWsEZrUF3yXMendN35bMpyhySL351NCzkJynK0L5KfBldgK9nQBBuedCrnoCzbVFooFR
         KFaLICH7CszTWRzTj3sg+9vZ/9JHdoqSoYALmC9E4IYb3yF8vfMean/pFM7L780HXKmE
         dXPS7pAiaf0bl2YAUjDNCy78kHYu10OX1LXes9SOHZcsUOfcmwXk9V//yq8IH9G7K6JC
         QtrC9msfoerhaGvK792FByJepyLgCOyBInNwV+egSpYyEr2uQZASDKnnC199hWNwBUvy
         aQIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784822774; x=1785427574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FvYIfRYCEjjbVjLfQARMk6BLucVnGSuIJy4RHzRK1z0=;
        b=EUk2nRZjD0r1xdASkZsNlXzm8UbFIl/S7l8BpOrOqkdrAB5BUX0IIgcFEBbwrvYnGM
         ESszRYkTBd5mnly8seoaVciOErzTuBla9MF8LbVWrCgVlsT1V9F8GlTkHK6sk+WHy1pX
         3ZaV+HhMQ256pE/SqiaJdRij/dK5azHLkLs/v3l+b2OT+8W8JHiqY+W3sHXrLluXMwyQ
         iup3bjpHLW47m1fkYjjC348a4xkQGb8/h972+K6H5du9/5pHx/6m0V6ctb/f0tgeUg9h
         wM+hJ0TF98srpt2DmUigMZSIfa6h/Fb1qzbqyTFM7aZ8FmhHQOb0iWVscAPJT4/E4MsU
         UZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822774; x=1785427574;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvYIfRYCEjjbVjLfQARMk6BLucVnGSuIJy4RHzRK1z0=;
        b=nqpXw79gCtsBwrgh9YK6B/2GiXObp/ZHImIco7ggtbv8rxoxLdgrFhSwfNI/JthKhg
         rNHdz8MzPCQoyU7GiOnnRGSWu+2bzgX/aqafhyKRuT9GUiS8EoHJplNj67Uhso5UEuJX
         4j2Ri+4BPRcj2NlXPLOCm2aK122aEZ90KTY6kTm8RG1oExyLaSelraaWZpq6n31SClB7
         Jbnixo9EQbgVvSReI0i0GXdhfwlg0D2m0WwsadK7IKXiIGoEnnpPfVuF8kLsLMrOp8md
         Qj8/9avOYYkfDuFBcDVBAWvm82mo/0blJ4MY+RmUdyFwkWNIrchqpnb2+/OyjJ/UWrqb
         1YPg==
X-Forwarded-Encrypted: i=1; AHgh+RqJi/LXyUEPD/FVB1KBgkOyp5F/SGqxcJOEIy4hFofJ4LEjDLWxO95v2guj/X1RytLVGylF/5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzsMLmqCXkqOq6L88zwyK/aux35t7N9LXtrbI/yJ9m83kF0R8p
	YILX/i9ARk4im7vZDCpVLwtqhi/AA0dZtGpmnK2YpZNzW5J3iddJPiLcUVLK9NpnJC8O8cyi+Oc
	EjVfNWnnxTN524fVCJHl2hQuirDC9PwIfswlgGuV9
X-Gm-Gg: AR+sD117nHQO/P7mhuYrN/kH8lbepwpbEoXDoGzSiBCwwRWPXgjjKORN9ZTQ6E4HNLZ
	cddCRuZe5KFa4C58PJ3NuJEaF+R7mTXwVaxZi+eUJ3ZzBq+gtXxqstT+UbQVgxkd2ittNmBZCXV
	sjnuUG25fd8Udn0eVId1GcvGn4H/ZyOK+MXy6NqAf+BndhDZ7UmTTk09METRnjw++zDUCOgrr0H
	ITkUXXIlqi02FWz02YmuwCBQTPki1zumS/Mzo+yXLrH/hP+v1jARK/Bzjyq9tnPTfYQiY6NHHI0
	NCyxjpBcbrmX0jf2tkBqumgrAN6csJ5UpAusNlwrP/qUXEfCnGqvB0bjw0grscxgLToQ/E6uww=
	=
X-Received: by 2002:a05:622a:1aa2:b0:51c:7b11:41a9 with SMTP id
 d75a77b69052e-5283dfde951mr35886241cf.86.1784822773528; Thu, 23 Jul 2026
 09:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723155145.158572-1-alice.kernel@fastmail.im> <20260723155145.158572-3-alice.kernel@fastmail.im>
In-Reply-To: <20260723155145.158572-3-alice.kernel@fastmail.im>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jul 2026 18:06:02 +0200
X-Gm-Features: AUfX_mzxaShQqbFL8nzPH3k2r3U1gmFflr3ARoJhSg4viS2EXaoqKERNPsVNL_8
Message-ID: <CANn89iJn=_iz239z3=4pRPH=XFPqHtM7Y7-_mjd+bP7t+4NAbg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] virtio-net: Block malformed packets that
 overflow gso_segs
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	HanQuan <eilaimemedsnaimel@gmail.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Alice Mikityanska <alice@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:52=E2=80=AFPM Alice Mikityanska
<alice.kernel@fastmail.im> wrote:
>
> From: Alice Mikityanska <alice@isovalent.com>
>
> The user can specify any gso_size in a packet crafted with an AF_PACKET
> PACKET_VNET_HDR socket, even smaller than TCP_MIN_GSO_SIZE =3D 8. At the
> same time, GSO_MAX_SIZE =3D 8 * GSO_MAX_SEGS =3D 8 * 65535. When the user
> crafts a packet with gso_size < 8, there is a risk for partial GSO to
> overflow the 16-bit gso_segs field when dividing the SKB length by
> gso_size.
>
> While the previous commit added a generic guard to skb_segment, block
> such malformed packets in this commit altogether.

Too much code in GRO fast path.

Have you considered silently setting gso_size to max(TCP_MIN_GSO_SIZE, gso_=
size)
