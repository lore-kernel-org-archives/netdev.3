Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1356261F;
	Wed,  9 Sep 2026 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957560; cv=none; b=T33Pg5IiQQ0DwpPQCwUpvSpArFDIRe3IEAjK+Lge4GQTX4SGBkT7lAsuNf+CvsTQ46Z7Z4Oybf2fU3srmK0hU21c5CS/aVMCX38xu0DjpvhZblLT+Q/9pOtkmRvfQ8HFThoM07EDvbI4WO4s/uF1685JBFBktx/6573SbbbuJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957560; c=relaxed/simple;
	bh=+05FvJJjwnHRYscYNxnxB2etPGCvnMkm4RfFqheONsM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DOaxkHrvz/Ux+PIm3QV7ycwEPVV8TyJFeafhiNB0YseBYoag5keFj8pCPTUm4fsV/Ug3shWAPUlj1PyirhYtMNuLRQzXfp+1B6x7i+OcaUfLN+cYQ2E93IOHmSHnResY2hDNqinfjfI/qOHaGBg+iG1bM5iIIjO21mVS6auAXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cExm8Kq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cExm8Kq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F8A1F00A3D;
	Wed,  9 Sep 2026 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957558;
	bh=DnqHe56X31XVSlrCwlzo/Ft8NWQ3Cpoin39smqZWZXU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cExm8Kq/8JNGtZJdQ0D/KdJpHaFJ0MrF25BV1Yfu17mOoAj+UdkCb6HpV+76FILwv
	 Kn8u6ue7JIUyyhbiYFG52Eo/r3hWgmoHApotWS4/eLfnXspA5fxAyr6HvJsRu5jWes
	 UOQUsOPQBLlaikBz06sztKmpi1/hjE8uVniW6hGDq29vLugk6PQHCdoB5OjnObbRai
	 5BizdEkFkWeugtnFT1w2whTd8cufeAqgppmCQ8gntmR4Wq4cUymiKlY0q7JS6eYEah
	 EFUSeEi06/NjyWi+juNtlM+MZohzVVUwAmOZ/KYvYMbO9ZIG7gHZdwF4rucA7hlcJo
	 MCItS2VRisdVA==
Subject:
 Re: [PATCH net-next v10 1/4] dt-bindings: net: dsa: microchip: Add KSZ8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 09 Sep 2026 12:39:16 +0000
Message-ID: <178895755698.219967.14487699742720379802@kernel.org>
In-Reply-To: <20260908-ks8995-to-ksz8-v10-1-7379239eb65f@kernel.org>
References: <20260908-ks8995-to-ksz8-v10-1-7379239eb65f@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] In
  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml the new…
- [Low] Reported concern (validated as NOT a defect):
  `microchip,ksz8995xa` is documented in…

--

dt-bindings: net: dsa: microchip: Add KSZ8995XA

This adds the compatible microchip,ksz8995xa to the Microchip KSZ DSA
switch binding, described as having the same properties as the KS8995XA
and being like the KSZ8795 and KSZ8864.

> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 8d4a3a9a33fcc..ed39530b6cbbb 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -23,6 +23,7 @@ properties:
>        - microchip,ksz8864  # 4-port version of KSZ8895 family switch
>        - microchip,ksz8873
>        - microchip,ksz8895  # 5-port version of KSZ8895 family switch
> +      - microchip,ksz8995xa
>        - microchip,ksz9477
>        - microchip,ksz9897
>        - microchip,ksz9896
> @@ -122,6 +123,7 @@ allOf:
>              enum:
>                - microchip,ksz8863
>                - microchip,ksz8873
> +              - microchip,ksz8995xa
>      then:
>        $ref: dsa.yaml#/$defs/ethernet-ports
>      else:

[Severity: Medium]
Is this second hunk intentional?  The enum being extended here sits under
a "not:", so adding a compatible to it selects the "else" branch rather
than the "then" branch:

  - if:
      not:
        properties:
          compatible:
            enum:
              - microchip,ksz8863
              - microchip,ksz8873
              - microchip,ksz8995xa
    then:
      $ref: dsa.yaml#/$defs/ethernet-ports
    else:
      patternProperties:
        "^(ethernet-)?ports$":
          patternProperties:
            "^(ethernet-)?port@[0-2]$":

The "else" branch is the hand-rolled KSZ88x3 schema.  It only matches
port@0 through port@2, does not reference dsa.yaml#, and additionally
allows the KSZ88x3/REFCLKO-only flag microchip,rmii-clk-internal.

The KSZ8995XA is a 5-port part with the CPU port at index 4.  The chip
data added later in this series, ksz_switch_chips[KSZ8995XA] in
drivers/net/dsa/microchip/ksz_common.c, has:

	.cpu_ports = 0x10,	/* can be configured as cpu port */
	.port_cnt = 5,		/* total cpu and user ports */

So for microchip,ksz8995xa, would port@3 and port@4 (including the MII
CPU port with ethernet/phy-mode/fixed-link) match no subschema and go
unvalidated, and would a node with no ports/ethernet-ports at all also
pass since the dsa.yaml base requirements are no longer applied?

The same silicon is also described by
Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml, which
drivers/net/dsa/microchip/ksz_spi.c maps to the same
ksz_switch_chips[KSZ8995XA] entry.  That file uses:

  allOf:
    - $ref: dsa.yaml#/$defs/ethernet-ports

and its example documents ethernet-port@0 through ethernet-port@4, which
is the opposite of the 3-port constraint now applied to
microchip,ksz8995xa.

This also seems to disagree with the commit message, which says the part
is "just like the KSZ8795 and KSZ8864" and "has the same properties as
the KS8995XA" - both microchip,ksz8795 and microchip,ksz8864 take the
"then" branch and use the generic dsa.yaml ethernet-ports schema.

Would dropping the second hunk and keeping only the top-level compatible
enum addition give the described behaviour?

The same negated enum entry is still present at the end of the series
(c34290e766e1566f450a527435a9398d135e21d4), so no later patch appears to
change it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-ks8995-to-ksz8-v10-0-7379239eb65f%40kernel.org
