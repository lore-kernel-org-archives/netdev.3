Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63199449EB2
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976225; cv=pass; b=kPtvk/W31pcXDioyiGyHzRq+XdXbsKV5CWDWVxfLidlYy0b7eIbyW9xMskH70txdhbjJzjgHZpb3Qyc23SNB5Vf1QcqUy+UYUWfvbIzv+wUXowL8gD8ZjxDTrWUG9LqXtO3YkBJeVwp8+rKKAZVONmeM0WX9Py+3QZe/U1QREbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976225; c=relaxed/simple;
	bh=v92a07kZ9pv1iZ0gl/XUWpQyf6mAsKw5gJ3QL1iN71k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oG4/vXfHK7g/WYu/atqcpcVNvoLzat4nIEYHHM5LmJVpO0A+tOmjPXnDkyMajdFDaggzeV12XdySiBes3zfJcBQFEh+aIz+rcFYokd0atr9qjTEPIrsYV01W7N3XzOrLTWfJOtVouP3G55340tiIIqqAarWVPvBuLrYunl9jGO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5FGxH+0; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5FGxH+0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48af27fe287so392873f8f.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 04:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791976222; cv=none;
        d=google.com; s=arc-20260327;
        b=Bhn40bP2dGztFqYOShdZylWVgr0GGXhfGRX3/kjMYs0m5CSN2qfai6mVbkMubLqSkr
         57QG3H8fZVprvl8opiLJk3VEc4lzGneHUby7bc4V9AinSZbIJx5ACQh6NLTIzg+t8oSi
         JLLvOJciYVGuSVtmqtxWguq1EP90Sjvd0dEyAs41LwJXP9Smtok2tjjy+OKTjFO2maaW
         Ks6MxLQSxywJVF+VNcxYoLFicuSelUTs8lsGB498q5xgPuxN/PjdQ9d3kQV3ZhyDUfl0
         Y7gb/eEZVZ6Vkf28reyBYZNZQfQRFqqLUB8aKqDEr2wyP5ZAtNr/koa4rEpXg8ZPHWbN
         ab6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sUDJh128qN21U/Zac0vqYWgqSkXm0ycHDE5s6YgcYz8=;
        fh=oQGdRRi8fio8esHhmGDhKu4KA+WNP7fMaaGv9TxdGE4=;
        b=K0k3eUfbXssu1KVKT9q44ZBD3ACaW1mms28UC4U5ztty5BpA8thW5zNq2+wQTk/Cma
         mZRcuW7lzdaZoYxCUoYmVLUpOtlVqy+gA/atVk2X3QLRzORMGoTDAvBzY1i1LcRN9vOp
         RgZPb+Vc0CB/ghtwVVOuXV75IP+Ye9Ehn9Yd3/tYo13xToAVE7DTZomOWLZwBlW9cGmk
         Hsc5F3p3y3NCbGIRsDmvOW2xMAYxcPyh8LxrjyYJO0JFLbsWwi81VDJfEYQwDrdiId32
         gRhS62Ct8iV9UvTdbMvhrwpdgI+WxVwi6yqwAV1NCwZEz/cCvgViotoCimXnZg1tTBju
         cGYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791976222; x=1792581022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sUDJh128qN21U/Zac0vqYWgqSkXm0ycHDE5s6YgcYz8=;
        b=I5FGxH+0z/Prn267fHkf+CyaJZA71gU35He0ty4Jj8o1IQIU4skBDiCxFLNaTQV1qz
         ZaS6WC4lH6k3BHebs0XORvU9LBHcvmvhhjlz5ZvgJvsabdyy3Q+jpRV/29Ec/yi6qmVR
         HzvtKtQ31N6H7q/WoTlkYbizhPbJ0NNeCsE/THeiPtn3Lh+YRIpyskDBa1greRZ5kwF0
         sOXKkyJ2rX6oyDchG4MuNxTLPm2ln/7Ziv6Snrk2VHz1WCuWH2eaQ2UU05/goTsQXcMo
         ZEiFzJ8kbHy30crHme205EmvIMbGzulm5J45rQzIt7tx03Frnp6w11vA9IsOwNUnDPxy
         T1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791976222; x=1792581022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUDJh128qN21U/Zac0vqYWgqSkXm0ycHDE5s6YgcYz8=;
        b=EEaCadAxkVW9L21VKiJIBYz833WXI5TqH3ELqjdwWTzogx1SJXw7uCh4tpQIEug2Xd
         EJi1AeCLWgvaaxo5SSL25ibl0tXqxZRQAO/tfKywqKwS4XDcNRXu3XHl7gCURxRz49vP
         mPvr2zATc0QglRx1o03oI5rXNyB9+Gsi1jUdRgwdOPN2KwP0PJeey/aJDOOTgYDczKbd
         CqeeecUwJspOZqcQrDCViI+PCo/GY/gNuEz1NqW0LePIgcIP4Oz0bXWeBqylHyic7pdf
         zcUEqLoGYXk3VwIGZS3Xdvrz8JxTOTT7kjThOmpKvbyvnAxr0nWcXSqGwmrscLhplQRG
         1Duw==
