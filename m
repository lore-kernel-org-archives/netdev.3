Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6626F29C
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014391; cv=none; b=T6GS6ywLLKb30WPpNsHud4PYiN/GKGen0tTm31t0AH0EExc7f9N4EtKeJBu2MOw/0lqzijwAvRu/EGV5ar0Z2nucGvrNG+9kjxBTHAkmRmH/cTWVF/TOkbh3UAaP+ORR0gW2n7uP50ru+4zIUmeKk422YWj7myQdmSr9OAGhL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014391; c=relaxed/simple;
	bh=RZMuf80XDxHSbxPVmLIh9UA96dyig3RFRvrfEn1evGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/HwlTalOKZtyOhDHH9LeswQu7Iu0Va0BpPANXI3pzCusvELyHa6c+Qh35NWGG5q0HMuVfhmLDxM60JZEnrkcJ92yt/4XzuNHtEluzpTnB0b9vUolCCjYkeVTTcvXLxP9fct5GpJ0KPnRZ/D3MwFSOmDZje6/Y7r9esAvlLxzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3oa5ImF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3oa5ImF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F6EC2BCFF
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779014391;
	bh=RZMuf80XDxHSbxPVmLIh9UA96dyig3RFRvrfEn1evGg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m3oa5ImF5ltPyjbkueQya//wdm7MCFWRbZArrw30aahjjNXo/ET/kpU3Dyi/1F/Ae
	 X78kmGwnozL2KxAcHk+r+OIexTqg5A2o0SIhnOTgrLxqlyoFl6aParnGr1hFaxIm7X
	 4ckH1ikB4dQV7Yf2Sa+5tpN4/Dxtu/uiTHoWY71+VfAWC2v0tJFy7dxw1RPquX8Wkt
	 2kKwhIVOUNmp6r1oAQDOqc2I1FoJ0BAjIjhNOU/zfY3jVvwj9434IOYVNpH6WECdLp
	 M5OB2DZfW1YK3InnxCi5QrJNpCssSswj4HNC6s3Hb7u6Zw4I44kZsQUjqFM2jHqw9f
	 oK139BZU+9Xgw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a4113ab355so1687749e87.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 03:39:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/oQcm1/QQqBbLDA3hf5KnmDz/dp6HuTcDnHUvNNMzzEHSiNeLez71GjI0nBoRARETLDPVlK6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZb1dJPkn6nyl6RcDJ4R+EN914mxo/XJs0FcoKDJs4///kTikA
	QFLGXBZP34VjM5Gz3v6sxKVM/kkIqWIhm0bG/uxB4Xqsc5Jg3AQP7iLmS+QF5PYXxsQGn3DTVvw
	dV2F4pNHbUX7/Sfz1eKvKTHdH89SpKFg=
X-Received: by 2002:a05:6512:1452:10b0:5aa:f41:328d with SMTP id
 2adb3069b0e04-5aa0f41334bmr1865660e87.10.1779014390067; Sun, 17 May 2026
 03:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
 <20260516-ks8995-to-ksz8-v1-2-70d0ef4aa5f4@kernel.org> <570e6488-6320-4cbc-8d48-5438b4073d8b@kernel.org>
In-Reply-To: <570e6488-6320-4cbc-8d48-5438b4073d8b@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 17 May 2026 12:39:37 +0200
X-Gmail-Original-Message-ID: <CAD++jLnCQZtcCX6Yy8G0c5VprQP1UozqDd+6ppiStuHsdCN6og@mail.gmail.com>
X-Gm-Features: AVHnY4J8_nKN5in9STpMywwF6jSGuuV9EuyKQ0oAM4wVbiTzYv_Mz9cwlRuy0WM
Message-ID: <CAD++jLnCQZtcCX6Yy8G0c5VprQP1UozqDd+6ppiStuHsdCN6og@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: net: dsa: microchip: Add KSZ8995XA
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 10:42=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> On 16/05/2026 01:16, Linus Walleij wrote:
> > The KSZ8995XA is just like the KSZ8795 and KSZ8864 a Micrel
> > product. It was renamed from KS8995XA to KSZ8995XA at some point,
> > but it has the same properties as the KS8995XA.
>
> This is a bit unfortunate sentence, because it strongly suggests devices
> are compatible, but you do not express any compatibility. Driver looks
> handling them in incompatible way, so it is odd to see "it is just like".

Hm, they are compatible. The driver should handle KS8995XA and KSZ8995XA
the same way, the only thing that is funky in the driver is that since ther=
e
is (unfortunately) an old "micrel,ks8995" (no suffixes) binding, which is
actually the KS8995XA, we need to treat that as the XA binding as well.

I should probably patch it deprecated.

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks!

Yours,
Linus Walleij
