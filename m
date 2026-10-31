Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483771;
	b=sq99vykAgJDmOpfc0VqvFuguG39NUmtbB4u8svX6EYZPhJxAJ28QNk1avIWFjtrpGlRo
	 zovbepluYbLymCbuBmEdThW4Fef1iPOnGFAv7mnlT4/1uuSlETUnVhBD7iBwkrcxxAzYw
	 N6Hm/EQYzrD7z5YFVfsQ3YU/Gi8T9klk+uZw1iSOdmr1y3aSG3B1USam8ecO4ff5sepMy
	 iX/uLRzx3HZvZVdmVGmJ1a4d8GrvQvWv9/JJI3rqjNtIo6dmHh0L7lDNRplVb2S5WcF2d
	 sFjYijNimD6PbZTDGJ1ePgst51Hvo42r7XzlDkvpg7sDADAs5rF67jLXBezsvPJrXRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483771;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=w4CIcxiTCNFLsGNTBS4u6EFdTdib0ADNzyxSejSonw0=;
	b=mANJdPzfxUyJaCPOHF5gz7uV8kYy35fyvqvEsMNw93EnOBSwC9CPBEUXOQyK1TrL/Y+P
	 51wGgxk4gQR/54wvLN0JaP/gRRJiCOtmLRAN4lJoIlB4Du87CyDWN4C0rBU6I6OAes0XE
	 EzZuuihLC3gQrlOcWSv/emALjs1dpUKFI8r6C+/hRWiqErNO00y0dO2lKYuxpP9JvbcR/
	 OkoVJ980afF6+ifs1zigq4GeSJmxTkooAtorEahgiTwPL+jYn1W4nQRLy73JY30j3l0nN
	 AlF7YOoUAb8dr6eyf5U+sI9mySLQ5Hg4ryMiqWhMmqHmp0x4YVlyTG/ycLo3eTqTD1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wee9UDSg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA6606A327;
	Sat, 31 Oct 2026 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wee9UDSg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFDD1F00A1F;
	Sat, 31 Oct 2026 21:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793483766;
	bh=w4CIcxiTCNFLsGNTBS4u6EFdTdib0ADNzyxSejSonw0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wee9UDSgn2UQPX64XuXtcBr/9ePGxenkBHCV/9WBCugmaq0IRCbB+ezb76t9wA6Mr
	 8rQYitQZUNy3o+o6mqPgfqA1mayWuGXWekZZMabstzK8aFSFVKVzXiEm8ISDqQiYHb
	 NlCjtX//h1EaZdKo5oARCD134P+Oej0ujNt+ktUhhptMg07WuNSyj5ysBMk7BU4Qmt
	 Q1rrmv6XKML6lZP+DegxfbdhXQuEImuFO7SLKLecR2o5iPntU8m6I0qO0PQfrbu/U2
	 echbfAVREWJmPg1aeSXffiwZNVSzt+JflWmcbmI32iSo6fvuD3KqgtcYkk+UFHCv6l
	 Ha9/sBbKjYdgQ==
Subject:
 Re: [PATCH net v3 7/8] net: dsa: b53: harden mirror register programming
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, linux-kernel@vger.kernel.org
Date: Sat, 31 Oct 2026 21:56:05 +0000
Message-ID: <179348376557.3131.9793537339199409475@kernel.org>
In-Reply-To: <20261030211617.288562-8-florian.fainelli@broadcom.com>
References: <20261030211617.288562-8-florian.fainelli@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds an unconditional b53_mirror_init() call to
  bcm_sf2_sw_setup() (drivers/net/dsa/bcm_sf2.c).

--

net: dsa: b53: harden mirror register programming

This commit clears the mirror capture control register and both
source-control registers during b53 and bcm_sf2 setup. It checks every
mirror register access and only increments the source reference count
once hardware programming has succeeded. It also decides whether the
destination is occupied from the source masks instead of MIRROR_EN.

> diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
> index 9e5713015187b..9f54cd414c18f 100644
> --- a/drivers/net/dsa/bcm_sf2.c
> +++ b/drivers/net/dsa/bcm_sf2.c
> @@ -1059,6 +1059,11 @@ static int bcm_sf2_sw_setup(struct dsa_switch *ds)
>  {
>  	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
>  	unsigned int port;
> +	int ret;
> +
> +	ret = b53_mirror_init(ds);
> +	if (ret)
> +		return ret;
>  
>  	/* Enable all valid ports and disable those unused */
>  	for (port = 0; port < priv->hw_params.num_ports; port++) {

[Severity: Medium]
Can this lose the installed mirror rules across suspend/resume?

The resume path also calls bcm_sf2_sw_setup():

drivers/net/dsa/bcm_sf2.c:bcm_sf2_sw_resume() {
    ...
	ret = bcm_sf2_cfp_resume(ds);
    ...
	ds->ops->setup(ds);

	return 0;
}

So every resume now writes 0 to B53_MIR_CAP_CTL, B53_IG_MIR_CTL and
B53_EG_MIR_CTL. The tc matchall mirror rules stay installed.

dev->ports[].mirror_count[] also keeps its value. The only thing that
clears it is the memset in b53_reset_switch(), and the bcm_sf2 path never
calls that.

CFP gets restored by bcm_sf2_cfp_resume(), but nothing reprograms the
mirror registers after resume.

After resume, b53_mirror_add() would hit this:

	if (*mirror_count) {
		(*mirror_count)++;
		return 0;
	}

A new rule for a port and direction that already has a reference would
then return success without programming the hardware.

The new occupancy check would also read all-zero source masks:

	if (((reg | other_reg) & MIRROR_MASK) &&
	    (cap_ctl & CAP_PORT_MASK) != mirror->to_local_port) {

That would accept a rule with a different destination while software
still tracks rules for the old one.

Doesn't this break the rule that mirror_count[] follows the hardware
source mask bits? The commit message relies on that when it says
"Reference counting must not record a first source reference until
hardware programming has succeeded".

bcm_sf2_sw_rst() may already clear these registers through EN_CHIP_RST.
If so, the stale count came from the earlier patch in this series, "net:
dsa: b53: reference count shared mirror source bits", and this patch makes
the wipe unconditional.

If the reset does not clear them, which is the case the commit message
describes, this patch causes the loss on resume.

The problem is still there at the end of the series. "net: dsa: b53: fix
mirror port encoding on BCM5325 and BCM5365" only changes the port and
capture encoding.

A related question: bcm_sf2_sw_resume() ignores the return value of
ds->ops->setup(). If b53_mirror_init() fails during resume, the new early
return skips the port, VLAN and ACB setup below and no error is reported.
Is that intended?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030211617.288562-1-florian.fainelli%40broadcom.com
