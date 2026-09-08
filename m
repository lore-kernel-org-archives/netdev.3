Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723134D398;
	Tue,  8 Sep 2026 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839387; cv=none; b=Wi/5qgwV/Ys8jLoqNIK+GvgIppCfr6EM3xn+rWdtfveGDCjwth2pMg5k1bpHsXpzL5Qco6KLQTteoQtWIbwoCA5C4FF+Q7WSXi/rVSvKgxMZ90IDI/Jj8vAzJqrR+CQ1+YABTB0hc716oUdlRxUSxxnOD1SZUz201AYbOwYlOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839387; c=relaxed/simple;
	bh=aqABLQVcml+k4ScuvnSqlRQXZYZICv/JKahUkmL11Xc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nNFIQ5Hb+hO4vowkrpTprMP4MrrzWLBB/2Wj+E0LMsI6Tc0q4j3wN0RhBgf/DG0cZNX4rNY/uMnWywd2jn64jIKk0v/8IVfl+gh9E/OvH3pNa6QRPVvF17Hh860NQj1oDw4XPVkWx5SwS51kLhksmUpK/D0+MozNUW+RoL3P3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORIbuRBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORIbuRBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A8C1F00A3A;
	Tue,  8 Sep 2026 03:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788839383;
	bh=OZUZ6EGQg9Z3jxk91Xs6CzHbDEbXdioMLzt3VtnITbc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ORIbuRBhW6OiTW+MrFk4uuGjMiUedBXb09pR0NwDRAfH4CoQaSg+BZEp2n6tRR24T
	 +a9Faf7OHxxt9h4uMLtinqkToWt7K3n3gwWWcfjvKWoVlmS8soxhU89NzxaKsLxqpS
	 JfYnUeApS0InRdqwVwJjPv+vshGXPJXIndJ2BjZUgJTW3JD1ytgEFt8Ze3legzNxIv
	 1EdM9JmFGn5WH/jmoFTs1Q25ejF77KVdNMcv9yZKrWIu6KhqKcvItvGCzSYKKYrrS0
	 +81id1yW+Qrz+ehPTTjxtBQdIVMwiuiAt7f8Z+FEjKYXnB3rPjflXpQWerDdlmRD5r
	 p4wJ9/FqR9BaA==
Subject:
 Re: [PATCH net-next v9 1/4] dt-bindings: net: dsa: microchip: Add KSZ8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 08 Sep 2026 03:49:42 +0000
Message-ID: <178883938242.219967.204339124922803087@kernel.org>
In-Reply-To: <20260906-ks8995-to-ksz8-v9-1-8d8815a91bd8@kernel.org>
References: <20260906-ks8995-to-ksz8-v9-1-8d8815a91bd8@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Concern (verified as a FALSE POSITIVE by series validation): the
  new compatible `microchip,ksz8995xa` added to…

--

dt-bindings: net: dsa: microchip: Add KSZ8995XA

This adds a new compatible string microchip,ksz8995xa to the Microchip
KSZ switch family binding, described as having the same properties as
the older KS8995XA part. No other schema constraints are changed.

> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 8d4a3a9a33fcc..4ed13870ed3ac 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -23,6 +23,7 @@ properties:
>        - microchip,ksz8864  # 4-port version of KSZ8895 family switch
>        - microchip,ksz8873
>        - microchip,ksz8895  # 5-port version of KSZ8895 family switch
> +      - microchip,ksz8995xa

[Severity: Low]
At this commit alone, is there any driver in tree that matches
microchip,ksz8995xa?  The existing part appears to be handled by the older
micrel,ks8995 binding and drivers/net/dsa/ks8995.c, so a device tree using
the new string would document a compatible that nothing binds to yet.

Checking the rest of the series, this looks already answered: the later
commit "net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA" adds

  drivers/net/dsa/microchip/ksz_spi.c:ksz_dt_ids
    { .compatible = "microchip,ksz8995xa",
      .data = &ksz_switch_chips[KSZ8995XA] },

along with ksz8995xa_regs[], ksz8995xa_dev_ops and ksz8995xa_switch_ops in
ksz_common.c, and "net: dsa: ks8995: Delete surplus driver" removes the
legacy driver and its micrel,* match table.  Documenting the binding one
patch ahead of the driver match entry is normal series ordering, so no
functional change results.

For completeness, the two if-then blocks in microchip,ksz.yaml (the
ksz8863/ksz8873 three-port block and the ksz8463 pinctrl/straps block) do
not appear to apply to this five-port part, so is it correct that neither
needs the new string added?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906-ks8995-to-ksz8-v9-0-8d8815a91bd8%40kernel.org
