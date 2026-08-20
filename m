Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A687F3DAABA;
	Thu, 20 Aug 2026 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259441; cv=none; b=RSUnOdcPH5eJLzwWOu+VtJqyqDTdRcTUS9uny47aTsvnCUeOvCJ9D67oX8F5o8xAvoMbhpOqZIIr1yX66kwve5DIUFpfrQllPQJRMbbG4SrPMF0yNAf2cI+TiHrP62vfWJG/ZUw6I4xrzotqzGFQULVLnG7uv1DtZieXoh/m/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259441; c=relaxed/simple;
	bh=KuoLb6R3YgIotnT792IF8n63OH38hhTOu4jKAkmwVd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnVVUEK6kWhO+3uTDkjy2PYBEEv29brO9/ifn3T4xm2/cu8M0OVmkgUfTnam0i+wzkz0EUF49fFAiyOmqXxNwVZlIGpFE5WevA8L6nriaF/Ut1SmhNjc7/hAACleHQl/RjuNsx8cjkfLZn9axtxdj6hzxaNQWdEx2SmnPXi6K/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHREILNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHREILNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25A51F000E9;
	Thu, 20 Aug 2026 20:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787259440;
	bh=IbAxxbT8tAzu++l7YEpQ8qx7NuP024/XerKy2rX7QqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EHREILNBpfwT0Euc/maJiAHHHhU4HloAu2+XfUEEhc92ijmK53qv+bxE8ZFyYAkWF
	 rbW3erbcN1PJ7Qz+pZAjoaMeaS+2SBWd3JgF8P59oo5O3DzslfwNixt8X1BnTI0v6Q
	 KN/l+osxGH/TMEBzG4hN84isdZTDf+CJjarHUOvYia6Zf70j5s4O4ZeAt83wXyfzTA
	 NjtZpEKDbcPApCISazwFRY5ivYRwiaHWHy41swP9lX5/JoXufZMiYPm6MF/NU5/FL8
	 O/3YtproF8PiHv3X73/LHHw3v0G4X7rGpmov852oasyrMV17MkLmNQcAY/UnpJEyY2
	 2qIoZBPGYibgw==
Date: Thu, 20 Aug 2026 13:57:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Leto Liu (
 =?UTF-8?B?5YiY5rab?=)" <Leto.Liu@airoha.com>
Subject: Re: [PATCH net v4] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
Message-ID: <20260820135719.0b4e5f35@kernel.org>
In-Reply-To: <20260817075044.17691-1-ansuelsmth@gmail.com>
References: <20260817075044.17691-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Aug 2026 09:50:39 +0200 Christian Marangi wrote:
> CPU accesses QDMA via the bus.=20

Maybe it's just me but I have no idea what "the bus" is here.
I'm guessing that the bug is that the CSR write path to=20
some SRAM may get starved.

> When multiple modules are using the bus
> simultaneously, CPU access to QDMA may encounter bus timeouts and fails,
> resulting in QDMA configuration failures and potentially causing packet
> transmission issues. In order to mitigate the issue, introduce a retry
> mechanism to airoha_qdma_set_trtcm_param routine in order to ensure the
> configuration is correctly applied to the hardware.
>=20
> Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Leto Liu (=E5=88=98=E6=B6=9B) <Leto.Liu@airoha.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v4:
> - Rebase on top of net
> Changes v3:
> - Init data
> - Use continue instead of negative error for poll
> - Add memory block after CFG_PARAM
>=20
>  drivers/net/ethernet/airoha/airoha_eth.c | 29 +++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 79418e682f71..302f8c432055 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2712,14 +2712,31 @@ static int airoha_qdma_set_trtcm_param(struct air=
oha_qdma *qdma, int channel,
>  		     FIELD_PREP(TRTCM_METER_GROUP_MASK, group) |
>  		     FIELD_PREP(TRTCM_PARAM_INDEX_MASK, idx) |
>  		     FIELD_PREP(TRTCM_PARAM_RATE_TYPE_MASK, mode);
> +	int i;
> =20
> -	airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
> -	airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);

a short two-line comment would help remind why we're doing this loop
here, specifically (and not all register accesses)

> +	for (i =3D 0; i < 100; i++) {
> +		u32 data =3D 0;
> =20
> -	return read_poll_timeout(airoha_qdma_rr, val,
> -				 val & TRTCM_PARAM_RW_DONE_MASK,
> -				 USEC_PER_MSEC, 10 * USEC_PER_MSEC, true,
> -				 qdma, REG_TRTCM_CFG_PARAM(addr));
> +		airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
> +		wmb();
> +		airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
> +		wmb();

The wmb()s look like cargo cult, please drop them or explain what they
do.

> +		if (airoha_qdma_get_trtcm_param(qdma, channel, addr, param,
> +						mode, &data, NULL))
> +			continue;

AI also points out that we're worried about this get timing out here
but other spots in the driver read it without a retry. Is this possibly
also an unnecessary check, like the wmb()?
--=20
pw-bot: cr
