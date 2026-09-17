Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E95221C1;
	Thu, 17 Sep 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651348; cv=none; b=p5SdsP7Epm88WudXkE+1Gn1cLJ8SaeMRzBE+i5Y/ucZ/zmbkeJWmo8Wtd4g7W85yYK1FNbbDPWlRza1veZ5ELlMEBPhQVdea11v0L1aQh3rIcp8XyCpSW5zlrwszKAxL6HT4K7fgQArK/tD0xBui3caKdpwDXna/77rtaglv1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651348; c=relaxed/simple;
	bh=Ry8kUYs6eJIrSmtXmJuvxfgvu5OGID0TzLqUwpULQUI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tg5hv4+HvzV6g/4xd0Ej1OXgBJMZrVvJ6dOPHSMhIDYKgB2h+s4LDOLriB6N5Q0da7hfkIi+20N8WNj+ev6QGKA1bcrNvxea5bqe0t3CokSrFzUjjbJA6PEW5DBJiaGHK30630zR+O3B3RpFhRcyizsbUdsd9B/cRoqQ8vUPkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9iIYNqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9iIYNqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4521F000FF;
	Thu, 17 Sep 2026 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651347;
	bh=7Tc9jkaiXTJByBcYiQEgKnvkvRPSFfcjQQIu1FBzBnE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z9iIYNqHeMrAlwmlVqx7FFHKbGQPQHpM3Ec4Rcf84XyJ1wBtgrcsVydzASSXCpeYZ
	 GRAHeP7KaGPnt7r/kR1+6Tt2zE8uWs2FMhfiyOPJHHRHRcCs7Umg5tLhy1nnRKAk5T
	 d6cli+qGeCRfcPI+uULOe5A/6tgP8U2q4Ew1+xq/kYSQ0oUQQQ4nU9L2ICsSMl8Pee
	 sqJ8f9IDSsAd6mynsJEJ9s7VUBjGOq0pupK98Ip933mzLTFRwCWEosO67JkTsH+Zbp
	 ZVKyMrbDfux2RdyM2V4a5RiOZrZhh4Fd/M0NhX7LV/LjB5FfJmTftrVeO0fVObrlCW
	 sXLd5XswEI70A==
Subject:
 Re: [PATCH net-next v15 1/4] dt-bindings: net: dsa: microchip: Add KSZ8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 17 Sep 2026 13:22:25 +0000
Message-ID: <178965134577.22033.16045801715665480170@kernel.org>
In-Reply-To: <20260916-ks8995-to-ksz8-v15-1-8825ff5fd4be@kernel.org>
References: <20260916-ks8995-to-ksz8-v15-1-8825ff5fd4be@kernel.org>
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

- [Low] Concern (validated as a FALSE POSITIVE, retained only because
  requires_validation=true): the new compatible `microchip,ksz8995xa`…

--

dt-bindings: net: dsa: microchip: Add KSZ8995XA

This adds the microchip,ksz8995xa compatible string to the enum in the
Microchip KSZ series DSA switch binding.  The commit notes the part was
renamed from KS8995XA and shares the same properties.

No Link: tags are present in the commit header.

> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 8d4a3a9a33fcc..4ed13870ed3ac 100644
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

No regressions to report for this patch.  The conditional blocks in
microchip,ksz.yaml only gate on microchip,ksz8863 / microchip,ksz8873 and
microchip,ksz8463, and the 5-port KSZ8995XA falls into the default
dsa.yaml#/$defs/ethernet-ports branch, so no existing if: block needed the
new string.  The driver match entry for microchip,ksz8995xa is added later
in the series in ksz_dt_ids[] in drivers/net/dsa/microchip/ksz_spi.c, so
the compatible does not end up unmatched.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ks8995-to-ksz8-v15-0-8825ff5fd4be%40kernel.org