X-Forwarded-Encrypted: i=1; AKwUvBxEOrrUB72+Od/AXlRait9aOoQH3tM7+Y+nHQ4lmb8bp3EcYRkUUvDWJE1DCIEtJ2iyhMJlJOU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKr581+r1AJN1HTpIlzl1rSoIgZOGti8JGxMCxN85Us0Y7Mmj02
	6Ro9UZ2l+MwZAEtibVlcgeU6qJgzh2007K3I0DPOStfxRS/2fVmRODFD8AQJIbnOfHoPOnpg37E
	+f9UYpa6iUM659YwFHsdWN6ewjdrPch4=
X-Gm-Gg: AYBFou1qZkL07cyLBw7zmq2I/oyjXe6UxCevlf1Sts8zNyVBrkOTzy69UoAU0SDC1dk
	z/URWvL2FlYW8qiA7K/TrIsxz5AhoQrQyr6MqHwNsk+Yf2auZ42mLVOiZHIN/VugheA27omI8gQ
	ooBDrKKzM3Yra2K7RxULIneEYDMadz0t5F0L/21q69vX4TkzSY1/sOYS8iM6jqnap+FrCS0XuVB
	ODWbbscGGEmR1UCX2imss/89PZV+BTdXe2kJD/+pmtbLCSWoDo76mr3Z8pBrTcza3HFb2qqDTlV
	MJ97rJ+db4tXjqDl5PUHmxQHPhsiyWwBteJJY2DWDBwbMEPAFgupQ56sbGejB9kElVLaT+eDkaD
	Hof8LNYLECPZJF5hco4YzYoiZg6Ypr7zQNM1kK2qRyumbxQcUf+3uahcTwcpOWfRiQP4ctpfcuK
	J9s0gUBsGk
X-Received: by 2002:adf:e004:0:20b0:487:88b:4681 with SMTP id
 ffacd0b85a97d-48dba9db07cmr22258882f8f.10.1791976222256; Wed, 14 Oct 2026
 04:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-miic-validate-dtb-v3-v3-0-68617b3dca5c@reliablecontrols.com>
 <20261006-miic-validate-dtb-v3-v3-1-68617b3dca5c@reliablecontrols.com>
In-Reply-To: <20261006-miic-validate-dtb-v3-v3-1-68617b3dca5c@reliablecontrols.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 14 Oct 2026 12:09:56 +0100
X-Gm-Features: AclHuK_AtxgKnhvGzHMnS03oYn804x_h6ChuS1hEcf2qg0FXvn7x9yZA8Od0Jgc
Message-ID: <CA+V-a8u-Sa7zwYRDvwzQB0N4GT4kAz8fj2fJX1dZCNx3Gz85Wg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net: pcs: rzn1-miic: Update port
 numbering for RZ/T2H
