Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794486924;
	b=V7DPtwIqbJN0nsgGvse4mfLFQjScfhIuRIma/g4bTM0J60J4TtqhByyEsC++oHwFkB+N
	 35kvVFfOgPFIyXnUSzG+21Q/yxm44XQGDPlTtCBSH1RnO2KVlZUFKYhDxIBlxuwEWsZgw
	 2ar/7FDBYokkbW8YD7hN0hWMFjZlyApYFiw1QwXUKasaRhNobZ1Q8V++YXaykySEPUaqD
	 C4sXG2XlsimQ7FRmGne8oGKxq2rLevUcDh6QFyXpKUo3LyMfa5DoE4vWHWsa2/7u9pH2c
	 IEiCZxhd+vhzOdnL4vnMp7AIITdPVYJovjjzuIYu5D2c9C9YieMb4+u010cSaLHeIkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gmfeXtI+tey0F/T6j/hOfxDyERZ2N7Ic5Vbc9BTsdyQ=;
	b=L/0vEVdjKDQUrrXEy5mjh3D+Q4n+LXa7tLGOHGpEoKL1bzhO6nbXh0k333EgWx5kWnzo
	 udavzY1s5K6oyOvtpX/46/ZFe6AoKUKx9DchlMfgTaWZ/dObQMHzet5MijtGh24gh0rRo
	 t8g7vdnphOxwnBrMuk88C/Z03+UR+iqDRFm0+FrX6aMA797QCHauqLWqdQY00V8eFdJnD
	 LJn8ltSZdxdPqAHzX385lte8Coibe4flmbDWGn58xg9Nk1SRzq0DSsKhSFi6013sxfMTJ
	 aJIfmtcvos1jZk9V3xkJatlUVgjyg429kFy7vJHWcukcMXj0weSipWgb1CU49GC6BcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ums0J9tX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB78606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB78606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ums0J9tX
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso29547275e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:35:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794486922; cv=none;
        d=google.com; s=arc-20260327;
        b=GIpyno+LFcXTBOV9V1FbA2QEgjKdXhjuJ4EBlBtSllAv/ue2S8xTQKoo5rUWpDubMj
         kyrhTJ3TpbfDs2VKA+FPz3b8W30+xqlvY0sLxiox9sa7LVUu2MyT3DISLSlv8AI5fheB
         KvHurcph5eFc944aqDnJAeoMb23vuOuBSPN2mo0PFiNrDnMJKwm129V00GxZxekiyx8l
         FEdte3O7b7XEqKpIeXO5wgM4nCVZFL4xfGsmzXdj5Yqj7e2RD9HMiN2t6024I3JqUDiJ
         ZeCRDpZyN4lhlw9CuDTYLm5pkv7kw7QDY69NhQsAI8vEwsG7nUee/j3MHs0gHcHJf4/E
         M4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gmfeXtI+tey0F/T6j/hOfxDyERZ2N7Ic5Vbc9BTsdyQ=;
        fh=Dw62s3sBpSHzEqvEYihnfkmOLNNmtvTTVfdSLA30iaA=;
        b=omIEXZa07+axFHGbbGFAK/7eoTLcb4aD9t8gRcN8w4qfceToGPEd1u7jmDUxOiqZLl
         TxRwCckzb0jRw/ztf9TSxWdRa/iO4LM+pD7O1sc0m59A9IaqqreTRNzC/o90BIhwlff9
         Z/xW77A1vL6yEzldrfW6/lttWq+qKCrRzEDrMhuGb9P3ohcf5GgvvHIxq20oMFsHW0vF
         gC29ewtyFFnECVnkikvUwd1Jja51/OKokB7BwBFlTKGrmOcuX/SRfH+O736IotF2G3xr
         Y9MPzQ8lwRQZonIYtD/D9BbCmdtOrFVEbRuN5vZF6A30FaKnKf2trTdN/+P1kc7sq3MO
         WC7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794486922; x=1795091722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gmfeXtI+tey0F/T6j/hOfxDyERZ2N7Ic5Vbc9BTsdyQ=;
        b=Ums0J9tXeHFKhdP+fol+vzmGnv1+Fue5K3B2lj8LLRXkHXY3JaZgN1a68UZDyVwlr3
         b+0TXQx6uz2DxdQO9FJRj6XA4Pwp5YiLBfzHunkAP5nZXfa20p8ohSXA/npzC9fTPsof
         YCI6CV0szHYmKPkXtlYqz3aToZBEJPSZnO3qJny8ZRSWwckefgqbggkEwAI5aEzUA0Vt
         ks8xjf2GELPaPEaJ0BQpF8FQOm3C6U7vbbVBf6l3M2MbyEnOxikMPL1dXYKfefIFcB7Q
         NDEggS0PaVnv+7mUAzLQBIW9SgIF2fBI7ZuxfzOOKngGjXrCabf714t5TK6zi46fwp+G
         FNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794486922; x=1795091722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gmfeXtI+tey0F/T6j/hOfxDyERZ2N7Ic5Vbc9BTsdyQ=;
        b=XrHEJHcQeGIc3S6go1oEMRjJd2h3ym1rr0oJ7JpztZQqRvdyk9upO+zLteH2V+2fW3
         YWLpCvyfO6SsCOK41hBEVAsqIHRu+/deSsQM6NzwgGV2XKtDlF5CTDHPYDVUl+5p/hta
         PgrariNXwWagHWVKubAaoRxl5+uYTZZ/5fEZBrjreNkAbx17iFbeFwyf6kOItygW9ZrE
         /toDLwkrJKDRzD3MhA8/JaCPB2+tu2/t9tEdng+LDQZPYVb+4SZtThpYC2AeiEr1pnK1
         f77/+9IecVqIWRLctHddyu3MV49Xzp4EVoooTtbURu2igDU3gRlUqKDPmTnvOcSRUZAa
         20rw==
