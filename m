Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629443A6EE3
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980224; cv=pass; b=gEOKM3NSzL3LH7TZDumv41LaODAzhy/wRNUD6hwk6zXvLcpKeVBybiTykCZq7nFavB2EpgIK+Z9c1W74bdIj/FcF2bNepArl4kAUm4HjRC/Ji6kH0j8WqfKDPRUNVo953IpQ9AqrxrpxnaM2z3c5BF7gbeBNnFNoLIiARADAEcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980224; c=relaxed/simple;
	bh=HRyDszTddmkegZPbqbF/UibEB7wszONa/Wg5VtrCDCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvviSatg9u7IimGo6gnffSlb0qUidOjeT/Ul8mTF9eyaQx3o294755OYcGAuAp7Zaq7sKGadA15EC/myuiUQ/A7ZlOxqBiiX2tMt/5rzZj0MEn6HC3+GC/jGjLcfMnEcxYQJFyjupPHzLFOG6/W3R6LRqMR1EgjT2kg6Bpmr7q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1xZgLgq; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1xZgLgq"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c2dbaf828eso585214e0c.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785980220; cv=none;
        d=google.com; s=arc-20260327;
        b=QYgUs26i20986yuL9V7mL+bttq0hhpdEfiMdEVFHqIiakp90QtpyVCTugcvj8QKLZ+
         NJ9jZ3Frds5pJfmkxvLaZBbLPRO8FLAV8aidT0d88oOcXb/1VvlFSLZ9KLLM7qaPF8P/
         +FClRNGWnqu9+uf1Ky6VzXHEfLcV6LDxnwRD7Vqpe6ePS07N8G6cvVWg8cCp16BoiIaF
         br3Si//00L/Jx+IkAhrgo+7HYusr67XX5gUFOF7jKVxK/F7K4TLyRlKoj/fxUlvfa9k3
         ovbcOuBuB6w+r24ZpOd59bByNKTnM5wQBfqRRGNsSSmCwhbKrAqhnyBfe69MFSnr3LrV
         +5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CmtSbhR0umzoPCNMklVcndk+0d6Cbu71OPbe5cqrdZM=;
        fh=2X1DI3jsTHRgauL7EIwzY9rkNmTJq42loXgRdu9axks=;
        b=cMzdVoKLbQ9DmxJb6jCDQJ/i9hJMdafGr5ONINueuZ5DmCpv92LCwiiUuDfRYxtUNd
         929rno0F7fstYFlcwKi4SBBf5bXnsAja4Enz2dirVlXflr4e98MZ+hQI0xtBZftg8qtL
         WHs4l8PANrh+kC4O7TTj3LVmmlbnzaSHbVCzz53X/cCbcL3dga76BGmZFEOMcoTdHBse
         Exa6BxE6z+riPTrWbC/bsvWS5hzGUm/R6lwAaIp9DKEXvmtZdrU1I4tikIEYboP0rM51
         PBD7cqkKmTXzz++yV9YGZxkn026WyO7sG04dYxMg9CPq/Er7xW6RaI946apKFrbqs7oa
         3xYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785980220; x=1786585020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CmtSbhR0umzoPCNMklVcndk+0d6Cbu71OPbe5cqrdZM=;
        b=M1xZgLgq/OM47q8liorINFQb/B1dl5WWK/SLET5KCnsRDxYXRn+z5bz2hxM3jQTpba
         twuBT06S0LBGq/1Gvblf3+Qb//TCIwPH/YpfIhsL2wcLUvNVPMOmPVFRZeWkkBGuvE5H
         SONxju+GJVPO1q17gwp6qpZBTbjffpl9h/rQQkFvmsY2Otfi1Qj/KEoOeuJqUhQVdkCV
         gp3CMRXbaWPAiAKbkwsEwVVt6Yg7gAODl8aP6PZL+upseYSeL7MnNxTJzYWC+vdCOUL3
         2Xw2xfBw1JRQCC6+8h6OJvuRPdhjOtAfXzQThbQci7PS47RT/G8lRRQUf77ufUVef6yL
         uA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785980220; x=1786585020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmtSbhR0umzoPCNMklVcndk+0d6Cbu71OPbe5cqrdZM=;
        b=EI+oZXP1ozBhnQxALK9katreo3iD0msdUxw5kmtsPMwQFv/elAnNUgTU/fNpJ18Jd7
         uKJU0ZgMsBbnGZnE0ud3E60RoaLjDmDnPSpRGfoHPQgfje18lhFUNOW1xBQogi+qczNW
         Xz8rgkiXD2cmiCQQ+ReXuWKYP+TW02R3jncbEqawCV+5Sjq0k92hFyI0TjBa9Vw4Zqtq
         fLv1oF5Pmw404DhHC7gNJLinx8BvbvgpsHpxRENCrgkv+LfQZE0yiwcLvZzag5vBBkeB
         VPj6YWDYQj/qau9RvLknDjsvhZ5FAVp/ragQe4SdZTYmxQz50B3ketVcQONJ07TAONuA
         HtxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1kLHXtLh6faxIMuRfnm6czeYrzjnXytBDi47d7MR8PbjvYrzRXVG2JMJn75WcQNpzb1rhYdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuFTO6jgEWLDktTvBbEVD15OsL/B1S8+Ku4dp+ABXvdtsK6S4
	WyJ8xMRy3NBVYyqAQ+q8iRM+4Vk6Vz2OfAWpVGON3h39svXK9sWjLqq/Et8J/2zXPdubloxaDpB
	zxpc/LGhjSDJZl0fM07t4ba5jY6OqbWg=
