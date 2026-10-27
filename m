Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133259;
	b=rFhl96Y33J2A8BogoeOC2Gf1E2HGYkiBVFE9vybh8cn65jgijp6LRgIn6YwIUpOlSSni
	 yyZa0zqhMoqIL0ZSoX0t2CqllfH/6drDyIuySXzx/7J4sfVrJbCc9Wrj5kBSE9zs7/2yy
	 1loc7eIzm88IUESGlUoFolFEAeaImhAzW03EpFGcYlVxuAeQOVqpVYlajgZGpLTt9Sniy
	 NcCoMIAFjhQ3v7QBr5247H8ZcHo2BukJC0Q669LQTxQJyDTQjnS9xmHj1RKxr/qXZU+wk
	 P4bPuV5NVgF9XyRHIn2Uy50TW4fASWnTLoGupnPY/yQfY5lRwpgBvrlE3er+fWWBf+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133259;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rQIqjK4g1zUPmSsEVLMejmP+b1YNzLwYjJY91CT8SgY=;
	b=WrrhaywFaZZ4qF69Y9Ta8JZPCrXNAE+9eUxHP5lgVCMPSKVMAYYMZDro37vlC1GskPCV
	 ZLtsqcPwl1d8b7hUeIUKreCiePhP6ImgP6AOo5rTz1WHZ+fJ5FWIBAD1TAo47Hznr3tnO
	 ainILZRiJkmWai/RFV/YMDUVuoJ3H3cfOAB6k5Ku/B/+7Q9P0DskQPEtbWDGM70e5Qrmh
	 YBgzfKL1DaWMpGJdFl1aBCcJfo7eX9CZ3pOp+CA5Ic9gD1Z67U/eyujgNiZqpPIDhJOkL
	 4FD/NVYVFo9rFoFKF9O4LCliodxpv8dL88vJgRxnY8ADL3Z0GZNrFXmJBcKyeuOmzCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Kg0B5c7/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128B606A31F
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kg0B5c7/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E73B1F031E1
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133259;
	bh=rQIqjK4g1zUPmSsEVLMejmP+b1YNzLwYjJY91CT8SgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Kg0B5c7/kUTwJYhvG+d/zMAnpEw9sUkUe0EK5IXZOiki0IpsXjR/WOc1HwodokQZk
	 09gTTh7qjbCglucn54NOUtquRvsLjBB7TCjpt3fcfqiF60JB51p0FVUeVESffzYbCY
	 t8UyJhzP0TCQsAuWqplruoHB8kOt6DsFc/88ubCYAnmf5vLJcPob+Ux4e56oo47Cyv
	 SbAEwoz6+Hu5Bt9/NpqWQ/aSGM4h62/AqsDNikp9fDbUkUsmin1Gnv1hM3plFPZQu3
	 1/XNfyB86s5KCPGdsa7sWN8lmzooPjbyub2IDoX9CkfT0tCK3azq6IrrKfHGPqKsAP
	 aB9PmjX6PjqZg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-705cb6cedd5so846969eaf.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:34:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw7hhtbQyc+vIBx3Di8ZAbMSronTBb+wrfdDxzImUFodWFL7XYG8qUvLBETp9J2u7kZSzif6QI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPGlGjiU1A5B/8WZOweGW/m5KUWb8Scq6qD2/QeDGAb/RzZfMD
	GtLk9+SkuXDkleEgZuI8lUNyWlKIw4i0/Lz2jqsi7BEPaW3qnRLG0yzrKGFxCIxVEKBraQRanyL
	JmpO4vzRKgrNgL4GNPqOWkh+gD9+uco8=
X-Received: by 2002:a05:6820:199a:b0:6f6:1e3a:6e1 with SMTP id
 006d021491bc7-7126c34b5c1mr2484996eaf.44.1793133258826; Tue, 27 Oct 2026
 13:34:18 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082604.1485903-1-edumazet@kernel.org> <willemdebruijn.kernel.22807e0fe104d@gmail.com>
 <CAL4WiirUmA1GnUaZq5MQgENZRo1248YSo6AOYb_OseWS8p-Cbw@mail.gmail.com> <CAM0EoMkTUK1cvNbeSvyOGLQ9yxQfR9-TsmQXXZbosbX+pz_2WQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkTUK1cvNbeSvyOGLQ9yxQfR9-TsmQXXZbosbX+pz_2WQ@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 21:34:07 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq6KJigDcqu40raE09Deets=rpMRLUBTdqausfVRAMvqw@mail.gmail.com>
X-Gm-Features: AclHuK_KFV9zIWqjjIL7ry7AcJbbCoUK29I-uTpEm16AJgMLwZVAOb2IRVHMbc4
Message-ID: <CAL4Wiiq6KJigDcqu40raE09Deets=rpMRLUBTdqausfVRAMvqw@mail.gmail.com>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs coming
 from the stack
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, Jiri Pirko <jiri@resnulli.us>, 
	dev@openvswitch.org, Ren Wei <weir@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 20:48, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
> I didnt add my reviewed-by or tested-by because i wasnt sure  if you
> are going to resend and include the patch i sent?
>

I think you should send this patch as a standalone patch, it does not
depend on anything in the series.

Thanks!