X-Forwarded-Encrypted: i=1; AL+hErGof46vvXzI+KzKe0T5JJQs2RPTad+CtEz/jLKfYL/mVKrr8XNAENet0ykqUc9quzxSOVhAUUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TL8/mwPJOJ/7UaLtRwqwoNC7S82J75JBq4DMDzgUg9dGzdSKR
	kQCMoEZHdy560FCfkkG4ScWiTKxjC55dAwXSuxoCpRK1Axcuc1kybHpPiW0Jcnxz93X+yYw0olw
	V/1CiLm0Y5sRN8D67eOmZe1T3GALW84g=
X-Gm-Gg: AYBFou3zWTwZv8WCzGyaEvaDzTvCbQIOcJGGjQHv39wjUkQh5ZAVLdgT0kHhVmHmEiR
	wzOacA2HZj3cSZ6ZKwoPwsIlPp7/FzFlc9ftvhGt69k6qnsMhWyH9/a+pOySf08jnq8ueVSG1k4
	ACr/iBMxe+c08r/9GXdxYCALmlzozblHluSOkd5hePQ5vyJgwmWG7tHoHe6ZtTdEzTbB+98IBMM
	EX6XhAEN+0DOZGEIop5kTU0jsZTWerb0njQGfcvz866trZttbkyItEOrwpjWChu6olqz6PHneOp
	ECYanJwdpTsobx85qWXlMVWhihcXOzY1u0hiX1MEwaxCysz6wRivlAwkWw7MfKIEzgM1vwkEZgP
	kElcMwIPZgBMIRf0LZMidFPWCZ0VE0KExhdUlK6Nr/ndyJMfXmcbpESW9bmiXvpVUOvoFAo5tjc
	q2DMQY9SQkFEV4WTf1TqdJq6oV/vWnMiiJWOR8cLZaCjzHKpNjy6Cl6KNFd3tD91oRdJ1N6MkuE
	aZ0kCB/uJQqWoo4cz1p
X-Received: by 2002:a05:600d:84ca:20b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4ba493b3412mr59282305e9.9.1794486922109; Thu, 12 Nov 2026
 04:35:22 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261104182105.1102555-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <20261106154454.GA3654918-robh@kernel.org>
In-Reply-To: <20261106154454.GA3654918-robh@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 12 Nov 2026 12:34:56 +0000
X-Gm-Features: AclHuK9CRcx1aTAbEKf-B1mAZlFhg1ndxA-uzYSl8n-I7fAtC3zV5PucT1NF8gU
Message-ID: <CA+V-a8uN1D7CQmKtAizY40NUOXHDLO2VG8JiAiLTyNb6uG=9jA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 05/14] dt-bindings: net: dsa:
 renesas,rzn1-a5psw: Disallow ports beyond port@4
To: Rob Herring <robh@kernel.org>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@linux.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Thank you for the review.

On Fri, Nov 6, 2026 at 3:44=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 04, 2026 at 06:20:53PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Restrict the A5PSW ethernet-ports node to ports 0 through 4, matching t=
he
> > hardware configuration of four external ports and one CPU/management po=
rt.
> >
> > Although the schema pattern limits port nodes to port@0 through port@4,
> > additionalProperties: true allows other port nodes to pass validation.
> > Set additionalProperties to false and explicitly allow #address-cells
> > and #size-cells so that ports beyond port@4 are rejected.
> >
> > Existing in-tree device trees describe only port@0 through port@4 and
> > are unaffected by this change.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v3->v4:
> > - Added reg items validation for ethernet ports
> >
> > v2->v3:
> > - New patch
> > ---
> >  .../bindings/net/dsa/renesas,rzn1-a5psw.yaml         | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5p=
sw.yaml b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> > index 9c477ceb170b..250c59e58439 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> > @@ -63,12 +63,22 @@ properties:
> >
> >    ethernet-ports:
> >      type: object
> > -    additionalProperties: true
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      '#address-cells':
> > +        const: 1
> > +      '#size-cells':
> > +        const: 0
> > +
>
> Drop all this.
>
> >      patternProperties:
> >        "^(ethernet-)?port@[0-4]$":
>
> And make this "^(ethernet-)?port@". Then any node will get the 'reg'
> schema applied. That doesn't check the unit-address, but the way to
> check that is comparing it to the reg value (not yet implemented except
> for specific buses in dtc).
>
Good point.

>
> >          type: object
> >          additionalProperties: true
> >          properties:
> > +          reg:
> > +            items:
> > +              - maximum: 4
Here I can drop items and just have something like below:

         properties:
+          reg:
+            maximum: 4

Cheers,
Prabhakar

> >            pcs-handle:
> >              maxItems: 1
> >              description:
> > --
> > 2.56.0
> >