X-Gm-Gg: AR+sD11zw1ZkEsBHoMVR4lXkIjhOsFkEabDwK8KwuBTMutWXgFY0XJ0XkC6+jqBm+EM
	0uvUDj1Wfr1vHVixLRDziHNJ2CK7AbXISIVjj2AT2k9DkYJREI3X8EnsfQHoxRwkYX7u0arUYtp
	xvzFv43Lp+2tOSXznUEU/FW5FpBb529sTZPk4z0bWJlCAe2z6caRAzIvJmCNXBq5dqvXcR+ep8I
	q35KJ3oE3IgI5ulslo6Q6/ZR45vi1cPTvXMON1pdm35FbJS7TqGH6xXcnwXqZMPW1vcF4ZGQrob
	ikZyaCGwCxBgDIia9VpQYTM6nkc+QDXd2Nz6zgfpuWmnaFUN0gqbXsEH9NTgkxC5ICQzv6nMH/Q
	W2rGOR9AOpCh5ZV/nPAS/ZJPDhh4TBlqJoQoyZtjwLndAW5kCl/cymh4BvWSKCECIUSXCBzK1zy
	FQ45gjPZi4ZoAVSWoDSqNAjGIsb333PkPijBtv
X-Received: by 2002:a05:6122:4f8a:b0:5bf:bb66:414f with SMTP id
 71dfb90a1353d-5c3d93a8410mr1586273e0c.11.1785980220218; Wed, 05 Aug 2026
 18:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
 <20260804-submit-acx00-of-dynamic-v1-v2-5-3eef49ff1d8c@gmail.com> <20260805141737.GA715959-robh@kernel.org>
In-Reply-To: <20260805141737.GA715959-robh@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 5 Aug 2026 19:36:49 -0600
X-Gm-Features: AUfX_mzQwafoGswTs6dpUFv2c34FSJlAsZ9bjOHCBKQRghZLcM4QQZUZyorkfog
Message-ID: <CADvTj4r7qwdb4+-k11HD7d_8kYhJX3=XE1ftaRKP+-xpSiST5A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/8] dt-bindings: net: x-powers: add AC300
 EPHY control
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 8:17=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Aug 04, 2026 at 08:27:03PM -0600, James Hilliard wrote:
> > The AC300 exposes its Fast Ethernet PHY control registers through a
> > separate non-PHY Clause 22 address. The manual defines that address as
> > the link PHY address plus 16, giving control addresses 16 through 23 an=
d
> > link addresses 0 through 7.
>
> That's not a separate device, but just a second address range. You
> should make 'reg' have 2 entries.

I tried a different approach in my v3 using ethernet-phy-package to
instead of ctrl drivers with the AC300 control address specified by the
ethernet-phy-package register(internal it's doing a + 16 to get align
with existing conventions).

>
> >
> > Describe the control endpoint, its required VCC1 supply, its 24, 25 or
> > 27 MHz input clock and its SoC SID calibration cell. The actual PHY
> > remains a separate ethernet-phy node and supplies the MAC-selected
> > interface mode at runtime.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  .../bindings/net/x-powers,ac300-ephy-ctl.yaml      | 70 ++++++++++++++=
++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/x-powers,ac300-ephy-=
ctl.yaml b/Documentation/devicetree/bindings/net/x-powers,ac300-ephy-ctl.ya=
ml
> > new file mode 100644
> > index 000000000000..8a616ff3e89f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/x-powers,ac300-ephy-ctl.yam=
l
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/x-powers,ac300-ephy-ctl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: X-Powers AC300 Ethernet PHY control interface
> > +
> > +maintainers:
> > +  - James Hilliard <james.hilliard1@gmail.com>
> > +
> > +description:
> > +  The AC300 Fast Ethernet PHY has a separate control interface accesse=
d as a
> > +  non-PHY Clause 22 device. Its address is 16 plus the address of the =
link PHY.
> > +
> > +properties:
> > +  compatible:
> > +    const: x-powers,ac300-ephy-ctl
> > +
> > +  reg:
> > +    minimum: 16
> > +    maximum: 23
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      AC300 input clock. Its configured rate must be 24, 25, or 27 MHz=
 and
> > +      determines the corresponding EPHY_CLK_SEL value.
> > +
> > +  vcc1-supply:
> > +    description:
> > +      3.3 V supply for the AC300 I/O, bandgap, Ethernet PHY analog fro=
nt end,
> > +      and internal digital LDO
>
> Sounds like this supply and clock would need to be enabled before
> accessing the "link PHY address"? If so, then 2 nodes is really a
> problem.

I think having the link node depend on the ctrl node was preventing
issues there AFAIU. My v3 works differently though.

>
> Rob
