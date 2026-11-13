Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579812;
	b=TVJyL5KRVInE4b8eshCxfdQh6SRT1afkvYAXtMxJQekMVyoRXKiTMOrUBLwvnZst8xIp
	 VWWbcxGReYrBfThHBjDF4M6rnsoJ2dQZ2G+As0zp/z73Kg4o11GlVm1hhLw7CW3YSsk78
	 Dyg0CmzVaaqz414KsNx1k6A6yGcuL51k8wtWYvoDMRBcqD/2vfLC6OpuSl9fpokle0SIV
	 byUkewNTJ9tzkgNRSAFaPppcSVjbGckOgPqlcsKAY8NyBoTx7MsLIRpGU10EQ6QQlpvYg
	 k7blv/z7TTojhabJ4VNiV9Mkhld+f0byOKNimwc7Etg0SYzlv/33ZKGRDKw02F7FW9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579812;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=oTXRYCpqjj1rl3vyHjx8W2/mRwY/DkjlcdCqq9U+cmg=;
	b=uE3Sy20qzOOn785zv6RittPABSyzHKgjvdt86aRGQECuK6DrWvIEjstuI1N7fUYgKzJp
	 u0tkvjE9tbPSe8AdjNwwGYUPJxPWEAwd1raxBdRqQPGC77wSMJv5smP58ag8Y5rfRr/K5
	 /wGs2UF8iYaD4ei8gehni5kkT+NV1o5ue3NXoemJcKA+o14lF8Q8VJdkxqVT4IVeL4CJC
	 UGpxg617rb6laccftYnbZkbvAzBbjIZAHpaEYaFB10LQCaG0Q/YC5bgKrm3gH1DyIxV4c
	 kKFI0knGyk8l/1OA3i2VBUUEGTClkdDFMSz1pnb69zk7PoPOuSHrwXDTZQtsl3Ge+gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4LUgG+4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78D606A327;
	Fri, 13 Nov 2026 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4LUgG+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A091F000C4;
	Fri, 13 Nov 2026 14:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579811;
	bh=oTXRYCpqjj1rl3vyHjx8W2/mRwY/DkjlcdCqq9U+cmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m4LUgG+4O9wOw5PECmOhmjElyPGjEyauwluxzttah1Qm4rZn1lH+6EbmtsEpGYM6Z
	 1pOjj1lnIQwn/m/JWEoRkZbJp+d0lVyDYNA3aUerzZYvYb2Hl5QMjLXUDo4h2ejIWl
	 XGyy1GonO7vjji4FZq1Xis8QL0A8zIookpUN2PAtMFxp7XIAj6hLJ20J+rrb1lhd2r
	 DQVzM1pjJojQBDknpYKRMXhcMwpyHhWyI36ByZmJgve+Yz5xs2tpekHiqAfcoLk3dk
	 uywxWeLFQChUcwlrTeFypKz7KeFdE1+upscnEjlIGCQtTFBjgQpacVUcNyOB9JjWVt
	 W08xaPWirg4cw==
Date: Fri, 13 Nov 2026 08:23:29 -0600
From: Rob Herring <robh@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
Message-ID: <20261113142329.GA593855-robh@kernel.org>
References: <20261105100322.37816-1-tanure@linux.com>
 <20261105100322.37816-3-tanure@linux.com>
 <20261110175451.GA833369-robh@kernel.org>
 <CAJX_Q+2WoawiGT9zF2W+LCUhVn2QV3F9rUDBHiGtR6pddKAkNA@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJX_Q+2WoawiGT9zF2W+LCUhVn2QV3F9rUDBHiGtR6pddKAkNA@mail.gmail.com>

On Fri, Nov 13, 2026 at 12:07:55PM +0000, Lucas Tanure wrote:
> On Tue, Nov 10, 2026 at 5:54 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Nov 05, 2026 at 10:03:17AM +0000, Lucas Tanure wrote:
> > > The T7 has the same ethernet glue as the G12A but needs two clocks of
> > > its own. The controller reaches memory through a pipeline stage with
> > > its own gate; nothing else claims it, so it is switched off as unused
> > > and transfers never finish. The glue registers sit in a block clocked
> > > together with the MDIO multiplexer, which probes after the controller
> > > has programmed them: the writes are lost and the port keeps the
> > > bootloader's delays.
> > >
> > > So the T7 gets its own clock list, without the timing adjustment clock
> > > it never uses. Its delays follow ethernet-controller.yaml: the PHY adds
> > > the 2ns, and only the receive delay line offers fine tuning, so only
> > > rx-internal-delay-ps is valid here.
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > ---
> > >  .../bindings/net/amlogic,meson-dwmac.yaml     | 49 +++++++++++++++++++
> > >  1 file changed, 49 insertions(+)
> >
> > I tend to agree with the sashiko comment, but am fine either way. Once
> > the if/then schemas are longer than the main schema, it's a sign to
> > split.
> 
> In V7 I will split as I think it will be easier to review.
> 
> >
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> > > index e769c9bb70d8..ff5e50f65114 100644
> > > --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> > > +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> > > @@ -23,6 +23,7 @@ select:
> > >            - amlogic,meson-gxbb-dwmac
> > >            - amlogic,meson-axg-dwmac
> > >            - amlogic,meson-g12a-dwmac
> > > +          - amlogic,t7-dwmac
> > >    required:
> > >      - compatible
> > >
> > > @@ -84,6 +85,49 @@ allOf:
> > >          rx-internal-delay-ps:
> > >            default: 0
> > >
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: amlogic,t7-dwmac
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          items:
> > > +            - description: GMAC main clock
> > > +            - description: First parent clock of the internal mux
> > > +            - description: Second parent clock of the internal mux
> > > +            - description:
> > > +                clock of the pipeline stage inserted in the bus path between
> > > +                the controller and the DRAM. Without it, the controller cannot
> > > +                complete DMA transfers.
> > > +            - description:
> > > +                clock of the register block holding PRG_ETH0 and PRG_ETH1.
> > > +                Without it, the block reads as zero and ignores writes.
> > > +
> > > +        clock-names:
> > > +          items:
> > > +            - const: stmmaceth
> > > +            - const: clkin0
> > > +            - const: clkin1
> > > +            - const: pipeline
> > > +            - const: pclk
> > > +
> > > +        # The PHY adds the 2ns RGMII delays, see ethernet-controller.yaml.
> > > +        # The RX delay line of this glue is fine tuning in 200ps steps,
> >
> > Sounds like constraints:
> >
> > maximum: 2000
> > multipleOf: 200
> 
> Yes, with maximum: 3000: the field is four bits, 0 to 15 steps of
> 200ps.
> >
> > > +        # added on top of what phy-mode describes. The TX side has no fine
> > > +        # tuning: its only step is a quarter of the clock period, the full
> > > +        # 2ns at 1Gbit/s, so the TX property is not accepted.
> >
> > Move this to tx-internal-delay-ps. You can (kind of ackwardly) do:
> >
> > tx-internal-delay-ps:
> >   description: ...
> >   not: {}
> 
> dt_binding_check does not accept "not" on a property under
> properties: or in an allOf entry: cell.yaml allows only description,
> deprecated, const, enum, minimum, maximum, multipleOf, default, $ref
> and oneOf there. It passes only inside if/then, and the new file has
> no if/then. So the property stays false, with the explanation as a
> comment above it.

Okay, but we should fix that.

Rob