To: khendry@reliablecontrols.com
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 5:48=E2=80=AFPM Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
>
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> The port numbers on the RZ/T2H are documented as 0 to 3. Update the info
> structure and change the member name to miic_port_last to be more accurat=
e.
>
> This value was being used as the number of miic registers when setting
> default values. Add logic to get the total port count and loop over that.
>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> ---
>  drivers/net/pcs/pcs-rzn1-miic.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-m=
iic.c
> index 3aa513467060..31716241b58f 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -222,7 +222,7 @@ enum miic_type {
>   * @index_to_string: String representations of the index values
>   * @index_to_string_count: Number of entries in the index_to_string arra=
y
>   * @miic_port_start: MIIC port start number
> - * @miic_port_max: Maximum MIIC supported
> + * @miic_port_last: MIIC port last number
>   * @sw_mode_mask: Switch mode mask
>   * @reset_ids: Reset names array
>   * @reset_count: Number of entries in the reset_ids array
> @@ -240,7 +240,7 @@ struct miic_of_data {
>         const char * const *index_to_string;
>         u8 index_to_string_count;
>         u8 miic_port_start;
> -       u8 miic_port_max;
> +       u8 miic_port_last;
>         u8 sw_mode_mask;
>         const char * const *reset_ids;
>         u8 reset_count;
> @@ -485,7 +485,7 @@ struct phylink_pcs *miic_create(struct device *dev, s=
truct device_node *np)
>
>         miic =3D platform_get_drvdata(pdev);
>         of_data =3D miic->of_data;
> -       if (port > of_data->miic_port_max || port < of_data->miic_port_st=
art) {
> +       if (port > of_data->miic_port_last || port < of_data->miic_port_s=
tart) {
>                 put_device(&pdev->dev);
>                 return ERR_PTR(-EINVAL);
>         }
> @@ -523,6 +523,7 @@ EXPORT_SYMBOL(miic_destroy);
>  static int miic_init_hw(struct miic *miic, u32 cfg_mode)
>  {
>         u8 sw_mode_mask =3D miic->of_data->sw_mode_mask;
> +       int num_ports;
>         int port;
>
>         /* Unlock write access to accessory registers (cf datasheet). If =
this
> @@ -538,7 +539,10 @@ static int miic_init_hw(struct miic *miic, u32 cfg_m=
ode)
>         miic_reg_writel(miic, MIIC_MODCTRL,
>                         ((cfg_mode << __ffs(sw_mode_mask)) & sw_mode_mask=
));
>
> -       for (port =3D 0; port < miic->of_data->miic_port_max; port++) {
> +       num_ports =3D miic->of_data->miic_port_last -
> +               miic->of_data->miic_port_start + 1;
> +
> +       for (port =3D 0; port < num_ports; port++) {
>                 miic_converter_enable(miic, port, 0);
>                 /* Disable speed/duplex control from these registers, dat=
asheet
>                  * says switch registers should be used to setup switch p=
ort
> @@ -825,7 +829,7 @@ static struct miic_of_data rzn1_miic_of_data =3D {
>         .index_to_string =3D index_to_string,
>         .index_to_string_count =3D ARRAY_SIZE(index_to_string),
>         .miic_port_start =3D 1,
> -       .miic_port_max =3D 5,
> +       .miic_port_last =3D 5,
>         .sw_mode_mask =3D GENMASK(4, 0),
>         .init_unlock_lock_regs =3D true,
>         .miic_write =3D miic_reg_writel_unlocked,
> @@ -841,7 +845,7 @@ static struct miic_of_data rzt2h_miic_of_data =3D {
>         .index_to_string =3D rzt2h_index_to_string,
>         .index_to_string_count =3D ARRAY_SIZE(rzt2h_index_to_string),
>         .miic_port_start =3D 0,
> -       .miic_port_max =3D 4,
> +       .miic_port_last =3D 3,
>         .sw_mode_mask =3D GENMASK(2, 0),
>         .reset_ids =3D rzt2h_reset_ids,
>         .reset_count =3D ARRAY_SIZE(rzt2h_reset_ids),
>
> --
> 2.43.0
>
>
>
