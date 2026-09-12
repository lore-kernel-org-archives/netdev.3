Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73468274B39;
	Sat, 12 Sep 2026 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244391; cv=none; b=U83qKlbMw9I3xSkaNQe7jlXtFU/61m2YxLyvKWE7NhUbqcppOHYtYZ18RYtUpL7utHpDqYAdesc4WjeOCdR4YTi9KZqdOIM59l2vjIG2j3AHk93CMpENy7ve1kmJjt3LUo/9t9nx5VJEpGWSNwTQtkhlXRcFXPsDSF4h5+58EQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244391; c=relaxed/simple;
	bh=0LLFKb6cgE70JSjCfk8jAZVvPw0IK2Ow+KjUizLkeDc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBLrENNTi/ps5l+gDl6+Se+wWg3/RVWcxaxNKhLMGg6XjkcERPF0ARPvqP27Q2PgWk/uHqQBoRxVMGgRGV4sZNiAAEyHQ3in4ayJ9ro52Vj0sx3EDk1LPol2fx6zW4ZIJceDqevayNj/nyGmPRrHgMCobnuYHpMauNjoon2/W7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzx7cNRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzx7cNRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857E11F00893;
	Sat, 12 Sep 2026 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244390;
	bh=1SYxb1IIsyXB3c0sbt7JafYqPhZQPdxm+G2JSeV1qvY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rzx7cNRiDI58fYxXaCAkvtPZzSpomyIqOyhz8TouP5bYgXxj6jOA8srnHD1dUVJp5
	 /dAv+q1XDhwQYj7Ct1GWgt7FSu4AdFmlsQ4HfxFNou+U1TvEEtylwfC7MxAMW3szJm
	 +8VOsQ8PjsoHuLkvNEIaLIfmOc4FI6xbhJmrP4tVCTp9GBWUhHalgq2jty7xOlevZq
	 yYPrJL3IxYr0szsGf/RaMbZsY6G7p9E1suicGVGYb1WEeVJr1Afg7axLfXw+HvcZ3K
	 wpKO8UP3eYTeqe71GN5NM87j5C8qXKZYYfof3RGZoVjoKwCGyrMCGYgT1rjJ7blaYZ
	 RmtjXh7DH0qOA==
Subject:
 Re: [PATCH net-next v3 2/8] r8152: support RTL8159 for different packages
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Sat, 12 Sep 2026 20:19:49 +0000
Message-ID: <178924438904.3125.17659166669293112223@kernel.org>
In-Reply-To: <20260908075634.23740-3-nic_swsd@realtek.com>
References: <20260908075634.23740-3-nic_swsd@realtek.com>
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

- [Low] The changelog describes the patch as a pure enum split ("RTL8159
  comes in two packages, QFN68 and QFN100, which require different…

--

r8152: support RTL8159 for different packages

This splits RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100 and
updates every version switch accordingly.  Probe now reads PLA_PKG_DET
over a USB control transfer to decide which of the two packages is
present, and r8159_init() gains one package-specific register write.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 013e8d1abfc24..f01f442fa71a0 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -8716,6 +8739,10 @@ static void r8159_init(struct r8152 *tp)
>  	/* TX descriptor Signature */
>  	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
>  
> +	/* Enable u2phy backup restore patch */
> +	if (tp->version == RTL_VER_17_QFN68)
> +		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xb99c, BIT(0));
> +

[Severity: Low]
This isn't a bug, but could the changelog mention this write?  The commit
message describes the change as an enum split:

    RTL8159 comes in two packages, QFN68 and QFN100, which require different
    handling. Split RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100.

Every other hunk in the patch is a mechanical rename, and this
ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xb99c, BIT(0)) in r8159_init() is the
only place where the two packages actually behave differently.

RTL8159 has been driven as RTL_VER_17 since commit ad2a55b63b41af ("r8152:
Add support for the RTL8159 chip"), so QFN68 parts are running today without
this u2phy backup restore bit.

Is this write correcting misbehaviour on QFN68 hardware that is already
supported, or is it enablement for silicon that was not previously in the
field?  If it is the former, would a Fixes: ad2a55b63b41af ("r8152: Add
support for the RTL8159 chip") tag be appropriate so it reaches stable, and
could the changelog describe the symptom it addresses?

>  	/* Enable u3phy patch backup */
>  	ocp_write_word(tp, MCU_TYPE_USB, 0xb9a2, 0x0448);
>  

[ ... ]

> @@ -10287,7 +10340,16 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
>  		version = RTL_VER_16;
>  		break;
>  	case 0x2020:
> -		version = RTL_VER_17;
> +		pkg_det = __rtl_get_pkg_det(udev);
> +		if (pkg_det == 0x1e || pkg_det == 0x1c) {
> +			version = RTL_VER_17_QFN68;
> +		} else if (pkg_det == 0x18 || pkg_det == 0x1a) {
> +			version = RTL_VER_17_QFN100;
> +		} else {
> +			version = RTL_VER_UNKNOWN;
> +			dev_info(&udev->dev, "Unknown package %#02x\n",
> +				 pkg_det);
> +		}
>  		break;

[Severity: Low]
Along the same lines, the changelog does not mention that hw version 0x2020
now requires an extra PLA_PKG_DET control read at probe time to be
classified at all.  Could a sentence be added covering that?

Was this new detection path validated against both packages, and which
PLA_PKG_DET values were observed on each?

>  	default:
>  		version = RTL_VER_UNKNOWN;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908075634.23740-1-nic_swsd%40realtek.com
