Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED2369208
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157748; cv=none; b=YYNZ7iKgoPBtVXMYih07DyanIvfc4bi3EqaVUD6WGVPFwp99/eJnVSPXXDtd5K0S1XaVFjsCqNcEr177IEzJ94gD2adygJSSu48z9TRnAM2djaK+NPKikzYYNp4sihyQ86suKcRN8vCjgf779dwXJKtNXwEKy4zolLmpFAA1de8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157748; c=relaxed/simple;
	bh=KVuVxATK6tiu2JVfmX0IasB0mDRYeBOPP6q7SnmEn+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE26nTQ3Rh+UbcowcykJ38LqceaDqg3mwYcEwuCSpWrt2OK7oYggni2q0DBhzCTqfsVAd6wDPs2O9UGSYkpnAvDPnRghx+KYUdqTLIT1K9AmlcCiz+9sKZP4Wcq3wRi6xuqpWSq/nLFpkxtQFPKx9+Roy3E6StSlkfbsfbtnF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTnuiWcj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTnuiWcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9867C2BC9E
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770157747;
	bh=KVuVxATK6tiu2JVfmX0IasB0mDRYeBOPP6q7SnmEn+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LTnuiWcjB9ZD16t8sN3E7L48QKEWK+7aeT3V64p3pfV/qQVin4erfnxlgdRTzk8HP
	 xJvl/ds/epCPGZ/kwLm9E6dfxZoFy9KOCjQYrLd+kY6e75+xCW0fXSXKTvEY34Qc6I
	 bSKGzgiWwjsrJ81AdbHyT59U1Bw+aXP0FiZG6v+cT9JqSLTJuWMlOGtMF7x15t6bz0
	 +zZhnQqj2nS6yZE7cuwDGSUuNWuVOFkzRFZSD7bt+8IULrkG6JwqhZ23pXd9UKJQWh
	 dWzatRo0mGgrmTWrI19UanBozLh2P8UFzsqhTcFwwlZM+WXqbpExUn6T2/OOk7LY28
	 ivoAtVuiQiUyQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b88593aa4dcso850729966b.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 14:29:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUC8SeuTCznRX3udMVYhrensuYx75eYg+KhHly5jeo4C1mx//SAFz/0UTH+DlIFGEC2iOoZUyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGXM7o783MY7gxuuqDu+oejAYRPY9Kf6+A0auLK4b3z9E/DEA
	/XnzM2a0qRbUMZKTMQhvxhD7XYOiH+PBYJF3LJ8z83dLODrhGWyUVeqimCaPwadA1zvNJ/sYUG/
	OqBCO2hgqJj1yEln3PgjPLGBTJvAnSQ==
X-Received: by 2002:a17:907:9342:b0:b8d:be68:bc20 with SMTP id
 a640c23a62f3a-b8e9f340685mr62370266b.64.1770157746137; Tue, 03 Feb 2026
 14:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203121723.312336-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260203121723.312336-1-biju.das.jz@bp.renesas.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Feb 2026 16:28:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJK3brXxSeD-U42PBCeHoxUhWJYho3ZWj__t5C1LL-n-Q@mail.gmail.com>
X-Gm-Features: AZwV_QhH4etfKSeilVLLahZp8med19LJeiVxQYVbCtyPxrnrsbuwVmr_thOPHWs
Message-ID: <CAL_JsqJK3brXxSeD-U42PBCeHoxUhWJYho3ZWj__t5C1LL-n-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: micrel: Fix dtbs compatible
 too long warnings
