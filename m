Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95B360EDC;
	Tue, 22 Sep 2026 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052592; cv=none; b=jteH+nM0Oubu7B1GZnSrjeYdzF7+BEZpJ+soPvcVePS15n/o/0iyvwY4V7AO//5OvuxkpUV/CDDNJaer+2doCEjIYHfO8LjS5TGbQahOQG7AYFaVS5JIHw7vaGPMG+1LIYmAvhkwP/eSarWcgxFRKTeqSeqwECQ1c/ovQFKY7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052592; c=relaxed/simple;
	bh=LE3ktMvn8f20wey7b96+iSHLbZJasRdXGgoFtYTRWfs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6asmGmyRMsx1u8OVhTV15DF+2CHVga5cKldEppOgomuHtr0Haa+e0GYmE2nUuILlMwT0JZth84BXiLEE2NjnSmt0blD+eO1OaEEw2OBl3C8USFiiP+/IrNeLdaAODY2FwtDVu/DXb+vpKhglr1emzkkK/lDUARFtKsMTd5sV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfbtMN/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfbtMN/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708931F000FF;
	Tue, 22 Sep 2026 04:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790052591;
	bh=qC/scIJ0wq4RMXDVdwbaYlepxpTiRdoR45/xM5+kulM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AfbtMN/S5YuBrDLCgvQ+s3VacCte4ChmcAdZre0KaXjG3gIl2gmqtOU4oF3jfpD3x
	 XVE+vYYEZzZsuPYnsSu6cF0Hk35/QDYIv7SEnvMJxgXVlKZfxzi152/jaZbLjG+uz4
	 STH03j8TsJ9A10TFWFAzlEIZgcZmDDPSA5kO7VQbU1rk58ZViSB+on/nH2Buw3I8Id
	 VP+CNRLFNIn+4E7vuWXSuCyCLEuLpLhbXQYR31fkKhY66g8+nlFOw6liQTR1DvB3uP
	 KxfOY8hBbmVuwd0AqR9I/Hyw7Uv16Tio3gm9euqFOaiwhdr/WC9x+rcMGkV6jNDLQz
	 Ah1VvTespjzRg==
Subject: Re: [PATCH net v3] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
From: netdev-bot+sashiko@kernel.org
To: yoshihisa.yamamoto.xn@renesas.com
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 04:49:49 +0000
Message-ID: <179005258996.2160803.11359360903588205993@kernel.org>
In-Reply-To: =?utf-8?q?=3CTYCPR01MB7481CE8351FDB2CDCA229955A4872=40TYCPR01MB?=
 =?utf-8?q?7481=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CTYCPR01MB7481CE8351FDB2CDCA229955A4872=40TYCPR01MB7?=
 =?utf-8?q?481=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] SoC-specific PRCMD semantics are applied unconditionally in a
  shared helper: the new `writel(0x0000, miic->base + MIIC_PRCMD)` is…
- [Medium] Fixes-tag mis-attribution and a changelog that names no
  failure mode.

--

net: pcs: rzn1-miic: Reset PRCMD state before unprotect sequence

This adds a writel(0x0000, MIIC_PRCMD) ahead of the existing
0x00A5/0x0001/0xFFFE/0x0001 unprotect key sequence in miic_unlock_regs(),
so that the sequence starts from the IDLE state of the PRCMD command state
machine as documented for RZ/T2H.

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index cb74861e823c..4a2a50827338 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -270,6 +270,9 @@ static struct miic_port *phylink_pcs_to_miic_port(struct phylink_pcs *pcs)
>  
>  static void miic_unlock_regs(struct miic *miic)
>  {
> +	/* Reset PRCMD state before unprotect sequence */
> +	writel(0x0000, miic->base + MIIC_PRCMD);
> +

[Severity: Medium]
Should this write be gated on the SoC it is documented for?

miic_unlock_regs() has two consumers, and they belong to different SoCs:

  miic_reg_writel_locked()   /* only rzt2h_miic_of_data.miic_write */
      miic_unlock_regs()
      writel(value, ...)
      miic_lock_regs()

  miic_init_hw()             /* only rzn1_miic_of_data sets the flag */
      if (miic->of_data->init_unlock_lock_regs)
              miic_unlock_regs();

rzn1_miic_of_data carries .init_unlock_lock_regs = true and
.miic_write = miic_reg_writel_unlocked, while rzt2h_miic_of_data carries
.miic_write = miic_reg_writel_locked and does not set the flag. So the new
un-keyed PRCMD write is now also emitted on RZ/N1 (r9a06g032), where the
driver has so far only ever written the documented key sequence to this
write-protected register.

The changelog justifies the write with RZ/T2H documentation only:

  "On RZ/T2H MIIC, writing 0x0000 to PRCMD resets the command state
  machine to the IDLE state."

If the RZ/N1 protect block instead treats a bare 0x0000 as an
out-of-sequence command of the A5/data/~data/data protocol, does the
following unprotect sequence still release protection?

In that case every write that miic_init_hw() issues afterwards, MODCTRL,
CONVRST via miic_converter_enable(), SWCTRL and SWDUPC, would be dropped by
the hardware. There is no read-back of a protected register and
miic_init_hw() ends with:

	return 0;

so probe would still succeed and the only visible symptom would be a
mis-muxed or dead Ethernet path on RZ/N1.

Would it make sense to scope the reset write to RZ/T2H, either via
of_data->type == MIIC_TYPE_RZT2H, a new of_data flag, or by doing it inside
miic_reg_writel_locked(), or alternatively to state in the changelog that
the extra PRCMD write was verified harmless on RZ/N1?

[Severity: Medium]
Does the Fixes tag point at the right commit?

  Fixes: 419747319e3a ("net: pcs: rzn1-miic: Add per-SoC control for MIIC
  register unlock/lock")

git blame shows 419747319e3a only moved the pre-existing RZ/N1 four-write
sequence into miic_unlock_regs(); at that point the helper was reachable
only from the RZ/N1 miic_init_hw() path. The RZ/T2H side the changelog
relies on came from the later commit 08f89e42121d4, which added
miic_lock_regs(), miic_reg_writel_locked() and rzt2h_miic_of_data.

A backport driven by this tag would therefore land the write on kernels
that have no RZ/T2H support at all, where its only effect is an extra
PRCMD write on RZ/N1. Should the tag reference 08f89e42121d4 instead?

Also, which condition actually leaves PRCMD in a non-IDLE state?

On RZ/T2H every register write goes through
unlock, write, miic_lock_regs(), and miic_lock_regs() already does:

	writel(0x0000, miic->base + MIIC_PRCMD);

so PRCMD is 0x0000 after any driver-initiated access. On RZ/N1
miic_unlock_regs() runs once during probe on a freshly reset block. The
remaining source of unknown state would be pre-kernel firmware or the other
master mentioned in miic_init_hw():

	/* Unlock write access to accessory registers (cf datasheet). If this
	 * is going to be used in conjunction with the Cortex-M3, this sequence
	 * will have to be moved in register write
	 */

but the changelog does not mention it. And against a concurrent external
agent, does one extra leading write really give the stated property,
"always starts from a known state, regardless of any previous PRCMD
activity", given the five writes are not atomic as a group?

Could the changelog name the observed symptom or the condition that
produces the stale PRCMD state?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/TYCPR01MB7481CE8351FDB2CDCA229955A4872%40TYCPR01MB7481.jpnprd01.prod.outlook.com
