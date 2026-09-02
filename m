Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661D3A2E3F;
	Wed,  2 Sep 2026 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342641; cv=none; b=uaGwJowgbDkckfuIdTId/0akWLmjFh/Bjpq9TzNufxIPvKhcsDaVKVCkJRG6ImLyUawrj3XkepxriUjd+I55r2FmqzksS77EsOSPyQL5Z/GrKkyl9CYQskDDG0J+J4FWbXGWpN8vRbmggPlBbnP8dwoMJfj3UD4NNVV9f3F0Pkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342641; c=relaxed/simple;
	bh=+xygiKuxHXffIANJqZVU65CcB9G21kYFz9xbiIbTzc0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kVH6wRJvrARKE47LCq1YYP6OjccFI1xwZMtJYj2gCbUnBhPChv/J/wBpF/EBgJprbq2+xH8M351DoZ6tdAIGQ4+JVHvaX3Cbb9CFfB10rxoNOrFh//VhlX+CTRaqFf5j+CWgB9Xw+tX/tilYF1vo8baZuO4AMw7aEzPXUIjAVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR79NdVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR79NdVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2601F00A3D;
	Wed,  2 Sep 2026 09:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788342638;
	bh=RjLhBYCL0IaM7G+bymZddXDAwW9Su9kpsBAPzpvy758=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MR79NdVkeH2WXYkRnwP2oGPpuEPUyzDdOZjnj0/GnewLA+lmUqdhmlbOwpfOD22Fr
	 WUiepk/h+wgyBllo8bBknG2f8aPqj/Enr7FqxsAFYA7TDbPBieyuWvYgOZss4Vi8QA
	 qBIzdVAEL/fRARqleJAq7UtHguCWDrZwbXdq5/C3kuO7zWAWIq168a+a4ABWuj55PD
	 agprhHvrgaDPeh/3t+Kc0WDED8d3OoyhWty6kvqM58ShwcG0jcJBdKLWqHXqH5cyIF
	 XZiQiRWHRJVMU80uX1Jzohtz7PERkz7krKeXXZXjusTrghopMvgoRd0JuC8IrTAs4z
	 GDl9bYg2L8MwA==
Subject: Re: [net-next,v8,2/5] dt-bindings: net: dsa: microchip: Add KSZ8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 09:50:37 +0000
Message-ID: <178834263728.3394541.8763382902139129360@kernel.org>
In-Reply-To: <20260831-ks8995-to-ksz8-v8-2-fd1dbb2b76e8@kernel.org>
References: <20260831-ks8995-to-ksz8-v8-2-fd1dbb2b76e8@kernel.org>
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

- [Low] Concern (validated as FALSE POSITIVE by series-end verification):
  the newly documented `microchip,ksz8995xa` compatible was reported to…

--

dt-bindings: net: dsa: microchip: Add KSZ8995XA

This adds a new compatible string microchip,ksz8995xa to the Microchip KSZ
switch binding, noting the part was renamed from KS8995XA and that
KSZ8995MA and KSZ8995E are different parts.

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
At this commit, is there anything in tree that matches this compatible?

A device tree node using microchip,ksz8995xa passes dt_binding_check here,
but ksz_dt_ids[] in drivers/net/dsa/microchip/ksz_spi.c has no entry for
it yet, so the node would not probe.

That said, the following patch in the same series ("net: dsa: microchip:
Support Microchip KSZ8995XA / KS8995XA") adds the matching entry:

drivers/net/dsa/microchip/ksz_spi.c:ksz_dt_ids[] {
	...
	{
		.compatible = "microchip,ksz8995xa",
		.data = &ksz_switch_chips[KSZ8995XA]
	},
	...
}

along with ksz_switch_chips[KSZ8995XA] and the { "ksz8995" } spi_device_id
entry, so at the tip of the series the string does resolve to a driver.
Documenting the binding ahead of the driver is the usual ordering, so this
is only a note about the intermediate state rather than something that
breaks a previously working configuration.

>        - microchip,ksz9477
>        - microchip,ksz9897
>        - microchip,ksz9896

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8%40kernel.org