To: Biju <biju.das.au@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 6:17=E2=80=AFAM Biju <biju.das.au@gmail.com> wrote:
>
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The KSZ9131 PHY is suitable for IEEE 802.3 applications.
>
> Fix the below dtbs warning "compatible: ['ethernet-phy-id0022.1640',
> 'ethernet-phy-ieee802.3-c22'] is too long" on the below dts:
>
> r8a774b1-beacon-rzg2n-kit.dtb
> r8a774a1-beacon-rzg2m-kit.dtb
> r8a774e1-beacon-rzg2h-kit.dtb
> r9a08g046l48-smarc.dtb
> r9a07g043u11-smarc.dtb
> r9a07g044c2-smarc.dtb
> r9a07g044l2-smarc.dtb
> r9a07g044l2-smarc.dtb
> r9a07g054l2-smarc.dtb
> r9a07g054l2-smarc.dtb
> r9a09g047e57-smarc.dtb
> r9a09g047e57-smarc.dtb
> r9a09g056n48-rzv2n-evk.dtb
> r9a09g056n48-rzv2n-evk.dtb
> r9a09g057h44-rzv2h-evk.dtb
> r9a09g057h44-rzv2h-evk.dtb
> r9a07g043u11-smarc-cru-csi-ov5645.dtb
> r9a07g043u11-smarc-pmod.dtb
> r9a07g043u11-smarc-du-adv7513.dtb
> r9a09g047e57-smarc-cru-csi-ov5645.dtb
> r9a07g044c2-smarc-cru-csi-ov5645.dtb
> r9a09g047e57-smarc-cru-csi-ov5645.dtb
> r9a07g044l2-smarc-cru-csi-ov5645.dtb
> r9a07g044l2-smarc-cru-csi-ov5645.dtb
> r9a07g054l2-smarc-cru-csi-ov5645.dtb
> r9a07g054l2-smarc-cru-csi-ov5645.dtb
> r9a09g056n48-rzv2n-evk-cn15-emmc.dtb
> r9a09g056n48-rzv2n-evk-cn15-emmc.dtb
> r9a09g056n48-rzv2n-evk-cn15-sd.dtb
> r9a09g057h44-rzv2h-evk-cn15-sd.dtb
> r9a09g056n48-rzv2n-evk-cn15-sd.dtb
> r9a09g057h44-rzv2h-evk-cn15-emmc.dtb
> r9a09g057h44-rzv2h-evk-cn15-sd.dtb
> r9a09g057h44-rzv2h-evk-cn15-emmc.dtb
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/net/micrel,gigabit.yaml          | 23 +++++++++++--------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/micrel,gigabit.yaml b/=
Documentation/devicetree/bindings/net/micrel,gigabit.yaml
> index 384b4ea6181e..284c3ba379f3 100644
> --- a/Documentation/devicetree/bindings/net/micrel,gigabit.yaml
> +++ b/Documentation/devicetree/bindings/net/micrel,gigabit.yaml
> @@ -17,15 +17,20 @@ description:
>
>  properties:
>    compatible:
> -    enum:
> -      - ethernet-phy-id0022.1610  # KSZ9021
> -      - ethernet-phy-id0022.1611  # KSZ9021RLRN
> -      - ethernet-phy-id0022.1620  # KSZ9031
> -      - ethernet-phy-id0022.1631  # KSZ9477
> -      - ethernet-phy-id0022.1640  # KSZ9131
> -      - ethernet-phy-id0022.1650  # LAN8841
> -      - ethernet-phy-id0022.1660  # LAN8814
> -      - ethernet-phy-id0022.1670  # LAN8804
> +    oneOf:
> +      - items:
> +          - const: ethernet-phy-id0022.1640
> +          - const: ethernet-phy-ieee802.3-c22

To avoid the errors, you would need a custom 'select' that excludes
the c22 compatible from this schema (IOW, lists all the other
compatibles here).

However, I think the correct fix is probably dropping the c22
compatible from your .dts files. I don't that compatible is useful on
its own?

Also, it doesn't make sense that ethernet-phy-id0022.1640 is sometimes
compatible with ethernet-phy-ieee802.3-c22 and sometimes isn't.

> +      - items:
> +          - enum:
> +              - ethernet-phy-id0022.1610  # KSZ9021
> +              - ethernet-phy-id0022.1611  # KSZ9021RLRN
> +              - ethernet-phy-id0022.1620  # KSZ9031
> +              - ethernet-phy-id0022.1631  # KSZ9477
> +              - ethernet-phy-id0022.1640  # KSZ9131
> +              - ethernet-phy-id0022.1650  # LAN8841
> +              - ethernet-phy-id0022.1660  # LAN8814
> +              - ethernet-phy-id0022.1670  # LAN8804
>
>    micrel,force-master:
>      type: boolean
> --
> 2.43.0
>
